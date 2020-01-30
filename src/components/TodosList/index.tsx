import React from "react";

import {Todo} from "../Input";
import Check from '../../check.svg';
import Close from '../../x.svg';

interface Props {
    todos: Todo[];
    onComplete: (t: Todo) => void;
    onClear: (t: Todo) => void;
}

const TodosList: React.FC<Props> = ({ onClear, onComplete, todos }) => {
    return todos ? (
        <ul className="list-container">
            {
                todos.map(todo => (
                    <li className="list-item" key={todo.id}>
                        <div className="section-left">
                            <div className="check-circle" onClick={() => onComplete(todo)}>
                                {
                                    todo.completed ? <img src={Check} alt="Mark Completed" /> : null
                                }
                            </div>
                            <span>{todo.value}</span>
                        </div>
                        <img src={Close} alt={"Clear todo"} className="clear-todo" onClick={() => onClear(todo)} />
                    </li>
                ))
            }
        </ul>
    ) : null;
};

export default TodosList;
