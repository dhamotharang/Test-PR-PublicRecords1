//
//

import ut
	  , Prof_License_Mari
	  , lib_stringlib
	  , lib_datalib;

// Filter heading and records w/o name1 and SLNUM not populated
ValidMTGFile	:= Prof_License_Mari.file_CAS0611(NAME1 <> '' AND LIC_NUMBER <> '' AND NOT REGEXFIND(Prof_License_Mari.filters.BadNameFilter, StringLib.StringToUpperCase(NAME1)));


// Reference Files
SrcCmvTrans	:= prof_license_mari.files_References.cmvtranslation;
SrcCmvType	:= prof_license_mari.files_References.MARIcmvlictype;
SrcCmv		:= prof_license_mari.files_References.MARIcmvSrc;
SrcCmvProf	:= prof_license_mari.files_References.MARIcmvprof;
SrcCmvStatus := prof_license_mari.files_References.MARIcmvlicstatus;

src_cd	:= 'S0611';
string8 process_date:=(string8)Lib_StringLib.StringLib.GetDateYYYYMMDD();

//lic_types_not_used := [];
// company_lic_types := [];

maribase_plus_dbas := record,maxlength(5000)
  Prof_License_Mari.layouts_reference.MARIBASE;
  string60 dba;
  string60 dba1;
  string60 dba2;
  string60 dba3;
  string60 dba4;
  string60 dba5;
end;

