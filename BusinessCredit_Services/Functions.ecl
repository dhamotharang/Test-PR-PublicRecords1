IMPORT Address, AutoStandardI, BIPV2, BIPV2_Best, Business_Credit, doxie, iesp, Risk_Indicators;

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
  
END; // end of Functions module