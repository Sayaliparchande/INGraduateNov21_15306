module.exports=(app)=>{

    const express=require('express');

    const ROUTER=express.Router();

    const BooksController=require('./book-controller');

    ROUTER.get('/books',BooksController.findAll);

    ROUTER.get('/books/:id',BooksController.findByPk);

    ROUTER.post('/books/add',(req,resp)=>{    });

    ROUTER.put('/books/update/:id',(req,resp)=>{    });

    ROUTER.delete('/books/delete/:id',(req,resp)=>{    });

    




    app.use('/app',ROUTER);

}