module.exports = (app) => {
    const express = require("express");
    const router = express.Router();
    const accountController = require("./account-controller");
  
    router.get("/accounts", accountController.findAll);
    router.get("/accounts/:id", accountController.findById);
    router.post("/accounts/create", accountController.create);
    router.put("/accounts/update/:id", accountController.update);
    router.delete("/accounts/delete/:id", accountController.delete);
  
    app.use("/app", router);
  };