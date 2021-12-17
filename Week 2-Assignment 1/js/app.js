function Book(bookId,bookName,authorName){

    this.bookId=bookId;

    this.bookName=bookName;

    this.authorName=authorName;

    this.displayDetails=function (){

    return " ID-"+this.bookId+" Book Name- "+this.bookName+" Author Name- "+this.authorName;

    }

    }

 const Book1=new Book(1,"Let us 'C'", "Y.S.Kanetkar");

 const result=document.getElementById("result");

 result.innerHTML=Book1.displayDetails();