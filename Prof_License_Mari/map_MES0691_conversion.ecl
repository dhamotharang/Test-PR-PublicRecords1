// MES0691 / Louisiana Real Estate Commission / Real Estate raw data to common layout for MARI and PL use


import Prof_License, Prof_License_Mari, Address, Ut, Lib_FileServices, lib_stringlib;

src_cd	:= 'S0691'; //Vendor code
src_st	:= 'ME';	//License state

string8 process_date:=(string8)Lib_StringLib.StringLib.GetDateYYYYMMDD();


//input file(s)
mtg_all       := Prof_License_Mari.files_MES0691;

//Remove bad records before processing
ValidFile	:= mtg_all(TRIM(name_1,left,right)+trim(name_1,left,right) != ' ' 
								 AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(name_1))
                 AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(name_1))
								 AND ut.CleanSpacesAndUpper(slnum) != 'LICENSENUMBER');

//Dataset reference files for lookup joins
License_Desc	  := Prof_License_Mari.files_References.MARIcmvLicType(SRC_UPD = 'S0691');
Status_Desc	    := Prof_License_Mari.files_References.MARIcmvLicStatus;
Prof_Desc		    := Prof_License_Mari.files_References.MARIcmvProf;
Src_Desc			  := Prof_License_Mari.files_References.MARIcmvSrc(SRC_NBR = 'S0691');
Disp_Desc       := Prof_License_Mari.files_References.MARIcmvDispType;
Cmvtranslation	:= Prof_License_Mari.files_References.cmvtranslation(SOURCE_UPD ='S0691');

//Pattern for DBA
DBApattern	:= '^(.*)(DBA |C/O |D B A |D/B/A | AKA )(.*)';

//Date Pattern
Datepattern := '^(.*)-(.*)-(.*)$';
                      

maribase_plus_dbas := record,maxlength(5000)
  Prof_License_Mari.layouts_reference.MARIBASE;
  string60 dba;
  string60 dba1;
  string60 dba2;
  string60 dba3;
  string60 dba4;
  string60 dba5;
end;

test_file := choosen(ValidFile,10000);

