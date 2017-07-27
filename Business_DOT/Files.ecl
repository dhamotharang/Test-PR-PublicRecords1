/*2013-03-20T18:24:25Z (Charles Morton)

*/
// Files -- Define, build, and reference DOT base file(s)


// --------------------------------------------------------------------------------------------
// Vern's description of the different id levels:
//
// So, we start with dots.  They are the most granular id.  A company name and address
// with a contact name and address.(and source, vendor_ids, phones, urls, email addresses
// too if available.  What else?).  Should this be renamed to be somewhat consistent with
// the other ids?  There would be many many dots that make up lexisnexis, since there would
// have to be one for each contact, and also since it is more granular than the bdid, it
// might be less fuzzy on address and name for internally linking the dots.
// 
// Then comes the legal id(lgid), which arises out of specific relationships of dots that
// we cluster together.  Each legal entity in lexisnexis would have it’s own lgid.
// 
// Then, the division id(BDL?) which is clusters of lgids(so, another spc file with lgid as
// the id and different relationships based on LNCA).  For the lexis hierarchy, this would
// be lexisnexis I would think.
// 
// Then, the top level GID, which I think will be similar to the groupid today, so for
// lexisnexis it would include all of Reed Elsevier.
// 
// So, going from more specific to less specific, DOT->LGID->BDL->GID
// --------------------------------------------------------------------------------------------


import Business_DOT, ut, AID, AID_Build, mdr, BIPV2, BIPV2_Company_Names;

