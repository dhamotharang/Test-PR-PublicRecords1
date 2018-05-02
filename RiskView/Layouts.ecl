
IMPORT iesp, header, watercraft, BankruptcyV2, american_student_list, AlloyMedia_student_list,
				Prof_LicenseV2, Impulse_Email, iBehavior, risk_indicators;

EXPORT Layouts := module

export Layout_RiskViewLITE_in := RECORD
	STRING30  AcctNo;
	STRING12  LexID;
	STRING30  Name_First;
	STRING30  Name_Last;
	STRING9   SSN;
	UNSIGNED8 rawaid;
END;

export layout_riskview_attributes_5_slimList := record
 	string3	SubjectRecordTimeOldest	;
 	string3	SubjectRecordTimeNewest	;
 	string2	SubjectNewestRecord12Month	;
 	string2	SubjectActivityIndex03Month	;
 	string2	SubjectActivityIndex06Month	;
 	string2	SubjectActivityIndex12Month	;
 	string3	SubjectAge	;
 	string2	SubjectDeceased	;
 	string3	SubjectSSNCount	;
 	string2	SubjectStabilityIndex	;
 	string3	SubjectStabilityPrimaryFactor	;
 	string2	SubjectAbilityIndex	;
 	string3	SubjectAbilityPrimaryFactor	;
 	string2	SubjectWillingnessIndex	;
 	string3	SubjectWillingnessPrimaryFactor	;
 	string1	ConfirmationSubjectFound	;
 	string2	SourceNonDerogProfileIndex	;
 	string3	SourceNonDerogCount	;
 	string3	SourceNonDerogCount03Month	;
 	string3	SourceNonDerogCount06Month	;
 	string3	SourceNonDerogCount12Month	;
 	string3	SourceCredHeaderTimeOldest	;
 	string3	SourceCredHeaderTimeNewest	;
 	string2	SourceVoterRegistration	;
 	string2	EducationAttendance	;
 	string2	EducationEvidence	;
 	string2	EducationProgramAttended	;
 	string2	EducationInstitutionPrivate	;
 	string2	EducationInstitutionRating	;
 	string3	ProfLicCount	;
 	string2	ProfLicTypeCategory	;
 	string2	BusinessAssociation	;
 	string2	BusinessAssociationIndex	;
 	string3	BusinessAssociationTimeOldest	;
 	string2	BusinessTitleLeadership	;
 	string2	AssetIndex	;
 	string3	AssetIndexPrimaryFactor	;
 	string2	AssetOwnership	;
 	string2	AssetProp	;
 	string2	AssetPropIndex	;
 	string3	AssetPropEverCount	;
 	string3	AssetPropCurrentCount	;
 	string7	AssetPropCurrentTaxTotal	;
 	string3	AssetPropPurchaseCount12Month	;
 	string3	AssetPropPurchaseTimeOldest	;
 	string3	AssetPropPurchaseTimeNewest	;
	string2	AssetPropNewestMortgageType	;
	string3	AssetPropEverSoldCount	;
	string3	AssetPropSoldCount12Month	;
 	string3	AssetPropSaleTimeOldest	;
 	string3	AssetPropSaleTimeNewest	;
 	string7	AssetPropNewestSalePrice	;
 	string5	AssetPropSalePurchaseRatio	;
 	string2	AssetPersonal	;
 	string3	AssetPersonalCount	;
 	string2	PurchaseActivityIndex	;
 	string3	PurchaseActivityCount	;
 	string7	PurchaseActivityDollarTotal	;
 	string2	DerogSeverityIndex	;
 	string3	DerogCount	;
 	string3	DerogCount12Month	;
 	string3	DerogTimeNewest	;
 	string3	CriminalFelonyCount	;
 	string3	CriminalFelonyCount12Month	;
 	string2	CriminalFelonyTimeNewest	;
 	string3	CriminalNonFelonyCount	;
 	string3	CriminalNonFelonyCount12Month	;
 	string2	CriminalNonFelonyTimeNewest	;
 	string3	EvictionCount	;
 	string3	EvictionCount12Month	;
 	string2	EvictionTimeNewest	;
 	string2	LienJudgmentSeverityIndex	;
 	string3	LienJudgmentCount	;
 	string3	LienJudgmentCount12Month	;
 	string3	LienJudgmentSmallClaimsCount	;
 	string3	LienJudgmentCourtCount	;
 	string3	LienJudgmentTaxCount	;
 	string3	LienJudgmentForeclosureCount	;
 	string3	LienJudgmentOtherCount	;
 	string2	LienJudgmentTimeNewest	;
 	string7	LienJudgmentDollarTotal	;
 	string3	BankruptcyCount 	;
 	string3	BankruptcyCount24Month	;
 	string3	BankruptcyTimeNewest	;
 	string2	BankruptcyChapter	;
 	string2	BankruptcyStatus	;
 	string2	BankruptcyDismissed24Month	;
 	string2	ShortTermLoanRequest	;
 	string2	ShortTermLoanRequest12Month	;
 	string2	ShortTermLoanRequest24Month	;
 	string2	InquiryAuto12Month;
 	string2	InquiryBanking12Month;
 	string2	InquiryTelcom12Month;
 	string2	InquiryNonShortTerm12Month;
 	string2	InquiryShortTerm12Month;
 	string2	InquiryCollections12Month;
 	string3	AddrOnFileCount	;
 	string2	AddrOnFileCorrectional	;
 	string2	AddrOnFileCollege	;
 	string2	AddrOnFileHighRisk	;
 	string3	AddrCurrentTimeOldest	;
 	string3	AddrCurrentTimeNewest	;
	string3	AddrCurrentLengthOfRes 	;
 	string2	AddrCurrentSubjectOwned 	;
 	string2	AddrCurrentDeedMailing	;
 	string2	AddrCurrentOwnershipIndex	;
 	string2	AddrCurrentPhoneService	;
 	string2	AddrCurrentDwellType 	;
 	string2	AddrCurrentDwellTypeIndex	;
 	string3	AddrCurrentTimeLastSale	;
 	string7	AddrCurrentLastSalesPrice	;
 	string7	AddrCurrentTaxValue	;
 	string4	AddrCurrentTaxYr	;
 	string7	AddrCurrentTaxMarketValue	;
 	string7	AddrCurrentAVMValue	;
 	string7	AddrCurrentAVMValue12Month	;
 	string5	AddrCurrentAVMRatio12MonthPrior	;
 	string7	AddrCurrentAVMValue60Month	;
 	string5	AddrCurrentAVMRatio60MonthPrior	;
 	string5	AddrCurrentCountyRatio	;
 	string5	AddrCurrentTractRatio	;
 	string5	AddrCurrentBlockRatio	;
 	string2	AddrCurrentCorrectional	;
 	string3	AddrPreviousTimeOldest	;
 	string3	AddrPreviousTimeNewest	;
 	string3	AddrPreviousLengthOfRes 	;
 	string2	AddrPreviousSubjectOwned 	;
 	string2	AddrPreviousOwnershipIndex	;
 	string2	AddrPreviousDwellType 	;
 	string2	AddrPreviousDwellTypeIndex	;
 	string2	AddrPreviousCorrectional	;
 	string2	AddrStabilityIndex	;
 	string3	AddrChangeCount03Month	;
 	string3	AddrChangeCount06Month	;
 	string3	AddrChangeCount12Month	;
 	string3	AddrChangeCount24Month	;
 	string3	AddrChangeCount60Month	;
 	string5	AddrLastMoveTaxRatioDiff	;
 	string2	AddrLastMoveEconTrajectory	;
 	string2	AddrLastMoveEconTrajectoryIndex	;
 	string1	AlertRegulatoryCondition	;
