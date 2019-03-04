IMPORT Address, Business_Credit, BIPV2, BIPV2_Best, BIPV2_Best_SBFE, Codes, Doxie, DCAV2, iesp, TopBusiness_Services;

EXPORT fn_getBusiness_BestInformation (BusinessCredit_Services.Iparam.reportrecords inmod,
																				DATASET(BusinessCredit_Services.Layouts.TopBusinessRecord) topBusinessRecs,
																				DATASET(doxie.layout_best) AuthRepBestRec,
																				DATASET(BusinessCredit_Services.Layouts.buzCredit_AccNo_Slim)	buzCreditHeader_recs,
																				boolean buzCreditAccess = FALSE,
																				STRING8 BestCode
																			 ):= FUNCTION

    topBusiness_bestrecs_bip := PROJECT(topBusinessRecs, BusinessCredit_Services.Layouts.TopBusiness_BestSection)[1].BestSection;
    topBusiness_bestrecs_sbfe := IF(buzCreditAccess,
                                    BIPV2_Best_SBFE.Key_LinkIds().kFetch2(inmod.BusinessIds, inmod.FetchLevel, , inmod.DataPermissionMask,
                                                                          BusinessCredit_Services.Constants.KFETCH_MAX_LIMIT));
    
    iesp.topbusinessreport.t_TopBusinessBestSection tFormat2Best(RECORDOF(topBusiness_bestrecs_sbfe) pInput) :=
    TRANSFORM
      addr := pInput.company_address[1];
      business_ids := inmod.BusinessIds[1];
      
      street_addr := Address.Addr1FromComponents(addr.company_prim_range, addr.company_predir, addr.company_prim_name, addr.company_addr_suffix,
                                                  addr.company_postdir, addr.company_unit_desig, addr.company_sec_range);
      csz := Address.Addr2FromComponents(addr.address_v_city_name, addr.company_st, addr.company_zip5);
      
      is_sbfe_best_exists := EXISTS(topBusiness_bestrecs_sbfe);
      
      SELF.CompanyName        := pInput.company_name[1].company_name;
      SELF.Address            := iesp.ECL2ESP.SetAddress(addr.company_prim_name, addr.company_prim_range, addr.company_predir, addr.company_postdir,
                                                          addr.company_addr_suffix, addr.company_unit_desig, addr.company_sec_range, addr.address_v_city_name,
                                                          addr.company_st, addr.company_zip5, addr.company_zip4, addr.county_name, '',
                                                          street_addr, '', csz);
      SELF.PhoneInfo.Phone10  := pInput.company_phone[1].company_phone;
      SELF.Tin                := pInput.company_fein[1].company_fein;
      SELF.TinSource          := pInput.company_fein[1].sources[1].source;
      // Should I basically use business_ids instead of checking whether SBFE best exists since the search is being done based on LinkIds??
      SELF.BusinessIds.UltId  := IF(is_sbfe_best_exists, pInput.UltId, business_ids.UltId);
      SELF.BusinessIds.OrgId  := IF(is_sbfe_best_exists, pInput.OrgId, business_ids.OrgId);
      SELF.BusinessIds.SeleId := IF(is_sbfe_best_exists, pInput.SeleId, business_ids.SeleId);
      SELF.BusinessIds.ProxId := IF(is_sbfe_best_exists, pInput.ProxId, business_ids.ProxId);
      SELF.BusinessIds.PowId  := IF(is_sbfe_best_exists, pInput.PowId, business_ids.PowId);
      SELF.BusinessIds.EmpId  := IF(is_sbfe_best_exists, pInput.EmpId, business_ids.EmpId);
      SELF.BusinessIds.DotId  := IF(is_sbfe_best_exists, pInput.DotId, business_ids.DotId);
      SELF                    := [];
    END;
    
    topBusiness_bestrecs_sbfe_format := ROW(topBusiness_bestrecs_sbfe[1], tFormat2Best(LEFT));
    
    // RQ-12976 - If the record is an SBFE singleton, we want to show the best info from SBFE
		topBusiness_bestrecs := IF(topBusiness_bestrecs_bip.CompanyName != '', topBusiness_bestrecs_bip, topBusiness_bestrecs_sbfe_format);
    
		//getting LNCA/DCA records
		ds_lnca_keyrecs := DCAV2.Key_Linkids.kFetch2(inmod.BusinessIds, inmod.FetchLevel,,BusinessCredit_Services.Constants.KFETCH_MAX_LIMIT);
		ds_lnca_slimmed := PROJECT(ds_lnca_keyrecs, TRANSFORM(BusinessCredit_Services.Layouts.rec_lnca,
																														SELF.source_docid 				:= LEFT.rawfields.enterprise_num, 
																														SELF.annual_sales_amount	:= (INTEGER) LEFT.rawfields.sales,
																														SELF.employee_number 			:= LEFT.rawfields.emp_num,																														
																														SELF.update_date                             := LEFT.clean_dates.update_date,
																														SELF 											:= LEFT));
 
		tmpds_lnca_dedup 	:= DEDUP(SORT(ds_lnca_slimmed(annual_sales_amount != 0),
														 #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),source_docid ,-update_date, RECORD),
											 #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()),source_docid);
           ds_lnca_dedup := SORT(tmpds_lnca_dedup, -update_date);
											 
		AnnualIncome		:= ds_lnca_dedup[1].annual_sales_amount;
		noOfEmployees		:= ds_lnca_dedup[1].employee_number;
   
		//getting SOS active flag
		incorp_section	:= PROJECT(topBusinessRecs, TRANSFORM(iesp.topbusinessreport.t_TopBusinessIncorporationSection, SELF := LEFT.IncorporationSection));
		iesp.TopBusinessReport.t_TopBusinessIncorporationInfo corpChild(iesp.TopBusinessReport.t_TopBusinessIncorporationInfo R) := TRANSFORM
			SELF := R;
		END; 

		incorp_rec 			:= NORMALIZE(incorp_section,LEFT.CorpFilings,corpChild(RIGHT));
		corp_status_srt := SORT(incorp_rec  , -FilingDate, RECORD);
		corp_status			:= corp_status_srt[1].businessstatus;
			
		//getting ultimate ParentCompanyName
	
		// efficiency use parent section instead of hitting best again.
		ParentInfo := Project(topBusinessRecs,  TRANSFORM(iesp.businesscreditreport.t_BusinessCreditTopBusinessRecord,
		                                             SELF.ParentSection := LEFT.ParentSection;
                                                       SELF := []																								 
										));
								         			        										 								             
		ParentInfoCname := project(parentInfo[1].ParentSection, TRANSFORM(iesp.businesscreditreport.t_BusinessCreditParentSection,
		                                                        SELF.CompanyName := LEFT.CompanyName;
													self := []));	
          
		// information from sbfe
		buzCredit_tradeline := JOIN(buzCreditHeader_recs , Business_Credit.key_tradeline(), 
																BusinessCredit_Services.Macros.mac_JoinBusAccounts(),
																TRANSFORM(RIGHT), 
																LIMIT(BusinessCredit_Services.Constants.KFETCH_MAX_LIMIT, SKIP));

		trades_with_BusSt		:= buzCredit_tradeline(Legal_Business_Structure<>'');

		BusStructCount_Rec := RECORD
			trades_with_BusSt.Legal_Business_Structure;
			STRING8 	Date_Account_Opened := MAX(trades_with_BusSt.Date_Account_Opened);
			STRING8 	Cycle_End_Date 			:= MAX(trades_with_BusSt.Cycle_End_Date) ;
			INTEGER8	Record_Count 				:= COUNT(GROUP);
		END;

		tradeline_slim_tab 				:= TABLE(trades_with_BusSt, BusStructCount_Rec, trades_with_BusSt.Legal_Business_Structure);
		legal_Business_Structure 	:= SORT(tradeline_slim_tab, -Record_Count, -Date_Account_Opened, -Cycle_End_Date)[1].Legal_Business_Structure;
		business_structure_desc		:= BusinessCredit_Services.Functions.fn_BuzStructureDescription(legal_Business_Structure);

           IndustryCode := bestCode;		
		SIC_Desc		 :=	Codes.Key_SIC4(KEYED(SIC4_Code = IndustryCode))[1].sic4_description; 
		NAICS_Desc	 := Codes.Key_NAICS(KEYED(naics_code = IndustryCode))[1].naics_description;
		IndustryDesc :=	IF(SIC_Desc <> '' , SIC_Desc , NAICS_Desc);

		iesp.businesscreditreport.t_BusinessCreditBestInformation transform_t_BusinessCreditBestSection() := TRANSFORM
      street_addr := Address.Addr1FromComponents(AuthRepBestRec[1].prim_range, AuthRepBestRec[1].predir, AuthRepBestRec[1].prim_name, AuthRepBestRec[1].suffix,
                                                  AuthRepBestRec[1].postdir, AuthRepBestRec[1].unit_desig, AuthRepBestRec[1].sec_range);
      csz := Address.Addr2FromComponents(AuthRepBestRec[1].city_name, AuthRepBestRec[1].st, AuthRepBestRec[1].zip);
      
			SELF.BusinessIds 								:= topBusiness_bestrecs.BusinessIds;
			SELF.CompanyName 								:= topBusiness_bestrecs.CompanyName;
			SELF.CompanyAddress 						:= topBusiness_bestrecs.Address; 
			SELF.Tin 												:= topBusiness_bestrecs.Tin;
			SELF.TinSource									:= topBusiness_bestrecs.TinSource;
			SELF.CompanyPhone 							:= topBusiness_bestrecs.PhoneInfo.Phone10;
			SELF.UniqueId 									:= (string) AuthRepBestRec[1].did;
			SELF.AuthRepName 								:= iesp.ECL2ESP.setName(AuthRepBestRec[1].fname, AuthRepBestRec[1].mname, AuthRepBestRec[1].lname, AuthRepBestRec[1].name_suffix, AuthRepBestRec[1].title);
			SELF.AuthRepAddress 						:= iesp.ECL2ESP.SetAddress(AuthRepBestRec[1].prim_name, AuthRepBestRec[1].prim_range, AuthRepBestRec[1].predir, AuthRepBestRec[1].postdir,
																																 AuthRepBestRec[1].suffix, AuthRepBestRec[1].unit_desig, AuthRepBestRec[1].sec_range,AuthRepBestRec[1].city_name, 
																																 AuthRepBestRec[1].st, AuthRepBestRec[1].zip, AuthRepBestRec[1].zip4, '', '', street_addr, '', csz);
			SELF.AuthRepSSN 								:= AuthRepBestRec[1].ssn;
			SELF.AuthRepPhone 							:= AuthRepBestRec[1].phone;
			SELF.RecentTradeDate						:= IF(buzCreditAccess, iesp.ECL2ESP.toDatestring8(MAX(buzCredit_tradeline, buzCredit_tradeline.Date_Account_Opened)));
			SELF.EstablishedDate						:= IF(buzCreditAccess, iesp.ECL2ESP.toDatestring8(MIN(buzCredit_tradeline, buzCredit_tradeline.Business_Established_Date)));
			SELF.AnnualIncome 							:= (string) AnnualIncome;
			SELF.NoOfEmployees 							:= noOfEmployees;
			SELF.PrimaryIndustryCode				:= IndustryCode;
			SELF.PrimaryIndustryDescription := IndustryDesc;
			SELF.BusinessType								:= IF(buzCreditAccess, business_structure_desc, '');
			SELF.ParentCompanyName 					:=   ParentInfoCname.CompanyName; 
			SELF.sosActiveIndicator 				:= corp_status;
			SELF.BusinessCreditIndicator 		:= BusinessCredit_Services.Functions.fn_BuzCreditIndicator(	topBusiness_bestrecs.BusinessIds.UltID, 
																																																	topBusiness_bestrecs.BusinessIds.OrgID,
																																																	topBusiness_bestrecs.BusinessIds.SeleID,
																																																	inmod.DataPermissionMask,
																																																	buzCreditAccess);
		END;

		Business_BestInformation := DATASET([transform_t_BusinessCreditBestSection()]);
       // output(ParentInfoCname, named('ParentInfoCname'));
			 // output(parentCompany, named('parentCompany'));
			
		RETURN Business_BestInformation;
END;