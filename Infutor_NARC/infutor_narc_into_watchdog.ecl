import watchdog , header,ut ; 

infutor_tracker_in := Infutor_narc.File_Infutor_Narc_DID(did > 0) ; 

header.layout_header reformat(infutor_narc.layouts.base l,unsigned6 c) := transform
	self.did := l.did;
	self.rid := 99999999999999 + c;
	self.src := '1F';
	self.dt_vendor_last_reported := (unsigned3)infutor_narc.version[1..6];
	self.dt_vendor_first_reported := (unsigned3)infutor_narc.version[1..6];
	self.rec_type := '' ; // there are some old addresses in original address field
	self.dob := (integer4)l.clean_dob;
	self.Phone := l.clean_phone;
	self.city_name:=l.v_city_name;
	self.suffix    :=l.addr_suffix;
	self.county:=l.fips_county;
  self:=l;
  self:=[];
	end;
					
	
dinfutorasSource0 := project(infutor_tracker_in, reformat(left,counter));
dinfutorasSource_dist := distribute(dinfutorasSource0,hash(did));
dinfutorasSource_sort := sort(dinfutorasSource_dist,did,fname,mname,lname,name_suffix,dob,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,county,phone,local);

header.layout_header t_rollup(dinfutorasSource_sort le, dinfutorasSource_sort ri) := transform
 self.dt_vendor_first_reported := ut.Min2(le.dt_vendor_first_reported,ri.dt_vendor_first_reported);
 self.dt_vendor_last_reported  := ut.Max2(le.dt_vendor_last_reported,ri.dt_vendor_last_reported);
 self                          := le;
end;

infutor_to_header := rollup(dinfutorasSource_sort,
               left.did         = right.did         and 
               left.fname       = right.fname       and 
               left.mname       = right.mname       and 
						   left.lname       = right.lname       and 
						   left.name_suffix = right.name_suffix and
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
						   left.phone       = right.phone       and
						   left.rec_type    = right.rec_type,
			       t_rollup(left,right),
				   local
				  );
infutor_to_header_final:=infutor_to_header(fname<>'',lname<>'',prim_name<>'');		  
				
export infutor_narc_into_watchdog := infutor_to_header_final;