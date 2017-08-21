import ut,SALT20;
export hygiene(dataset(layout_PersonHeader) h) := MODULE
//A simple summary record
export Summary(string20 txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_NAME_SUFFIX_pcnt := ave(group,if(h.NAME_SUFFIX = (typeof(h.NAME_SUFFIX))'',0,100));
    maxlength_NAME_SUFFIX := max(group,length(trim((string)h.NAME_SUFFIX)));
    avelength_NAME_SUFFIX := ave(group,length(trim((string)h.NAME_SUFFIX)));
    populated_FNAME_pcnt := ave(group,if(h.FNAME = (typeof(h.FNAME))'',0,100));
    maxlength_FNAME := max(group,length(trim((string)h.FNAME)));
    avelength_FNAME := ave(group,length(trim((string)h.FNAME)));
    populated_MNAME_pcnt := ave(group,if(h.MNAME = (typeof(h.MNAME))'',0,100));
    maxlength_MNAME := max(group,length(trim((string)h.MNAME)));
    avelength_MNAME := ave(group,length(trim((string)h.MNAME)));
    populated_LNAME_pcnt := ave(group,if(h.LNAME = (typeof(h.LNAME))'',0,100));
    maxlength_LNAME := max(group,length(trim((string)h.LNAME)));
    avelength_LNAME := ave(group,length(trim((string)h.LNAME)));
    populated_PRIM_RANGE_pcnt := ave(group,if(h.PRIM_RANGE = (typeof(h.PRIM_RANGE))'',0,100));
    maxlength_PRIM_RANGE := max(group,length(trim((string)h.PRIM_RANGE)));
    avelength_PRIM_RANGE := ave(group,length(trim((string)h.PRIM_RANGE)));
    populated_PRIM_NAME_pcnt := ave(group,if(h.PRIM_NAME = (typeof(h.PRIM_NAME))'',0,100));
    maxlength_PRIM_NAME := max(group,length(trim((string)h.PRIM_NAME)));
    avelength_PRIM_NAME := ave(group,length(trim((string)h.PRIM_NAME)));
    populated_SEC_RANGE_pcnt := ave(group,if(h.SEC_RANGE = (typeof(h.SEC_RANGE))'',0,100));
    maxlength_SEC_RANGE := max(group,length(trim((string)h.SEC_RANGE)));
    avelength_SEC_RANGE := ave(group,length(trim((string)h.SEC_RANGE)));
    populated_CITY_pcnt := ave(group,if(h.CITY = (typeof(h.CITY))'',0,100));
    maxlength_CITY := max(group,length(trim((string)h.CITY)));
    avelength_CITY := ave(group,length(trim((string)h.CITY)));
    populated_STATE_pcnt := ave(group,if(h.STATE = (typeof(h.STATE))'',0,100));
    maxlength_STATE := max(group,length(trim((string)h.STATE)));
    avelength_STATE := ave(group,length(trim((string)h.STATE)));
    populated_ZIP_pcnt := ave(group,if(h.ZIP = (typeof(h.ZIP))'',0,100));
    maxlength_ZIP := max(group,length(trim((string)h.ZIP)));
    avelength_ZIP := ave(group,length(trim((string)h.ZIP)));
    populated_ZIP4_pcnt := ave(group,if(h.ZIP4 = (typeof(h.ZIP4))'',0,100));
    maxlength_ZIP4 := max(group,length(trim((string)h.ZIP4)));
    avelength_ZIP4 := ave(group,length(trim((string)h.ZIP4)));
    populated_COUNTY_pcnt := ave(group,if(h.COUNTY = (typeof(h.COUNTY))'',0,100));
    maxlength_COUNTY := max(group,length(trim((string)h.COUNTY)));
    avelength_COUNTY := ave(group,length(trim((string)h.COUNTY)));
    populated_SSN5_pcnt := ave(group,if(h.SSN5 = (typeof(h.SSN5))'',0,100));
    maxlength_SSN5 := max(group,length(trim((string)h.SSN5)));
    avelength_SSN5 := ave(group,length(trim((string)h.SSN5)));
    populated_SSN4_pcnt := ave(group,if(h.SSN4 = (typeof(h.SSN4))'',0,100));
    maxlength_SSN4 := max(group,length(trim((string)h.SSN4)));
    avelength_SSN4 := ave(group,length(trim((string)h.SSN4)));
    populated_DOB_pcnt := ave(group,if(h.DOB = (typeof(h.DOB))'',0,100));
    maxlength_DOB := max(group,length(trim((string)h.DOB)));
    avelength_DOB := ave(group,length(trim((string)h.DOB)));
    populated_PHONE_pcnt := ave(group,if(h.PHONE = (typeof(h.PHONE))'',0,100));
    maxlength_PHONE := max(group,length(trim((string)h.PHONE)));
    avelength_PHONE := ave(group,length(trim((string)h.PHONE)));
  END;
  RETURN table(h,SummaryLayout);
END;
// The character counts
// First create a deduped inversion to speed things up
SALT20.MAC_Character_Counts.Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,trim((string)le.NAME_SUFFIX),trim((string)le.FNAME),trim((string)le.MNAME),trim((string)le.LNAME),trim((string)le.PRIM_RANGE),trim((string)le.PRIM_NAME),trim((string)le.SEC_RANGE),trim((string)le.CITY),trim((string)le.STATE),trim((string)le.ZIP),trim((string)le.ZIP4),trim((string)le.COUNTY),trim((string)le.SSN5),trim((string)le.SSN4),trim((string)le.DOB),trim((string)le.PHONE),trim((string)le.FNAME)+' '+trim((string)le.MNAME)+' '+trim((string)le.LNAME),trim((string)le.FNAME)+' '+trim((string)le.MNAME)+' '+trim((string)le.LNAME)+' '+trim((string)le.NAME_SUFFIX),trim((string)le.PRIM_RANGE)+' '+trim((string)le.PRIM_NAME)+' '+trim((string)le.SEC_RANGE)+' '+trim((string)le.ZIP4),trim((string)le.COUNTY)+' '+trim((string)le.CITY)+' '+trim((string)le.STATE)+' '+trim((string)le.ZIP),trim((string)le.PRIM_RANGE)+' '+trim((string)le.PRIM_NAME)+' '+trim((string)le.SEC_RANGE)+' '+trim((string)le.ZIP4)+' '+trim((string)le.COUNTY)+' '+trim((string)le.CITY)+' '+trim((string)le.STATE)+' '+trim((string)le.ZIP)));
  SELF.FldNo := C;
