old_layout_gongMaster := record,maxlength(30000)
 Gong_v2.Layout_Raw_LSS;
 Gong_v2.Layout_GongHistory;
end;

export layout_temp_for_daily_raw_processing_old := record
 string	  temp_hseno   :='';
 string	  temp_hsesx   :='';
 string	  temp_strt    :='';
 string   temp_address1:='';
 string   temp_address2:='';
 string	  temp_cap1    :='';
 string   temp_cap2    :='';
 string   temp_cap3    :='';
 string   temp_cap4    :='';
 string   temp_cap5    :='';
 string   temp_cap6    :='';
 string   temp_cap7    :='';
 string5  name2_prefix :='';
 string20 name2_first  :='';
 string20 name2_middle :='';
 string20 name2_last   :='';
 string5  name2_suffix :='';
 string	  precleanName1:='';
 string	  precleanName2:='';
 string	  cleanName    :='';
 string	  cleanName2   :='';
 old_layout_gongMaster;
end;