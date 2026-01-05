import React, { useState } from 'react';
import './App.css';

function App() {
  const [term, setTerm] = useState('');
  const [definition, setDefinition] = useState('');
  const [loading, setLoading] = useState(false);

  // REPLACE THIS with your "api_endpoint" output from Terraform
  const API_URL = process.env.REACT_APP_API_URL;

  const handleSearch = async () => {
    setLoading(true);
    setDefinition('');

    // Update the tab title dynamically!
    document.title = `Searching: ${term}...`;

    try {
      const response = await fetch(`${API_URL}?term=${term}`);
      const data = await response.json();
      
      if (response.ok) {
        document.title = `${term} | Cloud Dictionary`; // Title when found
        setDefinition(data.Definition);
      } else {
        setDefinition(data.message || "Term not found.");
      }
    } catch (error) {
      console.error("Error fetching data:", error);
      setDefinition("Error connecting to the dictionary.");
    }
    setLoading(false);
  };

  return (
    <div className="App">
      <header className="App-header">
        <h1>Cloud Dictionary</h1>
        <div className="search-container">
          <input 
            type="text" 
            placeholder="Search cloud term (e.g. S3)..." 
            value={term}
            onChange={(e) => setTerm(e.target.value)}
          />
          <button onClick={handleSearch} disabled={loading}>
            {loading ? 'Searching...' : 'Search'}
          </button>
        </div>
        {definition && (
          <div className="result-box">
            <h3>{term}</h3>
            <p>{definition}</p>
          </div>
        )}
      </header>
    </div>
  );
}

export default App;