//AR mortgage and lenders to MARIBASE layout
maribase_plus_dbas	transformToCommon(Prof_License_Mari.Layout_CAS0611 pInput) 
    := 
	   TRANSFORM
			self.PRIMARY_KEY	 := 0;  //Generate sequence number (not yet initiated)
			self.CREATE_DTE      := process_date;
			self.LAST_UPD_DTE    := process_date;
			self.STAMP_DTE       := process_date;
			self.STD_SOURCE_UPD	 := src_cd;
			self.TYPE_CD		 := 'GR';
			
			//trimming name_org for future use
			TrimNAME_ORG		:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.name1);
			TrimNAME_DBA		:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.name2);

			// Fix names to parse correctly
			fixNAME_ORG		:= IF(StringLib.stringfind(TrimNAME_ORG,'COLDWELL BANKER HOME LOANS CARTUS HOME LOANS,',1)>0 
															,StringLib.StringFindReplace(TrimNAME_ORG,'COLDWELL BANKER HOME LOANS CARTUS HOME LOANS,','COLDWELL BANKER HOME LOANS, CARTUS HOME LOANS,'),
																TrimNAME_ORG);

			
			fixNAME_DBA		:= MAP(StringLib.stringfind(TrimNAME_DBA,'COLDWELL BANKER MORTGAGE (',1) >0 => ', ' + TrimNAME_DBA,
								   StringLib.stringfind(TrimNAME_DBA,'COLDWELL BANKER MORTGAGE(',1) >0 => ', ' + TrimNAME_DBA,
								   StringLib.stringfind(TrimNAME_DBA,'HAMERA HOME LOANS FIRST CAPITAL (PHH HOME LOANS, LLC,DBA)',1) >0 
											=> StringLib.StringFindReplace(TrimNAME_DBA,'HAMERA HOME LOANS FIRST CAPITAL (PHH HOME LOANS, LLC,DBA)','HAMERA HOME LOANS, FIRST CAPITAL (PHH HOME LOANS, LLC,DBA)'),
									StringLib.stringfind(TrimNAME_DBA,'24 LUSKAR HOSUR ROAD, 4TH, 5TH & 6TH FLOORS',1) >0 => StringLib.StringFindReplace(TrimNAME_DBA,'24 LUSKAR HOSUR ROAD, 4TH, 5TH & 6TH FLOORS',''),
																TrimNAME_DBA);
																
																
			//Business Logic to identify ORG_NAME from DBA field
			tempNAME_ORG	:= MAP(StringLib.stringfind(TrimNAME_ORG,'(',1)>0 and NOT StringLib.stringfind(TrimNAME_ORG,')',1)>0 =>Trim(fixNAME_ORG,left,right)+ '' + TRIM(fixNAME_DBA,left,right), 
								   StringLib.stringfind(TrimNAME_DBA,'DBA',1)>0 and StringLib.stringfind(TrimNAME_DBA,'(',1)>0 
										and NOT StringLib.stringfind(TrimNAME_DBA[1],'(',1)>0 => Trim(fixNAME_ORG,left,right)+ ' ' + TRIM(fixNAME_DBA,left,right),
									NOT StringLib.stringfind(TrimNAME_ORG,'(',1)>0 and StringLib.stringfind(TrimNAME_DBA,'DBA',1)>0 and 
										NOT StringLib.stringfind(TrimNAME_DBA[1],'(',1)>0 and StringLib.stringfind(TrimNAME_DBA[1],')',1)>0 => '(' + TRIM(fixNAME_DBA,left,right),	
								   StringLib.stringfind(TrimNAME_DBA,'DBA',1)>0 and StringLib.stringfind(TrimNAME_DBA[1],'(',1)>0 => fixNAME_DBA, 
										NOT StringLib.stringfind(TrimNAME_DBA,'DBA',1)>0 and StringLib.stringfind(TrimNAME_DBA[1],'(',1)>0 => fixNAME_ORG,
								   TrimNAME_ORG != '' and TrimNAME_DBA != ' '
										and NOT StringLib.stringfind(TrimNAME_DBA,'DBA',1)>0 => Trim(fixNAME_ORG,left,right)+ ' ' + TRIM(fixNAME_DBA,left,right), 
																		fixNAME_ORG);
			
			rmvContactAttn	:= MAP(StringLib.stringfind(tempNAME_ORG,'ATTN',1)>0 and StringLib.stringfind(tempNAME_ORG,'C/O',1)>0 
									and NOT StringLib.stringfind(tempNAME_ORG,'DBA',1)>0 =>
										REGEXFIND('^([A-Za-z ].*)([Cc][/][Oo][ ][A-Za-z ].*)([Aa][Tt][Tt][Nn]?[:]?[A-Za-z ].*)',tempNAME_ORG,1),
								   StringLib.stringfind(tempNAME_ORG,'C/O',1)>0 and NOT StringLib.stringfind(tempNAME_ORG,'ATTN',1)>0 
									and NOT StringLib.stringfind(tempNAME_ORG,'DBA',1)>0 => Prof_License_Mari.mod_clean_name_addr.GetCorpName(tempNAME_ORG), 
								   StringLib.stringfind(tempNAME_ORG,'ATTN',1)>0 and NOT StringLib.stringfind(tempNAME_ORG,'C/O',1)>0
									and NOT StringLib.stringfind(tempNAME_ORG,'DBA',1)>0 => Prof_License_Mari.mod_clean_name_addr.GetCorpName(tempNAME_ORG),
								   StringLib.stringfind(tempNAME_ORG,'ATTN',1)>0 and NOT StringLib.stringfind(tempNAME_ORG,'C/O',1)>0
									and StringLib.stringfind(tempNAME_ORG,'DBA',1)>0 => Prof_License_Mari.mod_clean_name_addr.GetCorpName(tempNAME_ORG), 
																tempNAME_ORG);
															
			ContactNAME		:= IF(StringLib.stringfind(tempNAME_ORG,'ATTN',1)>0 and StringLib.stringfind(tempNAME_ORG,'C/O',1)>0,
									REGEXFIND('^([A-Za-z ].*)([Cc][/][Oo][ ][A-Za-z ].*)([Aa][Tt][Tt][Nn]?[:]?[A-Za-z ].*)',tempNAME_ORG,2),'');
			AttnNAME		:= IF(StringLib.stringfind(tempNAME_ORG,'ATTN',1)>0 and StringLib.stringfind(tempNAME_ORG,'C/O',1)>0,
									REGEXFIND('^([A-Za-z ].*)([Cc][/][Oo][ ][A-Za-z ].*)([Aa][Tt][Tt][Nn]?[:]?[A-Za-z ].*)',tempNAME_ORG,3),' ');
		
		// Prepping name2 to handle various conditions 
		// 1.) Replacing D/B/A with  '|' to separate name1 & DBA
		// 2.) Handle AKA Names to First, Middle Last Format
		// 3.) Standardized corporation suffixes
			
			StripORGName	:= MAP(StringLib.stringfind(rmvContactAttn,'/',1) > 0 and StringLib.stringfind(rmvContactAttn,'DBA',1)>0 
									and REGEXFIND('^([A-Za-z ][^\\/]+)[\\/]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*.)[\\)]',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\/]+)[\\/]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*.)[\\)]',rmvContactAttn,4),
										
								   StringLib.stringfind(rmvContactAttn,',,',1) > 0 and StringLib.stringfind(rmvContactAttn,'DBA',1)>0 =>
										REGEXFIND('^([A-Za-z ][^\\,]+),([A-Za-z ][^\\,,]+),,[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn,4),
								   
								   StringLib.stringfind(rmvContactAttn,'/',1) > 0 and StringLib.stringfind(rmvContactAttn,'DBA',1)>0 
									and REGEXFIND('^([A-Za-z ][^\\/]+)[\\/]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)],[ ]([A-Za-z \\.]*)',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\/]+)[\\/]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)],[ ]([A-Za-z \\.]*)',rmvContactAttn,3),	
										
								   StringLib.stringfind(rmvContactAttn,', DBA',1)>0 
									and REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn,5),	
										
								   StringLib.stringfind(rmvContactAttn,', DBA',1)>0
									and REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn,5),
								   StringLib.stringfind(rmvContactAttn,';',1) > 0 and StringLib.stringfind(rmvContactAttn,'DBA',1)>0
									and REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn) 	
										=> REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn,3),
									StringLib.stringfind(rmvContactAttn,',',1) > 0 and StringLib.stringfind(rmvContactAttn,', DBA',1)>0
									and REGEXFIND('^([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA][^\\)]+)[\\)]',rmvContactAttn) 	
										=> REGEXFIND('^([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA][^\\)]+)[\\)]',rmvContactAttn,3),
									StringLib.stringfind(rmvContactAttn,',',1) > 0 and StringLib.stringfind(rmvContactAttn,', DBA',1)>0 
									and REGEXFIND('^([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA][^\\)]+)[\\)]',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA][^\\)]+)[\\)]',rmvContactAttn,4),
									StringLib.stringfind(rmvContactAttn,'DBA',1)>0 and REGEXFIND('^([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA][^\\)]+)[\\)]',rmvContactAttn) =>	
										REGEXFIND('^([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA][^\\)]+)[\\)]',rmvContactAttn,2),
									StringLib.stringfind(rmvContactAttn,'DBA',1)>0 and REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z \\,][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z \\,][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn,3),
									NOT StringLib.stringfind(rmvContactAttn,'DBA',1)>0 
										and REGEXFIND('^([A-Za-z \\,]*).,[ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z \\,]*).,[ ]([A-Za-z ][^\\)]+)',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z \\,]*).,[ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z \\,]*).,[ ]([A-Za-z ][^\\)]+)',rmvContactAttn,1),
									NOT StringLib.stringfind(rmvContactAttn,'DBA',1)>0 and NOT StringLib.stringfind(rmvContactAttn,', INC.',1)>0
										and REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ]*)',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ]*)',rmvContactAttn,1),
									NOT StringLib.stringFind(rmvContactAttn,'DBA',1)>0 
										and REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z ]*)',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z ]*)',rmvContactAttn,1),
										
									NOT StringLib.stringFind(rmvContactAttn,'DBA',1)>0 and NOT StringLib.stringFind(fixNAME_ORG,'(',1)>0
										and REGEXFIND('^([A-Za-z ][^\\(]+)[\\(]([A-Za-z ]*)',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\(]+)[\\(]([A-Za-z ]*)',rmvContactAttn,1),rmvContactAttn);
								
									
			prepNAME_ORG	:= MAP(StringLib.stringfind(StripORGName,', DBA',1)>0 => StringLib.StringFindReplace(StripORGName,', DBA',''),
								   StringLib.stringfind(StripORGName,',DBA',1)>0 => StringLib.StringFindReplace(StripORGName,',DBA',''),
								   StringLib.stringfind(StripORGName,'AS NORMANDY WEST CORPORATION',1)>0 => StringLib.StringFindReplace(StripORGName,'AS NORMANDY WEST CORPORATION',''),
								   StringLib.stringfind(StripORGName,'/',1)>0 => StringLib.StringFindReplace(StripORGName,'/',' '), 
								   StringLib.stringfind(StripORGName,'SMARTRATEDIRECT.COM, INC., A CALIFORNIA',1)>0 => 
													StringLib.StringFindReplace(StripORGName,'SMARTRATEDIRECT.COM, INC., A CALIFORNIA','SMARTRATEDIRECT.COM, INC.'),StripORGName);

								   
			StdNAME_ORG			:= IF(StringLib.stringfind(StripORGName,'LIMITED PARTNERSHIP',1)>0, StringLib.StringFindReplace(StripORGName,'LIMITED PARTNERSHIP','L.P.'),
										Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(prepNAME_ORG));
										
										
			CleanNAME_ORG		:= MAP(StringLib.stringfind(StdNAME_ORG,'ESCROW PLUS,INC.',1) > 0 => StringLib.StringFindReplace(StdNAME_ORG,'ESCROW PLUS,INC.','ESCROW PLUS'),
									    REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => StdNAME_ORG,
										REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => StdNAME_ORG,
										  								Prof_License_Mari.mod_clean_name_addr.cleanFName(StdNAME_ORG));	   		   
		
		// Parse out multiple ORG_SUFX(s) from name1
			tmpOrgSufx2			:= REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG,2);
			tmpOrgSufx3			:= REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG,3);
			
			
			self.NAME_ORG_PREfX	:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(StdNAME_ORG);
			self.NAME_ORG		:= MAP(NOT REGEXFIND('LLP',StdNAME_ORG) and REGEXFIND('(LP)$',StdNAME_ORG) and self.TYPE_CD = 'GR' => REGEXREPLACE('(LP)',CleanNAME_ORG,''),
									   REGEXFIND('(L[.]P[.])$',StdNAME_ORG) and self.TYPE_CD = 'GR' => REGEXREPLACE('(LP)',CleanNAME_ORG,''),
									   StringLib.stringfind(rmvContactAttn,'LIMITED PARTNERSHIP',1)>0 => StringLib.StringFindReplace(CleanNAME_ORG,'LP',''),
								       StringLib.stringfind(StdNAME_ORG,'.COM',1) >0 and self.TYPE_CD = 'GR' => StringLib.StringFindReplace(CleanNAME_ORG,'COM','.COM'),
									   // REGEXFIND('([Cc][Oo][\\.]?)$',CleanNAME_ORG) => StringLib.StringFindReplace(CleanNAME_ORG,'CO',''),
												 TRIM(CleanNAME_ORG,left,right));  
			
			self.NAME_ORG_SUFX	:= MAP(REGEXFIND('^([0-9A-Za-z ][^,]+)[\\,][ ]([A-Za-z \\.]+)[\\,][ ]([A-Za-z \\.]+)',StdNAME_ORG)=> tmpOrgSufx2 + ' ' + tmpOrgSufx3,
									   NOT REGEXFIND('LLP',StdNAME_ORG) and REGEXFIND('(LP)$',StdNAME_ORG) and self.TYPE_CD = 'GR' => REGEXFIND('(LP)$',StdNAME_ORG,1),
									   REGEXFIND('(L[.]P[.])$',StdNAME_ORG) and self.TYPE_CD = 'GR' => REGEXFIND('(L.P.)$',StdNAME_ORG,1),
									   StringLib.stringfind(rmvContactAttn,'LIMITED PARTNERSHIP',1)>0 => 'L.P.',
									   REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => '',
									   REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StdNAME_ORG,left,right)) => '',
								  						Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StdNAME_ORG)); 									 
			self.NAME_DBA		:= '';
			self.NAME_DBA_SUFX	:= '';
			self.DBA_FLAG       := IF(trim(self.name_dba,left,right) != '',1,0); // 1: true  0: false
			
			// If individual and not identified as a corporation names, parse into (FMLS) fmt
			clnPrepNAME_ORG		:= Prof_License_Mari.mod_clean_name_addr.strippunctName(prepNAME_ORG);
			clnParseName			:= MAP(StringLib.stringfind(TRIM(clnPrepNAME_ORG),' ',1)> 1 
											    AND Prof_License_Mari.func_is_company(clnPrepNAME_ORG) => ' ',
										   StringLib.stringfind(TRIM(clnPrepNAME_ORG,LEFT,RIGHT),' ',1)< 1 => ' ',
										   StringLib.stringfind(TRIM(clnPrepNAME_ORG),'ESCROW',1)> 0 => ' ', datalib.NameClean(CleanNAME_ORG));	
											
			
			self.NAME_FIRST		:= TRIM(clnParseName[1..30],left,right);
			self.NAME_MID		:= TRIM(clnParseName[41..70],left,right);
			self.NAME_LAST		:= TRIM(clnParseName[81..120],left,right);
			self.NAME_SUFX		:= TRIM(clnParseName[131..136],left,right);

			self.LICENSE_NBR	:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.lic_number);
			self.LICENSE_STATE	:= 'CA';
			self.RAW_LICENSE_TYPE 	:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.lic_type);
			
			// map raw license type to standard license type before profcode translations
		   	self.STD_LICENSE_TYPE := map(Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.LIC_TYPE) = 'MORTGAGE BANKER (BRANCH)' => 'MBBR',
				                        Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.LIC_TYPE) = 'MORTGAGE BANKER (MAIN)' => 'MBMN',
									    Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.LIC_TYPE) = 'ESCROW (MAIN)' => 'ESMN',
										Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.LIC_TYPE) = 'ESCROW (BRANCH)' => 'ESBR',
										Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.LIC_TYPE) = 'CALIFORNIA FINANCE LENDER' => 'CAFL', ' ');
		
			self.RAW_LICENSE_STATUS := Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.lic_status);
           
		 										
			//assign and reformat issue date 
			self.CURR_ISSUE_DTE	:= '17530101';
			self.ORIG_ISSUE_DTE	:= Prof_License_Mari.DateCleaner.fmt_dateMONDDYYYY(prof_license_mari.mod_clean_name_addr.trimupper(pInput.lic_date));
			self.EXPIRE_DTE		:= '17530101';
		  
			self.ADDR_BUS_IND	:= IF(TRIM(pInput.address1 + pInput.citystzip,LEFT,RIGHT) != '','B','');
			self.NAME_ORG_ORIG	:= TrimNAME_ORG;
			self.NAME_DBA_ORIG	:= TrimNAME_DBA;
			self.NAME_MARI_ORG	:= Prof_License_Mari.mod_clean_name_addr.strippunctName(prepNAME_ORG);
			self.NAME_MARI_DBA	:= ' ';
			
           // Address fields is could be populated with address1, address2, address3 separated by variations of comma(s), and semi-colon(s)
			trimAddress		:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.ADDRESS1);
			tmpAddress		:= IF(REGEXFIND('(^|\\W+)([Cc][/][Oo]|[(]?[Dd][/]?[Bb][/]?[Aa][)]?|[Aa][Tt][Tt][Nn]?[:]?|[%])($|\\W+)',trimAddress)
									and REGEXFIND('^([ATTN: ][A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+),([0-9A-Za-z ]*)',trimAddress),  
										REGEXFIND('^([ATTN: ][A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+),([0-9A-Za-z ]*)',trimAddress,3),trimAddress);
			
			self.ADDR_ADDR1_1	:= MAP(REGEXFIND('(^|\\W+)([Cc][/][Oo]|[(]?[Dd][/]?[Bb][/]?[Aa][)]?|[Aa][Tt][Tt][Nn]?[:]?|[%])($|\\W+)',trimAddress)
									    and REGEXFIND('^(C/O[A-Za-z ][^\\,]+),[ ]([0-9A-Za-z ][^\\,]+),[ ]([0-9A-Za-z ][^\\,]+),[ ]([0-9A-Za-z \\-]*)',tmpAddress) =>
													REGEXFIND('^(C/O[A-Za-z ][^\\,]+),[ ]([0-9A-Za-z ][^\\,]+),[ ]([0-9A-Za-z ][^\\,]+),[ ]([0-9A-Za-z \\-]*)',tmpAddress,2),
									   StringLib.stringfind(tmpAddress,',',1)>0 and StringLib.stringfind(tmpAddress,'/',1)>0 => REGEXREPLACE('/',tmpAddress, ' '),
    								   StringLib.stringfind(tmpAddress,',,',1)>0 => REGEXFIND('^([0-9A-Za-z \'\\.]+[ ]*.),,[ ]*([\\# 0-9A-Za-z \\#]+[ ]*.)',tmpAddress,1),
									   StringLib.stringfind(tmpAddress,', ,',1)>0 => REGEXFIND('^([0-9A-Za-z \'\\.]+[ ]*.), ,[ ]*([\\# 0-9A-Za-z \\#]+[ ]*.)',tmpAddress,1),
									   StringLib.stringfind(tmpAddress,', #',1)>0 => REGEXFIND('^([0-9A-Za-z ][^\\,]+)[\\,][ ]([#]?[0-9A-Za-z ]*)',tmpAddress,1),
									   
									   StringLib.stringfind(tmpAddress,',',1)>0 =>	REGEXFIND('^([\\#]?[0-9A-Za-z \'\\.\\-]+[ ]*.),[ ]*([\\# 0-9A-Za-z \\#]+[ ]*.)', tmpAddress,1),
									   																		tmpAddress);
		   
			self.ADDR_ADDR2_1	:= MAP(StringLib.stringfind(tmpAddress,',,',1)>0 => REGEXFIND('^([0-9A-Za-z \'\\.]+[ ]*.),,[ ]*([\\#]?[0-9A-Za-z ]+[^\\,]*)[\\,]?',tmpAddress,2),
									   StringLib.stringfind(tmpAddress,', ,',1)>0 => REGEXFIND('^([0-9A-Za-z \'\\.]+[ ]*.), ,[ ]*([\\# 0-9A-Za-z \\. \\# \\- \\& ][^\\,]+)',tmpAddress,2),
									   StringLib.stringfind(tmpAddress,', #',1)>0 => REGEXFIND('^([0-9A-Za-z ][^\\,]+)[\\,][ ]([#]?[0-9A-Za-z ]*)',tmpAddress,2),
									   REGEXFIND('(^|\\W+)([Cc][/][Oo]|[(]?[Dd][/]?[Bb][/]?[Aa][)]?|[Aa][Tt][Tt][Nn]?[:]?|[%])($|\\W+)',trimAddress)
									   and REGEXFIND('^(C/O[A-Za-z ][^\\,]+),[ ]([0-9A-Za-z ][^\\,]+),[ ]([0-9A-Za-z ][^\\,]+),[ ]([0-9A-Za-z \\-]*)',tmpAddress) =>
													REGEXFIND('^(C/O[A-Za-z ][^\\,]+),[ ]([0-9A-Za-z ][^\\,]+),[ ]([0-9A-Za-z ][^\\,]+),[ ]([0-9A-Za-z \\-]*)',tmpAddress,3),
									   StringLib.stringfind(tmpAddress,',',1)>0 =>	REGEXFIND('^([0-9A-Za-z ][^\\,]+)[\\,][ ]([\\#]?[0-9A-Za-z ][^\\,]+)[\\,]?',tmpAddress,2),
															    								  ' ');
												
			self.ADDR_ADDR3_1	:= MAP(StringLib.stringfind(tmpAddress,',,',1)>0 and REGEXFIND('^([0-9A-Za-z \'\\.]+[ ]*.),,[ ]*([0-9A-Za-z ][^\\,]+)[\\,]?[ ]([0-9A-Za-z )+[ ]*.)',tmpAddress) =>
																REGEXFIND('^([0-9A-Za-z \'\\.]+[ ]*.),,[ ]*([0-9A-Za-z ][^\\,]+)[\\,]?[ ]([0-9A-Za-z )+[ ]*.)',tmpAddress,3),
									   StringLib.stringfind(tmpAddress,', ,',1)>0 and REGEXFIND('^([0-9A-Za-z \'\\.]+[ ]*.), ,[ ]*([0-9A-Za-z \\.][^\\,]+)[\\,]?[ ]([0-9A-Za-z )+[ ]*.)',tmpAddress) =>
																REGEXFIND('^([0-9A-Za-z \'\\.]+[ ]*.), ,[ ]*([0-9A-Za-z \\.][^\\,]+)[\\,]?[ ]([0-9A-Za-z )+[ ]*.)',tmpAddress,3),
									   REGEXFIND('(^|\\W+)([Cc][/][Oo]|[(]?[Dd][/]?[Bb][/]?[Aa][)]?|[Aa][Tt][Tt][Nn]?[:]?|[%])($|\\W+)',trimAddress)
									   and REGEXFIND('^(C/O[A-Za-z ][^\\,]+),[ ]([0-9A-Za-z ][^\\,]+),[ ]([0-9A-Za-z ][^\\,]+),[ ]([0-9A-Za-z \\-]*)',tmpAddress) =>
													REGEXFIND('^(C/O[A-Za-z ][^\\,]+),[ ]([0-9A-Za-z ][^\\,]+),[ ]([0-9A-Za-z ][^\\,]+),[ ]([0-9A-Za-z \\-]*)',tmpAddress,4),
									   StringLib.stringfind(tmpAddress,',',2)>0 and REGEXFIND('^([0-9A-Za-z ][^\\,]+)[\\,][ ]([0-9A-Za-z ][^\\,]+)[\\,]?[ ]([0-9A-Za-z ][^\\,]+)', tmpAddress) =>
																	REGEXFIND('^([0-9A-Za-z ][^\\,]+)[\\,][ ]([0-9A-Za-z ][^\\,]+)[\\,]?[ ]([0-9A-Za-z ][^\\,]+)', tmpAddress,3),
																					'');

			self.ADDR_CITY_1		:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(REGEXFIND('^([A-Za-z ][^\\,]+)[\\,]', pInput.citystzip,1));
			self.ADDR_STATE_1	:= Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(REGEXFIND('^[A-Za-z \']+[ ]*.,[ ]*([A-Z]{2})', pInput.citystzip,1));
		   
			tmpZIPCODE 			:= REGEXFIND('[0-9]{5}(-[0-9]{4})?', pInput.citystzip, 0);
			self.ADDR_ZIP5_1		:= tmpZIPCODE[1..5];
			self.ADDR_ZIP4_1		:= tmpZIPCODE[7..10];

		  	   
		 // Expected codes [CO,BR,IN]
			self.AFFIL_TYPE_CD	:= map(self.type_cd = 'GR' and (self.std_license_type='MBBR' or self.std_license_type='ESBR') => 'BR',
									   self.type_cd = 'GR' and  self.std_license_type <> '' => 'CO', ' ');  

      	
		  // Business rules to identify contacts in dba field	
			GetContact			:= IF(StringLib.stringfind(tempNAME_ORG,'ATTN',1)>0 and StringLib.stringfind(tempNAME_ORG,'C/O',1)>0,
										Prof_License_Mari.mod_clean_name_addr.GetDBAName(AttnNAME),
													Prof_License_Mari.mod_clean_name_addr.GetDBAName(tempNAME_ORG));
			
			prepContact			:= IF(StringLib.stringfind(GetContact,',',1)>0,REGEXFIND('^([A-Za-z ][^\\,]+)',GetContact,1), 	GetContact);
												
			
			stripTitle			:= MAP(StringLib.stringfind(prepContact,'RECEIVER',1)>0 => StringLib.StringFindReplace(prepContact,'RECEIVER',''),
									   StringLib.stringfind(prepContact,'CONSERVATOR',1)>0 => StringLib.StringFindReplace(prepContact,'CONSERVATOR',''),
																	prepContact);
			
			parseContact		:= MAP(StringLib.stringfind(stripTitle,'CAPITAL',1) >0 => '',
									   StringLib.stringfind(stripTitle,'LEGAL DEPARTMENT',1) >0 => '',
									   StringLib.stringfind(stripTitle,'A PARTNERSHIP',1) >0 => '',datalib.NameClean(stripTitle));
									   
										
									
			
			self.NAME_CONTACT_FIRST := TRIM(parseContact[1..15],left,right);
			self.NAME_CONTACT_MID	:= TRIM(parseContact[41..56],left,right);
			self.NAME_CONTACT_LAST  := TRIM(parseContact[81..111],left,right);
			self.NAME_CONTACT_SUFX	:= TRIM(parseContact[131..134],left,right);
			self.NAME_CONTACT_TTL	:= MAP(StringLib.stringfind(GetContact,'RECEIVER',1)>0 => 'RECEIVER',
											StringLib.stringfind(GetContact,'CONSERVATOR',1)>0 => 'CONSERVATOR',
																		'');
		  	// Business rules to identify DBA name in either NAME1/NAME2 field	
			self.dba      	:= MAP(StringLib.stringfind(tempNAME_ORG,'ATTN',1)>0 and StringLib.stringfind(tempNAME_ORG,'C/O',1)>0 => Prof_License_Mari.mod_clean_name_addr.GetDBAName(ContactNAME),
								   StringLib.stringfind(StripORGName,'CALIFORNIA AS NORMANDY WEST CORPORATION',1)>0 => StringLib.StringFindReplace(fixNAME_DBA,'CALIFORNIA AS NORMANDY WEST CORPORATION','NORMANDY WEST CORPORATION'),
								   REGEXFIND('(^|\\W+)([Cc][/][Oo]|[(]?[Dd][/]?[Bb][/]?[Aa][)]?|[Aa][Tt][Tt][Nn]?[:]?|[%])($|\\W+)',trimAddress) => Prof_License_Mari.mod_clean_name_addr.GetContactName(trimAddress), 
																					' ');
																					
			self.dba1		:= MAP(NOT StringLib.stringfind(TrimNAME_DBA,'DBA',1)>0 and StringLib.stringfind(TrimNAME_DBA[1],'(',1)>0 => fixNAME_DBA,
						   			NOT StringLib.stringfind(rmvContactAttn,'DBA',1)>0 
										and REGEXFIND('^([A-Za-z \\,]*).,[ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z \\,]*).,[ ]([A-Za-z ][^\\)]+)',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z \\,]*).,[ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z \\,]*).,[ ]([A-Za-z ][^\\)]+)',rmvContactAttn,2),
									NOT StringLib.stringfind(rmvContactAttn,'DBA',1)>0 and NOT StringLib.stringfind(rmvContactAttn,', INC.',1)>0
										and REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ]*)',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ]*)',rmvContactAttn,2),
									NOT StringLib.stringFind(rmvContactAttn,'DBA',1)>0 
										and REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z ]*)',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z ]*)',rmvContactAttn,2),
									NOT StringLib.stringFind(rmvContactAttn,'DBA',1)>0 and NOT StringLib.stringFind(fixNAME_ORG,'(',1)>0
										and REGEXFIND('^([A-Za-z ][^\\(]+)[\\(]([A-Za-z ]*)',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\(]+)[\\(]([A-Za-z ]*)',rmvContactAttn,2),
			
									StringLib.stringfind(TrimNAME_DBA,'DBA',1)>0 and StringLib.stringfind(TrimNAME_DBA[1],'(',1)>0 
										and REGEXFIND('^([A-Za-z ][^\\/]+)[\\/]([0-9A-Za-z \\.]*.)', fixNAME_ORG) => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/]([A-Za-z ]*)',fixNAME_ORG,1),
																		
									StringLib.stringfind(TrimNAME_DBA,'DBA',1)>0 and StringLib.stringfind(TrimNAME_DBA[1],'(',1)>0 
										and REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ]*)',fixNAME_ORG) => REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ]*)',fixNAME_ORG,1),
									
									StringLib.stringfind(TrimNAME_DBA,'DBA',1)>0 and StringLib.stringfind(TrimNAME_DBA[1],'(',1)>0 => fixNAME_ORG,
									
									StringLib.stringfind(rmvContactAttn,'/',1) > 0 and StringLib.stringfind(rmvContactAttn,'DBA',1)>0 
										and REGEXFIND('^([A-Za-z ][^\\/]+)[\\/]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*.)[\\)]',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\/]+)[\\/]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*.)[\\)]',rmvContactAttn,1),
									
								   StringLib.stringfind(rmvContactAttn,', ,',1) > 0 and StringLib.stringfind(rmvContactAttn,'DBA',1)>0 =>
										REGEXFIND('^([A-Za-z ][^\\,]+),([A-Za-z ][^\\, ,]+), ,[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn,1),
								   
								   StringLib.stringfind(rmvContactAttn,'/',1) > 0 and StringLib.stringfind(rmvContactAttn,'DBA',1)>0 
										and REGEXFIND('^([A-Za-z ][^\\/]+)[\\/]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)],[ ]([A-Za-z \\.]*)',rmvContactAttn)
										=> REGEXFIND('([A-Za-z ][^\\/]+)[\\/]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)],[ ]([A-Za-z \\.]*)',rmvContactAttn,1),	
										
								   StringLib.stringfind(rmvContactAttn,', DBA',1)>0 
										and REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn,1),	
										
								   StringLib.stringfind(rmvContactAttn,', DBA',1)>0
										and REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn,1),
								   StringLib.stringfind(rmvContactAttn,';',1) > 0 and StringLib.stringfind(rmvContactAttn,'DBA',1)>0
										and REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn) 	
										=> REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn,1),
									
								   StringLib.stringfind(rmvContactAttn,',',1) > 0 and StringLib.stringfind(rmvContactAttn,', DBA',1)>0 
										and REGEXFIND('^([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA][^\\)]+)[\\)]',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA][^\\)]+)[\\)]',rmvContactAttn,1),
									
								  StringLib.stringfind(rmvContactAttn,',',1) > 0 and StringLib.stringfind(rmvContactAttn,', DBA',1)>0
										and REGEXFIND('^([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA][^\\)]+)[\\)]',rmvContactAttn) 	
										=> REGEXFIND('^([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA][^\\)]+)[\\)]',rmvContactAttn,1),
																		
									StringLib.stringfind(rmvContactAttn,',',1) > 0 and StringLib.stringfind(rmvContactAttn,', DBA',1)>0 
										and REGEXFIND('^([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA][^\\)]+)[\\)]',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA][^\\)]+)[\\)]',rmvContactAttn,1),
									StringLib.stringfind(rmvContactAttn,'DBA',1)>0 and REGEXFIND('^([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA][^\\)]+)[\\)]',rmvContactAttn) =>	
										REGEXFIND('^([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA][^\\)]+)[\\)]',rmvContactAttn,1),
									StringLib.stringfind(rmvContactAttn,'DBA',1)>0 and REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z \\,][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z \\,][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn,1),
																							' ');
		  
		  self.dba2 		:= MAP(NOT StringLib.stringfind(rmvContactAttn,'DBA',1)>0 
										and REGEXFIND('^([A-Za-z \\,]*).,[ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z \\,]*).,[ ]([A-Za-z ][^\\)]+)',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z \\,]*).,[ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z \\,]*).,[ ]([A-Za-z ][^\\)]+)',rmvContactAttn,3),
								   NOT StringLib.stringfind(rmvContactAttn,'DBA',1)>0 and NOT StringLib.stringfind(rmvContactAttn,', INC.',1)>0
										and REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ]*)',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ]*)',rmvContactAttn,3),
								   NOT StringLib.stringFind(rmvContactAttn,'DBA',1)>0 
										and REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z ]*)',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z ]*)',rmvContactAttn,3),
		  
								   StringLib.stringfind(TrimNAME_DBA,'DBA',1)>0 and StringLib.stringfind(TrimNAME_DBA[1],'(',1)>0 
										and REGEXFIND('^([A-Za-z ][^\\/]+)[\\/]([0-9A-Za-z \\.]*.)', fixNAME_ORG) => REGEXFIND('^([A-Za-z ][^\\/]+)[\\/]([0-9A-Za-z \\.]*.)',fixNAME_ORG,2),
																		
								   StringLib.stringfind(TrimNAME_DBA,'DBA',1)>0 and StringLib.stringfind(TrimNAME_DBA[1],'(',1)>0 
										and REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([0-9A-Za-z ]*)',fixNAME_ORG) => REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([0-9A-Za-z ]*)',fixNAME_ORG,2),
		  
		    					   StringLib.stringfind(rmvContactAttn,'/',1) > 0 and StringLib.stringfind(rmvContactAttn,'DBA',1)>0 
										and REGEXFIND('^([A-Za-z ][^\\/]+)[\\/]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*.)[\\)]',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\/]+)[\\/]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*.)[\\)]',rmvContactAttn,2),
										
								   StringLib.stringfind(rmvContactAttn,', ,',1) > 0 and StringLib.stringfind(rmvContactAttn,'DBA',1)>0 =>
										REGEXFIND('^([A-Za-z ][^\\,]+),([A-Za-z ][^\\, ,]+), ,[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn,2),
								    
								   StringLib.stringfind(rmvContactAttn,'/',1) > 0 and StringLib.stringfind(rmvContactAttn,'DBA',1)>0 
										and REGEXFIND('^([A-Za-z ][^\\/]+)[\\/]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)],[ ]([A-Za-z \\.]*)',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\/]+)[\\/]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)],[ ]([A-Za-z \\.]*)',rmvContactAttn,2),	
										
								   StringLib.stringfind(rmvContactAttn,', DBA',1)>0 
										and REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn,2),	
										
								   StringLib.stringfind(rmvContactAttn,', DBA',1)>0
										and REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn,2),
								   StringLib.stringfind(rmvContactAttn,';',1) > 0 and StringLib.stringfind(rmvContactAttn,'DBA',1)>0
										and REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn) 	
										=> REGEXFIND('^([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn,2),
								   
								   StringLib.stringfind(rmvContactAttn,',',1) > 0 and StringLib.stringfind(rmvContactAttn,', DBA',1)>0 
										and REGEXFIND('^([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA][^\\)]+)[\\)]',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA][^\\)]+)[\\)]',rmvContactAttn,2),
								   
								   StringLib.stringfind(rmvContactAttn,',',1) > 0 and StringLib.stringfind(rmvContactAttn,', DBA',1)>0
										and REGEXFIND('^([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA][^\\)]+)[\\)]',rmvContactAttn) 	
										=> REGEXFIND('^([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA][^\\)]+)[\\)]',rmvContactAttn,2),
									
									StringLib.stringfind(rmvContactAttn,'DBA',1)>0 and REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z \\,][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z \\,][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn,2),
																						' ');
			
						
			self.dba3		:= MAP(NOT StringLib.stringfind(rmvContactAttn,'DBA',1)>0 
										and REGEXFIND('^([A-Za-z \\,]*).,[ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z \\,]*).,[ ]([A-Za-z ][^\\)]+)',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z \\,]*).,[ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z \\,]*).,[ ]([A-Za-z ][^\\)]+)',rmvContactAttn,4),
									NOT StringLib.stringfind(rmvContactAttn,'DBA',1)>0 and NOT StringLib.stringfind(rmvContactAttn,', INC.',1)>0
										and REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ]*)',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ]*)',rmvContactAttn,4),
									
								   StringLib.stringfind(rmvContactAttn,'/',1) > 0 and StringLib.stringfind(rmvContactAttn,'DBA',1)>0 
										and REGEXFIND('^([A-Za-z ][^\\/]+)[\\/]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*.)[\\)]',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\/]+)[\\/]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*.)[\\)]',rmvContactAttn,3),
										
								   StringLib.stringfind(rmvContactAttn,', ,',1) > 0 and StringLib.stringfind(rmvContactAttn,'DBA',1)>0 =>
										REGEXFIND('^([A-Za-z ][^\\,]+),([A-Za-z ][^\\, ,]+), ,[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn,3),
								   								   	
								   StringLib.stringfind(rmvContactAttn,', DBA',1)>0 
										and REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn,3),	
										
								   StringLib.stringfind(rmvContactAttn,', DBA',1)>0
										and REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn,3),
								   
									StringLib.stringfind(rmvContactAttn,',',1) > 0 and StringLib.stringfind(rmvContactAttn,', DBA',1)>0 
										and REGEXFIND('^([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA][^\\)]+)[\\)]',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA][^\\)]+)[\\)]',rmvContactAttn,3),
																	' ');
			self.dba4		:= MAP(StringLib.stringfind(rmvContactAttn,'/',1) > 0 and StringLib.stringfind(rmvContactAttn,'DBA',1)>0 
										and REGEXFIND('^([A-Za-z ][^\\/]+)[\\/]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)],[ ]([A-Za-z \\.]*)',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\/]+)[\\/]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)],[ ]([A-Za-z \\.]*)',rmvContactAttn,4),	
										
								   StringLib.stringfind(rmvContactAttn,', DBA',1)>0 
										and REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\;]+)[\\;][ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn,4),	
										
								   StringLib.stringfind(rmvContactAttn,', DBA',1)>0
										and REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn)
										=> REGEXFIND('^([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\,]+)[\\,][ ]([A-Za-z ][^\\,]+),[ ]([A-Za-z ][^\\(]+)[\\(]([A-Za-z \\. \\, DBA]*)[\\)]',rmvContactAttn,4),
								   														' ');
			self.dba5	:= ' ';
				
			/* fields used to create mltrec_key unique record split dba key are :
			   transformed license number
			   standardized license type
			   standardized source update
			   raw name containing dba name(s)
			   raw address
			*/
			self.mltrec_key		:= IF(trim(self.dba1,left,right) != ' ' and trim(self.dba2,left,right) != ' ' 
									   and trim(self.dba1,left,right) != trim(self.dba2,left,right),
										hash32(trim(self.license_nbr,left,right) 
												+trim(self.std_license_type,left,right)
												+trim(self.std_source_upd,left,right)
												+Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.NAME1)
												+Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.address1)),0);
									
			
		   /* fields used to create unique key are:
		      license number
			  license type
			  source update
			  name
			  address
		  */
			self.cmc_slpk  		:= hash32(trim(self.license_nbr,left,right) 
									+trim(self.std_license_type,left,right)
									+trim(self.std_source_upd,left,right)
									+trim(self.name_org,left,right)
									+Prof_License_Mari.mod_clean_name_addr.TRIMUPPER(pInput.address1));
			
			SELF := [];		   		   