//raw to MARIBASE layout
maribase_plus_dbas	transformToCommon(Prof_License_Mari.Layout_MES0691 pInput) := TRANSFORM
			self.PRIMARY_KEY	   := 0;  //Generate sequence number (not yet initiated)
			self.CREATE_DTE      := process_date;
			self.LAST_UPD_DTE    := process_date;
			self.STAMP_DTE       := process_date;
			self.STD_SOURCE_UPD	 := src_cd;
		  tempLicNum           := ut.CleanSpacesAndUpper(pInput.slnum);
			self.LICENSE_NBR	   := tempLicNum;
			self.LICENSE_STATE	 := src_st;
			

			// initialize raw_license_type from raw data
			tempRawType  := ut.CleanSpacesAndUpper(pInput.lic_type);
												 
			self.RAW_LICENSE_TYPE := tempRawType;
																	 													          
		  // map raw license type to standard license type before profcode translations
			tempStdLicType        := tempRawType;
																	 
  		self.STD_LICENSE_TYPE := tempStdLicType;

        
			
			// assigning dates per business rules
			trimExpDt            := ut.CleanSpacesAndUpper(pInput.expdt);
			tempExpDt            := if(length(trimExpDt)<9,'0'+trimExpDt,trimExpdt);
			tempExpDt2           := (string)Prof_License_Mari.DateCleaner.FromDDMMMYY(tempExpDt);
		  self.EXPIRE_DTE		   := tempExpDt2;
			trimIssueDt          := ut.CleanSpacesAndUpper(pInput.issuedt);
			tempIssueDate        := if(length(trimIssueDt)<9,'0'+trimIssueDt,trimIssueDt);
			tempIssueDate2       := (string)Prof_License_Mari.DateCleaner.FromDDMMMYY(tempIssueDate);
			self.ORIG_ISSUE_DTE  := tempIssueDate2;
			trimCurIssueDt       := ut.CleanSpacesAndUpper(pInput.curissuedt);
			tempCurIssueDt       := if(length(trimCurIssueDt)<9,'0'+trimCurIssueDt,trimCurIssueDt);
			tempCurIssueDt2      := (string)Prof_License_Mari.DateCleaner.FromDDMMMYY(tempCurIssueDt);
			self.CURR_ISSUE_DTE  := tempCurIssueDt2;
			
			// phone
			tempPhone        := stringlib.stringfindreplace(pInput.tele_1,'(','');
			tempPhone2       := stringlib.stringfindreplace(tempPhone,')','');
			tempPhone3       := stringlib.stringfindreplace(tempPhone2,'-','');
			tempPhone4       := stringlib.stringfindreplace(tempPhone3,'+1','');
			tempPhone5       := stringlib.stringfindreplace(tempPhone4,' ','');
			self.PHN_PHONE_1 := tempPhone5;
			self.PHN_MARI_1  := tempPhone5;
			
			// email
			tempEmail  := ut.CleanSpacesAndUpper(pInput.email_1);
			self.EMAIL := tempEmail;
			
			// fax
			tempFax        := stringlib.stringfindreplace(pInput.fax_1,'(','');
			tempFax2       := stringlib.stringfindreplace(tempFax,')','');
			tempFax3       := stringlib.stringfindreplace(tempFax2,'-','');
			tempFax4       := stringlib.stringfindreplace(tempFax3,'+1','');
			tempFax5       := stringlib.stringfindreplace(tempFax4,' ','');
			self.PHN_FAX_1 := tempFax5;
			self.PHN_MARI_FAX_1  := tempFax5;
				
			//initialize raw_license_status from raw data
			tempRawStatus := ut.CleanSpacesAndUpper(pInput.licstat);
			
			self.RAW_LICENSE_STATUS := tempRawStatus;
			

			
			// assigning type code based on license type
			tempTypeCd		  	:= 'GR';
			self.TYPE_CD      := tempTypeCd;
			                            
	
		// Prepping ORG_NAME to handle various conditions 
		// 1.) Replacing D/B/A with  '|' to separate ORG_NAME & DBA
		// 2.) Handle AKA Names to First, Middle Last Format
		// 3.) Standardized corporation suffixes
		  trimName1        := ut.CleanSpacesAndUpper(pInput.name_1);
			trimName2        := ut.CleanSpacesAndUpper(pInput.name_2);
		  tempTrimName     := map(trimName2 != '' => trimName2,
			                        trimName2 = '' and trimName1 != '' => trimName1, 
			                       '');
			tempTrimNameFix  := if(tempTrimName[1..3]= 'C/O', trim(tempTrimName[4..],left,right),tempTrimName);
			tempTrimNameFix2 := if(tempTrimNameFix[1..4]= 'DBA ', trim(tempTrimNameFix[5..],left,right),tempTrimNameFix);
			tempTrimNameFix3 := stringlib.stringfindreplace(tempTrimNameFix2,'/DBA ',' DBA ');
			tempTrimNameFix4 := stringlib.stringfindreplace(tempTrimNameFix3,' D B A ',' DBA ');
			tempTrimNameFix5 := stringlib.stringfindreplace(tempTrimNameFix4,'RE/GROUP ','RE GROUP ');
			tempTrimNameFix6 := stringlib.stringcleanspaces(tempTrimNameFix5);
			TrimNAME_ORG		 := if(regexfind(DBApattern,tempTrimNameFix6) = true,
												 		 Prof_License_Mari.mod_clean_name_addr.getCorpName(tempTrimNameFix6),
													 	 tempTrimNameFix6);
														 
			// assign mariparse to correctly parse individual names for business records
			tempMariParse     := tempTypeCd;
			mariParse         := map(prof_license_mari.func_is_company(TrimNAME_ORG) = true => 'GR',
			                         prof_license_mari.func_is_company(TrimNAME_ORG) = false => 'MD',
															 tempMariParse);
			
			
			// noquoteORG      := if(mariParse='GR',stringlib.stringfindreplace(TrimNAME_ORG,'"',''),TrimNAME_ORG);
			
			prepNAME_ORG		:= MAP(StringLib.stringfind(TrimNAME_ORG,'D/B/',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'D/B/',' '),
										StringLib.stringfind(TrimNAME_ORG,'T/A',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'T/A',' '),
										StringLib.stringfind(TrimNAME_ORG,'T\\A',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'T\\A',' '),
										StringLib.stringfind(TrimNAME_ORG,'/',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'/',' '),
										StringLib.stringfind(TrimNAME_ORG,'\\',1) >0 => stringlib.stringfindreplace(TrimNAME_ORG,'\\',' '),
										StringLib.stringfind(TrimNAME_ORG,'FLORIDA DEPARTMENT OF TRANSPORTATION (DO',1) >0 
														=> stringlib.stringfindreplace(TrimNAME_ORG,'FLORIDA DEPARTMENT OF TRANSPORTATION (DO','FLORIDA DEPARTMENT OF TRANSPORTATION'),
																	trimNAME_ORG);
										   
			tempNick		:= IF(StringLib.stringfind(prepNAME_ORG,'"',1) >0 and StringLib.stringfind(prepNAME_ORG,'(',1) >0,
										REGEXFIND('^([A-Za-z ][^("]+)[\\(][\\"]([A-Za-z ][^\\"]+)[\\"][\\)]',prepNAME_ORG,2),'');
			
			//Removing NickName from Corporate NAME field
			removeNick		:= IF(tempNick != ' ',REGEXREPLACE(tempNick,prepNAME_ORG,''), prepNAME_ORG);
			
			rmvQuoteORG     := stringlib.stringcleanspaces(Stringlib.Stringfindreplace(removeNick,'"',''));
			StdNAME_ORG		:= IF(rmvQuoteORG != ' ' and NOT Prof_License_Mari.func_is_company(rmvQuoteORG), 
										rmvQuoteORG, Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(rmvQuoteORG));
		
			// use the right parser for name field
			CleanNAME_ORG		:= map(// tempTypeCd = 'GR' and mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.cleanFName(noquoteORG),
									   REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
									   REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,left,right)) => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
									   REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => StdNAME_ORG,
									   REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => StdNAME_ORG,
									   tempTypeCd = 'GR' and mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
									   tempTypeCd = 'GR' and mariParse = 'MD' => Prof_License_Mari.mod_clean_name_addr.cleanFMLName(rmvQuoteORG),
									   tempTypeCd = 'MD' and mariParse = 'MD' => Prof_License_Mari.mod_clean_name_addr.cleanFMLName(rmvQuoteORG),
									   // tempTypeCd = 'MD' and mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.cleanFName(noquoteORG),
									   tempTypeCd = 'MD' and mariParse = 'GR' => Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG),
		                 StdNAME_ORG);
			
			//self.office_parse := mariParse;
			
			self.NAME_ORG_PREFX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG);
																					
			self.NAME_ORG 		:= MAP(mariParse='MD'=> stringlib.stringcleanspaces(CleanNAME_ORG[46..65]+' '+CleanNAME_ORG[66..70]
																+' '+CleanNAME_ORG[6..25]+' '+CleanNAME_ORG[26..45]),
									   StringLib.stringfind(StdNAME_ORG,'.COM',1) >0 and self.TYPE_CD = 'GR' => StringLib.StringFindReplace(CleanNAME_ORG,'COM','.COM'),
																									CleanNAME_ORG);
		
		// Parse out multiple ORG_SUFX(s) from ORG_NAME
			tmpOrgSufx2			:= REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG,2);
			tmpOrgSufx3			:= REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG,3);
			
		 // Parsed out ORG_NAME Suffix
			self.NAME_ORG_SUFX	:= MAP(REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG)=> tmpOrgSufx2 + ' ' + tmpOrgSufx3,
									   NOT REGEXFIND('LLP',StdNAME_ORG) and REGEXFIND('(LP)$',StdNAME_ORG) and self.TYPE_CD = 'GR' => REGEXFIND('(LP)$',StdNAME_ORG,1),
									   REGEXFIND('(L[.]P[.])$',StdNAME_ORG) and self.TYPE_CD = 'GR' => REGEXFIND('(L.P.)$',prepNAME_ORG,1),
									   REGEXFIND('^([A-Za-z ]*)(CORP)[ ](INC)',TRIM(StdNAME_ORG,left,right)) => Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG),
									   REGEXFIND('^([A-Za-z ]*)(CORP)[ ](LLC)',TRIM(StdNAME_ORG,left,right)) => Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG),
									   REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => '',
									   REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => '',
									  											Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG)); 
															
			self.NAME_PREFX     	:= if(mariParse='MD',TRIM(CleanNAME_ORG[1..5],left,right),'');
			self.NAME_FIRST			:= if(mariParse='MD',TRIM(CleanNAME_ORG[6..25],left,right),'');
			self.NAME_MID			:= if(mariParse='MD',TRIM(CleanNAME_ORG[26..45],left,right),'');
			self.NAME_LAST			:= if(mariParse='MD',TRIM(CleanNAME_ORG[46..65],left,right),'');
			self.NAME_SUFX			:= if(mariParse='MD',TRIM(CleanNAME_ORG[66..70],left,right),'');
			self.NAME_NICK			:= MAP(StringLib.stringfind(tempNick,'A/K/A',1)> 0 => REGEXREPLACE('(A/K/A)',tempNick,''),
									   StringLib.stringfind(tempNick,'AKA',1)> 0 => REGEXREPLACE('(AKA)',tempNick,''),
																	tempNick);

			

		   	 
      // office address fields
			tempAdd1_1_1            := ut.CleanSpacesAndUpper(pInput.ADDRESS1_1);
			tempAdd2_1_1            := ut.CleanSpacesAndUpper(pInput.ADDRESS2_1);
      tempAdd3_1_1            := ut.CleanSpacesAndUpper(pInput.ADDRESS3_1);
			
			tempAdd1_1_2            := if(Prof_License_Mari.func_is_address(tempAdd1_1_1) = false,tempAdd2_1_1,tempAdd1_1_1);
			tempAdd1_1_3            := map(tempAdd1_1_2 = '' and tempAdd2_1_1 = '' => tempAdd3_1_1,
			                               tempAdd1_1_2 = '' and tempAdd2_1_1 != '' => tempAdd2_1_1,
																		 tempAdd1_1_2);
			
			tempAdd2_1_2            := if(tempAdd1_1_3 = tempAdd2_1_1,'',tempAdd2_1_1);
			tempAdd2_1_3            := if(tempAdd2_1_2 = '',tempAdd3_1_1,tempAdd2_1_2);
			
			tempAdd3_1_2            := if( (tempAdd2_1_3 = tempAdd3_1_1) or (tempAdd1_1_3 = tempAdd3_1_1),'',tempAdd3_1_1);
			
																
			self.ADDR_ADDR1_1	  := tempAdd1_1_3;
			self.ADDR_ADDR2_1   := tempAdd2_1_3;
			self.ADDR_ADDR3_1   := tempAdd3_1_2;
			
			self.ADDR_CITY_1		:= ut.CleanSpacesAndUpper(pInput.CITY_1);
			tempState           := if(ut.CleanSpacesAndUpper(pInput.STATE_1)='NULL','',
			                          ut.CleanSpacesAndUpper(pInput.STATE_1));
			self.ADDR_STATE_1	  := tempState;
			tempZip3             := ut.CleanSpacesAndUpper(stringlib.stringfindreplace(pInput.ZIP_1,'-',''));
			tempZip4            := stringlib.stringfindreplace(tempZip3,' ','');
			tempZip44           := if(length(tempZip4)=4, '0'+tempZip4, tempZip4);
			self.ADDR_ZIP5_1		:= tempZip44[1..5];
			tempZip4_1        		:= tempZip44[6..9];
			self.ADDR_ZIP4_1    := if(tempZip4_1 = '0000',' ',tempZip4_1);
			
			// second set of address fields
			
			tempAdd1_2_1            := ut.CleanSpacesAndUpper(pInput.ADDRESS1_2);
			tempAdd2_2_1            := ut.CleanSpacesAndUpper(pInput.ADDRESS2_2);
      tempAdd3_2_1            := ut.CleanSpacesAndUpper(pInput.ADDRESS3_2);
			
			tempAdd1_2_2            := if(Prof_License_Mari.func_is_address(tempAdd1_2_1) = false,tempAdd2_2_1,tempAdd1_2_1);
			tempAdd1_2_3            := map(tempAdd1_2_2 = '' and tempAdd2_2_1 = '' => tempAdd3_2_1,
			                               tempAdd1_2_2 = '' and tempAdd2_2_1 != '' => tempAdd2_2_1,
																		 tempAdd1_2_2);
			
			tempAdd2_2_2            := if(tempAdd1_2_3 = tempAdd2_2_1,'',tempAdd2_2_1);
			tempAdd2_2_3            := if(tempAdd2_2_2 = '',tempAdd3_2_1,tempAdd2_2_2);
			
			tempAdd3_2_2            := if( (tempAdd2_2_3 = tempAdd3_2_1) or (tempAdd1_2_3 = tempAdd3_2_1),'',tempAdd3_2_1);
			
																
			self.ADDR_ADDR1_2	  := tempAdd1_2_3;
			self.ADDR_ADDR2_2   := tempAdd2_2_3;
			self.ADDR_ADDR3_2   := tempAdd3_2_2;
			
			self.ADDR_CITY_2		:= ut.CleanSpacesAndUpper(pInput.CITY_2);
			tempState2           := if(ut.CleanSpacesAndUpper(pInput.STATE_2)='NULL','',
			                          ut.CleanSpacesAndUpper(pInput.STATE_2));
			self.ADDR_STATE_2	  := tempState2;
			tempZip5             := ut.CleanSpacesAndUpper(stringlib.stringfindreplace(pInput.ZIP_2,'-',''));
			tempZip6            := stringlib.stringfindreplace(tempZip5,' ','');
			tempZip66           := if(length(tempZip6)=4, '0'+tempZip6, tempZip6);
			self.ADDR_ZIP5_2		:= tempZip66[1..5];
			tempZip4_2        		:= tempZip66[6..9];
			self.ADDR_ZIP4_2    := if(tempZip4_2 = '0000',' ',tempZip4_2);
			
			// assign business address indicator to true (B) if business address fields are not empty
			self.ADDR_BUS_IND	  := IF(TRIM(pInput.ADDRESS1_1 + pInput.CITY_1 + pInput.STATE_1 + pInput.ZIP_1,LEFT,RIGHT) != '','B','');
			
			
			//assign officename
			// tempNameOff          := if(tempTypeCd = 'MD',ut.CleanSpacesAndUpper(pInput.contact),'');
			// /*tempNameOff2         := if(tempTypeCd = 'MD' and prof_license_mari.func_is_address(pInput.address1_1)='false' and tempNameOff='',
			                           // ut.CleanSpacesAndUpper(pInput.address1_1),
																 // tempNameOff);*/
															 																 
			// trimNAME_OFFICE     := tempNameOff;
			// self.NAME_OFFICE    := trimNAME_OFFICE;
			
			//office parse
			// tempOffParse      := map(prof_license_mari.func_is_company(trimNAME_OFFICE)= true and trimNAME_OFFICE != ' '=> 'GR',
			                         // prof_license_mari.func_is_company(trimNAME_OFFICE)= false and trimNAME_OFFICE != ' ' => 'MD',
													     // '');
			// self.OFFICE_PARSE := tempOffParse;
      
			// assign two holders for raw data per mari business rules
			self.NAME_ORG_ORIG	:= tempTrimName;
			
			// assign mari_org with semi-clean name data per business rules
			self.NAME_MARI_ORG := StdNAME_ORG; 
			
			
			// Business rules to parse contacts
			trimDept        := ut.CleanSpacesAndUpper(pInput.dept);
			trimCont        := ut.CleanSpacesAndUpper(pInput.contact);
			
			tempContact     := map(trimDept != '' and Prof_License_Mari.func_is_company(trimDept) = false => trimDept,
			                       trimCont != '' and Prof_License_Mari.func_is_company(trimCont) = false => trimCont,
			  								    '');

			prepContact			:= tempContact;
												
			
			stripTitle			:= MAP(StringLib.stringfind(prepContact,'RECEIVER',1)>0 => StringLib.StringFindReplace(prepContact,'RECEIVER',''),
									   StringLib.stringfind(prepContact,'CONSERVATOR',1)>0 => StringLib.StringFindReplace(prepContact,'CONSERVATOR',''),
									   StringLib.stringfind(prepContact,'BROKER',1)>0 => StringLib.StringFindReplace(prepContact,'BROKER',''),
									   StringLib.stringfind(prepContact,'MNGR',1)>0 => StringLib.StringFindReplace(prepContact,'MNGR',''),
									   StringLib.stringfind(prepContact,'GENERAL COUNSEL',1)>0 => StringLib.StringFindReplace(prepContact,'GENERAL COUNSEL',''),
									   StringLib.stringfind(prepContact,'C/O',1)>0 => StringLib.StringFindReplace(prepContact,'C/O',''),
									   StringLib.stringfind(prepContact,'CAPITAL',1) >0 => StringLib.StringFindReplace(prepContact,'CAPITAL',''),
									   StringLib.stringfind(prepContact,'LEGAL DEPARTMENT',1) >0 => StringLib.StringFindReplace(prepContact,'LEGAL DEPARTMENT',''),
									   StringLib.stringfind(prepContact,'LEGAL DEPT',1) >0 => StringLib.StringFindReplace(prepContact,'LEGAL DEPT',''),
									   StringLib.stringfind(prepContact,'LEGAL DEPT.',1) >0 => StringLib.StringFindReplace(prepContact,'LEGAL DEPT.',''),
									   StringLib.stringfind(prepContact,'OFFICE',1) >0 => StringLib.StringFindReplace(prepContact,'OFFICE',''),
									   StringLib.stringfind(prepContact,'A PARTNERSHIP',1) >0 => StringLib.StringFindReplace(prepContact,'A PARTNERSHIP',''),
																	prepContact);
			
			parseContact		:= MAP(prepContact != '' and StringLib.stringfind(TRIM(stripTitle,left,right),' ',1)< 1 => ' ',
									   prepContact != '' and NOT Prof_License_Mari.func_is_company(stripTitle) => datalib.NameClean(stripTitle),
									   												' ');
									   
			self.NAME_CONTACT_FIRST := TRIM(parseContact[1..15],left,right);
			self.NAME_CONTACT_MID	:= TRIM(parseContact[41..56],left,right);
			self.NAME_CONTACT_LAST  := TRIM(parseContact[81..111],left,right);
			self.NAME_CONTACT_SUFX	:= TRIM(parseContact[131..134],left,right);
			self.NAME_CONTACT_TTL	:= MAP(StringLib.stringfind(prepContact,'RECEIVER',1)>0 => 'RECEIVER',
											StringLib.stringfind(prepContact,'CONSERVATOR',1)>0 => 'CONSERVATOR',
											StringLib.stringfind(prepContact,'BROKER',1)>0 => 'BROKER',
											StringLib.stringfind(prepContact,'MNGR',1)>0 => 'MNGR',
											'');	
			

		  // Business rules to standardize DBA(s) for splitting into multiple records

		  // Populate if DBA exist in ORG_NAME field
			tempDBA       := if(trimName2 != '' and trimName1 != '', trimName1, '');
			trimDBA       := ut.CleanSpacesAndUpper(tempDBA);
			trimDBA2      := if(trimDBA = tempTrimName,'',trimDBA);
			trimFix       := stringlib.stringfindreplace(trimDBA2,'RE/MAX','REMAX');
			//trimDBA2      := if(tempTypeCd = 'GR' and Prof_License_Mari.func_is_address(tempAdd1)= false and trimDBA = '',tempAdd1, trimDBA);
			tempDBA1      := if(trimDBA=TrimNAME_ORG,'',trimFix);
			tempDBA2      := stringlib.stringfindreplace(tempDBA1,';','/');
			tempDBA3      := stringlib.stringfindreplace(tempDBA2,'AND/OR','/');
			tempDBA4      := if(stringlib.stringfind(tempDBA3,'BURRES AND ASSOCIATES',1)=0
			                    AND stringlib.stringfind(tempDBA3,'AND LOAN',1)=0,
													stringlib.stringfindreplace(tempDBA3,' AND ','/'),
												  tempDBA3);
													
			StripDBA      := stringlib.stringfindreplace(tempDBA4,'CORPORATION','CORP');
			sepSpot       := stringlib.stringfind(StripDBA,'/',1);
			self.dba			:= StripDBA[1..stringlib.stringfind(StripDBA,'/',1)-1];
			self.dba_flag := if(StripDBA != ' ', 1, 0);
		  temp_dba1			:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 and StringLib.stringfind(StripDBA,',',1) > 0 => REGEXFIND('^([\\/]?)([A-Za-z ][^\\/]+)',StripDBA,2),
									   StringLib.stringfind(StripDBA,'/',1) > 0 and StringLib.stringfind(StripDBA,';',1) > 0 =>
										  REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,1),
									   StringLib.stringfind(StripDBA,'/',2) > 0 and StringLib.stringfind(StripDBA,';',1) > 0 =>	  
										 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,1),
									   StringLib.stringfind(StripDBA,'/',1) > 0 => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)',StripDBA,1),
									   StringLib.stringfind(StripDBA,';',1) > 0 => REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',StripDBA,1),
									   		   										StripDBA);
																							
			self.dba1 := temp_dba1;

		  // self.dba2 			:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)',StripDBA,2),
			self.dba2			:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 and StringLib.stringfind(StripDBA,';',1) > 0 =>
										  REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,2),
									   StringLib.stringfind(StripDBA,'/',2) > 0 and StringLib.stringfind(StripDBA,';',1) > 0 =>	  
										 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,2),
							           StringLib.stringfind(StripDBA,'/',1) > 0 => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)',StripDBA,2),
									   StringLib.stringfind(StripDBA,';',1) > 0 => REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\;]+)[ ]',StripDBA,2),
									   									   		   ' ');
			 			
			self.dba3 			:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 and StringLib.stringfind(StripDBA,';',1) > 0 =>
										  REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,3),
									   StringLib.stringfind(StripDBA,'/',2) > 0 and StringLib.stringfind(StripDBA,';',1) > 0 =>	  
										 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,3),
									   StringLib.stringfind(StripDBA,'/',2) > 0 =>
										REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)',StripDBA,3),
																	            	'');
			
			self.dba4 			:= MAP(StringLib.stringfind(StripDBA,'/',1) > 0 and StringLib.stringfind(StripDBA,';',1) > 0 =>
										  REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,4),
									   StringLib.stringfind(StripDBA,'/',2) > 0 and StringLib.stringfind(StripDBA,';',1) > 0 =>	  
										 REGEXFIND('^([0-9A-Za-z ][^\\;]+)[\\;][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z ][^\\/]+)[\\/][ ]([0-9A-Za-z  ][^\\/]+)',StripDBA,4),
									   StringLib.stringfind(StripDBA,'/',3) > 0 =>
										REGEXFIND('^([A-Za-z ][^/]+)[/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)[ ]([A-Za-z ][^\\/]+)',StripDBA,4), 
																		             '');
			
			self.dba5 			:= IF(StringLib.stringfind(StripDBA,'/',4) > 0,
										REGEXFIND('^([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z ][^\\/]+)[\\/][ ]([A-Za-z][^\\/]+)',StripDBA,1),'');						   
			
		
		
		  //affiliation type code
			tempAffilTypeCd := if(tempRawType = 'CSB' or tempRawType = 'SLB', 'BR', 'CO');

			
			self.affil_type_cd := tempAffilTypeCd;
		
		
		   /* fields used to create mltreckey key are:
		    license number
			  license type
			  source update
			  name
			  address_1
				dba
				officename
		   */
			 
			mltreckeyHash := hash32(trim(tempLicNum,left,right) 
		                           +trim(tempStdLicType,left,right)
										           +trim(src_cd,left,right)
				                       +ut.CleanSpacesAndUpper(StdName_Org)
										           +ut.CleanSpacesAndUpper(pInput.ADDRESS1_1)
															 +ut.CleanSpacesAndUpper(StripDBA)
															 +ut.CleanSpacesAndUpper(pInput.ADDRESS2_1)
															 +tempContact); 
			
			self.mltrec_key := if(temp_dba1 != ' ',mltreckeyHash, 0);
			
		   /* fields used to create unique key are:
		    license number
			  license type
			  source update
			  name
			  address
		   */
			 
			self.cmc_slpk         := hash32(trim(tempLicNum,left,right) 
		                           +trim(tempStdLicType,left,right)
										           +trim(src_cd,left,right)
				                       +ut.CleanSpacesAndUpper(StdName_Org)
										           +ut.CleanSpacesAndUpper(pInput.ADDRESS1_1)
															 +ut.CleanSpacesAndUpper(pInput.ADDRESS2_1)
															 +tempContact);
										 

			SELF := [];		   		   
