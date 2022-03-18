 
import { DatePipe } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { GridOptions } from 'ag-grid-community';
import { ToastrService } from 'ngx-toastr';
import { AccountService } from 'src/app/services/account.service';
import { ExcelService } from 'src/app/services/excel.service';
import { Disbursement } from '../Disbursement.model';
import { DisbursementService } from '../Disbursement.service';
@Component({
  selector: 'app-Disbursement',
  templateUrl: './Disbursement.component.html',
  styleUrls: ['./Disbursement.component.css'],
  providers: [DatePipe]
})
export class DisbursementComponent implements OnInit {

  pagesize = 10;
  gridOptions: GridOptions;
  userdatas: Disbursement[];
  columnDefs = [];
 
  frameworkComponents:any;
  constructor(
    private DisbursementService: DisbursementService,
    private router: Router,
    private toastr: ToastrService,
    private accountService: AccountService,
    public excelService: ExcelService,
    private datePipe:DatePipe,

  ) {
    this.gridOptions = <GridOptions>{
 
    }
    this.gridOptions.paginationPageSize=this.pagesize;
   // this.gridOptions.floatingFilter=true;
 
    this.initColumns();
  }

  ngOnInit(): void {
    this.userdatas = [];
    let currentApplicationUserId = this.accountService.currentUserValue.applicationUserId;

    this.DisbursementService.getByApplicationUserId(currentApplicationUserId).subscribe(userdatas => {
      this.userdatas = userdatas;
      console.log(userdatas);
    });
  }

  defaultColDef;
  initColumns() {
    console.log("initColumns");
    let cc=this;
    this.columnDefs = [
      { headerName: 'Adhar'.toUpperCase(), field: 'Adhar',editable: true, sortable: true, filter: 'agTextColumnFilter', width: 150 ,floatingFilter:true  },
      { headerName: 'Amount'.toUpperCase(), field: 'Amount',editable: true, sortable: true, filter: 'agTextColumnFilter', width: 150 ,floatingFilter:true  },
      {
        headerName: 'Passbook'.toUpperCase(), width: 150, cellRenderer: (param) =>
        this.EDITRenderer(param)
      },
    
      // {
      //   headerName: 'Adr'.toUpperCase(), width: 75, cellRenderer: (param) =>
      //   this.AdrRenderer(param)
      // },
    ];
  }

  AdrRenderer(param) {  
    var element = document.createElement('span');
    let template = '<i class="fas fa-plus"></i>';
    element.innerHTML = template;
    element.addEventListener('click', () => {
      this.Adrdata(param.data.Adhar);
    });
    return element;
  }

  Adrdata(ID: number) {   
    this.router.navigate([`/passbook/${ID}`]);
  }
  
  EDITRenderer(param) {  
    var element = document.createElement('span');
    let template = '<i class="fas fa-eye"></i>';
    element.innerHTML = template;
    element.addEventListener('click', () => {
      this.editdata(param.data.id);
    });
    return element;
  }

  DeleteRenderer(param) {
     var element = document.createElement('span');
    let template = '<i class="fas fa-trash-alt"></i>';
    element.innerHTML = template;
    element.addEventListener('click', () => {
      this.deleteConfirmed(param.data, this.userdatas);
    });
    return element;
  }

  deleteConfirmed(data: Disbursement, datas: Disbursement[]) {  
    this.DisbursementService.delete(data.id).subscribe(() => {
      let index = 0;
      for (let i = 0; i < datas.length; i++) {
        if (datas[i].id === data.id) {
          index = i;
        }
      }
      if (index > -1) {
        datas.splice(index, 1);
      }
      this.toastr.info("data deleted."); 
    //  this.reloadPage();      
    });
  }

  reloadPage(){ 
    if(this.router.url.indexOf("Disbursements")>0){
      this.router.navigate([`/Disbursement/`]);
    }else{
      this.router.navigate([`/Disbursements/`]);
    }
  }

  editdata(ID: number) {   
    this.router.navigate([`/passbook/${ID}`]);
  }

  createdata() { 
    this.router.navigate(['/Disbursement/-1']);
  }

  import = false;
  Import() {
    this.router.navigate(['/Disbursementimport/']);   
  }

  Export() {
    let array = this.userdatas.map(v => {
      return {
        id: v.id.toString(),        
        Adhar: v.Adhar.toString(),      
        Amount: v.Amount.toString(), 
      }
    })
    let col=["id","Adhar","Amount"  ]
    this.excelService.Export( array,col,'Disbursement');
  }

  Print(id){
    var html="<html>";
    html+= document.getElementById(id).innerHTML; 
    html+="</html>"; 
    var printWin = window.open('','','left=100,top=100,width=800,height=800,toolbar=0,scrollbars=0,status  =0');
    printWin.document.write(html);
    printWin.document.close();
    printWin.focus();
    printWin.print();
    printWin.close();
  }

  ExportPDF(){
      this.Print("pdfdata");
  }

  onChangePageSize() {
    this.gridOptions.api.paginationSetPageSize(Number(this.pagesize));
    this.gridOptions.api.onFilterChanged();
  }
  showgrid=false
  Show(){
    this.showgrid=!this.showgrid;
  }

}
