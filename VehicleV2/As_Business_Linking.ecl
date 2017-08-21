#OPTION('multiplePersistInstances',FALSE);
import Address,VehicleV2,MDR,business_header,ut,business_headerv2,_Validate;

export As_Business_Linking (dataset(VehicleV2.Layout_Base.Party_Base_BIP) 
					                  pBase = VehicleV2.File_VehicleV2_Party_Building,
														boolean IsPRCT = false) := function
			      			      
  dBase := pBase( stringlib.StringFind(append_clean_cname,'%JR',1)  = 0 and 
							  stringlib.StringFind(append_clean_cname,'%SR',1)  = 0 and	
							  stringlib.StringFind(append_clean_cname,'%IV',1)  = 0 and 
							  stringlib.StringFind(append_clean_cname,'%II',1)  = 0 and 
							  stringlib.StringFind(append_clean_cname,'% JR',1) = 0 and
							  append_clean_cname <> '' and
								//exclude infutor veh and motorcycle. Bug 146486
								source_code not in ['1V','2V']); 
								
  //Base file mapping to Business Header Linking Interface
  Business_Header.Layout_Business_Linking.Linking_Interface	x1(dBase l) := transform
	 		self.source											:= MDR.sourceTools.fVehicles(l.state_origin,l.source_code);
			self.dt_first_seen  				    := if(_validate.date.fIsValid((string)l.date_first_seen + '00',,,true),
																						(unsigned4)l.date_first_seen,	0);
			self.dt_last_seen  					    := if(_validate.date.fIsValid((string)l.date_last_seen + '00',,,true), 
																						(unsigned4)l.date_last_seen, SELF.dt_first_seen);
		  self.dt_vendor_first_reported   := if(_validate.date.fIsValid((string)l.date_vendor_first_reported + '00',,,true),
																						(unsigned4)(l.date_vendor_first_reported), 0);
		  self.dt_vendor_last_reported    := if(_validate.date.fIsValid((string)l.date_vendor_last_reported + '00',,,true),
																						(unsigned4)(l.date_vendor_last_reported), 0);
			self.rcid 										  := 0; //Not available
			self.company_bdid               := (unsigned6)l.append_bdid;	
			self.company_name							  := trim(l.append_clean_cname,left,right);
			self.company_name_type_raw      := ''; //Not available
			self.company_rawaid						  := 0; //Not available
		  self.company_address.prim_range := l.append_clean_address.prim_range;
		  self.company_address.predir     := l.append_clean_address.predir;
		  self.company_address.prim_name  := l.append_clean_address.prim_name;
		  self.company_address.addr_suffix:= l.append_clean_address.addr_suffix;
		  self.company_address.postdir    := l.append_clean_address.postdir;
		  self.company_address.unit_desig := l.append_clean_address.unit_desig;
		  self.company_address.sec_range  := l.append_clean_address.sec_range;
		  self.company_address.p_city_name:= ''; //Not available
		  self.company_address.v_city_name:= l.append_clean_address.v_city_name;
		  self.company_address.st         := l.append_clean_address.st;
		  self.company_address.zip        := l.append_clean_address.zip5;
		  self.company_address.zip4       := l.append_clean_address.zip4;
		  self.company_address.cart       := ''; //Not available	
		  self.company_address.cr_sort_sz := ''; //Not available	
		  self.company_address.lot        := ''; //Not available
		  self.company_address.lot_order  := ''; //Not available		
		  self.company_address.dbpc       := ''; //Not available
		  self.company_address.chk_digit  := ''; //Not available	
		  self.company_address.rec_type   := ''; //Not available			
		  self.company_address.fips_county:= l.append_clean_address.fips_county;
			self.company_address.fips_state := l.append_clean_address.fips_state;
			self.company_address.geo_lat    := l.append_clean_address.geo_lat;
		  self.company_address.geo_long   := l.append_clean_address.geo_long;
			self.company_address.msa        := ''; //Not available	
		  self.company_address.geo_blk    := l.append_clean_address.geo_blk;
		  self.company_address.geo_match  := l.append_clean_address.geo_match;
		  self.company_address.err_stat   := l.append_clean_address.err_stat;
			self.company_address_type_raw   := ''; //Not available
		  self.company_address_category   := ''; //Not available
		  self.company_fein               := l.append_fein;
			self.best_fein_Indicator        := ''; //Only for FEIN.  
		  self.company_phone              := ''; //Not available
			self.phone_score                := 0; //Not available
			self.phone_type     						:= ''; //Not available
			self.company_org_structure_raw  := ''; //Not available			
		  self.company_incorporation_date	:= 0;  //Not available
		  self.company_sic_code1					:= ''; //Not available 
		  self.company_sic_code2					:= ''; //Not available 
		  self.company_sic_code3					:= ''; //Not available
		  self.company_sic_code4					:= ''; //Not available 
		  self.company_sic_code5					:= ''; //Not available 
		  self.company_naics_code1        := ''; //Not available
		  self.company_naics_code2        := ''; //Not available
		  self.company_naics_code3        := ''; //Not available
		  self.company_naics_code4        := ''; //Not available
		  self.company_naics_code5        := ''; //Not available
			self.company_ticker             := ''; //Not available
      self.company_ticker_exchange    := ''; //Not available
		  self.company_foreign_domestic   := ''; //Not available
		  self.company_url                := ''; //Not available	
		  self.company_inc_state			    := ''; //Not available
		  self.company_charter_number     := ''; //Not available		
		  self.company_filing_date        := 0;  //Not available
		  self.company_status_date        := 0;  //Not available
		  self.company_foreign_date       := 0;  //Not available
		  self.event_filing_date          := 0;  //Not available
		  self.company_name_status_raw    := ''; //Not available
		  self.company_status_raw         := ''; //Not available
		  self.dt_first_seen_company_name := 0;  //Not available
		  self.dt_last_seen_company_name  := 0;  //Not available
		  self.dt_first_seen_company_address:= 0;//Not available
		  self.dt_last_seen_company_address:= 0; //Not available
			self.vl_id                      := TRIM(l.vehicle_key); 
			self.current										:= true;
			self.source_record_id						:= l.source_rec_id; //Will be populated during retro fit	
		  self.glb												:= false;
		  self.dppa										    := false;
		  self.match_company_name					:= ''; //Not available
		  self.match_branch_city 					:= ''; //Not available
		  self.match_geo_city							:= ''; //Not available		
		  self.is_contact                 := false; //Will be set during linking
			self.dt_first_seen_contact      := 0; //Not available
		  self.dt_last_seen_contact       := 0; //Not available
		  self.contact_did                := 0; //Not available
		  self.contact_name.title         := ''; //Not available		
		  self.contact_name.fname         := ''; //Not available		
		  self.contact_name.mname         := ''; //Not available		
		  self.contact_name.lname         := ''; //Not available		
		  self.contact_name.name_suffix   := ''; //Not available		
		  self.contact_name.name_score    := ''; //Not available
		  self.contact_type_raw           := ''; //Not available
		  self.contact_job_title_raw      := ''; //Not available
		  self.contact_ssn                := l.orig_ssn;
		  self.contact_dob                := if(_validate.date.fIsValid((string)l.orig_dob),
																						(unsigned4)l.orig_dob, 0);
		  self.contact_status_raw         := ''; //Not available
		  self.contact_email              := ''; //Not available
		  self.contact_email_username     := ''; //Not available
		  self.contact_email_domain       := ''; //Not available
		  self.contact_phone              := ''; //Not available
		  self.cid												:= 0;  //Not available
		  self.contact_score							:= 0;  //Not available
		  self.from_hdr										:= 'N';		
		  self.company_department					:= ''; //Not available
		  self 														:= l;
		  self 														:= [];
	end;
  
	dsMapped := project(dBase,x1(left));
		
	dsMapped_dist := distribute(dsMapped,hash(vl_id, contact_name.fname, contact_name.lname));
		
	dsMapped_sort	:= sort(dsMapped_dist,
	                      vl_id, contact_name.fname, contact_name.lname,contact_name.mname,contact_name.name_suffix,
												company_address.prim_range,company_address.prim_name,company_address.sec_range,
												company_address.st,company_address.zip,contact_ssn,contact_dob,
												local);
												
	Business_Header.Layout_Business_Linking.Linking_Interface RollupLinking(dsMapped_sort l, dsMapped_sort r) := transform
	 self.dt_first_seen              := ut.EarliestDate(l.dt_first_seen,r.dt_first_seen);
	 self.dt_last_seen               := ut.LatestDate(l.dt_last_seen,r.dt_last_seen);
	 self.dt_vendor_first_reported   := ut.EarliestDate(l.dt_vendor_first_reported,r.dt_vendor_first_reported);
	 self.dt_vendor_last_reported    := ut.LatestDate(l.dt_vendor_last_reported,r.dt_vendor_last_reported);
	 self.contact_ssn                := if(l.contact_ssn	<>	'',l.contact_ssn,r.contact_ssn);
	 self.contact_dob                := if(l.contact_dob	<>	0,l.contact_dob,r.contact_dob);
	 self.contact_name.mname         := if(l.contact_name.mname	<>	'',l.contact_name.mname,r.contact_name.mname);
	 self.company_address.prim_range := if(l.company_address.prim_range	<>	'',l.company_address.prim_range,r.company_address.prim_range);
	 self                            := l;
	end;
   	
	//This rollup makes sure unique companies exist.				
	dsLinking := rollup(dsMapped_sort(company_name<>''), 
	                     			left.vl_id                     = right.vl_id			                       	 and
														left.contact_name.fname        = right.contact_name.fname					         and
														ut.NNEQ(left.contact_name.mname,right.contact_name.mname)					         and
														left.contact_name.lname        = right.contact_name.lname					         and
														left.contact_name.name_suffix  = right.contact_name.name_suffix		         and
														ut.NNEQ(left.company_address.prim_range,right.company_address.prim_range)	 and
														left.company_address.prim_name = right.company_address.prim_name	         and
														left.company_address.sec_range = right.company_address.sec_range           and
														left.company_address.st        = right.company_address.st					         and
														left.company_address.zip       = right.company_address.zip				         and
														ut.NNEQ_SSN(left.contact_ssn,right.contact_ssn)						                 and
														ut.NNEQ_Date(left.contact_dob,right.contact_dob),
														RollupLinking(left,right),
														local);  
												      
	
	dsLinking_add := dsLinking : persist('~thor_data400::persist::VehicleV2::As_Business_Linking');

	outf := if(IsPRCT, dsLinking, dsLinking_add);

	return outf;

end;	