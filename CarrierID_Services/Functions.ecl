import iesp,AutoStandardI, suppress;

export Functions := module
 
 export maskDL(layouts.r_payload_with_penalty in_row, boolean dl_mask_value) := function
		row_to_mask := dataset(row(in_row, layouts.r_payload_with_penalty));
		suppress.MAC_Mask(row_to_mask, row_masked, blank, driver_license_nbr, false, true);
		out_row := row(row_masked[1], layouts.r_payload_with_penalty);
 return out_row;
 end;
 
 export setsubject(layouts.r_payload_with_penalty in_rec, boolean is_driver = false, boolean is_passenger_or_otherparty = false) := function
    iesp.carrierid.t_CarrierIDSubject xform(layouts.r_payload_with_penalty le) := transform
				 self.driverlicensenumber := le.driver_license_nbr;
		     self.driverlicensestate  := le.dlnbr_st;
		     self.ssn                 := '';
				 self.dob                 := iesp.ecl2esp.todatestring8(le.dob);
         self.name                := iesp.ecl2esp.setnameandcompany(le.fname,if(is_passenger_or_otherparty, '', le.mname),le.lname,le.name_suffix,'','',if(is_driver, '',le.cname));
				 empty_address 						:= row([], iesp.share.t_Address);
				 self.address             := if(is_passenger_or_otherparty, empty_address, iesp.ecl2esp.setaddress(le.prim_name,le.prim_range,le.predir,le.postdir,le.addr_suffix,le.unit_desig,le.sec_range,le.v_city_name,le.st,le.zip,le.zip4,''));
				 self.partytype           := le.record_type;
				 self.did                 := (string) le.did;
				 self.bdid                := (string) le.b_did;
     end;
		out_rec := row(in_rec, xform(left));
    return out_rec;
  end;
 
 export translate_source(string in_src) := case(true,
						                              in_src in carrierid_services.constants.flacc_set        => carrierid_services.constants.str_flacc,
																					in_src in carrierid_services.constants.ecrash_set       => carrierid_services.constants.str_ecrash,
																					in_src in carrierid_services.constants.natl_keyed_set   => carrierid_services.constants.str_natlacc,
																					in_src in carrierid_services.constants.natl_inquiry_set => carrierid_services.constants.str_natlaccinq,																	
																					in_src in carrierid_services.constants.en_set           => carrierid_services.constants.str_en,
																					in_src in carrierid_services.constants.fs_set           => carrierid_services.constants.str_fs,
																					'Undefined');
												
end;