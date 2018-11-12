IMPORT Address, AutoStandardI, BIPV2, BIPV2_Best, Business_Credit, doxie, iesp, Risk_Indicators,
                        Business_Risk,  DID_Add,  STD, ut, TopBusiness_Services;

EXPORT Functions := MODULE
           // efficiency addition to move BIP and bus credit related kfetches into 1 place and pass in common params used in both.
		 EXPORT bipkfetch(dataset(BIPV2.IDlayouts.l_xlink_ids2) BipLinkids,
		                                             STRING1 FETCHLEVEL,
							                   INTEGER FETCHLIMIT = 10000,
									         STRING DataPermissionMask) := MODULE
                      
          // efficiency add true on END since not using for contacts skips the Suppression											
		EXPORT BIPBusHeaderRecsSlim := BIPV2.Key_BH_Linking_Ids.kfetch(project(Biplinkids, transform(BIPV2.IDlayouts.l_xlink_ids, SELF := LEFT))
		                                                                                                              ,FETCHLEVEL
																						    ,
																							,
																							,FETCHLIMIT
																							,TRUE
																							,TRUE)
											(source not in BusinessCredit_Services.Constants.EXCLUDED_EXPERIAN_SRC); //restricting ER and Q3 experian sources
		                                        			 
	     EXPORT   BusCreditHeaderRecs :=  Business_Credit.Key_LinkIds().kfetch2(BIpLinkids
			                                                                                                                              ,FETCHLEVEL
																				                                    ,
																										    ,DatapermissionMask);
	END;

	EXPORT fn_useBusinessCredit (STRING in_dataPermissionMask, BOOLEAN IncludeBusinessCredit ) := FUNCTION

		dataPermissionTempMod := MODULE( AutoStandardI.DataPermissionI.params )
			EXPORT dataPermissionMask := in_dataPermissionMask;
		END;

		// determine if the user has access to Commercial Credit / SBFE and verify that the SBFE work is requested.
		RETURN AutoStandardI.DataPermissionI.val(dataPermissionTempMod).use_SBFEData AND IncludeBusinessCredit;
	END;
   
  // Add Business Credit / SBFE Sorting
	EXPORT fn_BusinessCreditSorting ( DATASET(doxie.Layout_Rollup.KeyRec_feedback) ds_in, UNSIGNED6 inSeleId, UNSIGNED6 inOrgId, UNSIGNED6 inUltId) := FUNCTION 
		// Hit the SBFE keys to see if the did has matches for any of the SELEid/OrgId/UltId input combinations
		// We only need to keep one match to set the indicator for the next join.
		ds_BusinessCredit_hits := JOIN( ds_in, Business_Credit.Key_IndividualOwnerInformation(),
																			KEYED( (UNSIGNED6)LEFT.did = RIGHT.did ) AND
																			inUltId  = RIGHT.UltId AND 
																			inOrgId  = RIGHT.OrgId AND
																			inSeleId = RIGHT.SELEId AND
																			RIGHT.SELEid != 0,
																			TRANSFORM( doxie.Layout_Rollup.KeyRec_feedback,
																								 SELF.BusinessCreditMatch := (UNSIGNED6)LEFT.did = RIGHT.did, 
																								 SELF                     := LEFT,
																							 ),
																			LEFT OUTER,
																			KEEP (1),
																			LIMIT(0)
																	); 

		// sort so sbfe records bubble to the top, keeping the same penalty order for true/false records
		ds_BusinessCredit_atTop := SORT( ds_BusinessCredit_hits, ~BusinessCreditMatch ); 
		doxie.Layout_Rollup.KeyRec_feedback xfm_resetCounter(doxie.Layout_Rollup.KeyRec_feedback L, INTEGER NewBusinessCredit_Order ) := TRANSFORM 
				SELF.output_seq_no := NewBusinessCredit_Order;
				SELF               := L;
		END;
			
		ds_BusinessCredit_atTop_NewSeqNumOrder := PROJECT(ds_BusinessCredit_atTop, xfm_resetCounter (LEFT, COUNTER));
		RETURN ds_BusinessCredit_atTop_NewSeqNumOrder;  
	END; // function fn_BusinessCreditSorting for person Search

	EXPORT fn_setPersonLayout( DATASET(doxie.Layout_Rollup.KeyRec_feedback) ds_in ) := FUNCTION

		iesp.share.t_RiskIndicator xfm_HighRiskIndicators( Risk_Indicators.Layout_Desc L ) := TRANSFORM
				SELF := iesp.ECL2ESP.SetRiskIndicator((STRING4) L.hri,L.desc);
		END;

		iesp.businessauthrepsearch.t_BusinessAuthRepSearchPhones xfm_getPhones ( doxie.Layout_Rollup.PhoneRec_feedback L ) := TRANSFORM
				SELF.Phone10            := L.phone,
				SELF.HighRiskIndicators := PROJECT( L.hri_phone, xfm_HighRiskIndicators(LEFT)),
				SELF.UniqueId           := (STRING12)L.did,
        SELF.ListedName         := L.listed_name,
        SELF.PhoneFirstSeen     := iesp.ECL2ESP.toDateYM(L.phone_first_seen),
        SELF.PhoneLastSeen      := iesp.ECL2ESP.toDateYM(L.phone_last_seen),
        SELF                    := L,   // Listed & phoneType, 
		END;
			
		iesp.businessauthrepsearch.t_BusinessAuthRepSearchAddress xfm_getAddrs (doxie.Layout_Rollup.AddrRec_feedback L) := TRANSFORM
         street_addr := Address.Addr1FromComponents(L.prim_range, L.predir, L.prim_name, L.suffix,
                                                    L.postdir, L.unit_desig, L.sec_range);
         csz := Address.Addr2FromComponents(L.city_name, L.st, L.zip);
    
				 SELF.Address             := iesp.ecl2esp.setAddress ( L.prim_name, L.prim_range, L.predir, L.postdir,
                                                               L.suffix, L.unit_desig, L.sec_range, L.city_name,
                                                               L.st, L.zip, L.zip4, L.county, '', street_addr, '', csz),
				 SELF.DateFirstSeen      := iesp.ECL2ESP.toDate(L.first_seen),
				 SELF.DateLastSeen       := iesp.ECL2ESP.toDate(L.last_seen),
				 SELF.HighRiskIndicators := CHOOSEN(PROJECT( L.hri_address, xfm_HighRiskIndicators(LEFT)), iesp.Constants.DoxieHFRS.ADDRESS_HRIS),
				 SELF.phones             := CHOOSEN(PROJECT(l.phoneRecs, xfm_getPhones(LEFT)), iesp.Constants.DoxieHFRS.phones),
				 SELF                    := [] 
		END;

		iesp.businessauthrepsearch.t_BusinessAuthRepSearchDobRec xfm_getDobs( doxie.Layout_Rollup.dobRec L ) := TRANSFORM
				SELF.DOB := iesp.ECL2ESP.toDate(L.DOB),
				SELF.Age := (INTEGER)L.Age
		END;

		iesp.businessauthrepsearch.t_BusinessAuthRepSearchDodRec xfm_getDods( doxie.Layout_Rollup.dodRec L ) := TRANSFORM
				SELF.DOD        := iesp.ECL2ESP.toDate(L.DOD),
				SELF.AgeAtDeath := (INTEGER)L.dead_age,
				SELF            := L  // deceased
		END;     
																					 
		iesp.share.t_Name xfm_getNames (doxie.Layout_Rollup.NameRec L ) := TRANSFORM
				SELF := iesp.ECL2ESP.setName(L.fname, L.mname, L.lname, L.name_suffix, L.title[1..3]);
		END;
																						
		iesp.share.t_SSNInfoEx  xfm_getSSNs (doxie.Layout_Rollup.SsnRec L) := TRANSFORM
				SELF.Valid              := L.valid_ssn,
				SELF.IssuedLocation     := L.ssn_issue_place,
				SELF.IssuedStartDate    := iesp.ECL2ESP.toDateYM (L.ssn_issue_early),
				SELF.IssuedEndDate      := iesp.ECL2ESP.toDateYM (L.ssn_issue_last),
				SELF.HighRiskIndicators := CHOOSEN(PROJECT( L.hri_ssn, xfm_HighRiskIndicators(LEFT)),iesp.Constants.MaxCountHRI),
				SELF                    := L  // ssn
		END;
													
		// using Choosen here to ensure there are no errors even though the max counts are 
		// taken care of in the D.HFRS code.
		personRecs := PROJECT( ds_in, 
									 TRANSFORM( iesp.businessauthrepsearch.t_BusinessAuthRepPersonSearchRecord,
															SELF.UniqueId  := (STRING12)LEFT.did,
															SELF.Names     := CHOOSEN(PROJECT(LEFT.nameRecs, xfm_getNames(LEFT)), iesp.Constants.DoxieHFRS.names),
															SELF.Addresses := CHOOSEN(PROJECT(LEFT.addrRecs, xfm_getAddrs(LEFT)), iesp.Constants.DoxieHFRS.addresses),
															SELF.SSNs      := CHOOSEN(PROJECT(LEFT.ssnRecs,  xfm_getSSNs(LEFT)),  iesp.Constants.DoxieHFRS.ssns),
															SELF.DOBs      := CHOOSEN(PROJECT(LEFT.dobRecs,  xfm_getDobs(LEFT)),  iesp.Constants.DoxieHFRS.dobs),
															SELF.DODs      := CHOOSEN(PROJECT(LEFT.dodRecs,  xfm_getDods(LEFT)),  iesp.Constants.DoxieHFRS.dods),
															SELF._Penalty  := LEFT.penalt,
                              SELF           := LEFT // BusinessCreditMatch 
														));
		RETURN personRecs;
	END; // END of function fn_setPersonLayout


	//--------------- FUNCTIONS BusinessCredit_Services.CreditReportService --------------------------------//
	EXPORT fn_BuzCreditIndicator (UNSIGNED6 UltID, UNSIGNED6 OrgID, UNSIGNED6 SeleID , STRING in_dataPermissionMask, BOOLEAN buzCreditAccess = FALSE) := FUNCTION

		BIPV2.IDlayouts.l_xlink_ids2 initialize() := TRANSFORM
			SELF.SeleID := SeleID;
			SELF.OrgID  := OrgID;
			SELF.UltID  := UltID;
			SELF				:= [];
		END;

		BusinessIds := DATASET([initialize()]);
		
		BOOLEAN exists_BipHeader 			:= EXISTS(BIPV2_Best.Key_LinkIds.Kfetch2(BusinessIds, , , ,false,BusinessCredit_Services.Constants.BestKfetchMaxLimit));
		BOOLEAN exists_BuzCreditHeader:= IF(buzCreditAccess, EXISTS(Business_Credit.Key_LinkIds().Kfetch2(BusinessIds,,,in_dataPermissionMask,BusinessCredit_Services.Constants.JOIN_LIMIT)(record_type = Business_Credit.Constants().AccountBase)), FALSE);

		integer BuzCreditIndicator := MAP(exists_BipHeader and ~exists_BuzCreditHeader => BusinessCredit_Services.Constants.BUSINESS_CREDIT_INDICATOR.HEADER_FILE_ONLY,
																			~exists_BipHeader and exists_BuzCreditHeader => BusinessCredit_Services.Constants.BUSINESS_CREDIT_INDICATOR.BUSINESS_CREDIT_ONLY,
																			exists_BipHeader and exists_BuzCreditHeader	 => BusinessCredit_Services.Constants.BUSINESS_CREDIT_INDICATOR.BOTH,
																			0); 
		
		RETURN BuzCreditIndicator;
	END;	// END of function fn_BuzCreditIndicator

	EXPORT fn_BuzStructureDescription (STRING BuzStructureCode) := FUNCTION
		buzStructureDesc := CASE(BuzStructureCode,
															'001' => 'Individual Sole Proprietorship',
															'002' => 'Partnership - Limited',
															'003' => 'Partnership - General',
															'004' => 'Limited Liability - Corporation',
															'005' => 'Limited Liability - Partnership', 
															'006' => 'Corporation - Subchapter S',
															'007' => 'Corporation - Subchapter C',
															'008' => 'Corporation - Non-Profit',
															'009' => 'Corporation - Low Profit LLC/L3C',
															'010' => 'Corporation - Public',
															'011' => 'Corporation - Private', 
															'012' => 'Corporation - Type Unknown',
															'013' => 'Fiduciary - Estate',
															'014' => 'Fiduciary - Trust',
															'015' => 'Individual D.B.A.',
															'016' => 'Joint Venture',
															'050' => 'Government - Federal',
															'051' => 'Government - State',
															'052' => 'Government - County',
															'053' => 'Government - City',
															'070' => 'School - Private',
															'071' => 'School - Public',
															'080' => 'Church',
															'');
		RETURN buzStructureDesc;
	END; // END of function BuzStructureDescription
		
	EXPORT fn_AccountTypeDescription (STRING AccountTypeCode) := FUNCTION
		AccountTypeDescription := CASE(AccountTypeCode,
																		'001' => 'Term Loan',
																		'005' => 'Letter of Credit',
																		'002' => 'Line of Credit',
																		'006' => 'Open Ended Credit Line',
																		'003' => 'Commercial Card',
																		'099' => 'Other',
																		'004' => 'Business Lease',
																		'');
		RETURN AccountTypeDescription;
	END; // END of function AccountTypeDescription
	
	EXPORT fn_CurrentAccountStatus (STRING DateAccountClosed , STRING PaymentStatusCategory) := FUNCTION
		AccountStatus := MAP (
													DateAccountClosed = 	'' AND  (integer) PaymentStatusCategory = 0 => 'CURRENT',
													DateAccountClosed = 	'' AND  (integer) PaymentStatusCategory > 0 => 'OVERDUE',
													DateAccountClosed <> 	'' 																					=> 'CLOSED',
													''
													);
		RETURN AccountStatus;
	END; // END of function CurrentAccountStatus
  
  EXPORT fn_CurrentBizAccountStatus (STRING   DateAccountClosed,
                                     STRING   AccountClosureReason,
                                     STRING   PaymentStatusCategory,
                                     STRING   Cycle_End_Date, 
                                     BOOLEAN  isRemain_Bal_Changed,
                                     BOOLEAN  isRecent_Pmt_Not_Zero,
                                     UNSIGNED dateOneYearAgo,
                                     STRING   Account_Status_1,
                                     STRING   Account_Status_2) := FUNCTION
		
    RequiredValidations := DateAccountClosed = '' AND
                           AccountClosureReason = '' AND
                           Account_Status_1 NOT IN BusinessCredit_Services.Constants.Closed_Account_Status_Codes AND
                           Account_Status_2 NOT IN BusinessCredit_Services.Constants.Closed_Account_Status_Codes AND
                           (UNSIGNED)cycle_end_date > DateOneYearAgo AND
                           isRemain_Bal_Changed;
                        
                        
    AccountStatus := MAP (
													RequiredValidations AND (INTEGER) PaymentStatusCategory = 0 
                            => 'CURRENT',
													RequiredValidations AND (INTEGER) PaymentStatusCategory > 0 
                            => 'OVERDUE',
													~RequiredValidations
                            => 'CLOSED',
													''
													);
		RETURN AccountStatus;
	END; // END of function CurrentBizAccountStatus
	
	EXPORT fn_OwnerGuarnIndicator (STRING OwnerGuarnIndicatorCode) := FUNCTION
		OwnerGuarnIndicatorDesc := CASE(OwnerGuarnIndicatorCode,
																		'001' => 'Owner',
																		'002' => 'Guarantor',
																		'003' => 'Both',
																		'');
		RETURN OwnerGuarnIndicatorDesc;
	END; // END of function OwnerGuarnIndicator
	
	EXPORT fn_AccountClosureReason (STRING ClosureReasonCode) := FUNCTION
		ClosureReason := CASE(ClosureReasonCode,
													'V' => 'Voluntarily Closed By Account Holder',
													'P' => 'Involuntarily Closed Due to Poor Payment History',
													'X' => 'Involuntarily Closed By Creditor',
													'O' => 'Other Involuntary Closure By Creditor',
													'F' => 'Involuntarily Closed By Creditor Due to Fraud',
													'B' => 'Involuntarily Closed - Business Filed for Bankruptcy',
													'');
		RETURN ClosureReason;
	END; // END of function AccountClosureReason

	EXPORT fn_PaymentStatusCategory (STRING PaymentStatusCategoryCode) := FUNCTION
		PaymentStatusCategoryDesc:= MAP (
																			PaymentStatusCategoryCode = '007' OR PaymentStatusCategoryCode = '006' OR PaymentStatusCategoryCode = '005' OR PaymentStatusCategoryCode = '004' => 'Overdue 90+',
																			PaymentStatusCategoryCode = '003' => 'Overdue 90',
																			PaymentStatusCategoryCode = '002' => 'Overdue 60',
																			PaymentStatusCategoryCode = '001' => 'Overdue 30',
																			PaymentStatusCategoryCode = '000' => 'Within Terms',
																			''
																		);
		RETURN PaymentStatusCategoryDesc;
	END; // END of function PaymentStatusCategory
	
	EXPORT fn_PaymentTypeDesc (STRING PaymentTypeCode) := FUNCTION
		PaymentTypeDesc:= CASE(PaymentTypeCode , 
														'001' => 'Principal Only',
														'002' => 'Principal and Interest',
														'003' => 'Interest Only',
														'004' => 'Percentage of Balance',
														'005' => 'Principal Plus Interest',
														'006' => 'Fixed Payment Amount',
														'007' => 'Promotional - interest only for an introductory period, then fixed payments',
														'008' => 'Promotional - interest only for an introductory period, then balance due',
														'009' => 'Minimum Payment',
														'099' => 'Other',
														'');
		RETURN PaymentTypeDesc;
	END; // END of function PaymentTypeDesc
	
	EXPORT fn_PaymentFreqDesc (STRING PaymentFreqCode) := FUNCTION
		PaymentFreqDesc:= CASE(PaymentFreqCode,
														'A'		=> 'Annually',
														'BM'	=> 'Bi-Monthly',
														'BW'	=> 'Bi-Weekly',
														'D'		=> 'Daily',
														'M'		=> 'Monthly',
														'W'		=> 'Weekly',
														'Q'		=> 'Quarterly',
														'S'		=> 'Seasonal',
														'SA'	=> 'Semiannually',
														'SM'	=> 'Semi-Monthly',
														'SP'	=> 'Single Payment',
														'');
		RETURN PaymentFreqDesc;
	END; // END of function PaymentFreqDesc

	EXPORT fn_CollateralType (STRING CollateralTypeCode) := FUNCTION
		CollateralType:= CASE(CollateralTypeCode,
														'001' => 'Equipment',
														'002' => 'Blanket',
														'003' => 'Accounts Receivable',
														'004' => 'Inventory',
														'005' => 'AR and Inventory',
														'006' => 'Vehicle(s)',
														'007' => 'Marketable Securities',
														'008' => 'Commercial Real Estate',
														'009' => 'Residential Real Estate',
														'010' => 'Cash',
														'099' => 'Other',
														'');
		RETURN CollateralType;
	END; // END of function fn_CollateralType
	
	EXPORT fn_GovernmentGuaranteedCategoryDesc (STRING GovernmentGuaranteedCategoryCode) := FUNCTION
		GGCategoryDesc := CASE(GovernmentGuaranteedCategoryCode,
														'001' => 'SBA7A',
														'002' => 'SBA Low Doc',
														'003' => 'SBA Express',
														'004' => 'SBA Community Express',
														'005' => 'SBA Community Adj and Invest Program (CAIP)',
														'006' => 'SBA Certified Development Co (CDC 504)',
														'007' => 'SBA CAP Lines',
														'100' => 'US Treasury - Program Type Unknown',
														'200' => 'USDA - Program Type Unknown',
														'300' => 'HUD - Program Type Unknown',
														'400' => 'VA - Program Type Unknown',
														'500' => 'US DOE - Program Type Unknown',
														'600' => '(to be determined)',
														'700' => 'State - State/Program Type Unknown',
														'800' => 'County - County/Program Type Unknown',
														'810' => 'City - City/Program Type Unknown',
														'');
		RETURN GGCategoryDesc;
	END; // END of function GovernmentGuaranteedCategoryDesc		   

	EXPORT fn_WorstStatus (STRING Date_Account_Closed, STRING Account_Closed_Reason, STRING Account_Status_1, STRING Account_Status_2, STRING Payment_Status_Category) := FUNCTION
    BOOLEAN isAccountClosed := Date_Account_Closed <> '' OR
                              Account_Closed_Reason <> '' OR
                              Account_Status_1 IN BusinessCredit_Services.Constants.Closed_Account_Status_Codes OR
                              Account_Status_2 IN BusinessCredit_Services.Constants.Closed_Account_Status_Codes;
		status_whenAccClosed := MAP(isAccountClosed AND  Account_Status_1 = '008' => 'Bankruptcy',
																isAccountClosed AND  (Account_Status_1 = '009' OR Account_Status_1 = '011') => 'Charge off',
																isAccountClosed AND  (Account_Status_1 = '006' OR Account_Status_1 = '015' OR Account_Status_1 = '018') => 'Foreclosure/Repossession',
																isAccountClosed AND  Account_Status_1 = '010' => 'Non-Accrual account',
																isAccountClosed AND  Account_Status_1 = '017' => 'Collection',
																'');
																				
		paymentStatus	:= IF(status_whenAccClosed = '', fn_PaymentStatusCategory(Payment_Status_Category), status_whenAccClosed);
		RETURN paymentStatus; 
	END; // END of function WorstStatus	

	EXPORT fn_WorstStatus_sort_order(STRING status) := FUNCTION
		worst_status_sort_order := 	CASE(status,
																		'Bankruptcy' 							  => 1,
																		'Charge off' 							  => 2,
																		'Foreclosure/Repossession'  => 3,
																		'Non-Accrual account' 		  => 4,
																		'Collection' 							  => 5,
																		'Overdue 90+' 		  				=> 6,
																		'Overdue 90' 		  					=> 7,
																		'Overdue 60' 		 						=> 8,
																		'Overdue 30' 		  					=> 9,
																		'Within Terms' 							=> 10,
																		999);
		RETURN worst_status_sort_order;
	END;

	EXPORT fn_AccountStatus_sort_orderCreditTrades(STRING status) := FUNCTION
	
           res := 	CASE(status,
																				'OVERDUE'	=> 1,
																				'CURRENT'	=> 2,
																				'CLOSED'  => 3,
																				999);																	
   																			
		RETURN res;
	END;	
	EXPORT fn_AccountStatus_sort_order(STRING status) := FUNCTION
	
           fn_AccountStatus_sort_order := 	CASE(status,
																				'CURRENT'	=> 1,
																				'OVERDUE'	=> 2,
																				'CLOSED'  => 3,
																				999);																	
   																			
		RETURN fn_AccountStatus_sort_order;
	END;	
  EXPORT fn_set_ScoreTypeFilter ( STRING20 ScoreTypeRequested = BusinessCredit_Services.Constants.SCORE_TYPE.NONE ) := 
    FUNCTION

      set_ScoreTypeFilter :=
        CASE(ScoreTypeRequested,
             BusinessCredit_Services.Constants.SCORE_TYPE.CREDIT_BLENDED => BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT_BLENDED,
             BusinessCredit_Services.Constants.SCORE_TYPE.BLENDED        => BusinessCredit_Services.Constants.MODEL_NAME_SETS.BLENDED,
             BusinessCredit_Services.Constants.SCORE_TYPE.CREDIT         => BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT,
                                                                            BusinessCredit_Services.Constants.MODEL_NAME_SETS.NONE );

      RETURN set_ScoreTypeFilter;
    END;
		
		// new FUNCTION SBFE CREDIT
		
		EXPORT getVerificationInfo(  DATASET(TopBusiness_Services.Layouts.rec_busHeaderLayout) ds_In_busheaderRecs,
													BusinessCredit_Services.Iparam.reportrecords inmod) := FUNCTION

     tmpLayout := RECORD		
		 UNSIGNED4 seq;
		 bipv2.IDlayouts.l_xlink_ids;
		 STRING120 CompanyName := '';		
		 STRING120 StreetAddress1 := '';
		STRING120 StreetAddress2 := '';
		STRING25  City := '';
		STRING2   State := '';
		STRING9   Zip := '';
		STRING9   FEIN := '';
		STRING10  Phone10 := '';		
		END;

       ds_BusinessHeader := PROJECT(ds_in_busheaderRecs, TRANSFORM({UNSIGNED4 uniqueID;recordof(LEFT); },
			                                             SELF.UniqueID := 1;
										        SELF:= LEFT));
														
                      tmpLayout   inputxFORM() := TRANSFORM
			                              SELF.seq := 1;
								   SELF.ultid := inmod.businessids[1].ultid;
							        SELF.orgid := inmod.businessids[1].orgid;
								   SELF.seleid := inmod.businessIds[1].seleid;
							         SELF.Phone10 := inmod.Company_Phone;
								    SELF.companyname := inmod.CompanyName;																		    
                                              SELF.StreetAddress1 :=  inmod.Company_StreetAddress1;
								   SELF.StreetAddress2 := ''; // this is not populated so just blank out algorithm below adjusts for this. in
									                                 // Risk_Indicators.MOD_AddressClean.clean_addr() function call.
								    SELF.city := inmod.company_city;
								    SELF.state := inmod.company_state;								    
								    SELF.fein := inmod.tin;
								     SELF.zip := inmod.company_zip;
								     SELF := [];
							          END;
												
            ds_originalinput := DATASET( [ InputxFORM() ] );										
		
				layout_temp := RECORD
					UNSIGNED4 Seq;
					STRING120 origCompanyName;
					STRING120 origStreetAddress;
					STRING25  origCity;
					STRING2   origState;
					STRING5   origZip5;
					STRING9   origFEIN;
					STRING10  origPhone10;	
					STRING120 CompanyName;
					STRING120 AltCompanyName;
					STRING120 StreetAddress;
					STRING25  City;
					STRING2   State;
					STRING5   Zip5;
					STRING4   Zip4;
					STRING25  County;
					STRING9   FEIN;
					STRING10  Phone10;		
					UNSIGNED3 NameScore;
					UNSIGNED3 AddrScore;
					UNSIGNED3 CityScore;
					UNSIGNED3 StateScore;
					UNSIGNED3 Zip5Score;
					UNSIGNED3 TINScore;
					UNSIGNED3 PhoneScore;
				END;
				
				// Function aliases. Turns out, Risk_Indicators.AddrScore.zip_score just does some generic string-compares.
				fn_StateScore  := Risk_Indicators.AddrScore.zip_score;
				fn_Zip5Score   := Risk_Indicators.AddrScore.zip_score;

				// Slim down the Business Header records to only what's needed for Verify Echo calculations,
				// and then DEDUP for efficiency.
				ds_BusinessHeaderSlim :=
					TABLE( ds_BusinessHeader, {uniqueid, company_name, prim_range, predir, prim_name, addr_suffix, postdir, unit_desig, sec_range, p_city_name, v_city_name, st, zip, zip4, fips_county, company_fein, company_phone} );

				ds_BusinessHeaderSlimDeduped := DEDUP( ds_BusinessHeaderSlim, RECORD, ALL, HASH );

				// Okay, let's do some matching. The Company and Address data in the layout below
				// are from the matching key record. Seq is from the input record.				
				layout_temp xfm_ScoreTheData( ds_OriginalInput le, ds_BusinessHeaderSlimDeduped ri ) :=
					TRANSFORM
						// NOTE: except for the company name, we're making no effort at this point to improve
						// efficiency by doing first character comparisons to short-circuit fuzzy matching, as 
						// in Business_Risk_BIP.getBusinessHeader( ).
						
						inp_city  := STD.Str.ToUpperCase(TRIM(le.City));
						p_city    := STD.Str.ToUpperCase(TRIM(ri.p_city_name));
						v_city    := STD.Str.ToUpperCase(TRIM(ri.v_city_name));
	
						// Company Name
						NamePopulated      := le.CompanyName <> '' AND ri.Company_Name <> '';
						NameMatchedExactly := NamePopulated AND (TRIM(le.CompanyName) = TRIM(ri.Company_Name));
						NameScore_pre      := Business_Risk.CNameScore(le.CompanyName, ri.Company_Name);
						NameMatched        := NamePopulated AND le.CompanyName[1] = ri.Company_Name[1] AND Risk_Indicators.iid_constants.g(NameScore_pre);
						NameScore          := IF( NameMatchedExactly, 200, NameScore_pre );					
						
						// Company City, State, Zip5, Zip4, County, and Address.						
						CityPopulated := inp_city != '' AND (p_city != '' OR v_city != '');
						
						// Calculate the City score against both the p_city_name and v_city_name; choose the greater.
						// NOTE: ut.StringSimilar100 --> lower value is a better match
						P_CityScore := 100 - MIN(ut.StringSimilar100(inp_city, p_city), ut.StringSimilar100(p_city, inp_city));
						V_CityScore := 100 - MIN(ut.StringSimilar100(inp_city, v_city), ut.StringSimilar100(v_city, inp_city));
						CityScore   := IF( CityPopulated, MAX(P_CityScore,V_CityScore), Risk_Indicators.iid_constants.default_empty_score );
						CityMatched := Risk_Indicators.iid_constants.ga( CityScore );
						use_V_City  := V_CityScore > P_CityScore;
								
						StateScore := fn_StateScore( le.State, ri.st );
						StateMatched := StateScore = 100;
						
						CityStateScore := 
								MAP(
									CityScore = Risk_Indicators.iid_constants.default_empty_score OR 
									StateScore = Risk_Indicators.iid_constants.default_empty_score  => Risk_Indicators.iid_constants.default_empty_score,
									CityScore BETWEEN 80 AND 100 AND StateMatched  => 100,    
									0 
								);
						
						Zip5Score := fn_Zip5Score( le.Zip, ri.Zip );
						Zip5Matched := Zip5Score = 100;
						
						// Calculate Address score; a bit more work.
						CleanAddr := Risk_Indicators.MOD_AddressClean.clean_addr(le.StreetAddress1, inp_city, le.State, le.Zip, le.StreetAddress2);											
						cln := Address.CleanFields(CleanAddr);

						AddressPopulated := (le.StreetAddress1 <> '' OR le.StreetAddress2 <> '') AND ri.prim_name <> '';
						AddressScore := 
								IF(
										Zip5Score = Risk_Indicators.iid_constants.default_empty_score AND CityStateScore = Risk_Indicators.iid_constants.default_empty_score, 
										Risk_Indicators.iid_constants.default_empty_score, 
										Risk_Indicators.AddrScore.AddressScore(cln.Prim_Range, cln.Prim_Name, cln.Sec_Range, ri.prim_range, ri.prim_name, ri.sec_range, Zip5Score, CityStateScore)
									);
						AddressMatched := AddressPopulated AND Risk_Indicators.iid_constants.ga( AddressScore );

						// Company TIN (use only the input FEIN).			
						TINPopulated := le.FEIN != '' AND ri.company_fein != '';
						TINScore     := DID_Add.SSN_Match_Score( ri.company_fein, le.FEIN, LENGTH(TRIM(le.FEIN)) = 4 );
						TINMatched   := TINPopulated AND le.FEIN[1] = ri.company_fein[1] AND Risk_Indicators.iid_constants.gn( TINScore );

						// Company Phone (use only the Business Phone).		
						PhonePopulated := le.Phone10 != '' AND ri.Company_Phone != '';
						PhoneScore     := Risk_Indicators.PhoneScore( ri.Company_Phone, le.Phone10 );
						PhoneMatched   := PhonePopulated AND (le.Phone10[1] = ri.Company_Phone[1] OR le.Phone10[4] = ri.Company_Phone[4] OR le.Phone10[4] = ri.Company_Phone[1]) AND Risk_Indicators.iid_constants.gn( PhoneScore );
						
						// Begin transform...:
						SELF.Seq               := le.Seq;
						SELF.origCompanyName   := le.CompanyName;						
						SELF.origStreetAddress := le.StreetAddress1 + IF( le.StreetAddress2 != '', ' ' + le.StreetAddress2, '' );
						SELF.origCity          := le.City;
						SELF.origState         := le.State;
						SELF.origZip5          := le.zip;
						SELF.origFEIN          := le.FEIN;
						SELF.origPhone10       := le.Phone10;	
						SELF.CompanyName       := IF( NameMatched, STD.Str.ToUpperCase(ri.Company_Name), '' );
						
						SELF.StreetAddress     := IF( AddressMatched, STD.Str.ToUpperCase(Risk_Indicators.MOD_AddressClean.street_address( '', ri.prim_range, ri.predir, ri.prim_name, ri.addr_suffix, ri.postdir, ri.unit_desig, ri.sec_range)), '' );
						SELF.City              := IF( CityMatched, STD.Str.ToUpperCase(IF( use_V_City, v_city, p_city )), '' );
						SELF.State             := IF( StateMatched, STD.Str.ToUpperCase(ri.st), '' );
						SELF.Zip5              := IF( Zip5Matched, ri.Zip, '' );
						SELF.FEIN              := IF( TINMatched, ri.company_fein, '' );
						SELF.Phone10           := IF( PhoneMatched, ri.company_phone, '' );		
						SELF.NameScore         := IF( NameScore    != Risk_Indicators.iid_constants.default_empty_score, NameScore   , 0 );					
						SELF.AddrScore         := IF( AddressScore != Risk_Indicators.iid_constants.default_empty_score, AddressScore, 0 );
						SELF.CityScore         := IF( CityScore    != Risk_Indicators.iid_constants.default_empty_score, CityScore   , 0 );
						SELF.StateScore        := IF( StateScore   != Risk_Indicators.iid_constants.default_empty_score, StateScore  , 0 );
						SELF.Zip5Score         := IF( Zip5Score    != Risk_Indicators.iid_constants.default_empty_score, Zip5Score   , 0 );
						SELF.TINScore          := IF( TINScore     != Risk_Indicators.iid_constants.default_empty_score, TINScore    , 0 );
						SELF.PhoneScore        := IF( PhoneScore   != Risk_Indicators.iid_constants.default_empty_score, PhoneScore  , 0 );
						SELF := [];
					END;
					
				ds_Matching :=
					JOIN(
						ds_OriginalInput, ds_BusinessHeaderSlimDeduped,
						LEFT.Seq = RIGHT.uniqueid,
						xfm_ScoreTheData(LEFT,RIGHT),
						LEFT OUTER
					);

				layout_temp xfm_RollTheScores( layout_temp le, layout_temp ri ) :=
					TRANSFORM
						SELF.Seq               := le.Seq;
						SELF.origCompanyName   := le.origCompanyName;						
						SELF.origStreetAddress := le.origStreetAddress;
						SELF.origCity          := le.origCity;
						SELF.origState         := le.origState;
						SELF.origZip5          := le.origZip5;
						SELF.origFEIN          := le.origFEIN;
						SELF.origPhone10       := le.origPhone10;	
						SELF.CompanyName       := IF( le.NameScore    > ri.NameScore   , le.CompanyName   , ri.CompanyName );						
						SELF.StreetAddress     := IF( le.AddrScore    > ri.AddrScore   , le.StreetAddress , ri.StreetAddress );
						SELF.City              := IF( le.CityScore    > ri.CityScore   , le.City          , ri.City );
						SELF.State             := IF( le.StateScore   > ri.StateScore  , le.State         , ri.State );
						SELF.Zip5              := IF( le.Zip5Score    > ri.Zip5Score   , le.Zip5          , ri.Zip5 );
						SELF.FEIN              := IF( le.TINScore     > ri.TINScore    , le.FEIN          , ri.FEIN );
						SELF.Phone10           := IF( le.PhoneScore   > ri.PhoneScore  , le.Phone10       , ri.Phone10 );	
						SELF.NameScore         := IF( le.NameScore    > ri.NameScore   , le.NameScore     , ri.NameScore );						
						SELF.AddrScore         := IF( le.AddrScore    > ri.AddrScore   , le.AddrScore     , ri.AddrScore );
						SELF.CityScore         := IF( le.CityScore    > ri.CityScore   , le.CityScore     , ri.CityScore );
						SELF.StateScore        := IF( le.StateScore   > ri.StateScore  , le.StateScore    , ri.StateScore );
						SELF.Zip5Score         := IF( le.Zip5Score    > ri.Zip5Score   , le.Zip5Score     , ri.Zip5Score );
						SELF.TINScore          := IF( le.TINScore     > ri.TINScore    , le.TINScore      , ri.TINScore );
						SELF.PhoneScore        := IF( le.PhoneScore   > ri.PhoneScore  , le.PhoneScore    , ri.PhoneScore );
						SELF := [];
					END;

				ds_MatchingRolled :=
					ROLLUP(
						ds_Matching,
						LEFT.Seq = RIGHT.Seq,
						xfm_RollTheScores(LEFT,RIGHT)
					);
				
				// DEBUGs...:
				// OUTPUT( ds_OriginalInput, NAMED('__OriginalInput') );
				// OUTPUT( ds_BusinessHeaderSlimDeduped, NAMED('BusinessHeaderSlimDeduped') );
				// OUTPUT( ds_Matching, NAMED('Matching') );
				// OUTPUT( ds_MatchingRolled, NAMED('MatchingRolled') );
				// OUTPUT( ds_MatchingWithShellData, NAMED('MatchingWithShellData') );
				
				RETURN ds_MatchingRolled; 
		END;		
  
END; // end of Functions module