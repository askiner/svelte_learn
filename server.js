const express = require("express")
const app = express()
const port = process.env.PORT || 3000;
app.get("/", (req, res) => {
  res.send("Hello, from my express app");
});

app.listen(port, () => {
  console.log(`Server runs on ${port}`);
});