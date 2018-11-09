import file_compare;
EXPORT fnBaseFilesCheck (string pversion):=function
	
FullStats:=dataset('~thor_data400::file_compare::SANCTN::ImportantFieldResults',file_compare.Layouts.ImportantFieldsResultsLayout,thor);

RelevantStats:=FullStats(trim(version,left,right)=pversion);

return if(exists(RelevantStats(percent_change>0.0)),true,false);	
	
end;