end;

export layout_riskview5_alerts := record
	string4 Alert1;
	string4 Alert2;
	string4 Alert3;
	string4 Alert4;
	string4 Alert5;
	string4 Alert6;
	string4 Alert7;
	string4 Alert8;
	string4 Alert9;
	string4 Alert10;
	
	string2000 ConsumerStatementText;
end;

export layout_riskview5LITE_search_results := record
	unsigned4 seq;
	STRING30  AcctNo;
	string12  LexID;
	string3   Auto_Index;
	string30  Auto_Score_Name := '';
	string3   Auto_score;
	string3   Bankcard_Index;
	string30  BankCard_Score_Name := '';
	string3   Bankcard_score;
	string3   Short_term_lending_Index;
	string30  Short_term_lending_Score_Name := '';
	string3   Short_term_lending_score;
	string3   Telecommunications_Index;
	string30  Telecommunications_Score_Name := '';
	string3   Telecommunications_score;
	string3   Custom_Index;
	string30  Custom_Score_Name := '';
	string3   Custom_score;
	string3   Custom2_Index;
	string30  Custom2_Score_Name := '';
	string3   Custom2_score;
	string3   Custom3_Index;
	string30  Custom3_Score_Name := '';
	string3   Custom3_score;
	string3   Custom4_Index;
	string30  Custom4_Score_Name := '';
	string3   Custom4_score;
	string3   Custom5_Index;
	string30  Custom5_Score_Name := '';
	string3   Custom5_score;
	string3   Custom6_Index;
	string30  Custom6_Score_Name := '';
	string3   Custom6_score;
	string3   Custom7_Index;
	string30  Custom7_Score_Name := '';
	string3   Custom7_score;
	string3   Custom8_Index;
	string30  Custom8_Score_Name := '';
	string3   Custom8_score;
	string3   Custom9_Index;
	string30  Custom9_Score_Name := '';
	string3   Custom9_score;
	string3   Custom10_Index;
	string30  Custom10_Score_Name := '';
	string3   Custom10_score;
	string3   Custom11_Index;
	string30  Custom11_Score_Name := '';
	string3   Custom11_score;
	string3   Custom12_Index;
	string30  Custom12_Score_Name := '';
	string3   Custom12_score;
	string3   Custom13_Index;
	string30  Custom13_Score_Name := '';
	string3   Custom13_score;
	string3   Custom14_Index;
	string30  Custom14_Score_Name := '';
	string3   Custom14_score;
	string3   Custom15_Index;
	string30  Custom15_Score_Name := '';
	string3   Custom15_score;
	string3   Custom16_Index;
	string30  Custom16_Score_Name := '';
	string3   Custom16_score;
	string3   Custom17_Index;
	string30  Custom17_Score_Name := '';
	string3   Custom17_score;
	string3   Custom18_Index;
	string30  Custom18_Score_Name := '';
	string3   Custom18_score;
	string3   Custom19_Index;
	string30  Custom19_Score_Name := '';
	string3   Custom19_score;
	string3   Custom20_Index;
	string30  Custom20_Score_Name := '';
	string3   Custom20_score;
	string3   Custom21_Index;
	string30  Custom21_Score_Name := '';
	string3   Custom21_score;
	string3   Custom22_Index;
	string30  Custom22_Score_Name := '';
	string3   Custom22_score;
	string3   Custom23_Index;
	string30  Custom23_Score_Name := '';
	string3   Custom23_score;
	string3   Custom24_Index;
	string30  Custom24_Score_Name := '';
	string3   Custom24_score;
	string3   Custom25_Index;
	string30  Custom25_Score_Name := '';
	string3   Custom25_score;
	string3   Custom26_Index;
	string30  Custom26_Score_Name := '';
	string3   Custom26_score;
	string3   Custom27_Index;
	string30  Custom27_Score_Name := '';
	string3   Custom27_score;
	string3   Custom28_Index;
	string30  Custom28_Score_Name := '';
	string3   Custom28_score;
	string3   Custom29_Index;
	string30  Custom29_Score_Name := '';
	string3   Custom29_score;
	string3   Custom30_Index;
	string30  Custom30_Score_Name := '';
	string3   Custom30_score;
	string3   Custom31_Index;
	string30  Custom31_Score_Name := '';
	string3   Custom31_score;
	string3   Custom32_Index;
	string30  Custom32_Score_Name := '';
	string3   Custom32_score;
	string3   Custom33_Index;
	string30  Custom33_Score_Name := '';
	string3   Custom33_score;
	string3   Custom34_Index;
	string30  Custom34_Score_Name := '';
	string3   Custom34_score;
	string3   Custom35_Index;
	string30  Custom35_Score_Name := '';
	string3   Custom35_score;
	string3   Custom36_Index;
	string30  Custom36_Score_Name := '';
	string3   Custom36_score;
	string3   Custom37_Index;
	string30  Custom37_Score_Name := '';
	string3   Custom37_score;
	string3   Custom38_Index;
	string30  Custom38_Score_Name := '';
	string3   Custom38_score;
	string3   Custom39_Index;
	string30  Custom39_Score_Name := '';
	string3   Custom39_score;
	string3   Custom40_Index;
	string30  Custom40_Score_Name := '';
	string3   Custom40_score;
	string3   Custom41_Index;
	string30  Custom41_Score_Name := '';
	string3   Custom41_score;
	string3   Custom42_Index;
	string30  Custom42_Score_Name := '';
	string3   Custom42_score;
	string3   Custom43_Index;
	string30  Custom43_Score_Name := '';
	string3   Custom43_score;
	string3   Custom44_Index;
	string30  Custom44_Score_Name := '';
	string3   Custom44_score;
	string3   Custom45_Index;
	string30  Custom45_Score_Name := '';
	string3   Custom45_score;
	string3   Custom46_Index;
	string30  Custom46_Score_Name := '';
	string3   Custom46_score;
	string3   Custom47_Index;
	string30  Custom47_Score_Name := '';
	string3   Custom47_score;
	string3   Custom48_Index;
	string30  Custom48_Score_Name := '';
	string3   Custom48_score;
	string3   Custom49_Index;
	string30  Custom49_Score_Name := '';
	string3   Custom49_score;
	string3   Custom50_Index;
	string30  Custom50_Score_Name := '';
	string3   Custom50_score;
	string3   Custom51_Index;
	string30  Custom51_Score_Name := '';
	string3   Custom51_score;
	string3   Custom52_Index;
	string30  Custom52_Score_Name := '';
	string3   Custom52_score;
	string3   Custom53_Index;
	string30  Custom53_Score_Name := '';
	string3   Custom53_score;
	string3   Custom54_Index;
	string30  Custom54_Score_Name := '';
	string3   Custom54_score;
	string3   Custom55_Index;
	string30  Custom55_Score_Name := '';
	string3   Custom55_score;
	string3   Custom56_Index;
	string30  Custom56_Score_Name := '';
	string3   Custom56_score;
	string3   Custom57_Index;
	string30  Custom57_Score_Name := '';
	string3   Custom57_score;
	string3   Custom58_Index;
	string30  Custom58_Score_Name := '';
	string3   Custom58_score;
	string3   Custom59_Index;
	string30  Custom59_Score_Name := '';
	string3   Custom59_score;
	string3   Custom60_Index;
	string30  Custom60_Score_Name := '';
	string3   Custom60_score;
	string3   Custom61_Index;
	string30  Custom61_Score_Name := '';
	string3   Custom61_score;
	string3   Custom62_Index;
	string30  Custom62_Score_Name := '';
	string3   Custom62_score;
	string3   Custom63_Index;
	string30  Custom63_Score_Name := '';
	string3   Custom63_score;
	string3   Custom64_Index;
	string30  Custom64_Score_Name := '';
	string3   Custom64_score;
	string3   Custom65_Index;
	string30  Custom65_Score_Name := '';
	string3   Custom65_score;
	string3   Custom66_Index;
	string30  Custom66_Score_Name := '';
	string3   Custom66_score;
	string3   Custom67_Index;
	string30  Custom67_Score_Name := '';
	string3   Custom67_score;
	string3   Custom68_Index;
	string30  Custom68_Score_Name := '';
	string3   Custom68_score;
	string3   Custom69_Index;
	string30  Custom69_Score_Name := '';
	string3   Custom69_score;
	string3   Custom70_Index;
	string30  Custom70_Score_Name := '';
	string3   Custom70_score;
	string3   Custom71_Index;
	string30  Custom71_Score_Name := '';
	string3   Custom71_score;
	string3   Custom72_Index;
	string30  Custom72_Score_Name := '';
	string3   Custom72_score;
	string3   Custom73_Index;
	string30  Custom73_Score_Name := '';
	string3   Custom73_score;
	string3   Custom74_Index;
	string30  Custom74_Score_Name := '';
	string3   Custom74_score;
	string3   Custom75_Index;
	string30  Custom75_Score_Name := '';
	string3   Custom75_score;
	string3   Custom76_Index;
	string30  Custom76_Score_Name := '';
	string3   Custom76_score;
	string3   Custom77_Index;
	string30  Custom77_Score_Name := '';
	string3   Custom77_score;
	string3   Custom78_Index;
	string30  Custom78_Score_Name := '';
	string3   Custom78_score;
	string3   Custom79_Index;
	string30  Custom79_Score_Name := '';
	string3   Custom79_score;
	string3   Custom80_Index;
	string30  Custom80_Score_Name := '';
	string3   Custom80_score;
	string3   Custom81_Index;
	string30  Custom81_Score_Name := '';
	string3   Custom81_score;
	string3   Custom82_Index;
	string30  Custom82_Score_Name := '';
	string3   Custom82_score;
	string3   Custom83_Index;
	string30  Custom83_Score_Name := '';
	string3   Custom83_score;
	string3   Custom84_Index;
	string30  Custom84_Score_Name := '';
	string3   Custom84_score;
	string3   Custom85_Index;
	string30  Custom85_Score_Name := '';
	string3   Custom85_score;
	string3   Custom86_Index;
	string30  Custom86_Score_Name := '';
	string3   Custom86_score;
	string3   Custom87_Index;
	string30  Custom87_Score_Name := '';
	string3   Custom87_score;
	string3   Custom88_Index;
	string30  Custom88_Score_Name := '';
	string3   Custom88_score;
	string3   Custom89_Index;
	string30  Custom89_Score_Name := '';
	string3   Custom89_score;
	string3   Custom90_Index;
	string30  Custom90_Score_Name := '';
	string3   Custom90_score;
	string3   Custom91_Index;
	string30  Custom91_Score_Name := '';
	string3   Custom91_score;
	string3   Custom92_Index;
	string30  Custom92_Score_Name := '';
	string3   Custom92_score;
	string3   Custom93_Index;
	string30  Custom93_Score_Name := '';
	string3   Custom93_score;
	string3   Custom94_Index;
	string30  Custom94_Score_Name := '';
	string3   Custom94_score;
	string3   Custom95_Index;
	string30  Custom95_Score_Name := '';
	string3   Custom95_score;
	string3   Custom96_Index;
	string30  Custom96_Score_Name := '';
	string3   Custom96_score;
	string3   Custom97_Index;
	string30  Custom97_Score_Name := '';
	string3   Custom97_score;
	string3   Custom98_Index;
	string30  Custom98_Score_Name := '';
	string3   Custom98_score;
	string3   Custom99_Index;
	string30  Custom99_Score_Name := '';
	string3   Custom99_score;
	string3   Custom100_Index;
	string30  Custom100_Score_Name := '';
	string3   Custom100_score;
	layout_riskview_attributes_5_slimList;
  layout_riskview5_alerts;
