IMPORT BIPV2, doxie, Residency_Services, STD, ut;

EXPORT fn_getBIP(DATASET(Residency_Services.Layouts.IntermediateData) Batch_In) := FUNCTION

	// NOTE: should already only be 1 did per acctno; the did first obtained in fn_getBestInfo.
	//       But just to be safe sort by acctno and descending did (to put any non-zero ones first).
	ded_acct_did := DEDUP(SORT(Batch_In, acctno, -did), acctno); 
		
	BIP_In := PROJECT(Batch_In,TRANSFORM(BIPV2.IDfunctions.rec_SearchInput,
																			SELF.acctno      := (STRING) LEFT.acctno,
																			SELF.contact_ssn := LEFT.ssn,
																			SELF.contact_did := LEFT.did;
																			SELF := []));

	dsBusiness := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(BIP_In).SELEBest;	

  // Revise to use linkids back from above to get BIP contact key recs for the dids(ssns?)
	// then get county/st from there (NOT ON THAT KEY)  DISCUSS WITH DON???????????
	// AND/OR change above to fro those dids/ssns in the BIP data, get their "best"/current
	// address st county from ????????????????


	TodaysDate := Residency_Services.Constants.TodaysDate;

	dsBusiness_fltrd := dsBusiness((ut.DaysApart((STRING8)dt_last_seen, TodaysDate)
	                                < Residency_Services.Constants.Days_in_Year));
	
	dsBIPwDID := JOIN(dsBusiness_fltrd,ded_acct_did,
									    LEFT.acctno = RIGHT.acctno, 
									  TRANSFORM(Residency_Services.Layouts.Int_Service_output,
										  SELF.acctno       := RIGHT.acctno,
											SELF.did          := RIGHT.did,
											SELF.expired_flag := 'N',
											SELF.county_name  := LEFT.county_name,
											SELF.st           := LEFT.st
									 ));
	
	// output(dsBussiness,named('dsBussiness')); 
	// output(dsBussiness_fltrd,named('dsBussiness_fltrd')); 
	
	RETURN dsBIPwDID;
	
END;