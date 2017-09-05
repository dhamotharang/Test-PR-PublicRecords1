IMPORT Address_Attributes, BIPv2, Business_Header, codes, ADVO, Business_Risk, Risk_indicators, RiskWise, Address, YellowPages, Easi, Business_Risk_BIP, DueDiligence;

/* 
	Following Keys being used:
			Address_Attributes.key_AML_addr
*/

EXPORT getBusAddrData(DATASET(DueDiligence.Layouts.Busn_Internal) inData,
												Business_Risk_BIP.LIB_Business_Shell_LIBIN options) := FUNCTION

	//get unique addrress for businesses coming in
	sortInData := SORT(inData, seq, #EXPAND(DueDiligence.Constants.mac_ListTop3Linkids()), Busn_info.address.prim_range, Busn_info.address.prim_name, Busn_info.address.addr_suffix, Busn_info.address.postdir, Busn_info.address.zip5);
	dedupInData  :=  DEDUP(sortInData, seq, #EXPAND(DueDiligence.Constants.mac_ListTop3Linkids()), Busn_info.address.prim_range, Busn_info.address.prim_name, Busn_info.address.addr_suffix, Busn_info.address.postdir, Busn_info.address.zip5);

	addrRaw := join(dedupInData, Address_Attributes.key_AML_addr, 
									KEYED(TRIM(LEFT.busn_info.address.zip5) = RIGHT.zip) AND
									KEYED(TRIM(LEFT.busn_info.address.prim_range) = RIGHT.prim_range) AND
									KEYED(TRIM(LEFT.busn_info.address.prim_name) = RIGHT.prim_name) AND
									KEYED(TRIM(LEFT.busn_info.address.addr_suffix) = RIGHT.addr_suffix) AND
									KEYED(TRIM(LEFT.busn_info.address.predir) = RIGHT.predir) AND
									KEYED(TRIM(LEFT.busn_info.address.postdir) = RIGHT.postdir),
									TRANSFORM({UNSIGNED4 UniqueID, UNSIGNED6 ultID, UNSIGNED6 orgID, UNSIGNED6 seleID, UNSIGNED6 inPowID, RECORDOF(Address_Attributes.key_AML_addr)},
														SELF.UniqueID := LEFT.seq;
														SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
														SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
														SELF.seleID := LEFT.Busn_info.BIP_IDS.SeleID.LinkID;
														SELF.inPowID := LEFT.Busn_info.BIP_IDS.PowID.LinkID;
														SELF := RIGHT;),
									ATMOST(100));

	// Add back our Seq number
	DueDiligence.Common.AppendSeq(addrRaw, indata, addrRaw_seq);
	
	// Filter out records after our history date.
	addrDataFiltRecs := DueDiligence.Common.FilterRecordsSingleDate(addrRaw_seq, dt_first_seen);
	
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently - dates used in FilterRecords have been cleaned
	clean_dateLastSeen := DueDiligence.Common.CleanDateFields(addrDataFiltRecs, dt_last_seen);

	//creating variable to be used in logic so if add additional dates, does not impact flow
	addrDataFilt := clean_dateLastSeen;
	
	matchingPowIDs := addrDataFilt(inPowID = powID);
	
	//determine company org structure
	structures := PROJECT(matchingPowIDs, TRANSFORM({RECORDOF(LEFT)},
																									SELF.company_org_structure_derived := IF(LEFT.trust >= 1, DueDiligence.Constants.CMPTYP_TRUST, LEFT.company_org_structure_derived);
																									SELF := LEFT;));
	
	sortStructures := SORT(structures, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), -dt_last_seen);
	
	rollStructure := ROLLUP(sortStructures,
													LEFT.seq = RIGHT.seq AND
													LEFT.ultID = RIGHT.ultID AND
													LEFT.orgID = RIGHT.orgID AND
													LEFT.seleID = RIGHT.seleID,
													TRANSFORM({RECORDOF(sortStructures)},
																		SELF.company_org_structure_derived := IF(LEFT.company_org_structure_derived = '', RIGHT.company_org_structure_derived, LEFT.company_org_structure_derived);
																		SELF := LEFT;));
		
	addAddrStructure := JOIN(inData, rollStructure,
														LEFT.seq = RIGHT.seq AND
														LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
														LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
														LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,
														TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																			SELF.adrBusnType := RIGHT.company_org_structure_derived;
																			SELF := LEFT;),
														LEFT OUTER);




// output(inData, named('inData'));
// output(sortInData, named('sortInData'));
// output(dedupInData, named('dedupInData'));
// output(addrRaw, named('addrRaw'));
// output(addrRaw_seq, named('addrRaw_seq'));
// output(addrDataFilt, named('addrDataFilt'));


// output(matchingPowIDs, named('matchingPowIDs'));
// output(structures, named('structures'));
// output(sortStructures, named('sortStructures'));
// output(rollStructure, named('rollStructure'));
// output(addAddrStructure, named('addAddrStructure'));



RETURN addAddrStructure;

END;
