import BIPV2, MDR, prte_bip, ut, VersionControl;

export fn_build_prte_bip_bh_base
(
	string pname		 = '',
	string pversion  = '',	
	dataset(prte_bip.layouts.as_business_linking) infile  = prte_bip.files('abl_full_file',pversion).abl_base.new
) :=
FUNCTION

prte_bip.layouts.base X2BIPBH(prte_bip.layouts.as_business_linking l) := transform
		self.rcid														:= l.rcid;
		self.source													:= l.source;
		self.ingest_status									:= '';
		self.dotid													:= 0;																						
		self.empid													:= 0;																																							
		self.powid													:= 0;
		self.proxid													:= 0;
		self.seleid													:= 0;
		self.lgid3													:= 0;
		self.orgid													:= 0;
		self.ultid													:= 0;
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
		self.cnp_btype											:= '';
		self.cnp_name												:= '';
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
		self.cnp_number											:= '';
		self.cnp_hasnumber 									:= if(self.cnp_number <> '', 'T', 'F');
		self.cnp_store_number								:= '';
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
end;

project_infile_2_bh_layout	:= project(infile, X2BIPBH(left));

temp_layout := record
		unsigned8 	unique_id;
		prte_bip.layouts.base;
end;

project_2_temp_layout				:= project(project_infile_2_bh_layout, transform(temp_layout, self := left; self.unique_id := 0;));

ut.MAC_Sequence_Records(project_2_temp_layout, unique_id, project_infile_2_bh_layout_seq );

project_2_fakeId_layout			:= project(project_infile_2_bh_layout_seq,transform(prte_bip.Layout_Append_FakeIDs.LinkIds,self := left;));

stamp_infile_with_linkids		:= fn_Append_Fake_LinkIDs(project_2_fakeId_layout);

prte_bip.layouts.base AssignIDs(temp_layout l, prte_bip.Layout_Append_FakeIDs.LinkIds r) := transform
		self.DotID			:= r.DotID;
		self.EmpID			:= r.EmpID;
		self.POWID			:= r.POWID;
		self.ProxID			:= r.ProxID;
		self.SELEID			:= r.SELEID;	
		self.OrgID			:= r.OrgID;
		self.UltID			:= r.UltID;
		self.LgID3			:= r.LgID3;
		self 						:= l;
end;

infile_with_linkids					 := join(project_infile_2_bh_layout_seq,
																		 stamp_infile_with_linkids,
																		 left.unique_id = right.unique_id,
																		 AssignIDs(left, right),
																		 left outer
																		 );

VersionControl.macBuildNewLogicalFile(
																			prte_bip.filenames(pname,pversion).base.new, 
																			infile_with_linkids,
																			prte_bip_bh_base
																			);

return prte_bip_bh_base;

end;