/* ************************************************************************************************************ */	
//  The purpose of this development is take the Professional License common superfile and convert MARIFLAT_out
//  layout as well as filter licenses to be used for MARI development in the ROXIE environment.
//  NOTE: Future development will be required to address ADDRESS ID business logic.
/* ************************************************************************************************************ */	

import Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

//Superfile created in the raw to common(MARIBASE) layout conversion
ds_common	:= Prof_License_Mari.file_common_inputdatasets;

//Professional license types processed by MARI
MARI_LicType := ['531320','APRC','APRG','APRR','APRT',
								'522291','522292','522294','522298','522310','522320','522390',
								'531110','531120','531130','531190','531210','531311','531312',
								'531390','532310','RECA','RECB','RECC','RECD','RECS'];
//Map raw_to_maribase output to MARIFLAT output
Prof_License_Mari.layouts_reference.MARIFLAT_out	transformCommonToMARI(Prof_License_Mari.layouts_reference.MARIBASE L) := TRANSFORM
	self.PRIMARY_KEY		:= 0;
	self.CREATE_DTE			:= L.CREATE_DTE; //YYYYMMDD
	self.LAST_UPD_DTE		:= Lib_StringLib.StringLib.GetDateYYYYMMDD();
	self.STAMP_DTE			:= L.STAMP_DTE; //YYYYMMDD
	self.GEN_NBR				:= '';
	self.STD_PROF_CD		:= L.STD_PROF_CD;
	self.STD_PROF_DESC	:= L.STD_PROF_DESC;
	self.STD_SOURCE_UPD	:= L.STD_SOURCE_UPD;
	self.STD_SOURCE_DESC:= L.STD_SOURCE_DESC;
	self.TYPE_CD				:= L.TYPE_CD; //Corp(GR) or Individual(MD) code
	self.NAME_ORG_PREFX	:= L.NAME_ORG_PREFX;
	self.NAME_ORG				:= L.NAME_ORG; //Without punct. and Sufx removed
	self.NAME_ORG_SUFX 	:= L.NAME_ORG_SUFX;
	self.STORE_NBR			:= L.STORE_NBR;
	self.NAME_DBA_PREFX := L.NAME_DBA_PREFX;
	self.NAME_DBA				:= L.NAME_DBA;
	self.NAME_DBA_SUFX	:= L.NAME_DBA_SUFX;
	self.STORE_NBR_DBA	:= L.STORE_NBR_DBA;
	self.DBA_FLAG				:= L.DBA_FLAG;
	self.NAME_OFFICE		:= L.NAME_OFFICE;
	self.OFFICE_PARSE		:= L.OFFICE_PARSE;
	self.NAME_PREFX			:= L.NAME_PREFX;
	self.NAME_FIRST			:= L.NAME_FIRST;
	self.NAME_MID				:= L.NAME_MID;
	self.NAME_LAST			:= L.NAME_LAST;
	self.NAME_SUFX			:= L.NAME_SUFX;
	self.NAME_NICK			:= L.NAME_NICK;
	self.BIRTH_DTE			:= L.BIRTH_DTE;
	self.GENDER					:= L.GENDER;
	self.PROV_STAT			:= L.PROV_STAT;
	self.CREDENTIAL			:= L.CREDENTIAL;
	self.LICENSE_NBR		:= L.LICENSE_NBR;
	self.OFF_LICENSE_NBR	:= L.OFF_LICENSE_NBR;
	self.LICENSE_STATE		:= L.LICENSE_STATE;
	self.STD_LICENSE_TYPE	:= L.STD_LICENSE_TYPE;
	self.STD_LICENSE_DESC	:= L.STD_LICENSE_DESC;
	self.STD_LICENSE_STATUS	:= L.STD_LICENSE_STATUS;
	self.STD_STATUS_DESC		:= L.STD_STATUS_DESC;
	self.CURR_ISSUE_DTE		:= IF(TRIM(L.CURR_ISSUE_DTE) != '',TRIM(L.CURR_ISSUE_DTE),'17530101');
	self.ORIG_ISSUE_DTE		:= IF(TRIM(L.ORIG_ISSUE_DTE) != '',TRIM(L.ORIG_ISSUE_DTE),'17530101');
	self.EXPIRE_DTE				:= IF(TRIM(L.EXPIRE_DTE) != '',TRIM(L.EXPIRE_DTE),'17530101');
	self.ACTIVE_FLAG			:= L.ACTIVE_FLAG;
	self.SSN_TAXID_1			:= StringLib.stringfilter(L.SSN_TAXID_1,'0123456789');
	self.TAX_TYPE_1				:= L.TAX_TYPE_1;
	self.SSN_TAXID_2			:= StringLib.stringfilter(L.SSN_TAXID_2,'0123456789');
	self.TAX_TYPE_2				:= L.TAX_TYPE_2;
	self.FED_RSSD					:= L.FED_RSSD;
	self.ADDR_BUS_IND			:= L.ADDR_BUS_IND;
	self.NAME_ORG_ORIG		:= L.NAME_ORG_ORIG;
	self.NAME_DBA_ORIG		:= L.NAME_DBA_ORIG;
	self.NAME_MARI_ORG		:= L.NAME_MARI_ORG;
	self.NAME_MARI_DBA		:= L.NAME_MARI_DBA;
	self.PHN_MARI_1				:= IF(L.PHN_MARI_1 != '',stringlib.stringfilter(L.PHN_MARI_1,'0123456789')[1..10],'0000000000');
	self.PHN_MARI_FAX_1		:= L.PHN_MARI_FAX_1;
	self.PHN_MARI_2				:= IF(L.PHN_MARI_2 != '',stringlib.stringfilter(L.PHN_MARI_2,'0123456789')[1..10],'0000000000');
	self.PHN_MARI_FAX_2		:= L.PHN_MARI_FAX_2;
	//FullStreet						:= TRIM(L.ADDR_ADDR1_1,LEFT) + ' ' + TRIM(L.ADDR_ADDR2_1,LEFT,RIGHT);
	//clean_addr						:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(FullStreet, L.ADDR_CITY_1+' '+L.ADDR_STATE_1+' '+L.ADDR_ZIP5_1+L.ADDR_ZIP4_1);
	self.ADDR_ID_1				:= '';
	self.ADDR_ADDR1_1			:= L.ADDR_ADDR1_1;
	self.ADDR_ADDR2_1			:= L.ADDR_ADDR2_1;
	self.ADDR_CITY_1			:= L.ADDR_CITY_1;
	self.ADDR_STATE_1			:= L.ADDR_STATE_1;
	self.ADDR_ZIP5_1			:= L.ADDR_ZIP5_1;
	self.ADDR_ZIP4_1			:= L.ADDR_ZIP4_1;
	self.PHN_PHONE_1			:= IF(L.PHN_PHONE_1 != '',stringlib.stringfilter(L.PHN_PHONE_1,'0123456789')[1..10],'0000000000');
	self.PHN_FAX_1				:= IF(L.PHN_FAX_1!= '',stringlib.stringfilter(L.PHN_FAX_1,'0123456789')[1..10],'0000000000');
	self.ADDR_CNTY_1			:= L.ADDR_CNTY_1;
	self.ADDR_CNTRY_1			:= L.ADDR_CNTRY_1;
	self.SUD_KEY_1				:= L.SUD_KEY_1;
	self.OOC_IND_1				:= 0;
	self.RESULT_CD_1			:= '';
	self.ADDR_CARRIER_RTE_1	:= '';
	self.ADDR_DELIVERY_PT_1	:= '';
	self.ADDR_MAIL_IND 		:= L.ADDR_MAIL_IND;
	//FullStreet2						:= TRIM(L.ADDR_ADDR1_2,LEFT) + ' ' + TRIM(L.ADDR_ADDR2_2,LEFT,RIGHT);
	//clean_addr2						:= Prof_License_Mari.mod_clean_name_addr.cleanAddress(FullStreet2, L.ADDR_CITY_2+' '+L.ADDR_STATE_2+' '+L.ADDR_ZIP5_2+L.ADDR_ZIP4_2);
	self.ADDR_ID_2				:= '';
	self.ADDR_ADDR1_2			:= L.ADDR_ADDR1_2;
	self.ADDR_ADDR2_2			:= L.ADDR_ADDR2_2;
	self.ADDR_CITY_2			:= L.ADDR_CITY_2;
	self.ADDR_STATE_2			:= L.ADDR_STATE_2;
	self.ADDR_ZIP5_2			:= L.ADDR_ZIP5_2;
	self.ADDR_ZIP4_2			:= L.ADDR_ZIP4_2;
	self.ADDR_CNTY_2			:= L.ADDR_CNTY_2;        
	self.ADDR_CNTRY_2			:= L.ADDR_CNTRY_2;
	self.PHN_PHONE_2			:= IF(L.PHN_PHONE_2 != '',stringlib.stringfilter(L.PHN_PHONE_2,'0123456789')[1..10],'0000000000');
	self.PHN_FAX_2				:= IF(L.PHN_FAX_2!= '',stringlib.stringfilter(L.PHN_FAX_2,'0123456789')[1..10],'0000000000');
	self.SUD_KEY_2				:= L.SUD_KEY_2;
	self.OOC_IND_2				:= 0;
	self.RESULT_CD_2			:= '';
	self.ADDR_CARRIER_RTE_2	:= '';
	self.ADDR_DELIVERY_PT_2	:= '';
	self.LICENSE_NBR_CONTACT	:= L.LICENSE_NBR_CONTACT;
  //STRING73 ClnContactName	:= Prof_License_Mari.mod_clean_name_addr.cleanLFMName(TRIM(L.NAME_CONTACT_LAST+', '+TRIM(L.NAME_CONTACT_FIRST,LEFT,RIGHT)+' '+L.NAME_CONTACT_MID,LEFT,RIGHT));
	self.NAME_CONTACT_PREFX	:= L.NAME_CONTACT_PREFX;
	self.NAME_CONTACT_FIRST	:= L.NAME_CONTACT_FIRST;
	self.NAME_CONTACT_MID		:= L.NAME_CONTACT_MID;
	self.NAME_CONTACT_LAST	:= L.NAME_CONTACT_LAST;
	self.NAME_CONTACT_SUFX	:= L.NAME_CONTACT_SUFX;
	self.NAME_CONTACT_NICK	:= L.NAME_CONTACT_NICK;
	self.NAME_CONTACT_TTL		:= L.NAME_CONTACT_TTL;
	self.PHN_CONTACT				:= L.PHN_CONTACT;
	self.PHN_CONTACT_EXT		:= L.PHN_CONTACT_EXT;
	self.PHN_CONTACT_FAX		:= L.PHN_CONTACT_FAX;
	self.EMAIL							:= L.EMAIL;
	self.URL								:= L.URL;
	self.BK_CLASS						:= L.BK_CLASS;
	self.CHARTER						:= L.CHARTER;
	self.INST_BEG_DTE				:= L.INST_BEG_DTE;
	self.ORIGIN_CD					:= L.ORIGIN_CD;
	self.DISP_TYPE_CD				:= L.DISP_TYPE_CD;
	self.REG_AGENT					:= L.REG_AGENT;
	self.HQTR_CITY					:= L.HQTR_CITY;
	self.HQTR_NAME					:= L.HQTR_NAME;
	self.DOMESTIC_OFF_NBR		:= L.DOMESTIC_OFF_NBR;
	self.FOREIGN_OFF_NBR		:= L.FOREIGN_OFF_NBR;
	self.HCR_RSSD						:= L.HCR_RSSD;
	self.HCR_LOCATION				:= L.HCR_LOCATION;
	self.AFFIL_TYPE_CD			:= L.AFFIL_TYPE_CD;
	self.GENLINK						:= L.GENLINK;
	self.RESEARCH_IND				:= 0;
	self.DOCKET_ID					:= L.DOCKET_ID;
	self.REC_KEY						:= 0;
	self.MLTRECKEY					:= 0;
	self.OLD_CMC_SLPK				:= 0;
	self.CMC_SLPK						:= 0;
	self.PCMC_SLPK					:= 0;
	self.AFFIL_KEY					:= 0;
	self.MATCH_ID						:= '';
	self.PROVNOTE_123				:= TRIM(L.PROVNOTE_1+L.PROVNOTE_2+L.PROVNOTE_3,LEFT,RIGHT);
	self.TMP_NAME_COMPANY		:= L.NAME_ORG_ORIG;
	self.TMP_NAME_DBA				:= L.NAME_DBA_ORIG;
	self.LICENSOR_KEY				:= HASH(L.STD_SOURCE_UPD);
	self.LICENSE_KEY				:= 0;
	self.PRIME_KEY					:= 0;
	self.DBA_KEY						:= 0;
	self	:= [];
END;

ds_mari	:= project(ds_common,transformCommonToMARI(left));

export MariFlat	:= ds_mari(STD_LICENSE_TYPE IN MARI_LicType);

OUTPUT(MariFlat,,'~thor400_88::out::prolic::Mariflat_prof.txt',OVERWRITE);

