import file_compare;

EXPORT fn_CheckBaseFile(string filedate):=function
	
FullStats:=dataset('~thor_data400::file_compare::prte_phonesplus::importantfieldresults',file_compare.Layouts.ImportantFieldsResultsLayout,thor);

RelevantStats:=FullStats(trim(version,left,right)=filedate);

return if(exists(RelevantStats(percent_change>1.0)),true,false);	
	
end;