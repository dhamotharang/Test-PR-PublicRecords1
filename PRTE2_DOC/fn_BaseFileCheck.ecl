import file_compare;

EXPORT fn_BaseFileCheck(string pversion):=function
	
FullStats:=dataset('~thor_data400::file_compare::prte_doc::importantfieldresults',file_compare.Layouts.ImportantFieldsResultsLayout,thor);

RelevantStats:=FullStats(trim(version,left,right)=pversion);

return if(exists(RelevantStats(percent_change>1.0)),true,false);	
	
end;