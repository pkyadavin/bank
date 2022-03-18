import { AfterViewInit, Component, ElementRef, OnInit, ViewChild } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { TypeaheadMatch } from 'ngx-bootstrap/typeahead';
import { ToastrService } from 'ngx-toastr'; 
import { Photo } from 'src/app/models/photo/photo.model'; 
import { PhotoService } from 'src/app/services/photo.service';
import { AccountService } from 'src/app/services/account.service';
import { DatePipe } from '@angular/common';
import { Passbook } from './Passbook.model';
import { PassbookService } from './Passbook.service';
import { DataService } from 'src/app/services/data.service';

@Component({
  selector: 'app-Passbook',
  templateUrl: './Passbook.component.html',
  styleUrls: ['./Passbook.component.css'],
  providers: [DatePipe]
})
export class PassbookEditComponent  implements OnInit , AfterViewInit{
  showloader=false;
  dataForm: FormGroup;
  confirmImageDelete: boolean = false;
  userPhotos: Photo[] = [];
  id=0;
  img='';
  centerlist=[];
  branchlist=[];
  customerlist=[];
  productlist=[];
  @ViewChild('dob') dobElementRef:ElementRef;
  constructor(
    private route: ActivatedRoute,
    private formBuilder: FormBuilder,
    private PassbookService: PassbookService,
    private photoService: PhotoService,
    private toastr: ToastrService,
    public accountService: AccountService,
    private datePipe:DatePipe,
    private router: Router,
    private dataService:DataService,
  ) { }
installment;
  ngOnInit(): void {
     this.id = parseInt(this.route.snapshot.paramMap.get('id'));
    this.dataForm = this.formBuilder.group({
      id: [this.id],      
      Adhar	: ['', [Validators.required,Validators.minLength(12),Validators.maxLength(12) ]],     
      Amount	: ['', [Validators.required,Validators.minLength(5),Validators.maxLength(5) ]],
    });

    if (!!this.id  && this.id  !== -1) {
      this.showloader=true;
      this.PassbookService.getByApplicationUserId(this.id ).subscribe(data => {
        console.log(JSON.stringify(data)  );
        this.installment=data;
       // this.updateForm(data);
        this.showloader=false;
      });
    }
  }
 
  ngAfterViewInit() {
    console.log('Parent After View Init'); 
  }
dob;
  updateForm(Passbook: Passbook) {

    this.dataForm.patchValue({
      id: Passbook.id,    
      Adhar: Passbook.Adhar, 
      Amount: Passbook.Amount,      
 
    });  
    console.log(this.dataForm);
  }

  isTouched(field: string) {
    return this.dataForm.get(field).touched;
  }

  hasErrors(field: string) {
    return this.dataForm.get(field).errors;
  }

  hasError(field: string, error: string) {
    return !!this.dataForm.get(field).hasError(error);
  }

  isNew() {
    return parseInt(this.dataForm.get('id').value) === -1;
  }

  detachPhoto() {
    this.dataForm.patchValue({
      photoId: null,
      photoDescription: null
    });
  }

  onSelect(event: TypeaheadMatch): void {
    let chosenPhoto: Photo = event.item;
    this.dataForm.patchValue({
      photoId: chosenPhoto.photoId,
      photoDescription: chosenPhoto.description
    });
  }

  onSubmit() {    
    let data: Passbook = new Passbook(); 
    data.id=this.id; 
    data.Adhar=this.dataForm.get("Adhar").value;   
    data.Amount= (this.dataForm.get("Amount").value);   
    this.PassbookService.create(data).subscribe(createddata => {
      this.updateForm(createddata);
      this.toastr.info("Passbook saved.");
      this.router.navigate(['/Passbook/']);
    })
  }
}
