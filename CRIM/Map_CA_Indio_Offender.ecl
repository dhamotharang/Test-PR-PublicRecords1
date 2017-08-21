import Crim_Common, CRIM, Address, lib_stringlib;

Input_RawFile := crim.File_CA_Indio;
dInput_RawFile:= distribute(Input_RawFile(regexfind(('^A[ ]*1| I[ ]*NC[ ]*$|VFW POST| LODGE | LODGE$| LANDSCAPE| PL[ ]*UMB[ ]*ING| TRANSP| TEST| CORP | CORP[ ]*$| STORES| COMPANY| LLC | LLC[ ]*$| SPORTS | SPORT[ ]*$| AUTO | AUTO[ ]*$| TOWING | TOWING[ ]*$|GROUP| CAB | CAB[ ]*$| TRUCK | TRUCK[ ]*$'),Name,0) ='' ), hash(case_number));
dsInput_RawFile := sort(dInput_RawFile,name,dob,case_number,date_filed,convicted_charge,probation_expires,key,local);
//output(count(dsInput_RawFile));
Input_RawFile_dedup := dedup(dsInput_RawFile,name,dob,case_number,date_filed,convicted_charge,probation_expires,RIGHT,local);
//output(count(Input_RawFile_dedup));
crim_common.Layout_In_Court_Offender Map_offender(Input_RawFile_dedup L) := Transform
	
         
	self.process_date     := Crim_Common.Version_In_Arrest_Offender;
	self.offender_key			:= Function_Offender_Key_Generator('3CA', L.Case_number,stringlib.stringfindreplace(L.Date_Filed,'/',''))+L.key;
																		
	self.vendor				    := '3C';
	self.state_origin			:= 'CA';
	self.data_type				:= '2';
	self.source_file			:= 'CA_INDIO_CRIM';
	self.case_number			:= TRIM(L.Case_number,left,right);

	string v_case_dt      := Function_ParseDate(L.Date_Filed,'MM/DD/YY');
	
	self.case_filing_dt		:= IF(v_case_dt[1..2] between '19' and '20', v_case_dt,'');
	self.pty_nm_fmt			  := 'L';
	string clean_name1    := IF (regexfind(('[1-9]'),L.name,0) = '' and regexfind(('0'),L.name,0) <> '', 
	                                       stringlib.stringfindreplace(L.name,'0','O'), L.name);
	string clean_name     := stringlib.stringfindreplace(
	                         stringlib.stringfindreplace(
	                         stringlib.stringfindreplace(
													 stringlib.stringfindreplace(
	                         stringlib.stringfindreplace(clean_name1,' 111 ',' III '),
													                                    ' 11 ',' II '),
																															' 3RD ',' III '),
																															' 2ND ',' II '),
																															' 1V ',' IV ')  ;
  string lname_temp     := trim(clean_name[1..19]);
	string lnamewithnum   := If(regexfind(('[a-zA-Z ]+'),lname_temp,0) = '', 'Y','N');
	string fname_temp     := trim(clean_name[20..31]);
	string mname_temp     := trim(clean_name[32..]);
	string orig_lname			:= IF (lnamewithnum = 'Y',mname_temp,lname_temp);
	string orig_fname			:= fname_temp;    
	string orig_mname			:= IF (lnamewithnum = 'Y','',mname_temp);
	
	self.orig_lname			  := trim(orig_lname);
	self.orig_fname			  := trim(orig_fname);    
	self.orig_mname			  := trim(orig_mname);
	self.orig_name_suffix	:= '';
	self.pty_nm           := trim(stringlib.stringfindreplace(trim(orig_lname)+ ' '+trim(orig_fname)+' '+trim(orig_mname),'  ',' '),LEFT,RIGHT);
	self.pty_typ				  := '0';
	self.dob					    := IF(Function_ParseDate(TRIM(L.dob,right),'MM/DD/YYDOB') >= '19000101'  and 
	                            ((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)Function_ParseDate(TRIM(L.dob,right),'MM/DD/YYDOB')[1..4])>=18,
									            Function_ParseDate(TRIM(L.dob,right),'MM/DD/YYDOB'),'');
	
  self                  := [];
end;

P_CAIN_Offender := PROJECT(Input_RawFile_dedup, Map_offender(left),LOCAL);
Crim.Crim_clean(P_CAIN_Offender,clean_CAIN_Offender);

export Map_CA_Indio_Offender := clean_CAIN_Offender :PERSIST('~thor_dell400::persist::Crim_CA_Indio_Offender');