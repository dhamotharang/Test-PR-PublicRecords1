import ut, Prof_License_Mari, Lib_FileServices, lib_stringlib, Lib_date, address;


export  map_cmrflat_test (string pVersion) := function



inFile_base 	:= Prof_License_Mari.file_cmrflat_test;


//Mapping MARIFLAT Full Dump file into MARIFLAT_out Layout
Prof_License_Mari.layouts.base xformCmrFlat(Prof_License_Mari.layout_cmrflat_test pInput) 
    := 
	   TRANSFORM
	       self.PRIMARY_KEY				:= 0;
				
		   // Reformatting the following date format: M/D/YYYY, MM/D/YYYY, MM/DD/YYYY, and YYYY-MM-DD to YYYYMMDD
	     self.CREATE_DTE					:= MAP(REGEXFIND('[0-9]+/[0-9]+/[0-9]{4}',pInput.CREATE_DTE) =>	ut.date_slashed_MMDDYYYY_to_YYYYMMDD(pInput.CREATE_DTE),
																	 	 REGEXFIND('[0-9]{4}\\-[0-9]+\\-[0-9]+', pInput.CREATE_DTE) => Prof_License_Mari.DateCleaner.fmt_dateYYYYMMDD(pInput.CREATE_DTE),
																											'');
										   
		   self.LAST_UPD_DTE				:= pInput.LAST_UPD_DTE[1..4] + pInput.LAST_UPD_DTE[6..7] + pInput.LAST_UPD_DTE[9..10];
		   self.STAMP_DTE						:= pInput.STAMP_DTE[1..4] + pInput.STAMP_DTE[6..7] + pInput.STAMP_DTE[9..10];
			 self.DATE_FIRST_SEEN 		:= pVersion;
			 self.DATE_LAST_SEEN 			:= pVersion;
			 self.PROCESS_DATE				:= pVersion;
			 self.DATE_VENDOR_FIRST_REPORTED 	:= self.STAMP_DTE;
			 self.DATE_VENDOR_LAST_REPORTED 	:= self.STAMP_DTE;
			 self.GEN_NBR							:= pInput.GEN_NBR;
			 self.TYPE_CD							:= '';
			 self.STD_SOURCE_UPD			:= pInput.STD_SOURCE_UPD;
			 self.STD_SOURCE_DESC			:= '';
			 self.STD_PROF_CD					:= pInput.STD_PROF_CD;
			 self.STD_PROF_DESC 			:= CASE(pInput.STD_PROF_CD,
																				'APR' => 	'APPRAISERS',
																				'LND'	=> 	'OTHER LENDING',
																				'MTG'	=>	'MORTGAGE LENDERS',
																				'RLE'	=>	'REAL ESTATE',
																							'');
			 self.RAW_LICENSE_TYPE 		:= '';
			 self.STD_LICENSE_TYPE		:= '';
			 self.STD_LICENSE_DESC 		:= ut.fnTrim2Upper(pInput.STD_LICENSE_TYPE);
			 self.RAW_LICENSE_STATUS 	:= '';
			 self.STD_LICENSE_STATUS	:= '';
			 self.STD_STATUS_DESC 		:= ut.fnTrim2Upper(pInput.STD_LICENSE_STATUS);
			 self.NAME_ORG_PREFX			:= ut.fnTrim2Upper(pInput.NAME_ORG_PREFX);																	
			 self.NAME_ORG						:= ut.fnTrim2Upper(pInput.NAME_ORG);
			 self.NAME_ORG_SUFX				:= ut.fnTrim2Upper(pInput.NAME_ORG_SUFX);
			 self.NAME_DBA_PREFX			:= ut.fnTrim2Upper(pInput.NAME_DBA_PREFX);
			 self.NAME_DBA						:= ut.fnTrim2Upper(pInput.NAME_DBA);
			 self.NAME_DBA_SUFX				:= ut.fnTrim2Upper(pInput.NAME_DBA_SUFX);
			 self.NAME_OFFICE 				:= ut.fnTrim2Upper(pInput.NAME_OFFICE);
			 self.OFFICE_PARSE 				:= ut.fnTrim2Upper(pInput.OFFICE_PARSE);
			 self.NAME_PREFX					:= ut.fnTrim2Upper(pInput.NAME_PREFX);
			 self.NAME_FIRST					:= ut.fnTrim2Upper(pInput.NAME_FIRST);
		   self.NAME_MID						:= ut.fnTrim2Upper(pInput.NAME_MID);
		   self.NAME_LAST						:= ut.fnTrim2Upper(pInput.NAME_LAST);
		   self.NAME_SUFX						:= ut.fnTrim2Upper(pInput.NAME_SUFX);
			 self.NAME_NICK						:= ut.fnTrim2Upper(pInput.NAME_NICK);
		   self.LICENSE_NBR					:= pInput.LICENSE_NBR;
		   self.CURR_ISSUE_DTE			:= Prof_License_Mari.DateCleaner.fmt_dateYYYYMMDD(pInput.CURR_ISSUE_DTE[1..10]);
		   self.ORIG_ISSUE_DTE			:= Prof_License_Mari.DateCleaner.fmt_dateYYYYMMDD(pInput.ORIG_ISSUE_DTE[1..10]);
		   self.EXPIRE_DTE					:= Prof_License_Mari.DateCleaner.fmt_dateYYYYMMDD(pInput.EXPIRE_DTE[1..10]);
			 self.PHN_MARI_1					:= ''; 
			 self.PHN_MARI_FAX_1			:= '';
			 self.BIRTH_DTE 					:= '';	
			 self.ADDR_BUS_IND 				:= (STRING1)pInput.ADDR_BUS_IND_1;
		   self.ADDR_ADDR1_1				:= ut.fnTrim2Upper(pInput.ADDR_ADDR1_1);
			 self.ADDR_ADDR2_1				:= ut.fnTrim2Upper(pInput.ADDR_ADDR2_1);;
			 self.ADDR_ADDR3_1				:= '';
			 self.ADDR_ADDR4_1				:= '';
			 self.ADDR_CITY_1					:= ut.fnTrim2Upper(pInput.ADDR_CITY_1);;
		   self.ADDR_STATE_1				:= ut.fnTrim2Upper(pInput.ADDR_STATE_1);
		   self.ADDR_ZIP5_1					:= pInput.ADDR_ZIP5_1;
		   self.ADDR_ZIP4_1					:= pInput.ADDR_ZIP4_1;
			 self.ADDR_CNTRY_1 				:= ut.fnTrim2Upper(pInput.ADDR_CNTRY_1);
			 self.PHN_PHONE_1					:= stringlib.stringfilterout(pInput.PHN_PHONE_1,'-');; 
			 self.PHN_FAX_1						:= stringlib.stringfilterout(pInput.PHN_FAX_1,'-'); 
			 self.NAME_MARI_ORG	    	:= '';
			 self.NAME_MARI_DBA	    	:= '';
			 self.PROVNOTE_1 					:= ut.fnTrim2Upper(pInput.PROVNOTE_1);											
			 self.PROVNOTE_2 					:= '';
			 self.PROVNOTE_3 					:= '';
			 self.MLTRECKEY						:= 0;
			 self.CMC_SLPK						:=  HASH64(ut.fnTrim2Upper(pInput.license_nbr) 			+ ','
																					+ut.fnTrim2Upper(pInput.off_license_nbr)	+ ','
																					+ut.fnTrim2Upper(pInput.std_license_type) + ','
																					+ut.fnTrim2Upper(pInput.std_source_upd) 	+ ','
																					+ut.fnTrim2Upper(pInput.NAME_ORG) 				+ ','
																					+ut.fnTrim2Upper(pInput.NAME_FIRST)				+ ','
																					+ut.fnTrim2Upper(pInput.NAME_MID)					+ ','
																					+ut.fnTrim2Upper(pInput.NAME_LAST)				+ ','
																					+ut.fnTrim2Upper(pInput.NAME_SUFX)				+ ','
																					+ut.fnTrim2Upper(pInput.ADDR_ADDR1_1) 		+ ','
																					+ut.fnTrim2Upper(pInput.ADDR_ADDR2_1) 		+ ','
																					+ut.fnTrim2Upper(pInput.ADDR_CITY_1) 			+ ','
																					+ut.fnTrim2Upper(pInput.ADDR_ZIP5_1));
			self.PCMC_SLPK 					:= 0;					
			self.AFFIL_KEY					:= pInput.AFFIL_KEY;
			self.PREV_PRIMARY_KEY 	:= pInput.PRIMARY_KEY;
			self.PREV_MLTRECKEY	  	:= pInput.MLTRECKEY;
			self.PREV_CMC_SLPK			:= pInput.CMC_SLPK;
			self.PREV_PCMC_SLPK 		:= pInput.PCMC_SLPK;
	
			self := pInput;
			self := [];
END;

dsCmrFlat_Test     := PROJECT(inFile_base, xformCmrFlat(left));

d_final := output(dsCmrFlat_Test	, ,'~thor_data400::in::proflic_mari::'+pVersion+'::cmrflat_test',__compressed__,overwrite);
		
add_super := sequential(fileservices.startsuperfiletransaction(),
													fileservices.addsuperfile('~thor_data400::in::proflic_mari::cmrflat_test','~thor_data400::in::proflic_mari::'+pVersion+'::cmrflat_test'),
													fileservices.finishsuperfiletransaction()
													);

return sequential(d_final, add_super);


end;