END;

//ds_map := project(prof_license_mari.file_MES0691, transformToCommon(left));
ds_map := project(ValidFile, transformToCommon(left));

// Clean-up Fields
maribase_plus_dbas	transformClean(ds_map pInput) 
    := 
	   TRANSFORM
		// clnParseName			:= IF(pInput.NAME_ORG_ORIG != '' and Prof_License_Mari.func_is_company(pInput.NAME_ORG_ORIG),
											// '', datalib.NameClean(pInput.NAME_ORG));

		self.ADDR_ADDR1_1		:= MAP(StringLib.stringfind(pInput.ADDR_ADDR1_1,'.',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR1_1, '.'),
									   StringLib.stringfind(pInput.ADDR_ADDR1_1,',',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR1_1, ','),
									   StringLib.stringfind(pInput.ADDR_ADDR1_1,'#',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR1_1, '#'),	
										                                                       pInput.ADDR_ADDR1_1);
		self.ADDR_ADDR2_1		:= MAP(StringLib.stringfind(pInput.ADDR_ADDR2_1,'.',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR2_1, '.'),
									   StringLib.stringfind(pInput.ADDR_ADDR2_1,',',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR2_1, ','),
									   StringLib.stringfind(pInput.ADDR_ADDR2_1,'#',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR2_1, '#'),	
										                                                       pInput.ADDR_ADDR2_1);
		
		self.ADDR_ADDR3_1		:= MAP(StringLib.stringfind(pInput.ADDR_ADDR3_1,'.',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR3_1, '.'),
									   StringLib.stringfind(pInput.ADDR_ADDR3_1,',',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR3_1, ','),
									   StringLib.stringfind(pInput.ADDR_ADDR3_1,'#',1) > 0 => StringLib.StringFilterOut(pInput.ADDR_ADDR3_1, '#'),	
										                                                       pInput.ADDR_ADDR3_1);
		
		self := pInput;
