import Salt35, Orbit3SOA, ut,_control,std,salt311;
EXPORT OrbitProfileStats (string pProfileName = '', string pProfileType = 'ScrubsAlerts', dataset(Salt35.ScrubsOrbitLayout)ScrubsStats = dataset([], Salt35.ScrubsOrbitLayout), string versionDate = '', string FileType = '', string CustomTag = '', string maxThreshold = '10' , string minThreshold = '-10'):= module
	ut.CleanFields(ScrubsStats,ScrubsStatsClean);
	Commonlayout:=project(ScrubsStatsClean,transform(salt311.ScrubsOrbitLayout,Self.rulepcnt:=(decimal5_2) (((real)left.Rulecnt/(real)left.RecordsTotal) * 100.00);self:=left;));
Shared CleanStats:=Commonlayout;	
EXPORT GetProfile:= Orbit3SOA.Orbit3GetProfileRules(pProfileType, pProfileName);
				DefaultPass:=GetProfile(Name='Default')[1].PassPercentage;
				DefaultConversion	:=	project(GetProfile,Transform(Scrubs.Layouts.OrbitLayoutStep1,
																			self.passpercentage	:=	if(STD.Str.find(left.name,':POP',1)=0 and STD.Str.find(left.name,':SUMMARY',1)=0 and left.passpercentage = '',DefaultPass,left.passpercentage);
																			self := left;));
export	RemoveBlankRules	:=	DefaultConversion(STD.Str.find(name,':POP',1)<>0 or STD.Str.find(name,':SUMMARY',1)<>0 or passpercentage<>'');

SHARED Filename := '~profiletemplate::' + pProfileType + '::' + pProfileName + '.csv';
//	Scrubs
SHARED profile_header := dataset([{'Name', 'Description', 'IsEnabled', 'Group', 'Order', 'Severity', 'PassPercentage', 'Code'}], layouts.ProfileTemplateLayout);
EXPORT ProfileTemplate:=  output(profile_header + project(dedup(sort(CleanStats, ruledesc, errormessage, -rulepcnt), ruledesc, errormessage),
																																	 transform(layouts.ProfileTemplateLayout,
																													 	       self.ruleName := trim(left.ruledesc, left, right),
																																	 self.ruledesc :=  trim(stringlib.stringfindreplace(left.errormessage[..100], ',', ' '),left, right),
																																	 self.isEnabled := 'TRUE',
																													 	       self.group_ := '',
																													 	       self.order := (string)counter,
																													 	       self.severity :='',
																													 	       self.code:= '',
																																	 self.rulepcnt := (string) (decimal5_2) (((real)left.Rulecnt/(real)left.RecordsTotal) * 100.00);
																																	 self := left)) ,, Filename, csv(separator(','),terminator('\r\n'),quote('"'),maxlength(65535)), compressed, overwrite, named('ProfileTemplate'+FileType)); 	

//	Scrubs Alerts
SHARED profile_alerts_header := dataset([{'Profile','Rule Name','Description','Enabled','Default','Order','Code','Severity','Pass Percentage','Percentage Error - Relative to previous (Min)','Percentage Error - Relative to previous (Max)','Change To/From Zero'},
																  {pProfileName,'Default','','true','true','0','','','','-10','20','false'}], layouts.ProfileAlertsTemplateLayout);
EXPORT ProfileAlertsTemplate:=  output(profile_alerts_header + project(dedup(sort(CleanStats, ruledesc, -rulepcnt), ruledesc),
																																	 transform(layouts.ProfileAlertsTemplateLayout,
																																	 self.Profile := pProfileName;
																													 	       self.Rule_Name := trim(left.ruledesc, left, right),
																																	 self.Description :=   trim(stringlib.stringfindreplace(left.errormessage, ',', ' '),left, right),
																																	 self.Enabled := 'TRUE',
																													 	       self.Default_Rule := 'FALSE',
																													 	       self.Order := (string)counter,
																													 	       self.severity :='',
																													 	       self.code:= '',
																																	 self.Pass_Percentage := if(STD.Str.find(self.Rule_Name,':POP',1)=0 and STD.Str.find(self.Rule_Name,':SUMMARY',1)=0,(string) (decimal5_2) (((real)left.Rulecnt/(real)left.RecordsTotal) * 100.00),'');
																																	 self.Percentage_Error_Min	:=	'',
																																	 self.Percentage_Error_Max	:=	'',
																																	 // self.ScrubsAlertsPerRelToPopulationMin	:=	'', Currently in Testing
																																	 self.Change_To_From_Zero	:=	'',
																																	 self := left)) ,, Filename, csv(separator(','),terminator('\r\n'),quote('"'),maxlength(65535)), compressed, overwrite, named('ProfileAlertsTemplate'+FileType)); 	
											
Export CompareToProfile_with_examples 	 := join(CleanStats, RemoveBlankRules, trim(left.RuleDesc, left, right) = trim(right.Name, left, right),
                                         transform( layouts.StatsOutLayout, 
																				 self.RulePcnt := (decimal5_2) (((real)left.Rulecnt/(real)left.RecordsTotal) * 100.00);
																				 self.RejectWarning := if(trim(right.passpercentage,left,right)<>'' and self.RulePcnt > (decimal5_2) right.passpercentage, 'Y', 'N'),
																				 self.RuleName := trim(left.RuleDesc, left),
																				 self.ruledesc :=  trim(stringlib.stringfindreplace(left.errormessage[..100], ',', ' '),left, right),
																				 self.FieldName := trim(Ut.Word(left.ruledesc,1,':'), left),
																				 self.InvalidValue := (string)(string100)left.rawcodemissing,
																				 self.InvalidValueCnt := left.rawcodemissingcnt,
																				 self.RuleThreshold := (decimal5_2) right.passpercentage;
																				 self := left,
																				 self := right));

EXPORT CompareToProfile_for_Orbit := dedup(sort(CompareToProfile_with_examples, Sourcecode, RuleName), Sourcecode, RuleName);
Shared SearchPattern:='^dataopsowner:([^ ]*) ';
Shared PulledName:=regexfind(SearchPattern,STD.System.Job.Name(),0);

EXPORT SubmitStats :=  sequential(output(CleanStats,,'~thor_data400::Scrubs::FileToSubmit_'+pProfileName+'_'+workunit+'_'+versionDate,thor,all,expire(2)),
output(RemoveBlankRules),
																	output(_control.fSubmitNewWorkunit('#workunit(\'name\',\''+PulledName+' Build Scrubs - '+pProfileName+'\');\r\n'+
																																		 'Submission:=dataset(\'~thor_data400::Scrubs::FileToSubmit_'+pProfileName+'_'+workunit+'_'+versionDate+'\',SALT311.ScrubsOrbitLayout,thor);\r\n'+
																																		 'CalculateWarnings:=Scrubs.OrbitProfileStatsPost310(\''+pProfileName+'\',\'ScrubsAlerts\',Submission,\''+versionDate+'\',\''+pProfileName+'\').CompareToProfile_for_Orbit;\r\n'+
																																		 'Scrubs.StatSubmit(Submission,CalculateWarnings,\''+pProfileName+'\',\''+CustomTag+'\',\''+pProfileType+'\',\''+versionDate+'\',\''+FileType+'\',\''+workunit+'\');'
																																		 ,std.system.job.target())));
																																		 
																																		 

EXPORT SummaryStats := dedup(sort(project(CleanStats,
																					transform(SALT311.ScrubsOrbitLayout and not [rejectwarning, rawcodemissing, rawcodemissingcnt],
																					self := left)), sourcecode, ruledesc), sourcecode, ruledesc);

END;