end;

export Layout_Riskview_Batch_In := RECORD
	STRING30  AcctNo;
	string12  LexID;
	STRING9   SSN;
	STRING120 unParsedFullName;
	STRING30  Name_First;
	STRING30  Name_Middle;
	STRING30  Name_Last;
	STRING5   Name_Suffix;
	STRING8   DOB;
	STRING65 	street_addr;
	string10	Prim_Range;
	string2		Predir;
	string28	Prim_Name;
	string4		Suffix;
	string2		Postdir;
	string10	Unit_Desig;
	string8		Sec_Range;
	STRING25  p_City_name;
	STRING2   St;
	STRING5   Z5;
	string3		Age;
	STRING20  DL_Number;
	STRING2   DL_State;
	STRING10  Home_Phone;
	STRING10  Work_Phone;
	STRING50  Email;
	STRING45  ip_addr;
	string20 HistoryDateTimeStamp;
	string64 custom_input1 := '';
	string64 custom_input2 := '';
	string64 custom_input3 := '';
	string64 custom_input4 := '';
	string64 custom_input5 := '';
	string64 custom_input6 := '';
	string64 custom_input7 := '';
	string64 custom_input8 := '';
	string64 custom_input9 := '';
	string64 custom_input10 := '';
	string64 custom_input11 := '';
	string64 custom_input12 := '';
	string64 custom_input13 := '';
	string64 custom_input14 := '';
	string64 custom_input15 := '';
	string64 custom_input16 := '';
	string64 custom_input17 := '';
	string64 custom_input18 := '';
	string64 custom_input19 := '';
	string64 custom_input20 := '';
	string64 custom_input21 := '';
	string64 custom_input22 := '';
	string64 custom_input23 := '';
	string64 custom_input24 := '';
	string64 custom_input25 := '';
