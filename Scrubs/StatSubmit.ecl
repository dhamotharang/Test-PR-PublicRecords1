import Salt311, Orbit3SOA, ut,_control,std, scrubs;
EXPORT StatSubmit(Submission, CalculateWarnings, pProfileName, CustomTag, pProfileType, versionDate, FileType, wuid) := functionmacro 
		
		
		submit_orbit := Orbit3SOA.SubmitStat(CalculateWarnings,pProfileName,pProfileType,versionDate,FileType);
		
		FullRules:=join(Submission,CalculateWarnings,trim(left.RuleDesc, left, right) = trim(right.RuleName, left, right),
								transform(Salt311.ScrubsOrbitLayout,Self.rejectwarning:=Right.rejectwarning;Self:=Left;),left outer);
		
		log_File:='~thor_data400::'+pProfileName+'::OrbitReports::'+workunit;
		
		SuperFile:='~thor_data400::Scrubs::OrbitReports';
		
		RemoveDuplicates:=dedup(sort(FullRules,sourcecode,ruledesc),sourcecode,ruledesc);
		
		FillVersionAndRemainingStats:=project(RemoveDuplicates,transform(Scrubs.Layouts.OrbitLogLayout,self.ProfileName:=pProfileName;self.version:=versionDate;self.rejectwarning:=if(left.rejectwarning='','X',left.rejectwarning);self:=left;));
		
		return sequential(
				submit_orbit,
				output(FillVersionAndRemainingStats,,log_File,thor,overwrite),
				nothor(global(sequential(STD.File.StartSuperFileTransaction(),
																 STD.File.AddSuperFile(SuperFile,log_File),
																 STD.File.FinishSuperFileTransaction(),
				))));
endmacro;