export Files := module

	// ------------------------------------------------------------------------------
	// Data as received from data team
	// ------------------------------------------------------------------------------
	
	// shared l_as_linking	:= Business_Header.Layout_Business_Linking.Linking_Interface;
	// shared l_as_linking	:= Business_DOT.Layout_as_linking.l_20120720;
	// shared l_as_linking	:= Business_DOT.Layout_as_linking.l_20120817;
	// shared l_as_linking	:= Business_DOT.Layout_as_linking.l_20120905;
	// shared l_as_linking	:= Business_DOT.Layout_as_linking.l_20121102;
	
	// export ds_as_linking	:= Business_DOT.Files_as_linking.ds_20120720;
	// export ds_as_linking	:= Business_DOT.Files_as_linking.ds_20120817;
	// export ds_as_linking	:= Business_DOT.Files_as_linking.ds_20120905;
	// export ds_as_linking	:= Business_DOT.Files_as_linking.ds_20121102;

	// Prod data - not versioned
	shared l_as_linking		:= BIPV2.Layout_Business_Linking_Full;
	export ds_as_linking	:= dataset(ut.foreign_prod+'thor_data400::persist::BIPV2::BL_Init', l_as_linking, thor);
	
	export city_samp(ds_in, st_field, city_field) := macro
		ds_in(
			st_field in ['FL','OH'],
			city_field in [
				'BOCA RATON','BOCARATON','BOCA RTN','BCA RTN','DELRAY BEACH','DEL RAY BEACH','DELRAY BCH','DEL RAY BCH',
				'MIAMISBURG','DAYTON','GERMANTOWN','KETTERING','WILMINGTON']
		)
	endmacro;
	
	export ds_as_linking_samp := city_samp(ds_as_linking, company_address.st, company_address.v_city_name);
	
	export top_eight(ds_in, src_field) := macro
		ds_in(
			MDR.sourceTools.SourceIsCorpV2(src_field) OR
			MDR.sourceTools.SourceIsDCA(src_field) OR
			MDR.sourceTools.SourceIsFBNV2(src_field) OR
			MDR.sourceTools.SourceIsDunn_Bradstreet_Fein(src_field) OR // a.k.a. DNB_FEIN
			MDR.sourceTools.SourceIsEBR(src_field) OR
			MDR.sourceTools.SourceIsBusiness_Registration(src_field) OR
			MDR.sourceTools.SourceIsDunn_Bradstreet(src_field) OR // a.k.a. DNB_DMI
			MDR.sourceTools.SourceIsFrandx(src_field)
		)
	endmacro;
	
	// ------------------------------------------------------------------------------
	// Layouts needed for SALT build
	// ------------------------------------------------------------------------------
	
	export l_dot := record
		// record and business identifiers
		l_as_linking.rcid;
		BIPV2.IDlayouts.l_header_ids;
		
		// flattened version of contact_name
		string1		isContact; // T=true, F=false - indicates population
		string5		title;
		string20	fname;
		string20	mname;
		string20	lname;
		string5		name_suffix;
		string3		name_score;
		
		// Parsed company names
		string1		isCorp; // T=true, F=false, blank=unknown - indicates whether company is a corporation
		l_as_linking.company_name;
		l_as_linking.company_name_type_raw;
		l_as_linking.company_name_type_derived;
		string1		cnp_hasNumber; // T=true, F=false - indicates population of the cnp_number field
		BIPV2_Company_Names.layouts.layout_Names and not cnp_nameid;
		
		// Address IDs
		AID.Common.xAID	Company_RawAID;
		AID.Common.xAID	Company_AceAID;
		
		// flattened version of company_address
		string10	prim_range;
		string2		predir;
		string28	prim_name;
		string4		addr_suffix;
		string2		postdir;
		string10	unit_desig;
		string8		sec_range;
		string25	p_city_name;
		string25	v_city_name;
		string2		st;
		string5		zip;
		string4		zip4;
		string4		cart;
		string1		cr_sort_sz;
		string4		lot;
		string1		lot_order;
		string2		dbpc;
		string1		chk_digit;
		string2		rec_type;
		string2		fips_state;
		string3		fips_county;
		string10	geo_lat;
		string11	geo_long;
		string4		msa;
		string7		geo_blk;
		string1		geo_match;
		string4		err_stat;
		
		// derived fields (mainly required by Prox)
		string250	corp_legal_name;
		string250	dba_name;
		string9		active_duns_number;
		string9		hist_duns_number;
		string9		active_enterprise_number;
		string9		hist_enterprise_number;
		string9		ebr_file_number;
		string30	active_domestic_corp_key;
		string30	hist_domestic_corp_key;
		string30	foreign_corp_key;
		string30	unk_corp_key;
		// Taken from BIPV2_PROX_SALT_int_micro_test7.Layouts.DOT_Base
		
		// include (nearly) every field we don't cover some other way above
		l_as_linking and not [
			// flattened/rearranged
			is_contact, company_address, contact_name,
			rcid, company_name, company_name_type_raw, company_name_type_derived, company_rawaid, company_aceaid,
			
			// unused
			company_address_category, glb, dppa, match_company_name, match_branch_city, match_geo_city, cid, contact_score
			];
	end;
	
	// we may try some iterations with the bare minimum of fields
	export l_dot_thin := record
		l_dot.rcid;
		l_dot.DOTid;
		
		l_dot.source;
		l_dot.source_record_id;
		l_dot.vl_id;
		
		l_dot.isCorp;
		l_dot.company_name;
		BIPV2_Company_Names.layouts.layout_Names and not cnp_nameid;
		l_dot.company_phone;
		l_dot.company_fein;
		l_dot.company_inc_state;
		l_dot.company_charter_number;
		l_dot.company_bdid;
		
		l_dot.active_duns_number;
		l_dot.active_enterprise_number;
		l_dot.active_domestic_corp_key;
		
		l_dot.prim_range;
		l_dot.predir;
		l_dot.prim_name;
		l_dot.addr_suffix;
		l_dot.postdir;
		l_dot.unit_desig;
		l_dot.sec_range;
		l_dot.p_city_name;
		l_dot.v_city_name;
		l_dot.st;
		l_dot.zip;
		l_dot.zip4;
		l_dot.Company_ACEAID;
		
		l_dot.isContact;
		l_dot.title;
		l_dot.fname;
		l_dot.mname;
		l_dot.lname;
		l_dot.name_suffix;
		l_dot.contact_phone;
		l_dot.contact_email;
		l_dot.contact_ssn;
		
		l_dot.contact_job_title_raw;
		l_dot.contact_job_title_derived;
		l_dot.company_department;
		
		l_dot.dt_first_seen;
		l_dot.dt_last_seen;
	end;
	
	
	// ------------------------------------------------------------------------------
	// Build and retrieve the &quot;0th iteration&quot;
	// ------------------------------------------------------------------------------
	
	// convert RawAID to AceAID where we can
	// STUB - eventually will be populated in data layer?
	k_aid := AID_Build.Key_AID_Base;
	l_aid := {k_aid.RawAID; k_aid.AceAID;};
	shared dist_aid := distribute(project(pull(k_aid)(RawAID<>0,AceAID<>0),l_aid), hash32(RawAID));
	shared dataset(l_dot) SetAceAID(dataset(l_dot) ds_in) := function
		dist_dot	:= distribute(ds_in(Company_RawAID<>0), hash32(Company_RawAID));
		ds_ace		:= join(	dist_dot, dist_aid,
												left.Company_RawAID = right.RawAID,
												transform(l_dot, self.Company_AceAID:=right.AceAID, self:=left),
												left outer, keep(1), local );
		
		return ds_ace + ds_in(Company_RawAID=0);
	end;
	
	// Set parsed company name fields and detect corporations
	export dataset(l_dot) SetCompanyFields(dataset(l_dot) ds_in) := function
		BIPV2_Company_Names.functions.mac_go(ds_in, ds_out, rcid, company_name);
		
		l_dot toCnp(ds_out L) := transform
			self.cnp_hasNumber := if(L.cnp_number <> '', 'T', 'F');
			boolean match_src := MDR.sourceTools.SourceIsCorpV2(L.source);
			boolean match_typ := regexfind('\\b(INC|LLC|PLLC|LLP)\\b',L.cnp_btype,NOCASE);
      boolean match_org := regexfind('(corporation|corporate|llc|llp|sos|limited liability company|limited liability partnership)',trim(L.company_org_structure_raw,left,right),nocase);
			boolean match_ssn := false; // STUB - ???
			self.isCorp := map(
				match_src or match_typ or match_org	=> 'T',
				match_ssn														=> 'F',
				''
			);
			
			// Derived fields
			self.corp_legal_name := if(
				BIPV2.BL_Tables.CompanyNameTypeDesc(L.company_name_type_raw) not in ['DBA','FBN','TRADEMARK']
					and not regexfind('FICTITIOUS NAME',L.company_org_structure_raw,nocase),
				L.cnp_name,
				'');
			self.dba_name := if(self.corp_legal_name='', L.cnp_name, '');
			
			self := L;
		end;
		
		return project(ds_out, toCnp(left));
	end;
	
	shared l_dot flatten(l_as_linking L, unsigned C) := transform
		self.rcid									:= C; // STUB - Shouldn't this be populated in data layer?
		self.DOTid								:= self.rcid;
		self.EmpID								:= 0;
		self.POWID								:= 0;
		self.ProxID								:= 0;
		self.SELEID								:= 0;
		self.OrgID								:= 0;
		self.UltID								:= 0;
		
		self.dt_first_seen				:= ut.NormDate(L.dt_first_seen);
		self.dt_last_seen					:= ut.NormDate(L.dt_last_seen);
		
		// flatten company_address
		self.prim_range		:= L.company_address.prim_range;
		self.predir				:= L.company_address.predir;
		self.prim_name		:= L.company_address.prim_name;
		self.addr_suffix	:= L.company_address.addr_suffix;
		self.postdir			:= L.company_address.postdir;
		self.unit_desig		:= L.company_address.unit_desig;
		self.sec_range		:= L.company_address.sec_range;
		self.p_city_name	:= L.company_address.p_city_name;
		self.v_city_name	:= L.company_address.v_city_name;
		self.st						:= L.company_address.st;
		self.zip					:= L.company_address.zip;
		self.zip4					:= L.company_address.zip4;
		self.cart					:= L.company_address.cart;
		self.cr_sort_sz		:= L.company_address.cr_sort_sz;
		self.lot					:= L.company_address.lot;
		self.lot_order		:= L.company_address.lot_order;
		self.dbpc					:= L.company_address.dbpc;
		self.chk_digit		:= L.company_address.chk_digit;
		self.rec_type			:= L.company_address.rec_type;
		self.fips_state		:= L.company_address.fips_state;
		self.fips_county	:= L.company_address.fips_county;
		self.geo_lat			:= L.company_address.geo_lat;
		self.geo_long			:= L.company_address.geo_long;
		self.msa					:= L.company_address.msa;
		self.geo_blk			:= L.company_address.geo_blk;
		self.geo_match		:= L.company_address.geo_match;
		self.err_stat			:= L.company_address.err_stat;
		
		// flatten contact_name
		self.isContact		:= if(L.contact_name.fname<>'' and L.contact_name.lname<>'', 'T', 'F');
		self.title				:= L.contact_name.title;
		self.fname				:= L.contact_name.fname;
		self.mname				:= L.contact_name.mname;
		self.lname				:= L.contact_name.lname;
		self.name_suffix	:= L.contact_name.name_suffix;
		self.name_score		:= L.contact_name.name_score;
		
		// Derived fields
		self.ebr_file_number    	:= if(MDR.sourceTools.SourceIsEBR(L.source), L.vl_id, '');
		
		// we'll catch these later
		self.isCorp										:= ''; // SetCompanyFields
		self.cnp_hasNumber						:= ''; // SetCompanyFields
		self.cnp_name									:= ''; // SetCompanyFields
		self.corp_legal_name					:= ''; // SetCompanyFields
		self.dba_name									:= ''; // SetCompanyFields
		self.active_duns_number				:= ''; // SetDuns
		self.hist_duns_number					:= ''; // SetDuns
		self.active_enterprise_number	:= ''; // SetEnterprise
		self.hist_enterprise_number		:= ''; // SetEnterprise
		self.active_domestic_corp_key	:= ''; // SetSOS
		self.hist_domestic_corp_key		:= ''; // SetSOS
		self.foreign_corp_key					:= ''; // SetSOS
		self.unk_corp_key							:= ''; // SetSOS
		
		self := L;
	end;
	
	// import BIPV2_PROX_SALT_int_micro_test7;
	// shared dactive_duns    := BIPV2_PROX_SALT_int_micro_test7.file_current_Duns();
	// shared dactive_entnum  := BIPV2_PROX_SALT_int_micro_test7.file_current_LNCA();
	// shared dDEAD_SOS				:= BIPV2_PROX_SALT_int_micro_test7.file_DEAD_SOS();
	export dactive_duns		:= dataset('~thor_data400::persist::bipv2_prox_salt_int_micro_test7::file_current_duns', {string9 duns_number}, thor);
	// export dactive_entnum	:= dataset('~thor_data400::persist::BIPV2_PROX_SALT_int_micro_test7::file_current_LNCA', {string9 enterprise_num}, thor);
	export dDEAD_SOS			:= dataset('~thor_data400::persist::BIPV2_PROX_SALT_int_micro_test7::file_current_SOS', {string30 corp_key}, thor);
	
	// import dnb_dmi;
	// pFile_DNB_Base := dnb_dmi.files(,true).base.companies.qa; // foreign_prod
	// pPersistname := '~thor_data400::persist::Business_DOT::base::file_current_Duns';
	// du := pFile_DNB_Base(active_duns_number = 'Y',rawfields.duns_number != '');
	// export dactive_duns := table(du,{string9 duns_number := rawfields.duns_number},rawfields.duns_number) : persist(pPersistname);
	
	import dcav2;
	// pFile_LNCA_Base	:= dcav2.files(,true).base.companies.qa; // foreign_prod
	pFile_LNCA_Base	:= dcav2.files(,true).base.companies.qa(record_type in [dcav2.Utilities.RecordType.Updated,dcav2.Utilities.RecordType.New]);
	pPersistname		:= '~thor_data400::persist::Business_DOT::base::file_current_LNCA';
  du := pFile_LNCA_Base(rawfields.enterprise_num != '');
  export dactive_entnum := table(du,{string9 enterprise_num := rawfields.enterprise_num},rawfields.enterprise_num) : persist(pPersistname);
	
	// import corp2, paw;
	// pCorpInactives	:= PAW.fCorpInactives(,corp2.files(,,true).base.corp.qa); // foreign_prod
	// pPersistname		:= '~thor_data400::persist::Business_DOT::base::file_current_SOS';
  // du := table(pCorpInactives,{corp_key},corp_key,local);
  // export dDEAD_SOS := table(du,{corp_key},corp_key) : persist(pPersistname);	
	
	shared dataset(l_dot) SetDuns(dataset(l_dot) ds_in) := function
		l_dot toDuns(l_dot L, dactive_duns R) := transform
			self.active_duns_number	:= if(R.duns_number != '', R.duns_number,'');
			self.hist_duns_number		:= if(
				R.duns_number = ''
					and (MDR.sourceTools.SourceIsDunn_Bradstreet(L.source)
								or MDR.sourceTools.SourceIsDunn_Bradstreet_Fein(L.source)),
				L.vl_id,
				'');
			self := L;
		end;
		return join(
			distribute(ds_in,hash32(vl_id)), distribute(dactive_duns,hash32(duns_number)),
			trim(left.vl_id) = trim(right.duns_number)
				and (MDR.sourceTools.SourceIsDunn_Bradstreet(left.source)
							or MDR.sourceTools.SourceIsDunn_Bradstreet_Fein(left.source)),
			toDuns(left,right),
			left outer, local
		);
	end;
	
	shared dataset(l_dot) SetEnterprise(dataset(l_dot) ds_in) := function
		l_dot toEnt(l_dot L, dactive_entnum R) := transform
			self.active_enterprise_number	:= if(R.enterprise_num != '', R.enterprise_num, '');
			self.hist_enterprise_number		:= if(R.enterprise_num = '' and MDR.sourceTools.SourceIsDCA(L.source), L.vl_id, '');
			self := L;
		end;
		return join(
			distribute(ds_in,hash32(vl_id)), distribute(dactive_entnum,hash32(enterprise_num)),
			trim(left.vl_id) = trim(right.enterprise_num) and MDR.sourceTools.SourceIsDCA(left.source),
			toEnt(left,right),
			left outer, local
		);
	end;
	
	shared dataset(l_dot) SetSOS(dataset(l_dot) ds_in) := function
		l_dot toSOS(l_dot L, dDEAD_SOS R) := transform
			self.active_domestic_corp_key	:= if(mdr.sourcetools.sourceiscorpv2(L.source) and R.corp_key = '' and L.company_foreign_domestic = 'D', L.vl_id, '');
			self.hist_domestic_corp_key		:= if(mdr.sourcetools.sourceiscorpv2(L.source) and R.corp_key != '' and L.company_foreign_domestic = 'D', L.vl_id, '');
			self.foreign_corp_key					:= if(mdr.sourcetools.sourceiscorpv2(L.source) and L.company_foreign_domestic = 'F', L.vl_id, '');
			self.unk_corp_key							:= if(mdr.sourcetools.sourceiscorpv2(L.source) and L.company_foreign_domestic = '', L.vl_id, '');
			self := L;
		end;
		return join(
			distribute(ds_in, hash32(vl_id)), distribute(dDEAD_SOS, hash32(corp_key)),
			trim(left.vl_id) = trim(right.corp_key) and mdr.sourcetools.sourceiscorpv2(left.source),
			toSOS(left,right),
			left outer, local
		);
	end;
	
	// base files computed on-the-fly
	ds_flat := project(ds_as_linking, flatten(left,counter));
	ds_ace	:= SetAceAID(ds_flat) : persist('~thor_data400::persist::Business_DOT::base::ds_ace');
	ds_cnp	:= SetCompanyFields(ds_ace) : persist('~thor_data400::persist::Business_DOT::base::ds_cnp');
	ds_duns	:= SetDuns(ds_cnp);
	ds_ent	:= SetEnterprise(ds_duns);
	ds_sos	:= SetSOS(ds_ent);
	ds_good	:= ds_sos(cnp_name<>'');
	ds_src8	:= top_eight(ds_good,source);
	output(count(ds_sos), named('cnt_preview_total'));
	output(count(ds_good), named('cnt_preview_good'));
	output(count(ds_src8), named('cnt_preview_src8'));
	shared preview := ds_sos;
	
	ds_flat := project(ds_as_linking_samp, flatten(left,counter));
	ds_ace	:= SetAceAID(ds_flat) : persist('~thor_data400::persist::Business_DOT::base::ds_ace_samp');
	ds_cnp	:= SetCompanyFields(ds_ace) : persist('~thor_data400::persist::Business_DOT::base::ds_cnp_samp');
	ds_duns	:= SetDuns(ds_cnp);
	ds_ent	:= SetEnterprise(ds_duns);
	ds_sos	:= SetSOS(ds_ent);
	ds_good	:= ds_sos(cnp_name<>'');
	ds_src8	:= top_eight(ds_good,source);
	output(count(ds_sos), named('cnt_preview_samp_total'));
	output(count(ds_good), named('cnt_preview_samp_good'));
	output(count(ds_src8), named('cnt_preview_samp_src8'));
	shared preview_samp := ds_src8;
	
	// base files ripped from prod - generally this is now better than recomputing the derived fields in Dataland
	shared f_prodbase					:= ut.foreign_prod+'thor_data400::bipv2_dotid::base';
	export ds_prodbase				:= dataset(f_prodbase, l_dot, thor);
	export ds_prodbase_samp		:= city_samp(ds_prodbase, st, v_city_name);
	export ds_prodbase_samp2	:= ds_prodbase(st in ['OH','FL']);
	shared preview_prod				:= project(ds_prodbase, transform(l_dot, self.dotid:=left.rcid, self:=left));
	shared preview_prod_samp	:= project(ds_prodbase_samp, transform(l_dot, self.dotid:=left.rcid, self:=left));
	shared preview_prod_samp2	:= project(ds_prodbase_samp2, transform(l_dot, self.dotid:=left.rcid, self:=left));
	
	// storage for the initial base file
	// export fname_preview				:= '~thor40_241::business_dot::preview';
	// export fname_preview				:= '~thor40_241::business_dot::preview2';
	// export fname_preview				:= '~thor40_241::business_dot::preview_20120905';
	// export fname_preview				:= '~thor40_241::business_dot::preview_20121015';
	// export fname_preview				:= '~thor40_241::business_dot::preview_20121102';
	export fname_preview					:= '~thor40_241::business_dot::preview_20121119';
	// export fname_preview_samp	:= '~thor40_241::business_dot::preview_samp';
	// export fname_preview_samp	:= '~thor40_241::business_dot::preview_samp_20120817';
	// export fname_preview_samp	:= '~thor40_241::business_dot::preview_samp_20120905';
	// export fname_preview_samp	:= '~thor40_241::business_dot::preview_samp_20121015';
	// export fname_preview_samp	:= '~thor40_241::business_dot::preview_samp_20121102';
	export fname_preview_samp			:= '~thor40_241::business_dot::preview_samp_20121119';
	export fname_preview_samp2		:= '~thor40_241::business_dot::preview_samp2_20121119';
	export build_preview						:= output(preview,, fname_preview, compressed, overwrite);
	export build_preview_samp				:= output(preview_samp,, fname_preview_samp, compressed, overwrite);
	export build_preview_prod				:= output(preview_prod,, fname_preview, compressed, overwrite);
	export build_preview_prod_samp	:= output(preview_prod_samp,, fname_preview_samp, compressed, overwrite);
	export build_preview_prod_samp2	:= output(preview_prod_samp2,, fname_preview_samp2, compressed, overwrite);
	export ds_preview								:= dataset(fname_preview, l_dot, thor);
	export ds_preview_samp					:= dataset(fname_preview_samp, l_dot, thor);
	export ds_preview_samp2					:= dataset(fname_preview_samp2, l_dot, thor);
	
	
	// ------------------------------------------------------------------------------
	// Iteration file access (current layouts)
	// ------------------------------------------------------------------------------
	export l_micro31 := l_dot;
	export ds_iterN_micro31(string i) := dataset('~temp::dotid::business_dot_salt_micro31::it'+i, l_micro31, thor);
	
	
	// ------------------------------------------------------------------------------
	// Iteration file access (legacy layouts)
	// ------------------------------------------------------------------------------
	export l_int4_dot := RECORD
   unsigned6 dotid;
   unsigned6 lgid;
   unsigned6 divid;
   unsigned6 grid;
   unsigned8 company_aceaid;
   string1 iscontact;
   string2 source;
   string34 source_group;
   unsigned4 dt_first_seen;
   unsigned4 dt_last_seen;
   unsigned4 dt_vendor_first_reported;
   unsigned4 dt_vendor_last_reported;
   unsigned6 rcid;
   unsigned6 company_bdid;
   string120 company_name;
   string1 company_name_type;
   unsigned8 company_rawaid;
   string1 company_address_type;
   string9 company_fein;
   string10 company_phone;
   string1 company_org_structure;
   string1 company_derived_classification;
   unsigned4 company_incorporation_date;
   string8 company_sic_code;
   string6 company_naics_code;
   string1 company_foreign_domestic;
   string80 company_url;
   string2 company_charter_state;
   string32 company_charter_number;
   string1 company_name_status;
   unsigned4 dt_first_seen_company_name;
   unsigned4 dt_last_seen_company_name;
   unsigned4 dt_first_seen_company_address;
   unsigned4 dt_last_seen_company_address;
   string34 vendor_id;
   string34 vl_id;
   boolean current;
   unsigned8 source_record_id;
   string34 pflag;
   boolean glb;
   boolean dppa;
   unsigned6 group1_id;
   unsigned2 phone_score;
   string81 match_company_name;
   string20 match_branch_city;
   string25 match_geo_city;
   unsigned4 dt_first_seen_contact;
   unsigned4 dt_last_seen_contact;
   unsigned6 contact_did;
   string1 contact_type;
   string35 contact_job_title;
   string9 contact_ssn;
   unsigned4 contact_dob;
   string60 contact_email;
   string30 contact_email_username;
   string30 contact_email_domain;
   string10 contact_phone;
   unsigned8 cid;
   unsigned1 contact_score;
   string1 from_hdr;
   string35 company_department;
   qstring10 company_prim_range;
   string2 company_predir;
   qstring28 company_prim_name;
   qstring4 company_addr_suffix;
   string2 company_postdir;
   qstring10 company_unit_desig;
   qstring8 company_sec_range;
   qstring25 company_p_city_name;
   qstring25 company_v_city_name;
   string2 company_st;
   qstring5 company_zip5;
   qstring4 company_zip4;
   string5 contact_title;
   string20 contact_fname;
   string20 contact_mname;
   string20 contact_lname;
   string5 contact_name_suffix;
  END;

	export l_int4 := RECORD(l_int4_dot)
		string250 cnp_name;
		string10 cnp_number;
		string10 cnp_btype;
		string20 cnp_lowv;
		boolean cnp_translated;
		integer4 cnp_classid;
		string1 hasnumber;
	END;

	export l_micro4_dot := RECORD
		unsigned6 dotid;
		unsigned6 lgid;
		unsigned6 divid;
		unsigned6 grid;
		unsigned8 company_aceaid;
		string1 iscontact;
		string2 source;
		string34 source_group;
		unsigned4 dt_first_seen;
		unsigned4 dt_last_seen;
		unsigned4 dt_vendor_first_reported;
		unsigned4 dt_vendor_last_reported;
		unsigned6 rcid;
		unsigned6 company_bdid;
		string120 company_name;
		string1 company_name_type;
		unsigned8 company_rawaid;
		string1 company_address_type;
		string9 company_fein;
		string10 company_phone;
		string1 company_org_structure;
		string1 company_derived_classification;
		unsigned4 company_incorporation_date;
		string8 company_sic_code;
		string6 company_naics_code;
		string1 company_foreign_domestic;
		string80 company_url;
		string2 company_charter_state;
		string32 company_charter_number;
		string1 company_name_status;
		unsigned4 dt_first_seen_company_name;
		unsigned4 dt_last_seen_company_name;
		unsigned4 dt_first_seen_company_address;
		unsigned4 dt_last_seen_company_address;
		string34 vendor_id;
		string34 vl_id;
		boolean current;
		unsigned8 source_record_id;
		string34 pflag;
		boolean glb;
		boolean dppa;
		unsigned6 group1_id;
		unsigned2 phone_score;
		string81 match_company_name;
		string20 match_branch_city;
		string25 match_geo_city;
		unsigned4 dt_first_seen_contact;
		unsigned4 dt_last_seen_contact;
		unsigned6 contact_did;
		string1 contact_type;
		string35 contact_job_title;
		string9 contact_ssn;
		unsigned4 contact_dob;
		string60 contact_email;
		string30 contact_email_username;
		string30 contact_email_domain;
		string10 contact_phone;
		unsigned8 cid;
		unsigned1 contact_score;
		string1 from_hdr;
		string35 company_department;
		qstring10 company_prim_range;
		string2 company_predir;
		qstring28 company_prim_name;
		qstring4 company_addr_suffix;
		string2 company_postdir;
		qstring10 company_unit_desig;
		qstring8 company_sec_range;
		qstring25 company_p_city_name;
		qstring25 company_v_city_name;
		string2 company_st;
		qstring5 company_zip5;
		qstring4 company_zip4;
		string5 contact_title;
		string20 contact_fname;
		string20 contact_mname;
		string20 contact_lname;
		string5 contact_name_suffix;
	end;
	
	export l_micro4 := record(l_micro4_dot)
		string250 cnp_name;
		string10 cnp_number;
		string10 cnp_btype;
		string20 cnp_lowv;
		boolean cnp_translated;
		integer4 cnp_classid;
		string1 hasnumber;
	END;

	export l_micro9 := RECORD // was l_cnPlusW
		unsigned6 dotid;
		unsigned6 sdotid;
		unsigned6 lgid;
		unsigned6 divid;
		unsigned6 grid;
		unsigned8 company_aceaid;
		string1 iscontact;
		string2 source;
		string34 source_group;
		unsigned4 dt_first_seen;
		unsigned4 dt_last_seen;
		unsigned4 dt_vendor_first_reported;
		unsigned4 dt_vendor_last_reported;
		unsigned6 rcid;
		unsigned6 company_bdid;
		string120 company_name;
		string1 company_name_type;
		unsigned8 company_rawaid;
		string1 company_address_type;
		string9 company_fein;
		string10 company_phone;
		string1 company_org_structure;
		string1 company_derived_classification;
		unsigned4 company_incorporation_date;
		string8 company_sic_code;
		string6 company_naics_code;
		string1 company_foreign_domestic;
		string80 company_url;
		string2 company_charter_state;
		string32 company_charter_number;
		string1 company_name_status;
		unsigned4 dt_first_seen_company_name;
		unsigned4 dt_last_seen_company_name;
		unsigned4 dt_first_seen_company_address;
		unsigned4 dt_last_seen_company_address;
		string34 vendor_id;
		string34 vl_id;
		boolean current;
		unsigned8 source_record_id;
		string34 pflag;
		boolean glb;
		boolean dppa;
		unsigned6 group1_id;
		unsigned2 phone_score;
		string81 match_company_name;
		string20 match_branch_city;
		string25 match_geo_city;
		unsigned4 dt_first_seen_contact;
		unsigned4 dt_last_seen_contact;
		unsigned6 contact_did;
		string1 contact_type;
		string35 contact_job_title;
		string9 contact_ssn;
		unsigned4 contact_dob;
		string60 contact_email;
		string30 contact_email_username;
		string30 contact_email_domain;
		string10 contact_phone;
		unsigned8 cid;
		unsigned1 contact_score;
		string1 from_hdr;
		string35 company_department;
		qstring10 company_prim_range;
		string2 company_predir;
		qstring28 company_prim_name;
		qstring4 company_addr_suffix;
		string2 company_postdir;
		qstring10 company_unit_desig;
		qstring8 company_sec_range;
		qstring25 company_p_city_name;
		qstring25 company_v_city_name;
		string2 company_st;
		qstring5 company_zip5;
		qstring4 company_zip4;
		string5 contact_title;
		string20 contact_fname;
		string20 contact_mname;
		string20 contact_lname;
		string5 contact_name_suffix;
		string250 cnp_name;
		string10 cnp_number;
		string10 cnp_btype;
		string20 cnp_lowv;
		boolean cnp_translated;
		integer4 cnp_classid;
		string1 hasnumber;
	END;
	
	export l_micro10 := RECORD
		unsigned6 dotid;
		unsigned6 sdotid;
		unsigned6 lgid;
		unsigned6 divid;
		unsigned6 grid;
		unsigned8 company_aceaid;
		string1 iscontact;
		string2 source;
		string34 source_group;
		unsigned4 dt_first_seen;
		unsigned4 dt_last_seen;
		unsigned4 dt_vendor_first_reported;
		unsigned4 dt_vendor_last_reported;
		unsigned6 rcid;
		unsigned6 company_bdid;
		string120 company_name;
		string30 company_name_type;
		unsigned8 company_rawaid;
		string1 company_address_type;
		string9 company_fein;
		string10 company_phone;
		string50 company_org_structure;
		string1 company_derived_classification;
		unsigned4 company_incorporation_date;
		string8 company_sic_code;
		string6 company_naics_code;
		string1 company_foreign_domestic;
		string80 company_url;
		string2 company_charter_state;
		string32 company_charter_number;
		string1 company_name_status;
		unsigned4 dt_first_seen_company_name;
		unsigned4 dt_last_seen_company_name;
		unsigned4 dt_first_seen_company_address;
		unsigned4 dt_last_seen_company_address;
		string34 vendor_id;
		string34 vl_id;
		boolean current;
		unsigned8 source_record_id;
		string34 pflag;
		boolean glb;
		boolean dppa;
		unsigned6 group1_id;
		unsigned2 phone_score;
		string81 match_company_name;
		string20 match_branch_city;
		string25 match_geo_city;
		unsigned4 dt_first_seen_contact;
		unsigned4 dt_last_seen_contact;
		unsigned6 contact_did;
		string1 contact_type;
		string35 contact_job_title;
		string9 contact_ssn;
		unsigned4 contact_dob;
		string60 contact_email;
		string30 contact_email_username;
		string30 contact_email_domain;
		string10 contact_phone;
		unsigned8 cid;
		unsigned1 contact_score;
		string1 from_hdr;
		string35 company_department;
		qstring10 company_prim_range;
		string2 company_predir;
		qstring28 company_prim_name;
		qstring4 company_addr_suffix;
		string2 company_postdir;
		qstring10 company_unit_desig;
		qstring8 company_sec_range;
		qstring25 company_p_city_name;
		qstring25 company_v_city_name;
		string2 company_st;
		qstring5 company_zip5;
		qstring4 company_zip4;
		string5 contact_title;
		string20 contact_fname;
		string20 contact_mname;
		string20 contact_lname;
		string5 contact_name_suffix;
		string250 cnp_name;
		string10 cnp_number;
		string10 cnp_btype;
		string20 cnp_lowv;
		boolean cnp_translated;
		integer4 cnp_classid;
		string1 hasnumber;
	END;
	
	export l_micro12	:= l_micro10;
	export l_int5			:= l_micro10;
	
	export l_micro13	:= RECORD
		unsigned6 rcid;
		unsigned6 dotid;
		unsigned6 empid;
		unsigned6 powid;
		unsigned6 proxid;
		unsigned6 orgid;
		unsigned6 ultid;
		string1 iscontact;
		string5 contact_title;
		string20 contact_fname;
		string20 contact_mname;
		string20 contact_lname;
		string5 contact_name_suffix;
		string1 iscorp;
		string120 company_name;
		string30 company_name_type;
		string1 cnp_hasnumber;
		string250 cnp_name;
		string10 cnp_number;
		string10 cnp_btype;
		string20 cnp_lowv;
		boolean cnp_translated;
		integer4 cnp_classid;
		unsigned8 company_rawaid;
		unsigned8 company_aceaid;
		qstring10 company_prim_range;
		string2 company_predir;
		qstring28 company_prim_name;
		qstring4 company_addr_suffix;
		string2 company_postdir;
		qstring10 company_unit_desig;
		qstring8 company_sec_range;
		qstring25 company_p_city_name;
		qstring25 company_v_city_name;
		string2 company_st;
		qstring5 company_zip5;
		qstring4 company_zip4;
		string2 source;
		string34 source_group;
		unsigned4 dt_first_seen;
		unsigned4 dt_last_seen;
		unsigned4 dt_vendor_first_reported;
		unsigned4 dt_vendor_last_reported;
		unsigned6 company_bdid;
		string1 company_address_type;
		string1 company_address_category;
		string9 company_fein;
		string10 company_phone;
		string50 company_org_structure;
		string1 company_derived_classification;
		unsigned4 company_incorporation_date;
		string8 company_sic_code;
		string6 company_naics_code;
		string1 company_foreign_domestic;
		string80 company_url;
		string2 company_charter_state;
		string32 company_charter_number;
		string1 company_name_status;
		unsigned4 dt_first_seen_company_name;
		unsigned4 dt_last_seen_company_name;
		unsigned4 dt_first_seen_company_address;
		unsigned4 dt_last_seen_company_address;
		string34 vendor_id;
		string34 vl_id;
		boolean current;
		unsigned8 source_record_id;
		string34 pflag;
		boolean glb;
		boolean dppa;
		unsigned6 group1_id;
		unsigned2 phone_score;
		string81 match_company_name;
		string20 match_branch_city;
		string25 match_geo_city;
		unsigned4 dt_first_seen_contact;
		unsigned4 dt_last_seen_contact;
		unsigned6 contact_did;
		string1 contact_type;
		string35 contact_job_title;
		string9 contact_ssn;
		unsigned4 contact_dob;
		string60 contact_email;
		string30 contact_email_username;
		string30 contact_email_domain;
		string10 contact_phone;
		unsigned8 cid;
		unsigned1 contact_score;
		string1 from_hdr;
		string35 company_department;
	END;
	export l_int6			:= l_micro13;

	export l_micro14 := RECORD
		unsigned6 rcid;
		unsigned6 dotid;
		unsigned6 empid;
		unsigned6 powid;
		unsigned6 proxid;
		unsigned6 orgid;
		unsigned6 ultid;
		string1 iscontact;
		string5 contact_title;
		string20 contact_fname;
		string20 contact_mname;
		string20 contact_lname;
		string5 contact_name_suffix;
		string1 iscorp;
		string120 company_name;
		string30 company_name_type_raw;
		string30 company_name_type_derived;
		string1 cnp_hasnumber;
		string250 cnp_name;
		string10 cnp_number;
		string10 cnp_btype;
		string20 cnp_lowv;
		boolean cnp_translated;
		integer4 cnp_classid;
		unsigned8 company_rawaid;
		unsigned8 company_aceaid;
		qstring10 company_prim_range;
		string2 company_predir;
		qstring28 company_prim_name;
		qstring4 company_addr_suffix;
		string2 company_postdir;
		qstring10 company_unit_desig;
		qstring8 company_sec_range;
		qstring25 company_p_city_name;
		qstring25 company_v_city_name;
		string2 company_st;
		qstring5 company_zip5;
		qstring4 company_zip4;
		string2 source;
		unsigned4 dt_first_seen;
		unsigned4 dt_last_seen;
		unsigned4 dt_vendor_first_reported;
		unsigned4 dt_vendor_last_reported;
		unsigned6 company_bdid;
		string30 company_address_type_raw;
		string1 company_address_category;
		string9 company_fein;
		string1 best_fein_indicator;
		string10 company_phone;
		string1 phone_type;
		string50 company_org_structure_raw;
		unsigned4 company_incorporation_date;
		string8 company_sic_code1;
		string8 company_sic_code2;
		string8 company_sic_code3;
		string8 company_sic_code4;
		string8 company_sic_code5;
		string6 company_naics_code1;
		string6 company_naics_code2;
		string6 company_naics_code3;
		string6 company_naics_code4;
		string6 company_naics_code5;
		string6 company_ticker;
		string6 company_ticker_exchange;
		string1 company_foreign_domestic;
		string80 company_url;
		string2 company_inc_state;
		string32 company_charter_number;
		unsigned4 company_filing_date;
		unsigned4 company_status_date;
		unsigned4 company_foreign_date;
		unsigned4 event_filing_date;
		string30 company_name_status_raw;
		string30 company_status_raw;
		unsigned4 dt_first_seen_company_name;
		unsigned4 dt_last_seen_company_name;
		unsigned4 dt_first_seen_company_address;
		unsigned4 dt_last_seen_company_address;
		string34 vl_id;
		boolean current;
		unsigned8 source_record_id;
		boolean glb;
		boolean dppa;
		unsigned2 phone_score;
		string81 match_company_name;
		string20 match_branch_city;
		string25 match_geo_city;
		unsigned4 dt_first_seen_contact;
		unsigned4 dt_last_seen_contact;
		unsigned6 contact_did;
		string30 contact_type_raw;
		string35 contact_job_title_raw;
		string9 contact_ssn;
		unsigned4 contact_dob;
		string30 contact_status_raw;
		string60 contact_email;
		string30 contact_email_username;
		string30 contact_email_domain;
		string10 contact_phone;
		unsigned8 cid;
		unsigned1 contact_score;
		string1 from_hdr;
		string35 company_department;
		string30 company_address_type_derived;
		string50 company_org_structure_derived;
		string30 company_name_status_derived;
		string30 contact_type_derived;
		string30 contact_job_title_derived;
		string30 contact_status_derived;
	END;
	export l_micro15 := l_micro14;
	export l_micro16 := l_micro14;
	export l_micro17 := l_micro14;
	export l_micro18 := l_micro14;
	export l_micro19 := l_micro14;

	export l_micro20 := RECORD
		unsigned6 rcid;
		unsigned6 dotid;
		unsigned6 empid;
		unsigned6 powid;
		unsigned6 proxid;
		unsigned6 orgid;
		unsigned6 ultid;
		string1 iscontact;
		string5 contact_title;
		string20 contact_fname;
		string20 contact_mname;
		string20 contact_lname;
		string5 contact_name_suffix;
		string3 contact_name_score;
		string1 iscorp;
		string120 company_name;
		string30 company_name_type_raw;
		string30 company_name_type_derived;
		string1 cnp_hasnumber;
		string250 cnp_name;
		string10 cnp_number;
		string10 cnp_btype;
		string20 cnp_lowv;
		boolean cnp_translated;
		integer4 cnp_classid;
		unsigned8 company_rawaid;
		unsigned8 company_aceaid;
		qstring10 company_prim_range;
		string2 company_predir;
		qstring28 company_prim_name;
		qstring4 company_addr_suffix;
		string2 company_postdir;
		qstring10 company_unit_desig;
		qstring8 company_sec_range;
		qstring25 company_p_city_name;
		qstring25 company_v_city_name;
		string2 company_st;
		qstring5 company_zip5;
		qstring4 company_zip4;
		qstring4 company_cart;
		string1 company_cr_sort_sz;
		qstring4 company_lot;
		string1 company_lot_order;
		string2 company_dbpc;
		string1 company_chk_digit;
		string2 company_rec_type;
		qstring5 company_county;
		qstring10 company_geo_lat;
		qstring11 company_geo_long;
		qstring4 company_msa;
		qstring7 company_geo_blk;
		string1 company_geo_match;
		qstring4 company_err_stat;
		unsigned1 company_clean_errors;
		string250 corp_legal_name;
		string250 dba_name;
		string9 active_duns_number;
		string9 hist_duns_number;
		string9 active_enterprise_number;
		string9 hist_enterprise_number;
		string9 ebr_file_number;
		string30 active_domestic_corp_key;
		string30 hist_domestic_corp_key;
		string30 foreign_corp_key;
		string30 unk_corp_key;
		string2 source;
		unsigned4 dt_first_seen;
		unsigned4 dt_last_seen;
		unsigned4 dt_vendor_first_reported;
		unsigned4 dt_vendor_last_reported;
		unsigned6 company_bdid;
		string30 company_address_type_raw;
		string1 company_address_category;
		string9 company_fein;
		string1 best_fein_indicator;
		string10 company_phone;
		string1 phone_type;
		string50 company_org_structure_raw;
		unsigned4 company_incorporation_date;
		string8 company_sic_code1;
		string8 company_sic_code2;
		string8 company_sic_code3;
		string8 company_sic_code4;
		string8 company_sic_code5;
		string6 company_naics_code1;
		string6 company_naics_code2;
		string6 company_naics_code3;
		string6 company_naics_code4;
		string6 company_naics_code5;
		string6 company_ticker;
		string6 company_ticker_exchange;
		string1 company_foreign_domestic;
		string80 company_url;
		string2 company_inc_state;
		string32 company_charter_number;
		unsigned4 company_filing_date;
		unsigned4 company_status_date;
		unsigned4 company_foreign_date;
		unsigned4 event_filing_date;
		string30 company_name_status_raw;
		string30 company_status_raw;
		unsigned4 dt_first_seen_company_name;
		unsigned4 dt_last_seen_company_name;
		unsigned4 dt_first_seen_company_address;
		unsigned4 dt_last_seen_company_address;
		string34 vl_id;
		boolean current;
		unsigned8 source_record_id;
		boolean glb;
		boolean dppa;
		unsigned2 phone_score;
		string81 match_company_name;
		string20 match_branch_city;
		string25 match_geo_city;
		unsigned4 dt_first_seen_contact;
		unsigned4 dt_last_seen_contact;
		unsigned6 contact_did;
		string30 contact_type_raw;
		string35 contact_job_title_raw;
		string9 contact_ssn;
		unsigned4 contact_dob;
		string30 contact_status_raw;
		string60 contact_email;
		string30 contact_email_username;
		string30 contact_email_domain;
		string10 contact_phone;
		unsigned8 cid;
		unsigned1 contact_score;
		string1 from_hdr;
		string35 company_department;
		string30 company_address_type_derived;
		string50 company_org_structure_derived;
		string30 company_name_status_derived;
		string30 contact_type_derived;
		string30 contact_job_title_derived;
		string30 contact_status_derived;
	END;
	export l_micro21 := l_micro20;
	export l_micro22 := l_micro20;
	export l_micro23 := l_micro20;
	export l_int7 := l_micro20;
	
	export l_micro24 := RECORD
		unsigned6 rcid;
		unsigned6 dotid;
		unsigned6 empid;
		unsigned6 powid;
		unsigned6 proxid;
		unsigned6 orgid;
		unsigned6 ultid;
		string1 iscontact;
		string5 contact_title;
		string20 contact_fname;
		string20 contact_mname;
		string20 contact_lname;
		string5 contact_name_suffix;
		string3 contact_name_score;
		string1 iscorp;
		string120 company_name;
		string50 company_name_type_raw;
		string50 company_name_type_derived;
		string1 cnp_hasnumber;
		string250 cnp_name;
		string10 cnp_number;
		string10 cnp_btype;
		string20 cnp_lowv;
		boolean cnp_translated;
		integer4 cnp_classid;
		unsigned8 company_rawaid;
		unsigned8 company_aceaid;
		string10 company_prim_range;
		string2 company_predir;
		string28 company_prim_name;
		string4 company_addr_suffix;
		string2 company_postdir;
		string10 company_unit_desig;
		string8 company_sec_range;
		string25 company_p_city_name;
		string25 company_v_city_name;
		string2 company_st;
		string5 company_zip;
		string4 company_zip4;
		string4 company_cart;
		string1 company_cr_sort_sz;
		string4 company_lot;
		string1 company_lot_order;
		string2 company_dbpc;
		string1 company_chk_digit;
		string2 company_rec_type;
		string2 company_fips_state;
		string3 company_fips_county;
		string10 company_geo_lat;
		string11 company_geo_long;
		string4 company_msa;
		string7 company_geo_blk;
		string1 company_geo_match;
		string4 company_err_stat;
		string250 corp_legal_name;
		string250 dba_name;
		string9 active_duns_number;
		string9 hist_duns_number;
		string9 active_enterprise_number;
		string9 hist_enterprise_number;
		string9 ebr_file_number;
		string30 active_domestic_corp_key;
		string30 hist_domestic_corp_key;
		string30 foreign_corp_key;
		string30 unk_corp_key;
		string2 source;
		unsigned4 dt_first_seen;
		unsigned4 dt_last_seen;
		unsigned4 dt_vendor_first_reported;
		unsigned4 dt_vendor_last_reported;
		unsigned6 company_bdid;
		string50 company_address_type_raw;
		string9 company_fein;
		string1 best_fein_indicator;
		string10 company_phone;
		string1 phone_type;
		string60 company_org_structure_raw;
		unsigned4 company_incorporation_date;
		string8 company_sic_code1;
		string8 company_sic_code2;
		string8 company_sic_code3;
		string8 company_sic_code4;
		string8 company_sic_code5;
		string6 company_naics_code1;
		string6 company_naics_code2;
		string6 company_naics_code3;
		string6 company_naics_code4;
		string6 company_naics_code5;
		string6 company_ticker;
		string6 company_ticker_exchange;
		string1 company_foreign_domestic;
		string80 company_url;
		string2 company_inc_state;
		string32 company_charter_number;
		unsigned4 company_filing_date;
		unsigned4 company_status_date;
		unsigned4 company_foreign_date;
		unsigned4 event_filing_date;
		string50 company_name_status_raw;
		string50 company_status_raw;
		unsigned4 dt_first_seen_company_name;
		unsigned4 dt_last_seen_company_name;
		unsigned4 dt_first_seen_company_address;
		unsigned4 dt_last_seen_company_address;
		string34 vl_id;
		boolean current;
		unsigned8 source_record_id;
		unsigned2 phone_score;
		unsigned4 dt_first_seen_contact;
		unsigned4 dt_last_seen_contact;
		unsigned6 contact_did;
		string50 contact_type_raw;
		string50 contact_job_title_raw;
		string9 contact_ssn;
		unsigned4 contact_dob;
		string30 contact_status_raw;
		string60 contact_email;
		string30 contact_email_username;
		string30 contact_email_domain;
		string10 contact_phone;
		string1 from_hdr;
		string35 company_department;
		string50 company_address_type_derived;
		string60 company_org_structure_derived;
		string50 company_name_status_derived;
		string50 company_status_derived;
		string50 contact_type_derived;
		string50 contact_job_title_derived;
		string30 contact_status_derived;
	END;
	export l_micro25 := l_micro24;
	
	export l_micro26 := l_dot and not seleid;
	export l_micro27 := l_micro26;
	export l_micro28 := l_micro26;
	export l_micro29 := record(l_micro26)
		string4 src_partition;
	end;
	export l_micro30 := l_micro26;
	
	export ds_iterN_micro4(string i) := dataset('~temp::dotid::business_dot_salt_micro4::it'+i, l_micro4, thor);
	export ds_iterN_micro5(string i) := dataset('~temp::dotid::business_dot_salt_micro5::it'+i, l_micro4, thor);
	export ds_iterN_micro6(string i) := dataset('~temp::dotid::business_dot_salt_micro6::it'+i, l_micro4, thor);
	export ds_iterN_micro7(string i) := dataset('~temp::dotid::business_dot_salt_micro7::it'+i, l_micro4, thor);
	export ds_iterN_micro8(string i) := dataset('~temp::dotid::business_dot_salt_micro8::it'+i, l_micro4, thor);
	export ds_iterN_micro9(string i) := dataset('~temp::dotid::business_dot_salt_micro9::it'+i, l_micro9, thor);
	export ds_iterN_micro10(string i) := dataset('~temp::dotid::business_dot_salt_micro10::it'+i, l_micro10, thor);
	export ds_iterN_micro12(string i) := dataset('~temp::dotid::business_dot_salt_micro12::it'+i, l_micro12, thor);
	export ds_iterN_micro13(string i) := dataset('~temp::dotid::business_dot_salt_micro13::it'+i, l_micro13, thor);
	export ds_iterN_micro14(string i) := dataset('~temp::dotid::business_dot_salt_micro14::it'+i, l_micro14, thor);
	export ds_iterN_micro15(string i) := dataset('~temp::dotid::business_dot_salt_micro15::it'+i, l_micro15, thor);
	export ds_iterN_micro16(string i) := dataset('~temp::dotid::business_dot_salt_micro16::it'+i, l_micro16, thor);
	export ds_iterN_micro17(string i) := dataset('~temp::dotid::business_dot_salt_micro17::it'+i, l_micro17, thor);
	export ds_iterN_micro18(string i) := dataset('~temp::dotid::business_dot_salt_micro18::it'+i, l_micro18, thor);
	export ds_iterN_micro19(string i) := dataset('~temp::dotid::business_dot_salt_micro19::it'+i, l_micro19, thor);
	export ds_iterN_micro20(string i) := dataset('~temp::dotid::business_dot_salt_micro20::it'+i, l_micro20, thor);
	export ds_iterN_micro21(string i) := dataset('~temp::dotid::business_dot_salt_micro21::it'+i, l_micro21, thor);
	export ds_iterN_micro22(string i) := dataset('~temp::dotid::business_dot_salt_micro22::it'+i, l_micro22, thor);
	export ds_iterN_micro23(string i) := dataset('~temp::dotid::business_dot_salt_micro23::it'+i, l_micro23, thor);
	export ds_iterN_micro24(string i) := dataset('~temp::dotid::business_dot_salt_micro24::it'+i, l_micro24, thor);
	export ds_iterN_micro25(string i) := dataset('~temp::dotid::business_dot_salt_micro25::it'+i, l_micro25, thor);
	export ds_iterN_micro26(string i) := dataset('~temp::dotid::business_dot_salt_micro26::it'+i, l_micro26, thor);
	export ds_iterN_micro27(string i) := dataset('~temp::dotid::business_dot_salt_micro27::it'+i, l_micro27, thor);
	export ds_iterN_micro28(string i) := dataset('~temp::dotid::business_dot_salt_micro28::it'+i, l_micro28, thor);
	export ds_iterN_micro29(string i) := dataset('~temp::dotid::business_dot_salt_micro29::it'+i, l_micro29, thor);
	export ds_iterN_micro30(string i) := dataset('~temp::dotid::business_dot_salt_micro30::it'+i, l_micro30, thor);	
	
	export ds_iterN_int4(string i) := dataset('~temp::dotid::business_dot_salt_int4::it'+i, l_int4, thor);
	export ds_iterN_int5(string i) := dataset('~temp::dotid::business_dot_salt_int5::it'+i, l_int5, thor);
	export ds_iterN_int6(string i) := dataset('~temp::dotid::business_dot_salt_int6::it'+i, l_int6, thor);
	export ds_iterN_int7(string i) := dataset('~temp::dotid::business_dot_salt_int7::it'+i, l_int7, thor);
	
	
	export l_micro26 m20_to_m26(l_micro20 L) := transform
		self.prim_range		:= L.company_prim_range;
		self.predir				:= L.company_predir;
		self.prim_name		:= L.company_prim_name;
		self.addr_suffix	:= L.company_addr_suffix;
		self.postdir			:= L.company_postdir;
		self.unit_desig		:= L.company_unit_desig;
		self.sec_range		:= L.company_sec_range;
		self.p_city_name	:= L.company_p_city_name;
		self.v_city_name	:= L.company_v_city_name;
		self.st						:= L.company_st;
		self.zip					:= L.company_zip5;
		self.zip4					:= L.company_zip4;
		self.cart					:= L.company_cart;
		self.cr_sort_sz		:= L.company_cr_sort_sz;
		self.lot					:= L.company_lot;
		self.lot_order		:= L.company_lot_order;
		self.dbpc					:= L.company_dbpc;
		self.chk_digit		:= L.company_chk_digit;
		self.rec_type			:= L.company_rec_type;
		self.geo_lat			:= L.company_geo_lat;
		self.geo_long			:= L.company_geo_long;
		self.msa					:= L.company_msa;
		self.geo_blk			:= L.company_geo_blk;
		self.geo_match		:= L.company_geo_match;
		self.err_stat			:= L.company_err_stat;

		self.title				:= L.contact_title;
		self.fname				:= L.contact_fname;
		self.mname				:= L.contact_mname;
		self.lname				:= L.contact_lname;
		self.name_suffix	:= L.contact_name_suffix;
		self.name_score		:= L.contact_name_score;
		
		self := L;
		
		self.fips_state							:= ut.st2FipsCode(L.company_st);
		self.fips_county						:= if(length(trim(L.company_county))=5, L.company_county[3..5], L.company_county);
		self.company_status_derived := L.company_status_raw;
	end;

end;
