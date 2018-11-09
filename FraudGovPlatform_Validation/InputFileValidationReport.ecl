IMPORT FraudGovPlatform,STD;
EXPORT InputFileValidationReport(string fname, string pSeparator, string pTerminator):=module

rCount:=count(dataset(FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+fname,{string line},CSV(separator([pSeparator]),quote(''),terminator(pTerminator))));
dAllRecords := Mod_Stats.ValidateInputFields(fname,pSeparator,pTerminator).ValidationResults:independent;
RecWithErrors := Mod_Stats.ValidateInputFields(fname,pSeparator,pTerminator).RecordsRejected:independent;
output(dAllRecords);
treshld_:=Mod_Sets.threshld;

CriticalFieldError := MAP (
			 STD.Str.Contains( fname, 'IdentityData',	true )	=> Mod_Sets.CriticalFieldError_IdentityData
			,STD.Str.Contains( fname, 'KnownFraud'	,	true )	=> Mod_Sets.CriticalFieldError_KnownFraud,
			[]
		);
																		
RecordsRejected  := count(dedup(sort(dAllRecords(err[1]='E',field in CriticalFieldError),seq),seq));
ExcessiveInvalidRecordsFound:=exists(dAllRecords(err[1]='E',RecWithErrors/RecordsTotal>treshld_));

		rText	:=
		record
			string	TextLine{maxlength(512000)};
		end;

		p1	:=	project(dAllRecords
							,transform(rText
								,self.TextLine	:=(string7)left.FileState
															+ (string20)regexfind('([0-9])\\w+',fname, 0)
															+ (string8)left.seq
															+ Map(stringlib.stringtouppercase((string35)left.field[1..34]) ='SSN'	=>'SSN:LEXID:DRIVERSLICENSE'
																	 ,stringlib.stringtouppercase((string35)left.field[1..34]) ='CITY' => 'ADDRESS'
																	 ,(string35)left.field[1..34])
															+ (string20)left.value[1..19]
															+ (string10)left.err
															+ (string10)left.err_cnt
															+ (string5)((100*(left.err_cnt/left.RecordsTotal))+'')+'%'
								,self:=left
															));

		rText	tText(p1 l, p1 r)	:= 
		transform
			self.TextLine	:=	trim(l.TextLIne) + '\n' + trim(r.TextLine);
			end
		 ;

		roll1			:=	rollup(p1, true, tText(left, right));


		string130		HeaderLine1
										:=	
										'====================================== FIELD MESSAGES =============================================================='
										;
		string130		HeaderLine2
										:=	
											(string8)'STATE'
										+ (string16)'FILE DATE_TIME'
										+ (string11)'SMP REC#'
										+ (string35)'FIELD'
										+ (string20)'SAMPLE DATA'
										+ (string10)'MESSAGE'
										+ (string10)'COUNT'
										+ (string6)'PCT'
										;
		string130		HeaderLine2a
										:=	
											(string8)'STATE'
										+ (string16)'FILE DATE_TIME'
										+ (string11)'SMP REC#'
										+ (string13)'FIELD'
										+ (string42)'SAMPLE DATA'
										+ (string10)'MESSAGE'
										+ (string10)'COUNT'
										+ (string6)'PCT'
										;
		string130		HeaderLine3
										:=	
										'===================================================================================================================='
										;

		FooterLine1
										:=	
										'====================================================================================================================\n'
										+'TOTAL ERRORS:   '+ (string8)sum(dAllRecords(err[1]='E'),err_cnt)+'\n'  
										+'TOTAL WARNINGS: '+ (string8)sum(dAllRecords(err[1]='W'),err_cnt)+'\n'
										+'===================================================================================================================='										
										;
		FooterLine2
										:=
											'TOTAL RECORDS:  '+ rCount  +'\n'
										+	'RECORDS REJECTED:   '+ RecWithErrors +'\n'
										+	'THRESHOLD ACCEPTING (TA): '+ ROUND(RecWithErrors/rCount, 2)*100 +'% OF '+ treshld_*100 +'%.\n'
										+ 'WARNING: If TA reachs '+ treshld_*100 + '% threshold the file will be automatically rejected\n\n'
										+	if(ExcessiveInvalidRecordsFound
												,'FILE CONTAINS TOO MANY ERROR.   ****   FILE WAS REJECTED   ********\n'
												+'FILE CONTAINS TOO MANY ERROR.   ****   FILE WAS REJECTED   ********\n'
												+'FILE CONTAINS TOO MANY ERROR.   ****   FILE WAS REJECTED   ********\n'
												,'FILE CONTENT IS ACCEPTABLE.   ****   FILE WILL BE PROCESSED   ********\n'
												+'FILE CONTENT IS ACCEPTABLE.   ****   FILE WILL BE PROCESSED   ********\n'
												+'FILE CONTENT IS ACCEPTABLE.   ****   FILE WILL BE PROCESSED   ********\n'
												) + '\n'
										;

		FooterLine3
										:=	
											'LEGEND\n'
										+ '======\n'
										+ 'E001 = ERROR - BLANK\n'
										+ 'E002 = ERROR - INVALID DATE\n'																				
										+ 'E003 = ERROR - INVALID STATE\n'
										+ 'E004 = ERROR - INVALID VERTICAL TYPE\n'
										+ 'E005 = ERROR - INVALID PROGRAM\n'
										+ 'E006 = ERROR - NO IDENTIFICATION PROVIDED (SSN, LEXID, DRIVER LICENSE)\n'						
										+ '\n'
										+ 'W002 = WARNING - INVALID ADDRESS\n'													
										
										;

EXPORT BODY := if(regexfind('inquirylog',fname,nocase),regexreplace('\\_[a-z0-9]*',fname,'',nocase),fname)
						+'\n\n'+ HeaderLine1
						+'\n'+ HeaderLine2
						+'\n'+ HeaderLine3
						+'\n'+ roll1[1].TextLine
						+'\n'+ FooterLine1
						+'\n\n\n'+ FooterLine2
						+'\n\n\n'+ FooterLine3
						;


END;