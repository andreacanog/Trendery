import React, { useState, FormEvent } from "react";
import { useAppDispatch, useAppSelector } from "../../hooks";
import { signupUser } from "../../actions/sessionActions";

const Signup: React.FC = () => {
  const dispatch = useAppDispatch();
  const session = useAppSelector((state) => state.session);
  const [username, setUsername] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [name, setName] = useState("");

  const handleSubmit = (e: FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    dispatch(signupUser({ username, email, password, name }));
  };

  return (
    <div>
      <h2>Signup</h2>
      <form onSubmit={handleSubmit}>
        <div>
          <label>Username:</label>
          <input
            type="text"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            required
          />
        </div>
        <div>
          <label>Name:</label>
          <input
            type="text"
            value={name}
            onChange={(e) => setName(e.target.value)}
            required
          />
        </div>
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
        <button type="submit">Sign Up</button>
      </form>
      {session.loading && <p>Loading...</p>}
      {session.error && <p style={{ color: "red" }}>{session.error}</p>}
    </div>
  );
};

export default Signup;
