ds := address_file.File_addressID;

rStats := record
 file_ct                       := count(group);
 integer ct_src_header         := count(group,ds.src_header<>'');
 integer ct_src_bus_header     := count(group,ds.src_bus_header='Y');
 integer ct_src_bus_header_gov := count(group,ds.src_bus_header='G');
 integer ct_src_pcnsr          := count(group,ds.src_pcnsr<>'');
 integer ct_src_gong           := count(group,ds.src_gong<>'');
 integer ct_src_property_bus   := count(group,ds.src_property[1]='B');
 integer ct_src_property_res   := count(group,ds.src_property[2]='I');
 integer ct_src_property_gov   := count(group,ds.src_property[3]='G');
 integer ct_src_so             := count(group,ds.src_so<>'');
 integer just_res              := count(group,trim(ds.resident_flag)!='' and trim(ds.business_flag) ='' and trim(ds.govt_flag) ='');
 integer just_bus              := count(group,trim(ds.resident_flag) ='' and trim(ds.business_flag)!='' and trim(ds.govt_flag) ='');
 integer just_gov              := count(group,trim(ds.resident_flag) ='' and trim(ds.business_flag) ='' and trim(ds.govt_flag)!='');
 integer just_res_and_bus      := count(group,trim(ds.resident_flag)!='' and trim(ds.business_flag)!='' and trim(ds.govt_flag) ='');
 integer just_res_and_gov      := count(group,trim(ds.resident_flag)!='' and trim(ds.business_flag) ='' and trim(ds.govt_flag)!='');
 integer just_bus_and_gov      := count(group,trim(ds.resident_flag) ='' and trim(ds.business_flag)!='' and trim(ds.govt_flag)!='');
 integer res_and_bus_and_gov   := count(group,trim(ds.resident_flag)!='' and trim(ds.business_flag)!='' and trim(ds.govt_flag)!='');
end;

dStats := table(ds,rStats,few);
export Stats_AddressTypes := output(dStats,named('Base_File_Stats'));