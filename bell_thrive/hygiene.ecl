import ut,SALT20;
export hygiene(dataset(layouts.input.sprayed) h) := MODULE
//A simple summary record
export Summary(string20 txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_id_pcnt := ave(group,if(h.id = (typeof(h.id))'',0,100));
    maxlength_id := max(group,length(trim((string)h.id)));
    avelength_id := ave(group,length(trim((string)h.id)));
    populated_fname_pcnt := ave(group,if(h.fname = (typeof(h.fname))'',0,100));
    maxlength_fname := max(group,length(trim((string)h.fname)));
    avelength_fname := ave(group,length(trim((string)h.fname)));
    populated_lname_pcnt := ave(group,if(h.lname = (typeof(h.lname))'',0,100));
    maxlength_lname := max(group,length(trim((string)h.lname)));
    avelength_lname := ave(group,length(trim((string)h.lname)));
    populated_dob_pcnt := ave(group,if(h.dob = (typeof(h.dob))'',0,100));
    maxlength_dob := max(group,length(trim((string)h.dob)));
    avelength_dob := ave(group,length(trim((string)h.dob)));
    populated_Own_Home_pcnt := ave(group,if(h.Own_Home = (typeof(h.Own_Home))'',0,100));
    maxlength_Own_Home := max(group,length(trim((string)h.Own_Home)));
    avelength_Own_Home := ave(group,length(trim((string)h.Own_Home)));
    populated_dlnum_pcnt := ave(group,if(h.dlnum = (typeof(h.dlnum))'',0,100));
    maxlength_dlnum := max(group,length(trim((string)h.dlnum)));
    avelength_dlnum := ave(group,length(trim((string)h.dlnum)));
    populated_State_Of_License_pcnt := ave(group,if(h.State_Of_License = (typeof(h.State_Of_License))'',0,100));
    maxlength_State_Of_License := max(group,length(trim((string)h.State_Of_License)));
    avelength_State_Of_License := ave(group,length(trim((string)h.State_Of_License)));
    populated_addr_pcnt := ave(group,if(h.addr = (typeof(h.addr))'',0,100));
    maxlength_addr := max(group,length(trim((string)h.addr)));
    avelength_addr := ave(group,length(trim((string)h.addr)));
    populated_city_pcnt := ave(group,if(h.city = (typeof(h.city))'',0,100));
    maxlength_city := max(group,length(trim((string)h.city)));
    avelength_city := ave(group,length(trim((string)h.city)));
    populated_st_pcnt := ave(group,if(h.st = (typeof(h.st))'',0,100));
    maxlength_st := max(group,length(trim((string)h.st)));
    avelength_st := ave(group,length(trim((string)h.st)));
    populated_zip_pcnt := ave(group,if(h.zip = (typeof(h.zip))'',0,100));
    maxlength_zip := max(group,length(trim((string)h.zip)));
    avelength_zip := ave(group,length(trim((string)h.zip)));
    populated_Phone_Home_pcnt := ave(group,if(h.Phone_Home = (typeof(h.Phone_Home))'',0,100));
    maxlength_Phone_Home := max(group,length(trim((string)h.Phone_Home)));
    avelength_Phone_Home := ave(group,length(trim((string)h.Phone_Home)));
    populated_Phone_Cell_pcnt := ave(group,if(h.Phone_Cell = (typeof(h.Phone_Cell))'',0,100));
    maxlength_Phone_Cell := max(group,length(trim((string)h.Phone_Cell)));
    avelength_Phone_Cell := ave(group,length(trim((string)h.Phone_Cell)));
    populated_Phone_Work_pcnt := ave(group,if(h.Phone_Work = (typeof(h.Phone_Work))'',0,100));
    maxlength_Phone_Work := max(group,length(trim((string)h.Phone_Work)));
    avelength_Phone_Work := ave(group,length(trim((string)h.Phone_Work)));
    populated_EMAIL_pcnt := ave(group,if(h.EMAIL = (typeof(h.EMAIL))'',0,100));
    maxlength_EMAIL := max(group,length(trim((string)h.EMAIL)));
    avelength_EMAIL := ave(group,length(trim((string)h.EMAIL)));
    populated_ip_pcnt := ave(group,if(h.ip = (typeof(h.ip))'',0,100));
    maxlength_ip := max(group,length(trim((string)h.ip)));
    avelength_ip := ave(group,length(trim((string)h.ip)));
    populated_dt_pcnt := ave(group,if(h.dt = (typeof(h.dt))'',0,100));
    maxlength_dt := max(group,length(trim((string)h.dt)));
    avelength_dt := ave(group,length(trim((string)h.dt)));
    populated_INCOME_MONTHLY_pcnt := ave(group,if(h.INCOME_MONTHLY = (typeof(h.INCOME_MONTHLY))'',0,100));
    maxlength_INCOME_MONTHLY := max(group,length(trim((string)h.INCOME_MONTHLY)));
    avelength_INCOME_MONTHLY := ave(group,length(trim((string)h.INCOME_MONTHLY)));
    populated_Weekly_BiWeekly_pcnt := ave(group,if(h.Weekly_BiWeekly = (typeof(h.Weekly_BiWeekly))'',0,100));
    maxlength_Weekly_BiWeekly := max(group,length(trim((string)h.Weekly_BiWeekly)));
    avelength_Weekly_BiWeekly := ave(group,length(trim((string)h.Weekly_BiWeekly)));
    populated_MONTHSEMPLOYED_pcnt := ave(group,if(h.MONTHSEMPLOYED = (typeof(h.MONTHSEMPLOYED))'',0,100));
    maxlength_MONTHSEMPLOYED := max(group,length(trim((string)h.MONTHSEMPLOYED)));
    avelength_MONTHSEMPLOYED := ave(group,length(trim((string)h.MONTHSEMPLOYED)));
    populated_MonthsAtBank_pcnt := ave(group,if(h.MonthsAtBank = (typeof(h.MonthsAtBank))'',0,100));
    maxlength_MonthsAtBank := max(group,length(trim((string)h.MonthsAtBank)));
    avelength_MonthsAtBank := ave(group,length(trim((string)h.MonthsAtBank)));
    populated_employer_pcnt := ave(group,if(h.employer = (typeof(h.employer))'',0,100));
    maxlength_employer := max(group,length(trim((string)h.employer)));
    avelength_employer := ave(group,length(trim((string)h.employer)));
    populated_Bank_pcnt := ave(group,if(h.Bank = (typeof(h.Bank))'',0,100));
    maxlength_Bank := max(group,length(trim((string)h.Bank)));
    avelength_Bank := ave(group,length(trim((string)h.Bank)));
  END;
  RETURN table(h,SummaryLayout);
END;
// The character counts
// First create a deduped inversion to speed things up
SALT20.MAC_Character_Counts.Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,trim((string)le.id),trim((string)le.fname),trim((string)le.lname),trim((string)le.dob),trim((string)le.Own_Home),trim((string)le.dlnum),trim((string)le.State_Of_License),trim((string)le.addr),trim((string)le.city),trim((string)le.st),trim((string)le.zip),trim((string)le.Phone_Home),trim((string)le.Phone_Cell),trim((string)le.Phone_Work),trim((string)le.EMAIL),trim((string)le.ip),trim((string)le.dt),trim((string)le.INCOME_MONTHLY),trim((string)le.Weekly_BiWeekly),trim((string)le.MONTHSEMPLOYED),trim((string)le.MonthsAtBank),trim((string)le.employer),trim((string)le.Bank)));
  SELF.FldNo := C;
