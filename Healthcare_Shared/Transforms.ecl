import doxie,iesp,Healthcare_Shared,STD;
EXPORT Transforms := MODULE
	shared legacyLayout := doxie.ingenix_provider_module;
	Shared LegacySearch := legacyLayout.layout_ingenix_provider_search_plus;
	shared LegacyReport := legacyLayout.layout_ingenix_provider_report;
	shared LegacyReportWithVerification := Healthcare_Shared.Layouts.LegacyReportWithVerifications;

	export iesp.share.t_GeoAddress processSanctionAddressRaw(Healthcare_Shared.Layouts.layout_LegacySanctions inAddr):= TRANSFORM
		self.address := iesp.ECL2ESP.SetAddress(inAddr.ProvCo_Address_Clean_prim_name, inAddr.ProvCo_Address_clean_prim_range, inAddr.ProvCo_Address_clean_predir, inAddr.ProvCo_Address_Clean_postdir,
           inAddr.ProvCo_Address_clean_addr_suffix, inAddr.ProvCo_Address_clean_unit_desig, inAddr.ProvCo_Address_clean_sec_range, inAddr.ProvCo_Address_clean_p_city_name,
           inAddr.ProvCo_Address_clean_st, inAddr.ProvCo_Address_clean_zip, '', '');
		self.Location.Latitude := inAddr.ProvCo_Address_clean_geo_lat;
		self.Location.Longitude := inAddr.ProvCo_Address_clean_geo_long;
	end;
	export iesp.healthcare.t_HealthCareSanctionConsolidatedReport processSanctions(Healthcare_Shared.Layouts.layout_LegacySanctions inSanction):= TRANSFORM
		self.SanctionId := (string)inSanction.sanc_id;
		self.UniqueId := inSanction.did;
		self.Name := iesp.ECL2ESP.SetName(inSanction.prov_clean_fname, inSanction.prov_clean_mname, inSanction.prov_clean_lname, inSanction.Prov_Clean_name_suffix, inSanction.Prov_Clean_title, inSanction.SANC_BUSNME);
		self.GeoAddress := project(inSanction, processSanctionAddressRaw(left));
		self.DOB := iesp.ECL2ESP.toDatestring8(inSanction.sanc_dob);
		self.TaxId := inSanction.sanc_tin;
		self.UPIN := inSanction.sanc_upin;
		self.Source := inSanction.sanc_src_desc;
		self.SanctionTerm := inSanction.sanc_terms;
		self.SanctionType := inSanction.sanc_type;
		self.BoardType := inSanction.sanc_brdtype;
		self.ProviderType := inSanction.sanc_provtype;
		self.Fines := inSanction.sanc_fines;
		self.SanctionReason := inSanction.sanc_reas;
		self.Conditions := inSanction.sanc_cond;
		self.LicenseNumber := inSanction.sanc_licnbr;
		self.SanctionState := inSanction.sanc_sancst;
		self.SanctionDate := iesp.ECL2ESP.toDatestring8(inSanction.sanc_sancdte_form);
		self.DateLastReported := iesp.ECL2ESP.toDatestring8(inSanction.date_last_reported);
		self.DateFirstSeen := iesp.ECL2ESP.toDatestring8(inSanction.date_first_seen);
		self.DateLastSeen := iesp.ECL2ESP.toDatestring8(inSanction.date_last_seen);
		self.LicenseReinstatedDate := iesp.ECL2ESP.toDatestring8(inSanction.sanc_reindte_form);
		self.FraudAbuseFlag := if(inSanction.sanc_fab='TRUE',TRUE,FALSE);
		self.LostOfLicenseIndicator := if(inSanction.sanc_unamb_ind='TRUE',TRUE,FALSE);
		self.DateFirstReported := iesp.ECL2ESP.toDatestring8(inSanction.date_first_reported);
		self.ProcessDate := iesp.ECL2ESP.toDatestring8(inSanction.process_date);
		self.SanctionGroupType := inSanction.sanc_grouptype;
		self.SanctionSubGroupType := inSanction.sanc_subgrouptype;
		self.NationalProviderId := '';//Not in the Sanction file
		self.nppesVerified := inSanction.nppesVerified;
		self.DerivedReinstateDateIndicator := inSanction.LNDerivedReinstateDate;
		self.SanctionTypePriority := (string)inSanction.sanc_priority;
		self := inSanction;
		self := [];
	end;

	//Final Rollups
	Export Healthcare_Shared.Layouts.layout_licenseinfo addLicSeq(Healthcare_Shared.Layouts.layout_licenseinfo l, integer c) := TRANSFORM
					self.licenseSeq := c;
					self := l;
	END;

	Export Healthcare_Shared.Layouts.layout_licenseinfo doStateLicenseRollup(Healthcare_Shared.Layouts.layout_licenseinfo l, dataset(Healthcare_Shared.Layouts.layout_licenseinfo) allRows) := transform 
		self.LicSortGroup := max(allRows,Termination_Date)+l.LicSortGroup;
		self.Effective_Date := min(allRows(Effective_Date<>''),Effective_Date);
		self.Termination_Date := max(allRows,Termination_Date);
		self := l;
	END;

	export Healthcare_Shared.Layouts.layout_addressinfo doFinalBaseRecordAddrRollup(Healthcare_Shared.Layouts.layout_addressinfo l,
																										DATASET(Healthcare_Shared.Layouts.layout_addressinfo) allRows) := TRANSFORM
			self.last_seen := max(allRows,last_seen);
			self.addrSeq := min(allRows,addrSeq);
			self.first_seen := if(min(allRows(first_seen<>'0'),first_seen) <> '', min(allRows(first_seen<>'0'),first_seen),min(allRows(first_seen<>'0'),last_seen));
			self.v_last_seen := max(allRows,v_last_seen);
			self.v_first_seen := if(min(allRows(first_seen<>'0'),v_first_seen) <> '', min(allRows(first_seen<>'0'),v_first_seen),min(allRows(first_seen<>'0'),v_last_seen));
			self := l;
			self := [];
	end;
	Export Healthcare_Shared.Layouts.CombinedHeaderResults doFinalRollup(Healthcare_Shared.Layouts.CombinedHeaderResults l, 
																							DATASET(Healthcare_Shared.Layouts.CombinedHeaderResults) allRowsRaw,
																							dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := TRANSFORM
		hasAllowMergeAuthoritySrc := cfg[1].allowMergeAuthoritySrc;
		//Filter out rows the user said they did not want or do not have access too.
		allRows := project(allRowsRaw,transform(Healthcare_Shared.Layouts.CombinedHeaderResults,
								keepRow := map(left.src = Healthcare_Shared.Constants.SRC_AMS and cfg[1].excludeSourceAMS => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_NPPES and cfg[1].excludeSourceNPPES => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_DEA and cfg[1].excludeSourceDEA => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_PROFLIC and cfg[1].excludeSourceProfLic => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_SELECTFILE and cfg[1].excludeSourceSelectFile => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_CLIA and cfg[1].excludeSourceCLIA => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_NCPDP and cfg[1].excludeSourceNCPDP => false,
															 left.src = Healthcare_Shared.Constants.SRC_MPRD and STD.Str.ToUpperCase(left.subSrc[1..3]) = Healthcare_Shared.SourceTools.prefixRoster and cfg[1].ExcludeRoster => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_MPRD and left.subSrc in Healthcare_Shared.SourceTools.set_Claims and cfg[1].ExcludeClaims => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_MPRD and left.subSrc in Healthcare_Shared.SourceTools.set_CHOICEPOINT  and cfg[1].ExcludeOldCP => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_MPRD and left.subSrc in Healthcare_Shared.SourceTools.set_VSF and cfg[1].ExcludeVSF => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_MPRD and left.subSrc in Healthcare_Shared.SourceTools.set_FKA and cfg[1].ExcludeFKA => false,																					
															 true);
								self.acctno := if(keepRow,left.acctno,skip);
								self:=left;));
		SELF.acctno := l.acctno;
		self.LNPID   := l.LNPID;
		self.SrcId  := l.SrcId;
		self.Src    := if(l.isAutokeysResult or l.Src=Healthcare_Shared.Constants.SRC_SANC or l.Src=Healthcare_Shared.Constants.SRC_BOCA_BUS_HEADER or l.Src=Healthcare_Shared.Constants.SRC_BOCA_PERSON_HEADER,l.Src,Healthcare_Shared.Constants.SRC_HEADER);//For business re-entry we need to keep this until header 2
		self.VendorID := ''; //vendor id should be blank as thee are multiple vendors within a given result
		self.isAutokeysResult := l.isAutokeysResult;
		self.isHeaderResult := if(l.isAutokeysResult,false,true);
		self.isBestBIPResult := l.isBestBIPResult;
		self.glb_ok	:= if(exists(allRows(glb_ok=true)),true,false);
		self.dppa_ok:= if(exists(allRows(dppa_ok=true)),true,false);
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		self.ProcessingMessage := l.ProcessingMessage;
		self.hasStateRestrict := if(exists(allRows(hasStateRestrict=true)),true,false);
		self.hasOIG := if(exists(allRows(hasOIG=true)),true,false);
		self.hasOPM := if(exists(allRows(hasOPM=true)),true,false);
		//Handle Status
		statusDeceased := exists(allRows(status='D'));
		statusUnconfirmedDeceased := exists(allRows(status='U1'));
		statusStrongUnconfirmedDeceased := exists(allRows(status='U'));
		statusRetired := exists(allRows(status in ['R','R3']));
		statusTierIStrongestRetired := exists(allRows(status='R1'));
		statusTierIIRetired := exists(allRows(status='R2'));
		statusTierIVWeakRetired := exists(allRows(status='R4'));
		statusAActive := exists(allRows(status='A'));
		statusNActive := exists(allRows(status='N'));
		self.status := map(statusDeceased => 'D',
											 statusUnconfirmedDeceased => 'U1',
											 statusStrongUnconfirmedDeceased => 'U',
											 statusRetired => 'R',
											 statusTierIStrongestRetired => 'R1',
											 statusTierIIRetired => 'R2',
											 statusTierIVWeakRetired => 'R4',
											 statusNActive => 'N',
											 statusAActive => 'A',
											 ' ');
		self.NPPESVerified := map(exists(allRows(NPPESVerified='YES')) => 'YES',
															exists(allRows(NPPESVerified='CORRECTED')) => 'CORRECTED',
															' ');
		self.Sources       := DEDUP( NORMALIZE( allRows, LEFT.Sources, TRANSFORM( Healthcare_Shared.Layouts.layout_SrcID, SELF := RIGHT	)	), RECORD, ALL );
		self.Names         := sort(DEDUP(sort( NORMALIZE( allRows, LEFT.Names(nameSeq>0), TRANSFORM( Healthcare_Shared.Layouts.layout_nameinfo, SELF := RIGHT	)	), FullName,FirstName,MiddleName,LastName,Suffix,CompanyName,nameSeq ), FullName,FirstName,MiddleName,LastName,Suffix,CompanyName),nameSeq,namePenalty);

		/*Add logic to sort based on requirements
			normalize the addresses
			sort them so similar address are together and get priority fields in first position
			dedupe out duplicates that are the exact same address, but to not have the priority fields set
			resort the address using the priority sorting below.
			**** Primary Sorting Sequence ****
			The individual dataset build routines are going to have different addrseq values
			Finally, put a decending on the seen dates to put think in oder after that 
		*/
		self.Addresses     := Choosen(sort(rollup(group(sort(NORMALIZE( allRows, LEFT.Addresses, 
																										TRANSFORM( Healthcare_Shared.Layouts.layout_addressinfo, SELF := RIGHT	)),
																					prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5,addrSeq,-(integer)addrConfidenceValue),
																		 prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),group,doFinalBaseRecordAddrRollup(left,rows(left))),addrseq,-(integer)addrConfidenceValue,-addrVerificationDate),100);
		self.ssns          := DEDUP( NORMALIZE( allRows, LEFT.ssns, TRANSFORM( Healthcare_Shared.Layouts.layout_ssn, SELF := RIGHT	)	), ssn, ALL )(ssn<>'');
		self.dobs          := sort(DEDUP( NORMALIZE( allRows, LEFT.dobs, TRANSFORM( Healthcare_Shared.Layouts.layout_dob, SELF := RIGHT	)	), dob, ALL ),-dob);
		self.dods          := sort(DEDUP( NORMALIZE( allRows, LEFT.dods, TRANSFORM( Healthcare_Shared.Layouts.layout_death, SELF := RIGHT	)	), dod, ALL ),-dod);
		self.phones        := DEDUP( NORMALIZE( allRows, LEFT.phones, TRANSFORM( Healthcare_Shared.Layouts.layout_phone, SELF := RIGHT	)	), RECORD, ALL );
		self.dids          := DEDUP( sort(NORMALIZE( allRows, LEFT.dids, TRANSFORM( Healthcare_Shared.Layouts.layout_did, SELF := RIGHT	)	),did,-freq), did, ALL );
		self.bdids         := DEDUP( sort(NORMALIZE( allRows, LEFT.bdids, TRANSFORM( Healthcare_Shared.Layouts.layout_bdid, SELF := RIGHT	)	),bdid,-freq), bdid, ALL );
		self.bipkeys       := DEDUP( sort(NORMALIZE( allRows, LEFT.bipkeys, TRANSFORM( Healthcare_Shared.Layouts.layout_bipkeys, SELF := RIGHT	)	),UltID,OrgID,SELEID,-freq), UltID,OrgID,SELEID,ProxID, ALL );
		self.feins         := DEDUP( NORMALIZE( allRows, LEFT.feins, TRANSFORM( Healthcare_Shared.Layouts.layout_fein, SELF := RIGHT	)	), fein, ALL );
		self.taxids        := DEDUP( NORMALIZE( allRows, LEFT.taxids(taxid<>''), TRANSFORM( Healthcare_Shared.Layouts.layout_taxid, SELF := RIGHT	)	), taxid, ALL );
		self.upins         := DEDUP( NORMALIZE( allRows, LEFT.upins, TRANSFORM( Healthcare_Shared.Layouts.layout_upin, SELF := RIGHT	)	), upin, ALL );
		self.npis          := DEDUP( sort( NORMALIZE( allRows, LEFT.npis, TRANSFORM( Healthcare_Shared.Layouts.layout_npi, SELF.npi := TRIM(RIGHT.npi,ALL), SELF := RIGHT	)	), npi,bestsource), npi);
		self.deas          := DEDUP( SORT( NORMALIZE( allRows, LEFT.deas(dea_num<>''), TRANSFORM( Healthcare_Shared.Layouts.layout_dea, SELF.dea_num := TRIM(RIGHT.dea_num,ALL), SELF := RIGHT	)	), dea_num, -dea_num_exp,bestsource), dea_num, dea_num_exp );
		self.clianumbers   := DEDUP( NORMALIZE( allRows, LEFT.clianumbers, TRANSFORM( Healthcare_Shared.Layouts.layout_clianumber, SELF := RIGHT	)	), clianumber, ALL );
		self.optouts       := DEDUP( NORMALIZE( allRows, LEFT.optouts, TRANSFORM( Healthcare_Shared.Layouts.layout_optout, SELF := RIGHT	)	), RECORD, ALL );
		//Adding code to do rollup within each license to get most recent and first expire date to provide range
		self.StateLicenses := project(sort(rollup(group(SORT( NORMALIZE( allRows, LEFT.StateLicenses(LicenseNumber<>''), TRANSFORM( Healthcare_Shared.Layouts.layout_licenseinfo, self.LicSortGroup := trim(right.LicenseState,left,right)+(string)(integer)Healthcare_Shared.Functions.cleanOnlyNumbers(right.LicenseNumber); SELF := RIGHT)), LicSortGroup,-Termination_Date),LicSortGroup),group,doStateLicenseRollup(left, rows(left))),-LicSortGroup,map(LicenseStatus='A'=>1,LicenseStatus='S'=>2,LicenseStatus='I'=>3,4)),addLicSeq(left,counter));
		self.affiliates    := DEDUP( NORMALIZE( allRows, LEFT.affiliates, TRANSFORM( Healthcare_Shared.Layouts.layout_affiliateHospital, SELF := RIGHT	)	), name, ALL );
		self.hospitals     := DEDUP( NORMALIZE( allRows, LEFT.hospitals, TRANSFORM( Healthcare_Shared.Layouts.layout_affiliateHospital, SELF := RIGHT	)	), name, ALL, HASH );
		self.Languages     := DEDUP( NORMALIZE( allRows, LEFT.Languages, TRANSFORM( Healthcare_Shared.Layouts.layout_language, SELF := RIGHT	)	), RECORD, ALL, HASH );
		self.Degrees     	 := DEDUP( NORMALIZE( allRows, LEFT.Degrees, TRANSFORM( Healthcare_Shared.Layouts.layout_degree, SELF := RIGHT	)	), RECORD, ALL, HASH );
		self.Specialties   := DEDUP( NORMALIZE( allRows, LEFT.Specialties, TRANSFORM( Healthcare_Shared.Layouts.layout_specialty, SELF := RIGHT	)	), RECORD, ALL, HASH );
		// self.Residencies   := DEDUP( NORMALIZE( allRows, LEFT.Residencies, TRANSFORM( Healthcare_Shared.Layouts.layout_residency, SELF := RIGHT	)	), RECORD, ALL, HASH );
		self.MedSchools    := sort(DEDUP( NORMALIZE( allRows, LEFT.MedSchools, TRANSFORM( Healthcare_Shared.Layouts.layout_medschool, SELF := RIGHT	)	), RECORD, ALL, HASH ),-GraduationYear);
		self.Medicare		   := DEDUP( NORMALIZE( allRows, LEFT.Medicare, TRANSFORM( Healthcare_Shared.Layouts.layout_Medicare, SELF := RIGHT	)	), RECORD, ALL, HASH );
		self.Taxonomy      := DEDUP( NORMALIZE( allRows, LEFT.Taxonomy, TRANSFORM( Healthcare_Shared.Layouts.layout_taxonomy, SELF := RIGHT	)	), RECORD, ALL, HASH );
		self.Sanctions     := allRows(exists(Sanctions)).Sanctions;
		self.LegacySanctions := sort(DEDUP(allRows(exists(LegacySanctions)).LegacySanctions,record, all, hash),groupsortorder);
		self.NPIRaw        := if(hasAllowMergeAuthoritySrc,allRowsRaw(exists(NPIRaw)).NPIRaw,allRows(exists(NPIRaw)).NPIRaw);
		self.DEARaw        := if(hasAllowMergeAuthoritySrc,allRowsRaw(exists(DEARaw)).DEARaw,allRows(exists(DEARaw)).DEARaw);
		self.ProfLicRaw    := allRows(exists(ProfLicRaw)).ProfLicRaw;
		self.CLIARaw    	 := if(hasAllowMergeAuthoritySrc,allRowsRaw(exists(CLIARaw)).CLIARaw,allRows(exists(CLIARaw)).CLIARaw);
		self.NCPDPRaw    	 := if(hasAllowMergeAuthoritySrc,allRowsRaw(exists(NCPDPRaw)).NCPDPRaw,allRows(exists(NCPDPRaw)).NCPDPRaw);
		self.RecordsRaw    	 := allRows.RecordsRaw;
		self := l;
		self :=[];
	END;
	Export Healthcare_Shared.Layouts.CombinedHeaderResults doMergeSourcesRollup(Healthcare_Shared.Layouts.CombinedHeaderResults l, 
																							DATASET(Healthcare_Shared.Layouts.CombinedHeaderResults) allRowsRaw,
																							dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := TRANSFORM
		hasAllowMergeAuthoritySrc := cfg[1].allowMergeAuthoritySrc;
		//Filter out rows the user said they did not want or do not have access too.
		allRows := project(allRowsRaw,transform(Healthcare_Shared.Layouts.CombinedHeaderResults,
								keepRow := map(left.src = Healthcare_Shared.Constants.SRC_AMS and cfg[1].excludeSourceAMS => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_NPPES and cfg[1].excludeSourceNPPES => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_DEA and cfg[1].excludeSourceDEA => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_PROFLIC and cfg[1].excludeSourceProfLic => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_SELECTFILE and cfg[1].excludeSourceSelectFile => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_CLIA and cfg[1].excludeSourceCLIA => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_NCPDP and cfg[1].excludeSourceNCPDP => false,
															 left.src = Healthcare_Shared.Constants.SRC_MPRD and STD.Str.ToUpperCase(left.subSrc[1..3]) = Healthcare_Shared.SourceTools.prefixRoster and cfg[1].ExcludeRoster => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_MPRD and left.subSrc in Healthcare_Shared.SourceTools.set_Claims and cfg[1].ExcludeClaims => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_MPRD and left.subSrc in Healthcare_Shared.SourceTools.set_CHOICEPOINT  and cfg[1].ExcludeOldCP => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_MPRD and left.subSrc in Healthcare_Shared.SourceTools.set_VSF and cfg[1].ExcludeVSF => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_MPRD and left.subSrc in Healthcare_Shared.SourceTools.set_FKA and cfg[1].ExcludeFKA => false,																					
															 true);
								self.acctno := if(keepRow,left.acctno,skip);
								self:=left;));
		SELF.acctno := l.acctno;
		self.glb_ok	:= if(exists(allRows(glb_ok=true)),true,false);
		self.dppa_ok:= if(exists(allRows(dppa_ok=true)),true,false);
		self.isSearchFailed := if(exists(allRows(isSearchFailed=true)),true,false);
		self.keysfailed_decode := allRows(keysfailed_decode<>'')[1].keysfailed_decode;
		self.isAutokeysResult := l.isAutokeysResult;
		self.isHeaderResult := if(l.isAutokeysResult,false,true);
		self.isBestBIPResult := l.isBestBIPResult;
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		self.ProcessingMessage := l.ProcessingMessage;
		self.hasStateRestrict := if(exists(allRows(hasStateRestrict=true)),true,false);
		self.hasOIG := if(exists(allRows(hasOIG=true)),true,false);
		self.hasOPM := if(exists(allRows(hasOPM=true)),true,false);
		self.InternalID := l.InternalID;
		self.LNPID   := l.LNPID;
		self.LNFID   := l.LNFID;
		self.VendorID := sort(allrows(length(trim(VendorID,right))>30),vendorid)[1].VendorID; // determinism, if multiple group_keys, keep smallest
		self.Src    := if(l.isAutokeysResult or l.Src=Healthcare_Shared.Constants.SRC_SANC or l.Src=Healthcare_Shared.Constants.SRC_BOCA_BUS_HEADER or l.Src=Healthcare_Shared.Constants.SRC_BOCA_PERSON_HEADER,l.Src,Healthcare_Shared.Constants.SRC_HEADER);//For business re-entry we need to keep this until header 2
		self.userinput := sort(allrows,if(userinput.clnName.acctno<>'' or userinput.clnAddr.acctno<>'',1,99))[1].userinput;
		self.NPPESVerified := map(exists(allRows(NPPESVerified='YES')) => 'YES',
															exists(allRows(NPPESVerified='CORRECTED')) => 'CORRECTED',
															' ');
		self.last_update_date := max(allRows,last_update_date);
		self.DeathLookup := if(exists(allRows(DeathLookup=true)),true,false);
		self.DateofDeath := allRows(DateofDeath<>'')[1].DateofDeath;
		self.DOServiceFromDate := if((string)l.DOServiceFromDate<>'',(integer)l.DOServiceFromDate,(integer)l.userinput.ServiceFromDate);
		self.DOServiceToDate := if((string)l.DOServiceToDate<>'',(integer)l.DOServiceToDate,(integer)l.userinput.ServiceToDate);
		self.Sources       := DEDUP( NORMALIZE( allRows, LEFT.Sources, TRANSFORM( Healthcare_Shared.Layouts.layout_SrcID, SELF := RIGHT	)	), RECORD, ALL );
		self.dids          := DEDUP( sort(NORMALIZE( allRows, LEFT.dids, TRANSFORM( Healthcare_Shared.Layouts.layout_did, SELF := RIGHT	)	),did,-freq), did, ALL );
		self.bdids         := DEDUP( sort(NORMALIZE( allRows, LEFT.bdids, TRANSFORM( Healthcare_Shared.Layouts.layout_bdid, SELF := RIGHT	)	),bdid,-freq), bdid, ALL );
		self.bipkeys       := DEDUP( sort(NORMALIZE( allRows, LEFT.bipkeys, TRANSFORM( Healthcare_Shared.Layouts.layout_bipkeys, SELF := RIGHT	)	),UltID,OrgID,SELEID,-freq), UltID,OrgID,SELEID,ProxID, ALL );
		self.affiliates    := DEDUP( NORMALIZE( allRows, LEFT.affiliates, TRANSFORM( Healthcare_Shared.Layouts.layout_affiliateHospital, SELF := RIGHT	)	), name, ALL );
		self.hospitals     := DEDUP( NORMALIZE( allRows, LEFT.hospitals, TRANSFORM( Healthcare_Shared.Layouts.layout_affiliateHospital, SELF := RIGHT	)	), name, ALL, HASH );
		self.officeAttributes := DEDUP( NORMALIZE( allRows, LEFT.officeAttributes, TRANSFORM( Healthcare_Shared.Layouts.layout_officeAttributes, SELF := RIGHT	)	), record, ALL, HASH );
		self.NPIRaw        := if(hasAllowMergeAuthoritySrc,allRowsRaw(exists(NPIRaw)).NPIRaw,allRows(exists(NPIRaw)).NPIRaw);
		self.DEARaw        := if(hasAllowMergeAuthoritySrc,allRowsRaw(exists(DEARaw)).DEARaw,allRows(exists(DEARaw)).DEARaw);
		self.ProfLicRaw    := allRows(exists(ProfLicRaw)).ProfLicRaw;
		self.CLIARaw    	 := if(hasAllowMergeAuthoritySrc,allRowsRaw(exists(CLIARaw)).CLIARaw,allRows(exists(CLIARaw)).CLIARaw);
		self.NCPDPRaw    	 := if(hasAllowMergeAuthoritySrc,allRowsRaw(exists(NCPDPRaw)).NCPDPRaw,allRows(exists(NCPDPRaw)).NCPDPRaw);
		self.RecordsRaw    	 := allRows.RecordsRaw;
		self := l;
		self :=[];
	END;
/*	Export Healthcare_Shared.Layouts.CombinedHeaderResults doFinalRollup(Healthcare_Shared.Layouts.CombinedHeaderResults l, 
																							DATASET(Healthcare_Shared.Layouts.CombinedHeaderResults) allRowsRaw,
																							dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := TRANSFORM
		hasAllowMergeAuthoritySrc := cfg[1].allowMergeAuthoritySrc;
		//Filter out rows the user said they did not want or do not have access too.
		allRows := project(allRowsRaw,transform(Healthcare_Shared.Layouts.CombinedHeaderResults,
								keepRow := map(left.src = Healthcare_Shared.Constants.SRC_AMS and cfg[1].excludeSourceAMS => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_NPPES and cfg[1].excludeSourceNPPES => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_DEA and cfg[1].excludeSourceDEA => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_PROFLIC and cfg[1].excludeSourceProfLic => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_SELECTFILE and cfg[1].excludeSourceSelectFile => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_CLIA and cfg[1].excludeSourceCLIA => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_NCPDP and cfg[1].excludeSourceNCPDP => false,
															 left.src = Healthcare_Shared.Constants.SRC_MPRD and STD.Str.ToUpperCase(left.subSrc[1..3]) = Healthcare_Shared.SourceTools.prefixRoster and cfg[1].ExcludeRoster => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_MPRD and left.subSrc in Healthcare_Shared.SourceTools.set_Claims and cfg[1].ExcludeClaims => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_MPRD and left.subSrc in Healthcare_Shared.SourceTools.set_CHOICEPOINT  and cfg[1].ExcludeOldCP => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_MPRD and left.subSrc in Healthcare_Shared.SourceTools.set_VSF and cfg[1].ExcludeVSF => false,																					
															 left.src = Healthcare_Shared.Constants.SRC_MPRD and left.subSrc in Healthcare_Shared.SourceTools.set_FKA and cfg[1].ExcludeFKA => false,																					
															 true);
								self.acctno := if(keepRow,left.acctno,skip);
								self:=left;));
		SELF.acctno := l.acctno;
		self.LNPID   := l.LNPID;
		self.SrcId  := l.SrcId;
		self.Src    := if(l.isAutokeysResult or l.Src=Healthcare_Shared.Constants.SRC_SANC or l.Src=Healthcare_Shared.Constants.SRC_BOCA_BUS_HEADER or l.Src=Healthcare_Shared.Constants.SRC_BOCA_PERSON_HEADER,l.Src,Healthcare_Shared.Constants.SRC_HEADER);//For business re-entry we need to keep this until header 2
		self.VendorID := ''; //vendor id should be blank as thee are multiple vendors within a given result
		self.isAutokeysResult := l.isAutokeysResult;
		self.isHeaderResult := if(l.isAutokeysResult,false,true);
		self.isBestBIPResult := l.isBestBIPResult;
		self.glb_ok	:= if(exists(allRows(glb_ok=true)),true,false);
		self.dppa_ok:= if(exists(allRows(dppa_ok=true)),true,false);
		self.srcIndividualHeader := l.srcIndividualHeader;
		self.srcBusinessHeader := l.srcBusinessHeader;
		self.ProcessingMessage := l.ProcessingMessage;
		self.hasStateRestrict := if(exists(allRows(hasStateRestrict=true)),true,false);
		self.hasOIG := if(exists(allRows(hasOIG=true)),true,false);
		self.hasOPM := if(exists(allRows(hasOPM=true)),true,false);
		//Handle Status
		statusDeceased := exists(allRows(status='D'));
		statusUnconfirmedDeceased := exists(allRows(status='U1'));
		statusStrongUnconfirmedDeceased := exists(allRows(status='U'));
		statusRetired := exists(allRows(status in ['R','R3']));
		statusTierIStrongestRetired := exists(allRows(status='R1'));
		statusTierIIRetired := exists(allRows(status='R2'));
		statusTierIVWeakRetired := exists(allRows(status='R4'));
		statusAActive := exists(allRows(status='A'));
		statusNActive := exists(allRows(status='N'));
		self.status := map(statusDeceased => 'D',
											 statusUnconfirmedDeceased => 'U1',
											 statusStrongUnconfirmedDeceased => 'U',
											 statusRetired => 'R',
											 statusTierIStrongestRetired => 'R1',
											 statusTierIIRetired => 'R2',
											 statusTierIVWeakRetired => 'R4',
											 statusNActive => 'N',
											 statusAActive => 'A',
											 ' ');
		self.NPPESVerified := map(exists(allRows(NPPESVerified='YES')) => 'YES',
															exists(allRows(NPPESVerified='CORRECTED')) => 'CORRECTED',
															' ');
		self.Sources       := DEDUP( NORMALIZE( allRows, LEFT.Sources, TRANSFORM( Healthcare_Shared.Layouts.layout_SrcID, SELF := RIGHT	)	), RECORD, ALL );
		self.Names         := sort(DEDUP(sort( NORMALIZE( allRows, LEFT.Names(nameSeq>0), TRANSFORM( Healthcare_Shared.Layouts.layout_nameinfo, SELF := RIGHT	)	), FullName,FirstName,MiddleName,LastName,Suffix,CompanyName,nameSeq ), FullName,FirstName,MiddleName,LastName,Suffix,CompanyName),nameSeq,namePenalty);

		/*Add logic to sort based on requirements
			normalize the addresses
			sort them so similar address are together and get priority fields in first position
			dedupe out duplicates that are the exact same address, but to not have the priority fields set
			resort the address using the priority sorting below.
			**** Primary Sorting Sequence ****
			The individual dataset build routines are going to have different addrseq values
			Finally, put a decending on the seen dates to put think in oder after that 
		/*
		self.Addresses     := Choosen(sort(rollup(group(sort(NORMALIZE( allRows, LEFT.Addresses, 
																										TRANSFORM( Healthcare_Shared.Layouts.layout_addressinfo, SELF := RIGHT	)),
																					prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5,addrSeq,-(integer)addrConfidenceValue),
																		 prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,z5),group,doFinalBaseRecordAddrRollup(left,rows(left))),addrseq,-(integer)addrConfidenceValue,-addrVerificationDate),100);
		self.ssns          := DEDUP( NORMALIZE( allRows, LEFT.ssns, TRANSFORM( Healthcare_Shared.Layouts.layout_ssn, SELF := RIGHT	)	), ssn, ALL )(ssn<>'');
		self.dobs          := sort(DEDUP( NORMALIZE( allRows, LEFT.dobs, TRANSFORM( Healthcare_Shared.Layouts.layout_dob, SELF := RIGHT	)	), dob, ALL ),-dob);
		self.dods          := sort(DEDUP( NORMALIZE( allRows, LEFT.dods, TRANSFORM( Healthcare_Shared.Layouts.layout_death, SELF := RIGHT	)	), dod, ALL ),-dod);
		self.phones        := DEDUP( NORMALIZE( allRows, LEFT.phones, TRANSFORM( Healthcare_Shared.Layouts.layout_phone, SELF := RIGHT	)	), RECORD, ALL );
		self.dids          := DEDUP( sort(NORMALIZE( allRows, LEFT.dids, TRANSFORM( Healthcare_Shared.Layouts.layout_did, SELF := RIGHT	)	),did,-freq), did, ALL );
		self.bdids         := DEDUP( sort(NORMALIZE( allRows, LEFT.bdids, TRANSFORM( Healthcare_Shared.Layouts.layout_bdid, SELF := RIGHT	)	),bdid,-freq), bdid, ALL );
		self.bipkeys       := DEDUP( sort(NORMALIZE( allRows, LEFT.bipkeys, TRANSFORM( Healthcare_Shared.Layouts.layout_bipkeys, SELF := RIGHT	)	),UltID,OrgID,SELEID,-freq), UltID,OrgID,SELEID,ProxID, ALL );
		self.feins         := DEDUP( NORMALIZE( allRows, LEFT.feins, TRANSFORM( Healthcare_Shared.Layouts.layout_fein, SELF := RIGHT	)	), fein, ALL );
		self.taxids        := DEDUP( NORMALIZE( allRows, LEFT.taxids(taxid<>''), TRANSFORM( Healthcare_Shared.Layouts.layout_taxid, SELF := RIGHT	)	), taxid, ALL );
		self.upins         := DEDUP( NORMALIZE( allRows, LEFT.upins, TRANSFORM( Healthcare_Shared.Layouts.layout_upin, SELF := RIGHT	)	), upin, ALL );
		self.npis          := DEDUP( sort( NORMALIZE( allRows, LEFT.npis, TRANSFORM( Healthcare_Shared.Layouts.layout_npi, SELF.npi := TRIM(RIGHT.npi,ALL), SELF := RIGHT	)	), npi,bestsource), npi);
		self.deas          := DEDUP( SORT( NORMALIZE( allRows, LEFT.deas(dea_num<>''), TRANSFORM( Healthcare_Shared.Layouts.layout_dea, SELF.dea_num := TRIM(RIGHT.dea_num,ALL), SELF := RIGHT	)	), dea_num, -dea_num_exp,bestsource), dea_num, dea_num_exp );
		self.clianumbers   := DEDUP( NORMALIZE( allRows, LEFT.clianumbers, TRANSFORM( Healthcare_Shared.Layouts.layout_clianumber, SELF := RIGHT	)	), clianumber, ALL );
		self.optouts       := DEDUP( NORMALIZE( allRows, LEFT.optouts, TRANSFORM( Healthcare_Shared.Layouts.layout_optout, SELF := RIGHT	)	), RECORD, ALL );
		//Adding code to do rollup within each license to get most recent and first expire date to provide range
		self.StateLicenses := project(sort(rollup(group(SORT( NORMALIZE( allRows, LEFT.StateLicenses(LicenseNumber<>''), TRANSFORM( Healthcare_Shared.Layouts.layout_licenseinfo, self.LicSortGroup := trim(right.LicenseState,left,right)+(string)(integer)Healthcare_Shared.Functions.cleanOnlyNumbers(right.LicenseNumber); SELF := RIGHT)), LicSortGroup,-Termination_Date),LicSortGroup),group,doStateLicenseRollup(left, rows(left))),-LicSortGroup,map(LicenseStatus='A'=>1,LicenseStatus='S'=>2,LicenseStatus='I'=>3,4)),addLicSeq(left,counter));
		self.affiliates    := DEDUP( NORMALIZE( allRows, LEFT.affiliates, TRANSFORM( Healthcare_Shared.Layouts.layout_affiliateHospital, SELF := RIGHT	)	), name, ALL );
		self.hospitals     := DEDUP( NORMALIZE( allRows, LEFT.hospitals, TRANSFORM( Healthcare_Shared.Layouts.layout_affiliateHospital, SELF := RIGHT	)	), name, ALL, HASH );
		self.Languages     := DEDUP( NORMALIZE( allRows, LEFT.Languages, TRANSFORM( Healthcare_Shared.Layouts.layout_language, SELF := RIGHT	)	), RECORD, ALL, HASH );
		self.Degrees     	 := DEDUP( NORMALIZE( allRows, LEFT.Degrees, TRANSFORM( Healthcare_Shared.Layouts.layout_degree, SELF := RIGHT	)	), RECORD, ALL, HASH );
		self.Specialties   := DEDUP( NORMALIZE( allRows, LEFT.Specialties, TRANSFORM( Healthcare_Shared.Layouts.layout_specialty, SELF := RIGHT	)	), RECORD, ALL, HASH );
		// self.Residencies   := DEDUP( NORMALIZE( allRows, LEFT.Residencies, TRANSFORM( Healthcare_Shared.Layouts.layout_residency, SELF := RIGHT	)	), RECORD, ALL, HASH );
		self.MedSchools    := sort(DEDUP( NORMALIZE( allRows, LEFT.MedSchools, TRANSFORM( Healthcare_Shared.Layouts.layout_medschool, SELF := RIGHT	)	), RECORD, ALL, HASH ),-GraduationYear);
		self.Medicare		   := DEDUP( NORMALIZE( allRows, LEFT.Medicare, TRANSFORM( Healthcare_Shared.Layouts.layout_Medicare, SELF := RIGHT	)	), RECORD, ALL, HASH );
		self.Taxonomy      := DEDUP( NORMALIZE( allRows, LEFT.Taxonomy, TRANSFORM( Healthcare_Shared.Layouts.layout_taxonomy, SELF := RIGHT	)	), RECORD, ALL, HASH );
		self.Sanctions     := allRows(exists(Sanctions)).Sanctions;
		self.LegacySanctions := sort(DEDUP(allRows(exists(LegacySanctions)).LegacySanctions,record, all, hash),groupsortorder);
		self.NPIRaw        := if(hasAllowMergeAuthoritySrc,allRowsRaw(exists(NPIRaw)).NPIRaw,allRows(exists(NPIRaw)).NPIRaw);
		self.DEARaw        := if(hasAllowMergeAuthoritySrc,allRowsRaw(exists(DEARaw)).DEARaw,allRows(exists(DEARaw)).DEARaw);
		self.ProfLicRaw    := allRows(exists(ProfLicRaw)).ProfLicRaw;
		self.CLIARaw    	 := if(hasAllowMergeAuthoritySrc,allRowsRaw(exists(CLIARaw)).CLIARaw,allRows(exists(CLIARaw)).CLIARaw);
		self.NCPDPRaw    	 := if(hasAllowMergeAuthoritySrc,allRowsRaw(exists(NCPDPRaw)).NCPDPRaw,allRows(exists(NCPDPRaw)).NCPDPRaw);
		self.RecordsRaw    := allRows.RecordsRaw;
		self := l;
		self :=[];
	END;*/
	//Legacy Transforms
	shared legacyLayout.ingenix_npi_rec processNpi(iesp.npireport.t_NPIReport rec, integer c, string Verified) := transform
			self.NPI := rec.NPIInformation.NPINumber;
			self.NPITierTypeID:=0;
			self.NPPESVerified:=if(c=1,Verified,'NO');
	end;
	shared legacyLayout.ingenix_npi_rec processNpiSource(Healthcare_Shared.Layouts.layout_npi rec) := transform
			self.NPI := rec.NPI;
			self.NPITierTypeID:=0;
			self.NPPESVerified:='NO';
	end;
	Export LegacySearch fmtLegacySearch (Healthcare_Shared.Layouts.CombinedHeaderResults resultRec) := transform
		self.ProviderID:= if(resultRec.issearchfailed,skip,(string)resultRec.LNPID);
		self.ProviderSrc:= resultRec.Src;
		self.did:=(string)resultRec.dids[1].did;
		self.name:= dedup(project(choosen(resultRec.Names,Healthcare_Shared.Constants.MAX_SEARCH_RECS), 
																	transform(legacyLayout.ingenix_name_rec,
																						skipit := left.FirstName = '' and left.MiddleName = '' and left.LastName ='';
																						self.Prov_Clean_fname := if(skipit,skip,left.FirstName);
																						self.Prov_Clean_mname := left.MiddleName;
																						self.Prov_Clean_lname := if(left.LastName <>'',left.LastName,left.CompanyName);
																						self.Prov_Clean_name_suffix := left.Suffix;
																						self := [];)),Prov_Clean_fname,Prov_Clean_mname,Prov_Clean_lname,all);
		self.taxid := project(choosen(resultRec.taxids,Healthcare_Shared.Constants.MAX_SEARCH_RECS), 
																		transform(legacyLayout.ingenix_taxid_rec, self.TaxID:=left.taxid;self := [];));
		self.dob := project(choosen(resultRec.dobs,Healthcare_Shared.Constants.MAX_SEARCH_RECS), 
																		transform(legacyLayout.ingenix_dob_rec, self.BirthDate:=left.dob;self := [];));
		self.license := dedup(sort(project(choosen(resultRec.StateLicenses,Healthcare_Shared.Constants.MAX_SEARCH_RECS), 
																		transform(legacyLayout.ingenix_license_rec,self := left;self := [])),record),record);
		self.address := project(choosen(resultRec.Addresses,Healthcare_Shared.Constants.MAX_SEARCH_RECS), 
																		transform(legacyLayout.ingenix_addr_rec_online,
																							tmp_off_phone:=project(left.Phones(phonenumber<>''),transform(legacyLayout.ingenix_phone_slim_rec, self.PhoneNumber := left.phonenumber;self.PhoneType:='OFFICE PHONE';self := []));
																							tmp_off_fax:=project(left.Phones(faxnumber<>''),transform(legacyLayout.ingenix_phone_slim_rec, self.PhoneNumber := left.faxnumber;self.PhoneType:='OFFICE FAX';self := []));
																							self.Prov_Clean_prim_range:=left.prim_range;
																							self.Prov_Clean_predir:=left.predir;
																							self.Prov_Clean_prim_name:=left.prim_name;
																							self.Prov_Clean_addr_suffix:=left.addr_suffix;
																							self.Prov_Clean_postdir:=left.postdir;
																							self.Prov_Clean_unit_desig:=left.unit_desig;
																							self.Prov_Clean_sec_range:=left.sec_range;
																							self.Prov_Clean_p_city_name:=left.p_city_name;
																							self.Prov_Clean_v_city_name:=left.v_city_name;
																							self.Prov_Clean_st:=left.st;
																							self.Prov_Clean_zip:=left.z5;
																							self.Prov_Clean_zip4:=left.zip4;
																							self.first_seen := left.first_seen;
																							self.last_seen := left.last_seen;
																							SELF.PHONE := tmp_off_phone(PhoneNumber<>'')+tmp_off_fax(PhoneNumber<>''); 
																							self := []));
	end;
	Export LegacyReport fmtLegacyRpt(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout resultRec, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := transform
		searchCriteria := cfg[1];
		myGender := resultRec.Names(Gender<>'')[1].Gender;
		self.Providerid:= if(resultRec.issearchfailed,skip,(string)resultRec.LNPID);
		self.ProviderSrc:= resultRec.Src;
		self.Gender := myGender;
		self.Gender_Name := map(myGender='M' => 'MALE',
														myGender='F' => 'FEMALE',
														myGender);
		self.sanc_flag := if(count(resultRec.LegacySanctions) >0,true,false);
		self.sanction_id := [];//Do not exist anymore;
		self.providerdid := project(resultRec.dids, transform(legacyLayout.ingenix_did_rec,self.did:=(string)left.did));
		self.name:= project(resultRec.Names, transform(legacyLayout.ingenix_name_rec,
																						skipit := left.FirstName = '' and left.MiddleName = '' and left.LastName ='';
																						self.Prov_Clean_fname := if(skipit,skip,left.FirstName);
																						self.Prov_Clean_mname := left.MiddleName;
																						self.Prov_Clean_lname := if(left.LastName <>'',left.LastName,left.CompanyName);
																						self.Prov_Clean_name_suffix := left.Suffix;
																						self := [];));
		self.taxid := project(resultRec.taxids, transform(legacyLayout.ingenix_taxid_rec, self.TaxID:=left.taxid;self := [];));
		self.dob := project(resultRec.dobs, transform(legacyLayout.ingenix_dob_rec, self.BirthDate:=left.dob;self := [];));
		//Add rules about DOD
		dodTmp := dataset([{(string)resultRec.DeathLookup,resultRec.DateofDeath}],legacyLayout.ingenix_dod_rec);
		dodFull := dedup(sort(project(resultRec.dods, transform(legacyLayout.ingenix_dod_rec, self.DeceasedIndicator := if(left.death_ind,'T',''); self.DeceasedDate:=left.dod))+dodTmp,-DeceasedDate),record)(DeceasedDate<>'');
		self.dod := if(searchCriteria.IsShowAllDoDs,dodFull,choosen(dodFull,1));
		self.language := project(resultRec.Languages,transform(legacyLayout.ingenix_language_rec,self:=left;self:=[];));
		self.upin := project(resultRec.upins,transform(legacyLayout.ingenix_upin_rec,self.UPIN:=left.upin;self := []));
		npi_recs := project(resultRec.NPIRaw,processNpi(Left,counter,resultRec.NPPESVerified));
		npi_recs_orig := project(resultRec.npis,processNpiSource(left));
		npi_recs_filter := join(npi_recs,npi_recs_orig,left.npi=right.npi,right only);//Only keep those that are not dupes
		npi_recs_final := dedup(sort(npi_recs+npi_recs_filter,if(nppesverified = 'YES', 1, 2),npi),npi);
		self.npi := npi_recs_final;
		self.license := project(resultRec.StateLicenses, transform(legacyLayout.ingenix_license_rpt_rec,
																											self.LicenseState := left.LicenseState;
																											self.LicenseNumber := left.LicenseNumber;
																											self.Effective_Date := left.Effective_Date;
																											self.Termination_Date := left.Termination_Date;
																											self := []));
		self.dea := dedup(sort(project(resultRec.deas,transform(legacyLayout.ingenix_dea_rec,
																											self.DEANumber:=left.dea_num;
																											self.expiration_date := left.dea_num_exp;
																											self := []))(expiration_date<>''),deanumber,-expiration_date),deanumber,expiration_date);

		self.degree := project(resultRec.Degrees,transform(legacyLayout.ingenix_degree_rec,self:=left;self:=[];));
		self.specialty := project(resultRec.Specialties,transform(legacyLayout.ingenix_specialty_rec,self.specialtyid:=(integer)left.specialtyid;self:=left;self:=[];));
		self.business_address := project(resultRec.Addresses, transform(legacyLayout.ingenix_addr_rpt_rec,
																		tmp_off_phone:=project(left.Phones(phonenumber<>''),transform(legacyLayout.ingenix_phone_slim_rec, self.PhoneNumber := left.phonenumber,self.PhoneType:='OFFICE PHONE';self := []));
																		tmp_off_fax:=project(left.Phones(faxnumber<>''),transform(legacyLayout.ingenix_phone_slim_rec, self.PhoneNumber := left.faxnumber,self.PhoneType:='OFFICE FAX';self := []));
																							self.Prov_Clean_prim_range:=left.prim_range;
																							self.Prov_Clean_predir:=left.predir;
																							self.Prov_Clean_prim_name:=left.prim_name;
																							self.Prov_Clean_addr_suffix:=left.addr_suffix;
																							self.Prov_Clean_postdir:=left.postdir;
																							self.Prov_Clean_unit_desig:=left.unit_desig;
																							self.Prov_Clean_sec_range:=left.sec_range;
																							self.Prov_Clean_p_city_name:=left.p_city_name;
																							self.Prov_Clean_v_city_name:=left.v_city_name;
																							self.Prov_Clean_st:=left.st;
																							self.Prov_Clean_zip:=left.z5;
																							self.Prov_Clean_zip4:=left.zip4;
																							self.prov_Clean_geo_lat:=left.geo_lat;
																							SELF.prov_Clean_geo_long:=left.geo_long;
																							SELF.PHONE := tmp_off_phone(PhoneNumber<>'')+tmp_off_fax(PhoneNumber<>'');
																							self.first_seen := left.first_seen;
																							self.last_seen := left.last_seen;
																							self := []));
		self.group_affiliation := project(resultRec.affiliates, transform(legacyLayout.ingenix_group_rec,
																							self.BDID := (string)left.bdid;
																							self.GroupName := left.name;
																							self.Address := left.address1;
																							self.City := left.p_city_name;
																							self.State := left.st;
																							self.Zip := left.z5;
																							self := []));
		self.hospital_affiliation := project(resultRec.hospitals, transform(legacyLayout.ingenix_hospital_rec,
																							self.BDID := (string)left.bdid;
																							self.HospitalName := left.name;
																							self.Address := left.address1;
																							self.City := left.p_city_name;
																							self.State := left.st;
																							self.Zip := left.z5;
																							self := []));
		self.residency := dataset([],legacyLayout.ingenix_residency_rec);
		self.medschool := project(resultRec.MedSchools,transform(legacyLayout.ingenix_medschool_rec,self:=left;self:=[];));
		self.taxonomy := project(resultRec.Taxonomy,transform(legacyLayout.ingenix_taxonomy_rec,self:=left;self:=[];));
		self.sanction_data := project(resultRec.LegacySanctions,transform(legacyLayout.ingenix_sanc_child_rec_full,self:=left;self:=[];));
		self.SSN := dedup(sort(project(resultRec.SSNLookups,legacyLayout.ingenix_ssn_rec)+project(resultRec.ssns,legacyLayout.ingenix_ssn_rec),record),record);
		self.medicareoptout := project(resultRec.optouts, transform(legacyLayout.ingenix_medicare_optout_rec,
																				self.OptOutSiteDescription:=left.optout_sitedesc;
																				self.AffidavitReceivedDate:=left.optout_rec_dt;
																				self.OptOutEffectiveDate:=left.optout_eff_dt;
																				self.OptOutTerminationDate:=left.optout_term_dt;
																				self.OptOutStatus:=left.optout_status;
																				self.LastUpdate:=left.optout_last_update;
																				self := []))(OptOutSiteDescription<>'' or OptOutTerminationDate<>'');
		self.Deceased := resultRec.DeathLookup;
		self := resultRec;
		self := [];
	end;
end;