const express = require("express");
const cors = require("cors");
const swaggerJSDoc = require("swagger-jsdoc");
const swaggerUI = require("swagger-ui-express");

const port = process.env.PORT || 4000;
const bodyParser = require("body-parser");
const app = express();
app.use(cors());
app.use(bodyParser.json());

//import Controller
const RecipesController = require("./Controller/RecipesController");

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

app.listen(port, () => {
  console.log("Example app listen on port 4000!");
});
