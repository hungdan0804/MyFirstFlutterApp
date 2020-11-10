const express = require("express");
const app = express();
const port = process.env.PORT || 4000;
const cors = require("cors");
const swaggerJSDoc = require("swagger-jsdoc");
const swaggerUI = require("swagger-ui-express");
app.listen(port, () => {
  console.log("Server listening at port 4000 !!!!");
});

//Connect socket IO
const http = require("http").createServer();
http.listen(4001);
const io = require("socket.io").listen(http);

const bodyParser = require("body-parser");
app.use(cors());
app.use(bodyParser.json());
//import Controller
const RecipesController = require("./Controller/RecipesController");

//https://flutterapp-test.herokuapp.com/
const swaggerOptions = {
  swaggerDefinition: {
    info: {
      title: "My Test Api",
      description: "My Api information",
      contact: {
        name: "Hung Dan Project",
      },
      server: ["http://localhost:4000"],
    },
  },
  apis: ["app.js"],
};

const swaggerDocs = swaggerJSDoc(swaggerOptions);
app.use("/api-doc", swaggerUI.serve, swaggerUI.setup(swaggerDocs));

app.get("/", (req, res) => {
  res.redirect("/api-doc");
});

/**
 * @swagger
 *  paths:
 *   /Recipes/GetAll:
 *    get:
 *      summary: get all recipes.
 *      consumes:
 *        - application/json
 *      responses:
 *          '200':
 *            description: OK
 *          '400':
 *            description: Failed.

 */
app.get("/Recipes/GetAll", (req, res) => {
  RecipesController.GetAllRecipes(req, res);
});

io.on("connection", (socket) => {
  console.log("New Client " + socket.id);
  socket.emit("id", socket.id);
  socket.on("send", (value) => {
    console.log(value);
    socket.emit("receive", "Server: " + value);
  });
  socket.on("disconnect", () => {
    console.log("ABC");
    socket.disconnect();
  });
});
