import { Component, OnInit } from '@angular/core';
import { IUser } from '../user/IUser';
import { UserService } from '../user/service/user.service';

@Component({
  selector: 'app-user-list',
  templateUrl: './user-list.component.html',
  styleUrls: ['./user-list.component.css']
})
export class UserListComponent implements OnInit {

  users: IUser[] = [];


  constructor(private userService : UserService) { }

  ngOnInit(): void {

    // this.userService.getUsers().subscribe(
    //   (data: IUser[]) => {
    //     this.users = data;
    //   }
    // );


    this.getUsers();
  }

  getUsers(){
    this.userService.getUsers().subscribe(
      (allUsers: IUser[]) => {
        this.users = allUsers;
      }
    );
  }

}
