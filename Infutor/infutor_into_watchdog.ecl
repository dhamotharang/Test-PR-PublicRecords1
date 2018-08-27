import watchdog , header,ut ; 

infutor_tracker_in := Infutor.File_Infutor_DID(did > 0  and name_type[1] ='O' and addr_type[1] ='O') ; 
// ***  MAG 8/26/2018 - made change to get the current date from file as the attribute was deprecated
infutor_cversion := Infutor._config.get_cversion_dev;
header.layout_header reformat(infutor.infutor_layout_main.layout_base_tracker l,unsigned6 c) := transform

	self.did := l.did;
	self.rid := 999999999999 + c;
	self.pflag1 := '';
    self.pflag2 := '';
    self.pflag3 := ''; 
	self.src := 'IF';
	self.dt_first_seen := if( (unsigned3)l.last_activity_dt[1..6] < (unsigned3)l.effective_dt[1..6] , (unsigned3)l.last_activity_dt[1..6],  (unsigned3)l.effective_dt[1..6]); 
	self.dt_last_seen :=  if( (unsigned3)l.last_activity_dt[1..6] < (unsigned3)l.effective_dt[1..6] ,(unsigned3)l.effective_dt[1..6], (unsigned3)l.last_activity_dt[1..6]);
	self.dt_vendor_last_reported := (unsigned3)infutor_cversion [1..6];
	self.dt_vendor_first_reported := (unsigned3)infutor_cversion [1..6];
	self.dt_nonglb_last_seen := 0;
	self.rec_type := '' ; // there are some old addresses in original address field
	self.vendor_id := (qstring18)l.boca_id;
	self.dob := (integer4)l.orig_dob_dd_appended;
	self.phone := if(length(trim(l.phone,left,right)) not in [7,10]
		                ,'',Header.fn_blank_bogus_phones(l.phone));
    self.ssn := if(stringlib.stringfilterout(l.ssn, '0') ='' or l.ssn in ut.Set_BadSSN ,'',l.ssn);
					
	self.title := l.title;
	self.fname := l.fname;
	self.lname := l.lname;
	self.mname := l.mname;
	self.name_suffix := l.name_suffix;
	self.prim_range := l.prim_range;
	self.predir := l.predir;
	self.prim_name := l.prim_name;
	self.suffix := l.addr_suffix;
	self.postdir := l.postdir;
	self.unit_desig := l.unit_desig;
	self.sec_range := l.sec_range;
	self.city_name := l.v_city_name;
	self.st := l.st;
	self.zip := l.zip;
	self.zip4 := l.zip4;
	self.county := l.county[3..5];
	string3 msa_temp := l.msa;
	self.cbsa := if(msa_temp!='',msa_temp + '0','');
	self.geo_blk := l.geo_blk;
	self.tnt := '';
	self.valid_ssn := '';
	self.jflag1 := '';
	self.jflag2 := '';
	self.jflag3 := '';
	self.RawAID := l.RawAID ; 
	end;

dinfutorasSource0 := project(infutor_tracker_in, reformat(left,counter));
dinfutorasSource_dist := distribute(dinfutorasSource0,hash(did,vendor_id));
dinfutorasSource_sort := sort(dinfutorasSource_dist,did,vendor_id,fname,mname,lname,name_suffix,ssn,dob,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,county,phone,rec_type,RawAID,local);

header.layout_header t_rollup(dinfutorasSource_sort le, dinfutorasSource_sort ri) := transform
 self.dt_first_seen            := ut.Min2(le.dt_first_seen,ri.dt_first_seen);
 self.dt_last_seen             := ut.Max2(le.dt_last_seen,ri.dt_last_seen);
 self.dt_vendor_first_reported := ut.Min2(le.dt_vendor_first_reported,ri.dt_vendor_first_reported);
 self.dt_vendor_last_reported  := ut.Max2(le.dt_vendor_last_reported,ri.dt_vendor_last_reported);
 self                          := le;
end;

infutor_to_header := rollup(dinfutorasSource_sort,
                           left.did         = right.did         and 
                           left.vendor_id   = right.vendor_id   and
						   left.fname       = right.fname       and 
                           left.mname       = right.mname       and 
						   left.lname       = right.lname       and 
						   left.name_suffix = right.name_suffix and
						   left.ssn         = right.ssn         and 
						   left.dob         = right.dob         and 
                           if((left.prim_range  = right.prim_range  and 
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
						   left.county      = right.county)     or
						   (left.RawAID <>0 and right.RawAID<>0 and left.RawAID = right.RawAID),true,false) and 
						   left.phone       = right.phone       and
						   left.rec_type    = right.rec_type,
			       t_rollup(left,right),
				   local
				  );
				  
export infutor_into_watchdog := infutor_to_header ; 