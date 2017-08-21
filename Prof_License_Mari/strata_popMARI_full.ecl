import ut,strata,Prof_License_Mari;

EXPORT strata_popMARI_full(string pversion) := FUNCTION

	basefile := Prof_License_Mari.file_mari_search;
	indv_detail 	:= Prof_License_Mari.files_base.individual_detail;
	regulatory		:= Prof_License_Mari.files_base.regulatory_actions;
	disciplinary	:= Prof_License_Mari.files_base.disciplinary_actions;

rPopulationStats_Main :=  record	
	basefile.STD_SOURCE_UPD;
	basefile.LICENSE_STATE;
	basefile.STD_SOURCE_DESC; 
  CountGroup                                := count(group);
	MARI_RID																	:= sum(group,if(basefile.MARI_RID != 0,1,0));
	PRIMARY_KEY_CountNonBlank                 := sum(group,if(basefile.PRIMARY_KEY != 0,1,0));
  CREATE_DTE_CountNonBlank                  := sum(group,if(basefile.CREATE_DTE != '',1,0));
  LAST_UPD_DTE_CountNonBlank                := sum(group,if(basefile.LAST_UPD_DTE != '',1,0));
  STAMP_DTE_CountNonBlank                   := sum(group,if(basefile.STAMP_DTE != '',1,0));
	DATE_FIRST_SEEN														:= sum(group,if(basefile.DATE_FIRST_SEEN != '',1,0));
	DATE_LAST_SEEN														:= sum(group,if(basefile.DATE_LAST_SEEN != '',1,0));
	DATE_VENDOR_FIRST_REPORTED								:= sum(group,if(basefile.DATE_VENDOR_FIRST_REPORTED != '',1,0));
	DATE_VENDOR_LAST_REPORTED									:= sum(group,if(basefile.DATE_VENDOR_LAST_REPORTED != '',1,0));	
	PROCESS_DATE															:= sum(group,if(basefile.PROCESS_DATE != '',1,0));
	GEN_NBR_CountNonBlank                     := sum(group,if(basefile.GEN_NBR != '',1,0));
  STD_PROF_CD_CountNonBlank                 := sum(group,if(basefile.STD_PROF_CD != '',1,0));
	STD_PROF_DESC_CountNonBlank               := sum(group,if(basefile.STD_PROF_DESC != '',1,0));
	STD_SOURCE_DESC_CountNonBlank             := sum(group,if(basefile.STD_SOURCE_DESC != '',1,0));
  TYPE_CD_CountNonBlank                     := sum(group,if(basefile.TYPE_CD != '',1,0));
  NAME_ORG_PREFX_CountNonBlank              := sum(group,if(basefile.NAME_ORG_PREFX != '',1,0));
  NAME_ORG_CountNonBlank                    := sum(group,if(basefile.NAME_ORG != '',1,0));
  NAME_ORG_SUFX_CountNonBlank               := sum(group,if(basefile.NAME_ORG_SUFX!= '',1,0));
  STORE_NBR_CountNonBlank                   := sum(group,if(basefile.STORE_NBR != '',1,0));
  NAME_DBA_PREFX_CountNonBlank              := sum(group,if(basefile.NAME_DBA_PREFX != '',1,0));
  NAME_DBA_CountNonBlank                    := sum(group,if(basefile.NAME_DBA != '',1,0));
  NAME_DBA_SUFX_CountNonBlank               := sum(group,if(basefile.NAME_DBA_SUFX != '',1,0));
  STORE_NBR_DBA_CountNonBlank               := sum(group,if(basefile.STORE_NBR_DBA !='',1,0));
  DBA_FLAG_CountNonBlank                    := sum(group,if(basefile.DBA_FLAG != 0,1,0));
	NAME_OFFICE_CountNonBlank                 := sum(group,if(basefile.NAME_OFFICE != '',1,0));
  OFFICE_PARSE_CountNonBlank                := sum(group,if(basefile.OFFICE_PARSE != '',1,0));
	NAME_PREFX_CountNonBlank                  := sum(group,if(basefile.NAME_PREFX != '',1,0));
  NAME_FIRST_CountNonBlank                  := sum(group,if(basefile.NAME_FIRST != '',1,0));
  NAME_MID_CountNonBlank                    := sum(group,if(basefile.NAME_MID != '',1,0));
  NAME_LAST_CountNonBlank                   := sum(group,if(basefile.NAME_LAST != '',1,0));
  NAME_SUFX_CountNonBlank                   := sum(group,if(basefile.NAME_SUFX != '',1,0));
  NAME_NICK_CountNonBlank                   := sum(group,if(basefile.NAME_NICK != '',1,0));
  BIRTH_DTE_CountNonBlank                   := sum(group,if(basefile.BIRTH_DTE != '00000000' AND basefile.BIRTH_DTE != '',1,0));
  GENDER_CountNonBlank                      := sum(group,if(basefile.GENDER != '',1,0));
  PROV_STAT_CountNonBlank                   := sum(group,if(basefile.PROV_STAT != '',1,0));
  CREDENTIAL_CountNonBlank                  := sum(group,if(basefile.CREDENTIAL != '',1,0));
  LICENSE_NBR_CountNonBlank                 := sum(group,if(basefile.LICENSE_NBR != '',1,0));
  OFFICE_LICENSE_NBR_CountNonBlank          := sum(group,if(basefile.OFF_LICENSE_NBR != '',1,0));
	OFFICE_LIC_NBR_TYPE_CountNonBlank					:= sum(group,if(basefile.off_license_nbr_type != '',1,0));
	BROKER_LICENSE_NBR_CountNonBlank					:= sum(group,if(basefile.brkr_license_nbr != '',1,0));
	BROKER_LIC_NBR_TYPE_CountNonBlank					:= sum(group,if(basefile.brkr_license_nbr_type != '',1,0));
	RAW_LICENSE_TYPE													:= sum(group,if(basefile.RAW_LICENSE_TYPE != '',1,0));
	STD_LICENSE_TYPE_CountNonBlank            := sum(group,if(basefile.STD_LICENSE_TYPE != '',1,0));
	STD_LICENSE_DESC_CountNonBlank            := sum(group,if(basefile.STD_LICENSE_DESC != '',1,0));
	RAW_LICENSE_STATUS												:= sum(group,if(basefile.RAW_LICENSE_STATUS != '',1,0));
  STD_LICENSE_STATUS_CountNonBlank          := sum(group,if(basefile.STD_LICENSE_STATUS != '',1,0));
	STD_STATUS_DESC_CountNonBlank          		:= sum(group,if(basefile.STD_STATUS_DESC != '',1,0));
  CURR_ISS_DTE_CountNonBlank                := sum(group,if(basefile.CURR_ISSUE_DTE != '' and basefile.curr_issue_dte != '00000000',1,0));
  ORIG_ISSUE_DTE_CountNonBlank              := sum(group,if(basefile.ORIG_ISSUE_DTE != '' and basefile.orig_issue_dte != '00000000',1,0));
  EXPIRE_DTE_CountNonBlank                  := sum(group,if(basefile.EXPIRE_DTE != '' and basefile.expire_dte != '00000000',1,0));
	RENEWAL_DATE_CountNonBlank								:= sum(group,if(basefile.renewal_dte != '' and basefile.renewal_dte != '00000000',1,0));
  ACTIVE_FLAG_CountNonBlank                 := sum(group,if(basefile.ACTIVE_FLAG != '',1,0));
  SSN_TAXID_1_CountNonBlank                 := sum(group,if(basefile.SSN_TAXID_1 != '',1,0));
  TAX_TYPE_1_CountNonBlank                  := sum(group,if(basefile.TAX_TYPE_1 != '',1,0));
  SSN_TAXID_2_CountNonBlank                 := sum(group,if(basefile.SSN_TAXID_2 != '',1,0));
  TAX_TYPE_2_CountNonBlank                  := sum(group,if(basefile.TAX_TYPE_2 != '',1,0));
  FED_RSSD_CountNonBlank                    := sum(group,if(basefile.FED_RSSD !='',1,0));
  ADDR_BUS_IND_CountNonBlank           			:= sum(group,if(basefile.ADDR_BUS_IND != '',1,0));
	NAME_FORMAT_CountNonBlank									:= sum(group,if(basefile.NAME_FORMAT != '',1,0));
  NAME_ORG_ORIG_CountNonBlank               := sum(group,if(basefile.NAME_ORG_ORIG != '',1,0));
  NAME_DBA_ORIG_CountNonBlank               := sum(group,if(basefile.NAME_DBA_ORIG != '',1,0));
  NAME_MARI_ORIG_CountNonBlank              := sum(group,if(basefile.NAME_MARI_ORG != '',1,0));
  NAME_MARI_DBA_CountNonBlank               := sum(group,if(basefile.NAME_MARI_DBA != '',1,0));
  PHN_MARI_1_CountNonBlank                  := sum(group,if(basefile.PHN_MARI_1 != '0000000000' and basefile.PHN_MARI_1 != '',1,0));
  PHN_MARI_FAX_1_CountNonBlank              := sum(group,if(basefile.PHN_MARI_FAX_1 != '0000000000' and basefile.PHN_MARI_FAX_1 != '',1,0));
  PHN_MARI_2_CountNonBlank                  := sum(group,if(basefile.PHN_MARI_2 !='0000000000' and basefile.PHN_MARI_2 != '',1,0));
  PHN_MARI_FAX_2_CountNonBlank              := sum(group,if(basefile.PHN_MARI_FAX_2 != '0000000000' and basefile.PHN_MARI_FAX_2 != '',1,0));
  ADDR_ID_1_CountNonBlank                   := sum(group,if(basefile.ADDR_ID_1 != '',1,0));
  BUS_ADDR1_CountNonBlank                		:= sum(group,if(basefile.ADDR_ADDR1_1 != '',1,0));
  BUS_ADDR2_CountNonBlank                		:= sum(group,if(basefile.ADDR_ADDR2_1 != '',1,0));
  BUS_CITY_CountNonBlank                 		:= sum(group,if(basefile.ADDR_CITY_1 != '',1,0));
  BUS_STATE_CountNonBlank                		:= sum(group,if(basefile.ADDR_STATE_1 != '',1,0));
  BUS_ZIP5_CountNonBlank                 		:= sum(group,if(basefile.ADDR_ZIP5_1 != '',1,0));
  BUS_ZIP4_CountNonBlank                 		:= sum(group,if(basefile.ADDR_ZIP4_1 != '',1,0));
  PHN_PHONE_1_CountNonBlank                 := sum(group,if(basefile.PHN_PHONE_1 != '00000000000' and basefile.PHN_PHONE_1 != '',1,0));
  PHN_FAX_1_untNonBlank                   	:= sum(group,if(basefile.PHN_FAX_1 != '00000000000' and basefile.PHN_FAX_1 != '',1,0));
  BUS_CNTY_CountNonBlank                 		:= sum(group,if(basefile.ADDR_CNTY_1 != '',1,0));
  BUS_CNTRY_CountNonBlank                		:= sum(group,if(basefile.ADDR_CNTRY_1 != '',1,0));
  SUD_KEY_1_CountNonBlank                   := sum(group,if(basefile.SUD_KEY_1 != '',1,0));
  OOC_IND_1_CountNonBlank                   := sum(group,if(basefile.OOC_IND_1 != 0,1,0));
  RESULT_CD_1_CountNonBlank                 := sum(group,if(basefile.RESULT_CD_1 != '',1,0));
  BUS_CARRIER_RTE_CountNonBlank          		:= sum(group,if(basefile.ADDR_CARRIER_RTE_1 != '',1,0));
  BUS_DBPT_CountNonBlank                 		:= sum(group,if(basefile.ADDR_DELIVERY_PT_1 !='',1,0));
  ADDR_MAIL_IND_CountNonBlank           			:= sum(group,if(basefile.ADDR_MAIL_IND != '',1,0));
	ADDR_ID_2_CountNonBlank                   := sum(group,if(basefile.ADDR_ID_2 != '',1,0));
  MAIL_ADDR1_CountNonBlank                		:= sum(group,if(basefile.ADDR_ADDR1_2 != '',1,0));
  MAIL_ADDR2_CountNonBlank                		:= sum(group,if(basefile.ADDR_ADDR2_2 != '',1,0));
  MAIL_CITY_CountNonBlank                 		:= sum(group,if(basefile.ADDR_CITY_2 != '',1,0));
  MAIL_STATE_CountNonBlank                		:= sum(group,if(basefile.ADDR_STATE_2 != '',1,0));
  MAIL_ZIP5_CountNonBlank                 		:= sum(group,if(basefile.ADDR_ZIP5_2 != '',1,0));
  MAIL_ZIP4_CountNonBlank                 		:= sum(group,if(basefile.ADDR_ZIP4_2 != '',1,0));
  PHN_PHONE_2_CountNonBlank                 	:= sum(group,if(basefile.PHN_PHONE_2 != '00000000000' and basefile.PHN_PHONE_2 != '',1,0));
  PHN_FAX_2_untNonBlank                   		:= sum(group,if(basefile.PHN_FAX_2 != '00000000000' and basefile.PHN_FAX_2 != '',1,0));
  MAIL_CNTY_CountNonBlank                 		:= sum(group,if(basefile.ADDR_CNTY_2 != '',1,0));
  MAIL_CNTRY_CountNonBlank                		:= sum(group,if(basefile.ADDR_CNTRY_2 != '',1,0));
  SUD_KEY_2_CountNonBlank                   	:= sum(group,if(basefile.SUD_KEY_2 != '',1,0));
  OOC_IND_2_CountNonBlank                   	:= sum(group,if(basefile.OOC_IND_2 != 0,1,0));
  RESULT_CD_2_CountNonBlank                 	:= sum(group,if(basefile.RESULT_CD_2 != '',1,0));
  MAIL_CARRIER_RTE_CountNonBlank          		:= sum(group,if(basefile.ADDR_CARRIER_RTE_2 != '',1,0));
  MAIL_DBPT_CountNonBlank                 		:= sum(group,if(basefile.ADDR_DELIVERY_PT_2 !='',1,0));
	LICENSE_NBR_CONTACT_CountNonBlank         	:= sum(group,if(basefile.LICENSE_NBR_CONTACT != '',1,0));
  NAME_CONTACT_PREFX_CountNonBlank          	:= sum(group,if(basefile.NAME_CONTACT_PREFX != '',1,0));
  NAME_CONTACT_FIRST_CountNonBlank          	:= sum(group,if(basefile.NAME_CONTACT_FIRST != '',1,0));
  NAME_CONTACT_MID_CountNonBlank            	:= sum(group,if(basefile.NAME_CONTACT_MID != '',1,0));
	NAME_CONTACT_LAST_CountNonBlank           	:= sum(group,if(basefile.NAME_CONTACT_LAST != '',1,0));
  NAME_CONTACT_SUFX_CountNonBlank          	 	:= sum(group,if(basefile.NAME_CONTACT_SUFX != '',1,0));
  NAME_CONTACT_NICK_CountNonBlank           	:= sum(group,if(basefile.NAME_CONTACT_NICK != '',1,0));
	NAME_CONTACT_TTL_CountNonBlank            	:= sum(group,if(basefile.NAME_CONTACT_TTL != '',1,0));
  PHN_CONTACT_CountNonBlank                 	:= sum(group,if(basefile.PHN_CONTACT != '0000000000' AND basefile.PHN_CONTACT != '',1,0));
  PHN_CONTACT_EXT_CountNonBlank             	:= sum(group,if(basefile.PHN_CONTACT_EXT != '',1,0));
	PHN_CONTACT_FAX_CountNonBlank             	:= sum(group,if(basefile.PHN_CONTACT_FAX != '0000000000' AND basefile.PHN_CONTACT_FAX != '',1,0));
  EMAIL_CountNonBlank                       	:= sum(group,if(basefile.EMAIL != '',1,0));
	URL_CountNonBlank														:= sum(group,if(basefile.URL != '',1,0));
  BK_CLASS_CountNonBlank                    	:= sum(group,if(basefile.BK_CLASS != '',1,0));
	CHARTER_CountNonBlank												:= sum(group,if(basefile.CHARTER != '',1,0));	
	INST_BEG_DTE_CountNonBlank                	:= sum(group,if(basefile.INST_BEG_DTE != '',1,0));
  ORIGIN_CD_CountNonBlank                   	:= sum(group,if(basefile.ORIGIN_CD != '',1,0));
  DISP_TYPE_CD_CountNonBlank                	:= sum(group,if(basefile.DISP_TYPE_CD != '',1,0));
	REG_AGENT_CountNonBlank                   	:= sum(group,if(basefile.REG_AGENT != '',1,0));
	REGULATOR_CountNonBlank											:= sum(group,if(basefile.REGULATOR != '',1,0));
  HQTR_CITY_CountNonBlank                   	:= sum(group,if(basefile.HQTR_CITY != '',1,0));
  HQTR_NAME_CountNonBlank                   	:= sum(group,if(basefile.HQTR_NAME != '',1,0));
	DOMESTIC_OFF_NBR_CountNonBlank            	:= sum(group,if(basefile.DOMESTIC_OFF_NBR != '',1,0));
  FOREIGN_OFF_NBR_CountNonBlank             	:= sum(group,if(basefile.FOREIGN_OFF_NBR != '',1,0));
  HCR_RSSD_CountNonBlank                    	:= sum(group,if(basefile.HCR_RSSD != '',1,0));
	HCR_LOCATION_CountNonBlank                	:= sum(group,if(basefile.HCR_LOCATION != '',1,0));
  AFFIL_TYPE_CD_CountNonBlank               	:= sum(group,if(basefile.AFFIL_TYPE_CD != '',1,0));
  GENLINK_CountNonBlank                     	:= sum(group,if(basefile.GENLINK != '',1,0));
	RESEARCH_IND_CountNonBlank                	:= sum(group,if(basefile.RESEARCH_IND != 0,1,0));
  DOCKET_ID_CountNonBlank                  		:= sum(group,if(basefile.DOCKET_ID != '',1,0));	
  REC_KEY_CountNonZero                     		:= sum(group,if(basefile.REC_KEY != 0,1,0));
	MLTRECKEY_CountNonZero                   		:= sum(group,if(basefile.MLTRECKEY != 0,1,0));
	OLD_CMC_SLPK_CountNonZero                		:= sum(group,if(basefile.OLD_CMC_SLPK != 0,1,0));
	CMC_SLPK_CountNonZero                    		:= sum(group,if(basefile.CMC_SLPK != 0,1,0));
	PCMC_CLPK_CountNonZero                   		:= sum(group,if(basefile.PCMC_SLPK != 0,1,0));
	AFFIL_KEY_CountNonBlank                   	:= sum(group,if(basefile.AFFIL_KEY != 0,1,0));
	MATCH_ID_CountNonBlank                    	:= sum(group,if(basefile.MATCH_ID != '',1,0));
	PROVNOTE_1_CountNonBlank                  	:= sum(group,if(basefile.PROVNOTE_1 != '',1,0)); 
	PROVNOTE_2_CountNonBlank                  	:= sum(group,if(basefile.PROVNOTE_2 != '',1,0));
	PROVNOTE_3_CountNonBlank                  	:= sum(group,if(basefile.PROVNOTE_3 != '',1,0));	
	PREV_PRIMARY_KEY_CountNonBlank							:= sum(group,if(basefile.PREV_PRIMARY_KEY != 0,1,0));
	PREV_MLTRECKEY_CountNonBlank								:= sum(group,if(basefile.PREV_MLTRECKEY != 0,1,0));
	PREV_CMC_SLPK_CountNonBlank									:= sum(group,if(basefile.PREV_CMC_SLPK != 0,1,0));
	PREV_PCMC_SLPK_CountNonBlank								:= sum(group,if(basefile.PREV_PCMC_SLPK != 0,1,0));
	PERSISTENT_RECORD_ID_CountNonZero						:= sum(group,if(basefile.PERSISTENT_RECORD_ID != 0,1,0));
	ADDITIONAL_LICENSE_SPECIALIZED_CountNonBlank	:= sum(group,if(basefile.addl_license_spec != '',1,0));
	CONTINUED_EDUC_EARNED_CountNonBlank					:= sum(group,if(basefile.cont_education_ernd != '',1,0));
	CONTINUED_EDUC_REQUIRED_CountNonBlank				:= sum(group,if(basefile.cont_education_req != '',1,0));
	CONTINUED_EDUC_TERM_CountNonBlank						:= sum(group,if(basefile.cont_education_term != '',1,0));
	AGENCY_ID_CountNonBlank											:= sum(group,if(basefile.agency_id != '',1,0));
	SITE_LOCATION_CountNonBlank									:= sum(group,if(basefile.site_location != '',1,0));
	BUSINESS_TYPE_CountNonBlank									:= sum(group,if(basefile.business_type != '',1,0));
	DISCIPLINARY_ACTION_CountNonBlank						:= sum(group,if(basefile.displinary_action != '',1,0));
	VIOLATION_DATE_CountNonBlank								:= sum(group,if(basefile.violation_dte != '',1,0));
	VIOLATION_CASE_NBR_CountNonBlank						:= sum(group,if(basefile.violation_case_nbr != '',1,0));
	VIOLATION_DESC_CountNonBlank								:= sum(group,if(basefile.violation_desc != '',1,0));
	LICENSE_ID_CountNonZero											:= sum(group,if(basefile.LICENSE_ID != 0,1,0));		
	NMLS_ID_CountNonZero												:= sum(group,if(basefile.nmls_id != 0,1,0));
	FOREIGN_NMLS_ID_CountNonZero								:= sum(group,if(basefile.foreign_nmls_id != 0,1,0));
	LOCATION_TYPE_CountNonBlank									:= sum(group,if(basefile.location_type != '',1,0));
	NAME_TYPE_CountNonBlank											:= sum(group,if(basefile.name_type != '',1,0));
	START_DTE_CountNonBlank											:= sum(group,if(basefile.start_dte != '',1,0));
	AGENCY_STATUS																:= sum(group,if(basefile.AGENCY_STATUS != '',1,0));
	IS_AUTHORIZED_LICENSE_CountNonBlank					:= sum(group,if(basefile.is_authorized_license != '',1,0));
	IS_AUTHORIZED_CONDUCT_CountNonBlank					:= sum(group,if(basefile.is_authorized_conduct != '',1,0));
	FEDERAL_REGULATOR_CountNonBlank							:= sum(group,if(basefile.federal_regulator != '',1,0));
	DOTID_CountNonZero													:= sum(group,if(basefile.dotid != 0,1,0));
	DOTSCORE_CountNonZero												:= sum(group,if(basefile.dotscore != 0,1,0));
	DOTWEIGHT_CountNonZero											:= sum(group,if(basefile.dotweight != 0,1,0));
	EMPID_CountNonZero													:= sum(group,if(basefile.empid != 0,1,0));
	EMPSCORE_CountNonZero												:= sum(group,if(basefile.empscore != 0,1,0));
	EMPWEIGHT_CountNonZero											:= sum(group,if(basefile.empweight != 0,1,0));
	POWID_CountNonZero													:= sum(group,if(basefile.powid != 0,1,0));
	POWSCORE_CountNonZero												:= sum(group,if(basefile.powscore != 0,1,0));
	POWWEIGHT_CountNonZero											:= sum(group,if(basefile.powweight != 0,1,0));
	PROXID_CountNonZero													:= sum(group,if(basefile.proxid != 0,1,0));
	PROXSCORE_CountNonZero											:= sum(group,if(basefile.proxscore != 0,1,0));
	PROXWEIGHT_CountNonZero											:= sum(group,if(basefile.proxweight != 0,1,0));
	SELEID_CountNonZero													:= sum(group,if(basefile.seleid != 0,1,0));
	SELESCORE_CountNonZero											:= sum(group,if(basefile.selescore != 0,1,0));
	SELEWEIGHT_CountNonZero											:= sum(group,if(basefile.seleweight != 0,1,0));
	ORGID_CountNonZero													:= sum(group,if(basefile.orgid != 0,1,0));
	ORGSCORE_CountNonZero												:= sum(group,if(basefile.orgscore != 0,1,0));
	ORGWEIGHT_CountNonZero											:= sum(group,if(basefile.orgweight != 0,1,0));
	ULTID_CountNonZero													:= sum(group,if(basefile.ultid != 0,1,0));
	ULTSCORE_CountNonZero												:= sum(group,if(basefile.ultscore != 0,1,0));
	ULTWEIGHT_CountNonZero											:= sum(group,if(basefile.ultweight != 0,1,0));
	DID__CountNonZero                         	:= sum(group,if(basefile.DID != 0,1,0));
	BDID__CountNonZero                        	:= sum(group,if(basefile.BDID != 0,1,0));
	TITLE_CountNonBlank                       	:= sum(group,if(basefile.title != '',1,0));
  FNAME_CountNonBlank                       	:= sum(group,if(basefile.fname != '',1,0));
  MNAME_CountNonBlank                       	:= sum(group,if(basefile.mname != '',1,0));
  LNAME_CountNonBlank                       	:= sum(group,if(basefile.lname != '',1,0));
	NAME_SUFFIX_CountNonBlank                 	:= sum(group,if(basefile.name_suffix != '',1,0));
	NAME_COMPANY																:= sum(group,if(basefile.name_company != '',1,0));
	NAME_COMPANY_DBA														:= sum(group,if(basefile.name_company_dba != '',1,0));
	Append_BusAddrFirst													:= sum(group,if(basefile.append_busaddrfirst != '',1,0));
	Append_BusAddrLast													:= sum(group,if(basefile.append_busaddrlast != '',1,0));
	Append_BusRawAID														:= sum(group,if(basefile.append_busRawAID != 0,1,0));
	Append_BusAceAID														:= sum(group,if(basefile.append_busAceAID != 0,1,0));
	Append_MailAddrFirst												:= sum(group,if(basefile.append_mailAddrFirst != '',1,0));	
	Append_MailAddrLast													:= sum(group,if(basefile.append_MailAddrLast != '',1,0));	
	Append_MailRawAID														:= sum(group,if(basefile.append_MailRawAID != 0,1,0));	
	Append_MailAceAID														:= sum(group,if(basefile.append_MailAceAID != 0,1,0));	
	CLN_BUS_PRIM_RANGE_CountNonBlank                := sum(group,if(basefile.bus_prim_range != '',1,0));
  CLN_BUS_PREDIR_CountNonBlank                    := sum(group,if(basefile.bus_predir != '',1,0));
  CLN_BUS_PRIM_NAME_CountNonBlank                 := sum(group,if(basefile.bus_prim_name != '',1,0));
  CLN_BUS_ADDR_SUFFIX_CountNonBlank               := sum(group,if(basefile.bus_addr_suffix != '',1,0));
  CLN_BUS_POSTDIR_CountNonBlank                   := sum(group,if(basefile.bus_postdir != '',1,0));
  CLN_BUS_UNIT_DESIG_CountNonBlank                := sum(group,if(basefile.bus_unit_desig != '',1,0));
  CLN_BUS_SEC_RANGE_CountNonBlank                 := sum(group,if(basefile.bus_sec_range != '',1,0));
  CLN_BUS_P_CITY_NAME_CountNonBlank               := sum(group,if(basefile.bus_p_city_name != '',1,0));
  CLN_BUS_V_CITY_NAME_CountNonBlank               := sum(group,if(basefile.bus_v_city_name != '',1,0));
  CLN_BUS_STATE_CountNonBlank                     := sum(group,if(basefile.bus_state != '',1,0));
  CLN_BUS_ZIP5_CountNonBlank                      := sum(group,if(basefile.bus_zip5 != '',1,0));
  CLN_BUS_ZIP4_CountNonBlank                      := sum(group,if(basefile.bus_zip4 != '',1,0));
  CLN_BUS_CART_CountNonBlank                      := sum(group,if(basefile.bus_cart != '',1,0));
  CLN_BUS_CR_SORT_SZ_CountNonBlank                := sum(group,if(basefile.bus_cr_sort_sz != '',1,0));
  CLN_BUS_LOT_CountNonBlank                       := sum(group,if(basefile.bus_lot != '',1,0));
  CLN_BUS_LOT_ORDER_CountNonBlank                 := sum(group,if(basefile.bus_lot_order != '',1,0));
  CLN_BUS_DPBC_CountNonBlank                      := sum(group,if(basefile.bus_dpbc != '',1,0));
  CLN_BUS_CHK_DIGIT_CountNonBlank                 := sum(group,if(basefile.bus_chk_digit != '',1,0));
  CLN_BUS_RECORD_TYPE_CountNonBlank               := sum(group,if(basefile.bus_rec_type != '',1,0));
	CLN_BUS_ACE_FIPS_ST_CountNonBlank               := sum(group,if(basefile.bus_ace_fips_st != '',1,0));
  CLN_BUS_COUNTY_CountNonBlank                    := sum(group,if(basefile.bus_county != '',1,0));
  CLN_BUS_GEO_LAT_CountNonBlank                   := sum(group,if(basefile.bus_geo_lat != '',1,0));
  CLN_BUS_GEO_LONG_long_CountNonBlank             := sum(group,if(basefile.bus_geo_long != '',1,0));
  CLN_BUS_MSA_CountNonBlank                       := sum(group,if(basefile.bus_msa != '',1,0));
  CLN_BUS_GEO_BLK_CountNonBlank                   := sum(group,if(basefile.bus_geo_blk != '',1,0));
  CLN_BUS_GEO_MATCH_CountNonBlank                 := sum(group,if(basefile.bus_geo_match != '',1,0));
  CLN_BUS_ERR_STAT_CountNonBlank                  := sum(group,if(basefile.bus_err_stat != '',1,0));
	CLN_MAIL_PRIM_RANGE_CountNonBlank               := sum(group,if(basefile.mail_prim_range != '',1,0));
  CLN_MAIL_PREDIR_CountNonBlank                   := sum(group,if(basefile.mail_predir != '',1,0));
  CLN_MAIL_PRIM_NAME_CountNonBlank                := sum(group,if(basefile.mail_prim_name != '',1,0));
  CLN_MAIL_ADDR_SUFFIX_CountNonBlank              := sum(group,if(basefile.mail_addr_suffix != '',1,0));
  CLN_MAIL_POSTDIR_CountNonBlank                  := sum(group,if(basefile.mail_postdir != '',1,0));
  CLN_MAIL_UNIT_DESIG_CountNonBlank               := sum(group,if(basefile.mail_unit_desig != '',1,0));
  CLN_MAIL_SEC_RANGE_CountNonBlank                := sum(group,if(basefile.mail_sec_range != '',1,0));
	CLN_MAIL_P_CITY_NAME_CountNonBlank              := sum(group,if(basefile.mail_p_city_name != '',1,0));
  CLN_MAIL_V_CITY_NAME_CountNonBlank              := sum(group,if(basefile.mail_v_city_name != '',1,0));
  CLN_MAIL_STATE_CountNonBlank                    := sum(group,if(basefile.mail_state != '',1,0));
  CLN_MAIL_ZIP5_CountNonBlank                     := sum(group,if(basefile.mail_zip5 != '',1,0));
  CLN_MAIL_ZIP4_CountNonBlank                     := sum(group,if(basefile.mail_zip4 != '',1,0));
  CLN_MAIL_CART_CountNonBlank                     := sum(group,if(basefile.mail_cart != '',1,0));
  CLN_MAIL_CR_SORT_SZ_CountNonBlank               := sum(group,if(basefile.mail_cr_sort_sz != '',1,0));
  CLN_MAIL_LOT_CountNonBlank                      := sum(group,if(basefile.mail_lot != '',1,0));
  CLN_MAIL_LOT_ORDER_CountNonBlank                := sum(group,if(basefile.mail_lot_order != '',1,0));
  CLN_MAIL_DPBC_CountNonBlank                     := sum(group,if(basefile.mail_dpbc != '',1,0));
  CLN_MAIL_CHK_DIGIT_CountNonBlank                := sum(group,if(basefile.mail_chk_digit != '',1,0));
  CLN_MAIL_RECORD_TYPE_CountNonBlank              := sum(group,if(basefile.mail_rec_type != '',1,0));
	CLN_MAIL_ACE_FIPS_ST_CountNonBlank              := sum(group,if(basefile.mail_ace_fips_st != '',1,0));
  CLN_MAIL_COUNTY_CountNonBlank                   := sum(group,if(basefile.mail_county != '',1,0));
  CLN_MAIL_GEO_LAT_CountNonBlank                  := sum(group,if(basefile.mail_geo_lat != '',1,0));
  CLN_MAIL_GEO_LONG_long_CountNonBlank            := sum(group,if(basefile.mail_geo_long != '',1,0));
  CLN_MAIL_MSA_CountNonBlank                      := sum(group,if(basefile.mail_msa != '',1,0));
  CLN_MAIL_GEO_BLK_CountNonBlank                  := sum(group,if(basefile.mail_geo_blk != '',1,0));
  CLN_MAIL_GEO_MATCH_CountNonBlank                := sum(group,if(basefile.mail_geo_match != '',1,0));
  CLN_MAIL_ERR_STAT_CountNonBlank                 := sum(group,if(basefile.mail_err_stat != '',1,0));
	ClnLicenseNbr_CountNonBlank											:= sum(group,if(basefile.cln_LICENSE_NBR != '',1,0));
	EnhancedDID_CountNonBlank												:= sum(group,if(basefile.enh_did_src != '',1,0));
  end;
 
 
 rPopulationStats_Indiv_Detail :=  record
	indv_detail.REGULATOR;
  CountGroup                                := count(group);
	DATE_FIRST_SEEN														:= sum(group,if(indv_detail.DATE_FIRST_SEEN != '',1,0));
	DATE_LAST_SEEN														:= sum(group,if(indv_detail.DATE_LAST_SEEN != '',1,0));
	DATE_VENDOR_FIRST_REPORTED								:= sum(group,if(indv_detail.DATE_VENDOR_FIRST_REPORTED != '',1,0));
	DATE_VENDOR_LAST_REPORTED									:= sum(group,if(indv_detail.DATE_VENDOR_LAST_REPORTED != '',1,0));	
	PROCESS_DATE															:= sum(group,if(indv_detail.PROCESS_DATE != '',1,0));
	STD_SOURCE_UPD_CountNonBlank             	:= sum(group,if(indv_detail.STD_SOURCE_UPD != '',1,0));
	// RECORD_TYPE_IND
	INDIVIDUAL_NMLS_ID_CountNonZero						:= sum(group,if(indv_detail.INDIVIDUAL_NMLS_ID != 0,1,0));
	COMPANY_NMLS_ID_CountNonZero							:= sum(group,if(indv_detail.COMPANY_NMLS_ID != 0,1,0));
	INSTIT_NMLS_ID_CountNonZero								:= sum(group,if(indv_detail.INSTIT_NMLS_ID != 0,1,0));
	NAME_REGISTRATION_CountNonBlank						:= sum(group,if(indv_detail.NAME_REGISTRATION != '',1,0));
	REG_STATUS_CountNonBlank									:= sum(group,if(indv_detail.is_Authorized_Conduct != '',1,0));
	is_Authorized_Conduct_CountNonBlank				:= sum(group,if(indv_detail.REG_STATUS != '',1,0));
	EMPLOYER_NAME_CountNonBlank								:= sum(group,if(indv_detail.NAME_EMPLOYER != '',1,0));
	COMPANY_NAME_CountNonBlank								:= sum(group,if(indv_detail.NAME_COMPANY != '',1,0));
	LICENSE_ID_CountNonZero										:= sum(group,if(indv_detail.LICENSE_ID != 0,1,0));
	RAW_LICENSE_TYPE_CountNonBlank						:= sum(group,if(indv_detail.RAW_LICENSE_TYPE != '',1,0));
	STD_LICENSE_DESC_CountNonBlank 						:= sum(group,if(indv_detail.STD_LICENSE_DESC != '',1,0));
	// STD_LICENSE_DESC 													:= sum(group,if(indv_detail.START_DTE != '',1,0));
	// REGULATOR																	:= sum(group,if(indv_detail.STD_SOURCE_UPD != '',1,0));
	START_DTE_CountNonBlank										:= sum(group,if(indv_detail.START_DTE != '',1,0));
	END_DTE_CountNonBlank											:= sum(group,if(indv_detail.END_DTE != '',1,0));
	CLN_START_DTE_CountNonBlank								:= sum(group,if(indv_detail.CLN_START_DTE != '',1,0));
  CLN_END_DTE_CountNonBlank									:= sum(group,if(indv_detail.CLN_END_DTE != '',1,0));
