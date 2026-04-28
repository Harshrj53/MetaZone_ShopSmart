import React, { useEffect, useState } from 'react';
import axios from 'axios';

function App() {
  const [products, setProducts] = useState([]);
  const [status, setStatus] = useState('Loading...');

  const API_URL = import.meta.env.VITE_API_URL || '/api';

  useEffect(() => {
    axios.get(`${API_URL}/products`)
      .then(res => {
        setProducts(res.data);
        setStatus('Online');
      })
      .catch(err => {
        console.error(err);
        setStatus('Error connecting to backend');
      });
  }, [API_URL]);

  return (
    <div style={{ padding: '2rem', fontFamily: 'Arial' }}>
      <h1>MetaZone ShopSmart</h1>
      <p>System Status: <strong>{status}</strong></p>
      
      <h2>Product Catalog</h2>
      <div style={{ display: 'grid', gap: '1rem' }}>
        {products.map(product => (
          <div key={product.id} style={{ border: '1px solid #ccc', padding: '1rem', borderRadius: '8px' }}>
            <h3>{product.name}</h3>
            <p>Price: ${product.price}</p>
          </div>
        ))}
      </div>
    </div>
  );
}

export default App;
