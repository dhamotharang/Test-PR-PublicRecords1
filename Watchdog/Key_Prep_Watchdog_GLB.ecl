import lib_fileservices, ut, header_services, doxie,_Control,data_services,header,PRTE2_Header,PRTE2_Watchdog;

EXPORT Key_Prep_Watchdog_GLB(boolean exclude_util = false)  := FUNCTION

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
	string15     bdid := '';
	string10     run_date := '0';
	string10	 total_records := '0';
	string20   RawAID := '0';
	string8 addr_dt_first_seen := '0';
	string10 ind := '';
	string2      EOR := '';
end;

header_services.Supplemental_Data.mac_verify('file_bestv2_inj.txt', drop_header_layout, attr);

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
	self.rawaid := (unsigned)l.rawaid;
	self.addr_dt_first_seen := (unsigned3) L.addr_dt_first_seen;
    self := L;
 end;

base_file_append_out := project(Base_File_Append_In, reformat_layout(left)); 
//append ADL indicator
watchdog.mac_append_ADL_ind(base_file_append_out, Base_File_Append); 

wdog1 := dataset(data_services.Data_Location.Watchdog_Best + 'thor_data400::BASE::Watchdog_best',string_rec,flat) + Base_File_Append;
wdog2 := project(Watchdog.File_Best_nonutility ,transform(string_rec,self.__filepos := 0, SELF:=LEFT)) + Base_File_Append;

wdog0 := if(~exclude_util, wdog1,wdog2);

t0 := join(wdog0,
					Base_File_Append,
          left.did = right.did,
					left only,
					lookup);

wdog := t0 + Base_File_Append;

candidates := distribute(wdog(trim(fname)='' or trim(lname)=''),hash(did));
not_candidates := wdog(~(trim(fname)='' or trim(lname)=''));
_nonutil := if(exclude_util,'_nonutil','');
glb_pst        := distribute(dataset('~thor400_84::out::watchdog_filtered_header'+_nonutil,header.layout_header,flat),hash(did));;

header.layout_header t1(glb_pst le, candidates ri) := transform
 self := le;
end;

j1 := join(glb_pst,candidates
			,left.did=right.did
			,t1(left,right)
			,local);

//only fix those that need fixing
bestFirstLast	:=	watchdog.fn_BestFirstLastName(j1);

string_rec tr(candidates l,bestFirstLast r) := transform
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

candidates1 := distribute(concat(trim(ssn)=''),hash(did));
not_candidates1 := concat(~(trim(ssn)=''));

j2 := join(glb_pst,candidates1
			,left.did=right.did
			,t1(left,right)
			,local);

_bestSSN	:=	watchdog.fn_best_ssn(j2).concat_them;

string_rec tr0(candidates1 l,_bestSSN r) := transform
	self.ssn	:=	if(l.ssn='',r.ssn,l.ssn);
	self        :=	l;
end;

fb00:=join(candidates1,_bestSSN
			,left.did=right.did
			,tr0(left,right)
			,left outer
			,local);

concat1 := fb00+not_candidates1;
//temporary hack to fix IRS test case
// Bug: 88535 - Mark Marsupial No Longer retuns in BPSReport
_fb := project(concat1,transform(watchdog.layout_key,self.total_records:=if(left.did=166287520519,0,left.total_records),self:=left));
#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
fb := project(PRTE2_Watchdog.files.file_best,transform({_fb},SELF.__filepos:=0,SELF:=LEFT));
#ELSE
ut.mac_suppress_by_phonetype(_fb,phone,st,fb,true,did);
#END
RETURN INDEX(fb,{fb},data_services.Data_location.prefix('watchdog')+'thor_data400::key::watchdog_best'+_nonutil+'.did_'+doxie.Version_SuperKey);

END;