const express = require('express');

const app = express();
app.use(express.json());

let items = [];

app.get('/', (req, res) => {
  res.json({ message: 'Welcome to GitHub Actions Learning API!' });
});

app.get('/health', (req, res) => {
  res.json({ status: 'healthy', timestamp: new Date().toISOString() });
});

app.get('/items', (req, res) => {
  res.json(items);
});

app.post('/items', (req, res) => {
  const { name, description } = req.body;
  
  if (!name) {
    return res.status(400).json({ error: 'Name is required' });
  }
  
  const newItem = {
    id: items.length + 1,
    name,
    description: description || '',
    createdAt: new Date().toISOString()
  };
  
  items.push(newItem);
  res.status(201).json(newItem);
});

app.get('/items/:id', (req, res) => {
  const id = parseInt(req.params.id);
  const item = items.find(i => i.id === id);
  
  if (!item) {
    return res.status(404).json({ error: 'Item not found' });
  }
  
  res.json(item);
});

app.delete('/items/:id', (req, res) => {
  const id = parseInt(req.params.id);
  const index = items.findIndex(i => i.id === id);
  
  if (index === -1) {
    return res.status(404).json({ error: 'Item not found' });
  }
  
  items.splice(index, 1);
  res.status(204).send();
});

app.use((req, res) => {
  res.status(404).json({ error: 'Route not found' });
});

module.exports = app;