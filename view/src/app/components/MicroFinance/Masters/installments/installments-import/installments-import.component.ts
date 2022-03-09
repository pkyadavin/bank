
import { DatePipe } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { GridOptions } from 'ag-grid-community';
import { ToastrService } from 'ngx-toastr';
import { AccountService } from 'src/app/services/account.service';
import { ExcelService } from 'src/app/services/excel.service';
import { Installments } from '../Installments.model';
import { InstallmentsService } from '../Installments.service';
import * as XLSX from 'xlsx';

@Component({
  selector: 'app-Installments-import',
  templateUrl: './Installments-import.component.html',
  styleUrls: ['./Installments-import.component.css'],
  providers: [DatePipe]
})
export class InstallmentsImportComponent  implements OnInit {

  pagesize = 10;
  gridOptions: GridOptions;
  userdatas: Installments[];
  columnDefs = [];

  frameworkComponents: any;
  constructor(
    private InstallmentsService: InstallmentsService,
    private router: Router,
    private toastr: ToastrService,
    private accountService: AccountService,
    public excelService: ExcelService,
    public datePipe: DatePipe,
  ) {
    this.gridOptions = <GridOptions>{
    }
    this.gridOptions.paginationPageSize=this.pagesize;
    this.initColumns();
  }

  ngOnInit(): void {
    this.userdatas = []; 
  }

  defaultColDef;
  initColumns() {
    console.log("initColumns");
    let cc=this;
    this.columnDefs = [
      { headerName: 'id'.toUpperCase(), field: 'id',editable: true, sortable: true, filter: 'agTextColumnFilter', width: 150 ,floatingFilter:true  },
      { headerName: 'Adhar'.toUpperCase(), field: 'Adhar',editable: true, sortable: true, filter: 'agTextColumnFilter', width: 150 ,floatingFilter:true  },
      { headerName: 'Amount'.toUpperCase(), field: 'Amount',editable: true, sortable: true, filter: 'agTextColumnFilter', width: 150 ,floatingFilter:true  },
     {
        headerName: 'EDIT', width: 100, cellRenderer: (param) =>
        this.EDITRenderer(param)
      },      
    ];
  }  

  EDITRenderer(param) {
    var element = document.createElement('span');
    let template = '<i class="fas fa-edit"></i>';
    element.innerHTML = template;
    element.addEventListener('click', () => {
      this.editdata(param.data.id);
    });
    return element;
  }

  reloadPage() {
    if (this.router.url.indexOf("Installmentss") > 0) {
      this.router.navigate([`/Installments/`]);
    } else {
      this.router.navigate([`/Installmentss/`]);
    }
  }

  editdata(ID: number) {
    this.router.navigate([`/Installments/${ID}`]);
  }

  addfile(event) {
    this.imports(event);
  }

  imports(event) {
    let file;
    let arrayBuffer;
    let arraylist;
    file = event.target.files[0];
    let fileReader = new FileReader();
    fileReader.readAsArrayBuffer(file);
    fileReader.onload = (e) => {
      arrayBuffer = fileReader.result;
      var data = new Uint8Array(arrayBuffer);
      var arr = new Array();
      for (var i = 0; i != data.length; ++i) arr[i] = String.fromCharCode(data[i]);
      var bstr = arr.join("");
      var workbook = XLSX.read(bstr, { type: "binary" });
      var first_sheet_name = workbook.SheetNames[0];
      var worksheet = workbook.Sheets[first_sheet_name];
      arraylist = XLSX.utils.sheet_to_json(worksheet, { raw: true });
      this.userdatas=arraylist;
      console.log(arraylist);
    }
  }

  Save(){
    let array = this.userdatas.map(v => {
      return {
        id:  parseInt(v.id.toString()),           
        Adhar: v.Adhar.toString(),  
        Amount:  v.Amount.toString()  ,    
      }
    });

        this.InstallmentsService.createall(array).subscribe(v=>{
          this.router.navigate(['/Installments/']);
        });
  }

  onChangePageSize() {
    this.gridOptions.api.paginationSetPageSize(Number(this.pagesize));
    this.gridOptions.api.onFilterChanged();
  }

}
