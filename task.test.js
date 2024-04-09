// task.test.js
const chai = require('chai');
const chaiHttp = require('chai-http');
const app = require('./app'); // Assuming your Express app is in app.js
const should = chai.should();

chai.use(chaiHttp);

describe('Tasks', () => {
  beforeEach((done) => {
    tasks = []
    done();
  });

  // Test the POST /tasks route
  describe('/POST task', () => {
    it('it should create a new task', (done) => {
      const task = {
        title: 'Test Task',
      };
      chai.request(app)
        .post('/tasks')
        .send(task)
        .end((err, res) => {
          res.should.have.status(201);
          res.body.should.be.a('object');
          res.body.should.have.property('id');
          res.body.should.have.property('title').eql(task.title);
          res.body.should.have.property('completed').eql(false);
          done();
        });
    });
  });
});
