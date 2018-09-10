import header_services, business_header, AID, infutor, header, ut ;


EXPORT infutor_reflection_header(dataset(header.layout_header) ds_Xform) := function

///


Suppression_Layout 	:= header_services.Supplemental_Data.layout_in;
header_services.Supplemental_Data.mac_verify('ridinfutor_sup.txt',Suppression_Layout, base_sup_attr); // 
 
Base_infutor_sup_in := base_sup_attr() ;

base_infutor_sup := PROJECT(Base_infutor_sup_in ,header_services.Supplemental_Data.in_to_out(left)); 

ff_base := JOIN(ds_Xform, base_infutor_sup,
                hashmd5(intformat(left.did,15,1)) = right.hval OR
								hashmd5(left.ssn) = right.hval OR
								hashmd5(intformat(left.did,15,1), left.ssn) = right.hval, 
						    TRANSFORM(LEFT),
						    LEFT ONLY, ALL) ;
													

header_services.Supplemental_Data.mac_verify(	'file_infutor_inj.txt', 
																								infutor_layout_main.layout_base_tracker	, 
																								attr );
	Bfile_in := attr();
	
	UNSIGNED6 endMax := MAX(ds_Xform(intformat(rid, 14, 0)[1..2] = '15' and length(trim(intformat(rid, 14, 0))) = 14), rid);
	
	header.layout_header reformat(infutor.infutor_layout_main.layout_base_tracker l, integer c) := transform

/* //check date validity by length, number values, and between 1901 and today */  
  cversion_dev := infutor._config.get_cversion_dev; 

Valid_Date_Range(string in_date) := in_date[1..6] between '190101' and ut.GetDate[1..6];
	self.did := l.did;
	self.rid := endMax + c;
	self.src := 'IF';
	self.dt_last_seen := map(l.addr_type='O' => max((unsigned)l.last_activity_dt[1..6],(unsigned)l.effective_dt[1..6]), 
							 stringlib.stringtouppercase(l.addr_type) = 'P1' => (unsigned)l.prev1_addr_effective_dt[1..6],
							 stringlib.stringtouppercase(l.addr_type) = 'P2' => (unsigned)l.prev2_addr_effective_dt[1..6],
							 stringlib.stringtouppercase(l.addr_type) = 'P3' => (unsigned)l.prev3_addr_effective_dt[1..6],
							 stringlib.stringtouppercase(l.addr_type) = 'P4' => (unsigned)l.prev4_addr_effective_dt[1..6],
							 stringlib.stringtouppercase(l.addr_type) = 'P5' => (unsigned)l.prev5_addr_effective_dt[1..6],
							 0);
	self.dt_first_seen := map(l.addr_type='O' => (unsigned)l.effective_dt[1..6], self.dt_last_seen);
	self.dt_vendor_last_reported := (unsigned)cversion_dev[1..6];
	self.dt_vendor_first_reported := (unsigned)cversion_dev[1..6];
	self.dt_nonglb_last_seen := 0;
	self.vendor_id := (qstring18)l.boca_id;
	self.dob := (integer4)l.orig_dob_dd_appended;
	self.suffix := l.addr_suffix;
	self.city_name := l.v_city_name; // changed from p to v as v is used in other examples and is completely spelled out
	self.rec_type := '';
	self.county := l.county[3..];
	self := l;
end;

 base_reformated := distribute(project(Bfile_in, reformat(left, counter)), hash(did));
 
 header.macGetCleanAddr(base_reformated , RawAID , 'true' , base_file_out) ;
												 
	file_infutor_to_header := ff_base + base_file_out ;

  return file_infutor_to_header ;

end ;