END;
ds_map_clean := project(ds_map , transformClean(left));
							   

// Populate STD_LICENSE_STATUS field via translation on RAW_LICENSE_STATUS field
maribase_plus_dbas trans_lic_status(ds_map_clean L, Cmvtranslation R) := transform
	self.STD_LICENSE_STATUS := R.DM_VALUE1;
	self := L;
end;

ds_map_stat_trans := JOIN(ds_map_clean, Cmvtranslation,
							TRIM(left.raw_license_status,left,right)= TRIM(right.fld_value,left,right)
	    					AND right.fld_name='LIC_STATUS',
							trans_lic_status(left,right),left outer,lookup);


// Populate STD_PROF_CD field via translation on license type field
maribase_plus_dbas trans_lic_type(ds_map_stat_trans L, Cmvtranslation R) := transform
	self.STD_PROF_CD := R.DM_VALUE1;
	self := L;
end;

ds_map_lic_trans := JOIN(ds_map_stat_trans, Cmvtranslation,
						TRIM(left.std_license_type,left,right)= TRIM(right.fld_value,left,right)
						AND right.fld_name='LIC_TYPE' 
						AND right.dm_name1 = 'PROFCODE',
						trans_lic_type(left,right),left outer,lookup);
																		
// Populate prof code description
maribase_plus_dbas  trans_prof_desc(ds_map_lic_trans L, Prof_Desc R) := transform
  self.STD_PROF_DESC := StringLib.stringtouppercase(trim(R.PROF_DESC,left,right));
	self := L;
