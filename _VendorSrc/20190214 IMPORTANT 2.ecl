filedate:='20190214';
pversion:='20190214';
pUseProd:=true;

// a:=Misc.Files_VendorSrc(pVersion).Combined_Base;
// a:=Misc.Proc_Build_VendorSrc(filedate);
 //a:= Misc.Files_VendorSrc(pVersion).Combined_Base;
 //a:=Misc.Files_VendorSrc(pVersion).OldData;
 //a;
 //count(a);
 
//d:=_VendorSrc2.StandardizeInputFile(filedate, pUseProd).PrevBase;
//d:= _VendorSrc2.UpdateBase(filedate, pUseProd).VendorSrc_Base;
// d:=_VendorSrc2.StandardizeInputFile(filedate, pUseProd).Combined_Base;
 //d:=_VendorSrc2.Files(filedate, pUseProd).OldData_input;
 //d;
//count(d);


	
// Creates Base File
d:=_VendorSrc2.UpdateBase(filedate, pUseProd).VendorSrc_Base;
output(d,,'~thor_data::base::vendorsrc_'+filedate,compressed,overwrite);


// Takes base file as Dataset
     // b:=dataset(data_services.foreign_prod+'~thor_data400::base::vendor_src_info_20190211_patch',_vendorsrc2.layouts.base,flat);
     //b:=dataset('~thor_data400::base::vendor_src_info_20190211_patch',_vendorsrc2.layouts.base,flat);
		 b:=dataset(Data_Services.foreign_prod+'thor_data400::base::vendor_src_info_20190211',_vendorsrc2.layouts.base,flat);
     a:=dataset('~thor_data::base::vendorsrc_20190214',_vendorsrc2.layouts.base,flat);
count(b);
count(a);
// b;a;

// Creates compare tables
     // t:=table(b,{seq:='B',b}) + table(a,{seq:='A',a});

    // t1:=table(t,{cnt:=count(group),t},record, except seq,date_added,merge);

     // sort(t1(cnt=1),record, except seq,cnt);
     // count(t1(cnt=2));
     // count(t1(cnt=1));
