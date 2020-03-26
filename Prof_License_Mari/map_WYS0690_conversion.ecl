/* Converting Wyoming Division of Banking License File to MARI common layout
// Logic linking DBA to Corp needs additonal business logic which should be resolve with NMLS system
*/
IMPORT ut
		 ,Prof_License_Mari
		 ,lib_stringlib
		 ,Lib_FileServices
		 ,Address
		 ;

EXPORT  map_WYS0690_conversion(STRING pVersion) := FUNCTION
#workunit('name','Prof License MARI- WYS0690 ' + pVersion); 
	
src_cd	:= 'S0690';
license_state := 'WY';

inFile := Prof_License_Mari.files_WYS0690.mtg_lnd;

//Reference Files for lookup joins
cmvTransLkp	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD ='S0690');
LicTypeLkp	:= Prof_License_Mari.files_References.MARIcmvLicType(SRC_UPD ='S0690');
LicProfLkp	:= Prof_License_Mari.files_References.MARIcmvProf;
LicSrcLkp		:= Prof_License_Mari.files_References.MARIcmvSrc(SRC_NBR ='S0690'); 
LicStatusLkp	:=	Prof_License_Mari.files_References.MARIcmvLicStatus;
	
Comments	:= 'THIS IS NOT A MAIN OFFICE. IT IS A BRANCH OFFICE WITHOUT AN ASSOCIATED MAIN OFFICE FROM THIS SOURCE.';

C_O_Ind := '(C/O |ATTN:|ATTN|ATTENTION:|ATT:)';
DBA_Ind := '( DBA|D/B/A | D/B/A|/DBA | A/K/A | AKA|T/A | DBA )';
quote_pattern	:= '^(.*)\\"(.*)\\"(.*)$';
paren_pattern := '^(.*)\\((.*)\\)(.*)$';
dbl_quote_pattern := '^(.*)\\"\\"(.*)\\"\\"(.*)$';

//Filtering out "BAD" records per requirements
isNonBlankRec 	:= inFile(TRIM(ENTITYNAME,LEFT,RIGHT)+ TRIM(ADDRESS1,LEFT,RIGHT) <> ''); 
isGoodRecs	:= isNonBlankRec(NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(ENTITYNAME)));

maribase_plus_dbas := RECORD, maxsize(5000)
  Prof_License_Mari.layout_base_in;
	STRING60 dba1;
	STRING60 dba2;
	STRING60 dba3;
	STRING60 dba4;
	STRING60 dba5;
END;

maribase_plus_dbas		xformToCommon(isGoodRecs pInput)
:= 
	TRANSFORM
		SELF.PRIMARY_KEY	    := 0;  
		SELF.DATE_FIRST_SEEN	:= thorlib.wuid()[2..9];
		SELF.DATE_LAST_SEEN		:= thorlib.wuid()[2..9];
		SELF.DATE_VENDOR_FIRST_REPORTED := pInput.ln_filedate;
		SELF.DATE_VENDOR_LAST_REPORTED	:= pInput.ln_filedate;
		SELF.CREATE_DTE				:= thorlib.wuid()[2..9]; //yyyymmdd
		SELF.PROCESS_DATE			:= thorlib.wuid()[2..9];
		SELF.LAST_UPD_DTE			:= pInput.ln_filedate;
		SELF.STAMP_DTE				:= pInput.ln_filedate; //yyyymmdd
		SELF.STD_PROF_CD			:= '';
		SELF.STD_PROF_DESC    := '';
		SELF.STD_SOURCE_UPD		:= src_cd;
		SELF.STD_SOURCE_DESC  := '';
		SELF.TYPE_CD					:= 'GR';
		
		TrimNAME_FULL	:= ut.CleanSpacesAndUpper(pInput.ENTITYNAME);
		TrimDBA				:= ut.CleanSpacesAndUpper(pInput.DBA);
		TrimLicTYPE   := ut.CleanSpacesAndUpper(pInput.STD_LIC_TYPE); 
		TrimStatus		:= ut.CleanSpacesAndUpper(pInput.STATUS);
		TrimAddress1	:= ut.CleanSpacesAndUpper(pInput.ADDRESS1);
		TrimAddress2	:= ut.CleanSpacesAndUpper(pInput.ADDRESS2);
		TrimCity			:= ut.CleanSpacesAndUpper(pInput.CITY);	
		tempStoreNbr	:= MAP(StringLib.stringfind(TrimNAME_FULL,'""',1) >0 AND REGEXFIND(dbl_quote_pattern,TrimNAME_FULL)  
														=> REGEXFIND(dbl_quote_pattern,TrimNAME_FULL,2),
													 StringLib.stringfind(TrimNAME_FULL,'"',1) >0 => REGEXFIND(quote_pattern,TrimNAME_FULL,2),
													 StringLib.stringfind(TrimNAME_FULL,'(',1) >0 AND REGEXFIND(paren_pattern,TrimNAME_FULL)
														=> REGEXFIND(paren_pattern,TrimNAME_FULL,2),
														' ');																				
