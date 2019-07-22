﻿import lib_fileservices, ut, header_services, doxie,_Control,header,Data_Services, vault;

string_rec := record
	watchdog.Layout_Best;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

Drop_Header_Layout := 
record
	string15    did := '0';
	string10    phone := '';
	string9     ssn := '';
	string10     dob := '0';
	string5     title := '';
	string20    fname := '';
	string20    mname := '';
	string20    lname := '';
	string5     name_suffix := '';
	string10    prim_range := '';
	string2      predir := '';
	string28    prim_name := '';
	string4     suffix := '';
	string2      postdir := '';
	string10    unit_desig := '';
	string8     sec_range := '';
	string25    city_name := '';
	string2      st := '';
	string5     zip := '';
	string4     zip4 := '';
	string8    addr_dt_last_seen := '0';
	string8	 DOD := '';
	string17    Prpty_deed_id := '';
	string22    Vehicle_vehnum := '';
	string22  	 Bkrupt_CrtCode_CaseNo := '';
	string10     main_count := '0';
	string10     search_count := '0';
	string15	 DL_number := '';
	string12     bdid := '';
	string10     run_date := '0';
	string10	 total_records := '0';
	string2      EOR := '';
end;

header_services.Supplemental_Data.mac_verify('file_best_inj.txt', drop_header_layout, attr);

Base_File_Append_In := attr();

string_rec reformat_layout(Base_File_Append_In L) := 
 transform
	self.did := (unsigned6) L.did;
	self.dob := (integer4) L.dob;
	self.title  := trim(l.title ,left,right);
	self.fname  := trim(l.fname ,left,right);
	self.mname  := trim(l.mname ,left,right);
	self.lname  := trim(l.lname ,left,right);
	self.name_suffix  := trim(l.name_suffix ,left,right);
	self.prim_range  := trim(l.prim_range ,left,right);
	self.predir  := trim(l.predir ,left,right);
	self.prim_name  := trim(l.prim_name ,left,right);
	self.suffix  := trim(l.suffix ,left,right);
	self.postdir  := trim(l.postdir ,left,right);
	self.unit_desig  := trim(l.unit_desig ,left,right);
	self.sec_range  := trim(l.sec_range ,left,right);
	self.city_name  := trim(l.city_name ,left,right);
	self.addr_dt_last_seen := (unsigned3) L.addr_dt_last_seen;
	self.main_count := (integer4) L.main_count;
	self.search_count := (integer4) L.search_count;
	self.run_date := (integer4) L.run_date;
	self.total_records := (integer4) L.total_records;
	self.__filepos := 0;
    self := L;
 end;

Base_File_Append_out := project(Base_File_Append_In, reformat_layout(left)); 

//append ADL indicator
watchdog.mac_append_ADL_ind(Base_File_Append_out, Base_File_Append);

main_dataset := dataset('~thor_data400::base::watchdog_best_nonen',string_rec,flat) + Base_File_Append;
 
t0 := join(main_dataset,
					Base_File_Append,
          left.did = right.did,
					left only,
					lookup);

_t1 := t0 + Base_File_Append;
ut.mac_suppress_by_phonetype(_t1,phone,st,t1,true,did);


#IF(_Control.Environment.onVault) 
export Key_Watchdog_GLB_nonExperian := ungroup(vault.Watchdog.Key_Watchdog_GLB_nonExperian);
#ELSE
export Key_Watchdog_GLB_nonExperian := INDEX(t1,{t1},data_services.data_location.prefix() + 'thor_data400::key::watchdog_best_nonen.did_'+doxie.Version_SuperKey);
#END;
