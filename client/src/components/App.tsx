import { useEffect, useState } from "react";

function App() {
  const [message, setMessage] = useState<string>("");

  useEffect(() => {
    fetch("/api/hello")
      .then((res) => res.json())
      .then((data: { message: string }) => setMessage(data.message))
      .catch(() => setMessage("Failed to connect to server"));
  }, []);

  return (
    <div style={{ padding: "2rem", fontFamily: "system-ui, sans-serif" }}>
      <h1>Full-Stack React & Python</h1>
      <p>Server says: {message || "Loading..."}</p>
    </div>
  );
}

export default App;