END;

export Layout_Custom_Inputs := RECORD
	UNSIGNED Seq;
	DATASET(iesp.riskview_share.t_ModelOptionRV) Custom_Inputs;
END;

export layout_riskview_input := record
	Layout_Custom_Inputs;
	Layout_Riskview_Batch_In;
end;

export layout_riskview_attributes_5 := record
	string3 Attribute_Index  := '0'; // for now, only 0 is valid attribute index, in the future we can default this.
	string1	InputProvidedFirstName	;
	string1	InputProvidedLastName	;
	string1	InputProvidedStreetAddress	;
	string1	InputProvidedCity	;
	string1	InputProvidedState	;
	string1	InputProvidedZipCode	;
	string1	InputProvidedSSN	;
	string1	InputProvidedDateofBirth	;
	string1	InputProvidedPhone	;
	string1	InputProvidedLexID	;
	string3	SubjectRecordTimeOldest	;
	string3	SubjectRecordTimeNewest	;
	string2	SubjectNewestRecord12Month	;
	string2	SubjectActivityIndex03Month	;
	string2	SubjectActivityIndex06Month	;
	string2	SubjectActivityIndex12Month	;
	string3	SubjectAge	;
	string2	SubjectDeceased	;
	string3	SubjectSSNCount	;
	string2	SubjectStabilityIndex	;
	string3	SubjectStabilityPrimaryFactor	;
	string2	SubjectAbilityIndex	;
	string3	SubjectAbilityPrimaryFactor	;
	string2	SubjectWillingnessIndex	;
	string3	SubjectWillingnessPrimaryFactor	;
	string1	ConfirmationSubjectFound	;
	string2	ConfirmationInputName	;
	string2	ConfirmationInputDOB	;
	string2	ConfirmationInputSSN	;
	string2	ConfirmationInputAddress	;
	string2	SourceNonDerogProfileIndex	;
	string3	SourceNonDerogCount	;
	string3	SourceNonDerogCount03Month	;
	string3	SourceNonDerogCount06Month	;
	string3	SourceNonDerogCount12Month	;
	string3	SourceCredHeaderTimeOldest	;
	string3	SourceCredHeaderTimeNewest	;
	string2	SourceVoterRegistration	;
	string2	EducationAttendance	;
	string2	EducationEvidence	;
	string2	EducationProgramAttended	;
	string2	EducationInstitutionPrivate	;
	string2	EducationInstitutionRating	;
	string3	ProfLicCount	;
	string2	ProfLicTypeCategory	;
	string2	BusinessAssociation	;
	string2	BusinessAssociationIndex	;
	string3	BusinessAssociationTimeOldest	;
	string2	BusinessTitleLeadership	;
	string2	AssetIndex	;
	string3	AssetIndexPrimaryFactor	;
	string2	AssetOwnership	;
	string2	AssetProp	;
	string2	AssetPropIndex	;
	string3	AssetPropEverCount	;
	string3	AssetPropCurrentCount	;
	string7	AssetPropCurrentTaxTotal	;
	string3	AssetPropPurchaseCount12Month	;
	string3	AssetPropPurchaseTimeOldest	;
	string3	AssetPropPurchaseTimeNewest	;
	string2	AssetPropNewestMortgageType	;
	string3	AssetPropEverSoldCount	;
	string3	AssetPropSoldCount12Month	;
	string3	AssetPropSaleTimeOldest	;
	string3	AssetPropSaleTimeNewest	;
	string7	AssetPropNewestSalePrice	;
	string5	AssetPropSalePurchaseRatio	;
	string2	AssetPersonal	;
	string3	AssetPersonalCount	;
	string2	PurchaseActivityIndex	;
	string3	PurchaseActivityCount	;
	string7	PurchaseActivityDollarTotal	;
	string2	DerogSeverityIndex	;
	string3	DerogCount	;
	string3	DerogCount12Month	;
	string3	DerogTimeNewest	;
	string3	CriminalFelonyCount	;
	string3	CriminalFelonyCount12Month	;
	string2	CriminalFelonyTimeNewest	;
	string3	CriminalNonFelonyCount	;
	string3	CriminalNonFelonyCount12Month	;
	string2	CriminalNonFelonyTimeNewest	;
	string3	EvictionCount	;
	string3	EvictionCount12Month	;
	string2	EvictionTimeNewest	;
	string2	LienJudgmentSeverityIndex	;
	string3	LienJudgmentCount	;
	string3	LienJudgmentCount12Month	;
	string3	LienJudgmentSmallClaimsCount	;
	string3	LienJudgmentCourtCount	;
	string3	LienJudgmentTaxCount	;
	string3	LienJudgmentForeclosureCount	;
	string3	LienJudgmentOtherCount	;
	string2	LienJudgmentTimeNewest	;
	string7	LienJudgmentDollarTotal	;
	string3	BankruptcyCount 	;
	string3	BankruptcyCount24Month	;
	string3	BankruptcyTimeNewest	;
	string2	BankruptcyChapter	;
	string2	BankruptcyStatus	;
	string2	BankruptcyDismissed24Month	;
	string2	ShortTermLoanRequest	;
	string2	ShortTermLoanRequest12Month	;
	string2	ShortTermLoanRequest24Month	;
	string2	InquiryAuto12Month;
	string2	InquiryBanking12Month;
	string2	InquiryTelcom12Month;
	string2	InquiryNonShortTerm12Month;
	string2	InquiryShortTerm12Month;
	string2	InquiryCollections12Month;
	string3	SSNSubjectCount	;
	string2	SSNDeceased	;
	string8	SSNDateLowIssued	;
	string2	SSNProblems	;
	string3	AddrOnFileCount	;
	string2	AddrOnFileCorrectional	;
	string2	AddrOnFileCollege	;
	string2	AddrOnFileHighRisk	;
	string3	AddrInputTimeOldest	;
	string3	AddrInputTimeNewest	;
	string3	AddrInputLengthOfRes	;
	string3	AddrInputSubjectCount	;
	string2	AddrInputMatchIndex	;
	string2	AddrInputSubjectOwned	;
	string2	AddrInputDeedMailing	;
	string2	AddrInputOwnershipIndex	;
	string2	AddrInputPhoneService	;
	string3	AddrInputPhoneCount	;
	string2	AddrInputDwellType	;
	string2	AddrInputDwellTypeIndex	;
	string2	AddrInputDelivery	;
	string3	AddrInputTimeLastSale	;
	string7	AddrInputLastSalePrice	;
	string7	AddrInputTaxValue	;
	string4	AddrInputTaxYr	;
	string7	AddrInputTaxMarketValue	;
	string7	AddrInputAVMValue	;
	string7	AddrInputAVMValue12Month	;
	string5	AddrInputAVMRatio12MonthPrior	;
	string7	AddrInputAVMValue60Month	;
	string5	AddrInputAVMRatio60MonthPrior	;
	string5	AddrInputCountyRatio	;
	string5	AddrInputTractRatio	;
	string5	AddrInputBlockRatio	;
	string2	AddrInputProblems	;
	string3	AddrCurrentTimeOldest	;
	string3	AddrCurrentTimeNewest	;
	string3	AddrCurrentLengthOfRes 	;
	string2	AddrCurrentSubjectOwned 	;
	string2	AddrCurrentDeedMailing	;
	string2	AddrCurrentOwnershipIndex	;
	string2	AddrCurrentPhoneService	;
	string2	AddrCurrentDwellType 	;
	string2	AddrCurrentDwellTypeIndex	;
	string3	AddrCurrentTimeLastSale	;
	string7	AddrCurrentLastSalesPrice	;
	string7	AddrCurrentTaxValue	;
	string4	AddrCurrentTaxYr	;
	string7	AddrCurrentTaxMarketValue	;
	string7	AddrCurrentAVMValue	;
	string7	AddrCurrentAVMValue12Month	;
	string5	AddrCurrentAVMRatio12MonthPrior	;
	string7	AddrCurrentAVMValue60Month	;
	string5	AddrCurrentAVMRatio60MonthPrior	;
	string5	AddrCurrentCountyRatio	;
	string5	AddrCurrentTractRatio	;
	string5	AddrCurrentBlockRatio	;
	string2	AddrCurrentCorrectional	;
	string3	AddrPreviousTimeOldest	;
	string3	AddrPreviousTimeNewest	;
	string3	AddrPreviousLengthOfRes 	;
	string2	AddrPreviousSubjectOwned 	;
	string2	AddrPreviousOwnershipIndex	;
	string2	AddrPreviousDwellType 	;
	string2	AddrPreviousDwellTypeIndex	;
	string2	AddrPreviousCorrectional	;
	string2	AddrStabilityIndex	;
	string3	AddrChangeCount03Month	;
	string3	AddrChangeCount06Month	;
	string3	AddrChangeCount12Month	;
	string3	AddrChangeCount24Month	;
	string3	AddrChangeCount60Month	;
	string5	AddrLastMoveTaxRatioDiff	;
	string2	AddrLastMoveEconTrajectory	;
	string2	AddrLastMoveEconTrajectoryIndex	;
	string2	PhoneInputProblems	;
	string3	PhoneInputSubjectCount	;
	string2	PhoneInputMobile 	;
	string1	AlertRegulatoryCondition	;
	Risk_Indicators.Layouts_Derog_Info.LNR_AttrIbutes;
