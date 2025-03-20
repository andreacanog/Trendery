import React, {useState, FormEvent} from "react";
import { useAppDispatch, useAppSelector } from "../../hooks";
import { loginUser } from "../../actions/sessionActions";
// import { RootState } from "../../reducers/rootReducer";
// import type { AppDispatch } from "../../store";
// import { Form } from "react-router-dom";


const Login: React.FC = () => {
    const dispatch = useAppDispatch();
    const session = useAppSelector((state) => state.session);
    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");

    const handleSubmit = (e: FormEvent<HTMLFormElement>) => {
        e.preventDefault();
        dispatch(loginUser('email', 'password'));
    }

    return (
        <div>
            <h2>Login</h2>
            <form onSubmit={handleSubmit}>
                <div>
                    <label>Email:</label>
                    <input
                        type="email"
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                        required
                    />
                </div>
                <div>
                    <label>Password:</label>
                    <input
                        type="password"
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                        required
                    />
                </div>
                <button type="submit">Login</button>
            </form>
            {session.loading && <p>Loading...</p>}
            {session.error && <p style={{ color: "red"}}>{session.error}</p>}
        </div>
    )
}

export default Login;