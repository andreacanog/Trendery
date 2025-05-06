import React from "react";
import { useNavigate } from "react-router-dom";
import { useAppSelector } from "../../hooks";

const Home: React.FC = () => {
  const navigate = useNavigate();
  const session = useAppSelector((state) => state.session);

  const handleViewProduct = (id: number) => {
    if (session.user) {
      navigate(`/products/${id}`);
    } else {
      navigate("/auth");
    }
  };

  return (
    <div>
      <h1>Welcome to Trendery!</h1>
      <button onClick={() => handleViewProduct(1)}>See Product #1</button>
    </div>
  );
};

export default Home;
