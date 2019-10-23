import Scrubs_LN_PropertyV2_Assessor,ut,_control,std, scrubs, ut,tools;
EXPORT fn_scrubsPlus_assessor(string source = '', string version = '',string emailList='') := function 
vendor := if(source = 'O', 'SourceB', 'SourceA'); 

FileInput := Scrubs_LN_PropertyV2_Assessor.In_Property_Assessor(source, version);

return if(source = 'O',
					Scrubs.ScrubsPlus_PassFile(FileInput,'Scrubs_LN_PropertyV2_Assessor','Scrubs_LN_PropertyV2_Assessor','Scrubs_LN_PropertyV2_Assessor','',version+'O',emailList),
					Scrubs.ScrubsPlus_PassFile(FileInput,'Scrubs_LN_PropertyV2_Assessor','Scrubs_LN_PropertyV2_Assessor','Scrubs_LN_PropertyV2_Assessor','',version+'F',emailList));

end;