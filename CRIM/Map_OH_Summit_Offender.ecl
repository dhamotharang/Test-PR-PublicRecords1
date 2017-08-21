import Crim_Common, CRIM, Address, lib_stringlib;
Input_RawFile := File_OH_Summit;

dInput_RawFile:= distribute(Input_RawFile(trim(defendant) not in FILTER_CONDITIONS and 
                                          trim(defendant) <> 'Defendant' and 
																					defendant <> '' and
																					regexfind('[a-zA-Z]+',defendant,0)<> ''), hash(casenumber));

//dsInput_RawFile := sort(dInput_RawFile,record,local);

//Input_RawFile_dedup := dedup(dsInput_RawFile,record,local);

Crim_Common.Layout_In_Court_Offender Map_offender(dInput_RawFile L) := Transform
	
             
	self.process_date     := Crim_Common.Version_In_Arrest_Offender;
	self.offender_key			:= Function_Offender_Key_Generator('4B',trim(L.casenumber),trim(stringlib.stringfindreplace(L.Filedate,'/','')));
	self.vendor				    := '4B'; 
	self.state_origin			:= 'OH';
	self.data_type				:= '2';
	self.source_file			:= '(CV)OH_SUMMIT_CRIM';
	self.case_number			:= trim(L.casenumber);
	self.case_court			  := '';
	self.case_name				:= '';
	self.case_type				:= '';
	self.case_type_desc		:= '';
	
	string v_case_dt      := '';
	self.case_filing_dt		:= IF(Function_ParseDate(TRIM(L.filedate),'MM/DD/YYYY') >= '19000101', 
	                            Function_ParseDate(L.filedate,'MM/DD/YYYY'),'');
															
  string clean_name     := stringlib.stringfindreplace(
	                         stringlib.stringfindreplace(
	                         stringlib.stringfindreplace(
													 stringlib.stringfindreplace(
	                         stringlib.stringfindreplace(trim(L.defendant)+' ',' 111 ',' III '),
													                                    ' 11 ',' II '),
																															' 3RD ',' III '),
																															' 2ND ',' II '),
																															' 1V ',' IV ')  ;		
  string clean_name_1   := stringlib.stringfilterout(stringlib.stringfindreplace(trim(clean_name,left,right),'0','O'),'0123456789');																														
	self.pty_nm				    := trim(clean_name_1,left,right);
	self.pty_nm_fmt			  := 'F';
	self.orig_lname			  := '';
	self.orig_fname			  := '';    
	self.orig_mname			  := '';
	self.orig_name_suffix	:= '';
	self.pty_typ				  := '0';
	self.nitro_flag			  := '';
	string ssn            := '';
	self.dle_num				  := '';
	self.fbi_num				  := '';
	self.doc_num				  := '';
	self.ins_num				  := '';
	self.id_num				    := '';
  self.dl_num           := '';
	self.dl_state				  := '';
	self.citizenship		  := '';
	string dob            := IF(Function_ParseDate(TRIM(L.dateofbirth,right),'MM/DD/YYYY') >= '19000101'  and 
	                            ((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)Function_ParseDate(TRIM(L.dateofbirth,right),'MM/DD/YYYY')[1..4])>=18,
									            Function_ParseDate(TRIM(L.dateofbirth,right),'MM/DD/YYYY'),'');
	self.dob					     := dob;
	self.place_of_birth	  := '';
	string address1       := if(length(trim(L.defendant_address))> 1, stringlib.stringfilterout(L.defendant_address,'[]'),'');
	self.street_address_1	:= 	if(trim(address1,left,right)[1..4]='LKA ',
								regexreplace('LKA ', trim(Stringlib.stringfindreplace(Stringlib.stringfindreplace(Stringlib.stringfindreplace(Stringlib.stringfindreplace(
								address1,'(LKA)',''),'LKA:',''),
								'C/O',''),'(LK)',''),left,right), ''),
								trim(Stringlib.stringfindreplace(Stringlib.stringfindreplace(Stringlib.stringfindreplace(Stringlib.stringfindreplace(
								address1,'(LKA)',''),'LKA:',''),
								'C/O',''),'(LK)',''),left,right));
	self.street_address_2	:= '';
	self.street_address_3	:= If (regexfind('[a-zA-Z]+',L.defendant_city,0)<> '',stringlib.stringfilterout(TRIM(L.defendant_city),'[]'),'');
  self.street_address_4	:= If(regexfind('[a-zA-Z]+',L.defendant_state,0)<> '',TRIM(L.defendant_state),''); 
  self.street_address_5	:= IF (length(TRIM(L.defendantzip)) <5 ,'' ,TRIM(L.defendantzip)[1..5]) ;
	self.race					    := trim(L.race); //Field is not populated after 2003.Prior to that sex is populated in race field and visa versa 
	self.race_desc		    := RaceCode2StandardDescription(L.race);
	self.sex					    := MAP(trim(L.gender,all)[1..1] ='M' => 'M',
	                             trim(L.gender,all)[1..1] ='F' => 'F', 
															 '');	 //Field is not populated after 2003. 
															 
												 
  self                  := [];
end;
   
P_OHSU_Offender := PROJECT(dInput_RawFile, Map_offender(left),LOCAL);

Crim.Crim_clean(P_OHSU_Offender,clean_FLAC_Offender);

SFLAC_Offender     := sort(clean_FLAC_Offender,offender_key,lname,fname,mname,name_suffix,Case_Number,orig_ssn,DOB,dob_alias,dl_state,dl_num,
                                               Race,Sex,Height,Weight,hair_color,Eye_color,case_court,																							 
                                               prim_range, predir, addr_suffix, postdir, unit_desig, sec_range, zip5,pty_typ);
																					 
																							 
FLAC_Offender_dedup:= dedup(SFLAC_Offender, offender_key,lname,fname,mname,name_suffix,Case_Number,orig_ssn,DOB,dob_alias,dl_state,dl_num,
                                               Race,Sex,Height,Weight,hair_color,Eye_color,case_court,																							 
                                               prim_range, predir, addr_suffix, postdir, unit_desig, sec_range, zip5,LEFT); 




export Map_OH_Summit_Offender := FLAC_Offender_dedup : persist ('~thor_dell400::persist::Crim_OH_Summit_Offender');
