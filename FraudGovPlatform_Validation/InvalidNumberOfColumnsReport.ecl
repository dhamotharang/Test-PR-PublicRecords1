IMPORT FraudGovPlatform;
EXPORT InvalidNumberOfColumnsReport(string fname):=module

rCount:=count(dataset(FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+fname,{string line},CSV(separator(['~|~']),quote([]),terminator('~<EOL>~'))));

		dFields			:=Mod_Stats.ValidateNumberOfColumns(fname).ValidationResults(ReportName='fields');
		
		InvalidNumberOfColumnsFound:=exists( dFields(err='F2') );				

		rText	:=
		record
			string	TextLine{maxlength(512000)};
		end;
				 
		p1	:=	project(dFields
							,transform(rText
								,self.TextLine	:=(string7)left.FileState
															+ (string20)regexfind('([0-9])\\w+',fname, 0)
															+ (string8)left.seq
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
										'====================================== FILE COLUMNS MESSAGES ======================================================='
										;
		string130		HeaderLine2
										:=	
											(string8)'STATE'
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
										+	'TOTAL ERRORS   '+ sum(dFields(err='F2'),err_cnt) +'\n'
										+	if(InvalidNumberOfColumnsFound
												,'FILE CONTAINS AN INVALID NUMBER OF COLUMNS.   ****   FILE WAS REJECTED   ********\n'
												+'FILE CONTAINS AN INVALID NUMBER OF COLUMNS.   ****   FILE WAS REJECTED   ********\n'
												+'FILE CONTAINS AN INVALID NUMBER OF COLUMNS.   ****   FILE WAS REJECTED   ********\n'
												,'FILE CONTENT IS ACCEPTABLE.   ****   FILE WILL BE PROCESSED   ********\n'
												+'FILE CONTENT IS ACCEPTABLE.   ****   FILE WILL BE PROCESSED   ********\n'
												+'FILE CONTENT IS ACCEPTABLE.   ****   FILE WILL BE PROCESSED   ********\n'
												) + '\n'
										;

		FooterLine2
										:=	
											'LEGEND\n'
										+ '======\n'
										+ 'F2 = ERROR - INVALID NUMBER OF COLUMNS\n'
										;

EXPORT BODY := fname
						+'\n'+ HeaderLine1
						+'\n'+ HeaderLine2
						+'\n'+ HeaderLine3
						+'\n'+ roll1[1].TextLine
						+'\n\n\n'+ FooterLine1
						+'\n\n\n'+ FooterLine2
						;


END;