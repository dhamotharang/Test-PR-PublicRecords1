IMPORT BIPV2, PublicRecords_KEL;

EXPORT BIP_Linked_Businesses(PublicRecords_KEL.Interface_Options Options,
									DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) BusinessInput = DATASET([], PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII)
									) := MODULE


	// ------- Get Address Matches across all businesses ------------- //
	SHARED AddressSearchInput := PROJECT(BusinessInput(B_InpClnAddrPrimName <> '' AND B_InpClnAddrZip5 <> ''), 
		TRANSFORM(BIPV2.IDFunctions.rec_SearchInput,
			SELF.acctno := (STRING)LEFT.G_ProcBusUID;
			SELF.prim_range := LEFT.B_InpClnAddrPrimRng;
			SELF.prim_name := LEFT.B_InpClnAddrPrimName;
			SELF.zip5 := LEFT.B_InpClnAddrZip5;
			SELF.sec_range := LEFT.B_InpClnAddrSecRng;
			SELF.city := LEFT.B_InpClnAddrCity;
			SELF.state := LEFT.B_InpClnAddrState;
			SELF := []));

	SHARED AddressSearchResultsRaw := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(AddressSearchInput).uid_results_w_acct;
	
	SHARED AddressSearchResults := PROJECT(AddressSearchResultsRaw, 
		TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2,
			SELF.UniqueID := (UNSIGNED)LEFT.acctno,
			SELF.UltID := LEFT.UltID,
			SELF.OrgID := LEFT.OrgID,
			SELF.SeleID := LEFT.SeleID,
			SELF.ProxID := LEFT.ProxID,
			SELF.PowID := LEFT.PowID,
			SELF := []));
																					
	// ------- Get TIN Matches across all businesses ------------- //
	SHARED TINSearchInput := PROJECT(BusinessInput(B_InpClnTIN <> ''), 
		TRANSFORM(BIPV2.IDFunctions.rec_SearchInput,
			SELF.acctno := (STRING)LEFT.G_ProcBusUID;
			SELF.FEIN := LEFT.B_InpClnTIN,
			SELF := []));

	SHARED TINSearchResultsRaw := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(TINSearchInput).uid_results_w_acct;
	
	SHARED TINSearchResults := PROJECT(TINSearchResultsRaw, 
		TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2,
			SELF.UniqueID := (UNSIGNED)LEFT.acctno,
			SELF.UltID := LEFT.UltID,
			SELF.OrgID := LEFT.OrgID,
			SELF.SeleID := LEFT.SeleID,
			SELF.ProxID := LEFT.ProxID,
			SELF.PowID := LEFT.PowID,
			SELF := []));
	
		// ------- Get Phone Matches across all businesses ------------- //
	SHARED PhoneSearchInput := PROJECT(BusinessInput(B_InpClnPhone <> ''), 
		TRANSFORM(BIPV2.IDFunctions.rec_SearchInput,
			SELF.acctno := (STRING)LEFT.G_ProcBusUID;
			SELF.phone10 := LEFT.B_InpClnPhone,
			SELF := []));
				
	SHARED PhoneSearchResultsRaw := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(PhoneSearchInput).uid_results_w_acct;
	
	SHARED PhoneSearchResults := PROJECT(PhoneSearchResultsRaw, 
		TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2,
			SELF.UniqueID := (UNSIGNED)LEFT.acctno,
			SELF.UltID := LEFT.UltID,
			SELF.OrgID := LEFT.OrgID,
			SELF.SeleID := LEFT.SeleID,
			SELF.ProxID := LEFT.ProxID,
			SELF.PowID := LEFT.PowID,
			SELF := []));

	// Put results together
	SHARED BIP_Filters_Raw := AddressSearchInput + TINSearchInput + PhoneSearchInput;
	EXPORT BIP_Filters := PROJECT(BIP_Filters_Raw, 
		TRANSFORM(BIPV2.IDlayouts.l_filter_record,
			SELF.UniqueID := (UNSIGNED)LEFT.acctno,
			SELF.prim_range := LEFT.prim_range,
			SELF.prim_name := LEFT.prim_name,
			SELF.sec_range := LEFT.sec_range,
			SELF.zip := LEFT.zip5,
			SELF.company_fein := LEFT.fein,
			SELF.company_phone := LEFT.phone10));	
	
	SHARED Linked_BIPIDs_Unfiltered := DEDUP(SORT(AddressSearchResults + TINSearchResults + PhoneSearchResults, UniqueID, UltID, OrgID, SeleID, ProxID, PowID),	UniqueID, UltID, OrgID, SeleID, ProxID, PowID);
	// Since we search for the input SeleID separately, drop any records that match the input SeleID to avoid duplicate searching.
	EXPORT Linked_BIPIDs := JOIN(Linked_BIPIDs_Unfiltered, BusinessInput, 
		LEFT.UniqueID = RIGHT.G_ProcBusUID AND 
		LEFT.UltID = RIGHT.B_LexIDUlt AND
		LEFT.OrgID = RIGHT.B_LexIDOrg AND 
		LEFT.SeleID = RIGHT.B_LexIDLegal,
			TRANSFORM(RECORDOF(LEFT), 
				SELF := LEFT), 
			LEFT ONLY);

END;	
