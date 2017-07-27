// ================================================================================
// ===== RETURNS Other Source Doc records in an ESP-COMPLIANT WAY ====
// ================================================================================
IMPORT iesp, BIPV2, BIPV2_Build, TopBusiness_BIPV2; 


EXPORT OtherSource_Records (
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false
	,dataset(TopBusiness_Services.Layouts.rec_busHeaderLayout) ds_bh_keyrecs) 
	
 := MODULE
 	
	SHARED other_recs_layout := RECORD
		unsigned6 group_source_recID;
		string group_source;
		TopBusiness_BIPV2.Layouts.rec_other_directories_layout;
	END;
		
  SHARED in_docids_WIdValue := in_docids(idValue != '');		
 
	// Transform passed docids to necessary layout for linkid key lookup
	in_docs_link := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																													SELF := LEFT,
																													SELF := []));
																																		
	// Get the "other" data from the linkid file. Since there isn't a key on the source_doc, the fetch 
	// will first be on linkids, then a filter will be done via the source doc value.
	SHARED other_recs_link := BIPV2_Build.key_directories_linkids.KFetch(in_docs_link,inoptions.fetch_level,,,
	TopBusiness_Services.Constants.DirectoriesKfetchMaxLimit);
	
	// Match on source,idvalue and idtype. There isn't an vl_id field for the industry section, so
	// a no match on vl_id exists.
	SHARED other_recs_idLev := JOIN(other_recs_link,in_docids_WIdValue,
	                 BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND	                			
									 ((left.industry_fields.source = right.Source 
												AND left.industry_fields.source_rec_id = (integer) right.IdValue) OR
										 (left.contacts_fields.source = right.Source AND right.IdType = Constants.busvlid
											  AND left.contacts_fields.vl_id = right.IdValue) OR
										 (left.contacts_fields.source = right.Source AND right.idType = Constants.sourcerecid
											  AND left.contacts_fields.source_record_id = (integer) right.IdValue)),
										TRANSFORM(LEFT));
	
	// Capture records that there wasn't a match in the directories linkid key.
	SHARED missing_idLev := JOIN(other_recs_idLev,in_docids_WIdValue,
												BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND	                			
											((left.industry_fields.source = right.Source 
												AND left.industry_fields.source_rec_id = (integer) right.IdValue) OR
											(left.contacts_fields.source = right.Source AND right.IdType = Constants.busvlid
											  AND left.contacts_fields.vl_id = right.IdValue) OR
											(left.contacts_fields.source = right.Source AND right.idType = Constants.sourcerecid
											  AND left.contacts_fields.source_record_id = (integer) right.IdValue)),
												TRANSFORM(RIGHT),
												RIGHT ONLY);
	
	SHARED other_recs_srcLev := JOIN(other_recs_link,in_docids(idValue = ''),
	                 BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND	                			
									 ((left.industry_fields.source = right.Source) OR
										 (left.contacts_fields.source = right.Source)),
										TRANSFORM(LEFT));
	
	SHARED other_recs_comb := other_recs_idLev+other_recs_srcLev;
	
	 SHARED busHead_recs_link := ds_bh_keyrecs;
	// The industry records don't have company name and address info, pull this info from the 
	// business header linkid key.
	SHARED other_recs_ind := JOIN(other_recs_comb(rec_type = 'I'),busHead_recs_link,
																BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND
																LEFT.industry_fields.source = RIGHT.Source 
																AND left.industry_fields.source_rec_id = right.source_record_id,
																TRANSFORM(recordof(other_recs_comb),
																						SELF.contacts_fields.company_name := RIGHT.company_name,
																						SELF.contacts_fields.company_phone := RIGHT.company_phone,
																						SELF.contacts_fields.company_fein := RIGHT.company_fein,
																						SELF.contacts_fields.company_address := RIGHT,
																						SELF := LEFT),
																LEFT OUTER,
																KEEP(1));
	
	// For the missing id Lev records, pull info from business header
	SHARED other_recs_miss := JOIN(missing_idLev,busHead_recs_link,
																BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND
																left.Source = right.Source AND
																((left.IdValue = right.vl_id AND left.Idtype = Constants.busvlid) OR
																(left.IdValue = (string) right.source_record_id AND left.Idtype = Constants.sourcerecid)),
																TRANSFORM(recordof(other_recs_comb),
																						SELF.rec_type := 'C', // Picking 'C'ontact since using contact fields
																						SELF.contacts_fields.company_address := RIGHT,
																						SELF.contacts_fields := RIGHT,
																						SELF := LEFT,
																						SELF := []),
																KEEP(1));
																
	other_recs := PROJECT(DEDUP(other_recs_ind + other_recs_comb(rec_type != 'I')+other_recs_miss,ALL),
														TRANSFORM(other_recs_layout,
																			SELF.group_source_recID := IF(LEFT.rec_type = 'I',left.industry_fields.source_rec_id,left.contacts_fields.source_record_id);
																			SELF.group_source := IF(LEFT.rec_type = 'I',left.industry_fields.source,left.contacts_fields.source);	
																			SELF := LEFT));
	
	SHARED other_recs_grp := GROUP(SORT(other_recs,group_source_recID,group_source),group_source_recID,group_source);
	
	iesp.topbusinessOtherSources.t_OtherContact xform_contacts(other_recs_layout L) := TRANSFORM
		self.UniqueId						:= (STRING) L.contacts_fields.contact_did;
		self.Name.First  				:= L.contacts_fields.contact_name.fname;
	  self.Name.Middle 				:= L.contacts_fields.contact_name.mname;
		self.Name.Last 					:= L.contacts_fields.contact_name.lname;  
		self.Name.Suffix 				:= L.contacts_fields.contact_name.name_suffix;  	
		self.Name.Prefix 				:= L.contacts_fields.contact_name.title;
		self._Type							:= L.contacts_fields.contact_type_derived;
		self.Title							:= L.contacts_fields.contact_job_title_derived;
		self.SSN								:= L.contacts_fields.contact_ssn;
		self.Phone							:= L.contacts_fields.contact_phone;
		self.Email							:= L.contacts_fields.contact_email;
		self.CompanyDepartment	:= L.contacts_fields.company_department;
		SELF.DOB								:= iesp.ECL2ESP.toDate(L.contacts_fields.contact_dob);
		self := [];
  end;
	
	iesp.topbusinessOtherSources.t_otherSICCode xform_sic(other_recs_layout L, INTEGER C) := TRANSFORM
		// If contact record type, then use contact fields, otherwise only use single industry field.
		self.Code  := IF(L.rec_type = 'C',
												CHOOSE(C,L.contacts_fields.company_sic_code1,L.contacts_fields.company_sic_code2,
													 L.contacts_fields.company_sic_code3,L.contacts_fields.company_sic_code4,
													 L.contacts_fields.company_sic_code5),
												CHOOSE(C,L.industry_fields.siccode,''));
		self.Description := '';											 
	end;
			
	iesp.topbusinessOtherSources.t_otherNAICSCodes xform_naics(other_recs_layout L, INTEGER C) := TRANSFORM
		// If contact record type, then use contact fields, otherwise only use single industry field.
		self.Code  := IF(L.rec_type = 'C',
											CHOOSE(C,L.contacts_fields.company_naics_code1,L.contacts_fields.company_naics_code2,
													 L.contacts_fields.company_naics_code3,L.contacts_fields.company_naics_code4,
													 L.contacts_fields.company_naics_code5),
											CHOOSE(C,L.industry_fields.naics,''));
		self.Description := '';											 
	end;
		
	iesp.topbusinessOtherSources.t_OtherSourceRecord toOut(other_recs_layout L, DATASET(other_recs_layout) allRows) := TRANSFORM
		IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.IdValue := IF(L.rec_type = 'I',(STRING)L.industry_fields.source_rec_id,(STRING)L.contacts_fields.source_record_id);
		SELF.Source := IF(L.rec_type = 'I',L.industry_fields.source,L.contacts_fields.source);
		SELF.CompanyName        		:= L.contacts_fields.company_name;
		SELF.CompanyNameType				:= L.contacts_fields.company_name_type_derived;
		SELF.CompanyOrgStructure		:= L.contacts_fields.company_org_structure_derived;
		SELF.CompanyStatus					:= L.contacts_fields.company_status_derived;
		SELF.Fein										:= L.contacts_fields.company_fein;
		SELF.IndustryDescription		:= L.industry_fields.industry_description;
		SELF.BusinessDescription		:= L.industry_fields.business_description;
		SELF.Phone									:= L.contacts_fields.company_phone; 
		SELF.PhoneType							:= L.contacts_fields.phone_type; 
		SELF.SecondaryPhone					:= '';
		SELF.Ticker									:= L.contacts_fields.company_ticker;
		SELF.TickerExchange					:= L.contacts_fields.company_ticker_exchange;
		SELF.ForeignDomestic				:= CASE(L.contacts_fields.company_foreign_domestic,
																		'D' => Constants.ForeignDomesticDescription.Domestic,	
																		'F' => Constants.ForeignDomesticDescription.Foreign,
																		 L.contacts_fields.company_foreign_domestic);
		SELF.IncorpState						:= L.contacts_fields.company_inc_state;
		SELF.URL										:= L.contacts_fields.company_url;
		SELF.Email									:= '';
		SELF.CharterNumber					:= L.contacts_fields.company_charter_number;
		SELF.IncorpDate							:= iesp.ECL2ESP.toDate(L.contacts_fields.company_incorporation_date);
		SELF.FilingDate							:= iesp.ECL2ESP.toDate(L.contacts_fields.company_filing_date);
		SELF.FilingStatusDate				:= iesp.ECL2ESP.toDate(L.contacts_fields.company_status_date);
		SELF.ForeignDate						:= iesp.ECL2ESP.toDate(L.contacts_fields.company_foreign_date);
		SELF.EventFilingDate				:= iesp.ECL2ESP.toDate(L.contacts_fields.event_filing_date);
		SELF.Address := iesp.ECL2ESP.setAddress(
															L.contacts_fields.company_address.prim_name,L.contacts_fields.company_address.prim_range,
															L.contacts_fields.company_address.predir,L.contacts_fields.company_address.postdir,
															L.contacts_fields.company_address.addr_suffix,L.contacts_fields.company_address.unit_desig,
															L.contacts_fields.company_address.sec_range,L.contacts_fields.company_address.v_city_name,
															L.contacts_fields.company_address.st,L.contacts_fields.company_address.zip,
															L.contacts_fields.company_address.zip4,'');
		
		// Create a dataset from the sic code fields
		SELF.SICCodes := DEDUP(NORMALIZE(CHOOSEN(allRows,iesp.Constants.TOPBUSINESS.OTHER_MAX_SICCODES/5),5,xform_sic(LEFT, COUNTER)),ALL);
		// Create a dataset from the naics code fields
		SELF.NAICSCodes := DEDUP(NORMALIZE(CHOOSEN(allRows,iesp.Constants.TOPBUSINESS.OTHER_MAX_NAICSCODES/5),5,xform_naics(LEFT, COUNTER)),ALL);
		SELF.Contacts := DEDUP(PROJECT(CHOOSEN(allRows,iesp.Constants.TOPBUSINESS.OTHER_MAX_CONTACTS),xform_contacts(LEFT)),ALL);
		SELF := [];
	END;

	// Single records in the directories key are split for multiple contacts and siccodes. A group
	// rollup on record id and source is done to combine the record.
	SourceView_RecsIesp := ROLLUP(other_recs_grp,GROUP, toOut(LEFT,ROWS(LEFT)));
	
	EXPORT SourceView_Recs := DEDUP(SourceView_RecsIesp,ALL,HASH,EXCEPT businessIds.ultid,businessIds.orgid,businessIds.seleid,businessIds.proxid,
																							businessIds.dotid,businessIds.empid,businessIds.powid);
  SourceView_RecCount_org := 
    DEDUP(SORT(other_recs_comb + other_recs_miss,
          IF(rec_type = 'I',industry_fields.source_rec_id,contacts_fields.source_record_id), 
          IF(rec_type = 'I',industry_fields.source,contacts_fields.source)), 
      IF(rec_type = 'I',industry_fields.source_rec_id,contacts_fields.source_record_id), 
      IF(rec_type = 'I',industry_fields.source,contacts_fields.source)); 
  EXPORT SourceView_RecCount := 
    COUNT(DEDUP(SourceView_RecCount_org,ALL,HASH,EXCEPT #EXPAND(BIPV2.IDmacros.mac_ListAllLinkids())));

END;