end;

ds_map_prof_desc := JOIN(ds_map_lic_trans, Prof_Desc,
						 TRIM(left.std_prof_cd,left,right)= TRIM(right.prof_cd,left,right),
						 trans_prof_desc(left,right),left outer,lookup);
																		

// Populate License Status Description field
maribase_plus_dbas trans_status_desc(ds_map_prof_desc L, Status_Desc R) := transform
  self.STD_STATUS_DESC := StringLib.stringtouppercase(trim(R.STATUS_DESC,left,right));
  self := L;
end;

ds_map_status_desc := jOIN(ds_map_prof_desc, Status_Desc,
							TRIM(left.std_license_status,left,right)= TRIM(right.license_status,left,right),
							trans_status_desc(left,right),left outer,lookup);
																		
																		
//Populate License Type Description field
maribase_plus_dbas trans_type_desc(ds_map_status_desc L, License_Desc R) := transform
  self.STD_LICENSE_DESC := StringLib.stringtouppercase(trim(R.LICENSE_DESC,left,right));
  self := L;
end;

ds_map_type_desc := JOIN(ds_map_status_desc, License_Desc,
						TRIM(left.std_license_type,left,right) = TRIM(right.license_type,left,right),
						trans_type_desc(left,right),left outer,lookup);
						
