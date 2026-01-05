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

    // Format term to match DynamoDB (e.g., s3 -> S3)
    const formattedTerm = term.trim().toUpperCase();

    try {
      const response = await fetch(`${API_URL}?term=${formattedTerm}`);
      const data = await response.json();
      
      if (response.ok) {
        document.title = `${term} | Cloud Dictionary`;
        // Access data.Definition with capital D as defined in Terraform
        setDefinition(data.Definition || "Definition field missing in database.");
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
      {/* Main background container */}
      <div className="container"> 
        <h1>Cloud Dictionary</h1>
        <div className="search-container">
          <input 
            type="text" 
            placeholder="Search cloud term (e.g. S3)..." 
            value={term}
            onChange={(e) => setTerm(e.target.value)}
            onKeyDown={(e) => e.key === 'Enter' && handleSearch()} // Support Enter key
          />
          <button onClick={handleSearch} disabled={loading}>
            {loading ? 'Searching...' : 'Search'}
          </button>
        </div>

        {definition && (
          <div className="result-box">
            <div className="word-header">
              <span className="word">{term}</span>
            </div>
            <p className="definition">{definition}</p>
          </div>
        )}
      </div>
    </div>
  );
}

export default App;