END;
shared FldInv0 := NORMALIZE(h,21,Into(LEFT,COUNTER));
shared FldIds := dataset([{1,'NAME_SUFFIX'}
      ,{2,'FNAME'}
      ,{3,'MNAME'}
      ,{4,'LNAME'}
      ,{5,'PRIM_RANGE'}
      ,{6,'PRIM_NAME'}
      ,{7,'SEC_RANGE'}
      ,{8,'CITY'}
      ,{9,'STATE'}
      ,{10,'ZIP'}
      ,{11,'ZIP4'}
      ,{12,'COUNTY'}
      ,{13,'SSN5'}
      ,{14,'SSN4'}
      ,{15,'DOB'}
      ,{16,'PHONE'}
      ,{17,'MAINNAME'}
      ,{18,'FULLNAME'}
      ,{19,'ADDR1'}
      ,{20,'LOCALE'}
      ,{21,'ADDRS'}],SALT20.MAC_Character_Counts.Field_Identification);
export All_Profiles := SALT20.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
export NAME_SUFFIX_profile := All_Profiles(FldNo=1);
export FNAME_profile := All_Profiles(FldNo=2);
export MNAME_profile := All_Profiles(FldNo=3);
export LNAME_profile := All_Profiles(FldNo=4);
export PRIM_RANGE_profile := All_Profiles(FldNo=5);
export PRIM_NAME_profile := All_Profiles(FldNo=6);
export SEC_RANGE_profile := All_Profiles(FldNo=7);
export CITY_profile := All_Profiles(FldNo=8);
export STATE_profile := All_Profiles(FldNo=9);
export ZIP_profile := All_Profiles(FldNo=10);
export ZIP4_profile := All_Profiles(FldNo=11);
export COUNTY_profile := All_Profiles(FldNo=12);
export SSN5_profile := All_Profiles(FldNo=13);
export SSN4_profile := All_Profiles(FldNo=14);
export DOB_profile := All_Profiles(FldNo=15);
export PHONE_profile := All_Profiles(FldNo=16);
export MAINNAME_profile := All_Profiles(FldNo=17);
export FULLNAME_profile := All_Profiles(FldNo=18);
export ADDR1_profile := All_Profiles(FldNo=19);
export LOCALE_profile := All_Profiles(FldNo=20);
export ADDRS_profile := All_Profiles(FldNo=21);
ErrorRecord := record
  unsigned1 FieldNum;
  unsigned1 ErrorNum;
