const db = require("../db/models");
const account = db.account;

exports.findAll = (req, res) => {
  account.findAll()
    .then((accounts) => {
      res.json(accounts);
    })
    .catch((err) => {
      res.send(err);
    });
};

exports.findById = (req, res) => {
  const id = parseInt(req.params.id);
  account.findByPk(id)
    .then((account) => {
      res.json(account);
    })
    .catch((err) => {
      res.send(err);
    });
};

exports.create = (req, res) => {
  account
    .create({
      accName: req.body.accName,
      balance: req.body.balance,
    })
    .then((account) => {
      res.json(account);
    })
    .catch((err) => {
      res.send(err);
    });
};

exports.update = (req, res) => {
  const id = parseInt(req.params.id);
  account
    .update(
      {
        accName: req.body.accatName,
        balance: req.body.balance,
      },
      {
        where: {
          id: id,
        },
      }
    )
    .then((account) => {
      res.json("Successfully updated account with id = " + id);
    })
    .catch((err) => {
      res.send(err);
    });
};

exports.delete = (req, res) => {
  const id = parseInt(req.params.id);
  account.destroy({
    where: {
      id: id,
    },
  })
    .then((account) => {
      res.json("Successfully deleted account with id = " + id);
    })
    .catch((err) => {
      res.send(err);
    });
};