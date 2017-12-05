import BIPV2, BIPV2_Company_Names, Business_Header, PRTE2, PRTE2_Business_Header, STD, ut, mdr;

export BH_Init_Final(
		dataset(PRTE2_Business_Header.Layouts.Out.Layout_BH_Out	)	pInput_BusHdr_Init		= PRTE2_Business_Header.BH_Init()	
	 ,dataset(PRTE2_Business_Header.layouts.Out.Layout_BC_Out	)	pInput_BusCont_Init		= PRTE2_Business_Header.BC_Init()
	
) :=
function

	//*** Mapping Business Header
	dBH_Search_Recs := pInput_BusHdr_Init(trim(long_bus_name) <> '');

	PRTE2_BIPV2_BusHeader.Layouts.Temporary.Layout_BHL_Company trfMap_to_company_BHL(dBH_Search_Recs l) := transform
		
		self.link_fein											:= STD.Str.CleanSpaces(l.link_fein);
		self.link_inc_date									:= STD.Str.CleanSpaces(l.link_inc_date);
		self.cust_name											:= STD.Str.CleanSpaces(l.cust_name);
		self.tmp_join_id_company     				:= STD.Str.CleanSpaces(l.link_fein) + STD.Str.CleanSpaces(l.link_inc_date);
		self.dt_first_seen     							:= (unsigned4)l.dt_first_seen;																								   
	  self.dt_last_seen      							:= (unsigned4)l.dt_last_seen;																								  
	  self.dt_vendor_first_reported 			:= (unsigned4)l.dt_vendor_first_reported;
	  self.dt_vendor_last_reported  			:= (unsigned4)l.dt_vendor_last_reported;
		self.rcid														:= 0;
		self.vl_id             							:= if(trim(l.cust_name) = '', '', ut.CleanSpacesAndUpper(l.src) + STD.Str.CleanSpaces(l.link_fein + l.link_inc_date));
		self.company_bdid										:= l.bdid;
	  self.company_phone									:= STD.Str.CleanSpaces(l.bus_phone);
	  self.phone_score      							:= if((integer)trim(l.bus_phone) <> 0, 1, 0);
		self.phone_type	      							:= if((integer)trim(l.bus_phone) <> 0, 'T', '');
	  self.source           							:= ut.CleanSpacesAndUpper(l.src);
	  self.company_fein      							:= STD.Str.CleanSpaces(l.orig_fein);
		self.best_fein_Indicator						:= if(mdr.sourceTools.SourceIsDunn_Bradstreet_Fein(l.src) and trim(l.orig_fein) <> '', '1', '');
		self.company_name_type_raw					:= ut.CleanSpacesAndUpper(l.bus_type_desc);
	  self.company_name      							:= ut.CleanSpacesAndUpper(l.long_bus_name);
		self.company_org_structure_raw			:= '';
		self.company_incorporation_date			:= if(trim(l.cust_name) = '',0,(unsigned4)STD.Str.CleanSpaces(l.link_inc_date));
		self.company_address_type_raw				:= l.addr_type;
	  self.company_address.prim_range     := l.prim_range;
	  self.company_address.predir         := l.predir;
	  self.company_address.prim_name      := l.prim_name;
	  self.company_address.addr_suffix    := l.addr_suffix;
	  self.company_address.postdir        := l.postdir;
	  self.company_address.unit_desig     := l.unit_desig;
	  self.company_address.sec_range      := l.sec_range;
	  self.company_address.p_city_name    := l.p_city_name;
		self.company_address.v_city_name    := l.v_city_name;
	  self.company_address.st		          := l.st;
	  self.company_address.zip            := l.zip;
	  self.company_address.zip4           := l.zip4;
		self.company_address.cart						:= l.cart;
		self.company_address.cr_sort_sz			:= l.cr_sort_sz;
		self.company_address.lot						:= l.lot;
		self.company_address.lot_order			:= l.lot_order;
		self.company_address.dbpc						:= l.dbpc;
		self.company_address.chk_digit			:= l.chk_digit;
		self.company_address.rec_type				:= l.rec_type;
		self.company_address.fips_state			:= l.fips_state;
	  self.company_address.fips_county    := l.fips_county;
	  self.company_address.geo_lat        := l.geo_lat;
	  self.company_address.geo_long       := l.geo_long;
		self.company_address.msa            := l.msa;
		self.company_address.geo_blk				:= l.geo_blk;
		self.company_address.geo_match			:= l.geo_match;
		self.company_address.err_stat				:= l.err_stat;
		self.company_rawaid									:= l.RawAID;
		self.company_aceaid									:= l.AceAID;
		self.company_status_raw							:= ut.CleanSpacesAndUpper(l.bus_status);
	  self.company_sic_code1 							:= STD.Str.CleanSpaces(l.sic_code);
		self.company_naics_code1						:= STD.Str.CleanSpaces(l.naics_code);
		self.company_url										:= ut.CleanSpacesAndUpper(l.bus_URL);
	  self.current           							:= true;
		self.match_company_name							:= ut.CleanSpacesAndUpper(l.bus_name);
		self.dppa														:= if(trim(l.dppa) in ['0',''], false, true);
		self.source_record_id								:= 0;
		self 																:= [];
	end;
	
	ds_company := project(dBH_Search_Recs, trfMap_to_company_BHL(left));
	
	//*** Mapping Contacts
	dBC_Init_Recs		:= pInput_BusCont_Init;
	
	PRTE2_BIPV2_BusHeader.Layouts.Temporary.Layout_BHL_Contact trfMap_To_Contact_BHL(dBC_Init_Recs l) := transform
			
			self.link_fein										:= STD.Str.CleanSpaces(l.link_fein);
			self.link_inc_date								:= STD.Str.CleanSpaces(l.link_inc_date);
			self.cust_name										:= STD.Str.CleanSpaces(l.cust_name);
			self.tmp_join_id_contact					:= STD.Str.CleanSpaces(l.link_fein) + STD.Str.CleanSpaces(l.link_inc_date);
			self.dt_first_seen_contact				:= (unsigned4)l.dt_first_seen;
			self.dt_last_seen_contact					:= (unsigned4)l.dt_last_seen;
			//self.source								:= l.src;
			//self.company_name 				:= l.bus_name;
			//self.company_prim_range		:= l.company_clean_addr.prim_range;
			//self.company_predir				:= l.company_clean_addr.predir;
			//self.company_prim_name		:= l.company_clean_addr.prim_name;
			//self.company_addr_suffix	:= l.company_clean_addr.addr_suffix;
			//self.company_postdir			:= l.company_clean_addr.postdir;
			//self.company_unit_desig		:= l.company_clean_addr.unit_desig;
			//self.company_sec_range		:= l.company_clean_addr.sec_range;
			//self.company_city					:= l.company_clean_addr.p_city_name;
			//self.company_state				:= l.company_clean_addr.st;
			//self.company_zip					:= (unsigned3)l.company_clean_addr.zip;
			//self.company_zip4					:= (unsigned2)l.company_clean_addr.zip4;
			//self.company_phone				:= (unsigned6)l.bus_phone;
			//self.company_fein 				:= (unsigned4)l.orig_fein;
			
			self.contact_did 									:= l.did;
			self.contact_ssn									:= l.contact_ssn;
			self.contact_dob									:= (unsigned4)l.contact_dob;
			self.contact_score 								:= if(trim(l.cust_name) = '', (unsigned1)l.contact_score,
																							if(l.did = 0, 1, 3));
			self.contact_job_title_raw				:= ut.CleanSpacesAndUpper(l.company_title);
			self.company_department						:= '';
			self.contact_name.title						:= if(trim(l.cust_name) = '', l.contact_title, l.title);
			self.contact_name.fname						:= l.fname;
			self.contact_name.mname						:= l.mname;
			self.contact_name.lname						:= l.lname;
			self.contact_name.name_suffix			:= l.name_suffix;
			self.contact_name.name_score			:= if(trim(l.cust_name) = '', '0', l.name_score);
			self.contact_address.prim_range		:= l.contact_clean_addr.prim_range;
			self.contact_address.predir				:= l.contact_clean_addr.predir;
			self.contact_address.prim_name		:= l.contact_clean_addr.prim_name;
			self.contact_address.addr_suffix	:= l.contact_clean_addr.addr_suffix;
			self.contact_address.postdir			:= l.contact_clean_addr.postdir;
			self.contact_address.unit_desig		:= l.contact_clean_addr.unit_desig;
			self.contact_address.sec_range		:= l.contact_clean_addr.sec_range;
			self.contact_address.p_city_name	:= l.contact_clean_addr.p_city_name;
			self.contact_address.v_city_name	:= l.contact_clean_addr.v_city_name;
			self.contact_address.st						:= l.contact_clean_addr.st;
			self.contact_address.zip					:= l.contact_clean_addr.zip;
			self.contact_address.zip4					:= l.contact_clean_addr.zip4;
			self.contact_address.cart					:= l.contact_clean_addr.cart;
			self.contact_address.cr_sort_sz		:= l.contact_clean_addr.cr_sort_sz;
			self.contact_address.lot					:= l.contact_clean_addr.lot;
			self.contact_address.lot_order		:= l.contact_clean_addr.lot_order;
			self.contact_address.dbpc					:= l.contact_clean_addr.dbpc;
			self.contact_address.chk_digit		:= l.contact_clean_addr.chk_digit;
			self.contact_address.rec_type			:= l.contact_clean_addr.rec_type;
			self.contact_address.fips_state		:= l.contact_clean_addr.fips_state;
			self.contact_address.fips_county	:= l.contact_clean_addr.fips_county;
			self.contact_address.msa					:= l.contact_clean_addr.msa;
			self.contact_address.geo_lat			:= l.contact_clean_addr.geo_lat;
			self.contact_address.geo_long			:= l.contact_clean_addr.geo_long;
			self.contact_address.geo_blk			:= l.contact_clean_addr.geo_blk;
			self.contact_address.geo_match		:= l.contact_clean_addr.geo_match;
			self.contact_address.err_stat			:= l.contact_clean_addr.err_stat;
			self.contact_rawaid								:= l.contact_RawAID;
			self.contact_aceaid								:= l.contact_AceAID;
			self.contact_phone								:= l.contact_phone;
			self.contact_email								:= '';			
			self.from_hdr											:= l.from_hdr;			
			self 															:= l;
			
	end;

	ds_contact := project(dBC_Init_Recs, trfMap_To_Contact_BHL(left));
	
	ds_company_dist := distribute(ds_company, hash(tmp_join_id_company));
	ds_contact_dist := distribute(ds_contact, hash(tmp_join_id_contact));

	PRTE2_BIPV2_BusHeader.Layouts.Temporary.Layout_BHL_Combined joinfiles(PRTE2_BIPV2_BusHeader.Layouts.Temporary.Layout_BHL_Company l, PRTE2_BIPV2_BusHeader.Layouts.Temporary.Layout_BHL_Contact r) := transform
			self.contact_address_type			:= 	if(l.company_aceaid=r.contact_aceaid, 'CC', r.contact_address_type);
			self.company_address_type_raw	:= 	if(l.company_aceaid=r.contact_aceaid, 'CC', l.company_address_type_raw);		

			self.dt_first_seen            := ut.EarliestDate(L.dt_first_seen, R.dt_first_seen_contact);
			self.dt_last_seen             := max(self.dt_first_seen, L.dt_last_seen, R.dt_last_seen_contact);
			self 													:= l;
			self 													:= r;
	end;

	j1 := join(ds_company_dist, ds_contact_dist,
						 left.tmp_join_id_company = right.tmp_join_id_contact,
						 joinfiles(left,right),
						 left outer,local);
	
	ds_BH_result := project(j1, transform(PRTE2_BIPV2_BusHeader.Layouts.Temporary.Layout_BusLinking, 
																				self.rcid := counter, // Assigning an unique values per record.
																				self 			:= left)
												 ): persist('~prte::persist::PRTE2_BIPV2_BusHeader::BH_Init_Final::ds_BH_result');
	
	BIPV2_Company_Names.functions.mac_go(ds_BH_result, ds_BH_result_w_cnp, rcid, company_name, false, false);
	
	//*** Finally mapping to BIP BusHeader Base layout
	PRTE2_BIPV2_BusHeader.Layouts.Base.Layout_CommonBase trfMap_To_BH_base(ds_BH_result_w_cnp l) := transform
			self.rcid														:= l.rcid;
			self.source													:= l.source;
			self.ingest_status									:= '';
			self.dotid													:= 0;																						
			self.empid													:= 0;																																							
			self.lgid3													:= 0;
																						 // For Historical IRS data, the link_fein holds the bdid and link_inc_date (made up) because of these fields being blank.
			temp_LinkIds 												:= PRTE2.fn_AppendFakeID.LinkIds( l.company_name, l.link_fein, l.link_inc_date,
																																						 l.company_address.prim_range, l.company_address.prim_name, l.company_address.sec_range,
																																						 l.company_address.v_city_name, l.company_address.st, l.company_address.zip, l.cust_name
																																					);
			self.powid													:= temp_LinkIds.powid;
			self.proxid													:= temp_LinkIds.proxid;
			self.seleid													:= temp_LinkIds.seleid;
			self.orgid													:= temp_LinkIds.orgid;
			self.ultid													:= temp_LinkIds.ultid;
			self.cnt_rcid_per_dotid							:= 0;
			self.cnt_dot_per_proxid							:= 0;
			self.cnt_prox_per_lgid3							:= 0;
			self.cnt_prox_per_powid							:= 0;
			self.cnt_dot_per_empid							:= 0;
			self.has_lgid												:= 0;
			self.is_sele_level									:= 0;
			self.is_org_level										:= 0;
			self.is_ult_level										:= 0;
			self.parent_proxid									:= 0;
			self.sele_proxid										:= 0;
			self.org_proxid											:= 0;
			self.ultimate_proxid								:= 0;
			self.levels_from_top								:= 0;
			self.nodes_below										:= 0;
			self.nodes_total										:= 0;
			self.sele_gold											:= '';
			self.ult_seg												:= '';
			self.org_seg												:= '';
			self.sele_seg												:= '';
			self.prox_seg												:= '';
			self.pow_seg												:= '';
			self.ult_prob												:= '';
			self.org_prob												:= '';
			self.sele_prob											:= '';
			self.prox_prob											:= '';
			self.pow_prob												:= '';
			self.iscontact											:= if(l.contact_name.fname<>'' and l.contact_name.lname<>'', 'T', 'F');
			self.title													:= l.contact_name.title;
			self.fname													:= l.contact_name.fname;
			self.mname													:= l.contact_name.mname;
			self.lname													:= l.contact_name.lname;
			self.name_suffix										:= l.contact_name.name_suffix;
			self.name_score											:= l.contact_name.name_score;
			self.cnp_btype											:= STD.Str.CleanSpaces(l.cnp_btype);
			self.cnp_name												:= STD.Str.CleanSpaces(l.cnp_name);
			boolean match_src 									:= MDR.sourceTools.SourceIsCorpV2(l.source);
			boolean match_typ 									:= regexfind('\\b(INC|LLC|PLLC|LLP)\\b',self.cnp_btype,nocase);
			boolean match_org 									:= regexfind('(corporation|corporate|llc|llp|sos|limited liability company|limited liability partnership)',trim(l.company_org_structure_raw,left,right),nocase);
			boolean match_ssn 									:= false;		
			self.iscorp 												:= map(match_src	=> 'T',
																								 match_typ	=> 'T',
																								 match_org	=> 'T',
																								 match_ssn	=> 'F',
																								 ''
																								 );
			self.corp_legal_name								:= if (BIPV2.BL_Tables.CompanyNameTypeDesc(l.company_name_type_raw) not in ['DBA','FBN','TRADEMARK'] and
																								 not regexfind('FICTITIOUS NAME',l.company_org_structure_raw,nocase),
																								 self.cnp_name,
																								 ''
																								 );	
			self.dba_name 											:= if(self.corp_legal_name='', self.cnp_name, '');		
			self.company_name										:= l.company_name;
			self.company_name_type_raw					:= l.company_name_type_raw;
			self.company_name_type_derived			:= BIPV2.BL_Tables.CompanyNameTypeDesc(l.company_name_type_raw);
			self.cnp_number											:= trim(l.cnp_number);
			self.cnp_hasnumber 									:= if(trim(l.cnp_number) <> '', 'T', 'F');
			self.cnp_store_number								:= trim(l.cnp_store_number);
			self.cnp_component_code							:= '';
			self.cnp_lowv												:= '';
			self.cnp_translated									:= false;
			self.cnp_classid										:= 0;
			self.company_rawaid									:= l.company_rawaid;
			self.company_aceaid									:= 0;
			self.prim_range											:= l.company_address.prim_range;
			self.predir													:= l.company_address.predir;
			self.prim_name											:= l.company_address.prim_name;
			self.prim_name_derived							:= l.company_address.prim_name; //????
			self.addr_suffix										:= l.company_address.addr_suffix;
			self.postdir												:= l.company_address.postdir;
			self.unit_desig											:= l.company_address.unit_desig;
			self.sec_range											:= l.company_address.sec_range;
			self.p_city_name										:= l.company_address.p_city_name;
			self.v_city_name										:= l.company_address.v_city_name;
			self.st															:= l.company_address.st;
			self.zip														:= l.company_address.zip;
			self.zip4														:= l.company_address.zip4;
			self.cart														:= l.company_address.cart;
			self.cr_sort_sz											:= l.company_address.cr_sort_sz;
			self.lot														:= l.company_address.lot;
			self.lot_order											:= l.company_address.lot_order;
			self.dbpc														:= l.company_address.dbpc;
			self.chk_digit											:= l.company_address.chk_digit;
			self.rec_type												:= l.company_address.rec_type;
			self.fips_state											:= l.company_address.fips_state;
			self.fips_county										:= l.company_address.fips_county;
			self.geo_lat												:= l.company_address.geo_lat;
			self.geo_long												:= l.company_address.geo_long;
			self.msa														:= l.company_address.msa;
			self.geo_blk												:= l.company_address.geo_blk;
			self.geo_match											:= l.company_address.geo_match;
			self.err_stat												:= l.company_address.err_stat;
			self.active_duns_number							:= '';
			self.hist_duns_number								:= '';
			self.active_enterprise_number				:= '';
			self.hist_enterprise_number					:= '';
			self.ebr_file_number    						:= if(MDR.sourceTools.SourceIsEBR(l.source), l.vl_id, '');
			self.active_domestic_corp_key				:= '';
			self.hist_domestic_corp_key					:= '';
			self.foreign_corp_key								:= '';
			self.unk_corp_key										:= '';
			self.dt_first_seen									:= l.dt_first_seen;
			self.dt_last_seen										:= l.dt_last_seen;
			self.dt_vendor_first_reported				:= l.dt_vendor_first_reported;
			self.dt_vendor_last_reported				:= l.dt_vendor_last_reported;
			self.company_bdid										:= l.company_bdid;
			self.company_address_type_raw				:= l.company_address_type_raw;
			self.company_fein										:= l.company_fein;
			self.best_fein_indicator						:= l.best_fein_indicator;
			self.company_phone									:= l.company_phone;
			self.phone_type											:= l.phone_type;
			self.company_org_structure_raw			:= l.company_org_structure_raw;
			self.company_incorporation_date			:= l.company_incorporation_date;
			self.company_sic_code1							:= l.company_sic_code1;
			self.company_sic_code2							:= l.company_sic_code2;
			self.company_sic_code3							:= l.company_sic_code3;
			self.company_sic_code4							:= l.company_sic_code4;
			self.company_sic_code5							:= l.company_sic_code5;
			self.company_naics_code1						:= l.company_naics_code1;
			self.company_naics_code2						:= l.company_naics_code2;
			self.company_naics_code3						:= l.company_naics_code3;
			self.company_naics_code4						:= l.company_naics_code4;
			self.company_naics_code5						:= l.company_naics_code5;
			self.company_ticker									:= l.company_ticker;
			self.company_ticker_exchange				:= l.company_ticker_exchange;
			self.company_foreign_domestic				:= l.company_foreign_domestic;
			self.company_url										:= l.company_url;
			self.company_inc_state							:= l.company_inc_state;
			self.company_charter_number					:= l.company_charter_number;
			self.company_filing_date						:= l.company_filing_date;
			self.company_status_date						:= l.company_status_date;
			self.company_foreign_date						:= l.company_foreign_date;
			self.event_filing_date							:= l.event_filing_date;
			self.company_name_status_raw				:= l.company_name_status_raw;
			self.company_status_raw							:= l.company_status_raw;
			self.dt_first_seen_company_name			:= l.dt_first_seen_company_name;
			self.dt_last_seen_company_name			:= l.dt_last_seen_company_name;
			self.dt_first_seen_company_address	:= l.dt_first_seen_company_address;
			self.dt_last_seen_company_address		:= l.dt_last_seen_company_address;
			self.vl_id													:= l.vl_id;
			self.current												:= l.current;
			self.source_record_id								:= l.source_record_id;
			self.phone_score										:= l.phone_score;
			self.duns_number										:= l.duns_number;
			self.source_docid										:= l.source_docid;
			self.dt_first_seen_contact					:= l.dt_first_seen_contact;
			self.dt_last_seen_contact						:= l.dt_last_seen_contact;
			self.contact_did										:= l.contact_did;
			self.contact_type_raw								:= l.contact_type_raw;
			self.contact_job_title_raw					:= l.contact_job_title_raw;
			self.contact_ssn										:= l.contact_ssn;
			self.contact_dob										:= l.contact_dob;
			self.contact_status_raw							:= l.contact_status_raw;
			self.contact_email									:= l.contact_email;
			self.contact_email_username					:= l.contact_email_username;
			self.contact_email_domain						:= l.contact_email_domain;
			self.contact_phone									:= l.contact_phone;
			self.from_hdr												:= l.from_hdr;
			self.company_department							:= l.company_department;
			self.company_address_type_derived		:= BIPV2.BL_Tables.AddrType(l.company_address_type_raw);
			self.company_org_structure_derived	:= BIPV2.BL_Tables.CompanyOrgStructure(l.company_org_structure_raw);
			self.company_name_status_derived		:= BIPV2.BL_Tables.CompanyNameStatusDesc(l.company_name_status_raw);
			self.company_status_derived					:= BIPV2.BL_Tables.CompanyStatusDesc(l.company_status_raw);
			self.contact_type_derived						:= BIPV2.BL_Tables.ContactTypeDesc(l.contact_type_raw);
			self.contact_job_title_derived			:= BIPV2.BL_Tables.ContactTitle(l.contact_job_title_raw);
			self.contact_status_derived					:= BIPV2.BL_Tables.ContactStatus(l.contact_status_raw);
			self.vanity_owner_did								:= 0;
			self.prim_range_derived							:= '';
			self.deleted_key										:= '';
			self.deleted_fein										:= '';
			self.proxid_status_private					:= '';
			self.powid_status_private						:= '';
			self.seleid_status_private					:= '';
			self.orgid_status_private						:= '';
			self.ultid_status_private						:= '';
			self.proxid_status_public						:= '';
			self.powid_status_public						:= '';
			self.seleid_status_public						:= '';
			self.orgid_status_public						:= '';
			self.ultid_status_public						:= '';
			self.address_type_derived						:= '';
			self.is_vanity_name_derived					:= false;
			self 																:= l;			
	end;
	
	ds_BH_base_out := project(ds_BH_result_w_cnp, trfMap_To_BH_base(left)) : persist('~prte::persist::PRTE2_BIPV2_BusHeader::BH_Init_Final');
	
	return ds_BH_base_out;
	
end;
