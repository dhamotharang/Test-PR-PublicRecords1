IMPORT Address, BIPV2, BIPV2_Best, BIPV2_Best_SBFE,  Business_Credit, BusinessCredit_Services, Doxie, iesp, ut, std, suppress;

EXPORT fn_getOwnersGuarantors (	BusinessCredit_Services.Iparam.reportrecords inmod, 
																DATASET(doxie.layout_references) ds_individualOwnerOnlyDids,
																boolean buzCreditAccess = FALSE
																) := FUNCTION

  mod_access := MODULE (doxie.functions.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule()))
    EXPORT unsigned1 glb := inmod.glbpurpose;
    EXPORT unsigned1 dppa := inmod.dppapurpose;
    EXPORT string DataPermissionMask := inmod.DataPermissionMask;
    EXPORT string DataRestrictionMask := inmod.DataRestrictionMask;
    EXPORT string32 application_type := inmod.ApplicationType;
    EXPORT string ssn_mask := inmod.ssnmask;
		//TODO: the input is not supposed to include untranslated value for dob-mask
    EXPORT unsigned1 dob_mask := suppress.date_mask_math.MaskIndicator (inmod.dobmask);
  END;

	OwnrGuarRecs_raw 	:= Business_Credit.Key_TradelineGuarantor().kFetch2(inmod.BusinessIds, inmod.FetchLevel,,inmod.DataPermissionMask, BusinessCredit_Services.Constants.JOIN_LIMIT);

	BIPV2.IDlayouts.l_xlink_ids2 trans(BIPV2.IDlayouts.l_xlink_ids R) := TRANSFORM
		SELF := R;
	END;
	
	OwnrGuarRecs_raw_AB_recs			:= 	OwnrGuarRecs_raw(record_type = Business_Credit.Constants().AccountBase);
	ds_BusOwnrGuarRecs_raw_slim		:= 	NORMALIZE(OwnrGuarRecs_raw_AB_recs ,LEFT.businessownerlinkids,trans(RIGHT))(UltID > 0, OrgID > 0, SeleID > 0);
	ds_BusOwnrGuarRecs_slim_dedup	:=	DEDUP(SORT(ds_BusOwnrGuarRecs_raw_slim,  
																					#EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids())),  
																		#EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()));

	ds_busOwnerGuarRecs_raw	:= Business_Credit.Key_BusinessOwnerInformation().Kfetch2(ds_BusOwnrGuarRecs_slim_dedup, inmod.FetchLevel,,inmod.DataPermissionMask, , BusinessCredit_Services.Constants.JOIN_LIMIT);

	ds_busOwnerGuarLinkID	:= PROJECT(ds_BusOwnrGuarRecs_slim_dedup ,
														TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2,
															SELF.UltID 	:= LEFT.UltID,
															SELF.OrgID 	:= LEFT.OrgID,
															SELF.SeleID := LEFT.SeleID,
															SELF := []));
	//bip best
	busOwnerGuarRecs_Best 	 		:= BIPV2_Best.Key_LinkIds.Kfetch2(ds_busOwnerGuarLinkID, inmod.FetchLevel,,,false,BusinessCredit_Services.Constants.BestKfetchMaxLimit)(proxid = 0);
	busOwnerGuarRecs_Best_proj	:= PROJECT(busOwnerGuarRecs_Best, TRANSFORM(BIPV2_Best.layouts.key, 
																																		SELF := LEFT,
																																		SELF := []));

	//SBFE bip best
	busOwnerGuarRecs_sbfe_Best			:= BIPV2_Best_SBFE.Key_LinkIds().Kfetch2(ds_busOwnerGuarLinkID, inmod.FetchLevel,,inmod.DataPermissionMask,BusinessCredit_Services.Constants.JOIN_LIMIT)(proxid = 0);
	busOwnerGuarRecs_sbfe_Best_proj	:= PROJECT(busOwnerGuarRecs_sbfe_Best, TRANSFORM(BIPV2_Best.layouts.key, 
																																						SELF := LEFT,
																																						SELF := []));
											
	best_rec := IF(EXISTS(busOwnerGuarRecs_Best_proj), busOwnerGuarRecs_Best_proj, busOwnerGuarRecs_sbfe_Best_proj);
												
	iesp.businesscreditreport.t_BusinessCreditOwnerGuarantor trans_preFinalBus(best_rec L , ds_busOwnerGuarRecs_raw R) := TRANSFORM
    addr := L.company_address[1];
    street_addr := Address.Addr1FromComponents(addr.company_prim_range, addr.company_predir, addr.company_prim_name, addr.company_addr_suffix,
                                                  addr.company_postdir, addr.company_unit_desig, addr.company_sec_range);
    csz := Address.Addr2FromComponents(addr.address_v_city_name, addr.company_st, addr.company_zip5);
    
		SELF.BusinessIds.UltID 			:=  L.UltID;
		SELF.BusinessIds.OrgID 			:=  L.OrgID;
		SELF.BusinessIds.SeleID 		:=  L.SeleID;
		SELF.EntityType							:=	'Business';		
		SELF.EntityName.CompanyName	:=  L.Company_Name[1].Company_Name;
		SELF.EntityAddress					:=  iesp.ECL2ESP.SetAddress(L.company_address[1].company_prim_name, L.company_address[1].company_prim_range, L.company_address[1].company_predir, 
																														L.company_address[1].company_postdir, L.company_address[1].company_addr_suffix, L.company_address[1].company_unit_desig, 
																														L.company_address[1].company_sec_range,L.company_address[1].company_p_city_name,L.company_address[1].company_st, 
																														L.company_address[1].company_zip5, L.company_address[1].company_zip4, '', '', street_addr, '', csz);
		SELF.OwnerGuarantorIndicator:=	BusinessCredit_Services.Functions.fn_OwnerGuarnIndicator(R.Guarantor_Owner_Indicator);
		SELF.OwnershipPercent				:=	IF((integer)R.Percent_Of_Ownership_If_Owner_Principal >0, R.Percent_Of_Ownership_If_Owner_Principal, '');
		SELF.BusinessCreditIndicator:=	BusinessCredit_Services.Functions.fn_BuzCreditIndicator(L.UltId, 
																																														L.OrgID,
																																														L.SeleID,
																																														inmod.DataPermissionMask,
																																														buzCreditAccess);
		SELF := [];		
	END;

	busOwnrGuarRecs_PreFinal_temp:= JOIN(	best_rec , ds_busOwnerGuarRecs_raw ,
																				BIPV2.IDmacros.mac_JoinTop3Linkids(),
																				trans_preFinalBus(LEFT, RIGHT));
																		
	busOwnrGuarRecs_PreFinal := DEDUP(SORT(busOwnrGuarRecs_PreFinal_temp ,BusinessIds.UltID, BusinessIds.Orgid , BusinessIds.Seleid, OwnerGuarantorIndicator, -OwnershipPercent),
																	BusinessIds.UltID, BusinessIds.Orgid , BusinessIds.Seleid, OwnerGuarantorIndicator);

	//INDIVIDUAL:
	OwnrGuarRecs_raw_IS_recs		:= OwnrGuarRecs_raw(Record_Type = Business_Credit.Constants().IndividualOwner AND DID > 0);
	ds_IndOwnrGuarRecs_raw_slim	:= PROJECT(OwnrGuarRecs_raw_IS_recs, Doxie.layout_references);
	ds_combIndOwnrRecs					:= ds_IndOwnrGuarRecs_raw_slim + ds_individualOwnerOnlyDids;
	ds_IndOwnrGuarRecs_raw_dedup:= DEDUP(SORT(ds_combIndOwnrRecs, DID), DID);
	ds_IndOwnerGuarRecs_raw			:= JOIN(ds_IndOwnrGuarRecs_raw_dedup , Business_Credit.Key_IndividualOwnerInformation(),
																			KEYED(LEFT.DID = RIGHT.DID),
																			TRANSFORM(RIGHT) , 
																			LIMIT(BusinessCredit_Services.Constants.JOIN_LIMIT, SKIP));

	ds_IndOwnerGuar_Best 	:= IF(EXISTS(ds_IndOwnrGuarRecs_raw_dedup), doxie.best_records(ds_IndOwnrGuarRecs_raw_dedup, modAccess := mod_access));

	iesp.businesscreditreport.t_BusinessCreditOwnerGuarantor trans_preFinalIndi(ds_IndOwnerGuarRecs_raw L , doxie.layout_best R) := TRANSFORM
    street_addr := Address.Addr1FromComponents(R.prim_range, R.predir, R.prim_name, R.suffix,
                                                R.postdir, R.unit_desig, R.sec_range);
    csz := Address.Addr2FromComponents(R.city_name, R.st, R.zip);
    
		SELF.UniqueId					 			:=  (string)L.DID;
		SELF.EntityType							:=	'Person';
		SELF.EntityName.First				:=  R.fname;
		SELF.EntityName.Middle			:=  R.mname;
		SELF.EntityName.Last				:=  R.lname;
		SELF.EntityName.Suffix			:=  R.name_suffix;
		SELF.EntityAddress					:=  iesp.ECL2ESP.SetAddress(R.prim_name, R.prim_range, R.predir,R.postdir, R.suffix, R.unit_desig, 
																														R.sec_range,R.city_name,R.st, R.zip, R.zip4, '', '', street_addr, '', csz);
		SELF.OwnerGuarantorIndicator:=	BusinessCredit_Services.Functions.fn_OwnerGuarnIndicator(L.Guarantor_Owner_Indicator);
		SELF.OwnershipPercent				:=	IF((integer)L.Percent_Of_Ownership >0, L.Percent_Of_Ownership, '');
		SELF := [];		
	END;

	indOwnrGuarRecs_PreFinal_temp	:= 	JOIN(	ds_IndOwnerGuarRecs_raw, ds_IndOwnerGuar_Best,
																					LEFT.DID = RIGHT.DID,
																					trans_preFinalIndi(LEFT , RIGHT));

	indOwnrGuarRecs_PreFinal := DEDUP(SORT(indOwnrGuarRecs_PreFinal_temp, UniqueId, OwnerGuarantorIndicator , -OwnershipPercent), UniqueId, OwnerGuarantorIndicator);

	Prefinal_recs := busOwnrGuarRecs_PreFinal + indOwnrGuarRecs_PreFinal;

	// Requirement 1.4.10
	// Entity X is listed as an owner and can be a person or a business..
	x_owners := Prefinal_recs(OwnerGuarantorIndicator IN ['Owner' , 'Both']);

	x_owners_linkids := PROJECT(x_owners(BusinessIds.UltID > 0, BusinessIds.OrgID > 0, BusinessIds.SeleID > 0),
																TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2,
																	SELF.UltID 	:= LEFT.BusinessIds.UltID,
																	SELF.OrgID 	:= LEFT.BusinessIds.OrgID,
																	SELF.SeleID := LEFT.BusinessIds.SeleID,
																	SELF := []));

	x_owners_linkids_dedup 	:= DEDUP(SORT(x_owners_linkids, 
																	 #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids())), 
														 #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()));
														 
	x_owners_dids_temp 			:= PROJECT(x_owners((unsigned6)UniqueId > 0), TRANSFORM(Doxie.layout_references, SELF.DID := (unsigned6)LEFT.UniqueId));
	x_owners_dids 					:= DEDUP(SORT(x_owners_dids_temp,did), did);

	// -------------------------------------------------------------------- Starting the Y Calculation --------------------------------------------------------------------
	// ----- Entity Y is owned by Entity X and must be listed as a guarantor in SBFE 

	y_bus_owner 				:=	Business_Credit.Key_BusinessOwnerInformation().Kfetch2(x_owners_linkids_dedup, inmod.FetchLevel,,inmod.DataPermissionMask, BusinessCredit_Services.Constants.JOIN_LIMIT)(Guarantor_Owner_Indicator IN ['001' , '003']);
	y_bus_owner_Dedup 	:= 	DEDUP(SORT(y_bus_owner , 
																#EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()), #EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts())),
													#EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()), #EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts()));

	y_individual_owner 	:= JOIN(x_owners_dids, Business_Credit.Key_IndividualOwnerInformation(),
															KEYED(LEFT.DID = RIGHT.DID), 
															TRANSFORM(RIGHT), 
															LIMIT(BusinessCredit_Services.Constants.JOIN_LIMIT, SKIP))(Guarantor_Owner_Indicator IN ['001' , '003']);

	y_individual_owner_dedup 	:= DEDUP(SORT(y_individual_owner, 
																		 DID, #EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts())),
															 DID, #EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts()));
	
	y_slim_rec := RECORD
		UNSIGNED6 UltID;
		UNSIGNED6 OrgID;
		UNSIGNED6 SeleID;
		STRING30 Sbfe_Contributor_Number;
		STRING50 Contract_Account_Number;
		STRING3 Account_Type_Reported;
		Unsigned6 did := 0;
	END;

	y_linkids_accno 	:= PROJECT(y_bus_owner_Dedup , y_slim_rec) + PROJECT(y_individual_owner_dedup , y_slim_rec);
														
	y_trades := JOIN(	y_linkids_accno , Business_Credit.key_tradeline(),
										BusinessCredit_Services.Macros.mac_JoinBusAccounts(),
										LIMIT(BusinessCredit_Services.Constants.KFETCH_MAX_LIMIT, SKIP));
													
	y_trades_dedup := DEDUP(SORT(y_trades , 
													#EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()), #EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts()) , -cycle_end_date), 
										#EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()), #EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts()));

	y_trades_HistoryRecs := DEDUP(SORT(y_trades , 
																#EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()), #EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts()) , -cycle_end_date),
													cycle_end_date);
	
	y_trades_HistoryRecsFiltered := y_trades_HistoryRecs(Cycle_end_date >= ut.getDateOffset(BusinessCredit_Services.Constants.PAST24MONTHSInDays) and Cycle_end_date < ((STRING8)Std.Date.Today())[1..6]);

	iesp.businesscreditreport.t_BusinessCreditAccountPaymentHistory trans_y_paymenthistory (y_trades_HistoryRecs L ) := TRANSFORM

		paymentStatus := BusinessCredit_Services.Functions.fn_WorstStatus(L.Date_Account_Closed, L.Account_Closure_Basis, L.Account_Status_1, L.Account_Status_2, L.Payment_Status_Category);													

		SELF.ReportedDate				:= iesp.ECL2ESP.toDatestring8(L.Cycle_End_Date);
		SELF.ClosureDate				:= iesp.ECL2ESP.toDatestring8(L.Date_Account_Closed);
		SELF.ClosureReason			:= BusinessCredit_Services.Functions.fn_AccountClosureReason(L.Account_Closure_Basis);
		SELF.CurrentCreditLimit	:= L.Current_Credit_Limit;
		SELF.AmountOutstanding	:= L.Remaining_Balance;
		SELF.PaymentStatus			:= paymentStatus;
		SELF.PastDueAmount			:= L.Past_Due_Amount;
		SELF 										:= [];
	END;

	y_AccDetail_temp  := RECORD
		unsigned6 X_DID 	:= 0;
		iesp.businesscreditreport.t_BusinessCreditAccountDetails AccountDetails;
	END;

	 y_AccDetail_temp trans_y_AccDetail (y_trades_dedup L) := TRANSFORM
		PaymentStatusCategory 												:= 	BusinessCredit_Services.Functions.fn_PaymentStatusCategory(L.Payment_Status_Category);
		
		SELF.X_DID																		:=	L.DID;
		SELF.AccountDetails.BusinessIds.UltID					:=  L.UltID;
		SELF.AccountDetails.BusinessIds.OrgID					:=  L.OrgID;
		SELF.AccountDetails.BusinessIds.SeleID				:=  L.SeleID;
		SELF.AccountDetails.CompanyName								:=	L.Account_Holder_Business_Name;
		SELF.AccountDetails.BusinessContributorNumber	:= 	L.Sbfe_Contributor_Number;
		SELF.AccountDetails.BusinessAccountNumber			:= 	L.Contract_Account_Number;
		SELF.AccountDetails.AccountTypeReportedCode		:= 	L.Account_Type_Reported;
		SELF.AccountDetails.AccountTypeReportedDesc		:=	BusinessCredit_Services.Functions.fn_AccountTypeDescription(L.Account_Type_Reported);
		SELF.AccountDetails.AccountStatus					 		:=	BusinessCredit_Services.Functions.fn_CurrentAccountStatus(L.Date_Account_Closed , L.Payment_Status_Category);
		SELF.AccountDetails.AccountOpenDate						:= 	iesp.ECL2ESP.toDatestring8(L.Date_Account_Opened);
		SELF.AccountDetails.OriginalAmount						:= 	L.Original_Credit_Limit;
		SELF.AccountDetails.AmountOutstanding					:= 	L.Remaining_Balance;
		SELF.AccountDetails.Overdue										:= 	IF(L.Payment_Status_Category = '000' , 'No' , PaymentStatusCategory);
		SELF.AccountDetails.PastDueAmount							:=	L.Past_Due_Amount;
		SELF.AccountDetails.BusinessCreditIndicator		:=	BusinessCredit_Services.Functions.fn_BuzCreditIndicator(L.UltId, 
																																																							L.OrgID,
																																																							L.SeleID,
																																																							inmod.DataPermissionMask,
																																																							buzCreditAccess);
		SELF.AccountDetails.AccountPaymentHistory			:= 	CHOOSEN(PROJECT(y_trades_HistoryRecsFiltered (Sbfe_Contributor_Number = L.Sbfe_Contributor_Number AND 
																																																		Contract_Account_Number = L.Contract_Account_Number AND
																																																		Account_Type_Reported		= L.Account_Type_Reported) ,
																																																		trans_y_paymenthistory(LEFT)), BusinessCredit_Services.Constants.MAX_PAYMENT_HISTORY);
		SELF := [];
	END;

	y_AccDetail_Recs := PROJECT(y_trades_dedup , trans_y_AccDetail(LEFT));

	iesp.businesscreditreport.t_BusinessCreditOwnerGuarantor DenormThem (iesp.businesscreditreport.t_BusinessCreditOwnerGuarantor L, y_AccDetail_temp R) := TRANSFORM
		SELF.AccountDetails := SORT(L.AccountDetails + R.AccountDetails, BusinessCredit_Services.Functions.fn_AccountStatus_sort_order(AccountStatus), RECORD);
		SELF := L;
	END;

	final_recs_person := DENORMALIZE(indOwnrGuarRecs_PreFinal , y_AccDetail_Recs,
																			LEFT.UniqueId = (string)RIGHT.X_DID AND 
																			LEFT.OwnerGuarantorIndicator IN ['Owner', 'Both'],
																			DenormThem(LEFT, RIGHT));

	final_recs_business := DENORMALIZE(busOwnrGuarRecs_PreFinal , y_AccDetail_Recs,
																			LEFT.BusinessIds.UltID = RIGHT.AccountDetails.BusinessIds.UltID AND 
																			LEFT.BusinessIds.OrgID = RIGHT.AccountDetails.BusinessIds.OrgID AND 
																			LEFT.BusinessIds.SeleID = RIGHT.AccountDetails.BusinessIds.SeleID AND
																			LEFT.OwnerGuarantorIndicator IN ['Owner', 'Both'],
																			DenormThem(LEFT, RIGHT));
																			
	final_recs_y := final_recs_person + final_recs_business;
	// -------------------------------------------------------------------- Starting the Z Calculation ----------------------------------------------------------------------
	// Entity Z is SBFE account where Entity Y is the guarantor..
	
	z_guarantors_linkids := PROJECT(y_linkids_accno,
														TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2,
															SELF.UltID 	:= LEFT.UltID,
															SELF.OrgID 	:= LEFT.OrgID,
															SELF.SeleID := LEFT.SeleID,
															SELF := []));
															
	z_guarantors_linkids_dedup := DEDUP(SORT(z_guarantors_linkids, 
																			#EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids())), 
																#EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()));
																
	z_guarantors_recs :=	Business_Credit.Key_BusinessOwnerInformation().Kfetch2(z_guarantors_linkids_dedup, inmod.FetchLevel,,inmod.DataPermissionMask, BusinessCredit_Services.Constants.JOIN_LIMIT)(Guarantor_Owner_Indicator IN ['002']);

	z_slim_rec := RECORD
		UNSIGNED6 UltID;
		UNSIGNED6 OrgID;
		UNSIGNED6 SeleID;
		STRING30 Sbfe_Contributor_Number;
		STRING50 Contract_Account_Number;
		STRING3 Account_Type_Reported;
	END;

	z_guarantors_recs_slim := JOIN (z_guarantors_recs, Business_Credit.Key_BusinessInformation(),
																			BusinessCredit_Services.Macros.mac_JoinBusAccounts() AND
																			RIGHT.Record_Type = Business_Credit.Constants().AccountBase,
																			TRANSFORM(z_slim_rec , SELF := RIGHT),
																			LIMIT(BusinessCredit_Services.Constants.JOIN_LIMIT, SKIP));

	Z_linkids_accno_dedup := DEDUP(SORT(z_guarantors_recs_slim , 
																 #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()), #EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts())), 
													 #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()), #EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts()));
														
	z_trades := JOIN(	Z_linkids_accno_dedup , Business_Credit.key_tradeline(),
										BusinessCredit_Services.Macros.mac_JoinBusAccounts(),
										LIMIT(BusinessCredit_Services.Constants.KFETCH_MAX_LIMIT, SKIP));
													
	z_trades_dedup := DEDUP(SORT(z_trades , 
													#EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()), #EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts()) , -cycle_end_date), 
										#EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()), #EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts()));

	z_trades_HistoryRecs := DEDUP(SORT(z_trades , UltID, OrgID, SeleID, #EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts()) , -cycle_end_date),
														cycle_end_date)(Cycle_end_date >= ut.getDateOffset(BusinessCredit_Services.Constants.PAST24MONTHSInDays) and Cycle_end_date < ((STRING8)Std.Date.Today())[1..6]);

	Z_AccDetail_temp  := RECORD
		iesp.businesscreditreport.t_BusinessCreditAccountDetails RelatedAccountDetails;
	END;

	iesp.businesscreditreport.t_BusinessCreditAccountPaymentHistory trans_z_paymenthistory (z_trades_HistoryRecs L) := TRANSFORM
		paymentStatus := BusinessCredit_Services.Functions.fn_WorstStatus(L.Date_Account_Closed, L.Account_Closure_Basis, L.Account_Status_1, L.Account_Status_2, L.Payment_Status_Category);

		SELF.ReportedDate				:= iesp.ECL2ESP.toDatestring8(L.Cycle_End_Date);
		SELF.ClosureDate				:= iesp.ECL2ESP.toDatestring8(L.Date_Account_Closed);
		SELF.ClosureReason			:= BusinessCredit_Services.Functions.fn_AccountClosureReason(L.Account_Closure_Basis);
		SELF.CurrentCreditLimit	:= L.Current_Credit_Limit;
		SELF.AmountOutstanding	:= L.Remaining_Balance;
		SELF.PaymentStatus			:= paymentStatus;
		SELF.PastDueAmount			:= L.Past_Due_Amount;
		SELF := [];
	END;

	Z_AccDetail_temp trans_z_AccDetail (z_trades_dedup L) := TRANSFORM
		PaymentStatusCategory 																:= 	BusinessCredit_Services.Functions.fn_PaymentStatusCategory(L.Payment_Status_Category);
		SELF.RelatedAccountDetails.BusinessIds.UltID					:=  L.UltID;
		SELF.RelatedAccountDetails.BusinessIds.OrgID					:=  L.OrgID;
		SELF.RelatedAccountDetails.BusinessIds.SeleID					:=  L.SeleID;
		SELF.RelatedAccountDetails.CompanyName								:=	L.Account_Holder_Business_Name;
		SELF.RelatedAccountDetails.BusinessContributorNumber	:= 	L.Sbfe_Contributor_Number;
		SELF.RelatedAccountDetails.BusinessAccountNumber			:= 	L.Contract_Account_Number;
		SELF.RelatedAccountDetails.AccountTypeReportedCode		:= 	L.Account_Type_Reported;
		SELF.RelatedAccountDetails.AccountTypeReportedDesc		:=	BusinessCredit_Services.Functions.fn_AccountTypeDescription(L.Account_Type_Reported);
		SELF.RelatedAccountDetails.AccountStatus					 		:=	BusinessCredit_Services.Functions.fn_CurrentAccountStatus(L.Date_Account_Closed , L.Payment_Status_Category);
		SELF.RelatedAccountDetails.AccountOpenDate						:= 	iesp.ECL2ESP.toDatestring8(L.Date_Account_Opened);
		SELF.RelatedAccountDetails.OriginalAmount							:= 	L.Original_Credit_Limit;
		SELF.RelatedAccountDetails.AmountOutstanding					:= 	L.Remaining_Balance;
		SELF.RelatedAccountDetails.Overdue										:= 	IF(L.Payment_Status_Category = '000' , 'No' , PaymentStatusCategory);
		SELF.RelatedAccountDetails.PastDueAmount							:=	L.Past_Due_Amount;
		SELF.RelatedAccountDetails.BusinessCreditIndicator		:=	BusinessCredit_Services.Functions.fn_BuzCreditIndicator(L.UltId, 
																																																											L.OrgID,
																																																											L.SeleID,
																																																											inmod.DataPermissionMask,
																																																											buzCreditAccess); 
		SELF.RelatedAccountDetails.AccountPaymentHistory			:= 	CHOOSEN(PROJECT(z_trades_HistoryRecs (Sbfe_Contributor_Number = L.Sbfe_Contributor_Number AND 
																																																		Contract_Account_Number = L.Contract_Account_Number AND
																																																		Account_Type_Reported   = L.Account_Type_Reported) ,
																																																		trans_z_paymenthistory(LEFT)), BusinessCredit_Services.Constants.MAX_PAYMENT_HISTORY);
		SELF := [];
	END;

	z_RelatedAccDetail_Recs 	:= PROJECT(z_trades_dedup , trans_z_AccDetail(LEFT));

	iesp.businesscreditreport.t_BusinessCreditOwnerGuarantor denorm_z (iesp.businesscreditreport.t_BusinessCreditOwnerGuarantor L, Z_AccDetail_temp R) := TRANSFORM
		SELF.RelatedAccountDetails := SORT(L.RelatedAccountDetails + R.RelatedAccountDetails, BusinessCredit_Services.Functions.fn_AccountStatus_sort_order(AccountStatus), RECORD);
		SELF := L;
	END;

	withZRecs :=	DENORMALIZE (final_recs_y, z_RelatedAccDetail_Recs, 
									LEFT.AccountDetails[1].BusinessIds.UltID = RIGHT.RelatedAccountDetails.BusinessIds.UltID AND
									LEFT.AccountDetails[1].BusinessIds.SeleID = RIGHT.RelatedAccountDetails.BusinessIds.SeleID AND
									LEFT.AccountDetails[1].BusinessIds.OrgID = RIGHT.RelatedAccountDetails.BusinessIds.OrgID AND
									LEFT.OwnerGuarantorIndicator IN ['Owner', 'Both'],
									denorm_z(LEFT, RIGHT));
	RETURN withZRecs;
END;