end;
	
rPopulationStats_Disciplanary :=  record
	disciplinary.AUTHORITY_TYPE;
  CountGroup                                := count(group);
	DATE_FIRST_SEEN														:= sum(group,if(disciplinary.DATE_FIRST_SEEN != '',1,0));
	DATE_LAST_SEEN														:= sum(group,if(disciplinary.DATE_LAST_SEEN != '',1,0));
	DATE_VENDOR_FIRST_REPORTED								:= sum(group,if(disciplinary.DATE_VENDOR_FIRST_REPORTED != '',1,0));
	DATE_VENDOR_LAST_REPORTED									:= sum(group,if(disciplinary.DATE_VENDOR_LAST_REPORTED != '',1,0));	
	PROCESS_DATE															:= sum(group,if(disciplinary.PROCESS_DATE != '',1,0));
	STD_SOURCE_UPD_CountNonBlank        	  	:= sum(group,if(disciplinary.STD_SOURCE_UPD != '',1,0));
	INDIVIDUAL_NMLS_ID_CountNonZero						:= sum(group,if(disciplinary.INDIVIDUAL_NMLS_ID != 0,1,0));
  // AUTHORITY_TYPE_CountNonBlank             	:= sum(group,if(disciplinary.AUTHORITY_TYPE != '',1,0));
  ACTION_TYPE_CountNonBlank									:= sum(group,if(disciplinary.ACTION_TYPE != '',1,0));
  ACTION_DTE_CountNonBlank									:= sum(group,if(disciplinary.ACTION_DTE != '',1,0));
  AUTHORITY_NAME_CountNonBlank							:= sum(group,if(disciplinary.AUTHORITY_NAME != '',1,0));
  ACTION_DETAI_CountNonBlank								:= sum(group,if(disciplinary.ACTION_DETAIL != '',1,0));
  URL_CountNonBlank													:= sum(group,if(disciplinary.URL != '',1,0));
  STATE_ACTION_ID_CountNonZero							:= sum(group,if(disciplinary.STATE_ACTION_ID != 0,1,0));
	CLN_ACTION_DTE_CountNonBlank							:= sum(group,if(disciplinary.CLN_ACTION_DTE != '',1,0));