//Populate Disciplinary Action Type Description field
maribase_plus_dbas trans_disp_desc(ds_map_type_desc L, Disp_Desc R) := transform
  self.DISP_TYPE_DESC := StringLib.stringtouppercase(trim(R.disp_desc,left,right));
  self := L;
end;

ds_map_disp_desc := join(ds_map_type_desc, Disp_Desc,
						TRIM(left.DISP_TYPE_CD,left,right)= TRIM(right.disp_type,left,right),
						trans_disp_desc(left,right),left outer,lookup);
						
						
//Populate Source Description field
maribase_plus_dbas trans_source_desc(ds_map_disp_desc L, Src_Desc R) := transform
  self.STD_SOURCE_DESC := StringLib.stringtouppercase(trim(R.SRC_NAME,left,right));
  self := L;
end;

ds_map_source_desc := join(ds_map_disp_desc, Src_Desc,
						TRIM(left.std_source_upd,left,right)= TRIM(right.src_nbr,left,right),
						trans_source_desc(left,right),left outer,lookup);

// Normalized DBA records
maribase_dbas := record,maxlength(5000)
  maribase_plus_dbas;
  string60 tmp_dba;
end;

maribase_dbas	NormIT(ds_map_source_desc L, INTEGER C) := TRANSFORM
    self := L;
	self.TMP_DBA := CHOOSE(C, L.DBA, L.DBA1, L.DBA2, L.DBA3, L.DBA4, L.DBA5);
