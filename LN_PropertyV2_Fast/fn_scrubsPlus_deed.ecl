﻿import Scrubs_LN_PropertyV2_Deed,ut,_control,std, scrubs, ut,tools;
EXPORT fn_scrubsPlus_deed(string source = '', string version = '',string emailList='') := function 
vendor := if(source = 'O', 'SourceB', 'SourceA'); 
FileInput := Scrubs_LN_PropertyV2_Deed.In_Property_Deed(source, version);

return if(source = 'O',
					Scrubs.ScrubsPlus_PassFile(FileInput,'Scrubs_LN_PropertyV2_Deed_O','Scrubs_LN_PropertyV2_Deed','Scrubs_LN_PropertyV2_Deed_O','',version+'O',emailList),
					Scrubs.ScrubsPlus_PassFile(FileInput,'Scrubs_LN_PropertyV2_Deed_F','Scrubs_LN_PropertyV2_Deed','Scrubs_LN_PropertyV2_Deed_F','',version+'F',emailList));

end;