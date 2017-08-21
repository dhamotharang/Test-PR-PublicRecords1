#workunit('name', 'Core Data Dictionary STATS')

export Proc_Core_dictionary_stats_phones_Guam := function 

//header_stats := Metadata.various_people_assets_stats1 ; 
ph_stats := Metadata.Phone_Stats_Guam ; 
//business_header_stats := Metadata.Query_Data_Dictionary_Counts;

result := ph_stats; 

return result; 

end;