end;
ErrorRecord NoteErrors(h le,unsigned1 c) := transform
  self.ErrorNum := CHOOSE(c,
    Fields.InValid_NAME_SUFFIX((string)le.NAME_SUFFIX),
    Fields.InValid_FNAME((string)le.FNAME),
    Fields.InValid_MNAME((string)le.MNAME),
    Fields.InValid_LNAME((string)le.LNAME),
    Fields.InValid_PRIM_RANGE((string)le.PRIM_RANGE),
    Fields.InValid_PRIM_NAME((string)le.PRIM_NAME),
    Fields.InValid_SEC_RANGE((string)le.SEC_RANGE),
    Fields.InValid_CITY((string)le.CITY),
    Fields.InValid_STATE((string)le.STATE),
    Fields.InValid_ZIP((string)le.ZIP),
    Fields.InValid_ZIP4((string)le.ZIP4),
    Fields.InValid_COUNTY((string)le.COUNTY),
    Fields.InValid_SSN5((string)le.SSN5),
    Fields.InValid_SSN4((string)le.SSN4),
    Fields.InValid_DOB((string)le.DOB),
    Fields.InValid_PHONE((string)le.PHONE),
    0);
  self.FieldNum := IF(self.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
end;
Errors := normalize(h,21,NoteErrors(left,counter));
ErrorRecordsTotals := record
  Errors.FieldNum;
  Errors.ErrorNum;
  unsigned Cnt := count(group);
end;
TotalErrors := table(Errors,ErrorRecordsTotals,FieldNum,ErrorNum);
PrettyErrorTotals := record
  FieldName := CHOOSE(TotalErrors.FieldNum,'NAME_SUFFIX','FNAME','MNAME','LNAME','PRIM_RANGE','PRIM_NAME','SEC_RANGE','CITY','STATE','ZIP','ZIP4','COUNTY','SSN5','SSN4','DOB','PHONE','MAINNAME','FULLNAME','ADDR1','LOCALE','ADDRS');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_NAME_SUFFIX(TotalErrors.ErrorNum),Fields.InValidMessage_FNAME(TotalErrors.ErrorNum),Fields.InValidMessage_MNAME(TotalErrors.ErrorNum),Fields.InValidMessage_LNAME(TotalErrors.ErrorNum),Fields.InValidMessage_PRIM_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_PRIM_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_SEC_RANGE(TotalErrors.ErrorNum),Fields.InValidMessage_CITY(TotalErrors.ErrorNum),Fields.InValidMessage_STATE(TotalErrors.ErrorNum),Fields.InValidMessage_ZIP(TotalErrors.ErrorNum),Fields.InValidMessage_ZIP4(TotalErrors.ErrorNum),Fields.InValidMessage_COUNTY(TotalErrors.ErrorNum),Fields.InValidMessage_SSN5(TotalErrors.ErrorNum),Fields.InValidMessage_SSN4(TotalErrors.ErrorNum),Fields.InValidMessage_DOB(TotalErrors.ErrorNum),Fields.InValidMessage_PHONE(TotalErrors.ErrorNum),Fields.InValidMessage_MAINNAME(TotalErrors.ErrorNum),Fields.InValidMessage_FULLNAME(TotalErrors.ErrorNum),Fields.InValidMessage_ADDR1(TotalErrors.ErrorNum),Fields.InValidMessage_LOCALE(TotalErrors.ErrorNum),Fields.InValidMessage_ADDRS(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
end;
ValErr := table(TotalErrors,PrettyErrorTotals);
export ValidityErrors := ValErr;
//We have DID specified - so we can compute statistics on the cluster counts
export ClusterCounts := function
  t := distribute(table(h,{DID}),hash(DID));
  r0 := record
    t.DID;
    SALT20.UIDType InCluster := count(group);
  end;
  tots := table(t,r0,DID,local);
  r1 := record
    tots.InCluster;
    unsigned6 NumberOfClusters := count(group);
  end;
  return sort(table(tots,r1,InCluster,few),InCluster);
end;
end;
