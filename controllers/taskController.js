// controllers/taskController.js
const express = require('express');
const mysql = require('mysql');

const router = express.Router();

// Create MySQL connection
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'password',
  database: 'my_todo_app'
});

// Connect to MySQL
connection.connect((err) => {
  if (err) {
    console.error('Error connecting to MySQL: ' + err.stack);
    return;
  }
  console.log('Connected to MySQL as id ' + connection.threadId);
});

// Get all tasks
router.get('/', (req, res) => {
  connection.query('SELECT * FROM tasks', (error, results) => {
    if (error) {
      console.error('Error executing MySQL query: ' + error.stack);
      return res.status(500).json({ error: 'Internal server error' });
    }
    res.json(results);
  });
});


// Update a task
router.put('/:id', (req, res) => {
  const { id } = req.params;
  const { title, completed } = req.body;
  const updatedTask = { title, completed };
  connection.query('UPDATE tasks SET ? WHERE id = ?', [updatedTask, id], (error, result) => {
    if (error) {
      console.error('Error executing MySQL query: ' + error.stack);
      return res.status(500).json({ error: 'Internal server error' });
    }
    if (result.affectedRows === 0) {
      return res.status(404).send('Task not found');
    }
    updatedTask.id = parseInt(id);
    res.json(updatedTask);
  });
});

// Delete a task
router.delete('/:id', (req, res) => {
  const { id } = req.params;
  connection.query('DELETE FROM tasks WHERE id = ?', id, (error, result) => {
    if (error) {
      console.error('Error executing MySQL query: ' + error.stack);
      return res.status(500).json({ error: 'Internal server error' });
    }
    if (result.affectedRows === 0) {
      return res.status(404).send('Task not found');
    }
    res.sendStatus(204);
  });
});

module.exports = router;

