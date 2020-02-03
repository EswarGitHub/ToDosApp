import axios from 'axios';
import uuid from 'uuid/v4';
import React, {useEffect, useState} from 'react';

import Input, {Todo} from "../../components/Input";
import TodosList from "../../components/TodosList";

const App: React.FC = () => {
    const [todos, setTodos] = useState<Todo[]>([]);
    const [error, setError] = useState(null);

    useEffect(() => {
        (async () => {
            try {
                const response = await axios.get(`${process.env.REACT_APP_URL}`);
                if (response.status === 200) {
                    setTodos(response.data);
                }
            } catch (e) {
                console.log(e);
                setError(e.toString());
            }
        })();
    }, []);

    const updateTodos = (t: Todo) => {
        if (t.value.trim() === '') {
            return;
        }
        const newTodo: Todo = { ...t, id: uuid() };
        (async () => {
            try {
                const response = await axios.post(`${process.env.REACT_APP_URL}`, newTodo);
                if (response.status === 200) {
                    setTodos([...todos, newTodo]);
                }
            } catch (e) {
                console.log(e);
                setError(e.toString());
            }
        })();
    };

    const updateCompleted = (t: Todo) => {
        const newTodos = [...todos];
        const index = newTodos.findIndex(({ id }) => id === t.id);
        if (index > -1) {
            newTodos[index] = { ...t, completed: !t.completed };
        }

        (async () => {
            try {
                const response = await axios.put(
                    `${process.env.REACT_APP_URL}/${t.id}`,
                    { ...t, completed: !t.completed }
                    );
                if (response.status === 200) {
                    setTodos(newTodos);
                }
            } catch (e) {
                console.log(e);
                setError(e.toString());
            }
        })();
    };

    const clearTodo = (t: Todo) => {
        const newTodos = todos.filter(({ id }) => id !== t.id);
        setTodos(newTodos);

        (async () => {
            try {
                const response = await axios.delete(`${process.env.REACT_APP_URL}/${t.id}`);
                if (response.status === 200) {
                    setTodos(newTodos);
                }
            } catch (e) {
                console.log(e);
                setError(e.toString());
            }
        })();
    };

    return (
        <div className="container">
            <p className="heading">todos</p>
            <Input onFormSubmit={updateTodos}  />
            <TodosList todos={todos} onComplete={updateCompleted} onClear={clearTodo} />
            <div className="api-error">{error}</div>
        </div>
    );
};

export default App;