END;
shared FldInv0 := NORMALIZE(h,23,Into(LEFT,COUNTER));
shared FldIds := dataset([{1,'id'}
      ,{2,'fname'}
      ,{3,'lname'}
      ,{4,'dob'}
      ,{5,'Own_Home'}
      ,{6,'dlnum'}
      ,{7,'State_Of_License'}
      ,{8,'addr'}
      ,{9,'city'}
      ,{10,'st'}
      ,{11,'zip'}
      ,{12,'Phone_Home'}
      ,{13,'Phone_Cell'}
      ,{14,'Phone_Work'}
      ,{15,'EMAIL'}
      ,{16,'ip'}
      ,{17,'dt'}
      ,{18,'INCOME_MONTHLY'}
      ,{19,'Weekly_BiWeekly'}
      ,{20,'MONTHSEMPLOYED'}
      ,{21,'MonthsAtBank'}
      ,{22,'employer'}
      ,{23,'Bank'}],SALT20.MAC_Character_Counts.Field_Identification);
export All_Profiles := SALT20.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
export id_profile := All_Profiles(FldNo=1);
export fname_profile := All_Profiles(FldNo=2);
export lname_profile := All_Profiles(FldNo=3);
export dob_profile := All_Profiles(FldNo=4);
export Own_Home_profile := All_Profiles(FldNo=5);
export dlnum_profile := All_Profiles(FldNo=6);
export State_Of_License_profile := All_Profiles(FldNo=7);
export addr_profile := All_Profiles(FldNo=8);
export city_profile := All_Profiles(FldNo=9);
export st_profile := All_Profiles(FldNo=10);
export zip_profile := All_Profiles(FldNo=11);
export Phone_Home_profile := All_Profiles(FldNo=12);
export Phone_Cell_profile := All_Profiles(FldNo=13);
export Phone_Work_profile := All_Profiles(FldNo=14);
export EMAIL_profile := All_Profiles(FldNo=15);
export ip_profile := All_Profiles(FldNo=16);
export dt_profile := All_Profiles(FldNo=17);
export INCOME_MONTHLY_profile := All_Profiles(FldNo=18);
export Weekly_BiWeekly_profile := All_Profiles(FldNo=19);
export MONTHSEMPLOYED_profile := All_Profiles(FldNo=20);
export MonthsAtBank_profile := All_Profiles(FldNo=21);
export employer_profile := All_Profiles(FldNo=22);
export Bank_profile := All_Profiles(FldNo=23);
ErrorRecord := record
  unsigned1 FieldNum;
  unsigned1 ErrorNum;
