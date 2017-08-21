EXPORT InputFileValidationReport(string fname):=module

//rCount:=count(dataset('~nac::in::'+fname,Layouts.load,flat));
rCount:=count(dataset(fname,Layouts.load,flat));

dField:=Mod_Stats.ValidateInputFields(fname).ValidationResults(ReportName='field');
dRecord:=Mod_Stats.ValidateInputFields(fname).ValidationResults(ReportName='record');
treshld_:=Mod_Sets.threshld;
ExcessiveInvalidRecordsFound:=exists(   dField(err[1]='E',err_cnt/RecordsTotal>treshld_)
																			+ dRecord(err[1]='E',err_cnt/RecordsTotal>treshld_));

		rText	:=
		record
			string	TextLine{maxlength(512000)};
		end;

		p1	:=	project(dField
							,transform(rText
								,self.TextLine	:=(string7)left.FileState
															+ (string8)fname[8..15]
															+ (string1)'_'
															+ (string11)fname[17..22]
															+ (string8)left.seq
															+ (string35)left.field[1..34]
															+ (string20)left.value[1..19]
															+ (string10)left.err
															+ (string10)left.err_cnt
															+ (string5)((100*(left.err_cnt/left.RecordsTotal))+'')+'%'
								,self:=left
															));

		p2	:=	project(dRecord
							,transform(rText
								,self.TextLine	:=(string7)left.FileState
															+ (string8)fname[8..15]
															+ (string1)'_'
															+ (string11)fname[17..22]
															+ (string8)left.seq
															+ (string13)left.field
															+ (string42)left.value[1..41]
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
		roll2			:=	rollup(p2, true, tText(left, right));

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
		string130		HeaderLine4
										:=	
										'===================================== RECORD MESSAGES =============================================================='
										;

		FooterLine1
										:=	
											'TOTAL RECORDS  '+ rCount  +'\n'
										+	'TOTAL ERRORS   '+ (sum(dField(err[1]='E'),err_cnt)+sum(dRecord(err[1]='E'),err_cnt)) +'\n'
										+	'TOTAL WARNINGS '+ (sum(dField(err[1]='W'),err_cnt)+sum(dRecord(err[1]='W'),err_cnt)) +'\n\n'
										+	if(ExcessiveInvalidRecordsFound
												,'FILE CONTAINS TOO MANY ERROR.   ****   FILE WAS REJECTED   ********\n'
												+'FILE CONTAINS TOO MANY ERROR.   ****   FILE WAS REJECTED   ********\n'
												+'FILE CONTAINS TOO MANY ERROR.   ****   FILE WAS REJECTED   ********\n'
												+'FILE CONTAINS TOO MANY ERROR.   ****   FILE WAS REJECTED   ********\n'
												,'FILE CONTENT IS ACCEPTABLE.   ****   FILE WILL BE PROCESSED   ********\n'
												+'FILE CONTENT IS ACCEPTABLE.   ****   FILE WILL BE PROCESSED   ********\n'
												+'FILE CONTENT IS ACCEPTABLE.   ****   FILE WILL BE PROCESSED   ********\n'
												) + '\n'
										;

		FooterLine2
										:=	
											'LEGEND\n'
										+ '======\n'
										+ 'E001 = ERROR - NO CASE IDENTIFIER WAS PROVIDED\n'
										+ 'E002 = ERROR - NO CLIENT IDENTIFIER WAS PROVIDED\n'
										+ 'E003 = ERROR - NO VALID ADDRESS PROVIDED IN PHYSICAL OR MAILING\n'
										+ 'E004 = ERROR - NO FIRST NAME PROVIDED\n'
										+ 'E005 = ERROR - NO LAST NAME PROVIDED\n'
										+ 'E006 = ERROR - INVALID CONTRIBUTORY STATE\n'
										+ 'E007 = ERROR - NO BENEFIT MONTH\n'
										+ 'E010 = ERROR - VALID SSN TYPE - INVALID SSN\n'
										+ 'E011 = ERROR - INVALID SSN TYPE - VALID SSN\n'
										+ 'E012 = ERROR - VALID DOB TYPE - INVALID DOB\n'
										+ 'E013 = ERROR - INVALID DOB TYPE - VALID DOB\n'
										+ 'E014 = ERROR - INCOMPLETE BENEFIT MONTH\n'
										+ 'E015 = ERROR - INVALID BENEFIT TYPE\n'
										+ '\n'
										+ 'W001 = WARNING - INVALID PHYSICAL ADDRESS. WILL USE MAILING ADDRESS\n'
										+ 'W002 = WARNING - INVALID MAILING ADDRESS. WILL USE PHYSICAL ADDRESS\n'
										+ 'W003 = WARNING - BLANK, INVALID, OR INCOMPLETE VALUE\n'
										+ 'W004 = WARNING - INVALID FORMAT\n'
										+ 'W008 = WARNING - VALID STATUS INDICATOR - INVALID STATUS DATE\n'
										+ 'W009 = WARNING - INVALID STATUS INDICATOR - VALID STATUS DATE\n'
										;

EXPORT NCR1 := fname
						+'\n'+ HeaderLine1
						+'\n'+ HeaderLine2
						+'\n'+ HeaderLine3
						+'\n'+ roll1[1].TextLine
						+'\n\n\n'+ HeaderLine4
						+'\n'+ HeaderLine2a
						+'\n'+ HeaderLine3
						+'\n'+ roll2[1].TextLine
						+'\n\n\n'+ FooterLine1
						+'\n\n\n'+ FooterLine2
						;


//rCount:=count(dataset('~nac::in::'+fname,Layouts.load,flat));
rCount:=count(dataset(fname,Layouts.load,flat));

dField:=Mod_Stats.ValidateInputFields(fname).ValidationResults(ReportName='field');
dRecord:=Mod_Stats.ValidateInputFields(fname).ValidationResults(ReportName='record');
treshld_:=Mod_Sets.threshld;
ExcessiveInvalidRecordsFound:=exists(   dField(err[1]='E',err_cnt/RecordsTotal>treshld_)
																			+ dRecord(err[1]='E',err_cnt/RecordsTotal>treshld_));

		rText	:=
		record
			unsigned  SecNum;
			unsigned  LinNum;
			string130	TextLine;
			string1 	lf:='\n';
		end;

		HeaderLine1	:=dataset([
										 {1,1,'========================= FIELD MESSAGES ================================================'}
										,{1,2,(string11)'SMP REC#'
												+ (string35)'FIELD'
												+ (string20)'SAMPLE DATA'
												+ (string10)'MESSAGE'
												+ (string10)'COUNT'
												+ (string6)'PCT'
												}
										,{1,3,'========================================================================================='}
										],rText)
										;
		p1	:=	project(dField
							,transform(rText
								,self.SecNum	:=2
								,self.LinNum	:=counter
								,self.TextLine	:=(string8)left.seq
															+ (string35)left.field[1..34]
															+ (string20)left.value[1..19]
															+ (string10)left.err
															+ (string10)left.err_cnt
															+ (string5)((100*(left.err_cnt/left.RecordsTotal))+'')+'%'
								,self:=left
															));



		HeaderLine3	:=dataset([
										 {3,1,''}
										,{3,2,''}
										,{3,3,''}
										,{3,4,''}
										,{3,5,'========================= RECORD MESSAGES ==============================================='}
										,{3,6,(string11)'SMP REC#'
												+ (string13)'FIELD'
												+ (string42)'SAMPLE DATA'
												+ (string10)'MESSAGE'
												+ (string10)'COUNT'
												+ (string6)'PCT'
												}
										,{3,7,'========================================================================================='}
										],rText)
										;
		p2	:=	project(dRecord
							,transform(rText
								,self.SecNum	:=4
								,self.LinNum	:=counter
								,self.TextLine	:=(string8)left.seq
															+ (string13)left.field
															+ (string42)left.value[1..41]
															+ (string10)left.err
															+ (string10)left.err_cnt
															+ (string5)((100*(left.err_cnt/left.RecordsTotal))+'')+'%'
								,self:=left
															));


		FooterLine1		:=dataset([
										 {5,1,''}
										,{5,2,''}
										,{5,3,'TOTAL RECORDS  '+ rCount  }
										,{5,4,'TOTAL ERRORS   '+ (sum(dField(err[1]='E'),err_cnt)+sum(dRecord(err[1]='E'),err_cnt))}
										,{5,5,'TOTAL WARNINGS '+ (sum(dField(err[1]='W'),err_cnt)+sum(dRecord(err[1]='W'),err_cnt))}
										,{5,6,''}
										],rText)
										+
										if(ExcessiveInvalidRecordsFound
												,dataset([
												 {6,1,''}
												,{6,2,'FILE CONTAINS TOO MANY ERROR.   ****   FILE WAS REJECTED   ********'}
												,{6,3,'FILE CONTAINS TOO MANY ERROR.   ****   FILE WAS REJECTED   ********'}
												,{6,4,'FILE CONTAINS TOO MANY ERROR.   ****   FILE WAS REJECTED   ********'}
												,{6,5,'FILE CONTAINS TOO MANY ERROR.   ****   FILE WAS REJECTED   ********'}
												,{6,6,''}
												],rText)
												,dataset([
												 {6,1,''}
												,{6,2,'FILE CONTENT IS ACCEPTABLE.   ****   FILE WILL BE PROCESSED   ********'}
												,{6,3,'FILE CONTENT IS ACCEPTABLE.   ****   FILE WILL BE PROCESSED   ********'}
												,{6,4,'FILE CONTENT IS ACCEPTABLE.   ****   FILE WILL BE PROCESSED   ********'}
												,{6,5,''}
												],rText)
												)
										;
		FooterLine2			:=dataset([
										 {7,1,''}
										,{7,2,''}
										,{7,3,'LEGEND'}
										,{7,4,'======'}
										,{7,5,'E001 = ERROR - NO CASE IDENTIFIER WAS PROVIDED'}
										,{7,6,'E002 = ERROR - NO CLIENT IDENTIFIER WAS PROVIDED'}
										,{7,7,'E003 = ERROR - NO VALID ADDRESS PROVIDED IN PHYSICAL OR MAILING'}
										,{7,8,'E004 = ERROR - NO FIRST NAME PROVIDED'}
										,{7,9,'E005 = ERROR - NO LAST NAME PROVIDED'}
										,{7,10,'E006 = ERROR - INVALID CONTRIBUTORY STATE'}
										,{7,11,'E007 = ERROR - NO BENEFIT MONTH'}
										,{7,12,'E010 = ERROR - VALID SSN TYPE - INVALID SSN'}
										,{7,13,'E011 = ERROR - INVALID SSN TYPE - VALID SSN'}
										,{7,14,'E012 = ERROR - VALID DOB TYPE - INVALID DOB'}
										,{7,15,'E013 = ERROR - INVALID DOB TYPE - VALID DOB'}
										,{7,16,'E014 = ERROR - INCOMPLETE BENEFIT MONTH'}
										,{7,17,'E015 = ERROR - INVALID BENEFIT TYPE'}
										,{7,18,''}
										,{7,19,'W001 = WARNING - INVALID PHYSICAL ADDRESS. WILL USE MAILING ADDRESS'}
										,{7,20,'W002 = WARNING - INVALID MAILING ADDRESS. WILL USE PHYSICAL ADDRESS'}
										,{7,21,'W003 = WARNING - BLANK, INVALID, OR INCOMPLETE VALUE'}
										,{7,23,'W004 = WARNING - INVALID FORMAT'}
										,{7,24,'W008 = WARNING - VALID STATUS INDICATOR - INVALID STATUS DATE'}
										,{7,25,'W009 = WARNING - INVALID STATUS INDICATOR - VALID STATUS DATE'}
										],rText)
										;

NCR0 := dataset([{0,1,fname}],rText)
						+ HeaderLine1
						+ p1
						+ HeaderLine3
						+ p2
						+ FooterLine1
						+ FooterLine2
						;
NCR_ := sort(NCR0,SecNum,LinNum);

EXPORT NCR := project(NCR_,rText-[SecNum,LinNum]);


END;