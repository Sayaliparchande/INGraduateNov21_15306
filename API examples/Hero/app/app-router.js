module.exports=app=>{

    const express=require('express');

    const Router=express.Router();

    const HeroControllor=require('./hero-controller');


    //GET url: http://localhost:3500/app/persons

    Router.get('/hero',HeroControllor.findAll);

    //GET url: http://localhost:3500/app/persons/:id

    Router.get('/hero/:id',HeroControllor.findByPk);

    //POST url: http://localhost:3500/app/persons/add

    Router.post('/hero/add',HeroControllor.createHero);

    //PUT url: http://localhost:3500/app/persons/update/:id

    Router.put('/hero/update/:id',HeroControllor.update);

    //DELETE url: http://localhost:3500/app/persons/delete/:id

    Router.delete('/hero/delete/:id',HeroControllor.delete);  

    //Main url: http://localhost:3500/app/

    app.use('/app',Router);  

}