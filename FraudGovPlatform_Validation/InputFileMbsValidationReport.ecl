IMPORT FraudGovPlatform,STD;
EXPORT InputFileMbsValidationReport(string fname, string pSeparator, string pTerminator):=module

rCount:=count(dataset(FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+fname,{string line},CSV(separator([pSeparator]),quote(''),terminator(pTerminator))));
dAllRecords := Mod_Stats.ValidateInputWithMBS(fname,pSeparator,pTerminator).ValidationResults:independent;

output(dAllRecords);
treshld_:=Mod_Sets.threshld;

ExcessiveInvalidRecordsFound:=dAllRecords[1].errorcount/rCount>treshld_;

		rText	:=
		record
			string	TextLine{maxlength(512000)};
		end;

		p1	:=	project(dAllRecords
							,transform(rText
								,self.TextLine	:=(string20)regexfind('([0-9])\\w+',fname, 0)
															+ (string8)left.seq
															+ (string100)left.field[1..100]
															+ (string30)left.value[1..30]
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


		string185		HeaderLine1
										:=	
										'================================================================================ FIELD MESSAGES =========================================================================================='
										;
		string185		HeaderLine2
										:=	
											(string16)'FILE DATE_TIME'
										+ (string11)'SMP REC#'
										+ (string100)'FIELD'
										+ (string30)'SAMPLE DATA'
										+ (string10)'MESSAGE'
										+ (string10)'COUNT'
										+ (string6)'PCT'
										;
		string185		HeaderLine2a
										:=	
											(string16)'FILE DATE_TIME'
										+ (string11)'SMP REC#'
										+ (string13)'FIELD'
										+ (string42)'SAMPLE DATA'
										+ (string10)'MESSAGE'
										+ (string10)'COUNT'
										+ (string6)'PCT'
										;
		string185		HeaderLine3
										:=	
										'=========================================================================================================================================================================================='
										;

		FooterLine1
										:=	
										'==========================================================================================================================================================================================\n'
										+'TOTAL WARNINGS:   '+ (string8)dAllRecords[1].errorcount+'\n'  
										+'========================================================================================================================================================================================='										
										;
		FooterLine2
										:=
											'TOTAL RECORDS:  '+ rCount  +'\n'
										+	'TOTAL WARNINGS:   '+ dAllRecords[1].errorcount +'\n'
										+ '\n'										
										+ 'FILE CONTENT IS ACCEPTABLE.   ****   FILE WILL BE PROCESSED   ********\n'
										+ 'FILE CONTENT IS ACCEPTABLE.   ****   FILE WILL BE PROCESSED   ********\n'
										+ 'FILE CONTENT IS ACCEPTABLE.   ****   FILE WILL BE PROCESSED   ********\n'
										
										;

		FooterLine3
										:=	
											'LEGEND\n'
										+ '======\n'
										+ 'W001 = WARNING - INVALID MBS RECORDS\n'
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