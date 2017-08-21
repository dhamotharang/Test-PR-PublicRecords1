//Map the MARI clean output file to the cmrflat file for delivery to Reston
import ut, Address,Prof_License_Mari ,lib_stringlib ,Lib_FileServices ;

export map_MariClean_2_cmrflat(string pVersion) := function

#workunit('name','Prof License MARI - cmrflat build ' + pVersion);

dsMariCleanIn	:= Prof_License_Mari.file_mari_search;
CountyNames		:= Address.County_Names;

//Translate county names
Prof_License_Mari.layouts.final transformBusCntyNames(dsMariCleanIn L,CountyNames R)	:= TRANSFORM
	self.ADDR_CNTY_1	:= IF(TRIM(L.ADDR_CNTY_1) = ' ',R.county_name,L.ADDR_CNTY_1);
	self	:= L;
END;

BusCntyName		:= join(dsMariCleanIn, CountyNames,
											TRIM(left.BUS_ACE_FIPS_ST,right,left) = TRIM(right.state_code,left,right)
											AND	TRIM(left.BUS_COUNTY,right,left) = TRIM(right.county_code),
											transformBusCntyNames(left,right),left outer,lookup);

Prof_License_Mari.layouts.final transformMailCntyNames(BusCntyName L,CountyNames R)	:= TRANSFORM
	self.ADDR_CNTY_2	:= IF(TRIM(L.ADDR_CNTY_2) = ' ',R.county_name,L.ADDR_CNTY_2);
	self	:= L;
END;

MailCntyName	:= join(BusCntyName, CountyNames,
											TRIM(left.MAIL_ACE_FIPS_ST,right,left) = TRIM(right.state_code,left,right)
											AND	TRIM(left.MAIL_COUNTY,right,left) = TRIM(right.county_code),
											transformMailCntyNames(left,right),left outer,lookup);


