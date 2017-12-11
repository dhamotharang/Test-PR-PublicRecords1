import file_compare;
EXPORT fnInputFileCheck(string pversion):=function
	
FullStats:=dataset('~thor_data400::file_compare::SANCTN::fullrecordresults',file_compare.Layouts.FullFileResultsLayout,thor);

RelevantStats:=FullStats(trim(file_type,left,right)='InFile_Delta' and trim(version,left,right)=pversion);

return if(exists(RelevantStats(percent_change>0.0)),true,false);	
	
end;