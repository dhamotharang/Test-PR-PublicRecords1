IMPORT Autokey_batch;

EXPORT layouts_batch := MODULE	

	EXPORT Batch_in := RECORD,MAXLENGTH(40000)
		Autokey_batch.Layouts.rec_inBatchMaster  -ssn -dob -homephone -dl -dlstate -vin -Plate 
																						 -PlateState -searchType -max_results -score 
																						 -MatchCode -date -sic_code -filing_number -apn
																						 -fips_code -score_bdid;																																									
	END;
	
	EXPORT Batch_out := RECORD,MAXLENGTH(40000)
		  STRING20	acctno := '';
			UNSIGNED8 Date_FirstSeen;
			UNSIGNED8 Date_LastSeen;
			UNSIGNED6 bdid 	:= 0;
			STRING15	RMID;
			STRING205	Business_Name;
			STRING205	Business_DBA_Name;
			STRING205 Business_Owner_First_Name;         
			STRING1		Business_Owner_Middle_Name;
			STRING30	Business_Owner_Last_Name;
			STRING10	Business_Owner_Suffix_Name;
			STRING205	Contact_Business_Name;
			STRING205 Contact_First_Name;  
			STRING1		Contact_Middle_Name;
			STRING30	Contact_Last_Name;
			STRING10	Contact_Suffix_Name;
			STRING10	Business_addr_prim_range; 
			STRING2		Business_addr_predir;	
			STRING28	Business_addr_prim_name;	
			STRING4		Business_addr_addr_suffix; 
			STRING2		Business_addr_postdir;	
			STRING10	Business_addr_unit_desig;	
			STRING8		Business_addr_sec_range;	
			STRING25	Business_addr_p_city_name;	
			STRING25	Business_addr_v_city_name; 
			STRING2		Business_addr_st;	
			STRING5		Business_addr_zip;
      // Begin Workers Comp fields
			STRING5   WorkersCompIns := 'FALSE';
			STRING15  Workers_Comp_classCode; 
			STRING5	  Workers_Comp_Effective_Month_Day;
			STRING2	  Workers_Comp_EffectiveMonth;
			STRING8	  Workers_Comp_Effective_Date;
			STRING100	Workers_Comp_NAICCarrierName;
			STRING15	Workers_Comp_NAICCarrierNumber;
			STRING100	Workers_Comp_NAICGroupName;
			STRING15	Workers_Comp_NAICGroupNumber;
			STRING30	Workers_Comp_FEIN;
			STRING30	Workers_Comp_PolicySelf;
			STRING2		Workers_Comp_insured_status;
      // End Workers Comp fields
			// Begin Self Insurance Fields
			STRING5   SelfInsurance := 'FALSE';
			STRING15	DartID;
			UNSIGNED8 DateAdded;
			UNSIGNED8 DateUpdated;
			STRING80	Website;
			STRING2		State;
			UNSIGNED8	LNInsCertRecordID;
			STRING8		ProfileLastUpdated;
			STRING10	SIID;
			STRING15	SIPStatusCode;
			STRING15	WCBEmpNumber;
			STRING15	UBINumber;
			STRING25	CofANumber;
			STRING15	USDOTNumber;
			STRING205	DBA;
			STRING15	Phone1;
			STRING15	Phone2;
			STRING15	Phone3;
			STRING15	Fax1;
			STRING15	Fax2;
			STRING50	Email1;
			STRING50	Email2;
			STRING40	BusinessType;
			STRING15	ContactPhone;
			STRING15	ContactFax;
			STRING50	ContactEmail;
			STRING20	PolicyHolderNameFirst;
			STRING1		PolicyHolderNameMiddle;
			STRING30	PolicyHolderNameLast;
			STRING10	PolicyHolderNameSuffix;
			STRING30	StatePolicyFileNumber;
			STRING8		CoverageInjuryIllnessDate;
			STRING80	SelfInsuranceGroup;
			STRING15	SelfInsuranceGroupPhone;
			STRING25	SelfInsuranceGroupID;
			STRING60	NumberofEmployees;
			STRING10	LicensedContractor;
			STRING50	MCOName;
			STRING10	MCONumber;
			STRING75	MCOAddressLine1;
			STRING75	MCOAddressLine2;
			STRING50	MCOCity;
			STRING2		MCOState;
			STRING5		MCOZip;
			STRING4		MCOZip4;
			STRING15 	MCOPhone;
			STRING8		GoverningClassCode;
			STRING8		LicenseNumber;
			STRING8		Class;
			STRING8		ClassificationDescription;
			STRING8		LicenseStatus;
			STRING8		LicenseAdditionalInfo;
			STRING8		LicenseIssueDate;
			STRING8		LicenseExpirationDate;
			STRING8		NAICSCode;
			STRING8		OfficerExemptFirstName1;
			STRING8		OfficerExemptLastName1;
			STRING8		OfficerExemptMiddleName1;
			STRING8		OfficerExemptTitle1;
			STRING8		OfficerExemptEffectiveDate1;
			STRING8		OfficerExemptTerminationDate1;
			STRING8		OfficerExemptType1;
			STRING8		OfficerExemptBusinessActivities1;
			STRING8		OfficerExemptFirstName2;
			STRING8		OfficerExemptLastName2;
			STRING8		OfficerExemptMiddleName2;
			STRING8		OfficerExemptTitle2;
			STRING8		OfficerExemptEffectiveDate2;
			STRING8 	OfficerExemptTerminationDate2;
			STRING8		OfficerExemptType2;
			STRING8		OfficerExemptBusinessActivities2;
			STRING8		OfficerExemptFirstName3;
			STRING8		OfficerExemptLastName3;
			STRING8		OfficerExemptMiddleName3;
			STRING8		OfficerExemptTitle3;
			STRING8		OfficerExemptEffectiveDate3;
			STRING8		OfficerExemptTerminationDate3;
			STRING8		OfficerExemptType3;
			STRING8		OfficerExemptBusinessActivities3;
			STRING8		OfficerExemptFirstName4;
			STRING8		OfficerExemptLastName4;
			STRING8		OfficerExemptMiddleName4;
			STRING8		OfficerExemptTitle4;
			STRING8		OfficerExemptEffectiveDate4;
			STRING8		OfficerExemptTerminationDate4;
			STRING8		OfficerExemptType4;
			STRING8		OfficerExemptBusinessActivities4;
			STRING8		OfficerExemptFirstName5;
			STRING8		OfficerExemptLastName5;
			STRING8		OfficerExemptMiddleName5;
			STRING8		OfficerExemptTitle5;
			STRING8		OfficerExemptEffectiveDate5;
			STRING8		OfficerExemptTerminationDate5;
			STRING8		OfficerExemptType5;
			STRING8		OfficerExemptBusinessActivities5;
			STRING8		DBA1;
			STRING8		DBADateFrom1;
			STRING8		DBADateTo1;
			STRING8		DBAType1;
			STRING8		DBA2;
			STRING8		DBADateFrom2;
			STRING8		DBADateTo2;
			STRING8		DBAType2;
			STRING8		DBA3;
			STRING8		DBADateFrom3;
			STRING8		DBADateTo3;
			STRING8		DBAType3;
			STRING8		DBA4;
			STRING8		DBADateFrom4;
			STRING8		DBADateTo4;
			STRING8		DBAType4;
			STRING8		DBA5;
			STRING8		DBADateFrom5;
			STRING8		DBADateTo5;
			STRING8		DBAType5;
			STRING50 	SubsidiaryName1;
			STRING8		SubsidiaryStartDate1;
			STRING50	SubsidiaryName2;
			STRING8		SubsidiaryStartDate2;
			STRING50	SubsidiaryName3;
			STRING8		SubsidiaryStartDate3;
			STRING50	SubsidiaryName4;
			STRING8		SubsidiaryStartDate4;
			STRING50	SubsidiaryName5;
			STRING8		SubsidiaryStartDate5;
			STRING50	SubsidiaryName6;
			STRING8		SubsidiaryStartDate6;
			STRING50	SubsidiaryName7;
			STRING8		SubsidiaryStartDate7;
			STRING50	SubsidiaryName8;
			STRING8		SubsidiaryStartDate8;
			STRING50	SubsidiaryName9;
			STRING8		SubsidiaryStartDate9;
			STRING50	SubsidiaryName10;
			STRING8		SubsidiaryStartDate10;
		  STRING15	Policy_DartID;
			STRING60	Policy_InsuranceProvider;
			STRING35	Policy_PolicyNumber;
			STRING8		Policy_CoverageStartDate;
			STRING8		Policy_CoverageExpirationDate;
			STRING8 	Policy_CoverageWrapUP;
			STRING90	Policy_PolicyStatus;
			STRING25	Policy_InsuranceProviderPhone;
			STRING25	Policy_InsuranceProviderFax;
			STRING8		Policy_CoverageReinstateDate;
			STRING8		Policy_CoverageCancellationDate;
			STRING50	Policy_InsuranceProviderContactDept;
			STRING20	Policy_InsuranceType;
			STRING8		Policy_CoveragePostedDate;
			STRING20	Policy_CoverageAmountFrom;
			STRING20	Policy_CoverageAmountTo;
			STRING10	Policy_addr_prim_range; 
			STRING2		Policy_addr_predir;	
			STRING28	Policy_addr_prim_name;	
			STRING4		Policy_addr_addr_suffix; 
			STRING2		Policy_addr_postdir;	
			STRING10	Policy_addr_unit_desig;	
			STRING8		Policy_addr_sec_range;	
			STRING25	Policy_addr_p_city_name;	
			STRING25	Policy_addr_v_city_name; 
			STRING2		Policy_addr_st;	
			STRING5		Policy_addr_zip;
			// End Self Insurance Fields
	END;
	
END;