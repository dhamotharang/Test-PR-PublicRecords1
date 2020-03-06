import lib_date, std;

EXPORT Hygenics_Crim_Upload_Date_Check := FUNCTION

current_date := (STRING8)Std.Date.Today();

tab_layout := RECORD
  string100 sourcename;
  string5 fn_sourcename_to_vendor;
  string8 recorduploaddate;
  boolean t_f;
 END;
 
tab_layout_small := RECORD
  string5 vendor_code;
  string100 vendor_source;
  string1   lf;
 END;

omit_layout := record
  string5 vendor_code;
  string100 vendor_source;
  string1   lf;
end;

historical := dataset('~thor_data400::in::vendor_omits', omit_layout,flat);

x := hygenics_crim.file_in_defendant_doc + 
     hygenics_crim.file_in_defendant_counties + 
		 hygenics_crim.file_in_defendant + 
     hygenics_crim.file_in_defendant_arrests ;
		 
//get IE sources.  One sourcename can have many recorduploaddate. 
//So for that sourcename, use most recent recorduploaddate
IE_sources := x(sourcename[length(trim(sourcename,left,right))-2..length(trim(sourcename,left,right))]= '_IE');		 
sort_IE_sources := sort(distribute(IE_sources,hash32(sourcename)),sourcename,-recorduploaddate,local);
dedup_IE_sources := dedup(distribute(sort_IE_sources,hash32(sourcename)),sourcename,local);		 

//get non IE sources
other_sources := x(sourcename[length(trim(sourcename,left,right))-2..length(trim(sourcename,left,right))]<> '_IE');		 

y := other_sources + dedup_IE_sources;

tab := table(y(sourcename NOT IN ['FLORIDA_DEPARTMENT_OF_CORRECTIONS_HISTORY_FILE','OKLAHOMA_DISTRICT_COURTS_HISTORY_FILE']), {sourcename,recorduploaddate}, 	sourcename,recorduploaddate	,few);


a := tab(hygenics_crim._functions.fn_sourcename_to_vendor(trim(sourcename),'')<> '');

tab_layout tTAB(a input) := Transform
self.sourcename							        := input.sourcename;
self.fn_sourcename_to_vendor		:= hygenics_crim._functions.fn_sourcename_to_vendor(trim(input.sourcename),'');
self.recorduploaddate					    := input.recorduploaddate;
self.t_f						                := LIB_Date.DaysApart(input.recorduploaddate, current_date )<=180;
end;

pTAB 	:= project(a,tTAB(left));

pTABFinal := pTAB(t_f = false);

tab_layout_small tTABSmall(pTABFinal input) := Transform
self.vendor_code							       := input.fn_sourcename_to_vendor;
self.vendor_source		          := input.sourcename;
self.lf                       := '\n';
end;

pTABSmall 	:= project(pTABFinal,tTABSmall(left));

pTabAll := dedup(sort(pTABSmall + historical, vendor_code),vendor_code);


RETURN sequential(FileServices.ClearSuperFile('~thor_data400::out::vendor_omits'),
                  output(pTabAll,,'~thor_data400::out::omit_vendor_all_new',overwrite),
									         FileServices.AddSuperFile('~thor_data400::out::vendor_omits', '~thor_data400::out::omit_vendor_all_new'));
END;
