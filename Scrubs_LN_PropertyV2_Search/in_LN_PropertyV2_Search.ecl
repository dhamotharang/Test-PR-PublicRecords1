import LN_PropertyV2_Fast,LN_PropertyV2;

EXPORT in_LN_PropertyV2_Search(string1 source, string version) := function


File_search_delta:=  LN_PropertyV2_Fast.Files.base.search_prp;
File_search_full := LN_PropertyV2.file_search_building_Bip;

removefield:=project(File_search_delta,transform(recordof(File_search_full),self:=left;));
MaxprocessDate := if(version = '', Max(File_search_full +removefield,process_date), version);

RecsforDate := if(count(removefield( process_date[..8] = MaxprocessDate)) > 0, 
																	removefield( process_date[..8] = MaxprocessDate),
																	File_search_full( process_date[..8] = MaxprocessDate)) :INDEPENDENT;
																	
																	
File_source := if(source = 'O', RecsforDate (vendor_source_flag = source), RecsforDate (vendor_source_flag <> 'O'));

	 
return (File_source);
	 
	 end;