const db = require("../db/models");
const Authors = db.Authors;

exports.findAll = (req, res) => {
  Authors.findAll()
    .then((authors) => {
      res.json(authors);
    })
    .catch((err) => {
      res.send(err);
    });
};
exports.findById = (req, res) => {
  const id = parseInt(req.params.id);
  Authors.findByPk(id)
    .then((author) => {
      res.json(author);
    })
    .catch((err) => {
      res.send(err);
    });
};

exports.create = (req, res) => {
  Authors.create({
    authorName: req.body.authorName,
    bookName: req.body.bookName,
  })
    .then((author) => {
      res.json(author);
    })
    .catch((err) => {
      res.send(err);
    });
};

exports.update = (req, res) => {
  const id = parseInt(req.params.id);
  Authors.update(
    {
      authorName: req.body.authorName,
      bookName: req.body.bookName,
    },
    {
      where: {
        id: id,
      },
    }
  )
    .then((author) => {
      res.json("Successfully updated author with id = " + id);
    })
    .catch((err) => {
      res.send(err);
    });
};
exports.delete = (req, res) => {
  const id = parseInt(req.params.id);
  Authors.destroy({
    where: {
      id: id,
    },
  })
    .then((author) => {
      res.json("Successfully deleted author with id = " + id);
    })
    .catch((err) => {
      res.send(err);
    });
};