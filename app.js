// app.js
const express = require('express');
const bodyParser = require('body-parser');
const taskController = require('./controllers/taskController');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(bodyParser.json());

// Routes
//app.use('/tasks', taskController);

// Start server
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
