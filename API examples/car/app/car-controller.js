const db = require("../db/models");
const car = db.car;

exports.findAll = (req, res) => {
  car.findAll()
    .then((cars) => {
      res.json(cars);
    })
    .catch((err) => {
      res.send(err);
    });
};
exports.findById = (req, res) => {
  const id = parseInt(req.params.id);
  car.findByPk(id)
    .then((car) => {
      res.json(car);
    })
    .catch((err) => {
      res.send(err);
    });
};

exports.create = (req, res) => {
  car.create({
    carName: req.body.carName,
    brandName: req.body.brandName,
  })
    .then((car) => {
      res.json(car);
    })
    .catch((err) => {
      res.send(err);
    });
};

exports.update = (req, res) => {
  const id = parseInt(req.params.id);
  car.update(
    {
      carName: req.body.carName,
      brandName: req.body.brandName,
    },
    {
      where: {
        id: id,
      },
    }
  )
    .then((car) => {
      res.json("Successfully updated car with id = " + id);
    })
    .catch((err) => {
      res.send(err);
    });
};

exports.delete = (req, res) => {
  const id = parseInt(req.params.id);
  car.destroy({
    where: {
      id: id,
    },
  })
    .then((car) => {
      res.json("Successfully deleted car with id = " + id);
    })
    .catch((err) => {
      res.send(err);
    });
};