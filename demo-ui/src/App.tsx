import { useState } from "react";
import { useAuth0 } from "@auth0/auth0-react";

function App() {
  const { 
    isLoading, 
    isAuthenticated, 
    user, 
    loginWithRedirect, 
    logout,
    getAccessTokenSilently 
  } = useAuth0();

  const [message, setMessage] = useState("");
  const [error, setError] = useState("");

  const callBackend = async () => {
    try {
      setError("");
      setMessage("Loading...");

      // Get JWT token from Auth0
      const token = await getAccessTokenSilently();
      
      // Call minikube Istio gateway via port-forward (stable localhost:8080)
      const response = await fetch("http://localhost:8080/api/hello", {
        headers: {
          Authorization: `Bearer ${token}`,
        },
      });

      if (!response.ok) {
        throw new Error(`API Error: ${response.status}`);
      }

      const data = await response.json();
      setMessage(data.message);
    } catch (err: any) {
      setError(err.message);
      setMessage("");
    }
  };

  if (isLoading) {
    return <div style={{ padding: "2rem" }}>Loading...</div>;
  }

  return (
    <div style={{ padding: "2rem", fontFamily: "sans-serif" }}>
      <h2>🚀 AWS Demo UI with Auth0</h2>

      {/* Authentication Status */}
      <div style={{ 
        padding: "1rem", 
        marginBottom: "1rem", 
        backgroundColor: isAuthenticated ? "#d4edda" : "#f8d7da",
        borderRadius: "4px"
      }}>
        <strong>Status:</strong> {isAuthenticated ? "✅ Authenticated" : "❌ Not Authenticated"}
      </div>

      {/* User Info */}
      {isAuthenticated && user && (
        <div style={{ 
          padding: "1rem", 
          marginBottom: "1rem", 
          backgroundColor: "#d1ecf1",
          borderRadius: "4px"
        }}>
          <strong>User:</strong> {user.name || user.email}<br />
          <strong>Email:</strong> {user.email}
        </div>
      )}

      {/* Login/Logout Buttons */}
      {!isAuthenticated ? (
        <button 
          onClick={() => loginWithRedirect()}
          style={{ 
            padding: "0.5rem 1rem", 
            fontSize: "1rem",
            cursor: "pointer",
            marginBottom: "1rem"
          }}
        >
          🔐 Login with Auth0
        </button>
      ) : (
        <button 
          onClick={() => logout({ logoutParams: { returnTo: window.location.origin } })}
          style={{ 
            padding: "0.5rem 1rem", 
            fontSize: "1rem",
            cursor: "pointer",
            marginBottom: "1rem",
            marginRight: "0.5rem"
          }}
        >
          🚪 Logout
        </button>
      )}

      {/* Call Backend Button (only when authenticated) */}
      {isAuthenticated && (
        <button 
          onClick={callBackend}
          style={{ 
            padding: "0.5rem 1rem", 
            fontSize: "1rem",
            cursor: "pointer",
            marginBottom: "1rem",
            backgroundColor: "#007bff",
            color: "white",
            border: "none",
            borderRadius: "4px"
          }}
        >
          📡 Call Backend (with JWT)
        </button>
      )}

      {/* API Response */}
      {message && (
        <div style={{ 
          padding: "1rem", 
          backgroundColor: "#e7f3ff",
          borderRadius: "4px",
          marginTop: "1rem"
        }}>
          <strong>Backend Response:</strong> {message}
        </div>
      )}

      {/* Error Display */}
      {error && (
        <div style={{ 
          padding: "1rem", 
          backgroundColor: "#f8d7da",
          borderRadius: "4px",
          marginTop: "1rem",
          color: "#721c24"
        }}>
          <strong>Error:</strong> {error}
        </div>
      )}
    </div>
  );
}

export default App;