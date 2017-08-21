d	:= Phonesplus.file_phonesplus_base;


stat_rec :=  record

d.SourceFile;

totalrecs := count(group);
MAXdate := MAX(group,if(d.DateLastSeen != 0,d.DateVendorLastReported,0));

has_DateVendorFirstReported := AVE(group,IF(d.DateVendorFirstReported != 0,100,0));
has_DateVendorLastReported := AVE(group,IF(d.DateVendorLastReported != 0,100,0));
has_DateFirstSeen := AVE(group,IF(d.DateFirstSeen != 0,100,0));
has_DateLastSeen := AVE(group,IF(d.DateLastSeen != 0,100,0));
has_dt_nonglb_last_seen := AVE(group,IF(d.dt_nonglb_last_seen != 0,100,0));
has_glb_dppa_flag := AVE(group,IF(stringlib.stringfilterout(d.glb_dppa_flag ,'0')<>'',100,0));
has_ActiveFlag := AVE(group,IF(stringlib.stringfilterout(d.ActiveFlag ,'0')<>'',100,0));
has_CellPhoneIDKey := AVE(group,IF(stringlib.stringfilterout((string)d.CellPhoneIDKey ,'0')<>'',100,0));
has_Initscore := AVE(group,IF(d.Initscore != 0,100,0));
has_InitScoreType := AVE(group,IF(stringlib.stringfilterout(d.InitScoreType ,'0')<>'',100,0));
has_LnameMatch := AVE(group,IF(d.LnameMatch != 0,100,0));
has_FnameMatch := AVE(group,IF(d.FnameMatch != 0,100,0));
has_TDSMatch := AVE(group,IF(d.TDSMatch != 0,100,0));
has_ConfidenceScore := AVE(group,IF(d.ConfidenceScore != 0,100,0));
has_RecordKey := AVE(group,IF(stringlib.stringfilterout(d.RecordKey ,'0')<>'',100,0));
has_Vendor := AVE(group,IF(stringlib.stringfilterout(d.Vendor ,'0')<>'',100,0));
has_StateOrigin := AVE(group,IF(stringlib.stringfilterout(d.StateOrigin ,'0')<>'',100,0));
has_SourceFile := AVE(group,IF(stringlib.stringfilterout(d.SourceFile ,'0')<>'',100,0));
has_OrigName := AVE(group,IF(stringlib.stringfilterout(d.OrigName ,'0')<>'',100,0));
has_NameFormat := AVE(group,IF(stringlib.stringfilterout(d.NameFormat ,'0')<>'',100,0));
has_Address1 := AVE(group,IF(stringlib.stringfilterout(d.Address1 ,'0')<>'',100,0));
has_Address2 := AVE(group,IF(stringlib.stringfilterout(d.Address2 ,'0')<>'',100,0));
has_Address3 := AVE(group,IF(stringlib.stringfilterout(d.Address3 ,'0')<>'',100,0));
has_OrigCity := AVE(group,IF(stringlib.stringfilterout(d.OrigCity ,'0')<>'',100,0));
has_OrigState := AVE(group,IF(stringlib.stringfilterout(d.OrigState ,'0')<>'',100,0));
has_OrigZip := AVE(group,IF(stringlib.stringfilterout(d.OrigZip ,'0')<>'',100,0));
has_Country := AVE(group,IF(stringlib.stringfilterout(d.Country ,'0')<>'',100,0));
has_Dob := AVE(group,IF(stringlib.stringfilterout(d.Dob ,'0')<>'',100,0));
has_AgeGroup := AVE(group,IF(stringlib.stringfilterout(d.AgeGroup ,'0')<>'',100,0));
has_Gender := AVE(group,IF(stringlib.stringfilterout(d.Gender ,'0')<>'',100,0));
has_Email := AVE(group,IF(stringlib.stringfilterout(d.Email ,'0')<>'',100,0));
has_HomePhone := AVE(group,IF(stringlib.stringfilterout(d.HomePhone ,'0')<>'',100,0));
has_CellPhone := AVE(group,IF(stringlib.stringfilterout(d.CellPhone ,'0')<>'',100,0));
has_Company := AVE(group,IF(stringlib.stringfilterout(d.Company ,'0')<>'',100,0));
has_OrigTitle := AVE(group,IF(stringlib.stringfilterout(d.OrigTitle ,'0')<>'',100,0));
has_RegistrationDate := AVE(group,IF(d.RegistrationDate != 0,100,0));
has_PhoneModel := AVE(group,IF(stringlib.stringfilterout(d.PhoneModel ,'0')<>'',100,0));
has_IPAddress := AVE(group,IF(stringlib.stringfilterout(d.IPAddress ,'0')<>'',100,0));
has_CarrierCode := AVE(group,IF(stringlib.stringfilterout(d.CarrierCode ,'0')<>'',100,0));
has_CountryCode := AVE(group,IF(stringlib.stringfilterout(d.CountryCode ,'0')<>'',100,0));
has_KeyCode := AVE(group,IF(stringlib.stringfilterout(d.KeyCode ,'0')<>'',100,0));
has_GlobalKeyCode := AVE(group,IF(stringlib.stringfilterout(d.GlobalKeyCode ,'0')<>'',100,0));
has_prim_range := AVE(group,IF(stringlib.stringfilterout(d.prim_range ,'0')<>'',100,0));
has_predir := AVE(group,IF(stringlib.stringfilterout(d.predir ,'0')<>'',100,0));
has_prim_name := AVE(group,IF(stringlib.stringfilterout(d.prim_name ,'0')<>'',100,0));
has_addr_suffix := AVE(group,IF(stringlib.stringfilterout(d.addr_suffix ,'0')<>'',100,0));
has_postdir := AVE(group,IF(stringlib.stringfilterout(d.postdir ,'0')<>'',100,0));
has_unit_desig := AVE(group,IF(stringlib.stringfilterout(d.unit_desig ,'0')<>'',100,0));
has_sec_range := AVE(group,IF(stringlib.stringfilterout(d.sec_range ,'0')<>'',100,0));
has_p_city_name := AVE(group,IF(stringlib.stringfilterout(d.p_city_name ,'0')<>'',100,0));
has_v_city_name := AVE(group,IF(stringlib.stringfilterout(d.v_city_name ,'0')<>'',100,0));
has_state := AVE(group,IF(stringlib.stringfilterout(d.state ,'0')<>'',100,0));
has_zip5 := AVE(group,IF(stringlib.stringfilterout(d.zip5 ,'0')<>'',100,0));
has_zip4 := AVE(group,IF(stringlib.stringfilterout(d.zip4 ,'0')<>'',100,0));
has_cart := AVE(group,IF(stringlib.stringfilterout(d.cart ,'0')<>'',100,0));
has_cr_sort_sz := AVE(group,IF(stringlib.stringfilterout(d.cr_sort_sz ,'0')<>'',100,0));
has_lot := AVE(group,IF(stringlib.stringfilterout(d.lot ,'0')<>'',100,0));
has_lot_order := AVE(group,IF(stringlib.stringfilterout(d.lot_order ,'0')<>'',100,0));
has_dpbc := AVE(group,IF(stringlib.stringfilterout(d.dpbc ,'0')<>'',100,0));
has_chk_digit := AVE(group,IF(stringlib.stringfilterout(d.chk_digit ,'0')<>'',100,0));
has_rec_type := AVE(group,IF(stringlib.stringfilterout(d.rec_type ,'0')<>'',100,0));
has_ace_fips_st := AVE(group,IF(stringlib.stringfilterout(d.ace_fips_st ,'0')<>'',100,0));
has_ace_fips_county := AVE(group,IF(stringlib.stringfilterout(d.ace_fips_county ,'0')<>'',100,0));
has_geo_lat := AVE(group,IF(stringlib.stringfilterout(d.geo_lat ,'0')<>'',100,0));
has_geo_long := AVE(group,IF(stringlib.stringfilterout(d.geo_long ,'0')<>'',100,0));
has_msa := AVE(group,IF(stringlib.stringfilterout(d.msa ,'0')<>'',100,0));
has_geo_blk := AVE(group,IF(stringlib.stringfilterout(d.geo_blk ,'0')<>'',100,0));
has_geo_match := AVE(group,IF(stringlib.stringfilterout(d.geo_match ,'0')<>'',100,0));
has_err_stat := AVE(group,IF(stringlib.stringfilterout(d.err_stat ,'0')<>'',100,0));
has_title := AVE(group,IF(stringlib.stringfilterout(d.title ,'0')<>'',100,0));
has_fname := AVE(group,IF(stringlib.stringfilterout(d.fname ,'0')<>'',100,0));
has_mname := AVE(group,IF(stringlib.stringfilterout(d.mname ,'0')<>'',100,0));
has_lname := AVE(group,IF(stringlib.stringfilterout(d.lname ,'0')<>'',100,0));
has_name_suffix := AVE(group,IF(stringlib.stringfilterout(d.name_suffix ,'0')<>'',100,0));
has_name_score := AVE(group,IF(stringlib.stringfilterout(d.name_score ,'0')<>'',100,0));
has_did := AVE(group,IF(d.did != 0,100,0));
has_did_score := AVE(group,IF(stringlib.stringfilterout(d.did_score ,'0')<>'',100,0));

end;

stats := table(d,stat_rec,SourceFile,few);

stats_sorted := sort(stats,SourceFile);



export Build_Population_Stats :=  output(choosen(stats_sorted,all)); 