end;
	
rPopulationStats_Regulatory :=  record
	regulatory.REGULATOR;
  CountGroup                                := count(group);
	DATE_FIRST_SEEN														:= sum(group,if(regulatory.DATE_FIRST_SEEN != '',1,0));
	DATE_LAST_SEEN														:= sum(group,if(regulatory.DATE_LAST_SEEN != '',1,0));
	DATE_VENDOR_FIRST_REPORTED								:= sum(group,if(regulatory.DATE_VENDOR_FIRST_REPORTED != '',1,0));
	DATE_VENDOR_LAST_REPORTED									:= sum(group,if(regulatory.DATE_VENDOR_LAST_REPORTED != '',1,0));	
	PROCESS_DATE															:= sum(group,if(regulatory.PROCESS_DATE != '',1,0));
	STD_SOURCE_UPD_CountNonBlank             	:= sum(group,if(regulatory.STD_SOURCE_UPD != '',1,0));
  STATE_ACTION_ID_CountNonZero 							:= sum(group,if(regulatory.STATE_ACTION_ID != 0,1,0));
  NMLS_ID_CountNonZero 											:= sum(group,if(regulatory.NMLS_ID != 0,1,0));
  AFFIL_TYPE_CD_CountNonBlank             	:= sum(group,if(regulatory.AFFIL_TYPE_CD != '',1,0));
  // REGULATOR
  ACTION_TYP_CountNonBlank 									:= sum(group,if(regulatory.ACTION_TYPE != '',1,0));
  ACTION_DTE_CountNonBlank 									:= sum(group,if(regulatory.ACTION_DTE != '',1,0));
  MULTI_STATE_ID_CountNonBlank 							:= sum(group,if(regulatory.MULTI_STATE_ID != '',1,0));
  DOCKET_NBR_CountNonBlank 									:= sum(group,if(regulatory.DOCKET_NBR != '',1,0));
  URL_CountNonBlank 												:= sum(group,if(regulatory.URL != '',1,0));
  CLN_ACTION_DTE_CountNonBlank 							:= sum(group,if(regulatory.CLN_ACTION_DTE != '',1,0));
