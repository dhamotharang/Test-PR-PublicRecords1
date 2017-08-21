#OPTION('multiplePersistInstances',FALSE);
import Gong_v2,mdr,business_header,ut,address,business_headerv2,mdr,lib_stringlib,_Validate, gong, data_services;

export As_Business_Linking(dataset(Gong.layout_historyaid)
						pBase = dataset(Data_Services.Data_location.Prefix('Gong_History') + 'thor_data400::base::gong_history',
                               Gong.layout_historyaid, flat),
					  boolean IsPRCT = false) := function
			      //can't use gong_v2.File_GongMaster because we want physical file 
			      //on disk so it can be put into the business header superfile

  dBase := pBase((listing_type_bus <> '' or listing_type_gov <> '')
					  	   ,publish_code				in ['P','U']
						     ,current_record_flag =  'Y'
						     ,listed_name				not in ['','*','/ LOCKSMITH', 'FIRE', 'FIRE & WATER', 'FIRE (IF NO ANSWER)', 'FIRE (TO REPORT A FIRE)', 'FIRE ALARM', 'FIRE ALARM & EMERGENCY ONLY', 'FIRE ALARM CALLS ONLY', 'FIRE ALARM EMERGENCY ONLY', 'FIRE AMBULANCE RESCUE', 'FIRE CALLS', 'FIRE CALLS EMERGENCY', 'FIRE CHIEF', 'FIRE CHIEFS OFFICES-NOT FIRE CALLS', 'FIRE DEPARTMENT', 'FIRE DEPARTMENTS', 'FIRE DEPARTMENTS & DISTRICTS', 'FIRE DEPARTMENTS-COUNTY', 'FIRE DEPARTMENTS-GOVERNMENT', 'FIRE DEPT', 'FIRE DEPT TO REPORT A FIRE', 'FIRE DEPT TO REPORT FIRES', 'FIRE DEPT TO REPORT FIRES ONLY', 'FIRE DEPTS', 'FIRE DEPTS.', 'FIRE DEPT-TO REPORT A FIRE', 'FIRE EMERGENCIES ONLY', 'FIRE EMERGENCY', 'FIRE EMERGENCY CALLS', 'FIRE EMERGENCY ONLY', 'FIRE POLICE', 'FIRE SERVICE(DST)911', 'FIRE SERVICES', 'FIRE STATION', 'FIRE TO REPORT A FIRE', 'LOCKSMITH', 'LOCKSMITH _', 'LOCKSMITH EMERGENCY', 'LOCKSMITH SERVICE', 'LOCKSMITH SERVICES', 'LOCKSMITHS', 'PAYPHONE', 'POLICE', 'POLICE & FIRE', 'POLICE CALLS', 'POLICE CALLS-', 'POLICE CALLS EMERGENCY', 'POLICE DEPARTMENT', 'POLICE DEPARTMENTS', 'POLICE DEPARTMENTS-GOVERNMENT', 'POLICE DEPARTMENT-TO CALL POLICE', 'POLICE DEPT', 'POLICE DEPT TO CALL THE POLICE', 'POLICE DEPTS', 'POLICE DEPT-TO CALL THE POLICE', 'POLICE EMERGENCIES', 'POLICE EMERGENCY', 'POLICE EMERGENCY CALLS', 'POLICE EMERGENCY CALLS ONLY', 'POLICE EMERGENCY ONLY', 'POLICE NON-EMERGENCY CALLS', 'POLICE NON-EMERGENCY-BUSINESS', 'POLICE OR CALL', 'POLICE STATE', 'POLICE STATION', 'POLICE STATIONS', 'POLICE/SHERIFF', 'POLICE-TOWNSHIP OR VILLAGE OF', 'STATE POLICE']);

  //Base file mapping to Business Header Linking Interface
  Business_Header.Layout_Business_Linking.Linking_Interface	x1(dBase l) := transform
  		self.source											:= if(l.listing_type_gov <> ''
																				    or ut.GovName(ut.CleanCompany(l.listed_name)),
																			      MDr.sourceTools.src_Gong_Government,
																			      MDr.sourceTools.src_Gong_Business);
			self.dt_first_seen  				    := if(_validate.date.fIsValid((string)l.dt_first_seen),
																						(unsigned4)l.dt_first_seen,	0);
			self.dt_last_seen  					    := if(_validate.date.fIsValid((string)l.dt_last_seen), 
																						(unsigned4)l.dt_last_seen, SELF.dt_first_seen);
		  self.dt_vendor_first_reported   := if(_validate.date.fIsValid((string)l.filedate[1..8]),
																						(unsigned4)(l.filedate[1..8]), 0);
		  self.dt_vendor_last_reported    := self.dt_vendor_first_reported;
			self.rcid 										  := 0; //Not available
			self.company_bdid               := (unsigned6)l.bdid;	
			self.Company_name							  := // Strip out asterisks & '(CAP)' 
																				 if ((StringLib.StringFindCount(l.listed_name,'(CAP)')>0),
																							(trim(datalib.StringReplaceSmaller(l.listed_name,'(CAP)',''),left,right)),
																							if ((StringLib.StringFindCount(l.listed_name,'*')>0),
																									 (trim(datalib.StringReplaceSmaller(l.listed_name,'*',''),left,right)),
																							     (trim(l.listed_name,left,right))));
			self.company_name_type_raw      := ''; //Not available
			self.company_rawaid						  := l.rawaid;
		  self.company_address.prim_range := l.prim_range;
		  self.company_address.predir     := l.predir;
		  self.company_address.prim_name  := l.prim_name;
		  self.company_address.addr_suffix:= l.suffix;
		  self.company_address.postdir    := l.postdir;
		  self.company_address.unit_desig := l.unit_desig;
		  self.company_address.sec_range  := l.sec_range;
		  self.company_address.p_city_name:= l.p_city_name;
		  self.company_address.v_city_name:= l.v_city_name;
		  self.company_address.st         := l.st;
		  self.company_address.zip        := l.z5;
		  self.company_address.zip4       := l.z4;
		  self.company_address.cart       := l.cart;		
		  self.company_address.cr_sort_sz := l.cr_sort_sz;		
		  self.company_address.lot        := l.lot;
		  self.company_address.lot_order  := l.lot_order;		
		  self.company_address.dbpc       := l.dpbc;
		  self.company_address.chk_digit  := l.chk_digit;		
		  self.company_address.rec_type   := l.rec_type;			
		  self.company_address.fips_county:= l.county_code[3..5];
			self.company_address.fips_state := l.county_code[1..2];
			self.company_address.geo_lat    := l.geo_lat;
		  self.company_address.geo_long   := l.geo_long;
			self.company_address.msa        := l.msa;
		  self.company_address.geo_blk    := l.geo_blk;
		  self.company_address.geo_match  := l.geo_match;
		  self.company_address.err_stat   := l.err_stat;
			self.company_address_type_raw   := ''; //Not available
		  self.company_address_category   := ''; //Not available
		  self.company_fein               := ''; //Not available
			self.best_fein_Indicator        := ''; //Only for FEIN.  
		  self.company_phone              := ut.cleanPhone(l.phone10);
			self.phone_score                := if((integer)self.company_phone=0,0,1);
			self.phone_type     						:= if((integer)self.company_phone=0,'','T');
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
			self.vl_id                      := (string34)(l.bell_id + '-' + l.sequence_number); 
			self.current										:= true;
			self.source_record_id						:= l.persistent_record_id; 
		  self.glb												:= false;
		  self.dppa										    := false;
		  self.match_company_name					:= ''; //Not available
		  self.match_branch_city 					:= ''; //Not available
		  self.match_geo_city							:= ''; //Not available		
		  self.is_contact                 := false; //Will be set during linking
			self.dt_first_seen_contact      := 0;  //Not available
		  self.dt_last_seen_contact       := 0;  //Not available
		  self.contact_did                := l.did;
		  self.contact_name.title         := l.name_prefix;
		  self.contact_name.fname         := l.name_first;
		  self.contact_name.mname         := l.name_middle;
		  self.contact_name.lname         := l.name_last;
		  self.contact_name.name_suffix   := l.name_suffix;
		  self.contact_name.name_score    := ''; //Not available
		  self.contact_type_raw           := ''; //Not available
		  self.contact_job_title_raw      := ''; //Not available
		  self.contact_ssn                := ''; //Not available
		  self.contact_dob                := 0;  //Not available
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
		
	dsMapped_sortdist := sort(distribute(dsMapped,hash(vl_id)),record, EXCEPT company_rawaid,local);
		
	Business_Header.Layout_Business_Linking.Linking_Interface RollupLinking(Business_Header.Layout_Business_Linking.Linking_Interface L, Business_Header.Layout_Business_Linking.Linking_Interface R) := transform
		self := L;
	end;
  
	//This rollup makes sure unique companies exist.				
	dsLinking := rollup(dsMapped_sortdist(company_name<>''), RollupLinking(left, right),
												 record, except company_rawaid, LOCAL
												 );	
	dsLinking_pst := dsLinking : persist('~thor_data400::persist::Gong_v2::As_Business_Linking');
	
	return if (IsPRCT, dsLinking,dsLinking_pst );
end;	




