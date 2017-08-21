import ut;
export hygiene(dataset(layout_file_business_header) h) := MODULE
//A simple summary record
export Summary(string20 txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_fein_pcnt := ave(group,if(h.fein = (typeof(h.fein))'',0,100));
    maxlength_fein := max(group,length(trim((string)h.fein)));
    avelength_fein := ave(group,length(trim((string)h.fein)));
    populated_phone_pcnt := ave(group,if(h.phone = (typeof(h.phone))'',0,100));
    maxlength_phone := max(group,length(trim((string)h.phone)));
    avelength_phone := ave(group,length(trim((string)h.phone)));
    populated_vendor_id_pcnt := ave(group,if(h.vendor_id = (typeof(h.vendor_id))'',0,100));
    maxlength_vendor_id := max(group,length(trim((string)h.vendor_id)));
    avelength_vendor_id := ave(group,length(trim((string)h.vendor_id)));
    populated_company_name_pcnt := ave(group,if(h.company_name = (typeof(h.company_name))'',0,100));
    maxlength_company_name := max(group,length(trim((string)h.company_name)));
    avelength_company_name := ave(group,length(trim((string)h.company_name)));
    populated_prim_range_pcnt := ave(group,if(h.prim_range = (typeof(h.prim_range))'',0,100));
    maxlength_prim_range := max(group,length(trim((string)h.prim_range)));
    avelength_prim_range := ave(group,length(trim((string)h.prim_range)));
    populated_zip_pcnt := ave(group,if(h.zip = (typeof(h.zip))'',0,100));
    maxlength_zip := max(group,length(trim((string)h.zip)));
    avelength_zip := ave(group,length(trim((string)h.zip)));
    populated_sec_range_pcnt := ave(group,if(h.sec_range = (typeof(h.sec_range))'',0,100));
    maxlength_sec_range := max(group,length(trim((string)h.sec_range)));
    avelength_sec_range := ave(group,length(trim((string)h.sec_range)));
    populated_zip4_pcnt := ave(group,if(h.zip4 = (typeof(h.zip4))'',0,100));
    maxlength_zip4 := max(group,length(trim((string)h.zip4)));
    avelength_zip4 := ave(group,length(trim((string)h.zip4)));
    populated_CITY_pcnt := ave(group,if(h.CITY = (typeof(h.CITY))'',0,100));
    maxlength_CITY := max(group,length(trim((string)h.CITY)));
    avelength_CITY := ave(group,length(trim((string)h.CITY)));
    populated_unit_desig_pcnt := ave(group,if(h.unit_desig = (typeof(h.unit_desig))'',0,100));
    maxlength_unit_desig := max(group,length(trim((string)h.unit_desig)));
    avelength_unit_desig := ave(group,length(trim((string)h.unit_desig)));
    populated_county_pcnt := ave(group,if(h.county = (typeof(h.county))'',0,100));
    maxlength_county := max(group,length(trim((string)h.county)));
    avelength_county := ave(group,length(trim((string)h.county)));
    populated_prim_name_pcnt := ave(group,if(h.prim_name = (typeof(h.prim_name))'',0,100));
    maxlength_prim_name := max(group,length(trim((string)h.prim_name)));
    avelength_prim_name := ave(group,length(trim((string)h.prim_name)));
    populated_state_pcnt := ave(group,if(h.state = (typeof(h.state))'',0,100));
    maxlength_state := max(group,length(trim((string)h.state)));
    avelength_state := ave(group,length(trim((string)h.state)));
    populated_msa_pcnt := ave(group,if(h.msa = (typeof(h.msa))'',0,100));
    maxlength_msa := max(group,length(trim((string)h.msa)));
    avelength_msa := ave(group,length(trim((string)h.msa)));
    populated_SOURCE_pcnt := ave(group,if(h.SOURCE = (typeof(h.SOURCE))'',0,100));
    maxlength_SOURCE := max(group,length(trim((string)h.SOURCE)));
    avelength_SOURCE := ave(group,length(trim((string)h.SOURCE)));
    populated_addr_suffix_pcnt := ave(group,if(h.addr_suffix = (typeof(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := max(group,length(trim((string)h.addr_suffix)));
    avelength_addr_suffix := ave(group,length(trim((string)h.addr_suffix)));
  END;
  RETURN table(h,SummaryLayout);
END;
// The character counts
  mac_character_counts.mac(h,fein,'fein',fein_profile);
  mac_character_counts.mac(h,phone,'phone',phone_profile);
  mac_character_counts.mac(h,vendor_id,'vendor_id',vendor_id_profile);
  mac_character_counts.mac(h,company_name,'company_name',company_name_profile);
  mac_character_counts.mac(h,prim_range,'prim_range',prim_range_profile);
  mac_character_counts.mac(h,zip,'zip',zip_profile);
  mac_character_counts.mac(h,sec_range,'sec_range',sec_range_profile);
  mac_character_counts.mac(h,zip4,'zip4',zip4_profile);
  mac_character_counts.mac(h,CITY,'CITY',CITY_profile);
  mac_character_counts.mac(h,unit_desig,'unit_desig',unit_desig_profile);
  mac_character_counts.mac(h,county,'county',county_profile);
  mac_character_counts.mac(h,prim_name,'prim_name',prim_name_profile);
  mac_character_counts.mac(h,state,'state',state_profile);
  mac_character_counts.mac(h,msa,'msa',msa_profile);
  mac_character_counts.mac(h,SOURCE,'SOURCE',SOURCE_profile);
  mac_character_counts.mac(h,addr_suffix,'addr_suffix',addr_suffix_profile);
export All_Profiles :=  fein_profile + phone_profile + vendor_id_profile + company_name_profile + prim_range_profile + zip_profile + sec_range_profile + zip4_profile + CITY_profile + unit_desig_profile + county_profile + prim_name_profile + state_profile + msa_profile + SOURCE_profile + addr_suffix_profile;
ErrorRecord := record
	string		source;
  unsigned1 FieldNum;
  unsigned1 ErrorNum;
end;
ErrorRecord NoteErrors(h le,unsigned1 c) := transform
  self.ErrorNum := CHOOSE(c,
    Fields.InValid_fein((string)le.fein),
    Fields.InValid_phone((string)le.phone),
    Fields.InValid_vendor_id((string)le.vendor_id),
    Fields.InValid_company_name((string)le.company_name),
    Fields.InValid_prim_range((string)le.prim_range),
    Fields.InValid_zip((string)le.zip),
    Fields.InValid_sec_range((string)le.sec_range),
    Fields.InValid_zip4((string)le.zip4),
    Fields.InValid_CITY((string)le.CITY),
    Fields.InValid_unit_desig((string)le.unit_desig),
    Fields.InValid_county((string)le.county),
    Fields.InValid_prim_name((string)le.prim_name),
    Fields.InValid_state((string)le.state),
    Fields.InValid_msa((string)le.msa),
    Fields.InValid_SOURCE((string)le.SOURCE),
    Fields.InValid_addr_suffix((string)le.addr_suffix),
    0);
  self.FieldNum := IF(self.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
	self.source := le.source;
end;
Errors := normalize(h,18,NoteErrors(left,counter));
ErrorRecordsTotals := record
  Errors.source;
  Errors.FieldNum;
  Errors.ErrorNum;
  unsigned Cnt := count(group);
end;
TotalErrors := table(Errors,ErrorRecordsTotals,source,FieldNum,ErrorNum);
PrettyErrorTotals := record
  TotalErrors.source;
  FieldName := CHOOSE(TotalErrors.FieldNum,'fein','phone','vendor_id','company_name','prim_range','zip','sec_range','zip4','CITY','unit_desig','county','prim_name','state','msa','SOURCE','addr_suffix');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_fein(TotalErrors.ErrorNum),Fields.InValidMessage_phone(TotalErrors.ErrorNum),Fields.InValidMessage_vendor_id(TotalErrors.ErrorNum),Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_CITY(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_SOURCE(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
end;
ValErr := table(TotalErrors,PrettyErrorTotals);
export ValidityErrors := ValErr;
//We have BDID specified - so we can compute statistics on the cluster counts
export ClusterCounts := function
  t := distribute(table(h,{BDID}),hash(BDID));
  r0 := record
    t.BDID;
    unsigned6 InCluster := count(group);
  end;
  tots := table(t,r0,BDID,local);
  r1 := record
    tots.InCluster;
    unsigned6 NumberOfClusters := count(group);
  end;
  return sort(table(tots,r1,InCluster,few),InCluster);
end;
end;