END;

ds_map := project(ValidMTGFILE, transformToCommon(left));

					   
// Populate Standardized License field
maribase_plus_dbas trans_lic_status(ds_map L, SrcCmvTrans R) := transform
	self.STD_LICENSE_STATUS := R.DM_VALUE1;
	self := L;
end;

ds_map_stat_trans := JOIN(ds_map, SrcCmvTrans,
							TRIM(left.raw_license_status,left,right)= TRIM(right.fld_value,left,right)
	    					AND right.fld_name='LIC_STATUS',
							trans_lic_status(left,right),left outer,lookup);


// Populate STD_PROF_CD field via translation on license type field
maribase_plus_dbas trans_lic_type(ds_map_stat_trans L, SrcCmvTrans R) := transform
	self.STD_PROF_CD := R.DM_VALUE1;
	self := L;
end;

ds_map_lic_trans := JOIN(ds_map_stat_trans, SrcCmvTrans,
						TRIM(left.std_license_type,left,right)= TRIM(right.fld_value,left,right)
						AND right.fld_name='LIC_TYPE' 
						AND right.dm_name1 = 'PROFCODE',
						trans_lic_type(left,right),left outer,lookup);
																		
// Populate prof code description
maribase_plus_dbas  trans_prof_desc(ds_map_lic_trans L, prof_license_mari.files_References.MARIcmvprof R) := transform
  self.STD_PROF_DESC := StringLib.stringtouppercase(trim(R.PROF_DESC,left,right));
	self := L;