END;

NormDBAs 	:= DEDUP(NORMALIZE(ds_map_source_desc,6,NormIT(left,counter)),all,record);

NoDBARecs	:= NormDBAs(TMP_DBA = '' AND DBA = '' AND DBA1 = '' 
				AND DBA2 = '' AND DBA3 = '' AND DBA4 = '' AND DBA5 = '');
DBARecs 	:= NormDBAs(TMP_DBA != '');

FilteredRecs  := DBARecs + NoDBARecs;

// Transform expanded dataset to MARIBASE layout
// Apply DBA Business Rules
Prof_License_Mari.layouts_reference.MARIBASE xTransToBase(FilteredRecs L) := transform
    self.NAME_ORG_SUFX	:= StringLib.StringFilterOut(L.NAME_ORG_SUFX, '.');
	  TrimDBASufx			:= MAP(REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) => StringLib.StringFindReplace(L.TMP_DBA,'CO',''),
							         NOT REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanFName(L.TMP_DBA), 
							         '');
	DBA_SUFX			:= Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(L.TMP_DBA);						   
	self.NAME_DBA 		:= TRIM(TrimDBASufx,LEFT,RIGHT);
	self.DBA_FLAG       := IF(trim(self.name_dba,left,right) != '',1,0); // 1: true  0: false
	self.NAME_DBA_SUFX	:= StringLib.StringFilterOut(DBA_SUFX, '.'); 
	self.NAME_MARI_DBA	:= MAP(L.type_cd = 'GR' and StringLib.stringfind(L.name_org,'CIT GROUP',1) > 0 => L.NAME_ORG_ORIG,
							   L.type_cd = 'GR' and StringLib.stringfind(L.name_org,'CIT GROUP',1) = 0 => TRIM(L.TMP_DBA,left,right),
							   L.type_cd = 'MD' => TRIM(L.TMP_DBA,left,right), ''); 
	self := L;
