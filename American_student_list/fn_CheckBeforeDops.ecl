import SALT35,SCRUBS,file_compare,UT,data_services,tools,STD;

EXPORT fn_CheckBeforeDops(String pVersion) := function
ScrubsOld:=dataset(data_services.foreign_prod + 'thor_data400::scrubs::orbitreports::full',Scrubs.Layouts.OrbitLogLayout,thor);
ScrubsNew:=dataset(data_services.foreign_prod + 'thor_data400::scrubs::orbitreports',Scrubs.Layouts.OrbitLogLayout,thor);
ScrubsFiles:=ScrubsOld+ScrubsNew;

ScrubsRulesBase:=dataset('~thor_data400::Scrubs::Scrubs_American_Student_List::ProfileStorage',Scrubs.Layouts.ProfileRule_Rec,thor);
ScrubsRulesInput:=dataset('~thor_data400::Scrubs::Scrubs_American_Student_List_Input::ProfileStorage',Scrubs.Layouts.ProfileRule_Rec,thor);

ImportantStats:=dataset('~thor_data400::file_compare::american_student_list::importantfieldresults',file_compare.Layouts.ImportantFieldsResultsLayout,thor);

RelevantStatRecord:=ImportantStats(version=pVersion);
RelevantOrbitBase	:=ScrubsFiles(version=pVersion and STD.Str.ToLowerCase(ProfileName)='american_student_list');
RelevantOrbitInput	:=ScrubsFiles(version=pVersion and STD.Str.ToLowerCase(ProfileName)='american_student_list_input');

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
outputLargeShift:=if(DetectLargeShift,'Key File Grew by less than or equal to 3 percent','Base File Grew by more than 3 percent');
EmailSubject:=if(TestBase AND TestInput AND DetectLargeShift,'PASS: ASL BUILD VERSION '+pVersion+' PASED TESTS AND WAS SUBMITTED TO DOPS',
																													'ALERT: ASL BUILD VERSION '+pVersion+' FAILED TESTS REQUIRES REVIEW BEFORE DOPS SUBMISSION');
																													 
EmailBody:='Results of Tests:\n\n'+
					 'Scrubs Input:' + outputScrubsInput +'\n'+
					 'Scrubs Base:' + outputScrubsBase +'\n'+
					 'Detect Large Shift:' + outputLargeShift +'\n'+
					 'Workunit:'+tools.fun_GetWUBrowserString()+'\n';

fileservices.sendEmail('david.dittman@lexisnexisrisk.com;Charles.Pettola@lexisnexisrisk.com',EmailSubject,EmailBody);
																			

return TestBase OR TestInput OR DetectLargeShift;

end;