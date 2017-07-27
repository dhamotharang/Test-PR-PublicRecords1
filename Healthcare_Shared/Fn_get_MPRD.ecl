Import MPRD, Enclarity,Health_Facility_Services;
EXPORT Fn_get_MPRD := MODULE
	Export get_providers_base (dataset(Healthcare_Shared.Layouts_Header.CandidateRecords) recs,dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
			rawdataIndividualbyVendorid:= join(recs, mprd.Keys(,Healthcare_Shared.Constants.mprd_Keys_useProd).individual_join_group_key.QA,
											keyed(left.vendor_id = right.group_key) and left.src = Healthcare_Shared.Constants.SRC_MPRD and right.isTest = cfg[1].UseQATestRecs,
											transform(Healthcare_Shared.Layouts.mprd_providers_base_with_input,
																		self.acctno:=left.acctno;
																		self.internalID:=if(left.srcIndividualHeader,left.lnpid,left.lnfid);
																		self.lnpid:=left.lnpid;
																		self.lnfid:=left.lnfid;
																		self.src:=left.src;
																		self.vendor_id := left.vendor_id;
																		self.isSearchFailed := left.isSearchFailed;
																		self.keysfailed_decode := left.keysfailed_decode;
																		self.returnThresholdExceeded := left.returnThresholdExceeded;
																		self.srcIndividualHeader := left.srcIndividualHeader;
																		self.srcBusinessHeader := left.srcBusinessHeader;
																		self:=right;
																		self:=left;
																		self :=[]),
											keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));
			//FILTERING BY CURRENT MPRD RECORDS ONLY
			restrictionFilters := Project(rawdataIndividualbyVendorid(record_type = 'C'), 
																transform(Healthcare_Shared.Layouts.mprd_providers_base_with_input, 
																			keepRecord := map (left.filecode[1..3] = 'RST' and cfg[1].ExcludeRoster => false,																					
																												 left.filecode in Healthcare_Shared.SourceTools.set_Claims and cfg[1].ExcludeClaims => false,																					
																												 left.filecode in Healthcare_Shared.SourceTools.set_CHOICEPOINT and cfg[1].ExcludeOldCP => false,																					
																												 left.filecode in Healthcare_Shared.SourceTools.set_VSF and cfg[1].ExcludeVSF => false,																					
																												 left.filecode in Healthcare_Shared.SourceTools.set_FKA and cfg[1].ExcludeFKA => false,																					
																												 true);
																			self.acctno := if(keepRecord,left.acctno,skip);
																			self:= left));
			//group	by surrogate key for address denorm															
			sk_sort := SORT(restrictionFilters,acctno,internalid,surrogate_key,normed_addr_rec_type,clean_geo_match);
			sk_group := GROUP(sk_sort,acctno,internalid,surrogate_key);
			//denormalize address rows.  Grab normed_addr_rec_type = 1 for prac address and normed_addr_rec_type = 3 for bill address.
			  //I am not grabbing the "best" geolocation for primary address because FirstLogic is already using DUAL_ADDRESS settings from Enclarity to determine "best" primary and secondary fields
				Healthcare_Shared.Layouts.mprd_providers_base_with_input denormAddrWithGeo(Healthcare_Shared.Layouts.mprd_providers_base_with_input l,DATASET(Healthcare_Shared.Layouts.mprd_providers_base_with_input) allRows) := TRANSFORM
					prac_row := allRows(normed_addr_rec_type = '1')[1];
					bill_row := allRows(normed_addr_rec_type = '3')[1];
					self.clean_geo_lat := prac_row.clean_geo_lat;
					self.clean_geo_long := prac_row.clean_geo_long;
					self.clean_fips_st:= prac_row.clean_fips_st;
					self.clean_fips_county:= prac_row.clean_fips_county;                 
					self.clean_msa:= prac_row.clean_msa;                                   
					self.clean_geo_blk:= prac_row.clean_geo_blk;                     
					self.clean_geo_match:= prac_row.clean_geo_match;
					self.clean_bill_geo_lat := bill_row.clean_geo_lat;
					self.clean_bill_geo_long := bill_row.clean_geo_long;
					self.clean_bill_fips_st:= bill_row.clean_fips_st;
					self.clean_bill_fips_county:= bill_row.clean_fips_county;          
					self.clean_bill_msa:= bill_row.clean_msa;                                   
					self.clean_bill_geo_blk:= bill_row.clean_geo_blk;                           
					self.clean_bill_geo_match:= bill_row.clean_geo_match;
					self := l;
				end;
			sk_rollup_raw := sort(ROLLUP(sk_group,GROUP,denormAddrWithGeo(LEFT,ROWS(LEFT))),acctno);
			//Get hospital information...
			bestHospitalLookup1 := join(sk_rollup_raw, mprd.Keys(,Healthcare_Shared.Constants.mprd_Keys_useProd).best_hospital_addr_key.qa,
											keyed(left.prac1_key = right.addr_key) and right.isTest = cfg[1].UseQATestRecs,
											transform(Healthcare_Shared.layouts.mprd_providers_base_with_input, 
																		self.hospital_name := right.prac_company1_name;
																		self.hospital_group_key := right.group_key;
																		self.hospital_Phone := right.prac_phone1;
																		self:=left;
																		self:=[]),left outer,
											keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0)); 
			//Get LNPID for Best Hospital and dedup to get just one
			// bestHospitalLookup2 := dedup(sort(join(bestHospitalLookup1(hospital_group_key<>''),Health_Facility_Services.Key_HealthFacility_VEN.key,
											// keyed(left.hospital_group_key = right.vendor_id) and right.src = Healthcare_Shared.Constants.SRC_MPRD,
											// transform(recordof(Health_Facility_Services.Key_HealthFacility_VEN.key), self:= right;),left outer,
											// keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0)),vendor_id,lnpid),vendor_id,lnpid); 
			//Joing back lnpid key to best info
			bestHospitalLookup2 := join(bestHospitalLookup1, Health_Facility_Services.Key_HealthFacility_VEN.key, Keyed(left.hospital_group_key = right.vendor_id),
											transform(Healthcare_Shared.layouts.mprd_providers_base_with_input, 
																		self.hospital_lnpid := right.lnpid;
																		self:=left;
																		self:=[]),left outer,
											keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), atmost(1));//Keep only 1 record per join as you only need the lnpid
			appendSourceConfidenceData := join(bestHospitalLookup2,mprd.Keys(,Healthcare_Shared.Constants.mprd_Keys_useProd).source_confidence_lu_file_code_key.QA,
																			keyed(left.filecode = right.filecode) and right.isTest = cfg[1].UseQATestRecs,
																			transform(Healthcare_Shared.Layouts.mprd_providers_base_with_input,self.source_confidence_score:=RIGHT.confidence_score;self.audit_date := right.audit_date;self:=left;),left outer,
																			keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));
			sk_rollup := join(appendSourceConfidenceData,mprd.Keys(,Healthcare_Shared.Constants.mprd_Keys_useProd).lic_filedate_filecode_key.QA,
																		keyed(left.filecode = right.filecode) and right.isTest = cfg[1].UseQATestRecs,
																		transform(Healthcare_Shared.Layouts.mprd_providers_base_with_input,self.lic_filedate:=RIGHT.filedate;self:=left;),left outer,
																		keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));
			baseIndvRecs := project(sk_rollup,Healthcare_Shared.Transforms_MPRD.build_MPRD_Providers(left,cfg[1].Restrictions.hasSKA,cfg[1].MixedCaseOutput));//may need to pass cfg into transform

			//Get CP table records and add them to the base.
			rawCPdataIndividualbyVendorid:= join(recs, mprd.Keys(,Healthcare_Shared.Constants.mprd_Keys_useProd).basc_cp_group_key.QA,
											keyed(left.vendor_id = right.group_key) and left.src = Healthcare_Shared.Constants.SRC_MPRD and right.isTest = cfg[1].UseQATestRecs,
											transform(Healthcare_Shared.Layouts.mprd_cp_base_with_input,
																		self.acctno:=left.acctno;
																		self.internalID:=if(left.srcIndividualHeader,left.lnpid,left.lnfid);
																		self.lnpid:=left.lnpid;
																		self.lnfid:=left.lnfid;
																		self.src:=left.src;
																		self.vendor_id := left.vendor_id;
																		self.isSearchFailed := left.isSearchFailed;
																		self.keysfailed_decode := left.keysfailed_decode;
																		self.returnThresholdExceeded := left.returnThresholdExceeded;
																		self.srcIndividualHeader := left.srcIndividualHeader;
																		self.srcBusinessHeader := left.srcBusinessHeader;
																		self:=right;
																		self:=[]),
											keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));
			//FILTERING BY CURRENT MPRD RECORDS ONLY
			restrictionCPFilters := Project(rawCPdataIndividualbyVendorid, 
																transform(Healthcare_Shared.Layouts.mprd_cp_base_with_input, 
																			keepRecord := map (left.filecode[1..3] = 'RST' and cfg[1].ExcludeRoster => false,																					
																												 left.filecode in Healthcare_Shared.SourceTools.set_Claims and cfg[1].ExcludeClaims => false,																					
																												 left.filecode in Healthcare_Shared.SourceTools.set_CHOICEPOINT and cfg[1].ExcludeOldCP => false,																					
																												 left.filecode in Healthcare_Shared.SourceTools.set_VSF and cfg[1].ExcludeVSF => false,																					
																												 left.filecode in Healthcare_Shared.SourceTools.set_FKA and cfg[1].ExcludeFKA => false,																					
																												 true);
																			self.acctno := if(keepRecord,left.acctno,skip);
																			self:= left));
			//group	by surrogate key for address denorm															
 			sk_sort_cp := SORT(restrictionCPFilters,acctno,internalid,surrogate_key,normed_addr_rec_type,clean_geo_match);
   			sk_group_cp := GROUP(sk_sort_cp,acctno,internalid,surrogate_key);
   			//denormalize address rows.  Grab normed_addr_rec_type = 1 for prac address and normed_addr_rec_type = 3 for bill address.
   			  //I am not grabbing the "best" geolocation because FirstLogic is already using DUAL_ADDRESS settings from Enclarity to determine "best" primary and secondary fields
   				Healthcare_Shared.Layouts.mprd_cp_base_with_input denormAddrWithGeoCP(Healthcare_Shared.Layouts.mprd_cp_base_with_input l,DATASET(Healthcare_Shared.Layouts.mprd_cp_base_with_input) allRows) := TRANSFORM
   					prac_row := allRows(normed_addr_rec_type = '1')[1];
   					bill_row := allRows(normed_addr_rec_type = '3')[1];
   					self.clean_geo_lat := prac_row.clean_geo_lat;
   					self.clean_geo_long := prac_row.clean_geo_long;
   					self.clean_fips_st:= prac_row.clean_fips_st;
   					self.clean_fips_county:= prac_row.clean_fips_county;                 
   					self.clean_msa:= prac_row.clean_msa;                                   
   					self.clean_geo_blk:= prac_row.clean_geo_blk;                     
   					self.clean_geo_match:= prac_row.clean_geo_match;
   					self.clean_bill_geo_lat := bill_row.clean_geo_lat;
   					self.clean_bill_geo_long := bill_row.clean_geo_long;
   					self.clean_bill_fips_st:= bill_row.clean_fips_st;
   					self.clean_bill_fips_county:= bill_row.clean_fips_county;          
   					self.clean_bill_msa:= bill_row.clean_msa;                                   
   					self.clean_bill_geo_blk:= bill_row.clean_geo_blk;                           
   					self.clean_bill_geo_match:= bill_row.clean_geo_match;
   					self := l;
   				end;
 			sk_rollup_cp_raw := sort(ROLLUP(sk_group_cp,GROUP,denormAddrWithGeoCP(LEFT,ROWS(LEFT))),acctno);
			bestHospitalLookup1_cp := join(sk_rollup_cp_raw, mprd.Keys(,Healthcare_Shared.Constants.mprd_Keys_useProd).best_hospital_addr_key.qa,
											keyed(left.prac1_key = right.addr_key) and right.isTest = cfg[1].UseQATestRecs,
											transform(Healthcare_Shared.layouts.mprd_cp_base_with_input, 
																		self.hospital_name := right.prac_company1_name;
																		self.hospital_group_key := right.group_key;
																		self.hospital_Phone := right.prac_phone1;
																		self:=left;
																		self:=[];),left outer,
											keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0)); 
			//Get LNPID for Best Hospital and dedup to get just one
			// bestHospitalLookup2 := dedup(sort(join(bestHospitalLookup1(hospital_group_key<>''),Health_Facility_Services.Key_HealthFacility_VEN.key,
											// keyed(left.hospital_group_key = right.vendor_id) and right.src = Healthcare_Shared.Constants.SRC_MPRD,
											// transform(recordof(Health_Facility_Services.Key_HealthFacility_VEN.key), self:= right;),left outer,
											// keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0)),vendor_id,lnpid),vendor_id,lnpid); 
			//Joing back lnpid key to best info
			bestHospitalLookup2_cp := join(bestHospitalLookup1_cp, Health_Facility_Services.Key_HealthFacility_VEN.key, Keyed(left.hospital_group_key = right.vendor_id),
											transform(Healthcare_Shared.layouts.mprd_cp_base_with_input, 
																		self.hospital_lnpid := right.lnpid;
																		self:=left;
																		self:=[]),left outer,
											keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), atmost(1));//Keep only 1 record per join as you only need the lnpid
			appendSourceConfidenceData_cp := join(bestHospitalLookup2_cp,mprd.Keys(,Healthcare_Shared.Constants.mprd_Keys_useProd).source_confidence_lu_file_code_key.QA,
																			keyed(left.filecode = right.filecode) and right.isTest = cfg[1].UseQATestRecs,
																			transform(Healthcare_Shared.Layouts.mprd_cp_base_with_input,self.source_confidence_score:=RIGHT.confidence_score;self.audit_date := right.audit_date;self:=left;),left outer,
																			keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));
			sk_rollup_cp := join(appendSourceConfidenceData_cp,mprd.Keys(,Healthcare_Shared.Constants.mprd_Keys_useProd).lic_filedate_filecode_key.QA,
																		keyed(left.filecode = right.filecode) and right.isTest = cfg[1].UseQATestRecs,
																		transform(Healthcare_Shared.Layouts.mprd_cp_base_with_input,self.lic_filedate:=RIGHT.filedate;self:=left;),left outer,
																		keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));

			baseCPRecs := project(sk_rollup_cp,Healthcare_Shared.Transforms_MPRD.build_mprd_CP(left,cfg[1].Restrictions.hasSKA,cfg[1].MixedCaseOutput));//may need to pass cfg into transform
			
			//Get CAM table records and add them to the base.
			baseCAMRecs := Healthcare_Shared.Fn_get_CAM.getCAMData(baseIndvRecs, cfg);

			baseRecs := baseIndvRecs+baseCPRecs;
			// Join back to input to append user input into the record.
			baseRecsWithInput := join(baseRecs,input,left.acctno=right.acctno,transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.userinput:=right,self := left;),keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));
			//Do data service specific additional collections
			//Join in t_lic_filedate and add to MPRDRaw child dataset
			// baseRecsWithLicFiledate := Healthcare_Shared.Fn_do_MPRD_StateLicense.appendLicFiledate(baseRecsWithInput,cfg);
			//Join in source_confidence (RST_ filecodes) and add to MPRDRaw child dataset
			// baseRecsWithSourceConf := Healthcare_Shared.Fn_do_MPRD_SourceConfidence.appendSourceConfidence(baseRecsWithLicFiledate,cfg);
			//Populate the Group and Hospital Affiliations as you do not want to do lookups within a transform
			// baseRecsWithAffil := Healthcare_Shared.Fn_do_MPRD_Group_Affiliations.appendAffiliations(baseRecsWithInput,cfg);
			// baseRecsWithHosp := Healthcare_Shared.Fn_do_MPRD_Hospital_Affiliations.appendHospAffiliations(baseRecsWithAffil,cfg);
			// baseRecsWithOfficeAttributes := if(cfg[1].IncludeOfficeAttributes=true,
																					// Healthcare_Shared.Fn_do_MPRD_OfficeAttributes.appendOfficeAttributes(baseRecsWithInput,cfg),
																					// baseRecsWithInput);
			// baseRecsWithBestHospital := Healthcare_Shared.Fn_do_BestHospital.appendBestHospital(baseRecsWithInput,cfg);
			//output(baseRecsWithBestHospital,named('baseRecsWithBestHospital'),extend);
			// PLEASE DO NOT COMMENT OUTPUT LINE FOR PROVIDERSROLLED - IT SHUTS DOWN STDOUT TO FUNCTIONS - May be a shortcoming in ECL.
			// output(baseRecsWithDOD,named('baseRecsWithDOD'),extend);
			// output(baseCPRecs,named('baseCPRecs'),extend);
			// output(Recs,named('Recs'),extend);
			// output(rawdataIndividualbyVendorid,named('rawdataIndividualbyVendorid'),extend);
			// output(sk_rollup,named('sk_rollup'),extend);
			// output(baseRecs,named('baseRecs'),extend);
			// output(baseRecsWithInput,named('baseRecsWithInput'),extend);
			// output(baseIndvRecs,named('baseIndvRecs'),extend);
			// output(baseRecsWithBestHospital,named('baseRecsWithBestHospital'),extend);
			// Append CAM records
			//baseRecsWithCAM := baseRecsWithBestHospital+baseCAMRecs;
			baseRecsWithCAM := baseRecsWithInput+baseCAMRecs;
		return baseRecsWithCAM;
	end;

	Export get_facilities_base (dataset(Healthcare_Shared.Layouts_Header.CandidateRecords) recs,dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input,dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
			rawdataFacilitiesbyVendorid:= join(dedup(sort(recs(vendor_id<>''),record),record), mprd.Keys(,Healthcare_Shared.Constants.mprd_Keys_useProd).facility_join_group_key.qa(),
											keyed(left.vendor_id = right.group_key) and right.isTest = cfg[1].UseQATestRecs,
											transform(Healthcare_Shared.Layouts.mprd_facilities_base_with_input,
																		self.acctno:=left.acctno;
																		self.internalID:=if(left.srcIndividualHeader,left.lnpid,left.lnfid);
																		self.lnpid:=left.lnpid;
																		self.lnfid:=left.lnfid;
																		self.src:=left.src;
																		self.vendor_id := left.vendor_id;
																		self.isSearchFailed := left.isSearchFailed;
																		self.keysfailed_decode := left.keysfailed_decode;
																		self.returnThresholdExceeded := left.returnThresholdExceeded;
																		self.srcIndividualHeader := left.srcIndividualHeader;
																		self.srcBusinessHeader := left.srcBusinessHeader;
																		self:=right;
																		self:=[];),
											keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0)); 
			//FILTERING BY CURRENT MPRD RECORDS ONLY
			restrictionFilters := Project(rawdataFacilitiesbyVendorid(record_type = 'C'), 
																transform(Healthcare_Shared.Layouts.mprd_facilities_base_with_input, 
																			keepRecord := map (left.filecode[1..3] = 'RST' and cfg[1].ExcludeRoster => false,																					
																												 left.filecode in Healthcare_Shared.SourceTools.set_Claims and cfg[1].ExcludeClaims => false,																					
																												 left.filecode in Healthcare_Shared.SourceTools.set_CHOICEPOINT and cfg[1].ExcludeOldCP => false,																					
																												 left.filecode in Healthcare_Shared.SourceTools.set_VSF and cfg[1].ExcludeVSF => false,																					
																												 left.filecode in Healthcare_Shared.SourceTools.set_FKA and cfg[1].ExcludeFKA => false,																					
																												 true);
																			self.acctno := if(keepRecord,left.acctno,skip);
																			self:= left));
			
			//group	by surrogate key for address denorm															
			sk_sort := SORT(restrictionFilters,acctno,internalid,surrogate_key,normed_addr_rec_type,clean_geo_match);
			sk_group := GROUP(sk_sort,acctno,internalid,surrogate_key);
			//denormalize address rows.  Grab normed_addr_rec_type = 1 for prac address and normed_addr_rec_type = 3 for bill address.
			  //I am not grabbing the "best" geolocation because FirstLogic is already using DUAL_ADDRESS settings from Enclarity to determine "best" primary and secondary fields
				Healthcare_Shared.Layouts.mprd_facilities_base_with_input denormAddrWithGeo(Healthcare_Shared.Layouts.mprd_facilities_base_with_input l,DATASET(Healthcare_Shared.Layouts.mprd_facilities_base_with_input) allRows) := TRANSFORM
					prac_row := allRows(normed_addr_rec_type = '1')[1];
					bill_row := allRows(normed_addr_rec_type = '3')[1];
					self.clean_geo_lat := prac_row.clean_geo_lat;
					self.clean_geo_long := prac_row.clean_geo_long;
					self.clean_fips_st:= prac_row.clean_fips_st;
					self.clean_fips_county:= prac_row.clean_fips_county;                 
					self.clean_msa:= prac_row.clean_msa;                                   
					self.clean_geo_blk:= prac_row.clean_geo_blk;                     
					self.clean_geo_match:= prac_row.clean_geo_match;
					self.clean_bill_geo_lat := bill_row.clean_geo_lat;
					self.clean_bill_geo_long := bill_row.clean_geo_long;
					self.clean_bill_fips_st:= bill_row.clean_fips_st;
					self.clean_bill_fips_county:= bill_row.clean_fips_county;          
					self.clean_bill_msa:= bill_row.clean_msa;                                   
					self.clean_bill_geo_blk:= bill_row.clean_geo_blk;                           
					self.clean_bill_geo_match:= bill_row.clean_geo_match;
					self := l;
				end;
			sk_rollup_raw := sort(ROLLUP(sk_group,GROUP,denormAddrWithGeo(LEFT,ROWS(LEFT))),acctno);		
			appendSourceConfidenceData := join(sk_rollup_raw,mprd.Keys(,Healthcare_Shared.Constants.mprd_Keys_useProd).source_confidence_lu_file_code_key.QA,
																			keyed(left.filecode = right.filecode) and right.isTest = cfg[1].UseQATestRecs,
																			transform(Healthcare_Shared.Layouts.mprd_facilities_base_with_input,self.source_confidence_score:=RIGHT.confidence_score;self.audit_date := right.audit_date;self:=left;),left outer,
																			keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));
			sk_rollup := join(appendSourceConfidenceData,mprd.Keys(,Healthcare_Shared.Constants.mprd_Keys_useProd).lic_filedate_filecode_key.QA,
																		keyed(left.filecode = right.filecode) and right.isTest = cfg[1].UseQATestRecs,
																		transform(Healthcare_Shared.Layouts.mprd_facilities_base_with_input,self.lic_filedate:=RIGHT.filedate;self:=left;),left outer,
																		keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));
			baseRecs := project(sk_rollup,Healthcare_Shared.Transforms_MPRD.build_MPRD_Facility(left,cfg[1].Restrictions.hasSKA,cfg[1].MixedCaseOutput));//may need to pass cfg into transform
			baseRecsWithInput := join(baseRecs,input,left.acctno=right.acctno,transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.userinput:=right,self := left;),keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));
			Healthcare_Shared.Layouts.layout_child_fein doRollup(Healthcare_Shared.Layouts.layout_acct_fein l, dataset(Healthcare_Shared.Layouts.layout_acct_fein) r) := TRANSFORM
					SELF.acctno := l.acctno;
					self.internalID := l.internalID;
					self.childinfo := project(r,Healthcare_Shared.Layouts.layout_fein);
				END;

			getFEIN := dedup(sort(join(recs(vendor_id<>''),enclarity.Keys(,Healthcare_Shared.Constants.mprd_Keys_useProd).associate_bgk.qa,
													keyed(left.vendor_id = right.billing_group_key),
													transform(Healthcare_Shared.Layouts.layout_acct_fein, self.acctno:=left.acctno;self.internalID:=if(left.srcIndividualHeader,left.lnpid,left.lnfid);self.fein:=right.bill_tin),
													keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0)),record),record); 
			fein_rolled := rollup(group(getFEIN,acctno),group,doRollup(left,rows(left)));
			updateFEIN := join(baseRecsWithInput,fein_rolled,left.acctno=right.acctno and left.internalID=right.internalID,transform(Healthcare_Shared.Layouts.CombinedHeaderResults, self.feins:=dedup(sort(left.feins+right.childinfo,record),record);self:=left;self:=[];),left outer,keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
			//Populate the Group and Hospital Affiliations as you do not want to do lookups within a transform
			// baseRecsWithAffil := Healthcare_Shared.Fn_do_MPRD_Group_Affiliations.appendAffiliations(updateFEIN,cfg);
			// baseRecsWithHosp := Healthcare_Shared.Fn_do_MPRD_Hospital_Affiliations.appendHospAffiliations(baseRecsWithAffil,cfg);
			// baseRecsWithOfficeAttributes := if(cfg[1].IncludeOfficeAttributes=true,
																					// Healthcare_Shared.Fn_do_MPRD_OfficeAttributes.appendOfficeAttributesFacilities(baseRecsWithHosp,cfg),
																					// baseRecsWithHosp);    		 
		return updateFEIN;
	end;

	Export get_mprd_entity (dataset(Healthcare_Shared.Layouts_Header.CandidateRecords) recs, dataset(Healthcare_Shared.Layouts.userInputCleanMatch) input, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
			// output(input,named('input_get_mprd_entity'),extend);
			providers_base := get_providers_base(recs(srcIndividualHeader=true),input,cfg);
			// outpsut(providers_base,named('providers_base'),extend);
			facilities_base := get_facilities_base(recs(srcBusinessHeader=true),input,cfg);
    	return providers_base+facilities_base;//Only one should ever get populated
	end;
end;