end;

ds_map_base := project(FilteredRecs, xTransToBase(left));
																
//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
company_only_lookup := ds_map_base(affil_type_cd='CO');

Prof_License_Mari.layouts_reference.MARIBASE assign_pcmcslpk(ds_map_base L, company_only_lookup R) := transform
	self.pcmc_slpk := R.cmc_slpk;
	self := L;
end;

ds_map_affil := join(ds_map_base, company_only_lookup,
						     ((TRIM(left.name_org,left,right)[1..50] + TRIM(left.STD_LICENSE_TYPE,left,right)[1..2])	= 
								   (TRIM(right.name_org,left,right)[1..50] + TRIM(right.STD_LICENSE_TYPE,left,right)[1..2]))
						     AND left.AFFIL_TYPE_CD in ['IN', 'BR'],
						      assign_pcmcslpk(left,right),left outer,lookup);																		

Prof_License_Mari.layouts_reference.MARIBASE xTransPROVNOTE(ds_map_affil L) := transform
	self.provnote_1 := map(L.provnote_1 != '' and L.pcmc_slpk = 0 and L.affil_type_cd = 'BR' => 
							TRIM(L.provnote_1,left,right)+ '|' + 'This is not a main office.  It is a branch office without an associated main office from this source.',
						   L.provnote_1 = '' and L.pcmc_slpk = 0 and L.affil_type_cd = 'BR' => 
							'This is not a main office.  It is a branch office without an associated main office from this source.',L.PROVNOTE_1);

	self := L;
end;

OutRecs := project(ds_map_affil, xTransPROVNOTE(left));

//Adding to Superfile
	
d_final := output(OutRecs, ,'~thor_data400::in::prolic::mari::'+process_date+'::'+src_cd,overwrite);
		
add_super := sequential(fileservices.startsuperfiletransaction(),
													fileservices.addsuperfile('~thor_data400::in::prolic::mari::'+src_cd,'~thor_data400::in::prolic::mari::'+process_date+'::'+src_cd),
													fileservices.finishsuperfiletransaction()
													);

sequential(d_final, add_super);

export map_MES0691_conversion := '';

//export map_MES0691_conversion := outrecs;




