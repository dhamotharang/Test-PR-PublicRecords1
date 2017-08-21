import header, did_add, header_slimsort, ut, didville, fair_isaac,_control;
import nid as nnid;

recfrmt := record
	header.Layout_New_Records;
	unsigned6	seq := 0;
end;

infile := sequenced();

matchset := ['A','S','P'];
did_Add.MAC_Match_Flex
	(infile, matchset,						
	 ssn, dob, fname, mname,lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st, phone, 
	 DID, recfrmt, false, DID_Score_field,							
	 75, truout)

header.layout_header slimUT(truout L) := transform
 self := l;
end;

DID_into_header0 := project(truout,slimUT(left)) : persist('~thor_data400::persist::utility_DID'/*,'thor400_20'*/);

dutilasSource_dist := distribute(DID_into_header0,hash(did));
dutilasSource_sort := sort(dutilasSource_dist,did,/*vendor_id,*/fname/*,mname*/,lname,name_suffix,ssn,dob,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,county/*,phone*/,rec_type,local);

header.layout_header t_rollup(dutilasSource_sort le, dutilasSource_sort ri) := transform
 self.dt_first_seen            := ut.Min2(le.dt_first_seen,ri.dt_first_seen);
 self.dt_last_seen             := max    (le.dt_last_seen,ri.dt_last_seen);
 self.dt_vendor_first_reported := ut.Min2(le.dt_vendor_first_reported,ri.dt_vendor_first_reported);
 self.dt_vendor_last_reported  := max    (le.dt_vendor_last_reported,ri.dt_vendor_last_reported);
 self.mname                    := if(length(trim(le.mname))>length(trim(ri.mname)),le.mname,ri.mname);
 self.phone                    := if(le.phone <>'' ,le.phone ,ri.phone); 
 self                          := le;
end;

util_to_watchdog := rollup(dutilasSource_sort,
                           left.did         = right.did         and 
						   left.fname       = right.fname       and 
                           left.lname       = right.lname       and 
						   left.name_suffix = right.name_suffix and
						   left.ssn         = right.ssn         and 
						   left.dob         = right.dob         and 
                           left.prim_range  = right.prim_range  and 
						   left.predir      = right.predir      and
						   left.prim_name   = right.prim_name   and
						   left.suffix      = right.suffix      and
						   left.postdir     = right.postdir     and
						   left.unit_desig  = right.unit_desig  and
						   left.sec_range   = right.sec_range   and 
						   left.city_name   = right.city_name   and
						   left.st          = right.st          and
						   left.zip         = right.zip         and
						   left.zip4        = right.zip4        and
						   left.county      = right.county      and
						   left.rec_type    = right.rec_type and 
						   nnid.firstname_match(left.mname,right.mname)>0 and 
						   ut.NNEQ_Phone(left.phone,right.phone)  ,
			       t_rollup(left,right),
				   local
				  );
export DID_into_header := util_to_watchdog  ; 