end;
ErrorRecord NoteErrors(h le,unsigned1 c) := transform
  self.ErrorNum := CHOOSE(c,
    Fields.InValid_id((string)le.id),
    Fields.InValid_fname((string)le.fname),
    Fields.InValid_lname((string)le.lname),
    Fields.InValid_dob((string)le.dob),
    Fields.InValid_Own_Home((string)le.Own_Home),
    Fields.InValid_dlnum((string)le.dlnum),
    Fields.InValid_State_Of_License((string)le.State_Of_License),
    Fields.InValid_addr((string)le.addr),
    Fields.InValid_city((string)le.city),
    Fields.InValid_st((string)le.st),
    Fields.InValid_zip((string)le.zip),
    Fields.InValid_Phone_Home((string)le.Phone_Home),
    Fields.InValid_Phone_Cell((string)le.Phone_Cell),
    Fields.InValid_Phone_Work((string)le.Phone_Work),
    Fields.InValid_EMAIL((string)le.EMAIL),
    Fields.InValid_ip((string)le.ip),
    Fields.InValid_dt((string)le.dt),
    Fields.InValid_INCOME_MONTHLY((string)le.INCOME_MONTHLY),
    Fields.InValid_Weekly_BiWeekly((string)le.Weekly_BiWeekly),
    Fields.InValid_MONTHSEMPLOYED((string)le.MONTHSEMPLOYED),
    Fields.InValid_MonthsAtBank((string)le.MonthsAtBank),
    Fields.InValid_employer((string)le.employer),
    Fields.InValid_Bank((string)le.Bank),
    0);
  self.FieldNum := IF(self.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
end;
Errors := normalize(h,23,NoteErrors(left,counter));
ErrorRecordsTotals := record
  Errors.FieldNum;
  Errors.ErrorNum;
  unsigned Cnt := count(group);
end;
TotalErrors := table(Errors,ErrorRecordsTotals,FieldNum,ErrorNum);
PrettyErrorTotals := record
  FieldName := CHOOSE(TotalErrors.FieldNum,'id','fname','lname','dob','Own_Home','dlnum','State_Of_License','addr','city','st','zip','Phone_Home','Phone_Cell','Phone_Work','EMAIL','ip','dt','INCOME_MONTHLY','Weekly_BiWeekly','MONTHSEMPLOYED','MonthsAtBank','employer','Bank');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_id(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_dob(TotalErrors.ErrorNum),Fields.InValidMessage_Own_Home(TotalErrors.ErrorNum),Fields.InValidMessage_dlnum(TotalErrors.ErrorNum),Fields.InValidMessage_State_Of_License(TotalErrors.ErrorNum),Fields.InValidMessage_addr(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_Phone_Home(TotalErrors.ErrorNum),Fields.InValidMessage_Phone_Cell(TotalErrors.ErrorNum),Fields.InValidMessage_Phone_Work(TotalErrors.ErrorNum),Fields.InValidMessage_EMAIL(TotalErrors.ErrorNum),Fields.InValidMessage_ip(TotalErrors.ErrorNum),Fields.InValidMessage_dt(TotalErrors.ErrorNum),Fields.InValidMessage_INCOME_MONTHLY(TotalErrors.ErrorNum),Fields.InValidMessage_Weekly_BiWeekly(TotalErrors.ErrorNum),Fields.InValidMessage_MONTHSEMPLOYED(TotalErrors.ErrorNum),Fields.InValidMessage_MonthsAtBank(TotalErrors.ErrorNum),Fields.InValidMessage_employer(TotalErrors.ErrorNum),Fields.InValidMessage_Bank(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
end;
ValErr := table(TotalErrors,PrettyErrorTotals);
export ValidityErrors := ValErr;
end;
