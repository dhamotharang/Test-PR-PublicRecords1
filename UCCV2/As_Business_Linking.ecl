#OPTION('multiplePersistInstances',FALSE);
import UCCV2,mdr,business_header,ut,address,business_headerv2,mdr,lib_stringlib,_Validate;

export As_Business_Linking (dataset(Layout_UCC_Common.Layout_Party_With_AID) 
															pBase = UCCV2.File_UCC_Party_Base_AID, boolean IsPRCT = false) := function

//Base file mapping to Business Header Linking Interface
		Business_Header.Layout_Business_Linking.Linking_Interface	x1(pBase l) := transform
		  self.source                     := MDr.sourceTools.src_UCCV2;
			self.dt_first_seen  				    := if(_validate.date.fIsValid((string)l.dt_first_seen + '01'),(unsigned4)l.dt_first_seen,0);
		  self.dt_last_seen  					    := if(_validate.date.fIsValid((string)l.dt_last_seen + '01'),(unsigned4)l.dt_last_seen,0);
		  self.dt_vendor_first_reported   := if(_validate.date.fIsValid((string)l.dt_vendor_first_reported),(unsigned4)l.dt_vendor_first_reported,0); 
		  self.dt_vendor_last_reported    := if(_validate.date.fIsValid((string)l.dt_vendor_last_reported),(unsigned4)l.dt_vendor_last_reported,0); 
			self.rcid 										  := 0; //Not available
			self.company_bdid               := l.bdid;	
			self.company_name							  := l.company_name;
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
		  self.company_address.zip        := l.zip5;
		  self.company_address.zip4       := l.zip4;
		  self.company_address.cart       := l.cart;		
		  self.company_address.cr_sort_sz := l.cr_sort_sz;		
		  self.company_address.lot        := l.lot;
		  self.company_address.lot_order  := l.lot_order;		
		  self.company_address.dbpc       := l.dpbc;
		  self.company_address.chk_digit  := l.chk_digit;		
		  self.company_address.rec_type   := l.rec_type;			
		  self.company_address.fips_county:= l.ace_fips_county;
			self.company_address.fips_state := l.ace_fips_st;
			self.company_address.geo_lat    := l.geo_lat;
		  self.company_address.geo_long   := l.geo_long;
			self.company_address.msa        := l.msa;
		  self.company_address.geo_blk    := l.geo_blk;
		  self.company_address.geo_match  := l.geo_match;
		  self.company_address.err_stat   := l.err_stat;
			self.company_address_type_raw   := ''; //Not available		
		  self.company_address_category   := ''; //Not available
		  self.company_fein               := l.fein;
			self.best_fein_Indicator        := ''; //Only for FEIN.  Not for UCCV2.
		  self.company_phone              := ''; //Not available
		  self.phone_type                 := ''; //Not available 
		  self.company_org_structure_raw  := if (l.corp_type ='0','',l.corp_type);			
		  self.company_incorporation_date	:= 0; //Not available
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
		  self.company_foreign_domestic   := map(l.foreign_indc = 'Y' => 'F',
																						 l.foreign_indc = 'N' => 'D', '');		
		  self.company_url                := ''; //Not available	
		  self.company_inc_state			    := if (l.incorp_state in ['AL','AK','AZ','AR','CA','CO','CT',
																						 'DE','DC','FL','GA','HI','ID','IL','IN','IA','KS','KY',
																						 'LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV',
																						 'NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI',
																						 'SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY',
																						 'AS','GU','MP','PR','VI','FM','MH','PW','AA','AE','AP',
																						 'CZ','PI','TT','CM'], l.incorp_state, '');
		  self.company_charter_number     := if (l.corp_number in ['0','-','--','CORP','LLC','MA','N/A',
																							'n/a','NA','na','None','NONE','none','NULL','ORGID BOX CHECKED',
																							'OTHER','RSOS','WA','X','xxx-xx-9579','xxxx-xx-6586','TRUE'],
																							'',l.corp_number);			
		  self.company_filing_date        := 0;  //Not available
		  self.company_status_date        := 0;  //Not available
		  self.company_foreign_date       := 0;  //Not available
		  self.event_filing_date          := 0;  //Not available
		  self.company_name_status_raw    := ''; //Not available
		  self.company_status_raw         := ''; //Not available
		  self.dt_first_seen_company_name := 0;  //Not available
		  self.dt_last_seen_company_name  := 0;  //Not available
		  self.dt_first_seen_company_address:=0; //Not available
		  self.dt_last_seen_company_address:= 0; //Not available
			self.vl_id                      := l.tmsid;  
			self.current										:= TRUE;
			self.source_record_id						:= l.source_rec_id;	
		  self.glb												:= false;
		  self.dppa										    := false;
		  self.phone_score                := 0; 		
		  self.match_company_name					:= ''; //Not available
		  self.match_branch_city 					:= ''; //Not available
		  self.match_geo_city							:= ''; //Not available		
		  self.is_contact                 := false; //Will be set during linking
			self.dt_first_seen_contact      := 0; //Not available
		  self.dt_last_seen_contact       := 0; //Not available
		  self.contact_did                := l.did;
		  self.contact_name.title         := l.title;
		  self.contact_name.fname         := l.fname;
		  self.contact_name.mname         := l.mname;
		  self.contact_name.lname         := l.lname;
		  self.contact_name.name_suffix   := l.name_suffix;
		  self.contact_name.name_score    := l.name_score;
		  self.contact_type_raw           := ''; //Not available
		  self.contact_job_title_raw      := ''; //Not available
		  self.contact_ssn                := l.ssn;
		  self.contact_dob                := 0;  //Not available
		  self.contact_status_raw         := ''; //Not available
		  self.contact_email              := ''; //Not available
		  self.contact_email_username     := ''; //Not available
		  self.contact_email_domain       := ''; //Not available
		  self.contact_phone              := ''; //Not available
		  self.cid												:= 0;  //Not available
		  self.contact_score							:= 0;  //Not available
		  self.from_hdr										:= 'N';		
		  self.company_department					:= '';  //Not available
		  self 														:= l;
		  self 														:= [];
	end;

	dsMapped := project(pBase(company_name<>''),x1(left));
 
	dsMapped_sortdist := sort(distribute(dsMapped,hash(vl_id)),record, EXCEPT company_rawaid,local);
	
	Business_Header.Layout_Business_Linking.Linking_Interface RollupLinking(Business_Header.Layout_Business_Linking.Linking_Interface L, Business_Header.Layout_Business_Linking.Linking_Interface R) := transform
		self := L;
	end;
  
	//This rollup makes sure unique companies exist.				
	dsLinking := rollup(dsMapped_sortdist, RollupLinking(left, right), record, LOCAL);
	
	dsLinking_pst := dsLinking : persist('~thor_data400::persist::UCCV2::As_Business_Linking');	
												 
	return IF(IsPRCT, dsLinking, dsLinking_pst);
end;
