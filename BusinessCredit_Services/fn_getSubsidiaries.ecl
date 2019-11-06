﻿IMPORT BIPV2, BIPv2_HRCHY, BIPV2_Best,Business_Credit, BusinessCredit_Services, doxie, iesp, suppress;

EXPORT fn_getSubsidiaries (BusinessCredit_Services.Iparam.reportrecords inmod, boolean buzCreditAccess = FALSE,
                  dataset(recordof(Business_Credit.Key_BusinessOwnerInformation().Kfetch2(dataset([],BIPV2.IDlayouts.l_xlink_ids2)))) ownerInfokfetch ) := FUNCTION

  mod_access := 
    MODULE(doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule()))
      EXPORT STRING    DataPermissionMask := inmod.DataPermissionMask;
      EXPORT STRING	   DataRestrictionMask := inmod.DataRestrictionMask;
      EXPORT UNSIGNED1 unrestricted := (UNSIGNED1) inmod.AllowAll;
      EXPORT UNSIGNED1 glb := inmod.DPPAPurpose;
      EXPORT UNSIGNED1 dppa := inmod.GLBPurpose;
      EXPORT BOOLEAN   show_minors := inmod.IncludeMinors;
      EXPORT BOOLEAN   isPreGLBRestricted() := inmod.restrictPreGLB;
      EXPORT STRING    ssn_mask := inmod.ssnmask;
      EXPORT UNSIGNED1 dob_mask := suppress.date_mask_math.MaskIndicator (inmod.dobmask);    
      EXPORT STRING32  application_type := inmod.ApplicationType;
    END;
    
	subsidiaryRecs_raw   :=  ownerInfokfetch;
	subsidiaryRecs 			:= DEDUP(SORT(subsidiaryRecs_raw, #EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts()), Guarantor_Owner_Indicator),
																		#EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts()), Guarantor_Owner_Indicator);

	//append owner guarantor and bip parent indicator
	temp_rec := RECORD
		BIPV2.IDlayouts.l_xlink_ids; //Linkids of subsidiary business or bip childrens
		Boolean isOwner 			:= FALSE;
		Boolean isGuarantor 	:= FALSE;
		Boolean isParentinBIP	:= FALSE;
    UNSIGNED6 DID := 0;
    UNSIGNED4 global_sid := 0;
    UNSIGNED8 record_sid := 0;
	END;

	buzCredit_Subsidiary_Recs_Org	:=	JOIN (subsidiaryRecs, Business_Credit.Key_BusinessInformation(),
                                          BusinessCredit_Services.Macros.mac_JoinBusAccounts() AND
                                          RIGHT.Record_Type = Business_Credit.Constants().AccountBase,
                                          TRANSFORM(temp_rec ,
                                            SELF.isOwner 			:= LEFT.Guarantor_Owner_Indicator = '001' or LEFT.Guarantor_Owner_Indicator = '003',
                                            SELF.isGuarantor 	:= LEFT.Guarantor_Owner_Indicator = '002' or LEFT.Guarantor_Owner_Indicator = '003',
                                            SELF							:= RIGHT,
                                            SELF							:= []), 
                                          LIMIT(BusinessCredit_Services.Constants.JOIN_LIMIT, SKIP));
  buzCredit_Subsidiary_Recs := Suppress.MAC_SuppressSource(buzCredit_Subsidiary_Recs_org, mod_access, did);
  
	//getting the BIP Children
	bip_DirChilds_input :=	PROJECT(inmod.BusinessIds , {UNSIGNED6 seleid});
	bip_DirChilds 			:= 	PROJECT(BIPv2_HRCHY.FunctionsShow.ShowDirectParentsChildren(bip_DirChilds_input), 
																		TRANSFORM (BIPV2.IDlayouts.l_xlink_ids2,
																								SELF.SELEID := LEFT.Child_Seleid,
																								SELF := []));																	 
																		 
	bip_Children_Recs	:= PROJECT(bip_DirChilds , 
																TRANSFORM(temp_rec ,
																	SELF.SeleID := LEFT.SeleID, 
																	SELF.isParentinBIP := EXISTS(bip_DirChilds(SeleId > 0)), 
																	SELF := []));
																													
	comb_subsidiaries 			:= SORT(buzCredit_Subsidiary_Recs + bip_Children_Recs , seleid);

	temp_rec trans_rollup(temp_rec L , temp_rec R) := TRANSFORM
		SELF.isParentinBIP:= L.isParentinBIP OR R.isParentinBIP;
		SELF 							:= L;
	END;

	subsidiaries_rollup := ROLLUP(comb_subsidiaries , LEFT.Seleid = Right.Seleid, trans_rollup(LEFT, RIGHT));
	combined_linkids 		:= PROJECT(subsidiaries_rollup, 
																	TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2, 
																						 SELF.UltId 	:= LEFT.UltId;
																						 SELF.OrgID 	:= LEFT.OrgID;
																						 SELF.SeleID 	:= LEFT.SeleID;
																						 self := []));

	best_rec := BIPV2_Best.Key_LinkIds.Kfetch2(combined_linkids, inmod.FetchLevel,,,false,BusinessCredit_Services.Constants.BestKfetchMaxLimit)(proxid = 0);

	iesp.businesscreditreport.t_BusinessCreditSubsidiary final_trans(RECORDOF(best_rec) L , temp_rec R) := TRANSFORM
		SELF.BusinessIds.UltId 				:= L.UltId;
		SELF.BusinessIds.OrgID 				:= L.OrgID;
		SELF.BusinessIds.SeleID 			:= L.SeleID;
		SELF.CompanyName							:= L.company_name[1].company_name;
		SELF.RelationType							:= MAP(R.isGuarantor => 'Guaranteed Debt',
																				 R.isOwner OR R.isParentinBIP => 'Subsidiary',
																				 R.isGuarantor AND R.isOwner OR R.isParentinBIP => 'Guaranteed Debt & Subsidiary',
																				 '');
		SELF.BusinessCreditIndicator 	:= BusinessCredit_Services.Functions.fn_BuzCreditIndicator( L.UltId, 
																																															L.OrgID,
																																															L.SeleID,
																																															mod_access,
																																															buzCreditAccess);
		SELF := [];
	END;

	final_recs := JOIN(best_rec , subsidiaries_rollup, LEFT.SeleID = RIGHT.SeleID, final_trans(LEFT, RIGHT)); 
	return final_recs;
END;