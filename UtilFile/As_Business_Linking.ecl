#OPTION('multiplePersistInstances',FALSE);
import UtilFile,mdr,business_header,ut,address,business_headerv2,mdr,lib_stringlib,_Validate,header;

export As_Business_Linking (dataset(UtilFile.Layout_Utility_Bus_Base) 
														pBase_ = UtilFile.files(,true).base.QA, 
														boolean IsPRCT = false) := function

//*** filterning older than 5 years data due to gld restriction - Bug# 118328
pBase_filtered := if(isPRCT, pBase_, pBase_(~header.IsOldUtil(ut.GetDate,false,record_date)));

//Base file only contains Company data, so no mapping to Contact fields will be done

//Base file mapping to Business Header Linking Interface
		Business_Header.Layout_Business_Linking.Linking_Interface	x1(pBase_filtered l, unsigned8 ctr) := transform
		  self.source                     := MDr.sourceTools.src_Utilities;
			self.dt_first_seen  				    := if(_validate.date.fIsValid((string)l.date_first_seen),(unsigned4)l.date_first_seen,0);
		  self.dt_last_seen  					    := 0; //Not available
		  self.dt_vendor_first_reported   := 0; //Not available
		  self.dt_vendor_last_reported    := 0; //Not available
			self.rcid 										  := 0; 
			self.company_bdid               := (unsigned6)l.bdid;	
			self.company_name							  := trim(l.company_name,left,right);
			self.company_name_type_raw      := ''; //Not available
			self.company_rawaid						  := 0;  //Not available
		  self.company_address.prim_range := l.prim_range;
		  self.company_address.predir     := l.predir;
		  self.company_address.prim_name  := l.prim_name;
		  self.company_address.addr_suffix:= l.addr_suffix;
		  self.company_address.postdir    := l.postdir;
		  self.company_address.unit_desig := l.unit_desig;
		  self.company_address.sec_range  := l.sec_range;
		  self.company_address.p_city_name:= l.p_city_name;
		  self.company_address.v_city_name:= l.v_city_name;
		  self.company_address.st         := l.st;
		  self.company_address.zip        := l.zip;
		  self.company_address.zip4       := l.zip4;
		  self.company_address.cart       := l.cart;		
		  self.company_address.cr_sort_sz := l.cr_sort_sz;		
		  self.company_address.lot        := l.lot;
		  self.company_address.lot_order  := l.lot_order;		
		  self.company_address.dbpc       := l.dbpc;
		  self.company_address.chk_digit  := l.chk_digit;		
		  self.company_address.rec_type   := l.rec_type;			
		  self.company_address.fips_county:= l.county[3..5];
			self.company_address.fips_state := l.county[1..2];
			self.company_address.geo_lat    := l.geo_lat;
		  self.company_address.geo_long   := l.geo_long;
			self.company_address.msa        := l.msa;
		  self.company_address.geo_blk    := l.geo_blk;
		  self.company_address.geo_match  := l.geo_match;
		  self.company_address.err_stat   := l.err_stat;
			self.company_address_type_raw   := l.addr_type;
		  self.company_address_category   := ''; //Not available
		  self.company_fein               := l.ssn; //Base file SSN field contains FEINs
			self.best_fein_Indicator        := ''; //Only for FEIN.  Not for UtilFile.
		  self.company_phone              := choose(ctr,ut.cleanPhone(l.phone),ut.cleanPhone(l.work_phone));
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
			self.vl_id                      := l.id;  
			self.current										:= TRUE;
			self.source_record_id						:= l.source_rec_id; 	
		  self.glb												:= false;
		  self.dppa										    := false;
		  self.match_company_name					:= ''; //Not available
		  self.match_branch_city 					:= ''; //Not available
		  self.match_geo_city							:= ''; //Not available		
		  self.is_contact                 := false; //Will be set during linking
			self.dt_first_seen_contact      := 0;  //Not available
		  self.dt_last_seen_contact       := 0;  //Not available
		  self.contact_did                := 0;  //Not available
		  self.contact_name.title         := ''; //Not available
		  self.contact_name.fname         := ''; //Not available
		  self.contact_name.mname         := ''; //Not available
		  self.contact_name.lname         := ''; //Not available
		  self.contact_name.name_suffix   := ''; //Not available
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

	choosePhone(string pPhone1, string pPhone2) := map(pPhone1!='' and pPhone2!='' => 2, 1);
																										
	dsMapped	:= normalize(pBase_filtered, choosePhone(left.phone, left.work_phone), x1(left,counter));
 
	dsMapped_sortdist := sort(distribute(dsMapped,hash(vl_id)),record, local);
	
	Business_Header.Layout_Business_Linking.Linking_Interface RollupLinking(Business_Header.Layout_Business_Linking.Linking_Interface L, Business_Header.Layout_Business_Linking.Linking_Interface R) := transform
		self := L;
	end;
  
	//This rollup makes sure unique companies exist.				
	dsLinking := rollup(dsMapped_sortdist(company_name<>''), RollupLinking(left, right), record, LOCAL);

	dsLinking_add := dsLinking : persist('~thor_data400::persist::UtilFile::As_Business_Linking');
	
	outf := if(IsPRCT, dsLinking, dsLinking_add);

	return outf;

end;	