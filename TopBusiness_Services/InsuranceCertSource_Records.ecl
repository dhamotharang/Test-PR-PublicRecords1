// ================================================================================
// ======      RETURNS Insurance Cert DATA  IN ESP-COMPLIANT WAY  				    =====
// ================================================================================
IMPORT Insurance_Certification, BIPV2, iesp, Codes, ut;

EXPORT InsuranceCertSource_Records(
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 
 SHARED insure_layout_wLinkIds := RECORD
		Insurance_Certification.Layouts_Certification.Keybuild;
		Insurance_Certification.Layouts_Policy.Keybuild - BIPV2.IDlayouts.l_xlink_ids - Date_FirstSeen - Date_LastSeen - Bdid - LNInsCertRecordID - DartID - unique_id - Append_MailAddress1 - Append_MailAddressLast - Append_MailRawAID - Append_MailAceAID - m_prim_range - m_predir - m_prim_name - m_addr_suffix - m_postdir - m_unit_desig - m_sec_range - m_p_city_name - m_v_city_name - m_st - m_zip - m_zip4 - m_cart - m_cr_sort_sz - m_lot - m_lot_order - m_dbpc - m_chk_digit - m_rec_type - m_fips_state - m_fips_county - m_geo_lat - m_geo_long - m_msa - m_geo_blk - m_geo_match - m_err_stat;
 END;

 SHARED insure_key_layout := RECORD
		Layouts.rec_input_ids_wSrc;
		Insurance_Certification.layouts_certification.NormRec.LNInsCertRecordID;
		Insurance_Certification.layouts_certification.NormRec.DartID;
 END;

	// For in_docids records that don't have IdValue's retrieve them from linkid file
	in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	
	// *** Key fetch to get insurance cert keys from linkids
  ds_LinkInsurkeys := PROJECT(Insurance_Certification.Key_LinkIds.kFetch(in_docs_linkonly,inoptions.fetch_level,,
	                                                                       TopBusiness_Services.Constants.SlimKeepLimit),
																TRANSFORM(insure_key_layout,
																					SELF.LNInsCertRecordID := LEFT.LNInsCertRecordID,
																					SELF.DartID := LEFT.DartID,
																					SELF := LEFT,
																					SELF := []));
	
	// For records with an id value assigned and an Id type of sourcedocid, then parse the idvalue
	// to get the key parts (certid, dartid)
  in_docs_Parse := in_docids(IdValue != '' and Idtype = constants.sourcedocid);
	ds_ParseInsurekeys := PROJECT(in_docs_Parse,TRANSFORM(insure_key_layout,
																	delim1 := StringLib.StringFind(LEFT.IdValue,'//',1);
																	SELF.LNInsCertRecordID := (INTEGER) LEFT.IdValue[1..delim1-1],
																	SELF.DartID := LEFT.IdValue[delim1+2..],
																	SELF := LEFT,
																	SELF := []));
	
	insure_keys_comb := ds_LinkInsurkeys+ds_ParseInsurekeys;
	
	// Filter out zero certids, there is a data issue with this value.
	insure_keys_dedup := DEDUP(insure_keys_comb(LNInsCertRecordID != 0),ALL); 
	
 	// Since there is no existing ???_Services.raw(???) that accesses insurance cert data,
	// source doc will be built using insurance cert keys.
	insure_cert := JOIN(insure_keys_dedup,Insurance_Certification.Key_UniqueCert,
														KEYED(LEFT.LNInsCertRecordID = RIGHT.LNInsCertRecordID) AND
														LEFT.dartid = RIGHT.dartid,
														TRANSFORM(insure_layout_wLinkIds,
																					SELF := RIGHT,
																					SELF := LEFT,
																					SELF := []),
														LIMIT(ut.limits.default, SKIP));
	
	insure_cert_policy := JOIN(insure_cert,Insurance_Certification.Key_UniquePol,
														KEYED(LEFT.LNInsCertRecordID = RIGHT.LNInsCertRecordID) AND
														LEFT.dartid = RIGHT.dartid,
														TRANSFORM(insure_layout_wLinkIds,
																				SELF.LNInsCertRecordID := LEFT.LNInsCertRecordID,
																				SELF.dartid := LEFT.dartid,
																				SELF := RIGHT,		
																				SELF := LEFT,
																				SELF := [])
														,LEFT OUTER, LIMIT(TopBusiness_Services.Constants.SlimKeepLimit, SKIP));

	SHARED insure_cert_grp := GROUP(SORT(insure_cert_policy,LNInsCertRecordID,dartid,RECORD),LNInsCertRecordID,dartid);
																					
  // transforms for the iesp child dataset layouts used
	iesp.insurance_certification.t_insureCertBusinessInfo xform_mco(insure_layout_wLinkIds L) := transform
		self.CompanyName    	:= L.MCOName;
		self.Number						:= L.MCONumber;
		SELF.Address := iesp.ECL2ESP.setAddress('','','','','','','',
																		L.MCOCity,L.MCOState,L.MCOZip,L.MCOZip4,'','',
																		L.MCOAddressLine1,L.MCOAddressLine2);
		self.Phone		:= L.MCOPhone;
	  self := [];
  end;
	
	iesp.insurance_certification.t_insureCertBusinessInfo xform_subs(insure_layout_wLinkIds L, integer C) := transform
		self.CompanyName    	:= choose(C,L.SubsidiaryName1,L.SubsidiaryName2,L.SubsidiaryName3,L.SubsidiaryName4,L.SubsidiaryName5,
																		L.SubsidiaryName6,L.SubsidiaryName7,L.SubsidiaryName8,L.SubsidiaryName9,L.SubsidiaryName10);

		startDate := choose(C,L.subsidiarystartdate1,L.subsidiarystartdate2,L.subsidiarystartdate3,
													L.subsidiarystartdate4,L.subsidiarystartdate5,L.subsidiarystartdate6,
													L.subsidiarystartdate7,L.subsidiarystartdate8,L.subsidiarystartdate9,
													L.subsidiarystartdate10,'');
		
		self.StartDate := iesp.ECL2ESP.toDate ((integer4) startDate);
	  self := [];
  end;
	
	iesp.insurance_certification.t_insureCertContacts xform_bus_contact(insure_layout_wLinkIds L) := transform
		self.BusinessName    						 := L.norm_businessname;
		SELF.Address := iesp.ECL2ESP.setAddress(
															L.m_prim_name,L.m_prim_range,L.m_predir,L.m_postdir,
															L.m_addr_suffix,L.m_unit_desig,L.m_sec_range,L.m_v_city_name,
															L.m_st,L.m_zip,L.m_zip4,'');
		self.phone		:= L.norm_phone;
		self.Fax			:= L.contactfax;
		self.email		:= L.contactemail;
		self._type    := IF(L.norm_businessname != '','Business','');
	  self := [];
  end;
	
	iesp.insurance_certification.t_insureCertPhones xform_phones(insure_layout_wLinkIds L, integer C) := transform
		phone := CHOOSE(C,L.norm_phone,L.phone2,L.phone3,L.fax1,L.fax2);
		self.phone		:= phone;
		self._type    := IF(phone != '',IF(C<=3,'Phone','Fax'),'');
	  self := [];
  end;
	
	iesp.insurance_certification.t_insureCertNAICCodes xform_naics(insure_layout_wLinkIds L) := transform
		self.Code    			:= L.naicscode;
		self.Description 	:= Codes.Key_NAICS(keyed(naics_code = L.naicscode))[1].naics_description;
	  self := [];
  end;
	
	iesp.insurance_certification.t_insureCertContacts xform_contacts(insure_layout_wLinkIds L, integer C) := transform
	  self.Name.First  := choose(C,L.officerexemptfirstname1,L.officerexemptfirstname2,L.officerexemptfirstname3,
		                        L.officerexemptfirstname4,L.officerexemptfirstname5);  
	  self.Name.Middle := choose(C,L.officerexemptmiddlename1,L.officerexemptmiddlename2,L.officerexemptmiddlename3,
		                        L.officerexemptmiddlename4,L.officerexemptmiddlename5);  
	  self.Name.Last   := choose(C,L.officerexemptlastname2,L.officerexemptlastname2,L.officerexemptlastname3,
		                        L.officerexemptlastname4,L.officerexemptlastname5);  
	  self.Title 			 := choose(C,L.officerexempttitle1,L.officerexempttitle2,L.officerexempttitle3,
		                        L.officerexempttitle4,L.officerexempttitle5); 
		self._type    := 'Individual';

		
		self.EffectiveDate  	:= iesp.ECL2ESP.toDate ((integer4) L.officerexempteffectivedate1);
																	
		terminationDate := 	choose(C,L.officerexemptterminationdate1,L.officerexemptterminationdate2,
																	L.officerexemptterminationdate3,L.officerexemptterminationdate4,
																	L.officerexemptterminationdate5,'');
		self.TerminationDate := iesp.ECL2ESP.toDate ((integer4) terminationDate);
		self := [];														
	end;
	
	iesp.insurance_certification.t_insureCertPolicyInfo xform_policies(insure_layout_wLinkIds L) := transform
		self.PolicyNumber    	:= L.PolicyNumber;
		self.Status						:= L.PolicyStatus;
		self.InsuranceType		:= L.InsuranceType;
		self.CarrierName 			:= L.InsuranceProvider;
		self.Phone 						:= L.InsuranceProviderPhone;
		self.Fax 							:= L.InsuranceProviderFax;
		self.Address 					:= iesp.ECL2ESP.setAddress('','','','','','','',
																		L.InsuranceProviderCity,L.InsuranceProviderState,L.InsuranceProviderZip,
																		L.InsuranceProviderZip4,'','',
																		L.InsuranceProviderAddressLine,L.InsuranceProviderAddressLine2);
		
		self.Coverage.StartDate					:= iesp.ECL2ESP.toDate ((integer4) L.CoverageStartDate);
		self.Coverage.ExpirationDate		:= iesp.ECL2ESP.toDate ((integer4) L.CoverageExpirationDate);
		self.Coverage.ReinstateDate			:= iesp.ECL2ESP.toDate ((integer4) L.CoverageReinstateDate);
		self.Coverage.CancellationDate	:= iesp.ECL2ESP.toDate ((integer4) L.CoverageCancellationDate);
		self.Coverage.WrapUpDate				:= iesp.ECL2ESP.toDate ((integer4) L.CoverageWrapUpDate);
		self.Coverage.PostedDate				:= iesp.ECL2ESP.toDate ((integer4) L.CoveragePostedDate);
		self.Coverage.AmountFrom				:= L.CoverageAmountFrom;
		self.Coverage.AmountTo					:= L.CoverageAmountTo;
	  self := [];
  end;
	
  // transform for the main output iesp record layout
  iesp.insurance_certification.t_InsuranceCertificationRecord toOut (insure_layout_wLinkIds L, DATASET(insure_layout_wLinkIds) allRows) := transform
		IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
		bus_rec := allRows(norm_type = 'B')[1];
		dba_rec := allRows(norm_type = 'D')[1];
		cont_rec := allRows(norm_type = 'C')[1];
										
	  self.BusinessName := bus_rec.norm_businessname;
		SELF.Address := iesp.ECL2ESP.setAddress(
															bus_rec.m_prim_name,bus_rec.m_prim_range,bus_rec.m_predir,
															bus_rec.m_postdir,bus_rec.m_addr_suffix,bus_rec.m_unit_desig,
															bus_rec.m_sec_range,bus_rec.m_v_city_name,bus_rec.m_st,
															bus_rec.m_zip,bus_rec.m_zip4,'');
			
		self.DBAName         			:= dba_rec.norm_businessname;
		self.BusinessType 				:= L.BusinessType;
		self.LNInsCertRecordID 		:= L.LNInsCertRecordID;
		self.DartID 							:= L.DartID;
		self.ProfileLastUpdated 	:= iesp.ECL2ESP.toDate ((integer4) L.ProfileLastUpdated);
		self.StatePolicyFileNumber := L.StatePolicyFileNumber;
		self.State 								:= L.State;
		self.Email 								:= L.Email1;
		self.Email2 							:= L.Email2;
		self.WorkersCompBoardEmpNumber				:= L.WCBEmpNumber;
		self.UnifiedBusinessNumber						:= L.UBINumber;
		self.CertificateofAuthenticityNumber	:= L.CofANumber;
		self.USDeptOfTransportationNumber			:= L.USDOTNumber;
		self.SelfInsurance.InsuranceID 				:= L.SIID;
		self.SelfInsurance.InsuranceStatus 		:= L.SIPStatusCode;
		self.SelfInsurance.GroupName 					:= L.SelfInsuranceGroup;
		self.SelfInsurance.GroupPhone 				:= L.SelfInsuranceGroupPhone;
		self.SelfInsurance.GroupId 						:= L.SelfInsuranceGroupID;
		self.LicenseInfo.Number 							:= L.LicenseNumber;
		self.LicenseInfo.Status 							:= L.LicenseStatus;
		self.LicenseInfo.GoverningClassCode		:= L.GoverningClassCode;
		self.LicenseInfo.Class 								:= L.Class;
		self.LicenseInfo.ClassDesc 						:= L.ClassificationDescription;
		self.LicenseInfo.AdditionalInfo				:= L.LicenseAdditionalInfo;
		self.LicenseInfo.IssueDate 						:= iesp.ECL2ESP.toDate ((integer4) L.LicenseIssueDate);
		self.LicenseInfo.ExpirationDate 			:= iesp.ECL2ESP.toDate ((integer4) L.LicenseExpirationDate);
	
		busContact := project(cont_rec,xform_bus_contact(left));
		invdContacts := normalize(dataset(bus_rec),5,xform_contacts(left,counter));
		self.contacts := choosen(busContact + invdContacts(name.last!=''),iesp.constants.InsuranceCert.MaxContacts);
		phones := normalize(dataset(L),5,xform_phones(left,counter));
		Self.phones := choosen(phones(phone!=''),iesp.constants.InsuranceCert.MaxPhones);
		
		Self.ManagedCareOrgs := project(L,xform_mco(left));
		
		subs := normalize(dataset(L),10,xform_subs(left,counter));
		Self.Subsidiaries := choosen(subs(CompanyName != ''),iesp.constants.InsuranceCert.MaxSubsidiaries);
		
		naics := DEDUP(PROJECT(allrows,xform_naics(LEFT)),ALL);
		self.NAICCodes := choosen(naics,iesp.constants.InsuranceCert.MaxNAICCodes);
		
		policies := PROJECT(allRows(norm_type = 'B'),xform_policies(LEFT));
		self.Policies := choosen(DEDUP(policies,ALL),iesp.constants.InsuranceCert.MaxPolicies);
		self := [];
  end;
	
	
	SourceView_RecsIesp := ROLLUP(insure_cert_grp, GROUP, toOUT(LEFT,ROWS(LEFT)));
	EXPORT SourceView_Recs := DEDUP(SourceView_RecsIesp,ALL,HASH,EXCEPT IDValue,businessIds.ultid,businessIds.orgid,businessIds.seleid,businessIds.proxid,
																							businessIds.dotid,businessIds.empid,businessIds.powid);
  EXPORT SourceView_RecCount := COUNT(SourceView_Recs);
	
END;
