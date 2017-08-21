import header_services, business_header, AID, infutor, header ;


EXPORT infutor_reflection(dataset(infutor_layout_main.layout_base_tracker) ds_base) := function

Suppression_Layout 	:= header_services.Supplemental_Data.layout_in;
header_services.Supplemental_Data.mac_verify('ridinfutor_sup.txt',Suppression_Layout, base_sup_attr); //  
 
Base_infutor_sup_in := base_sup_attr() ;

base_infutor_sup := PROJECT(Base_infutor_sup_in ,header_services.Supplemental_Data.in_to_out(left));

ff_base := JOIN(ds_base, base_infutor_sup,
                hashmd5(intformat(left.did,15,1)) = right.hval OR
								hashmd5(left.ssn) = right.hval OR
								hashmd5(intformat(left.did,15,1), left.ssn) = right.hval, 
						    TRANSFORM(LEFT),
						    LEFT ONLY, ALL) ;
													

header_services.Supplemental_Data.mac_verify(	'file_infutor_inj.txt', 
																								infutor_layout_main.layout_base_tracker, 
																								attr );
	Bfile_in := attr();
	
	UNSIGNED6 endMax := MAX(ds_base, boca_id);
	
	layout_tmp :=record
	 Bfile_in ;
	 string25 city ;
	 string4 state ;
	end ;
	
	layout_tmp reformated_base(Bfile_in L, INTEGER c) := 
	transform	 
	self.boca_id := endMax + c ;
	self.city := if (L.p_city_name <> '', L.p_city_name, '');
	self.state := L.st ;
	self := L ;
	end ;


	base_reformated := project(Bfile_in, reformated_base(LEFT, counter) ); 
	
	business_header.macGetCleanAddr(base_reformated,  
											 prim_range, predir, prim_name, addr_suffix, postdir, unit_desig, 
											 sec_range, p_city_name, state, zip, zip4, RawAID, 
										   'false', 'false', Base_out); 
	
	base_file_out := distribute(Table(Base_out, {Base_out} - {state, city}), hash(did));
											 
	file_infutor_w_ssn := ff_base + base_file_out;

  return file_infutor_w_ssn;

end;