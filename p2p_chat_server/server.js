import express from 'express';
import bodyParser from 'body-parser';
import fetch from 'node-fetch';

const app = express();
app.use(bodyParser.json());

const users = {};
const messages = {};

app.post('/register', (req, res) => {
  const { username, pushToken } = req.body;
  users[username] = { pushToken };
  res.status(200).send('User registered');
});

app.post('/send', async (req, res) => {
  const { from, to, message } = req.body;
  if (!users[to]) {
    return res.status(404).send('Recipient not found');
  }

  if (!messages[to]) {
    messages[to] = [];
  }

  messages[to].push({ from, message });

  // Log received message for testing
  console.log(`Message from ${from} to ${to}: ${message}`);

  // Send push notification (mocked for now)
  // await fetch('https://example.com/send-push', {
  //   method: 'POST',
  //   headers: { 'Content-Type': 'application/json' },
  //   body: JSON.stringify({ to: users[to].pushToken, message: 'New message from ' + from }),
  // });

  res.status(200).send('Message sent');
});

app.get('/messages', (req, res) => {
  const { username } = req.query;
  res.status(200).json(messages[username] || []);
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
