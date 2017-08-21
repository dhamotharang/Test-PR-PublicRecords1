#workunit('name', 'Core Data Dictionary STATS')

export Proc_Core_dictionary_stats1 := function 

header_stats := Metadata.various_people_assets_stats1 ; 
ph_stats := Metadata.Phone_Stats ; 
business_header_stats := Metadata.Query_Data_Dictionary_Counts;

result := sequential(header_stats, ph_stats, business_header_stats); 

return result; 

end;