end;

ds_map_prof_desc := JOIN(ds_map_lic_trans, prof_license_mari.files_References.MARIcmvprof,
						 TRIM(left.std_prof_cd,left,right)= TRIM(right.prof_cd,left,right),
						 trans_prof_desc(left,right),left outer,lookup);
																		

// Populate License Status Description field
maribase_plus_dbas trans_status_desc(ds_map_prof_desc L, prof_license_mari.files_References.MARIcmvlicstatus R) := transform
  self.STD_STATUS_DESC := StringLib.stringtouppercase(trim(R.STATUS_DESC,left,right));
  self := L;
end;

ds_map_status_desc := jOIN(ds_map_prof_desc, prof_license_mari.files_References.MARIcmvlicstatus,
							TRIM(left.std_license_status,left,right)= TRIM(right.license_status,left,right),
							trans_status_desc(left,right),left outer,lookup);
																		
																		
//Populate License Type Description field
maribase_plus_dbas trans_type_desc(ds_map_status_desc L, SrcCmvType R) := transform
  self.STD_LICENSE_DESC := StringLib.stringtouppercase(trim(R.LICENSE_DESC,left,right));
  self := L;
end;

ds_map_type_desc := JOIN(ds_map_status_desc, SrcCmvType,
						TRIM(left.std_license_type,left,right) = TRIM(right.license_type,left,right),
						trans_type_desc(left,right),left outer,lookup);
						
						
