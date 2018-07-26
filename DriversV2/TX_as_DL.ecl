import ut;

export TX_as_DL(dataset(DriversV2.Layouts_DL_TX_Update.Layout_DL_TX_Update2) in_file):=function
					   
	u := project(in_file,
							 transform(DriversV2.Layouts_DL_TX_Update.Layout_TX_Update2,
												 self.dl_number := left.dl_number[3..];					  
												 self := left)
							 );

	kill_dlnum := record
	  u.dl_number;
	  u.process_date;
	end;

	kills := table(u,kill_dlnum);

	bad_names  := ['UNKNOWN','UNK','UNKN','NONE','N/A','UNAVAILABLE'];
	bad_mnames := ['NMN','NMI'];

	STRING remove_tilde(STRING input_name) := FUNCTION
	
	  // In some of the old data, the ~ is surrounded by a space... have to deal with it first
		first_clean_pass := StringLib.StringFindReplace(input_name, ' ~ ', '');
		RETURN StringLib.StringFindReplace(first_clean_pass, '~', '');
		
	END;

	DriversV2.Layout_DL_Extended setUpdates2(u le) := transform
	
	  self.orig_state       				:= 'TX';
	  self.dt_first_seen    				:= (unsigned8)le.process_date div 100;
	  self.dt_last_seen     				:= (unsigned8)le.process_date div 100;
	  self.dt_vendor_first_reported := (unsigned8)le.process_date div 100;
	  self.dt_vendor_last_reported  := (unsigned8)le.process_date div 100;
		self.dateReceived							:= (integer)le.process_date;	
	  self.name             				:= trim(le.last_name,left,right)   +  ', ' + 
																		 trim(le.first_name,left,right)  +  ' '  + 
																		 trim(le.middle_name,left,right) + ' ' + 
																		 trim(le.suffix_name,left,right) ;
	  self.RawFullName     				  := trim(le.last_name,left,right)  + ', ' + 
																		 trim(le.first_name,left,right) + ' '  +
																		 trim(le.middle_name,left,right)+ ' '  +
																	   trim(le.suffix_name,left,right);							 
	  self.addr1            			 := trim(le.street_addr1,left,right)+ ' ' +
																	  trim(le.street_addr2,left,right);
	  self.city             			 := le.city;
	  self.state            			 := le.in_state;
	  self.zip              			 := le.zip;
	  self.dob              			 := ut.Date_MMDDYYYY_i2(le.date_of_birth);
	  self.license_class    			 := if(le.card_type[1]='I','I','');
	  self.license_type     			 := '';
	  self.OrigLicenseClass				 := '';
	  self.OrigLicenseType				 := le.card_type;	
	  self.title            			 := le.title;
	  self.fname            			 := if (trim(le.first_name,left,right) in bad_names,'',remove_tilde(le.first_name));
	  self.mname            			 := if (trim(le.middle_name,left,right) in bad_names + bad_mnames,'',remove_tilde(le.middle_name));
	  self.lname            			 := if (trim(le.last_name,left,right) in bad_names,'',remove_tilde(le.last_name));
	  self.name_suffix      			 := le.suffix;
	  self.cleaning_score   			 := le.name_score;
	  self.prim_range       			 := le.prim_range;
	  self.sec_range        			 := le.sec_range;
	  self.prim_name        			 := le.prim_name;
	  self.p_city_name      			 := le.p_city_name;
	  self.v_city_name      			 := le.v_city_name;
	  self.cart             			 := le.cart;
	  self.predir           			 := le.predir;
	  self.postdir          			 := le.postdir;
	  self.suffix           			 := le.addr_suffix;
	  self.unit_desig       			 := le.unit_desig;
	  self.st               			 := le.state;
	  self.zip5             			 := le.zip5;
	  self.zip4             			 := le.zip4;
	  self.lot              			 := le.lot;
	  self.lot_order        			 := le.lot_order;
	  self.cr_sort_sz       			 := le.cr_sort_sz;
	  self.chk_digit        			 := le.chk_digit;
	  self.geo_lat          			 := le.geo_lat;
	  self.geo_blk          			 := le.geo_blk;
	  self.geo_long         			 := le.geo_long;
	  self.geo_match        			 := le.geo_match;
	  self.err_stat         			 := le.err_stat;
	  self.rec_type         			 := le.rec_type;
	  self.county           			 := le.county;
	  self.issuance         			 := '';
	  self.dl_number        			 := le.dl_number;
	  self.lic_issue_date   			 := (unsigned4) (le.issue_date[5..8] + le.issue_date[1..4]);
	  
	end;

	updates := project(u(trans_indicator = 'U'),setUpdates2(left));
	
	DriversV2.Layout_DL_Extended Killed(updates le, kills ri) := transform
	
	  self.history := IF( ri.dl_number='','','H');
	  self 				 := le;
	  
	end;

	out_stream := join(updates, kills,
										 left.dl_number     = right.dl_number and
										 left.dt_first_seen < (unsigned8)right.process_date div 100,
										 killed(left,right), left outer) ;
				 
	tx_as_dl_mapper := out_stream;
	return tx_as_dl_mapper; 

end;
										