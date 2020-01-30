import React, {ChangeEventHandler, FormEventHandler, useState} from 'react';

export interface Todo {
    id: string;
    value: string;
    completed: boolean;
}

interface Props {
    onFormSubmit: (t: Todo) => void;
}

const Input: React.FC<Props> = ({ onFormSubmit }) => {
    const [value, setValue] = useState('');

    const handleChange: ChangeEventHandler<HTMLInputElement> = e => {
        setValue(e.target.value);
    };

    const handleFormSubmit: FormEventHandler<HTMLFormElement> = e => {
        e.preventDefault();
        onFormSubmit({ id: '', completed: false, value: value.trim() });
        setValue('');
    };

    return (
        <form onSubmit={handleFormSubmit}>
            <input
                type="text"
                className="input"
                placeholder="What needs to be done?"
                value={value}
                onChange={handleChange}
            />
        </form>
    );
};

export default Input;
