import SALT35,SCRUBS,file_compare,UT,data_services,tools;

EXPORT fn_CheckBeforeDops(String pVersion) := function

ScrubsFileBase:=dataset(bank_routing.thor_cluster + 'scrubs_bank_routing::OrbitReports::'+workunit,Scrubs.Layouts.OrbitLogLayout,thor);
ScrubsFileInput:=dataset(bank_routing.thor_cluster + 'scrubs_bank_routing_Input::OrbitReports::'+workunit,Scrubs.Layouts.OrbitLogLayout,thor);

ScrubsRulesBase:=dataset(bank_routing.thor_cluster + 'Scrubs::Scrubs_bank_routing::ProfileStorage::'+workunit,Scrubs.Layouts.ProfileRule_Rec,thor);
ScrubsRulesInput:=dataset(bank_routing.thor_cluster + 'Scrubs::Scrubs_bank_routing_Input::ProfileStorage::'+workunit,Scrubs.Layouts.ProfileRule_Rec,thor);

ImportantStats:=dataset(bank_routing.thor_cluster + 'file_compare::bank_routing::importantfieldresults',file_compare.Layouts.ImportantFieldsResultsLayout,thor);

RelevantStatRecord:=ImportantStats(version=pVersion);
RelevantOrbitBase	:=ScrubsFileBase(version=pVersion);
RelevantOrbitInput	:=ScrubsFileInput(version=pVersion);

DetectLargeShift:=if(abs(RelevantStatRecord[1].percent_gain)>3.0,false,true);

MergeScrubsBase:= join(RelevantOrbitBase, ScrubsRulesBase, trim(left.RuleDesc, left, right) = trim(right.Name, left, right),
                                         transform( Scrubs.layouts.StatsOutLayout, 
																				 self.RulePcnt := (decimal5_2) (((real)left.Rulecnt/(real)left.RecordsTotal) * 100.00);
																				 self.RejectWarning := if(self.RulePcnt > (decimal5_2) right.passpercentagetop, 'Y', 'N'),
																				 self.RuleName := trim(left.RuleDesc, left),
																				 self.ruledesc :=  trim(stringlib.stringfindreplace(left.errormessage[..100], ',', ' '),left, right),
																				 self.FieldName := trim(Ut.Word(left.ruledesc,1,':'), left),
																				 self.InvalidValue := (string)(string100)left.rawcodemissing,
																				 self.InvalidValueCnt := left.rawcodemissingcnt,
																				 self.RuleThreshold := (decimal5_2) right.passpercentagetop;
																				 self := left,
																				 self := right));
																				 
MergeScrubsInput:= join(RelevantOrbitInput, ScrubsRulesInput, trim(left.RuleDesc, left, right) = trim(right.Name, left, right),
                                         transform( Scrubs.layouts.StatsOutLayout, 
																				 self.RulePcnt := (decimal5_2) (((real)left.Rulecnt/(real)left.RecordsTotal) * 100.00);
																				 self.RejectWarning := if(self.RulePcnt > (decimal5_2) right.passpercentagetop, 'Y', 'N'),
																				 self.RuleName := trim(left.RuleDesc, left),
																				 self.ruledesc :=  trim(stringlib.stringfindreplace(left.errormessage[..100], ',', ' '),left, right),
																				 self.FieldName := trim(Ut.Word(left.ruledesc,1,':'), left),
																				 self.InvalidValue := (string)(string100)left.rawcodemissing,
																				 self.InvalidValueCnt := left.rawcodemissingcnt,
																				 self.RuleThreshold := (decimal5_2) right.passpercentagetop;
																				 self := left,
																				 self := right));

TestBase:=if(Exists(MergeScrubsBase(RejectWarning='Y')),false,true);
TestInput:=if(Exists(MergeScrubsInput(RejectWarning='Y')),false,true);

outputScrubsBase:=if(TestBase,'Base File Passed Scrubs Analysis','Base File Failed Scrubs Analysis');
outputScrubsInput:=if(TestInput,'Input File Passed Scrubs Analysis','Input File Failed Scrubs Analysis');
outputLargeShift:=if(TestBase,'Key File Grew by less than or equal to 3 percent','Base File Grew by more than 3 percent');
EmailSubject:=if(TestBase AND TestInput AND DetectLargeShift,'PASS: BRTN BUILD VERSION '+pVersion+' PASED TESTS AND WAS SUBMITTED TO DOPS',
																													'ALERT: BRTN BUILD VERSION '+pVersion+' FAILED TESTS REQUIRES REVIEW BEFORE DOPS SUBMISSION');
																													 
EmailBody:='Results of Tests:\n\n'+
					 'Scrubs Input:' + outputScrubsInput +'\n'+
					 'Scrubs Base:' + outputScrubsBase +'\n'+
					 'Detect Large Shift:' + outputLargeShift +'\n'+
					 'Workunit:'+tools.fun_GetWUBrowserString()+'\n';

fileservices.sendEmail('david.dittman@lexisnexisrisk.com;Robert.Berger@lexisnexisrisk.com',EmailSubject,EmailBody);
																			

return TestBase OR TestInput OR DetectLargeShift;

end;