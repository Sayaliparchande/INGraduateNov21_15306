import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

import { HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { IUser } from '../IUser';


@Injectable({
  providedIn: 'root'
})
export class UserService {
  private baseUrl = 'http://localhost:3000';
  httpOptions = {
    headers: new HttpHeaders({'Content-Type': 'application/json'})
  };

 constructor(private httpClient : HttpClient) { }

  getUsers(): Observable<IUser[]> {
    return this.httpClient.get<IUser[]>(this.baseUrl + '/users');
  }
}