end;

//FCRA List Gen - Will use a slim version
export layout_riskview5 := record
	string12  LexID;
	
	string3 Auto_Index;
	string30 Auto_Score_Name := '';
	string3 Auto_score;
	string3 Auto_reason1;
	string3 Auto_reason2;
	string3 Auto_reason3;
	string3 Auto_reason4;
	string3 Auto_reason5;
	
	string3 Bankcard_Index;
	string30 BankCard_Score_Name := '';
	string3 Bankcard_score;
	string3 Bankcard_reason1;
	string3 Bankcard_reason2;
	string3 Bankcard_reason3;
	string3 Bankcard_reason4;
	string3 Bankcard_reason5;
	
	string3 Short_term_lending_Index;
	string30 Short_term_lending_Score_Name := '';
	string3 Short_term_lending_score;
	string3 Short_term_lending_reason1;
	string3 Short_term_lending_reason2;
	string3 Short_term_lending_reason3;
	string3 Short_term_lending_reason4;
	string3 Short_term_lending_reason5;
	
	string3 Telecommunications_Index;
	string30 Telecommunications_Score_Name := '';
	string3 Telecommunications_score;
	string3 Telecommunications_reason1;
	string3 Telecommunications_reason2;
	string3 Telecommunications_reason3;
	string3 Telecommunications_reason4;
	string3 Telecommunications_reason5;
	
	string3 Crossindustry_Index;
	string30 Crossindustry_Score_Name := '';
	string3 Crossindustry_score;
	string3 Crossindustry_reason1;
	string3 Crossindustry_reason2;
	string3 Crossindustry_reason3;
	string3 Crossindustry_reason4;
	string3 Crossindustry_reason5;
	
	string3 Custom_Index;
	string30 Custom_Score_Name := '';
	string3 Custom_score;
	string3 Custom_reason1;
	string3 Custom_reason2;
	string3 Custom_reason3;
	string3 Custom_reason4;
	string3 Custom_reason5;
	
	string3 Custom2_Index;
	string30 Custom2_Score_Name := '';
	string3 Custom2_score;
	string3 Custom2_reason1;
	string3 Custom2_reason2;
	string3 Custom2_reason3;
	string3 Custom2_reason4;
	string3 Custom2_reason5;

	string3 Custom3_Index;
	string30 Custom3_Score_Name := '';
	string3 Custom3_score;
	string3 Custom3_reason1;
	string3 Custom3_reason2;
	string3 Custom3_reason3;
	string3 Custom3_reason4;
	string3 Custom3_reason5;

	string3 Custom4_Index;
	string30 Custom4_Score_Name := '';
	string3 Custom4_score;
	string3 Custom4_reason1;
	string3 Custom4_reason2;
	string3 Custom4_reason3;
	string3 Custom4_reason4;
	string3 Custom4_reason5;

	string3 Custom5_Index;
	string30 Custom5_Score_Name := '';
	string3 Custom5_score;
	string3 Custom5_reason1;
	string3 Custom5_reason2;
	string3 Custom5_reason3;
	string3 Custom5_reason4;
	string3 Custom5_reason5;
	
	layout_riskview_attributes_5;
	
	string4 Alert1;
	string4 Alert2;
	string4 Alert3;
	string4 Alert4;
	string4 Alert5;
	string4 Alert6;
	string4 Alert7;
	string4 Alert8;
	string4 Alert9;
	string4 Alert10;
	
	string2000 ConsumerStatementText;
