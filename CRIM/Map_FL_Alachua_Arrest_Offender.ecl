import Crim_Common, CRIM, Address, lib_stringlib;


dInput_RawFile:= distribute(File_FL_Alachua_Arrest(trim(name) not in FILTER_CONDITIONS and name <> ''), hash(name));
dsInput_RawFile := sort(dInput_RawFile,name,address,citystatezip,dob,race,sex,arrestdate,local);
//output(count(dsInput_RawFile));
Input_RawFile_dedup := dedup(dsInput_RawFile,name,address,citystatezip,dob,race,sex,arrestdate,RIGHT,local);
//output(count(Input_RawFile_dedup));
Crim_Common.Layout_In_Court_Offender Map_offender(Input_RawFile_dedup L) := Transform
	
             
	self.process_date     := Crim_Common.Version_In_Arrest_Offender;
	self.offender_key			:= '3FA'+HASH(trim(L.name)+trim(L.DOB)+trim(L.arrestdate));
	self.vendor				    := '32'; 
	self.state_origin			:= 'FL';
	self.data_type				:= '5';
	self.source_file			:= 'FL_ALACHUA_ARREST';
	self.case_number			:= '';
	self.case_court			  := '';
	self.case_name				:= '';
	self.case_type				:=
	'';
	self.case_type_desc		:= '';
	
	string v_case_dt      := '';
	
	self.case_filing_dt		:= '';
															
	self.pty_nm				    := trim(L.name);
	self.pty_nm_fmt			  := 'L';
	self.orig_lname			  := '';
	self.orig_fname			  := '';    
	self.orig_mname			  := '';
	self.orig_name_suffix	:= '';
	self.pty_typ				  := '0';
	self.nitro_flag			  := '';
	self.orig_ssn				  := '';
	self.dle_num				  := '';
	self.fbi_num				  := '';
	self.doc_num				  := '';
	self.ins_num				  := '';
	self.id_num				    := '';
  self.dl_num           := '';
	self.dl_state				  := '';
	self.citizenship		  := '';
	self.dob					    := IF(Function_ParseDate(TRIM(L.DOB,right),'MMDDYYYY') >= '19000101'  and 
	                            ((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)Function_ParseDate(TRIM(L.DOB,right),'MMDDYYYY')[1..4])>=18,
									            Function_ParseDate(TRIM(L.DOB,right),'MMDDYYYY'),'');
	self.dob_alias				:= '';
	self.place_of_birth	  := '';

	self.street_address_1	:= TRIM(L.address);
	self.street_address_2	:= '';
	self.street_address_3	:= StringLib.StringCleanSpaces(L.citystatezip);
  self.street_address_4	:= ''; 
  self.street_address_5	:= '';
	self.race					    := L.race;
	self.race_desc		    := 	CASE(stringlib.stringtouppercase(L.race),
																'W'  => 'White(includes Mexicans)',
																'B'  => 'Black',
															  'O'  =>	'Oriental/Asian',
                                'I'  =>	'American Indian or Alaskan Native',
                                'N'  =>	'',
			                          ''
			                          );
	self.sex					    := MAP(trim(L.sex,all)[1..1] ='M' => 'M',
	                             trim(L.sex,all)[1..1] ='F' => 'F', '');	 //Field is not populated
  self                  := [];
end;

P_FLAR_Offender := PROJECT(Input_RawFile_dedup, Map_offender(left));

Crim.Crim_clean(P_FLAR_Offender,clean_FLAR_Offender);
SFLAR_Offender     := sort(clean_FLAR_Offender,offender_key,lname,fname,mname,name_suffix,pty_typ,prim_range, predir, addr_suffix, postdir, unit_desig, sec_range, zip5);
FLAR_Offender_dedup:= dedup(SFLAR_Offender, offender_key,lname,fname,mname,name_suffix,prim_range, predir, addr_suffix, postdir, unit_desig, sec_range, zip5); 


export Map_FL_Alachua_Arrest_Offender := FLAR_Offender_dedup : persist ('~thor_dell400::persist::Crim_FL_Alachua_Arrest_Offender');