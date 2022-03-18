import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs'; 
import { environment } from 'src/environments/environment';
import { Passbook } from './Passbook.model';
 

@Injectable({
  providedIn: 'root'
})
export class PassbookService {

  constructor(
    private http: HttpClient
  ) { }

  create(model: Passbook) : Observable<Passbook> {
    return this.http.post<Passbook>(`${environment.webApi}/Passbook`, model);
  }

  createall(model: any[]) : Observable<any> {
    return this.http.post<any>(`${environment.webApi}/Passbook/all`, model);
  }

  get(cid: number) : Observable<Passbook> {
    return this.http.get<any>(`${environment.webApi}/Common/Passbook/${cid}`);
  }

  getByApplicationUserId(applicationUserId: number) : Observable<Passbook[]> {
    return this.http.get<any[]>(`${environment.webApi}/Common/user/Passbook/${applicationUserId}`);
  }


  delete(cid: number) : Observable<number> {
    return this.http.delete<number>(`${environment.webApi}/Common/Passbook/${cid}`);
  }
}