end;

//FCRA List Gen - Will use a slim version
export layout_riskview5_search_results := record
	unsigned4 seq;
	layout_riskview5;
	string10 Auto_Type := '';
	string10 BankCard_Type := '';
	string10 Short_term_lending_Type := '';
	string10 Telecommunications_Type := '';
	string10 Crossindustry_Type := '';
	string10 Custom_Type := '';	
	string10 Custom2_Type := '';	
	string10 Custom3_Type := '';	
	string10 Custom4_Type := '';	
	string10 Custom5_Type := '';
	iesp.riskview2.t_RiskView2Report report;
  string5  Exception_code := '';
	dataset(iesp.share_fcra.t_ConsumerStatement) ConsumerStatements {xpath('ConsumerStatements/ConsumerStatement'), MAXCOUNT(iesp.Constants.MAX_CONSUMER_STATEMENTS)};
	string3	 Billing_Index2 := '';
	Risk_Indicators.Layouts_Derog_Info.LJ_Records;
end;


//Liens for layout - define up to 99
		#DECLARE(Liens);
		#DECLARE(cntLiens);
		
		#SET(Liens,'');
		#SET(cntLiens,1);
		
		#LOOP
			#IF(%cntLiens% > iesp.constants.RiskView_2.MaxPublicReportCount)
				#BREAK;
			#ELSE
				#APPEND(Liens,
							'string30 Liens' + %'cntLiens'% + '_Seq;' +
							'STRING8 Liens' + %'cntLiens'% + '_DateFiled;' +
							'string50 Liens' + %'cntLiens'% + '_LienType;' +
							'string15 Liens' + %'cntLiens'% + '_Amount;'+ 
							'STRING8 Liens' + %'cntLiens'% + '_ReleaseDate;' +
							'STRING8 Liens' + %'cntLiens'% + '_DateLastSeen;' +
							'string20 Liens' + %'cntLiens'% + '_FilingNumber;'+ 
							'string10 Liens' + %'cntLiens'% + '_FilingBook;'+ 
							'STRING10 Liens' + %'cntLiens'% + '_FilingPage;' +
							'STRING60 Liens' + %'cntLiens'% + '_Agency;' +
							'string35 Liens' + %'cntLiens'% + '_AgencyCounty;' +
							'string2 Liens' + %'cntLiens'% + '_AgencyState;' +
							'string25 Liens' + %'cntLiens'% + '_ConsumerStatementId;');										
								
				#SET(cntLiens,%cntLiens% + 1)
			#END
		#END		
