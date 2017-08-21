import Salt35, Orbit3SOA, ut,_control,std, scrubs;
EXPORT StatSubmit(Submission, CalculateWarnings, pProfileName, CustomTag, pProfileType, versionDate, FileType, wuid) := functionmacro 
		
		
		submit_orbit := Orbit3SOA.SubmitStat(CalculateWarnings,pProfileName,pProfileType,versionDate,FileType);
		
		FullRules:=join(Submission,CalculateWarnings,trim(left.RuleDesc, left, right) = trim(right.RuleName, left, right),
								transform(Salt35.ScrubsOrbitLayout,Self.rejectwarning:=Right.rejectwarning;Self:=Left;),left outer);
		
		log_File:='~thor_data400::'+pProfileName+'::OrbitReports';
		
		SuperFile:='~thor_data400::Scrubs::OrbitReports';
		
		RemoveDuplicates:=dedup(sort(FullRules,sourcecode,ruledesc),sourcecode,ruledesc);
		
		old_entries:=dataset(log_File,Scrubs.Layouts.OrbitLogLayout,thor,opt);
		
		FillVersionAndRemainingStats:=project(RemoveDuplicates,transform(Scrubs.Layouts.OrbitLogLayout,self.version:=versionDate;self.rejectwarning:=if(left.rejectwarning='','X',left.rejectwarning);self:=left;));
		
		return sequential(
				submit_orbit,
				output(old_entries+FillVersionAndRemainingStats,,log_File+'_temp',thor,overwrite),
				STD.File.StartSuperFileTransaction(),
				STD.File.RemoveSuperFile(SuperFile,log_File,true),
				STD.File.FinishSuperFileTransaction(),
				nothor(global(sequential(fileservices.deleteLogicalFile(log_File),
																 fileservices.renameLogicalFile(log_File+'_temp',log_File),
																 STD.File.StartSuperFileTransaction(),
																 STD.File.AddSuperFile(SuperFile,log_File),
																 STD.File.FinishSuperFileTransaction(),
				))));
endmacro;