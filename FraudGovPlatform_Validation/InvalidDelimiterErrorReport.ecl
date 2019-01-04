IMPORT FraudGovPlatform;
EXPORT InvalidDelimiterErrorReport(string fname, string pSeparator, string pTerminator):=module

rCount:=count(dataset(FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+fname,{string line},CSV(separator([]),quote([]),terminator(pTerminator))));

		dDelimiter	:=Mod_Stats.ValidateDelimiter(fname,pSeparator,pTerminator).ValidationResults(ReportName='delimiter');

		InvalidDelimiterFound:=exists( dDelimiter(err='F1') );

		rText	:=
		record
			string	TextLine{maxlength(512000)};
		end;
			 
		p1	:=	project(dDelimiter
							,transform(rText
								,self.TextLine	:=(string15)left.FileState
															+ (string16)(trim((string)left.FileDate)+'_'+trim((string)left.FileTime))
															+ (string11)left.seq
															+ (string50)left.line[1..50]
															+ (string3)'   '
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
										'======================================== FILE DELIMITER MESSAGES ====================================================='
										;
		string130		HeaderLine2
										:=	
											(string15)'ACCOUNT'
										+ (string16)'FILE DATE_TIME'
										+ (string11)'SMP REC#'
										+ (string50)'SAMPLE DATA'
										+ (string3)'   '
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
											'TOTAL RECORDS  '+ rCount  +'\n'
										+	'TOTAL ERRORS   '+ sum(dDelimiter(err='F1'),err_cnt)+'\n'
										+	if(InvalidDelimiterFound
												,'FILE CONTAINS DELIMITER ERRORS.   ****   FILE WAS REJECTED   ********\n'
												+'FILE CONTAINS DELIMITER ERRORS.   ****   FILE WAS REJECTED   ********\n'
												+'FILE CONTAINS DELIMITER ERRORS.   ****   FILE WAS REJECTED   ********\n'
												,'FILE CONTENT IS ACCEPTABLE.   ****   FILE WILL BE PROCESSED   ********\n'
												+'FILE CONTENT IS ACCEPTABLE.   ****   FILE WILL BE PROCESSED   ********\n'
												+'FILE CONTENT IS ACCEPTABLE.   ****   FILE WILL BE PROCESSED   ********\n'
												) + '\n'
										;

		FooterLine2
										:=	
											'LEGEND\n'
										+ '======\n'
										+ 'F1 = ERROR - NO VALID DELIMITER\n'
										;

EXPORT BODY := if(regexfind('inquirylog',fname,nocase),regexreplace('\\_[a-z0-9]*',fname,'',nocase),fname)
						+'\n'+ HeaderLine1
						+'\n'+ HeaderLine2
						+'\n'+ HeaderLine3
						+'\n'+ roll1[1].TextLine
						+'\n\n\n'+ FooterLine1
						+'\n\n\n'+ FooterLine2
						;


END;