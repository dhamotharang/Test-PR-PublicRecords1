import ut, Drivers;
  
t1 := Drivers.file_tx_raw;
t0 := DriversV2.File_DL_TX_Full2;

u1 := Drivers.file_texas_update;
u0 := DriversV2.File_DL_TX_Update2 + DriversV2.File_DL_TX_Update_Clean;

t2 := project(t0,
		     transform(DriversV2.Layouts_DL_TX_Full.Layout_TX_Full2,
			           self.dl_number := left.dl_number[3..];
					   self := left));
					   
u2 := project(u0,
			 transform(DriversV2.Layouts_DL_TX_Update.Layout_TX_Update2,
			           self.dl_number := left.dl_number[3..];					  
					   self := left));
					   
kill_dlnum1 := record
  u1.dl_number;
  u1.process_date;
end;

kill_dlnum2 := record
  u2.dl_number;
  u2.process_date;
end;

kill1 := table(u1(current_transaction = 'D' or current_transaction[1]='U'),kill_dlnum1);
kill2 := table(u2,kill_dlnum2);
kills := kill1 + kill2;

bad_names  := ['UNKNOWN','UNK','UNKN','NONE','N/A','UNAVAILABLE'];
bad_mnames := ['NMN','NMI'];

STRING remove_tilde(STRING input_name) := FUNCTION
  // In some of the old data, the ~ is surrounded by a space... have to deal with it first
	first_clean_pass := StringLib.StringFindReplace(input_name, ' ~ ', '');

	RETURN StringLib.StringFindReplace(first_clean_pass, '~', '');
END;

DriversV2.Layout_DL_Extended setFull1(t1 le) := transform
  self.orig_state       := 'TX';
  self.dt_first_seen    := (unsigned8)le.process_date div 100;
  self.dt_last_seen     := (unsigned8)le.process_date div 100;
  self.dt_vendor_first_reported := (unsigned8)le.process_date div 100;
  self.dt_vendor_last_reported  := (unsigned8)le.process_date div 100;
	self.dateReceived			:= (integer)le.process_date;
  self.name             := le.driver_name;
  self.RawFullName      := le.driver_name;	
  self.addr1            := le.street_address;
  self.city             := le.city_zipcode[..length(trim(le.city_zipcode))-5];
  self.state            := le.ace_state;
  self.zip              := le.city_zipcode[length(trim(le.city_zipcode))-4..];
  self.dob              := ut.Date_MMDDYYYY_i2(le.date_of_birth);
  self.license_class    := le.class;
  self.license_type     := le.last_transaction;
  self.OrigLicenseClass := '';
  self.OrigLicenseType  := le.class;	
  self.moxie_license_type     := le.class;
  self.title            := le.name_title;
  self.fname            := if (trim(le.name_first,left,right) in bad_names,'',le.name_first);
  self.mname            := if (trim(le.name_middle,left,right) in bad_names + bad_mnames,'',le.name_middle);
  self.lname            := if (trim(le.name_last,left,right) in bad_names,'',le.name_last);
  self.name_suffix      := le.name_suffix;
  self.cleaning_score   := le.name_score;
  self.st               := le.ace_state;
  self.zip5             := le.ace_zip;
  self.zip4             := le.ace_zip4;
  self.rec_type         := le.ace_rec_type;
  self.county           := le.ace_county;
  self.issuance         := '';
  self                  := le;
end;

