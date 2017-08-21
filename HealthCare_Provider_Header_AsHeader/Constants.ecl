IMPORT MDR;

EXPORT Constants := MODULE

	// for decoding source bitmask (rolled up records)
	// EXPORT SourceBit := MODULE
		// EXPORT LexisNexis := 0;
		// EXPORT Enclarity	:= 1;
		// EXPORT HMS				:= 2;
	// END;

	EXPORT SourceBit := MODULE
		EXPORT LexisNexis	        := 1000000000000000b;
		EXPORT Enclarity	        := 0100000000000000b;
		EXPORT HMS   	            := 0010000000000000b;
		EXPORT UPIN								:= 1000000000000000000000000000000000000000000000000000000000000000b;
		EXPORT SSN								:= 0100000000000000000000000000000000000000000000000000000000000000b;
		EXPORT DOB								:= 0010000000000000000000000000000000000000000000000000000000000000b;
		EXPORT MNAME							:= 0001000000000000000000000000000000000000000000000000000000000000b;
		EXPORT SNAME							:= 0000100000000000000000000000000000000000000000000000000000000000b;
		EXPORT PNAME							:= 0000010000000000000000000000000000000000000000000000000000000000b;
		EXPORT CNAME							:= 0000001000000000000000000000000000000000000000000000000000000000b;
		EXPORT GENDER							:= 0000000100000000000000000000000000000000000000000000000000000000b;
		EXPORT TAXONOMY						:= 0000000010000000000000000000000000000000000000000000000000000000b;
		EXPORT MEDSCHOOL					:= 0000000001000000000000000000000000000000000000000000000000000000b;
		EXPORT MEDSCHOOL_YEAR			:= 0000000000100000000000000000000000000000000000000000000000000000b;
		EXPORT TAX_ID							:= 0000000000010000000000000000000000000000000000000000000000000000b;
		EXPORT BILLING_NPI				:= 0000000000001000000000000000000000000000000000000000000000000000b;
		EXPORT DEATH_IND					:= 0000000000000100000000000000000000000000000000000000000000000000b;
		EXPORT DOD								:= 0000000000000010000000000000000000000000000000000000000000000000b;
		EXPORT PRAC_PHONE					:= 0000000000000001000000000000000000000000000000000000000000000000b;
		EXPORT PRAC_FAX						:= 0000000000000000100000000000000000000000000000000000000000000000b;
		EXPORT EMAIL							:= 0000000000000000010000000000000000000000000000000000000000000000b;
		EXPORT WEB_SITE						:= 0000000000000000001000000000000000000000000000000000000000000000b;
		EXPORT BILL_PHONE					:= 0000000000000000000100000000000000000000000000000000000000000000b;
		EXPORT BILL_FAX						:= 0000000000000000000010000000000000000000000000000000000000000000b;
		EXPORT cnsmr_ssn					:= 0000000000000000000001000000000000000000000000000000000000000000b;
		EXPORT cnsmr_dob					:= 0000000000000000000000100000000000000000000000000000000000000000b;
	END;

	// cleaning regex
	EXPORT NonPrintableChar := '[^[:print:]]';
	EXPORT NonAsciiChar			:= '[^ -~]';
	EXPORT NonAlphaNumChar	:= '[^A-Za-z0-9]';
	EXPORT NonNameChar  		:= '[^A-Za-z0-9\\-\' ]';
	EXPORT NonWordChar			:= '[^A-Za-z0-9 ]';

	// used in several Boca base files to indicate whether record was seen in latest feed
	EXPORT RecordType := MODULE
		EXPORT Current 		:= 'C';
		EXPORT Historical	:= 'H';
	END;
		
	// source handling
	EXPORT FileSources := MODULE
		EXPORT LN_DEA			:= MDR.SourceTools.src_DEA; //'DA'
		EXPORT LN_NPPES		:= MDR.SourceTools.src_NPPES; // 'NP'
		EXPORT LN_ProfLic	:= MDR.SourceTools.src_Professional_License; // 'PL'
		EXPORT AMS				:= MDR.SourceTools.src_AMS; // 'SJ'
		EXPORT MPRD	:= MODULE
			EXPORT Main									:= MDR.SourceTools.src_MPRD_Individual; // 'QN'
			EXPORT nppesMain						:= 'NPI_IDV';
			EXPORT setNPPES							:= [nppesMain, 'FKA_NPI', 'NPI_RET'];
			EXPORT deaMain							:= 'DEA';
			EXPORT setDEA 							:= [deaMain, 'DEA_RET', 'FKA_DEA'];
			EXPORT suffixENC						:= 'ENC';
			EXPORT setOutreachENC				:= ['SKA_' + suffixENC, 'INACT_' + suffixENC];
			EXPORT suffixHCSC						:= 'HCSC';
			EXPORT setOutreachHCSC			:= ['SKA_' + suffixHCSC, 'INACT_' + suffixHCSC];
			EXPORT suffixHMA						:= 'HMA';
			EXPORT setOutreachHMA				:= ['SKA_' + suffixHMA, 'INACT_' + suffixHMA];
			EXPORT suffixLOPS						:= 'LOPS';
			EXPORT setOutreachLOPS			:= ['SKA_' + suffixLOPS, 'INACT_' + suffixLOPS, 'INACT_LOP'];
			EXPORT suffixSKA						:= 'SKA';
			EXPORT setOutreachSKA				:= ['SKA_' + suffixSKA, 'INACT_' + suffixSKA];
			EXPORT suffixVSF						:= 'VSF';
			EXPORT setOutreachVSF				:= ['ACT_' + suffixVSF, 'INACT_' + suffixVSF];
			EXPORT setOutreach					:= setOutreachENC + setOutreachHCSC + setOutreachHMA + setOutreachLOPS +
			                               setOutreachSKA + setOutreachVSF;
			EXPORT suffixHBP						:= 'HBP';
			EXPORT setOutreachHBP				:= ['SKA_' + suffixHBP, 'INACT_' + suffixHBP];
			EXPORT suffixHOBP						:= 'HOBP';
			EXPORT setOutreachHOBP			:= ['SKA_' + suffixHOBP, 'INACT_' + suffixHOBP];
			EXPORT suffixINACT					:= 'INACT';
			EXPORT setOutreachINACT			:= ['SKA_' + suffixINACT, 'INACT_' + suffixINACT];
			EXPORT suffixOBP						:= 'OBP';
			EXPORT setOutreachOBP				:= ['SKA_' + suffixOBP, 'INACT_' + suffixOBP];
			EXPORT suffixPHAR1					:= 'PHAR1';
			EXPORT setOutreachPHAR1			:= ['SKA_' + suffixPHAR1, 'INACT_' + suffixPHAR1];
			EXPORT setOutreachRestricted:= setOutreachHBP + setOutreachHOBP + setOutreachINACT + 
			                               setOutreachOBP + setOutreachPHAR1;
			EXPORT UPIN									:= 'CMS_UPIN';
			EXPORT PCD									:= 'CMS_PCD';
			EXPORT setSanction					:= ['SNC_OIG', 'SNC_OPM'];
			EXPORT sanctionWildcard			:= 'ACI_IDV';
			EXPORT setReinstatement			:= ['REIN_OIG', 'REIN_OPM'];
			EXPORT licenseWildcard			:= 'LIC_';
			EXPORT rosterWildcard				:= 'RST_';
			EXPORT CSRWildcard					:= ['CSR_', 'CSL_'];
			EXPORT claimsAddresses			:= 'CLAIM_ADD';
		END;
	END;
	
	EXPORT StandardSources := MODULE
		EXPORT DEA										:= 'DEA';
		EXPORT NPPES									:= 'NPPES';
		EXPORT Outreach								:= 'MANUAL';
		EXPORT Outreach_Restricted		:= 'MANUAL-RE';
		EXPORT ProfessionalLicense		:= 'LIC';
		EXPORT UPIN										:= 'UPIN';
		EXPORT Sanction								:= 'SANCTION';
		EXPORT Roster									:= 'ROSTER';
		EXPORT Reinstatement					:= 'REINSTATE';
		EXPORT Claim									:= 'CLAIM';
		EXPORT AMS										:= 'AMS';
		EXPORT Other									:= 'OTHER';
	END;
	
	EXPORT setInternalDedupSources	:= [StandardSources.DEA, StandardSources.NPPES];
	EXPORT setLNLegacySources				:= [FileSources.LN_NPPES, FileSources.LN_DEA, FileSources.AMS, FileSources.LN_ProfLic];
	
	// flags for data source
	EXPORT FieldSourceFlag	:= MODULE
		EXPORT FromSrc		:= 'S';
		EXPORT FromLexID	:= 'L';
	END;
	
	// allowed gender values
	EXPORT setGenderAllowedValues := ['M','F'];
	
	// null taxonomy values
	EXPORT setTaxonomyIgnore := [];
	
	// bad cname values
	EXPORT regexBadCname	:= '^(LIMITED TO OFFICIAL|LTD TO OFFICIAL|LIMITED TO STATE|LTD TO STATE|LIMITED TO TRIBAL|LTD TO TRIBAL|CREDENTIAL OFFICE$|CREDENTIALS OFFICE$|LIMITED TO UNIVERSITY EMPLOYEE|'
	                         + 'FOR USE THIS LOCATION ONLY$|LIMITED FOR UNIVERSITY DUTIES ONLY|VALID FOR STATE GOVERNMENT EMPLOYEE ONLY|FOR USETHIS LOCATION ONLY|NOT A WORK ADDRESS|'
													 + 'FOR STATE EMPLOYEE OFFICIAL DUTIES|TO BE USED AT THIS FACILITY ONLY|NOT A BUSINESS ADDRESS|RESTRICTED TO OFFICIAL|NOT REPORTED|ATTN:CREDENTIAL OFFICE|'
													 + 'ATTN:CREDENTIALS OFFICE|OUT-OF-STATE|NOT IN PRACTICE|NONE|NA|!|")';
													 
	// bad medschool values
	EXPORT regexBadMedschool := '^(NOT ON FILE|OUT OF STATE|OUT-OF-STATE|-NOT REGISTERED|NONE|-NOT SPECIFIED|- NOT SPECIFIED|NOT APPKICABLE|ALL|NONE|NONE GIVEN|NONE REPORTED|NOT AVAILABLE|'
															+'NOT USED|NOT GIVEN|NOT LISTED|NOT ON CARD|OUT OF COUNTRY|OUT-OF-COUNTRY)';
	
	// DEA suffixes to move to pname
	EXPORT setSuffixMoveToPname_DEA := ['MD', 'PA', 'DDS', 'MSN', 'DO', 'MD PH', 'PHD', 'MS', 'DVM', 'DMD', 'RN', 'NP', 'OD'];
	
	// bogus license values to be filtered from license number field
	EXPORT setBogusLicense := ['390200000X','WC1','35NULL','34NULL','LARN00000',
	                           'INPROCESS','NOTAPPLICABLE','APPLIEDFOR','PENDING',
	                           '0','00','000','0000','00000','000000','0000000','00000000','000000000',
														 'NOLICNUMBER','NR','NULL','NA','NONE',
														 'TEMPORARY','STUDENT','UNKNOWN','TEMP','RESIDENT','OPT'];

	// bad first/last names to be filtered in Boca professional license build									 
	EXPORT badFname_ProfLic := ['KAISER','EYE','PERMANENETE','PERMANTENE','PERMENENTE',
	                            'EYE','PERMANETE','SOUTHERN','VOID','NEURO','SPINE','CARE',
															'INTERMED','ORTHOPADIC','PEDS'];
	EXPORT badLname_ProfLic := ['PERMANENTE','MASS','PERMANENTE','PERMANENTE','PREMANENTE',
	                            'PERMANENTE','PERMANENTE','PERMANENTE','PERMANENTE','KEISER',
															'PERMANENTE','PERMANENTE','PERMANENTE','GROUP','VOID','SPINE','CARE'];
															
	// Boca professional license file categories/boards to use in identifying records tied to medical licenses
	EXPORT category_ProfLic := ['DENTAL','MEDICAL','MEDICINE','NURSING','NURSING HOME','VETERINARY'];
	EXPORT professionBoard_ProfLic := ['RADIOLOGY','CHIROPRACTORS','HEALTH','DENTAL BOARD OF CALIFORNIA',
	                                   'MEDICAL','NURSING BOARD','DENTISTRY','DENTAL HYGIENE',
																		 'OPTOMETRY','DIETITIAN','MEDICINE','NURSING BOARD','PHARMACY'];
																		 
	// EXPORT setStates_ProfLic := ['AL','AK','AR','AS','AZ','CA','CO','CT','DC','DE','FL','GA','GS','GU','HI','IA','ID','IL',
															 // 'IN','KS','KY','LA','MA','MD','ME','MI','MN','MO','MS','MT','NC','ND','NE','NH','NJ','NM','NV',
															 // 'NU','NY','OH','OK','OR','PA','PR','RI','RN','SC','SD','TN','TX','UT','VA','VI','VT','WA','WI',
															 // 'WV','WY','RR','PR','EE'];
	// states that are updated in Boca professional license file
	EXPORT setStates_ProfLic := ['AL','AK','CA','CO','GA','HI','IL','IN','IA','MI','MN','NE','OK','SC','TX','VA','WI','WY'];
	
	// used in professional name (pname) cleaning
	EXPORT Prof_Name := DATASET ([
		{'AACNP'},	
		{'ABD'},
		{'ABFP'},
		{'ABIHM'},
		{'ABO'},
		{'ACA'},	
		{'ACNP'},
		{'ACNPBC'},
		{'ACRNP'},
		{'ACU'},
		{'AHNP'},
		{'ANP'},
		{'ANP-BC'},
		{'ANPBC'},
		{'ANPC'},
		{'APN'},
		{'APNC'},
		{'APNP'},
		{'APRN'},
		{'APRNBC'},
		{'APRNCNP'},
		{'ARNP'},
		{'ATH'},
		{'BA'},
		{'BC'},
		{'BCBA'},
		{'BCBAD'},
		{'BS'},
		{'CCCA'},
		{'CCCSLP'},
		{'CEP'},
		{'CFNP'},
		{'CMSW'},
		{'CMT'},
		{'CMW'},
		{'CNA'},
		{'CNM'},
		{'CNMW'},
		{'CNP'},
		{'CNS'},
		{'COTAS'},
		{'CPCS'},
		{'CPNP'},
		{'CRN'},
		{'CRNA'},
		{'CRNFA'},
		{'CRNP'},
		{'CSW'},
		{'DC'},
		{'DCPA'},
		{'DDM'},
		{'DDS'},
		{'DM'},
		{'DMD'},
		{'DNP'},
		{'DO'},
		{'DPM'},
		{'DPO'},
		{'DPT'},
		{'DR'},
		{'DVM'},
		{'FAAD'},
		{'FAAFP'},
		{'FAAO'},
		{'FAAOS'},
		{'FAAP'},
		{'FACC'},
		{'FACCP'},
		{'FACEP'},
		{'FACFAS'},
		{'FACMG'},
		{'FACMT'},
		{'FACOEM'},
		{'FACOG'},
		{'FACP'},
		{'FACR'},
		{'FACRO'},
		{'FACS'},
		{'FAHA'},
		{'FASCRS'},
		{'FNLA'},
		{'FNP'},
		{'FNP-C'},
		{'FNPBC'},
		{'FNPC'},
		{'LAC'},
		{'LADC'},
		{'LAT'},
		{'LATH'},
		{'LBSW'},
		{'LCMHC'},
		{'LCOTA'},
		{'LCPC'},
		{'LCSW'},
		{'LD'},
		{'LDN'},
		{'LDO'},
		{'LICSW'},
		{'LLM'},
		{'LMFT'},
		{'LMHC'},
		{'LMHP'},
		{'LMP'},
		{'LMSW'},
		{'LMT'},
		{'LOT'},
		{'LOTA'},
		{'LOTR'},
		{'LPC'},
		{'LPN'},
		{'LRCP'},
		{'LTR'},
		{'MASW'},
		{'MBBS'},
		{'MBCHB'},
		{'MD'},
		{'MDO'},
		{'MDPA'},
		{'MDPHD'},
		{'MED'},
		{'MHA'},
		{'MHS'},
		{'MMS'},
		{'MN'},
		{'MNSC'},
		{'MPAC'},
		{'MPAP'},
		{'MPAS'},
		{'MPH'},
		{'MPT'},
		{'MRC'},
		{'MS'},
		{'MSCE'},
		{'MSD'},
		{'MSEE'},
		{'MSN'},
		{'MSNFNP'},
		{'MSNFNPC'},
		{'MSNRN'},
		{'MSPA'},
		{'MSPAS'},
		{'MSPT'},
		{'MSS'},
		{'MSSA'},
		{'MSSW'},
		{'MSW'},
		{'MTH'},
		{'ND'},
		{'NM'},
		{'NMD'},
		{'NNP'},
		{'NP'},
		{'NP-C'},
		{'NPC'},
		{'NPF'},
		{'NPP'},
		{'NUR'},
		{'NURSE'},
		{'OD'},
		{'OGNP'},
		{'OT'},
		{'OTA'},
		{'OTR'},
		{'OTRL'},
		{'PA'},
		{'PA-C'},
		{'PAC'},
		{'PC'},
		{'PHARMD'},
		{'PHD'},
		{'PLLC'},
		{'PMH'},
		{'PMHCNSBC'},
		{'PMHNP'},
		{'PMHNPBC'},
		{'PNP'},
		{'PSC'},
		{'PSY'},
		{'PSYD'},
		{'PT'},
		{'PTA'},
		{'RCP'},
		{'RD'},
		{'RDO'},
		{'RN'},
		{'RNC'},
		{'RNCS'},
		{'RNP'},
		{'RPA-C'},
		{'RPAC'},
		{'RPH'},
		{'RRT'},
		{'RT'},
		{'RTT'},
		{'SLP'},
		{'TPA'},
		{'VMD'},
		{'WHCNP'},
		{'WHNP-B'},
		{'WHNPBC'}
	],{STRING15 PNAME});
END;