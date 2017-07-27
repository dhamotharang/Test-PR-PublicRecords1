import ut, header_services, doxie,_Control,header;

//compare to glb data and set flags
watchdog.Layout_best_flags flags(watchdog.layout_best L, watchdog.Layout_Best R) := transform
 self.glb_name := if(datalib.leadmatch(l.fname,r.fname)=0 or 
					datalib.preferredfirst(l.fname)!=datalib.preferredfirst(r.fname),'N','Y');
 self.glb_address := if(l.prim_range!=r.prim_range or l.prim_name!=r.prim_name or
						~ut.NNEQ(l.sec_range,r.sec_range) or
						 l.zip!=r.zip,'N','Y'); 
 self.glb_ssn := if(l.ssn!=r.ssn or 
					((integer)(r.ssn[1..5])=0 and l.ssn[6..9]!=r.ssn[6..9]),'N','Y');
 self.glb_dob := if(datalib.leadmatch((string)l.dob,(string)r.dob)=0,'N','Y');
 self.glb_phone := if(l.phone!=r.phone,'N','Y');
 self := r;
end;

string_rec := record
	watchdog.Layout_Best;
	string1 		glb_name := 'Y';
  string1 		glb_address := 'Y';
  string1 		glb_dob := 'Y';
  string1 		glb_ssn := 'Y';
  string1 		glb_phone := 'Y';
  unsigned8 filepos := 0;
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
  self := L;
end;


Base_File_Append_out := project(Base_File_Append_In, reformat_layout(left)); 

//append ADL indicator
watchdog.mac_append_ADL_ind(base_file_append_out, Base_File_Append); 

glb := watchdog.File_Best;
non_glb := watchdog.File_Best_nonglb;

set_Flags := join(glb,non_glb,left.did=right.did,flags(left,right),local);

t0 := join(set_Flags,
					Base_File_Append,
          left.did = right.did,
					left only,
					lookup);

wdog := t0 + Base_File_Append;

candidates := distribute(wdog(trim(fname)='' or trim(lname)=''),hash(did));
not_candidates := wdog(~(trim(fname)='' or trim(lname)=''));
glb_pst        := distribute(dataset('~thor400_84::out::watchdog_filtered_header_nonglb',header.layout_header,flat),hash(did));;

header.layout_header t1(glb_pst le, candidates ri) := transform
 self := le;
end;

j1 := join(glb_pst,candidates
			,left.did=right.did
			,t1(left,right)
			,local);

//only fix those that need fixing
bestFirstLast	:=	fn_BestFirstLastName(j1);

watchdog.Layout_best_flags tr(candidates l,bestFirstLast r) := transform
	self.fname	:=	if(l.fname='',r.fname,l.fname);
	self.lname	:=	if(l.lname='',r.lname,l.lname);
	self        := l;
end;

fb0:=join(candidates,bestFirstLast
			,left.did=right.did
			,tr(left,right)
			,left outer
			,local);

concat := fb0+not_candidates;

//only fix those that need fixing
candidates1 := distribute(concat(trim(ssn)=''),hash(did));
not_candidates1 := concat(~(trim(ssn)=''));

j2 := join(glb_pst,candidates1
			,left.did=right.did
			,t1(left,right)
			,local);

_bestSSN	:=	watchdog.fn_best_ssn(j2).concat_them;

watchdog.Layout_best_flags tr0(candidates1 l,_bestSSN r) := transform
	self.ssn	:=	if(l.ssn='',r.ssn,l.ssn);
	self        :=	l;
end;

fb00:=join(candidates1,_bestSSN
			,left.did=right.did
			,tr0(left,right)
			,left outer
			,local);

_fb := fb00+not_candidates1;
ut.mac_suppress_by_phonetype(_fb,phone,st,fb,true,did);

export Key_Prep_Watchdog_nonglb := index(fb,{fb},'~thor_data400::key::watchdog_nonglb.did_'+doxie.Version_SuperKey);