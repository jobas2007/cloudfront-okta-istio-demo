import { useState } from "react";

function App() {

  const [message, setMessage] = useState("");

  const callBackend = async () => {
    const response = await fetch("http://localhost:8080/api/hello");
    const data = await response.json();
    setMessage(data.message);
  };

  return (
      <div style={{ padding: "2rem" }}>
        <h2>AWS Demo UI</h2>

        <button onClick={callBackend}>
          Call Backend
        </button>

        <p>{message}</p>
      </div>
  );
}

export default App;