//Removing StoreNumber Name fields
	  removeStoreNbr		:= MAP(StringLib.StringFind(tempStoreNbr,'(',1) > 0 => StringLib.StringFindReplace(TrimNAME_FULL,tempStoreNbr,''),
												 StringLib.StringFind(tempStoreNbr,'"',1) >= 1 => REGEXREPLACE(tempStoreNbr,TrimNAME_FULL,''),
												 StringLib.StringFind(TrimNAME_FULL,'"',1) > 0 => REGEXREPLACE('\"'+ tempStoreNbr +'\"',TrimNAME_FULL,''),
																					StringLib.StringFindReplace(TrimNAME_FULL,'('+ tempStoreNbr +')','')
																																									);
		stripStoreNbr	:= StringLib.StringCleanSpaces(Prof_License_Mari.mod_clean_name_addr.strippunctName(removeStoreNbr));
		GoodName	    := IF(tempStoreNbr != '' AND REGEXFIND('[0-9]',tempStoreNbr),stripStoreNbr,TrimNAME_FULL);

//Identify DBA Names
    prepNAME_ORG := MAP(REGEXFIND('WITH DBA\'S',GoodName) => REGEXREPLACE('WITH DBA\'S',GoodName,''),
		                    StringLib.stringfind(GoodName,'/',1)> 0 AND NOT REGEXFIND('( D/B/A | A/K/A | T/A)',GoodName) 
																				=> StringLib.StringFindReplace(GoodName,'/',' '), 
												 REGEXFIND(DBA_Ind,GoodName)=> REGEXREPLACE(DBA_Ind,GoodName, ' /'),								
																						GoodName);
		getNAME_ORG := IF(StringLib.Stringfind(prepNAME_ORG,'/',1) > 0 ,REGEXFIND('([A-Za-z ][^\\/]+)[\\/]',prepNAME_ORG,1),prepNAME_ORG);
		StdNAME_ORG := Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(TRIM(getNAME_ORG,LEFT,RIGHT));
		CleanNAME_ORG	:= MAP(REGEXFIND('(([A-Za-z ]+)([\\(]THE[\\)]$)+)',StdNAME_ORG) => REGEXFIND('(([A-Za-z ]+)([\\(]THE[\\)]$)+)',StdNAME_ORG,2), 	
												 REGEXFIND('(.COM|.NET|.ORG)',StdNAME_ORG) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_ORG),
		                     REGEXFIND('(%)',StdNAME_ORG) => REGEXFIND('^([A-Za-z0-9 ][^\\,]+)',StdNAME_ORG,1),
												 REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,LEFT,RIGHT))
														OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT))
														OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT)) => StdNAME_ORG,
													REGEXFIND('^([A-Za-z \\.]*)(INC|THE)([A-Za-z ]*)',TRIM(StdNAME_ORG,LEFT,RIGHT))
																		AND NOT REGEXFIND('( INC$| THE$)',TRIM(StdNAME_ORG,LEFT,RIGHT))=> StdNAME_ORG,													
									   														Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG));		
		
		SELF.NAME_ORG_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG); 
		SELF.NAME_ORG		    	:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(CleanNAME_ORG,'()',''));
		
		tmpORG_SUFX := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG));
		SELF.NAME_ORG_SUFX	  := StringLib.StringFilterOut(tmpORG_SUFX,' ');
		SELF.STORE_NBR				:= IF(REGEXFIND('[0-9]',tempStoreNbr),StringLib.StringCleanSpaces(REGEXREPLACE('(LIC)',tempStoreNbr,'')),'');
		SELF.DBA_FLAG  			:= 0;
		
		ParsedName	:= IF(StdNAME_ORG != '' AND NOT Prof_License_Mari.func_is_company(TRIM(StdNAME_ORG,LEFT,RIGHT)),
																	Address.CleanPersonFML73(StdNAME_ORG),''); 
		SELF.NAME_FIRST		  		:= TRIM(ParsedName[6..25],LEFT,RIGHT);
		SELF.NAME_MID						:= TRIM(ParsedName[26..45],LEFT,RIGHT);									
		SELF.NAME_LAST		  		:= TRIM(ParsedName[46..65],LEFT,RIGHT); 
		SELF.NAME_SUFX					:= TRIM(ParsedName[66..70],LEFT,RIGHT);
		SELF.NAME_NICK      		:=  '';  	
		SELF.LICENSE_NBR				:= IF(pInput.LIC_NUM != '',pInput.LIC_NUM,'NR');
		SELF.LICENSE_STATE			:= license_state;
		SELF.RAW_LICENSE_TYPE		:= TrimLicTYPE; 	
		SELF.STD_LICENSE_TYPE		:= pInput.STD_LIC_TYPE;
		SELF.STD_LICENSE_DESC		:= '';
		SELF.RAW_LICENSE_STATUS	:= TrimStatus;
		SELF.STD_LICENSE_STATUS	:= '';
		SELF.STD_STATUS_DESC		:= '';
		
		//Reformatting date to YYYYMMDD
		SELF.CURR_ISSUE_DTE		:= IF(pInput.DATESTART != '',Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.DATESTART),'17530101');
		SELF.ORIG_ISSUE_DTE		:= '17530101';
		SELF.EXPIRE_DTE				:= IF(pInput.DATEEND != '',Prof_License_Mari.DateCleaner.fmt_dateMMDDYYYY(pInput.DATEEND),'17530101');
		SELF.RENEWAL_DTE			:= '';
		SELF.NAME_FORMAT			:= 'F';
		SELF.NAME_ORG_ORIG		:= TrimNAME_FULL;
		SELF.NAME_DBA_ORIG		:= TrimDBA;
		SELF.NAME_MARI_ORG		:= StdNAME_ORG;
		SELF.NAME_MARI_DBA		:= prepNAME_ORG;
		SELF.PHN_MARI_1				:= ut.CleanPhone(pInput.PHONE);
		
		prepAddr1 := IF(REGEXFIND(C_O_Ind,TrimAddress1),Prof_License_Mari.mod_clean_name_addr.GetCorpName(TrimAddress1),TrimAddress1);
		prepAddr2 := IF(REGEXFIND(C_O_Ind,TrimAddress2),Prof_License_Mari.mod_clean_name_addr.GetCorpName(TrimAddress2),TrimAddress2);
		SELF.ADDR_BUS_IND		:= IF(TRIM(TrimAddress1 + TrimAddress2 + TrimCity + pInput.ZIPCODE) != '','B','');		
		SELF.ADDR_ADDR1_1		:= prepAddr1;
		SELF.ADDR_ADDR2_1		:= prepAddr2;
		SELF.ADDR_ADDR3_1		:= '';
		SELF.ADDR_ADDR4_1		:= '';
		SELF.ADDR_CITY_1		:= TrimCity;
		SELF.ADDR_STATE_1		:= ut.CleanSpacesAndUpper(pInput.STATE);
		
		ParsedZIP := REGEXFIND('[0-9]{5}(-[0-9]{4})?', pInput.ZIPCODE, 0);
		SELF.ADDR_ZIP5_1		:= ParsedZIP[1..5];
		SELF.ADDR_ZIP4_1		:= ParsedZIP[7..10];
		SELF.PHN_PHONE_1		:= SELF.PHN_MARI_1;
	
		tmpContactName	:= MAP(REGEXFIND(C_O_Ind,TrimAddress1) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress1),
									         REGEXFIND(C_O_Ind,TrimAddress2) => Prof_License_Mari.mod_clean_name_addr.GetDBAName(TrimAddress2),
																	'');
		stripContactName	:= IF(StringLib.Stringfind(tmpContactName,',',1) > 0,
																REGEXFIND('^([A-Za-z ][^\\,]+)[\\,]([A-Za-z ]+)',tmpContactName,1),tmpContactName);
		ParseContact			:= IF(stripContactName != '' AND NOT Prof_License_Mari.func_is_company(stripContactName),
																Address.CleanPersonFML73(stripContactName),'');
		SELF.NAME_CONTACT_PREFX	:= TRIM(ParseContact[1..5],LEFT,RIGHT);
		SELF.NAME_CONTACT_FIRST	:= TRIM(ParseContact[6..25],LEFT,RIGHT);  
		SELF.NAME_CONTACT_MID		:= TRIM(ParseContact[26..45],LEFT,RIGHT);  
		SELF.NAME_CONTACT_LAST	:= TRIM(ParseContact[46..65],LEFT,RIGHT);  
		SELF.NAME_CONTACT_SUFX	:= TRIM(ParseContact[66..70],LEFT,RIGHT);  
		SELF.NAME_CONTACT_NICK	:= '';
		SELF.NAME_CONTACT_TTL	:= IF(StringLib.Stringfind(tmpContactName,',',1) > 0,
																REGEXFIND('^([A-Za-z ][^\\,]+)[\\,]([A-Za-z ]+)',tmpContactName,2),'');

		// Business rules to standardize DBA(s) for splitting into multiple records
		SELF.dba1				:=  MAP(TrimDBA != '' => TrimDBA,
														StringLib.stringfind(prepNAME_ORG,'/',1) > 0 AND StringLib.stringfind(prepNAME_ORG,';',1) > 0 
																=> REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',prepNAME_ORG,1),
														StringLib.stringfind(prepNAME_ORG,'/',2) > 0 AND StringLib.stringfind(prepNAME_ORG,';',1) > 0 
																=> REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',prepNAME_ORG,1),  
														StringLib.stringfind(prepNAME_ORG,'/',1) > 0 AND REGEXFIND('^([A-Za-z][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)',prepNAME_ORG)
																=> REGEXFIND('^([A-Za-z][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)',prepNAME_ORG,2),
														StringLib.stringfind(prepNAME_ORG,';',1) > 0 => REGEXFIND('^([A-Za-z][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',prepNAME_ORG,2),
									   		   										'');
		  
		SELF.dba2				:= MAP(StringLib.stringfind(prepNAME_ORG,'/',1) > 0 AND StringLib.stringfind(prepNAME_ORG,';',1) > 0 
															=> REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',prepNAME_ORG,2),
										   		 StringLib.stringfind(prepNAME_ORG,'/',2) > 0 AND StringLib.stringfind(prepNAME_ORG,';',1) > 0 
															=> REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',prepNAME_ORG,2),	  
										       StringLib.stringfind(prepNAME_ORG,'/',2) > 0 => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)',prepNAME_ORG,3),
									         StringLib.stringfind(prepNAME_ORG,';',1) > 0 => REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',prepNAME_ORG,3),
									   									   		   ' ');
						
		SELF.dba3 				:= MAP(StringLib.stringfind(prepNAME_ORG,'/',1) > 0 AND StringLib.stringfind(prepNAME_ORG,';',1) > 0 =>
										  REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',prepNAME_ORG,3),
									    StringLib.stringfind(prepNAME_ORG,'/',2) > 0 AND StringLib.stringfind(prepNAME_ORG,';',1) > 0 =>	  
										  REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',prepNAME_ORG,3),
									    StringLib.stringfind(prepNAME_ORG,'/',3) > 0  
											AND REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)',prepNAME_ORG)
												=> REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)',prepNAME_ORG,4),
										
									   StringLib.stringfind(prepNAME_ORG,'/',3) > 0 
											AND REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[\\/][ ]([0-9A-Za-z ])$',prepNAME_ORG)
									   
									   => REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[\\/][ ]([0-9A-Za-z ])$',prepNAME_ORG,4),
																		            	'');
			
		SELF.dba4 				:= MAP(StringLib.stringfind(prepNAME_ORG,'/',1) > 0 AND StringLib.stringfind(prepNAME_ORG,';',1) > 0 =>
										  REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',prepNAME_ORG,4),
									    StringLib.stringfind(prepNAME_ORG,'/',2) > 0 AND StringLib.stringfind(prepNAME_ORG,';',1) > 0 =>	  
										  REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',prepNAME_ORG,4),
									    StringLib.stringfind(prepNAME_ORG,'/',4) > 0 
											AND REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)',prepNAME_ORG)
											=> REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)',prepNAME_ORG,5), 
									    StringLib.stringfind(prepNAME_ORG,'/',4) > 0 
											AND REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z])$',prepNAME_ORG)
											=> REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z])$',prepNAME_ORG,5), 
																			             '');
			
		SELF.dba5 				:= IF(StringLib.stringfind(prepNAME_ORG,'/',5) > 0,
																REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z][^\\/]+)[/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z])$',prepNAME_ORG,6),
															'');						   
		
		//Expected codes [CO,BR,IN], Set during business/individual filter
		SELF.AFFIL_TYPE_CD		:= 'CO';
										   		
		/* fields used to create mltrec_key unique RECORD split dba key are :
			   transformed license number,standardized license type,standardized source update
			   raw name containing dba name(s),raw address
		*/
		SELF.mltreckey		:= IF(TRIM(SELF.dba1,LEFT,RIGHT) != ' ' AND TRIM(SELF.dba2,LEFT,RIGHT) != ' ' 
														AND TRIM(SELF.dba1,LEFT,RIGHT) != TRIM(SELF.dba2,LEFT,RIGHT),
															HASH32(TRIM(SELF.license_nbr,LEFT,RIGHT) + ','
																	+TRIM(SELF.std_license_type,LEFT,RIGHT) + ','
																	+TRIM(SELF.std_source_upd,LEFT,RIGHT) + ','
																	+TRIM(TrimNAME_FULL,LEFT,RIGHT) + ','
																	+TRIM(TrimAddress1,LEFT,RIGHT) + ','
																	+TRIM(TrimAddress2,LEFT,RIGHT) + ','
																	+TRIM(TrimCity,LEFT,RIGHT) + ','
																	+TRIM(pInput.ZIPCODE,LEFT,RIGHT)),0);
			
		// Fields used to create unique key are: license number, license type, source update, name, address,dba 
		SELF.CMC_SLPK         	:= HASH32(TRIM(SELF.license_nbr,LEFT,RIGHT) + ','
																			+TRIM(SELF.std_license_type,LEFT,RIGHT) + ','
																			+TRIM(SELF.std_source_upd,LEFT,RIGHT) + ','
																			+TRIM(SELF.NAME_ORG,LEFT,RIGHT) + ','
																			+TRIM(TrimAddress1,LEFT,RIGHT) + ','
																			+TRIM(TrimAddress2,LEFT,RIGHT) + ','
																			+TRIM(TrimCity,LEFT,RIGHT) + ','
																			+TRIM(pInput.ZIPCODE,LEFT,RIGHT));
																		   
		SELF.PCMC_SLPK		:= 0;
		SELF.PROVNOTE_1		:= '';
		SELF.PROVNOTE_2		:= '';
		SELF.PROVNOTE_3		:= '';
	
    SELF := [];	
		   
