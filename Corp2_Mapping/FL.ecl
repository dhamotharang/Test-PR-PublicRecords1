import ut, lib_stringlib, _validate, Address, corp2, corp2_mapping, lib_datalib, _control, versioncontrol;

export FL := MODULE;
	
	export Layouts_Raw_Input := MODULE;

		export DailyFile := record
			string12 ANN_COR_NUMBER;
			string48 ANN_COR_NAME;
			string01 ANN_COR_STATUS;
			string15 ANN_COR_FILING_TYPE;
			string42 ANN_COR_2ND_MAIL_ADD1;
			string42 ANN_COR_2ND_MAIL_ADD2;
			string28 ANN_COR_2ND_MAIL_CITY;
			string02 ANN_COR_2ND_MAIL_STATE;
			string10 ANN_COR_2ND_MAIL_ZIP;
			string02 ANN_COR_2ND_MAIL_COUNTRY;
			string08 ANN_COR_FILE_DATE;
			string14 ANN_COR_FEI_NUMBER;
			string01 ANN_SIX_OFF_FLAG;
			string08 ANN_LAST_TRX_DATE;
			string02 ANN_STATE_COUNTRY;
			string04 ANN_REPORT_YEAR1;
			string01 ANN_HOUSE_FLAG1;
			string08 ANN_REPORT_DATE1;
			string04 ANN_REPORT_YEAR2;
			string01 ANN_HOUSE_FLAG2;
			string08 ANN_REPORT_DATE2;
			string04 ANN_REPORT_YEAR3;
			string01 ANN_HOUSE_FLAG3;
			string08 ANN_REPORT_DATE3;
			string42 ANN_RA_NAME;
			string01 ANN_RA_NAME_TYPE;
			string42 ANN_RA_ADD1;
			string28 ANN_RA_CITY;
			string02 ANN_RA_STATE;
			string05 ANN_RA_ZIP5;
			string04 ANN_RA_ZIP4;
			string04 ANN_PRINC1_TITLE;
			string01 ANN_PRINC1_NAME_TYPE;
			string42 ANN_PRINC1_NAME;
			string42 ANN_PRINC1_ADD1;
			string28 ANN_PRINC1_CITY;
			string02 ANN_PRINC1_STATE;
			string05 ANN_PRINC1_ZIP5;
			string04 ANN_PRINC1_ZIP4;
			string04 ANN_PRINC2_TITLE;
			string01 ANN_PRINC2_NAME_TYPE;
			string42 ANN_PRINC2_NAME;
			string42 ANN_PRINC2_ADD1;
			string28 ANN_PRINC2_CITY;
			string02 ANN_PRINC2_STATE;
			string05 ANN_PRINC2_ZIP5;
			string04 ANN_PRINC2_ZIP4;
			string04 ANN_PRINC3_TITLE;
			string01 ANN_PRINC3_NAME_TYPE;
			string42 ANN_PRINC3_NAME;
			string42 ANN_PRINC3_ADD1;
			string28 ANN_PRINC3_CITY;
			string02 ANN_PRINC3_STATE;
			string05 ANN_PRINC3_ZIP5;
			string04 ANN_PRINC3_ZIP4;
			string04 ANN_PRINC4_TITLE;
			string01 ANN_PRINC4_NAME_TYPE;
			string42 ANN_PRINC4_NAME;
			string42 ANN_PRINC4_ADD1;
			string28 ANN_PRINC4_CITY;
			string02 ANN_PRINC4_STATE;
			string05 ANN_PRINC4_ZIP5;
			string04 ANN_PRINC4_ZIP4;
			string04 ANN_PRINC5_TITLE;
			string01 ANN_PRINC5_NAME_TYPE;
			string42 ANN_PRINC5_NAME;
			string42 ANN_PRINC5_ADD1;
			string28 ANN_PRINC5_CITY;
			string02 ANN_PRINC5_STATE;
			string05 ANN_PRINC5_ZIP5;
			string04 ANN_PRINC5_ZIP4;
			string04 ANN_PRINC6_TITLE;
			string01 ANN_PRINC6_NAME_TYPE;
			string42 ANN_PRINC6_NAME;
			string42 ANN_PRINC6_ADD1;
			string28 ANN_PRINC6_CITY;
			string02 ANN_PRINC6_STATE;
			string05 ANN_PRINC6_ZIP5;
			string04 ANN_PRINC6_ZIP4;
			string04 FILLER;
			string02 LF;
			end;
			
		export EventFile := record
			string012 COR_EVENT_DOC_NUMBER;                     
			string005 COR_EVENT_SEQ_NUMBER;                     
			string020 COR_EVENT_CODE;                           
			string020 COR_EVENT_DESC1;                           
			string020 COR_EVENT_DESC2;
			string008 COR_EVENT_EFFT_DATE;                      
			string008 COR_EVENT_FILED_DATE;                     
			string035 COR_EVENT_NOTE_1;                         
			string035 COR_EVENT_NOTE_2;                         
			string035 COR_EVENT_NOTE_3;                         
			string012 COR_EVENT_CONS_MER_NUMBER;                
			string192 COR_EVENT_COR_NAME;                       
			string005 COR_EVENT_NAME_SEQ;                       
			string005 COR_EVENT_X_NAME_SEQ;                     
			string001 COR_EVENT_NAME_CHG;                       
			string001 COR_EVENT_X_NAME_CHG;                     
			string042 COR_EVENT_ADD_1;                          
			string042 COR_EVENT_ADD_2;                          
			string028 COR_EVENT_CITY;                           
			string002 COR_EVENT_STATE;                          
			string010 COR_EVENT_ZIP;                            
			string042 COR_EVENT_MAIL_ADD_1;                     
			string042 COR_EVENT_MAIL_ADD_2;                     
			string028 COR_EVENT_MAIL_CITY;                      
			string002 COR_EVENT_MAIL_STATE;                     
			string010 COR_EVENT_MAIL_ZIP; 
			string002 LF;
			end;
			
		export TMFile := record
			string012 TM_NUMBER;
			string001 TM_CLASS_TYPE_01; 
			string004 TM_CLASS_01;
			string001 TM_CLASS_TYPE_02; 
			string004 TM_CLASS_02;
			string001 TM_CLASS_TYPE_03; 
			string004 TM_CLASS_03;
			string001 TM_CLASS_TYPE_04; 
			string004 TM_CLASS_04;
			string001 TM_CLASS_TYPE_05; 
			string004 TM_CLASS_05;
			string001 TM_CLASS_TYPE_06; 
			string004 TM_CLASS_06;
			string001 TM_CLASS_TYPE_07; 
			string004 TM_CLASS_07;
			string001 TM_CLASS_TYPE_08; 
			string004 TM_CLASS_08;
			string001 TM_CLASS_TYPE_09; 
			string004 TM_CLASS_09;
			string001 TM_CLASS_TYPE_10; 
			string004 TM_CLASS_10;
			string001 TM_CLASS_TYPE_11; 
			string004 TM_CLASS_11;
			string001 TM_CLASS_TYPE_12; 
			string004 TM_CLASS_12;
			string001 TM_CLASS_TYPE_13; 
			string004 TM_CLASS_13;
			string001 TM_CLASS_TYPE_14; 
			string004 TM_CLASS_14;
			string001 TM_CLASS_TYPE_15; 
			string004 TM_CLASS_15;
			string001 TM_CLASS_TYPE_16; 
			string004 TM_CLASS_16;
			string001 TM_CLASS_TYPE_17; 
			string004 TM_CLASS_17;
			string001 TM_CLASS_TYPE_18; 
			string004 TM_CLASS_18;
			string001 TM_CLASS_TYPE_19; 
			string004 TM_CLASS_19;
			string001 TM_CLASS_TYPE_20; 
			string004 TM_CLASS_20;
			string001 TM_STATUS;
			string042 TM_DISCLAIMER_1;
			string042 TM_DISCLAIMER_2;
			string050 TM_USED_1;
			string050 TM_USED_2;
			string008 TM_EP_DATE;
			string008 TM_DATE_FILED;
			string008 TM_1ST_DATE;
			string008 TM_1ST_FLA_DATE;
			string005 TM_TRADE_SEQ;
			string005 TM_PRINCE_SEQ;
			string012 TM_PRINCE_DOC_NUMBER_01;
			string042 TM_PRINCE_NAME_01;
			string042 TM_PRINCE_MAIL_ADD1_01;
			string042 TM_PRINCE_MAIL_ADD2_01;
			string028 TM_PRINCE_MAIL_CITY_01;
			string002 TM_PRINCE_MAIL_STATE_01;
			string010 TM_PRINCE_MAIL_ZIP_01;
			string002 TM_PRINCE_MAIL_COUNTRY_01;
			string012 TM_PRINCE_DOC_NUMBER_02;
			string042 TM_PRINCE_NAME_02;
			string042 TM_PRINCE_MAIL_ADD1_02;
			string042 TM_PRINCE_MAIL_ADD2_02;
			string028 TM_PRINCE_MAIL_CITY_02;
			string002 TM_PRINCE_MAIL_STATE_02;
			string010 TM_PRINCE_MAIL_ZIP_02;
			string002 TM_PRINCE_MAIL_COUNTRY_02;
			string012 TM_PRINCE_DOC_NUMBER_03;
			string042 TM_PRINCE_NAME_03;
			string042 TM_PRINCE_MAIL_ADD1_03;
			string042 TM_PRINCE_MAIL_ADD2_03;
			string028 TM_PRINCE_MAIL_CITY_03;
			string002 TM_PRINCE_MAIL_STATE_03;
			string010 TM_PRINCE_MAIL_ZIP_03;
			string002 TM_PRINCE_MAIL_COUNTRY_03;
			string012 TM_PRINCE_DOC_NUMBER_04;
			string042 TM_PRINCE_NAME_04;
			string042 TM_PRINCE_MAIL_ADD1_04;
			string042 TM_PRINCE_MAIL_ADD2_04;
			string028 TM_PRINCE_MAIL_CITY_04;
			string002 TM_PRINCE_MAIL_STATE_04;
			string010 TM_PRINCE_MAIL_ZIP_04;
			string002 TM_PRINCE_MAIL_COUNTRY_04;
			string012 TM_PRINCE_DOC_NUMBER_05;
			string042 TM_PRINCE_NAME_05;
			string042 TM_PRINCE_MAIL_ADD1_05;
			string042 TM_PRINCE_MAIL_ADD2_05;
			string028 TM_PRINCE_MAIL_CITY_05;
			string002 TM_PRINCE_MAIL_STATE_05;
			string010 TM_PRINCE_MAIL_ZIP_05;
			string002 TM_PRINCE_MAIL_COUNTRY_05;
			string012 TM_PRINCE_DOC_NUMBER_06;
			string042 TM_PRINCE_NAME_06;
			string042 TM_PRINCE_MAIL_ADD1_06;
			string042 TM_PRINCE_MAIL_ADD2_06;
			string028 TM_PRINCE_MAIL_CITY_06;
			string002 TM_PRINCE_MAIL_STATE_06;
			string010 TM_PRINCE_MAIL_ZIP_06;
			string002 TM_PRINCE_MAIL_COUNTRY_06;
			string005 TM_NUMBER_NAME;
			string192 TM_NAME;
			string005 TM_EVENT_SEQ;
			string020 TM_LAST_EVENT_CODE;
			string008 TM_LAST_EVENT_EFT_DATE;
			string008 TM_LAST_EVENT_FILED_DATE;
			string005 TM_XREF_SEQ;
			string192 TM_X_NAME;
			string050 TM_USED3;
			string002 crlf;
			end;
			
	end; // end of Layouts_Raw_Input module
	
	export Files_Raw_Input := MODULE;
	
		export dailyFile(string FileDate)		:= distribute(dataset('~thor_data400::in::corp2::'+filedate+'::dailyFile::fl',	
																	   layouts_Raw_Input.DailyFile,FLAT),hash32(ann_cor_number));
																	   
        export corpFile(string FileDate)		:= distribute(dataset('~thor_data400::in::corp2::'+filedate+'::corpFile::fl',	
																	   layouts_Raw_Input.DailyFile,FLAT),hash32(ann_cor_number));																	   
 
        export eventFile(string FileDate)		:= distribute(dataset('~thor_data400::in::corp2::'+filedate+'::eventFile::fl',	
																	   layouts_Raw_Input.EventFile,FLAT),hash32(cor_event_doc_number));
 
	end;

	
	export Update(string updateType, string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false) := function			
		
		TrimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
			end;					
			
		GetEventType(string evt) := function
		    eventType := case(trimUpper(evt),
							'CORAMADDIS' =>	'ADMINISTRATIVELY DISSOLVED',	
							'CORAMADMAR' =>	'ADMINISTRATIVE DISSOLUTION FOR ANNUAL REPORT',	
							'CORAMADMRA' =>	'ADMINISTRATIVE DISSOLUTION FOR REGISTED AGENT',	
							'CORAMADMTX' =>	'ADMINISTRATIVE DISSOLUTION FOR TAX WARRANT',	
							'CORAMADREV' => 'ADMINISTRATIVELY REVOKED',	
							'CORAMADVCN' =>	'ADVERTISED AND CANCELLED',	
							'CORAMCANNP' =>	'CANCEL FOR NON-PAYMENT',	
							'CORAMDCO'   =>	'DISSOLVED BY COURT ORDER',	
							'CORAMDSPRC' =>	'DISSOLVED BY PROCLAMATION',	
							'CORAMEXP'   =>	'EXPIRATION',	
							'CORAMFNQPP' =>	'FOREIGN NON QUALIFICATION PENALTY PAID',	
							'CORAMINVAR' =>	'INVOLUNTARILY DISSOLUTION FOR ANNUAL REPORT',	
							'CORAMINVOL' =>	'INVOLUNTARILY DISSOLVED',	
							'CORAMINVRA' =>	'INVOLUNTARILY DISSOLVED FOR REGISTERED AGENT',	
							'CORAMREV'   =>	'REVOCATION',
							'CORAMREVAR' =>	'REVOKED FOR ANNUAL REPORT',	
							'CORAMREVRA' =>	'REVOKED FOR REGISTERED AGENT',	
							'CORAMSURV'  =>	'EVENT CONVERTED TO NOTES',	
							'CORAPAFF'   =>	'AFFIDAVIT CHANGING OFFICERS',	
							'CORAPAMCAN' =>	'CANCELLED CREDIT UNION',	
							'CORAPAMDNC' =>	'AMENDMENT AND NAME CHANGE',	
							'CORAPAMNAR' =>	'AMENDED ARTICLES',	
							'CORAPAMNAS' =>	'AMENDED AUTHORIZED STOCK',	
							'CORAPAMNCE' =>	'AMENDED CERTIFICATE',	
							'CORAPAMND'  =>	'AMENDMENT',	
							'CORAPAMNRS' =>	'AMENDED AND RESTATED ARTICLES',	
							'CORAPAMNSN' =>	'AMENDED TO STOCK AND NAME CHANGE',	
							'CORAPAMRSC' =>	'AMENDED AND RESTATED CERTIFICATE',	
							'CORAPAREIN' =>	'REINCORPORATED',	
							'CORAPARNAM' =>	'AMENDED AND RESTATED ARTICLES/NAME CHANGE',	
							'CORAPARNC'  =>	'AMENDED ARTICLES AND NAME CHANGE',	
							'CORAPARTCR' =>	'ARTICLES OF CORRECTION',	
							'CORAPCANTM' =>	'TRADEMARK CANCELLATION',	
							'CORAPCCONS' =>	'CONSOLIDATION',	
							'CORAPCCONV' =>	'CONVERSTION',	
							'CORAPCMER'  =>	'MERGER',	
							'CORAPCONCH' =>	'CONTRIBUTION CHANGE',	
							'CORAPCONS'  =>	'CONSOLIDATION',	
							'CORAPCONV'  =>	'CONVERSION',	
							'CORAPCORNC' =>	'ARTICLES OF CORRECTION/NAME CHANGE',	
							'CORAPDBA'   =>	'DROPPING DBA',	
							'CORAPDBANC' =>	'CHANGING DBA',	
							'CORAPDOM'   =>	'DOMESTICATION',	
							'CORAPDSAST' =>	'DISTRIBUTION OF ASSETS',	
							'CORAPFNRRE' =>	'RENEWAL',	
							'CORAPLLIDS' =>	'INTENT TO DISSOLVE',	
							'CORAPMER'   =>	'MERGER',	
							'CORAPNC'    =>	'NAME CHANGE AMENDMENT',	
							'CORAPRCRNC' =>	'AMENDED AND RESTATED CERTIFICATE/NAME CHANGE',	
							'CORAPREIN'  =>	'REINSTATEMENT',	
							'CORAPREVDS' =>	'REVOCATION OF VOLUNTARY DISSOLUTION',	
							'CORAPRNC'   =>	'RESTATED ARTICLES AND NAME CHANGE',	
							'CORAPRSTAR' =>	'RESTATED ARTICLES',	
							'CORAPRSTCR' =>	'RESTATED CERTIFICATE',	
							'CORAPSHEX'  =>	'SHARE EXCHANGE',	
							'CORAPSTQUL' =>	'LLLP STATEMENT OF QUALIFICATION',	
							'CORAPTMASG' =>	'TRADEMARK ASSIGNMENT',	
							'CORAPTMREN' =>	'RENEWAL',	
							'CORAPVLDSI' =>	'VOLUNTARY DISSOLUTION OF INACTIVE CORPORATION',	
							'CORAPVOLCN' =>	'VOLUNTARY CANCELLATION',	
							'CORAPVOLDS' =>	'VOLUNTARY DISSOLUTION',	
							'CORAPWITH'  =>	'WITHDRAWAL',	
							'CORMERNC'   =>	'NAME CHANGE',
							'');
			return(eventType);
			end;
			
			
		buildDate(string in_mm, string in_dd, string in_ccyy) := function		  
		    integer low19    :=20;
            integer high19   :=99;
			
		    string2 out_cc   := if(length(in_ccyy)=4,
							   in_ccyy[1..2],
							   if((integer)in_ccyy BETWEEN low19 AND high19,
								'19',
								'20')); 
								
		    string2 out_yy   := if(length(in_ccyy)=4,
							   in_ccyy[3..4],
							   in_ccyy);
		  
		    string2 out_dd   := if(length(in_dd)=2,
							   in_dd,
							   '0'+in_dd);
							   
		    string2 out_mm   := if(length(in_mm)=2,
							   in_mm,
							   '0'+in_mm);
          		     
	
		    string8 fullDate := out_cc +
			    				out_yy +
							    out_mm +
							    out_dd;
				   
		    return if(_validate.date.fIsValid(fullDate) and 
					  _validate.date.fIsValid(fullDate,_validate.date.rules.DateInPast),
					  fullDate,
					 '');
			end;
			
			datePattern 	:= '(\\d{1,2})[-/](\\d{1,2})[-/](\\d{1,4})';

			resignPattern 	:= 'RESIGNED|RETIRED';
			
			revokedPattern 	:= 'REVOKED';
			
		//---------------------- Code to normalize the Ann input file to separate Principals ----------------	
		
		normalizedPrince := record
			string12 ANN_COR_NUMBER;
			string48 ANN_COR_NAME;
			string01 ANN_COR_STATUS;
			string15 ANN_COR_FILING_TYPE;
			string42 ANN_COR_2ND_MAIL_ADD1;
			string42 ANN_COR_2ND_MAIL_ADD2;
			string28 ANN_COR_2ND_MAIL_CITY;
			string02 ANN_COR_2ND_MAIL_STATE;
			string10 ANN_COR_2ND_MAIL_ZIP;
			string02 ANN_COR_2ND_MAIL_COUNTRY;
			string08 ANN_COR_FILE_DATE;
			string14 ANN_COR_FEI_NUMBER;
			string01 ANN_SIX_OFF_FLAG;
			string08 ANN_LAST_TRX_DATE;
			string02 ANN_STATE_COUNTRY;
			string04 ANN_REPORT_YEAR1;
			string01 ANN_HOUSE_FLAG1;
			string08 ANN_REPORT_DATE1;
			string04 ANN_REPORT_YEAR2;
			string01 ANN_HOUSE_FLAG2;
			string08 ANN_REPORT_DATE2;
			string04 ANN_REPORT_YEAR3;
			string01 ANN_HOUSE_FLAG3;
			string08 ANN_REPORT_DATE3;
			string42 ANN_RA_NAME;
			string01 ANN_RA_NAME_TYPE;
			string42 ANN_RA_ADD1;
			string28 ANN_RA_CITY;
			string02 ANN_RA_STATE;
			string05 ANN_RA_ZIP5;
			string04 ANN_RA_ZIP4;
			string04 ANN_PRINCE_TITLE;
			string01 ANN_PRINCE_NAME_TYPE;
			string42 ANN_PRINCE_NAME;
			string42 ANN_PRINCE_ADD1;
			string28 ANN_PRINCE_CITY;
			string02 ANN_PRINCE_STATE;
			string05 ANN_PRINCE_ZIP5;
			string04 ANN_PRINCE_ZIP4;
			string01 Position;
			end;						

		normalizedPrince normalizePrince(Layouts_Raw_Input.dailyFile l, unsigned1 cnt) := transform
			self.ANN_PRINCE_TITLE	    := choose(cnt,
												  l.ANN_PRINC1_TITLE,
												  l.ANN_PRINC2_TITLE,
												  l.ANN_PRINC3_TITLE,
												  l.ANN_PRINC4_TITLE,
												  l.ANN_PRINC5_TITLE,
												  l.ANN_PRINC6_TITLE);
			self.ANN_PRINCE_NAME_TYPE   := choose(cnt,
												  l.ANN_PRINC1_NAME_TYPE,
												  l.ANN_PRINC2_NAME_TYPE,
												  l.ANN_PRINC3_NAME_TYPE,
												  l.ANN_PRINC4_NAME_TYPE,
												  l.ANN_PRINC5_NAME_TYPE,
												  l.ANN_PRINC6_NAME_TYPE);
			self.ANN_PRINCE_NAME		:= choose(cnt,
												  l.ANN_PRINC1_NAME,
												  l.ANN_PRINC2_NAME,
												  l.ANN_PRINC3_NAME,
												  l.ANN_PRINC4_NAME,
												  l.ANN_PRINC5_NAME,
												  l.ANN_PRINC6_NAME);
			self.ANN_PRINCE_ADD1		:= choose(cnt,
												  l.ANN_PRINC1_ADD1,
												  l.ANN_PRINC2_ADD1,
												  l.ANN_PRINC3_ADD1,
												  l.ANN_PRINC4_ADD1,
												  l.ANN_PRINC5_ADD1,
												  l.ANN_PRINC6_ADD1);
			self.ANN_PRINCE_CITY		:= choose(cnt,
												  l.ANN_PRINC1_CITY,
												  l.ANN_PRINC2_CITY,
												  l.ANN_PRINC3_CITY,
												  l.ANN_PRINC4_CITY,
												  l.ANN_PRINC5_CITY,
												  l.ANN_PRINC6_CITY);	
			self.ANN_PRINCE_STATE		:= choose(cnt,
												  l.ANN_PRINC1_STATE,
												  l.ANN_PRINC2_STATE,
												  l.ANN_PRINC3_STATE,
												  l.ANN_PRINC4_STATE,
												  l.ANN_PRINC5_STATE,
												  l.ANN_PRINC6_STATE);
			self.ANN_PRINCE_ZIP5		:= choose(cnt,
												  l.ANN_PRINC1_ZIP5,
												  l.ANN_PRINC2_ZIP5,
												  l.ANN_PRINC3_ZIP5,
												  l.ANN_PRINC4_ZIP5,
												  l.ANN_PRINC5_ZIP5,
												  l.ANN_PRINC6_ZIP5);
			self.ANN_PRINCE_ZIP4		:= choose(cnt,
												  l.ANN_PRINC1_ZIP4,
												  l.ANN_PRINC2_ZIP4,
												  l.ANN_PRINC3_ZIP4,
												  l.ANN_PRINC4_ZIP4,
												  l.ANN_PRINC5_ZIP4,
												  l.ANN_PRINC6_ZIP4);
			self.Position		        := (string) cnt;													  		
			self 						:= l;
			end;

		// NormalizedPrinceInput	:= normalize(Files_Raw_Input.dailyFile(fileDate), 6, normalizePrince(left, counter));
		NormalizedPrinceInput	:= normalize(Files_Raw_Input.corpFile(fileDate), 6, normalizePrince(left, counter));
	       		
			//--------- Normalize the vendor input file to separate the Annual Reports ----------------	
		
		normalizedAR := record
			string12 ANN_COR_NUMBER;			
			string04 ANN_REPORT_YEAR;
			string01 ANN_HOUSE_FLAG;
			string08 ANN_REPORT_DATE;
			string01 Position;								
			end;						

		normalizedAr normalizeAr(Layouts_Raw_Input.dailyFile l, unsigned1 cnt) := transform
			self.ANN_COR_NUMBER	    := l.ANN_COR_NUMBER;
			self.ANN_REPORT_YEAR    := choose(cnt,
												  l.ANN_REPORT_YEAR1,
												  l.ANN_REPORT_YEAR2,
												  l.ANN_REPORT_YEAR3);
			self.ANN_HOUSE_FLAG		:= choose(cnt,
												  l.ANN_HOUSE_FLAG1,
												  l.ANN_HOUSE_FLAG2,
												  l.ANN_HOUSE_FLAG3);
			self.ANN_REPORT_DATE	:= choose(cnt,
												  l.ANN_REPORT_DATE1,
												  l.ANN_REPORT_DATE2,
												  l.ANN_REPORT_DATE3);				
			self.Position		    := (string) cnt;													  		
			end;

		// NormalizedArInput	:= normalize(Files_Raw_Input.dailyFile(fileDate), 3, normalizeAr(left, counter));
		NormalizedArInput	:= normalize(Files_Raw_Input.corpFile(fileDate), 3, normalizeAr(left, counter));
				
		corp2_mapping.Layout_CorpPreClean corpTransform(Layouts_Raw_Input.dailyFile input) := transform,
											SKIP(trim(input.ann_cor_name,left,right)='')

			raAddr1                             := trimUpper(input.ann_ra_add1);
			hasRevoke1 							:= if(regexfind(revokedPattern,raAddr1),
														TRUE,
														FALSE);
			raAddr2     				        := if(hasRevoke1,
														'',
														raAddr1);
		    raAddlInfo1    				        := if(hasRevoke1,
														raAddr1,
														'');
			hasResign1 							:= if(regexfind(resignPattern,raAddr2),
														TRUE,
														FALSE);
			dateOnly1 							:= if(hasResign1,
														regexfind(datePattern,raAddr2,0),
														'');
			mmOnly1 							:= if(hasResign1,
														regexfind(datePattern,raAddr2,1),
														'');
			ddOnly1 							:= if(hasResign1,
														regexfind(datePattern,raAddr2,2),
														'');
			ccyyOnly1 							:= if(hasResign1,
														regexfind(datePattern,raAddr2,3),
														'');
			raAddr3 							:= if(hasResign1 and (dateOnly1<>''),
														regexreplace(resignPattern,raAddr2,''),
														'');
  
			raAddr4						        := if(hasResign1 and (dateOnly1<>''),
														regexreplace(datePattern,raAddr3,''),
														'');
  
			raAddr5                  			:= if(hasResign1 and (dateOnly1<>''),
														regexreplace('\\*',raAddr4,''),
														'');
			raResignDate1                       := if(hasResign1 and (dateOnly1<>''),
														buildDate(mmOnly1,ddOnly1,ccyyOnly1),
														'');
														
            raName1                             := trimUpper(input.ann_ra_name);
			hasRevoke2 							:= if(regexfind(revokedPattern,raName1),
														TRUE,
														FALSE);
			raName2     				        := if(hasRevoke2,
														'',
														raName1);
		    raAddlInfo2    				        := if(hasRevoke2,
														raName1,
														'');
			hasResign2							:= if(regexfind(resignPattern,raName2),
														TRUE,
														FALSE);
			dateOnly2 							:= if(hasResign2,
														regexfind(datePattern,raName2,0),
														'');
			mmOnly2 							:= if(hasResign2,
														regexfind(datePattern,raName2,1),
														'');
			ddOnly2 							:= if(hasResign2,
														regexfind(datePattern,raName2,2),
														'');
			ccyyOnly2 							:= if(hasResign2,
														regexfind(datePattern,raName2,3),
														'');
			raName3 							:= if(hasResign2 and (dateOnly2<>''),
														regexreplace(resignPattern,raName2,''),
														raName2);
  
			raName4						        := if(hasResign2 and (dateOnly2<>''),
														regexreplace(datePattern,raName3,''),
														raName3);
  
			raName5                  			:= if(hasResign2 and (dateOnly2<>''),
														regexreplace('\\*',raName4,''),
														raName4);
			raResignDate2                       := if(hasResign2 and (dateOnly2<>''),
														buildDate(mmOnly2,ddOnly2,ccyyOnly2),
														'');
			self.dt_first_seen					:= fileDate;
			self.dt_last_seen					:= fileDate;
			self.dt_vendor_first_reported		:= fileDate;
			self.dt_vendor_last_reported		:= fileDate;
			self.corp_ra_dt_first_seen			:= fileDate;
			self.corp_ra_dt_last_seen			:= fileDate;			
			self.corp_key						:= '12-' + trimUpper(input.ann_cor_number);
			self.corp_vendor					:= '12';
			self.corp_state_origin				:= 'FL';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.ann_cor_number);
			self.corp_src_type					:= 'SOS';
			
			self.corp_legal_name				:= trimUpper(input.ann_cor_name); 														
			self.corp_ln_name_type_cd			:= '01';
		 	self.corp_ln_name_type_desc			:='LEGAL';
			
			self.corp_address1_type_cd          := if(trimUpper(input.ann_cor_2nd_mail_add1)<>'' or
													  trimUpper(input.ann_cor_2nd_mail_city)<>'',
													  'M',
													  '');
			self.corp_address1_type_desc        := if(trimUpper(input.ann_cor_2nd_mail_add1)<>'' or
													  trimUpper(input.ann_cor_2nd_mail_city)<>'',
													  'MAILING',
													  '');
			self.corp_address1_line1			:= trimUpper(input.ann_cor_2nd_mail_add1);
			self.corp_address1_line2			:= trimUpper(input.ann_cor_2nd_mail_add2);
			self.corp_address1_line3			:= trimUpper(input.ann_cor_2nd_mail_city);
			self.corp_address1_line4			:= trimUpper(input.ann_cor_2nd_mail_state);
			zip1								:= Stringlib.stringFilter(input.ann_cor_2nd_mail_zip,'0123456789');
			zip2								:= map(length(zip1) < 5 => '',
													   (integer) zip1 = 0 => '',
													   (integer) zip1[1..5] = 0 => '',
													   length(zip1) <> 9 => zip1[1..5],
													   (integer) zip1[6..9] = 0 => zip1[1..5],
													   zip1);													   													   														  													 
			self.corp_address1_line5			:= zip2;		
		 	self.corp_address1_line6 			:= if(trimUpper(input.ann_cor_2nd_mail_country) <> 'US',
													  trimUpper(input.ann_cor_2nd_mail_country),
													  '');
			self.corp_status_cd					:= if(trimUpper(input.ann_cor_status) in ['A','I'],
													  trimUpper(input.ann_cor_status),
													  '');
		 	self.corp_status_desc				:= map(trimUpper(input.ann_cor_status) = 'A' => 'ACTIVE',
													   trimUpper(input.ann_cor_status) = 'I' => 'INACTIVE',														
													   '');													  
		 	self.corp_fed_tax_id				:= if((integer) trimUpper(input.ann_cor_fei_number) <> 0,
													  trimUpper(input.ann_cor_fei_number),
													  '');
			
			self.corp_foreign_domestic_ind		:= map(input.ann_cor_filing_type = 'FLAL' => 'D',
													   input.ann_cor_filing_type[1..3] = 'DOM' => 'D',
													   input.ann_cor_filing_type[1..3] = 'FOR' => 'F',
													   '');												     
			
		 	self.corp_inc_state					:= if(trimUpper(input.ann_state_country) = 'FL',
														'FL',
														'');
												
												   
			self.corp_forgn_state_cd            := if(trimUpper(input.ann_state_country) <> 'FL',
													  trimUpper(input.ann_state_country),
													  '');
												   
		 	self.corp_forgn_state_desc          := if(trimUpper(input.ann_state_country) <> 'FL',
													  functions.decode_state(input.ann_state_country),
													  '');													  			
											
			self.corp_orig_org_structure_cd		:= trimUpper(input.ann_cor_filing_type);
			
		 	self.corp_orig_org_structure_desc	:= case(trimUpper(input.ann_cor_filing_type),
														'AGENT'	  => 'DECLARATION OF REGISTERED AGENT',
														'DOMLP'	  => 'DOMESTIC LIMITED PARTNERSHIP',
														'DOMNP'	  => 'DOMESTIC NON PROFIT',
														'DOMP'	  => 'DOMESTIC FOR PROFIT',
														'FLAL'	  => 'FLORIDA LIMITED LIABILITY',
														'FORL'	  => 'FOREIGN LIMITED LIABILITY',
														'FORLP'	  => 'FOREIGN LIMITED PARTNERSHIP',
														'FORNP'	  => 'FOREIGN NON PROFIT',
														'FORP'	  => 'FOREIGN FOR PROFIT',
														'NPREG'	  => 'NON PROFIT, REGULATED',
														'TRUST'   => 'DECLARATION OF TRUST',														
														''
														);
														
            self.corp_for_profit_ind 			:= MAP(trimUpper(input.ann_cor_filing_type)
																	in ['DOMNP','FORNP','NPREG'] => 'N',
													   trimUpper(input.ann_cor_filing_type)
																	in ['DOMP','FORP'] => 'Y',
													   '');
													  
			newFileDate							:= trim(input.ann_cor_file_date[5..8] + 
												        input.ann_cor_file_date[1..4],left,right);
												   
		 	self.corp_inc_date					:= if(trimUpper(input.ann_state_country) = 'FL' and													  
													  _validate.date.fIsValid(newFileDate) 		and
													  _validate.date.fIsValid(newFileDate,_validate.date.rules.DateInPast),
													    (newFileDate),
														'');
												      												   
		 	self.corp_forgn_date	            := if(trimUpper(input.ann_state_country) <> 'FL' and													  
													  _validate.date.fIsValid(newFileDate) 		 and
													  _validate.date.fIsValid(newFileDate,_validate.date.rules.DateInPast),
													    (newFileDate),
														'');
													   
			newStatusDate						:= trim(input.ann_last_trx_date[5..8] + 
												        input.ann_last_trx_date[1..4],left,right);
													   
			
			self.corp_status_date				:= if(_validate.date.fIsValid(newStatusDate) 	 and													  
													  _validate.date.fIsValid(newStatusDate,_validate.date.rules.DateInPast),
													    (newStatusDate),
														'');													              													   
        														   
			self.corp_ra_name					:= if((regexfind('[A-Z]',trimUpper(raName5))=false),
													'',
													trimUpper(raName5));
																						
			self.corp_ra_title_desc				:= if(self.corp_ra_name<>'',
													  'REGISTERED AGENT',
													  '');			
													  			 										  
			self.corp_ra_address_line1 			:= if((regexfind('[A-Z]',trimUpper(raAddr5))=false),
													'',
													trimUpper(raAddr5));
																											   																	   																   													   														  													 																	
			self.corp_ra_address_line3			:= if((regexfind('[A-Z]',trimUpper(input.ann_ra_city))=false),
													'',
													trimUpper(input.ann_ra_city));
														
			self.corp_ra_address_line4			:= if((regexfind('[A-Z]',trimUpper(input.ann_ra_state))=false),
													'',
													if(self.corp_ra_address_line1='' and 
													   self.corp_ra_address_line3='',
													   '',
													   trimUpper(input.ann_ra_state)));
			
			raZip51								:= Stringlib.stringFilter(input.ann_ra_zip5,'0123456789');
			
			raZip52								:= map(length(raZip51) <> 5 => '',
													   (integer) raZip51 = 0 => '',
													   raZip51);
			
            raZip41								:= Stringlib.stringFilter(input.ann_ra_zip4,'0123456789');
							
            raZip42								:= map(length(raZip41) <> 4 => '',
													   (integer) raZip41 = 0 => '',
													   raZip41);	
													   
			self.corp_ra_address_line5			:= if(self.corp_ra_address_line1='' and 
													  self.corp_ra_address_line3='' and
													  self.corp_ra_address_line4='',
													     '',
														 raZip52 + raZip42);
			
			self.corp_ra_address_type_cd   		:= if(self.corp_ra_address_line1<>'' or
													  self.corp_ra_address_line3<>'',
													  'G',
													  '');
			
			self.corp_ra_address_type_desc      := if(self.corp_ra_address_line1<>'' or
													  self.corp_ra_address_line3<>'' or
													  self.corp_ra_address_line4<>'',
													  'REGISTERED OFFICE',
													  '');
			self.corp_ra_resign_date            := if(raResignDate1<>'',
													  raResignDate1,	
													  if(raResignDate2<>'',
														 raResignDate2,
														 ''));
			self.corp_ra_addl_info              := if(raAddlInfo1<>'',
													  raAddlInfo1,	
													  if(raAddlInfo2<>'',
														 raAddlInfo2,
														 ''));
			self := [];
			end; 	
		
		
		corp2_mapping.Layout_ContPreClean contTransform(normalizedPrince input) := transform,
											SKIP(trim(input.ann_prince_name,left,right)='')
			self.dt_first_seen					:=fileDate;
			self.dt_last_seen					:=fileDate;			
			self.corp_key						:= '12-' + trimUpper(input.ann_cor_number);
			self.corp_vendor					:= '12';
			self.corp_state_origin				:= 'FL';
			self.corp_process_date				:= fileDate;
			self.corp_orig_sos_charter_nbr		:= trimUpper(input.ann_cor_number);				
			self.corp_legal_name				:= trimUpper(input.ann_cor_name);
			// self.corp_address1_type_cd          := if(trimUpper(input.ann_cor_2nd_mail_add1)<>'' or
												  // trimUpper(input.ann_cor_2nd_mail_city)<>'',
												  // 'M',
												  // '');
			// self.corp_address1_type_desc        := if(trimUpper(input.ann_cor_2nd_mail_add1)<>'' or
													  // trimUpper(input.ann_cor_2nd_mail_city)<>'',
													  // 'MAILING',
													  // '');
			// self.corp_address1_line1			:= trimUpper(input.ann_cor_2nd_mail_add1);
			// self.corp_address1_line2			:= trimUpper(input.ann_cor_2nd_mail_add2);
			// self.corp_address1_line3			:= trimUpper(input.ann_cor_2nd_mail_city);
			// self.corp_address1_line4			:= trimUpper(input.ann_cor_2nd_mail_state);
			// zip1								:= Stringlib.stringFilter(input.ann_cor_2nd_mail_zip,'0123456789');
			// zip2								:= map(length(zip1) < 5 => '',
													   // (integer) zip1 = 0 => '',
													   // (integer) zip1[1..5] = 0 => '',
													   // length(zip1) <> 9 => zip1[1..5],
													   // (integer) zip1[6..9] = 0 => zip1[1..5],
													   // zip1);													   													   														  													 
			// self.corp_address1_line5			:= zip2;		
		 	// self.corp_address1_line6 			:= if(trimUpper(input.ann_cor_2nd_mail_country) <> 'US',
													  // trimUpper(input.ann_cor_2nd_mail_country),
													  // '');
			self.cont_type_cd					:= if(trimUpper(input.ann_cor_filing_type) 			
													   in  ['AGENT',	  
														    'DOMNP',	  
														    'DOMP',	  
														    'FORNP',	  
														    'FORP',	  
														    'NPREG',	  
														    'TRUST'],   
														      'F',
														      'M');
            self.cont_type_desc					:= if(trimUpper(input.ann_cor_filing_type) 			
													   in  ['AGENT',	  
														    'DOMNP',	  
														    'DOMP',	  
														    'FORNP',	  
														    'FORP',	  
														    'NPREG',	  
														    'TRUST'],   
														      'OFFICER',
														      'MEMBER/MANAGER/PARTNER');																
			temp_cont_name						:= regexreplace('^[^ ]+',trimUpper(input.ann_prince_name),'$0,');			
			self.cont_name					    := regexreplace(',,',temp_cont_name,',');
			self.cont_title1_desc               := case(trimUpper(input.ann_prince_title),
														'AD'  	=> 'ASSISTANT DIRECTOR',
														'AS'  	=> 'ASSISTANT SECRETARY',
														'AV'  	=> 'ASSISTANT VICE PRESIDENT',
														'AVP' 	=> 'ASSISTANT VICE PRESIDENT',
														'C'	  	=> 'CHAIRMAN',
														'CEO'	=> 'CHIEF EXECUTIVE OFFICER',
														'CFO'	=> 'CHIEF FINANCIAL OFFICER',
														'COO'	=> 'CHIEF OPERATING OFFICER',
														'D'	  	=> 'DIRECTOR',
														'DIR'	=> 'DIRECTOR',
														'DT'   	=> 'DIRECTOR',														
														'G'   	=> 'GENERAL PARTNER',
														'MGR'   => 'MANAGER',
														'MGRM'  => 'MEMBER MANAGER',
														'P'   	=> 'PRESIDENT',
														'PD'   	=> 'PRESIDENT',
														'S'   	=> 'SECRETARY',
														'SD'   	=> 'SECRETARY',
														'T'   	=> 'TREASURER',
														'TD'   	=> 'TREASURER',
														'V'   	=> 'VICE PRESIDENT',
														'VD'   	=> 'VICE PRESIDENT',
														'VPT'   => 'VICE PRESIDENT',
														 trimUpper(input.ann_prince_title));	
			self.cont_address_line1			:= trimUpper(input.ann_prince_add1);
			self.cont_address_line3			:= trimUpper(input.ann_prince_city);
			self.cont_address_line4			:= trimUpper(input.ann_prince_state);			
			zip51							:= Stringlib.stringFilter(input.ann_prince_zip5,'0123456789');			
			zip52							:= map(length(zip51) <> 5 => '',
												   (integer) zip51 = 0 => '',
												   zip51);			
			zip41							:= Stringlib.stringFilter(input.ann_prince_zip4,'0123456789');							
			Zip42							:= map(length(zip41) <> 4 => '',
												   (integer) zip41 = 0 => '',
												   zip41);														   
			self.cont_address_line5			:= zip52 + zip42;																													
			self.cont_address_type_cd		:= if(trimUpper(input.ann_prince_add1)<>'' or
												  trimUpper(input.ann_prince_city)<>'',
												  'T',
												  '');																							 
			self.cont_address_type_desc		:= if(trimUpper(input.ann_prince_add1)<>'' or
												  trimUpper(input.ann_prince_city)<>'',
												  'CONTACT',
												  '');																								 																	  
			self.cont_addl_info				:= if(input.position = '1' and 
												  trimUpper(input.ann_six_off_flag) = 'Y',
												  'MORE THAN 6 PARTNERS ON FILE - CONTACT THE STATE',
												  '');
            self.cont_status_cd				:= if(trimUpper(input.ann_cor_status) in ['A','I'],
												  trimUpper(input.ann_cor_status),
											      '');
			self.cont_status_desc			:= map(trimUpper(input.ann_cor_status) = 'A' => 'ACTIVE',
												   trimUpper(input.ann_cor_status) = 'I' => 'INACTIVE',														
												   '');															  
			self 							:= [];						
			end;					
		
		
		Corp2.Layout_Corporate_Direct_AR_In arTransform(normalizedAR input):=transform,
									skip(trim(input.ann_report_year,left,right)='' 	or
									     trim(input.ann_report_date,left,right)='')
			self.corp_key					:= '12-' + trimUpper(input.ann_cor_number);
			self.corp_vendor				:= '12';
			self.corp_state_origin			:= 'FL';
			self.corp_process_date			:= fileDate;
			self.corp_sos_charter_nbr		:= trimUpper(input.ann_cor_number);										
			self.ar_year					:= input.ann_report_year;
			newReportDate					:= input.ann_report_date[5..8] + 
											   input.ann_report_date[1..4];													   			
			self.ar_filed_dt				:= if(_validate.date.fIsValid(newReportDate) 	 and													  
												  _validate.date.fIsValid(newReportDate,_validate.date.rules.DateInPast),
													(newReportDate),
													'');												
			// self.ar_type					:=	case(input.position,
													// '1' => 'T',
													// '2' => 'P',
													// '3' => 'C',
													// '');			
			self							:=[];
			end;
				
				
		Corp2.Layout_Corporate_Direct_Event_In EventTransform1(Layouts_Raw_Input.EventFile input):=transform									
			self.corp_key						:= '12-' + trimUpper(input.cor_event_doc_number);
			self.corp_vendor					:= '12';
			self.corp_state_origin				:= 'FL';
			self.corp_process_date				:= fileDate;
			self.corp_sos_charter_nbr			:= trimUpper(input.cor_event_doc_number);
			// self.event_amendment_nbr			:= trim((string)(integer) input.cor_event_seq_number,left,right);
			
			newEfftDate							:= trim(input.cor_event_efft_date[5..8] +
												   input.cor_event_efft_date[1..4],left,right);
			newFileDate							:= trim(input.cor_event_filed_date[5..8] +
												   input.cor_event_filed_date[1..4],left,right);
            dateToUse                           := if(newEfftDate<>'',
													  newEfftDate,
													  newFileDate);
            typeToUse                           := if(newEfftDate<>'',
													  'EFFECTIVE',
													  'FILING'); 													     
			self.event_filing_date				:= if(_validate.date.fIsValid(dateToUse) and												    		
													  _validate.date.fIsValid(dateToUse,_validate.date.rules.DateInPast),
														dateToUse,
														'');													   
			self.event_date_type_desc			:= if(self.event_filing_date<>'',
														typeToUse,
														'');
		
			// self.event_filing_desc				:= getEventType(input.cor_event_code);
			self.event_filing_desc				:= trimUpper(input.cor_event_desc1) +
												   ' ' + 	
												   trimUpper(input.cor_event_desc2);
			
			self.event_corp_nbr					:= trimUpper(input.cor_event_cons_mer_number);
			self.event_corp_nbr_desc			:= if(trimUpper(input.cor_event_cons_mer_number)<>'',
														'MERGING CORP NUMBER',
														'');
														
            all_notes                           := regexreplace('[ ]+',trimUpper(input.cor_event_note_1 +  														
																				 input.cor_event_note_2 + 
																				 input.cor_event_note_3),' ');
										
												   
            self.event_desc						:= if(trimUpper(input.cor_event_cor_name)<>'',
													  'NAME CHANGED TO: ' +
													  trimUpper(input.cor_event_cor_name),
													  all_notes);
			self								:= [];
			end;
		
		Corp2.Layout_Corporate_Direct_Event_In EventTransform2(Layouts_Raw_Input.EventFile input):=transform									
			self.corp_key						:= '12-' + trimUpper(input.cor_event_doc_number);
			self.corp_vendor					:= '12';
			self.corp_state_origin				:= 'FL';
			self.corp_process_date				:= fileDate;
			self.corp_sos_charter_nbr			:= trimUpper(input.cor_event_doc_number);
			// self.event_amendment_nbr			:= trim((string)(integer) input.cor_event_seq_number,left,right);
			
			newEfftDate							:= trim(input.cor_event_efft_date[5..8] +
												   input.cor_event_efft_date[1..4],left,right);
			newFileDate							:= trim(input.cor_event_filed_date[5..8] +
												   input.cor_event_filed_date[1..4],left,right);
            dateToUse                           := if(newEfftDate<>'',
													  newEfftDate,
													  newFileDate);
            typeToUse                           := if(newEfftDate<>'',
													  'EFFECTIVE',
													  'FILING'); 													     
			self.event_filing_date				:= if(_validate.date.fIsValid(dateToUse) and												    		
													  _validate.date.fIsValid(dateToUse,_validate.date.rules.DateInPast),
														dateToUse,
														'');													   
			self.event_date_type_desc			:= if(self.event_filing_date<>'',
														typeToUse,
														'');
		    self.event_desc                     := regexreplace('[ ]+',
													   trimUpper(input.cor_event_add_1) +
													   ' ' +
													   trimUpper(input.cor_event_add_2) +
													   ' ' +
													   trimUpper(input.cor_event_city)  +
													   ' ' + 
													   trimUpper(input.cor_event_state) +
													   ' ' +
													   trimUpper(input.cor_event_zip),
													   ' ');
													   
			self.event_filing_desc				:= 'PRINCIPAL ADDRESS CHANGE';
			
			self								:= [];
			end;
		
		Corp2.Layout_Corporate_Direct_Event_In EventTransform3(Layouts_Raw_Input.EventFile input):=transform									
			self.corp_key						:= '12-' + trimUpper(input.cor_event_doc_number);
			self.corp_vendor					:= '12';
			self.corp_state_origin				:= 'FL';
			self.corp_process_date				:= fileDate;
			self.corp_sos_charter_nbr			:= trimUpper(input.cor_event_doc_number);
			// self.event_amendment_nbr			:= trim((string)(integer) input.cor_event_seq_number,left,right);
			
			newEfftDate							:= trim(input.cor_event_efft_date[5..8] +
												   input.cor_event_efft_date[1..4],left,right);
			newFileDate							:= trim(input.cor_event_filed_date[5..8] +
												   input.cor_event_filed_date[1..4],left,right);
            dateToUse                           := if(newEfftDate<>'',
													  newEfftDate,
													  newFileDate);
            typeToUse                           := if(newEfftDate<>'',
													  'EFFECTIVE',
													  'FILING'); 													     
			self.event_filing_date				:= if(_validate.date.fIsValid(dateToUse) and												    		
													  _validate.date.fIsValid(dateToUse,_validate.date.rules.DateInPast),
														dateToUse,
														'');													   
			self.event_date_type_desc			:= if(self.event_filing_date<>'',
														typeToUse,
														'');
		    self.event_desc                     := regexreplace('[ ]+',
													   trimUpper(input.cor_event_mail_add_1) +
													   ' ' +
													   trimUpper(input.cor_event_mail_add_2) +
													   ' ' +
													   trimUpper(input.cor_event_mail_city)  +
													   ' ' + 
													   trimUpper(input.cor_event_mail_state) +
													   ' ' +
													   trimUpper(input.cor_event_mail_zip),
													   ' ');
													   
			self.event_filing_desc				:= 'MAILING ADDRESS CHANGE';
			
			self								:= [];
			end;
		
		Corp2.Layout_Corporate_Direct_Corp_In cleanCorp(corp2_mapping.Layout_CorpPreClean input) := transform		
			string73 tempname 					:= if(input.corp_ra_name = '', '', Address.CleanPersonFML73(input.corp_ra_name));
			pname 								:= Address.CleanNameFields(tempName);
			cname 								:= DataLib.companyclean(input.corp_ra_name);
			keepPerson 							:= corp2.Rewrite_Common.IsPerson(input.corp_ra_name);
			keepBusiness 						:= corp2.Rewrite_Common.IsCompany(input.corp_ra_name);
			
			self.corp_ra_title1					:= if(keepPerson, pname.title, '');
			self.corp_ra_fname1 				:= if(keepPerson, pname.fname, '');
			self.corp_ra_mname1 				:= if(keepPerson, pname.mname, '');
			self.corp_ra_lname1 				:= if(keepPerson, pname.lname, '');
			self.corp_ra_name_suffix1 			:= if(keepPerson, pname.name_suffix, '');
			self.corp_ra_score1 				:= if(keepPerson, pname.name_score, '');
		
			self.corp_ra_cname1 				:= if(keepBusiness, cname[1..70],'');
			self.corp_ra_cname1_score 			:= if(keepBusiness, pname.name_score, '');			
		
		    string182 clean_address 			:= Address.CleanAddress182(trim(trim(input.corp_address1_line1,left,right) + ' ' +
																				trim(input.corp_address1_line2,left,right),
																				left,right
																				),
																		   trim(trim(input.corp_address1_line3,left,right) + ', ' +
																				trim(input.corp_address1_line4,left,right) + ' ' +
																				trim(input.corp_address1_line5,left,right),
																				left,right
																				)
																			);
																			
			string182 clean_ra_address 			:= Address.CleanAddress182(trim(trim(input.corp_ra_address_line1,left,right) + ' ' +
																				trim(input.corp_ra_address_line2,left,right),
																				left,right
																				),
																		   trim(trim(input.corp_ra_address_line3,left,right) + ', ' +
																				trim(input.corp_ra_address_line4,left,right) + ' ' +
																				trim(input.corp_ra_address_line5,left,right),
																				left,right
																				)
																			);	
																				
			self.corp_ra_prim_range    			:= clean_ra_address[1..10];
			self.corp_ra_predir 	      		:= clean_ra_address[11..12];
			self.corp_ra_prim_name 	  			:= clean_ra_address[13..40];
			self.corp_ra_addr_suffix   			:= clean_ra_address[41..44];
			self.corp_ra_postdir 	    		:= clean_ra_address[45..46];
			self.corp_ra_unit_desig 	  		:= clean_ra_address[47..56];
			self.corp_ra_sec_range 	  			:= clean_ra_address[57..64];
			self.corp_ra_p_city_name	  		:= clean_ra_address[65..89];
			self.corp_ra_v_city_name	  		:= clean_ra_address[90..114];
			self.corp_ra_state 			      	:= clean_ra_address[115..116];
			self.corp_ra_zip5 		      		:= clean_ra_address[117..121];
			self.corp_ra_zip4 		      		:= clean_ra_address[122..125];
			self.corp_ra_cart 		      		:= clean_ra_address[126..129];
			self.corp_ra_cr_sort_sz 	 		:= clean_ra_address[130];
			self.corp_ra_lot 		      		:= clean_ra_address[131..134];
			self.corp_ra_lot_order 	  			:= clean_ra_address[135];
			self.corp_ra_dpbc 		      		:= clean_ra_address[136..137];
			self.corp_ra_chk_digit 	  			:= clean_ra_address[138];
			self.corp_ra_rec_type		  		:= clean_ra_address[139..140];
			self.corp_ra_ace_fips_st	  		:= clean_ra_address[141..142];
			self.corp_ra_county 	  			:= clean_ra_address[143..145];
			self.corp_ra_geo_lat 	    		:= clean_ra_address[146..155];
			self.corp_ra_geo_long 	    		:= clean_ra_address[156..166];
			self.corp_ra_msa 		      		:= clean_ra_address[167..170];
			self.corp_ra_geo_blk				:= clean_ra_address[171..177];
			self.corp_ra_geo_match 	  			:= clean_ra_address[178];
			self.corp_ra_err_stat 	    		:= clean_ra_address[179..182];
			
			self.corp_addr1_prim_range  		:= clean_address[1..10];
			self.corp_addr1_predir 	    		:= clean_address[11..12];
			self.corp_addr1_prim_name 			:= clean_address[13..40];
			self.corp_addr1_addr_suffix  	 	:= clean_address[41..44];
			self.corp_addr1_postdir 	   		:= clean_address[45..46];
			self.corp_addr1_unit_desig 			:= clean_address[47..56];
			self.corp_addr1_sec_range 			:= clean_address[57..64];
			self.corp_addr1_p_city_name			:= clean_address[65..89];
			self.corp_addr1_v_city_name			:= clean_address[90..114];
			self.corp_addr1_state 			    := clean_address[115..116];
			self.corp_addr1_zip5 		      	:= clean_address[117..121];
			self.corp_addr1_zip4 		      	:= clean_address[122..125];
			self.corp_addr1_cart 		     	:= clean_address[126..129];
			self.corp_addr1_cr_sort_sz 	 		:= clean_address[130];
			self.corp_addr1_lot 		      	:= clean_address[131..134];
			self.corp_addr1_lot_order 			:= clean_address[135];
			self.corp_addr1_dpbc 		     	:= clean_address[136..137];
			self.corp_addr1_chk_digit 			:= clean_address[138];
			self.corp_addr1_rec_type		  	:= clean_address[139..140];
			self.corp_addr1_ace_fips_st			:= clean_address[141..142];
			self.corp_addr1_county 	  			:= clean_address[143..145];
			self.corp_addr1_geo_lat 	    	:= clean_address[146..155];
			self.corp_addr1_geo_long 	   		:= clean_address[156..166];
			self.corp_addr1_msa 		      	:= clean_address[167..170];
			self.corp_addr1_geo_blk				:= clean_address[171..177];
			self.corp_addr1_geo_match 	  		:= clean_address[178];
			self.corp_addr1_err_stat 	    	:= clean_address[179..182];
			
			self								:= input;
			self 								:= [];
			end;
			
			
		Corp2.Layout_Corporate_Direct_Cont_In cleanCont(corp2_mapping.Layout_ContPreClean input) := transform		
			string73 tempname 					:= if(input.cont_name = '', '', Address.CleanPersonFML73(input.cont_name));
			pname 								:= Address.CleanNameFields(tempName);
			cname 								:= DataLib.companyclean(input.cont_name);
			keepPerson 							:= corp2.Rewrite_Common.IsPerson(input.cont_name);
			keepBusiness 						:= corp2.Rewrite_Common.IsCompany(input.cont_name);
			
			self.cont_title1					:= if(keepPerson, pname.title, '');
			self.cont_fname1 					:= if(keepPerson, pname.fname, '');
			self.cont_mname1 					:= if(keepPerson, pname.mname, '');
			self.cont_lname1 					:= if(keepPerson, pname.lname, '');
			self.cont_name_suffix1 				:= if(keepPerson, pname.name_suffix, '');
			self.cont_score1 					:= if(keepPerson, pname.name_score, '');
		
			self.cont_cname1 					:= if(keepBusiness, cname[1..70],'');
			self.cont_cname1_score 				:= if(keepBusiness, pname.name_score, '');
		
			string182 clean_address 			:= Address.CleanAddress182(trim(trim(input.cont_address_line1,left,right) + ' ' +
																				trim(input.cont_address_line2,left,right),
																				left,right),
																				trim(trim(input.cont_address_line3,left,right) + ', ' +
																				trim(input.cont_address_line4,left,right) + ' ' +
																				trim(input.cont_address_line5,left,right),
																				left,right
																						)
																			);	
																				
			self.cont_prim_range    			:= clean_address[1..10];
			self.cont_predir 	      			:= clean_address[11..12];
			self.cont_prim_name 	  			:= clean_address[13..40];
			self.cont_addr_suffix   			:= clean_address[41..44];
			self.cont_postdir 	  		  		:= clean_address[45..46];
			self.cont_unit_desig 	  			:= clean_address[47..56];
			self.cont_sec_range 	  			:= clean_address[57..64];
			self.cont_p_city_name	  			:= clean_address[65..89];
			self.cont_v_city_name	 			:= clean_address[90..114];
			self.cont_state 			      	:= clean_address[115..116];
			self.cont_zip5 		      			:= clean_address[117..121];
			self.cont_zip4 		 	     		:= clean_address[122..125];
			self.cont_cart 		    	  		:= clean_address[126..129];
			self.cont_cr_sort_sz 	 			:= clean_address[130];
			self.cont_lot 		      			:= clean_address[131..134];
			self.cont_lot_order 	  			:= clean_address[135];
			self.cont_dpbc 		   		   		:= clean_address[136..137];
			self.cont_chk_digit 	  			:= clean_address[138];
			self.cont_rec_type		  			:= clean_address[139..140];
			self.cont_ace_fips_st	  			:= clean_address[141..142];
			self.cont_county 	 	 			:= clean_address[143..145];
			self.cont_geo_lat 	    			:= clean_address[146..155];
			self.cont_geo_long 	    			:= clean_address[156..166];
			self.cont_msa 		      			:= clean_address[167..170];
			self.cont_geo_blk					:= clean_address[171..177];
			self.cont_geo_match 	  			:= clean_address[178];
			self.cont_err_stat 	    			:= clean_address[179..182];

			self								:= input;
			self 								:= [];
			end;
				
		// corpMapped		:= project(Files_Raw_Input.dailyFile(fileDate), corpTransform(left));
		corpMapped		:= project(Files_Raw_Input.corpFile(fileDate), corpTransform(left));
		
		contMapped		:= project(NormalizedPrinceInput, contTransform(left));
		
		arMapped		:= project(NormalizedARInput, arTransform(left));
		
		cleanedCorp     := project(corpMapped,cleanCorp(left));
		
		cleanedCont     := project(contMapped,cleanCont(left));
		
		allEvents		:= Files_Raw_Input.eventFile(fileDate);
		
		event1Mapped	:= project(allEvents, eventTransform1(left));
		
		event2Mapped	:= project(allEvents(trimUpper(cor_event_add_1)<>'' or
											 trimUpper(cor_event_city)<>''), eventTransform2(left));
											 
        event3Mapped	:= project(allEvents(trimUpper(cor_event_mail_add_1)<>'' or
											 trimUpper(cor_event_mail_city)<>''), eventTransform3(left));
											 
		allEventsMapped := event1Mapped + event2Mapped + event3Mapped;
		
		sortedEvents    := sort(allEventsMapped,corp_key);
		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_fl'		,arMapped			,ar_out		,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont_fl'	,cleanedCont	,cont_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp_fl'	,cleanedCorp	,corp_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_fl'	,sortedEvents	,event_out,,,pOverwrite);

		mapFLFiling := parallel(
			 ar_out				
			,cont_out			
			,corp_out			
			,if(trimUpper(updateType) = 'QUARTERLY',event_out)		
		);

		result := 
		if(trimUpper(updateType) not in ['DAILY','QUARTERLY']
			,FAIL('Must specify either \'daily\' or \'quarterly\' as 1st parameter.  Aborting job.')
			,sequential(
				 if(pshouldspray = true,fSprayFiles('fl_' + stringlib.stringtolowercase(trim(updateType)),filedate,pOverwrite := pOverwrite))
				,mapFLFiling
				,parallel(
					 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::ar'	,'~thor_data400::in::corp2::'+version+'::ar_fl')
					,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont','~thor_data400::in::corp2::'+version+'::cont_fl')
					,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp','~thor_data400::in::corp2::'+version+'::corp_fl')
					,if(trimUpper(updateType) = 'QUARTERLY',fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event','~thor_data400::in::corp2::'+version+'::event_fl'))
				)							
			)
		);
				 
		return result;
	end;					 
	
end; 