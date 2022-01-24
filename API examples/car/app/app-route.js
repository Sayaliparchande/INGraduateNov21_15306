module.exports = (app) => {
    const express = require("express");
    const router = express.Router();
    const carController = require("./car-controller");
  
    router.get("/car",carController.findAll);
     router.get("/car/:id", carController.findById);
     router.post("/car/create",carController.create);
    router.put("/car/update/:id", carController.update);
   router.delete("/car/delete/:id", carController.delete);
  
    app.use("/app", router);
  };