//MariClean to cmrflat(Reston) layout
Prof_License_Mari.layout_cmrflat	transformToCmrflat(MailCntyName pInput) := TRANSFORM
		self.PRIMARY_KEY		:= pInput.PRIMARY_KEY;
		self.CREATE_DTE			:= IF(trim(pInput.CREATE_DTE) = '','',
															pInput.CREATE_DTE[1..4]+'-'+pInput.CREATE_DTE[5..6]+'-'+pInput.CREATE_DTE[7..8]+' '+'00:00:00.000');
		self.LAST_UPD_DTE		:= IF(trim(pInput.LAST_UPD_DTE) = '','',
															pInput.LAST_UPD_DTE[1..4]+'-'+pInput.LAST_UPD_DTE[5..6]+'-'+pInput.LAST_UPD_DTE[7..8]+' '+'00:00:00.000');
		self.STAMP_DTE			:= IF(trim(pInput.STAMP_DTE) = '','',
															pInput.STAMP_DTE[1..4]+'-'+pInput.STAMP_DTE[5..6]+'-'+pInput.STAMP_DTE[7..8]+' '+'00:00:00.000');
		self.GEN_NBR				:= pInput.GEN_NBR;
		self.PROF_CD				:= pInput.STD_PROF_CD;
		self.TYPE_CD				:= pInput.TYPE_CD;
		self.SOURCE_UPD			:= pInput.STD_SOURCE_UPD;
		self.NAME_PREFX			:= pInput.TITLE;
		self.NAME_FIRST			:= pInput.FNAME;
		self.NAME_MID				:= pInput.MNAME;
		self.NAME_LAST			:= pInput.LNAME;
		self.NAME_SUFX			:= pInput.NAME_SUFFIX;
		self.NAME_NICK			:= pInput.NAME_NICK;
		tmpBIRTH_DTE := if(pInput.BIRTH_DTE != '', pInput.BIRTH_DTE,'00000000');
		self.DOB_MM					:= tmpBIRTH_DTE[5..6];
		self.DOB_DD					:= tmpBIRTH_DTE[7..8];
		self.DOB_YYYY				:= tmpBIRTH_DTE[1..4];
		self.LICENSE_NBR		:= pInput.LICENSE_NBR;
		self.OFFICIAL_LICENSE_NBR	:= pInput.OFF_LICENSE_NBR;
		self.LICENSE_STATE := pInput.LICENSE_STATE;
		self.LICENSE_TYPE		:= pInput.STD_LICENSE_DESC;
		self.LICENSE_STATUS	:= pInput.STD_STATUS_DESC;
		self.CURR_ISS_DTE		:= 	IF(trim(pInput.CURR_ISSUE_DTE) = '','',pInput.CURR_ISSUE_DTE[1..4]+'-'+pInput.CURR_ISSUE_DTE[5..6]+'-'+pInput.CURR_ISSUE_DTE[7..8]+' '+'00:00:00.000');
		self.ISSUE_DTE			:= 	IF(trim(pInput.ORIG_ISSUE_DTE) = '','',pInput.ORIG_ISSUE_DTE[1..4]+'-'+pInput.ORIG_ISSUE_DTE[5..6]+'-'+pInput.ORIG_ISSUE_DTE[7..8]+' '+'00:00:00.000');
		self.EXPIRE_DTE			:= 	if(trim(pInput.EXPIRE_DTE) = '','',pInput.EXPIRE_DTE[1..4]+'-'+pInput.EXPIRE_DTE[5..6]+'-'+pInput.EXPIRE_DTE[7..8]+' '+'00:00:00.000');
		self.ADDR_BUS_IND_1		:= IF(TRIM(pInput.ADDR_BUS_IND)='B',1,0);
		self.ADDR_MAIL_IND_1	:= 0;
		self.ADDR_HOME_IND_1	:= 0;
		self.ADDR_ID_1			:= pInput.ADDR_ID_1;
		self.ADDR_ADDR1_1		:= StringLib.StringCleanSpaces(pInput.BUS_PRIM_RANGE+' '+pInput.BUS_PREDIR+' '+pInput.BUS_PRIM_NAME+' '+pInput.BUS_ADDR_SUFFIX+' '+pInput.BUS_POSTDIR);
		self.ADDR_ADDR2_1		:= 	StringLib.StringCleanSpaces(pInput.BUS_UNIT_DESIG+' '+pInput.BUS_SEC_RANGE);
		self.ADDR_CITY_1		:= pInput.BUS_P_CITY_NAME;
		self.ADDR_STATE_1		:= pInput.BUS_STATE;
		self.ADDR_ZIP5_1		:= pInput.BUS_ZIP5;
		self.ADDR_ZIP4_1		:= pInput.BUS_ZIP4;
		self.ADDR_CNTY_1		:= pInput.ADDR_CNTY_1;
		self.ADDR_CNTRY_1		:= pInput.ADDR_CNTRY_1;
		self.SUD_KEY_1			:= pInput.SUD_KEY_1;
		self.OOC_IND_1			:= pInput.OOC_IND_1;
		self.RESULT_CD_1		:= pInput.RESULT_CD_1;
		self.ADDR_CARRIER_RTE_1	:= pInput.BUS_CART;
		self.ADDR_DELIVERY_PT_1	:= pInput.BUS_DPBC;
		self.ADDR_BUS_IND_2			:= 0;
		self.ADDR_MAIL_IND_2		:= IF(TRIM(pInput.ADDR_MAIL_IND)='M',1,0);
		self.ADDR_HOME_IND_2		:= 0;
		self.ADDR_ID_2			:= pInput.ADDR_ID_2;
		self.ADDR_ADDR1_2		:= StringLib.StringCleanSpaces(pInput.MAIL_PRIM_RANGE+' '+pInput.MAIL_PREDIR+' '+pInput.MAIL_PRIM_NAME+' '+pInput.MAIL_ADDR_SUFFIX+' '+pInput.MAIL_POSTDIR);
		self.ADDR_ADDR2_2		:= StringLib.StringCleanSpaces(pInput.MAIL_UNIT_DESIG+' '+pInput.MAIL_SEC_RANGE);
		self.ADDR_CITY_2		:= pInput.MAIL_P_CITY_NAME;
		self.ADDR_STATE_2		:= pInput.MAIL_STATE;
		self.ADDR_ZIP5_2		:= pInput.MAIL_ZIP5;
		self.ADDR_ZIP4_2		:= pInput.MAIL_ZIP4;
		self.ADDR_CNTY_2		:= pInput.ADDR_CNTY_2;
		self.ADDR_CNTRY_2		:= pInput.ADDR_CNTRY_2;
		self.SUD_KEY_2			:= pInput.SUD_KEY_2;
		self.OOC_IND_2			:= pInput.OOC_IND_2;
		self.RESULT_CD_2		:= pInput.RESULT_CD_2;
		self.ADDR_CARRIER_RTE_2		:= pInput.MAIL_CART;
		self.ADDR_DELIVERY_PT_2		:= pInput.MAIL_DPBC;
		self.INST_BEG_DTE			:= 	if(trim(pInput.INST_BEG_DTE)= '','',pInput.INST_BEG_DTE[1..4]+'-'+pInput.INST_BEG_DTE[5..6]+'-'+pInput.INST_BEG_DTE[7..8]+' '+'00:00:00.000');
		SELF := pInput;
		SELF := [];		   		   
