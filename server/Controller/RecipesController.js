exports.GetAllRecipes = (req, res) => {
  res.status(200).json([
    {
      msg: "OK",
      payload: [
        "Chorizo & mozzarella gnocchi bake",
        "Chorizo & mozzarella gnocchi bake",
        "Chorizo & mozzarella gnocchi bake",
      ],
    },
  ]);
};