DriversV2.Layout_DL_Extended setFull2(t2 le) := transform
  self.orig_state       := 'TX';
  self.dt_first_seen    := (unsigned8)le.process_date div 100;
  self.dt_last_seen     := (unsigned8)le.process_date div 100;
  self.dt_vendor_first_reported := (unsigned8)le.process_date div 100;
  self.dt_vendor_last_reported  := (unsigned8)le.process_date div 100;
	self.dateReceived			:= (integer)le.process_date;
  self.name             := trim(le.last_name,left,right) + 
						   ', ' + 
						   trim(le.first_name,left,right) + 
						   ' ' +
						   trim(le.middle_name,left,right) +
						   ' ' +
						   trim(le.suffix_name,left,right);
  self.RawFullName      :=  trim(le.last_name,left,right) + 
															', ' + 
														trim(le.first_name,left,right) + 
															' ' +
														trim(le.middle_name,left,right) +
															' ' +
														trim(le.suffix_name,left,right);							 
  self.addr1            := trim(le.street_addr1,left,right) +
						   ' ' +
						   trim(le.street_addr2,left,right);
  self.city             := le.city;
  self.state            := le.ace_state;
  self.zip              := le.zip;
  self.dob              := ut.Date_MMDDYYYY_i2(le.date_of_birth);
  self.license_class    := if(le.card_type[1]='I','I','');
  self.moxie_license_type     := if(le.card_type[1]='I','I','');
  self.license_type     := '';
  self.OrigLicenseClass := '';
  self.OrigLicenseType  := le.card_type;		
  self.title            := le.name_title;
  self.fname            := if (trim(le.first_name,left,right) in bad_names,'',remove_tilde(le.first_name));
  self.mname            := if (trim(le.middle_name,left,right) in bad_names + bad_mnames,'',remove_tilde(le.middle_name));
  self.lname            := if (trim(le.last_name,left,right) in bad_names,'',remove_tilde(le.last_name));
  self.name_suffix      := le.name_suffix;
  self.cleaning_score   := le.name_score;
  self.st               := le.ace_state;
  self.zip5             := le.ace_zip;
  self.zip4             := le.ace_zip4;
  self.rec_type         := le.ace_rec_type;
  self.county           := le.ace_county;
  self.issuance         := '';
  self.lic_issue_date   := ut.Date_MMDDYYYY_i2(le.issue_date);
  self                  := le;
end;

DriversV2.Layout_DL_Extended setUpdates1(u1 le) := transform
  self.orig_state       := 'TX';
  self.dt_first_seen    := (unsigned8)le.process_date div 100;
  self.dt_last_seen     := (unsigned8)le.process_date div 100;
  self.dt_vendor_first_reported := (unsigned8)le.process_date div 100;
  self.dt_vendor_last_reported  := (unsigned8)le.process_date div 100;
	self.dateReceived			:= (integer)le.process_date;	
  self.name             := le.new_driver_name;
  self.RawFullName      := le.new_driver_name;	
  self.addr1            := le.new_street_address;
  self.city             := le.new_city_zipcode[..length(trim(le.city_zipcode))-5];
  self.state            := le.new_state;
  self.zip              := le.new_city_zipcode[length(trim(le.city_zipcode))-4..];
  self.dob              := ut.Date_MMDDYYYY_i2(le.new_date_of_birth);
  self.license_class    := le.new_class;
  self.license_type     := le.new_current_transaction;
  self.OrigLicenseClass	:= '';
  self.OrigLicenseType	:= le.new_class;	
  self.title            := le.new_title;
  self.fname            := if (trim(le.new_fname,left,right) in bad_names,'',le.new_fname);
  self.mname            := if (trim(le.new_mname,left,right) in bad_names + bad_mnames,'',le.new_mname);
  self.lname            := if (trim(le.new_lname,left,right) in bad_names,'',le.new_lname);
  self.name_suffix      := le.new_suffix;
  self.cleaning_score   := le.new_name_score;
  self.prim_range       := le.new_prim_range;
  self.sec_range        := le.new_sec_range;
  self.prim_name        := le.new_prim_name;
  self.p_city_name      := le.new_p_city_name;
  self.v_city_name      := le.new_v_city_name;
  self.cart             := le.new_cart;
  self.predir           := le.new_predir;
  self.postdir          := le.new_postdir;
  self.suffix           := le.new_addr_suffix;
  self.unit_desig       := le.new_unit_desig;
  self.st               := le.new_state;
  self.zip5             := le.new_zip5;
  self.zip4             := le.new_zip4;
  self.lot              := le.new_lot;
  self.lot_order        := le.new_lot_order;
  self.cr_sort_sz       := le.new_cr_sort_sz;
  self.chk_digit        := le.new_chk_digit;
  self.geo_lat          := le.new_geo_lat;
  self.geo_blk          := le.new_geo_blk;
  self.geo_long         := le.new_geo_long;
  self.geo_match        := le.new_geo_match;
  self.err_stat         := le.new_err_stat;
  self.rec_type         := le.new_rec_type;
  self.county           := le.new_county;
  self.issuance         := '';
  self.dl_number        := le.new_dl_number;