END;

dsCmrflatOut := project(MailCntyName(std_source_upd != ''), transformToCmrflat(left)): persist('~thor_data400::persist::proflic_mari::fullfillment');

removeNMLS := dsCmrflatOut(source_upd not in ['S0900','S0376']);
getS0376_APR := dsCmrflatOut(source_upd = 'S0376' and prof_cd in ['APR','RLE','LND']);

dOutCmrflat := removeNMLS + getS0376_APR;

rLatestUpdate := record
STRING5		SOURCE_UPD;
STRING		LAST_UPD_DTE;
end;

dsLatestUpdate := sort(distribute(dedup(project(dOutCmrflat, TRANSFORM(rLatestUpdate,self := left)),record,all), hash(source_upd)), source_upd, last_upd_dte,local);

rLatestUpdate  Xform(rLatestUpdate  L, rLatestUpdate  R) := TRANSFORM
SELF.LAST_UPD_DTE :=  if(l.last_upd_dte  > r.last_upd_dte, l.last_upd_dte, r.last_upd_dte);;
SELF := L; 
END;


file_rollup := ROLLUP(dsLatestUpdate,
													trim(LEFT.source_upd)= trim(RIGHT.source_upd),
													 Xform(LEFT, RIGHT));

dsLatestLookup := output(file_rollup,,'~thor_data400::out::proflic_mari::latest_upd_date_fulfillment',overwrite);

Prof_License_Mari.layout_cmrflat JoinLatestUpdate(dOutCmrflat le, file_rollup ri) := transform
	self  := le;
END;
						
CurrentRecs		:=	join(dOutCmrflat, file_rollup,	
													TRIM(LEFT.SOURCE_UPD,LEFT,RIGHT) = TRIM(RIGHT.SOURCE_UPD,LEFT,RIGHT)
													AND left.LAST_UPD_DTE[1..10] = right.LAST_UPD_DTE[1..10],
													JoinLatestUpdate(LEFT,RIGHT), INNER, LOOKUP);
													


ds_final := output(dedup(CurrentRecs(source_upd in Prof_License_Mari.Cur_Source_Update),record,all),,'~thor_data400::out::proflic_mari::'+pVersion+'::cmrflat_out.csv',CSV(HEADING(single),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')),overwrite);
		
add_super := sequential(fileservices.startsuperfiletransaction(),
													FileServices.ClearSuperFile('~thor_data400::out::proflic_mari::cmrflat');
													fileservices.addsuperfile('~thor_data400::out::proflic_mari::cmrflat','~thor_data400::out::proflic_mari::'+pVersion+'::cmrflat_out.csv'),
													fileservices.finishsuperfiletransaction()
													);


return sequential(dsLatestLookup, ds_final, add_super);

end;