end;	



// Create the Main table and run the STRATA statistics
dPopulationStats_Main := sort(table(basefile,rPopulationStats_Main,std_source_upd,std_source_desc,license_state,few),
																								std_source_upd,std_source_desc,license_state);
// tStats := table(basefile,PopulationStats_File_MARI_full,std_source_upd,std_source_desc,license_state,few);									 

// Create the Individual Detail table and run the STRATA statistics
dPopulationStats_Indv_Detail := sort(table(indv_detail, rPopulationStats_Indiv_Detail,regulator,few),regulator);

// Create the Disciplinary Action table and run the STRATA statistics
dPopulationStats_Disciplinary:= sort(table(disciplinary,rPopulationStats_Disciplanary,authority_type,few),authority_type);

// Create the Regulatory Action table and run the STRATA statistics
dPopulationStats_Regulatory := sort(table(regulatory,rPopulationStats_Regulatory,regulator,few),regulator);
																				

// Call the STRATA function to generate the XML stats 
strata.createXMLStats(dPopulationStats_Main ,'Professional License Mari Base','data',pversion,'',resultsOut,'view','population');
strata.createXMLStats(dPopulationStats_Indv_Detail ,'Professional License Mari Individual Detail','data',pversion,'',resultsOut_detail,'view','population');
strata.createXMLStats(dPopulationStats_Disciplinary ,'Professional License Mari Disciplinary','data',pversion,'',resultsOut_disciplinary,'view','population');
strata.createXMLStats(dPopulationStats_Regulatory ,'Professional License Mari Regulatory','data',pversion,'',resultsOut_regulatory,'view','population');

  RETURN parallel(resultsOut,resultsOut_detail,resultsOut_disciplinary,resultsOut_regulatory);
	

END;






















































































