//Populate Source Description field
maribase_plus_dbas trans_source_desc(ds_map_type_desc L, SrcCmv R) := transform
  self.STD_SOURCE_DESC := StringLib.stringtouppercase(trim(R.SRC_NAME,left,right));
  self := L;
end;

ds_map_source_desc := join(ds_map_type_desc, SrcCmv,
						TRIM(left.std_source_upd,left,right)= TRIM(right.src_nbr,left,right),
						trans_source_desc(left,right),left outer,lookup);


//Perform lookup to assign pcmcslpk of child to cmcslpk of parent
company_only_lookup := ds_map_source_desc(affil_type_cd='CO');

maribase_plus_dbas 		assign_pcmcslpk(ds_map_source_desc L, company_only_lookup R) := transform
		self.pcmc_slpk := R.cmc_slpk;
		self := L;
end;

ds_map_affil := join(ds_map_source_desc, company_only_lookup,
						TRIM(left.name_org[1..50]+ left.std_license_type[1..2],left,right) = TRIM(right.name_org[1..50]+right.std_license_type[1..2],left,right)
						AND left.AFFIL_TYPE_CD = 'BR',
						assign_pcmcslpk(left,right),left outer,lookup);																		

maribase_plus_dbas 		xTransPROVNOTE(ds_map_affil L) := transform
		self.provnote_1 := map(L.provnote_1 != '' and L.pcmc_slpk = 0 and L.affil_type_cd = 'BR' => 
									TRIM(L.provnote_1,left,right)+ '|' + 'This is not a main office.  It is a branch office without an associated main office from this source.',
							   L.provnote_1 = '' and L.pcmc_slpk = 0 and L.affil_type_cd = 'BR' => 
									'This is not a main office.  It is a branch office without an associated main office from this source.',L.PROVNOTE_1);

	self := L;