//Judgments for layout - define up to 99
		#DECLARE(Jgmts);
		#DECLARE(cntJgmts);
		
		#SET(Jgmts,'');
		#SET(cntJgmts,1);
		
		#LOOP
			#IF(%cntJgmts% > iesp.constants.RiskView_2.MaxPublicReportCount)
			
				#BREAK;
			#ELSE
				#APPEND(Jgmts,
						'string30 Jgmts' + %'cntJgmts'% + '_Seq;' +
						'STRING8 Jgmts' + %'cntJgmts'% + '_DateFiled;' +
						'string50 Jgmts' + %'cntJgmts'% + '_JudgmentType;' +
						'string15 Jgmts' + %'cntJgmts'% + '_Amount;'+ 
						'STRING8 Jgmts' + %'cntJgmts'% + '_ReleaseDate;' +
						'string16 Jgmts' + %'cntJgmts'% + '_FilingDescription;' +
						'STRING8 Jgmts' + %'cntJgmts'% + '_DateLastSeen;' +
						'string120 Jgmts' + %'cntJgmts'% + '_Defendant;' +
						'string120 Jgmts' + %'cntJgmts'% + '_Plaintiff;' +
						'string20 Jgmts' + %'cntJgmts'% + '_FilingNumber;'+ 
						'string10 Jgmts' + %'cntJgmts'% + '_FilingBook;'+ 
						'STRING10 Jgmts' + %'cntJgmts'% + '_FilingPage;' +
						'STRING1 Jgmts' + %'cntJgmts'% + '_Eviction;' +
						'STRING60 Jgmts' + %'cntJgmts'% + '_Agency;' +
						'string35 Jgmts' + %'cntJgmts'% + '_AgencyCounty;' +
						'string2 Jgmts' + %'cntJgmts'% + '_AgencyState;' +
						'string25 Jgmts' + %'cntJgmts'% + '_ConsumerStatementId;');											
				#SET(cntJgmts,%cntJgmts% + 1)
			#END
		#END