end;

DriversV2.Layout_DL_Extended setUpdates2(u2 le) := transform
  self.orig_state       := 'TX';
  self.dt_first_seen    := (unsigned8)le.process_date div 100;
  self.dt_last_seen     := (unsigned8)le.process_date div 100;
  self.dt_vendor_first_reported := (unsigned8)le.process_date div 100;
  self.dt_vendor_last_reported  := (unsigned8)le.process_date div 100;
	self.dateReceived			:= (integer)le.process_date;	
  self.name             := trim(le.last_name,left,right) + 
						   ', ' + 
						   trim(le.first_name,left,right) + 
						   ' ' +
						   trim(le.middle_name,left,right) +
						   ' ' +
						   trim(le.suffix_name,left,right);
  self.RawFullName      := trim(le.last_name,left,right) + 
						   ', ' + 
						   trim(le.first_name,left,right) + 
						   ' ' +
						   trim(le.middle_name,left,right) +
						   ' ' +
						   trim(le.suffix_name,left,right);							 
  self.addr1            := trim(le.street_addr1,left,right) +
						   ' ' +
						   trim(le.street_addr2,left,right);
  self.city             := le.city;
  self.state            := le.in_state;
  self.zip              := le.zip;
  self.dob              := ut.Date_MMDDYYYY_i2(le.date_of_birth);
  self.license_class    := if(le.card_type[1]='I','I','');
  self.license_type     := '';
  self.OrigLicenseClass	:= '';
  self.OrigLicenseType	:= le.card_type;	
  self.title            := le.title;
  self.fname            := if (trim(le.first_name,left,right) in bad_names,'',remove_tilde(le.first_name));
  self.mname            := if (trim(le.middle_name,left,right) in bad_names + bad_mnames,'',remove_tilde(le.middle_name));
  self.lname            := if (trim(le.last_name,left,right) in bad_names,'',remove_tilde(le.last_name));
  self.name_suffix      := le.suffix;
  self.cleaning_score   := le.name_score;
  self.prim_range       := le.prim_range;
  self.sec_range        := le.sec_range;
  self.prim_name        := le.prim_name;
  self.p_city_name      := le.p_city_name;
  self.v_city_name      := le.v_city_name;
  self.cart             := le.cart;
  self.predir           := le.predir;
  self.postdir          := le.postdir;
  self.suffix           := le.addr_suffix;
  self.unit_desig       := le.unit_desig;
  self.st               := le.state;
  self.zip5             := le.zip5;
  self.zip4             := le.zip4;
  self.lot              := le.lot;
  self.lot_order        := le.lot_order;
  self.cr_sort_sz       := le.cr_sort_sz;
  self.chk_digit        := le.chk_digit;
  self.geo_lat          := le.geo_lat;
  self.geo_blk          := le.geo_blk;
  self.geo_long         := le.geo_long;
  self.geo_match        := le.geo_match;
  self.err_stat         := le.err_stat;
  self.rec_type         := le.rec_type;
  self.county           := le.county;
  self.issuance         := '';
  self.dl_number        := le.dl_number;
  self.lic_issue_date   := (unsigned4) (le.issue_date[5..8] + le.issue_date[1..4]);
end;

updates1 := project(u1(current_transaction[1] = 'O' or current_transaction[1] = 'U'),setUpdates1(left));
updates2 := project(u2(trans_indicator = 'U'),setUpdates2(left));

full1 := project(t1,setFull1(left));
full2 := project(t2,setFull2(left));

in_stream := full1 + full2 + updates1 + updates2;

DriversV2.Layout_DL_Extended Killed(in_stream le, kills ri) := transform
  self.history := IF( ri.dl_number='','','H');
  self := le;
end;

out_stream := join(in_stream,kills,left.dl_number=right.dl_number and
				   left.dt_first_seen < (unsigned8)right.process_date div 100,
  	               killed(left,right), left outer)  : persist(DriversV2.Constants.Cluster + 'Persist::DL2::DrvLic_TX_as_DL');
			 
export Tx_as_Dl := out_stream;
										