end;

ds_map_assign:= project(ds_map_affil, xTransPROVNOTE(left));

// Normalized DBA records
maribase_dbas := record,maxlength(5000)
  maribase_plus_dbas;
  string60 tmp_dba;
end;

maribase_dbas	NormIT(ds_map_assign L, INTEGER C) := TRANSFORM
    self := L;
	self.TMP_DBA := CHOOSE(C, L.DBA, L.DBA1, L.DBA2, L.DBA3, L.DBA4, L.DBA5);
END;

NormDBAs 	:= DEDUP(NORMALIZE(ds_map_assign,6,NormIT(left,counter)),all,record);

NoDBARecs	:= NormDBAs(TMP_DBA = '' AND DBA = '' AND DBA1 = '' 
				AND DBA2 = '' AND DBA3 = '' AND DBA4 = '' AND DBA5 = '');
DBARecs 	:= NormDBAs(TMP_DBA != '');

FilteredRecs  := DBARecs + NoDBARecs;

// output(FilteredRecs(StringLib.stringfind(name_dba_orig,'THE',1)> 0));

// Transform expanded dataset to MARIBASE layout
// Apply DBA Business Rules
Prof_License_Mari.layouts_reference.MARIBASE 	xTransToBase(FilteredRecs L) := transform
		self.NAME_ORG		:= IF(StringLib.stringfind(L.NAME_ORG,'PREFII PREFERREDME JOINT VENTURE',1) >0, 
										StringLib.StringFindReplace(L.NAME_ORG,'PREFII PREFERREDME JOINT VENTURE','PREFII PREFERRED INCOME JOINT VENTURE'),
											L.NAME_ORG);
		self.NAME_ORG_SUFX	:= Prof_License_Mari.mod_clean_name_addr.strippunctName(L.NAME_ORG_SUFX);
	
		TrimDBASufx			:= MAP(REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) => StringLib.StringFindReplace(L.TMP_DBA,'CO',''),
							   NOT REGEXFIND('([Cc][Oo][\\.]?)$',L.TMP_DBA) => Prof_License_Mari.mod_clean_name_addr.cleanFName(L.TMP_DBA), 
							   '');
							   
		prep_NAME_DBA		:= IF(StringLib.stringfind(L.TMP_DBA,'A PARTNERSHIP',1) >0, '',L.TMP_DBA);
		
		StdNAME_DBA			:= Prof_License_Mari.mod_clean_name_addr.StdCorpSuffix(prep_NAME_DBA);
		StripNAME_DBA		:= StringLib.StringFindReplace(StdNAME_DBA,'(','');
		CleanNAME_DBA		:= MAP(StringLib.stringfind(StripNAME_DBA,'.COM',1) > 0 => StringLib.StringFindReplace(StripNAME_DBA,')',''),
										REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StripNAME_DBA,left,right)) => StripNAME_DBA,
										REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StripNAME_DBA,left,right)) => StripNAME_DBA,
												Prof_License_Mari.mod_clean_name_addr.cleanFName(StripNAME_DBA));
		
		DBA_PREFX			:= Prof_License_Mari.mod_clean_name_addr.GetCorpPrefix(L.TMP_DBA);
		DBA_SUFX				:= MAP(REGEXFIND('^([A-Za-z ]*)(INC)([A-Za-z ]*)',TRIM(StripNAME_DBA,left,right)) => '',
									   // REGEXFIND(StringLib.stringfind(StripNAME_DBA,'PRINCETON',1) >0 => '',
									   REGEXFIND('^([A-Za-z ]*)(CORP)[ ]([A-Za-z ]*)',TRIM(StripNAME_DBA,left,right)) => '',
									   REGEXFIND('^([A-Za-z ]*)(INC)[ ]([A-Za-z ]*)',TRIM(StripNAME_DBA,left,right)) => '',
												Prof_License_Mari.mod_clean_name_addr.GetCorpSuffix(StripNAME_DBA));
		
		self.NAME_DBA_PREFX	:= TRIM(DBA_PREFX,LEFT,RIGHT);
		self.NAME_DBA 		:= TRIM(CleanNAME_DBA,LEFT,RIGHT);
		self.DBA_FLAG       := IF(trim(self.name_dba,left,right) != '',1,0); // 1: true  0: false
		self.NAME_DBA_SUFX	:= StringLib.StringFilterOut(DBA_SUFX, '.'); 
		self.NAME_MARI_DBA	:= IF(StringLib.stringfind(StripNAME_DBA,'.COM',1) > 0, StripNAME_DBA,
									Prof_License_Mari.mod_clean_name_addr.strippunctName(StripNAME_DBA)); 
		self.ADDR_ADDR1_1	:= Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR1_1);
		self.ADDR_ADDR2_1	:= Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR2_1);
		self.ADDR_ADDR3_1	:= Prof_License_Mari.mod_clean_name_addr.strippunctMisc(L.ADDR_ADDR3_1);
	
		self := L;
