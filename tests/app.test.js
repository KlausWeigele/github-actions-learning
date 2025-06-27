const request = require('supertest');
const app = require('../src/app');

describe('API Tests', () => {
  describe('GET /', () => {
    it('should return welcome message', async () => {
      const response = await request(app).get('/');
      expect(response.status).toBe(200);
      expect(response.body.message).toBe('Welcome to GitHub Actions Learning API!');
    });
  });

  describe('GET /health', () => {
    it('should return health status', async () => {
      const response = await request(app).get('/health');
      expect(response.status).toBe(200);
      expect(response.body.status).toBe('healthy');
      expect(response.body.timestamp).toBeDefined();
    });
  });

  describe('Items CRUD operations', () => {
    let app;
    
    beforeEach(() => {
      // Clear the module cache to get a fresh instance
      jest.resetModules();
      app = require('../src/app');
    });

    it('should create a new item', async () => {
      const newItem = { name: 'Test Item', description: 'Test Description' };
      const response = await request(app)
        .post('/items')
        .send(newItem);
      
      expect(response.status).toBe(201);
      expect(response.body.name).toBe(newItem.name);
      expect(response.body.description).toBe(newItem.description);
      expect(response.body.id).toBeDefined();
    });

    it('should return 400 when creating item without name', async () => {
      const response = await request(app)
        .post('/items')
        .send({ description: 'No name' });
      
      expect(response.status).toBe(400);
      expect(response.body.error).toBe('Name is required');
    });

    it('should get all items', async () => {
      await request(app).post('/items').send({ name: 'Item 1' });
      await request(app).post('/items').send({ name: 'Item 2' });
      
      const response = await request(app).get('/items');
      expect(response.status).toBe(200);
      expect(response.body).toHaveLength(2);
    });

    it('should get item by id', async () => {
      const createResponse = await request(app)
        .post('/items')
        .send({ name: 'Test Item' });
      
      const response = await request(app).get(`/items/${createResponse.body.id}`);
      expect(response.status).toBe(200);
      expect(response.body.name).toBe('Test Item');
    });

    it('should return 404 for non-existent item', async () => {
      const response = await request(app).get('/items/999');
      expect(response.status).toBe(404);
      expect(response.body.error).toBe('Item not found');
    });

    it('should delete an item', async () => {
      const createResponse = await request(app)
        .post('/items')
        .send({ name: 'To Delete' });
      
      const deleteResponse = await request(app)
        .delete(`/items/${createResponse.body.id}`);
      expect(deleteResponse.status).toBe(204);
      
      const getResponse = await request(app).get(`/items/${createResponse.body.id}`);
      expect(getResponse.status).toBe(404);
    });
  });

  describe('404 handler', () => {
    it('should return 404 for unknown routes', async () => {
      const response = await request(app).get('/unknown-route');
      expect(response.status).toBe(404);
      expect(response.body.error).toBe('Route not found');
    });
  });
});