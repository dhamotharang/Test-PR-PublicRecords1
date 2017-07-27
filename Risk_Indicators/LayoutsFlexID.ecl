/*2016-05-21T00:43:24Z (Kevin Huls)
Automated reinstate from 2016-05-19T17:50:17Z
*/
export LayoutsFlexID := MODULE

// batch input, originally created for FlexID batch
export LayoutBatchInPlus := record
	risk_indicators.Layout_Batch_In;
	string6  Gender := '';
	string44 PassportUpperLine := '';
	string44 PassportLowerLine := '';
end;


// Batch Output
export LayoutNameAddressPhone := RECORD
	string2 NameAddressPhoneSummary := '';
	string1 NameAddressPhoneType := '';
	string1 NameAddressPhoneStatus := '';
END;


export LayoutVerifiedElementSummary := RECORD
	string1 VerifiedElementSummaryFirstName := '';
	string1 VerifiedElementSummaryLastName := '';
	string1 VerifiedElementSummaryStreetAddress := '';
	string1 VerifiedElementSummaryCity := '';
	string1 VerifiedElementSummaryState := '';
	string1 VerifiedElementSummaryZip := '';
	string1 VerifiedElementSummaryHomePhone := '';
	string1 VerifiedElementSummaryDOB := '';
	string1 VerifiedElementSummaryDOBMatchLevel := '';
	string1 VerifiedElementSummarySSN := '';
	string1 VerifiedElementSummaryDL := '';
END;


export LayoutValidElementSummary := RECORD
	string1 ValidElementSummarySSN;
	string1 ValidElementSummarySSNDeceased;
	string1 ValidElementSummaryDL;
	string1 ValidElementSummaryPassport;
	string1 ValidElementSummaryAddressPOBox;
	string1 ValidElementSummaryAddressCMRA;
END;


export LayoutCVI := RECORD
	string2 ComprehensiveVerificationIndex;
	string4 CVIRiskCode1;
	string100 CVIDescription1;
	string4 CVIRiskCode2;
	string100 CVIDescription2;
	string4 CVIRiskCode3;
	string100 CVIDescription3;
	string4 CVIRiskCode4;
	string100 CVIDescription4;
	string4 CVIRiskCode5;
	string100 CVIDescription5;
	string4 CVIRiskCode6;
	string100 CVIDescription6;
	string4 CVIRiskCode7;
	string100 CVIDescription7;
	string4 CVIRiskCode8;
	string100 CVIDescription8;
	string4 CVIRiskCode9;
	string100 CVIDescription9;
	string4 CVIRiskCode10;
	string100 CVIDescription10;
	string4 CVIRiskCode11;
	string100 CVIDescription11;
	string4 CVIRiskCode12;
	string100 CVIDescription12;
	string4 CVIRiskCode13;
	string100 CVIDescription13;
	string4 CVIRiskCode14;
	string100 CVIDescription14;
	string4 CVIRiskCode15;
	string100 CVIDescription15;
	string4 CVIRiskCode16;
	string100 CVIDescription16;
	string4 CVIRiskCode17;
	string100 CVIDescription17;
	string4 CVIRiskCode18;
	string100 CVIDescription18;
	string4 CVIRiskCode19;
	string100 CVIDescription19;
	string4 CVIRiskCode20;
	string100 CVIDescription20;
END;


export LayoutModel := RECORD
	string3 Score1;
	string4 ScoreRiskCode1;
	string100 ScoreDescription1;
	string4 ScoreRiskCode2;
	string100 ScoreDescription2;
	string4 ScoreRiskCode3;
	string100 ScoreDescription3;
	string4 ScoreRiskCode4;
	string100 ScoreDescription4;
	string4 ScoreRiskCode5;
	string100 ScoreDescription5;
	string4 ScoreRiskCode6;
	string100 ScoreDescription6;
END;


export LayoutFlexIDBatchOut := RECORD
	string10 seq;
	string30 acctno;
	LayoutNameAddressPhone;
	LayoutVerifiedElementSummary;
	LayoutValidElementSummary;
	string2 NameAddressSSNSummary;
	LayoutCVI;
	LayoutModel;
	string1 StolenIdentityIndex;
	string1 SyntheticIdentityIndex;
	string1 ManipulatedIdentityIndex;
	string1 VulnerableVictimIndex;
	string1 FriendlyFraudIndex;
	string1 SuspiciousActivityIndex;
	string12 UniqueID;
	string1 ValidElementSummarySSNFoundForLexID;
	string9 verSSN;
	string3 cviCustomScore;
	string1 InstantIDVersion;	// output the version that was run
	boolean EmergingID;
	string1 AddressSecondaryRangeMismatch;	// New for EmergingIdentities
END;

END;