end;

ds_map_base := project(FilteredRecs, xTransToBase(left));


// output(ds_map_base(StringLib.stringfind(name_org_orig,'ORG_NAME(200)',1) >0));
// output(ds_map_base(name_org_orig = ' ' and license_nbr = ' '));
// output(ds_map_base(StringLib.stringfind(name_dba_orig,'THE',1)> 0));
// output(ds_map_base(StringLib.stringfind(name_org_orig,'C/O',1)> 0 or StringLib.stringfind(name_dba_orig,'C/O',1)> 0));
// output(ds_map_base(StringLib.stringfind(name_dba_orig,'C/O',1)> 0));
// output(ds_map_base(StringLib.stringfind(name_dba_orig,'ATTN:',1)> 0));
// output(ds_map_assign(StringLib.stringfind(provnote_3,'ATTN:',1)> 0 or StringLib.stringfind(provnote_3,'C/O',1)> 0));
// output(ds_map_base(StringLib.stringfind(name_org_orig,'PRINCETON',1)> 0 OR StringLib.stringfind(name_dba_orig,'PRINCETON',1)> 0));
// output(ds_map_assign(StringLib.stringfind(name_dba_orig,'ATTN:',1)> 0));
// output(ds_map_base(name_org_orig != ' ' and name_dba_orig = ''));
// output(ds_map_base(NOT StringLib.stringfind(name_dba_orig,'DBA',1)> 0 and name_org_orig != ' ' and name_dba_orig != ' '));
// output(ds_map_base(StringLib.stringfind(name_dba_orig,'DBA',1)> 0 and StringLib.stringfind(name_dba_orig[1],'(',1)> 0));
// output(ds_map_base(NOT StringLib.stringfind(name_dba_orig,'DBA',1)> 0 AND StringLib.stringfind(name_org_orig,'/',1)> 0
								// and NOT StringLib.stringfind(name_org_orig,'C/O',1)> 0));
// output(ds_map_base(NOT StringLib.stringfind(name_dba_orig,'DBA',1)> 0 and NOT StringLib.stringfind(name_dba_orig[1..3],'INC',1)> 0 and 
				// NOT StringLib.stringfind(name_dba_orig[1..4],'ATTN',1)> 0 and NOT StringLib.stringfind(name_dba_orig[1..3],'C/O',1)> 0 and 
					// NOT StringLib.stringfind(name_dba_orig[1..4],'CORP',1)> 0 and name_dba_orig != ' '));
// output(ds_map_base(StringLib.stringfind(name_dba_orig,'COLDWELL BANK',1)> 0));

																


// Adding to Superfile
d_final := output(ds_map_base, ,'~thor_data400::in::prolic::mari::'+process_date+'::'+src_cd,__compressed__,overwrite);
		
add_super := sequential(fileservices.startsuperfiletransaction(),
													fileservices.addsuperfile('~thor_data400::in::prolic::mari::'+src_cd,'~thor_data400::in::prolic::mari::'+process_date+'::'+src_cd),
													fileservices.finishsuperfiletransaction()
													);

sequential(d_final, add_super); 

export map_CAS0611_conversion := sequential(d_final, add_super);

// export map_CAS0611_conversion := ds_map_base;




