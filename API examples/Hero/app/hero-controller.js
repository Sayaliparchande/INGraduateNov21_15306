const db=require('../db/models');

const hero=db.hero;

exports.findAll=(req,resp)=>{

    hero.findAll()

          .then((data)=>{resp.json(data)})

          .catch((err)=>{

              resp.status(500)

                   .send({message:err.message|| " Some Error retriving People Data"})

          })



}

//SELECT id, "firstName", "lastName", "createdAt", "updatedAt"

// FROM public."People" where id=?;

 exports.findByPk=(req,resp)=>{

     console.log("findOne: "+req.params.id);

     const id=parseInt(req.params.id);

     hero.findByPk(id)

           .then((data)=>{

                resp.json(data);

            })

           .catch((err)=>{

               resp.status(500)

                    .send({message:err.message||` Some error retriving Author data with id ${id}`});

           })  

 };

 // create

 exports.createHero = (req, resp) => {

    if(!req.body.heroName){

        res.status(400).send({

            message: "Content can not be empty!"

        });

        return;

    }

    const newHero={

        heroName: req.body.HeroName,

        filmName: req.body.HeroName,

        createdAt:new Date(),

        updatedAt:new Date()

    }

    hero.create(newHero)

        .then(data=>{resp.send(data);})

        .catch((err) => {

            resp.status(500).send({

                message: err.message || " Some error Creating new Author data"

            })

        })

}

//update

exports.update = (req, resp) => {

    const id = req.params.id;



    hero.update(req.body, { where: { id: id } })

        .then(num => {

            if (num == 1) {

            resp.send({

                message: `author with id ${id} updated successfully.`

            });

            } else {

            resp.send({

                message: `Cannot update author with id=${id}. Maybe author was not found or req.body is empty!`

            });

            }

        })

        .catch((err) => {

            resp.status(500).send({

                message: err.message || " Some error retriving Author data"

            })

        })

}

exports.delete = (req, resp) => {

    const id = req.params.id;

    hero.destroy({ where: { id: id } })

        .then(num => {

            if (num == 1) {

                resp.send({ message: `author with id=${id} deleted successfully!` });

            } else {

                resp.send({ message: `Cannot delete Author with id=${id}. Maybe Author was not found!` });

            }

        })

        .catch((err) => {

            resp.status(500).send({

                message: err.message || " Could not delete Author with id=" + id

            })

        })

}