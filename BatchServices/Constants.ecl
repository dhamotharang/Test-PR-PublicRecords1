import ut, MDR, std;

EXPORT Constants := MODULE
	
	EXPORT PROPERTY_MAX_RESULTS_PER_ACCT 	:= 20;
	EXPORT PROPERTY_MAX_RESULTS_PER_QUERY	:= 50;
	EXPORT PROPERTY_SERVICE_JOIN_LIMIT 		:= 1000;
	EXPORT PROPERTY_MAX_KFETCH_LIMIT   		:= 5000;
	EXPORT PROPERTY_MAX_FIPS_LIMIT				:= 10000;
	EXPORT HRIADDR_MAX_RESULTS_PER_ACCT 	:= 20;
	EXPORT HRIADDR_SERVICE_JOIN_LIMIT := 1000;
	EXPORT HRIADDR_SICCODE_DESC_LIMIT := 5;
	
	EXPORT MATCH_ANYTHING := '.*'; // Regular Expression
	
	EXPORT AKA_JOIN_LIMIT := 5000;
	EXPORT AKA_PENALTY_LIMIT := 10;

  // CFP=CompaniesForPerson Batch Service (new as of June 2010)
	EXPORT CFP_JOIN_LIMIT := 10000;
	EXPORT UNSIGNED2 CFP_DID_LIMIT  := 1;
	
	EXPORT OTHERS_USING_SSN_JOIN_LIMIT := 5000;
	EXPORT OTHERS_USING_SSN_JOIN_KEEP_VAL := 100;

	EXPORT DEATH_SERVICE_JOIN_LIMIT := 1000;
	
	EXPORT SEXPREDCPS_SERVICE_JOIN_LIMIT := 1000;
	
	EXPORT DEA_SERVICE_JOIN_LIMIT := 1000;
	EXPORT DEA_SEQ_MAX_LIMIT := 500;
	EXPORT DEA_CODESV3_FILE := 'DEA_REGISTRATION';
	
	EXPORT Death := MODULE
		EXPORT DEFAULT_DID_SCORE_THRESHOLD	:= 100;
	END;
	
	Export JudgementsAndLiens := Module
		Export JOIN_LIMIT := 10000;	
	END;
	
	Export UCCLiens := Module		
		export JOIN_LIMIT := 10000;
		export DID_JOIN_LIMIT := 3000;
		export SEARCH_MIN_DATE := '01/01/1900';
		export SEARCH_MAX_DATE := '12/31/3000';
		export BATCH_MAX_RESULTS := '500';
	END;
	
	export PLD := MODULE
		export JOIN_LIMIT := 10000;
		export SEQ_MAX_LIMIT := 500;
		export DEFENDANT := 'DEFENDANT';
		export PLAINTIFF  := 'PLAINTIFF';
		export FILTERVALUE := 10;
		export PERSON_CHAR := 'P';
		export COMPANY_CHAR :='C';
	end;
	
	export Email := MODULE
		export JOIN_LIMIT := 10000;
		export SEQ_MAX_LIMIT := 500;
	end;
	export REALTIME_Record_max := 100;
	export RealTime := MODULE
		EXPORT REALTIME_PHONE_LIMIT := 10;
		EXPORT REALTIME_PHONE_MSG := 'Qsent Phone Gateway';
		export REALTIME_Record_default := 30;
		export SearchType := MODULE
		export TEN_DIGIT := 'TEN DIGIT';
		export NAME_ADDR := 'NAME ADDR';
		export NAME_SSN := 'NAME SSN';
		export LINKID := 'LINKID';
		export ADDR_ONLY := 'ADDR ONLY';
		EXPORT SEARCH_INPUT := 'SEARCH INPUT';
	end;
	end;
	
	
	EXPORT Bankruptcy := MODULE
		EXPORT INDIVIDUAL		:= 'I';
		EXPORT BUSINESS			:= 'B';
		EXPORT MULTIPLE_DEBTOR 	:= 'M';
		EXPORT SINGLE_DEBTOR 	:= 'S';
		EXPORT TRUSTEE_EMPTY_MESG 	:= 'INFORMATION NOT AVAILABLE';
		EXPORT TRUSTEE_INVALID_IDS 	:= ['0', '9999'];
		EXPORT FIXCASE_FL1_COURTS 	:= ['FLM0', 'FLM6', 'FLM8', 'FLM9'];
		EXPORT FIXCASE_FL1_XTRA_NUM	:= ['6', '8', '9'];
		EXPORT FIXCASE_FL2_COURTS	:= ['FL00', 'FL02', 'FL04', 'FLN0', 'FLN2', 'FLN4', 'FLN5', 'FLNC', 'FLNG', 'FLNP'];
		EXPORT FIXCASE_FL2_FIRST2	:= '98';
		EXPORT FIXCASE_FL2_XTRA_NUM	:= ['2', '3', '4', '5', '7'];
		EXPORT FIXCASE_PA_COURTS	:= ['PAM0', 'PAM5'];
		EXPORT FIXCASE_PA_XTRA_NUM	:= ['5'];
		EXPORT FIXCASE_PA_FIRST2_9L	:= '90';	/* Low first 2 9's 	*/
		EXPORT FIXCASE_PA_FIRST2_9H	:= '99';	/* High first 2 9's */
		EXPORT FIXCASE_PA_FIRST2_0L	:= '00';	/* Low first 2 0's 	*/
		EXPORT FIXCASE_PA_FIRST2_0H	:= '02';	/* High first 2 0's */
		EXPORT FIXCASE_VA_COURTS	:= ['VAW5', 'VAW6', 'VAW7'];
		EXPORT FIXCASE_VA_XTRA_NUM	:= ['5', '6', '7'];
		EXPORT CASE_STATUS			:= ['NEW_CASE', 'TRANSFER_IN', 'SPLIT_IN', 'CONSOLIDATED_IN'];
		
		/* 
			default threshold above which DID or BDID values are 'allowed' to be used to append AZC match code components
			to match code without existing SN/PN/RN matches in match code 
		*/
		EXPORT DEFAULT_DID_SCORE_THRESHOLD	:= 100;		
		EXPORT DEFAULT_BDID_SCORE_THRESHOLD	:= 100;
		
		/* Equivalence classes for name suffixes */
		// Junior
		EXPORT SUFFIX_JUNIOR 		:= ['J', '2', 'II', 'JR'];
		EXPORT SUFFIX_SENIOR		:= ['S', '1', 'I', 'SR'];
		EXPORT SUFFIX_FIFTH			:= ['V', '5'];
		
	END;
	export Residents := Module
		export integer TODAY_YYYYMM 								:= Std.Date.Today() DIV 100;
		export integer ONE_YEAR     								:= 100;
		export ThresholdDateForCurrentResidency := (TODAY_YYYYMM - (ONE_YEAR * 10));
	END;
	export ReversePhoneHistory := Module
	   EXPORT MAX_RESULTS_PER_ACCT := 50;
	   EXPORT MAX_SEARCH_RESULTS_PER_ACCT := 2000;
	END;
	EXPORT CourtLocator := MODULE
	   EXPORT MAX_RESULTS_PER_ACCT := 30;		 		 
	   EXPORT MAX_RESULTS := 2000;
		 EXPORT JOIN_LIMIT := 2000;
	END;
	
	EXPORT Trustee := MODULE
		EXPORT JOIN_LIMIT := 150000;
		EXPORT BAD_IDS := ['','0','9999'];
	END;
	
	EXPORT CapitalGains := MODULE
		EXPORT JOIN_LIMIT := 2000;
		EXPORT DID_SCORE_THRESHOLD 				:= 75;

		// As requested by product (see bug #104843), only use the following document types to account for sale information.
		// From codes v3, file=FARES_1080, field=DOCUMENT_TYPE, code.
		EXPORT SET OF STRING3 DOCTYPE_EXCLUSION_SRCA	:= [
																												'T', // DEED OF TRUST
																												'F', // FINAL JUDGEMENT
																												'U', // FORECLOSURE
																												'X', // MULTI CNTY/ST OR OPEN END MORTGAGE
																												'Z', // NOMINAL
																												'Q'  // QUIT CLAIM
																											];	
		EXPORT SET OF STRING3 DOCTYPE_EXCLUSION_SRCB := [
																												'DJ', // AFFIDAVIT OF DEATH OF JOINT TENANT
																												'BS', // BARGAIN AND SALE DEED
																												'BD', // BENEFICIARY DEED
																												'CR', // CORRECTION DEED
																												'DL', // DEED IN LIEU OF FORECLOSURE
																												'DG', // DEED OF GUARDIAN
																												'FC', // FORECLOSURE
																												'IT', // INTERFAMILY TRANSFER & DISSOLUTION
																												'KH', // PERSONAL REPRESENTATIVES DEED
																												'QC', // QUIT CLAIM DEED
																												'RD', // REDEMPTION DEED
																												'RR', // RE-RECORDED DOCUMENT TO CORRECT NAME, DESC., ETC.
																												'SD', // SHERIFF'S DEED
																												'SV', // SURVIVORSHIP DEED
																												'DD', // TRANSFER ON DEATH DEED
																												'TD' // TRUSTEE'S DEED - (CERTIFICATE OF TITLE)
																									 ];
		
	END;
	
	EXPORT TRISv3 := MODULE

		EXPORT Correctional_Institution := '2225'; //2018-04-10 v3.2.2 change
		EXPORT Data_Type_1 := '1';
		EXPORT Data_Type_2 := '2';
		EXPORT Department_of_Corrections := 'Department of Corrections';
		EXPORT Criminal_Court := 'Criminal Court';
		
		//Tris v3.2 Enhancement : Following Constants are added for Req # 3.1.4
		EXPORT SET OF STRING5 IP_Country := ['US','USA'];
		EXPORT Contributory_Rec_Join_Limit := 100;
		EXPORT RTNbr 		:= 'ROUTING_TRANSIT_NBR';
		EXPORT ARNbr 		:= 'ABA_ROUT_NBR';
		EXPORT PrepID 	:= 'PREP_ID2';
		EXPORT EmailAdd := 'EMAIL_ADDR';
		EXPORT ISPName2	:= 'ISP-NAME2';
		EXPORT ISPName3	:= 'ISP-NAME3';
		EXPORT RISK_ATTR1 := '1';
		EXPORT RISK_ATTR2 := '2';
			

    // values generated by SALT from the L&J data on 8/27/2014
    // clean name function removes some chars that were found by SALT analysis
    EXPORT set of string creditorStateSet := [
                        'STATE OF ALABAMA',
												'STATE OF ALASKA',
												'STATE OF ARIZONA',
												'STATE OF ARKANSAS',
												'STATE OF CALIFORNIA',
												'STATE OF COLORADO',
												'STATE OF CONNECTICUT',  
												'STATE OF DELAWARE',
												'STATE OF DISTRICT OF COLUMBIA',
												'STATE OF FLORIDA',
												'STATE OF GEORGIA',
												'STATE OF HAWAII',
												'STATE OF IDAHO',
												'STATE OF ILLINOIS',
												'STATE OF INDIANA',
												'STATE OF IOWA',
												'STATE OF KANSAS',
												'STATE OF KENTUCKY',
												'STATE OF MAINE',
												'STATE OF MARYLAND',
												'STATE OF MASS DOR',
												'STATE OF MASSACHUSETTS',
												'STATE OF MICHIGAN',
												'STATE OF MINNESOTA',
												'STATE OF MISSISSIPPI',
												'STATE OF MISSOURI',
												'STATE OF MONTANA',
												'STATE OF NEBRASKA',
												'STATE OF NEVADA',
												'STATE OF NEW HAMPSHIRE',
												'STATE OF NEW JERSEY',
												'STATE OF NEW MEXICO',
												'STATE OF NEW YORK',
												'STATE OF NORTH CAROLINA',
												'STATE OF NORTH DAKOTA',
												'STATE OF OHIO',
												'STATE OF OKLAHOMA',
												'STATE OF OREGON',
												'STATE OF PENNSYLVANIA',
												'STATE OF RHODE ISLAND',
												'STATE OF SOUTH CAROLINA',
												'STATE OF SOUTH DAKOTA',
												'STATE OF TENNESSEE',
												'STATE OF TEXAS',
												'STATE OF UTAH',
												'STATE OF VERMONT',
												'STATE OF WASHINGTON',
												'STATE OF WEST VIRGINIA',
												'STATE OF WISCONSIN',
												'STATE OF WYOMING',
												'COMMONWEALTH OF VIRGINIA',
												'COMMONWEALTH OF KENTUCKY',
												'COMMONWEALTH OF PENNSYLVANIA',
												'PEOPLE OF THE STATE OF NEW YORK',
												'NYS TAX COMMISSION',
												'NYS TAX COMMISSION CSE',
												'NYS DEPT OF TAXATION  FINANCE',
												'NYS DEPARTMENT OF TAXATION AND FINANCE',
												'NYS DEPARTMENT OF TAXATION FINANCE',
												'NY STATE DEPT OF TAXATION FINANCE',
                        'NY STATE DEPT OF TAXATION AND FINANCE',
												'NY DEPT OF TAXATION FINANCE',
												'SC DEPT OF REVENUE',
												'WV TAX LIEN',
												'IRS OHIO',
												'VA TAX LIEN',
												'VA CHILD SUPPORT LIEN'];

     EXPORT set of string stateLienSet := [
                               'NY STATE TAX WARRANT',
                               'STATE TAX LIEN',
                               'STATE TAX WARRANT',
				    									 'ILLINOIS TAX LIEN',
						    							 'JUDGMENT OR STATE TAX LIEN',
								    					 'STATE TAX WARRANT RENEWED',
										    			 'STATE TAX LIEN RENEWAL'];

    EXPORT set of string lienReleasedSet := [
													'STATE TAX RELEASE',
													'SATISFACTIONS',
													'JUDGMENT LIEN RELEASE ',                          
													'SATISFACTION OF JUDGMENT',
													'STATE TAX RELEASE',
													'FILED IN ERROR ST TAX WARRANT',
													'FILED IN ERROR ST TAX LIEN',
													'DISPOSED',
													'EXPUNGED',
													'WITHDRAWAL',
													'VACATED',
													'SATISFIED',
													'JUDGMENT VACATED'];

	 	// A set of deed_document_type_desc field values to be excluded.  This set was built
		// from the TRISV3 requirements document, Appendix A, 10.4, Deed Filing Types.xlsx.
		// NOTE: deed_document_type_desc is string70 in BatchServices.layout_Property_Batch_out
    EXPORT set of string set_ExcludedDeedTypes := [
                               'RELEASE/RECISION - 24', // per Jennifer on 09/08/14, from Salt data analysis,
															                          // but does not appear in key codesv3 for file_name=FARES_1080 & field_name=DOCUMENT_TYPE
															 'RELEASE/RECISION', // added since in key codesv3, but not on the Deed Filing Types.xlsx in the reqs doc
                               'LIS PENDENS',
                               'NOTICE OF DEFAULT',
				    									 'QUIT CLAIM',
						    							 'RELEASE OF LIS PENDENS', // per Jennifer on 09/08/14, from Salt data analysis
								    					 'DEED OF TRUST',
										    			 'ADMINISTRATOR\'S DEED',
															 'AFFIDAVIT',
															 'ASSIGNMENT DEED',
															 'AFFIDAVIT OF TRUST OR TRUST AGREEMENT (LOS ANGELES COUNTY ONLY)', //???
															 'BENEFICIARY DEED',
															 'CONSERVATOR\'S DEED',
															 'CERTIFICATE OF TRANSFER',
															 'TRANSFER ON DEATH DEED',
															 'DEED OF GUARDIAN',
															 'AFFIDAVIT OF DEATH OF JOINT TENANT',
															 'EXCHANGE',
															 'EXECUTOR\'S DEED',
															 'FIDUCIARY DEED', 
															 'GRANT DEED',
															 'GIFT DEED',
															 'INDIVDUAL DEED',
															 'INTERFAMILY TRANSFER & DISSOLUTION',
															 'JOINT TENANCY DEED',
															 'PERSONAL REP DEED',
															 'PUBLIC AUCTION OR PROPERTY SOLD FOR TAXES',
															 'PERSONAL REPRESENTATIVES DEED',
															 'QUIT CLAIM DEED',
															 'RELEASE/SATISFACTION OF AGREEMENT OF SALE (FREE PROPERTY)',
															 'AFFIDAVIT DEATH OF TRUSTEE/SUCCESSOR TRUSTEE (LOS ANGELES COUNTY ONLY)',
															 'SURVIVORSHIP DEED',
															 'TRUSTEE\'S DEED - (CERTIFICATE OF TITLE)'
															 ];
															 
	END;  //TRISv3 MODULE
	
	// TRISv3.1 with FDN
	
	EXPORT TRISv31_FDN := MODULE
	
	EXPORT set of string classification_source_sourc_type := ['EVENT OUTCOMES'];
	
	EXPORT set of string classification_activity_confidence := ['KNOWN GOOD','NEUTRAL'];
													
	EXPORT set of string classification_activity_Threat := ['CLEAR'];
													
	EXPORT set of string classification_Entity_Role := ['FACILITATOR/AGENT','REPORTER/INFORMANT'];
	 
	EXPORT set of string classification_Entity_Evidence := ['NONE','SECONDARY'];
													
	end;
													
	export  Didville := module
   EXPORT unsigned8 Limit_MaxResultsPerAcct := 5; // limiting the number of DIDs to be returened for a input to 5.
	end;
	
END;