END;
inFileLic	:= PROJECT(isGoodRecs,xformToCommon(left));															
			

// Populate STD_LICENSE_STATUS field via translation on RAW_LICENSE_STATUS field
maribase_plus_dbas 	trans_lic_status(inFileLic L, cmvTransLkp R) := TRANSFORM
	SELF.STD_LICENSE_STATUS := R.DM_VALUE1;
	SELF := L;
END;

ds_map_stat_trans := JOIN(inFileLic, cmvTransLkp,
													TRIM(LEFT.raw_license_status,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
													AND RIGHT.fld_name='LIC_STATUS',
													trans_lic_status(LEFT,RIGHT),LEFT OUTER,LOOKUP);

// Populate STD_PROF_CD field via translation on license type field
maribase_plus_dbas 	trans_lic_type(ds_map_stat_trans L, cmvTransLkp R) := TRANSFORM
	SELF.STD_PROF_CD := R.DM_VALUE1;
	SELF := L;
END;

ds_map_lic_trans := JOIN(ds_map_stat_trans, cmvTransLkp,
												TRIM(LEFT.std_license_type,LEFT,RIGHT)= TRIM(RIGHT.fld_value,LEFT,RIGHT)
												AND RIGHT.fld_name='LIC_TYPE' 
												AND RIGHT.dm_name1 = 'PROFCODE',
												trans_lic_type(LEFT,RIGHT),LEFT OUTER,LOOKUP);
																		
// Normalized DBA records
maribase_dbas := RECORD,MAXLENGTH(5000)
  maribase_plus_dbas;
  STRING60 tmp_dba;
END;

maribase_dbas	NormIT(ds_map_lic_trans L, INTEGER C) := TRANSFORM
    SELF := L;
	SELF.TMP_DBA := CHOOSE(C, L.DBA1, L.DBA2, L.DBA3, L.DBA4, L.DBA5);
END;

NormDBAs 	:= DEDUP(NORMALIZE(ds_map_lic_trans,5,NormIT(LEFT,COUNTER)),ALL,RECORD);

NoDBARecs	:= NormDBAs(TMP_DBA = '' AND DBA1 = '' 
				  AND DBA2 = '' AND DBA3 = '' AND DBA4 = '' AND DBA5 = '');
DBARecs 	:= NormDBAs(TMP_DBA != '');

FilteredRecs  := DBARecs + NoDBARecs;

// Transform expanded dataset to MARIBASE layout
Prof_License_Mari.layout_base_in	 xTransToBase(FilteredRecs L) := TRANSFORM
	
	SELF.NAME_ORG_SUFX		:= StringLib.StringFilterOut(L.NAME_ORG_SUFX, '.');
	StdNAME_DBA	:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(L.TMP_DBA);
	CleanNAME_DBA	:= MAP(REGEXFIND('(.COM|.NET|.ORG)',StdNAME_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanInternetName(StdNAME_DBA),
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_DBA,LEFT,RIGHT))
														OR REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA),
													REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT))
														OR REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_DBA,LEFT,RIGHT)) => StdNAME_DBA,
									   														Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_DBA));
	SELF.NAME_DBA_PREFX		:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_DBA);
	SELF.NAME_DBA					:= cleanNAME_DBA;
	tmpDBASufx := Prof_License_Mari.mod_clean_name_addr.strippunctName(
																	Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_DBA));
	SELF.NAME_DBA_SUFX	  := StringLib.StringFilterOut(tmpDBASufx,' '); 
	SELF.DBA_FLAG					:= IF(SELF.NAME_DBA != '',1,0);	
	SELF.NAME_MARI_ORG		:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(L.NAME_MARI_ORG,'/',' '));
	SELF.NAME_MARI_DBA		:= StringLib.StringCleanSpaces(StringLib.StringFindReplace(StdNAME_DBA,'/',' '));
	SELF := L;
END;

ds_map_base := PROJECT(FilteredRecs, xTransToBase(LEFT));

// Adding to Superfile
d_final   := OUTPUT(ds_map_base, ,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd,__COMPRESSED__,OVERWRITE);
		
add_super := SEQUENTIAL(fileservices.startsuperfiletransaction(),
													fileservices.addsuperfile('~thor_data400::in::proflic_mari::'+src_cd,'~thor_data400::in::proflic_mari::'+pVersion+'::'+src_cd),
													fileservices.finishsuperfiletransaction()
													);

RETURN SEQUENTIAL(d_final,add_super); 
		
END;