export layout_riskview_lnj_batch := record
	%Liens%
	%Jgmts%
end;


export layout_riskview5_batch_response := record
	string30 acctno;
	layout_riskview5;
  string5  Exception_code := '';
	string3	 Billing_Index2 := '';
	layout_riskview_lnj_batch;
	
end;

export attributes_internal_layout := record
	string30 AccountNumber;
	unsigned seq;
	unsigned did;
	layout_riskview_attributes_5;
	Risk_Indicators.Layouts_Derog_Info.LJ_Attributes;
	Risk_Indicators.Layouts_Derog_Info.LJ_DataSets;
end;

export attributes_internal_layout_noscore := record
	attributes_internal_layout;
	boolean no_score;
end;

export shell_NoScore := record
	risk_indicators.Layout_Boca_Shell;
	boolean no_score;
end;

export Model_Constants := RECORD
	STRING15 Model_Name := '';  // EX: 'RVA1403_0'
	STRING30 Output_Model_Name := ''; // EX: 'AutoRVA1403_0'
	UNSIGNED2 Billing_Index := 0; // EX: 1
	STRING10 Model_Type := ''; // EX: '0-999'
	UNSIGNED2 Billing_Index2 := 0; // This added specifically for MLA1608_0 which needs 2 billing indexes
END;


export addrhist_layout := RECORD
		integer seq;
		integer groupid; // assign unique number to each unique address. 
		integer historydate;
		string12 ln_fares_id := '';				
		header.layout_header;
		string8  assessmentdate := '';
		string11 assessmentprice := '';
		string32 AddrCharacteristics := '';
		string5 vendor_source_flag:='';
		string4 standardized_land_use_code := '';
		string120 land_use := '';
END;
export	layoutOfwatercraf_info := record
	watercraft.key_watercraft_wid (true);
	watercraft.key_watercraft_sid (true);
end;

export layout_bkr_search_temp := RECORD
	BankruptcyV2.layout_bankruptcy_search_v3;
	boolean inputIsDebtor;
END;

export layout_bkr_search := RECORD
	BankruptcyV2.layout_bankruptcy_search_v3;
END;

export layout_bankruptcy := record
	bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing;
end;

export Layout_AmStudent := record
	american_student_list.key_DID_FCRA;
	string college_major_exploded := '';
	string type_exploded := '';
	string code_exploded := '';
end;

export Layout_Alloy := record
	AlloyMedia_student_list.Key_DID_FCRA;
	string college_major_exploded := '';
	string type_exploded := '';
	string code_exploded := '';
end;

export layout_proflic := record
	Prof_LicenseV2.Key_Proflic_Did (true);
end;

export Layout_impulse := record
	Impulse_Email.Key_Impulse_DID_FCRA;
end;

export Layout_iBehavior := record
	risk_indicators.layout_bocashell_neutral;
	iBehavior.layout_consumer_search iConsumer;
	string10  ib_individual_id;
	string8   date_first_seen;	// from behavior key for keeping newest record, not consumer date (which are stored for output in ibehavior section)
	string8   date_last_seen;		// from behavior key for keeping newest record, not consumer date (which are stored for output in ibehavior section)
end;

//For RV5capOneBatch, I'm doing this join to model results slightly differently than in the Core RiskView batch product.
export layout_RV5capOneBatch_modelResults := record
	unsigned4 seq;
	string30  BankCard_Score_Name := '';
	string3   Bankcard_score;
	string3   Bankcard_reason1;
	string3   Bankcard_reason2;
	string3   Bankcard_reason3;
	string3   Bankcard_reason4;
	string3   Bankcard_reason5;
end;

export layout_RV5capOneBatch_searchResults := record
	unsigned4 seq;//Only used for joining back to input for acctNo maping to results, not included in product output.
	string30  AcctNo;
	string12  LexID;
	layout_RV5capOneBatch_modelResults-seq;  //Seq was used in the service to join the model results back to attribute results.
	layout_riskview_attributes_5 -Risk_Indicators.Layouts_Derog_Info.LNR_AttrIbutes; //CapOne is not running Juli so remove from output
  layout_riskview5_alerts-ConsumerStatementText;
end;

end;
