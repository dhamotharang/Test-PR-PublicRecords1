import ut,SALT20;
export hygiene(dataset(layouts.input.sprayed) h) := MODULE
//A simple summary record
export Summary(string20 txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_fname_pcnt := ave(group,if(h.fname = (typeof(h.fname))'',0,100));
    maxlength_fname := max(group,length(trim((string)h.fname)));
    avelength_fname := ave(group,length(trim((string)h.fname)));
    populated_lname_pcnt := ave(group,if(h.lname = (typeof(h.lname))'',0,100));
    maxlength_lname := max(group,length(trim((string)h.lname)));
    avelength_lname := ave(group,length(trim((string)h.lname)));
    populated_addr_pcnt := ave(group,if(h.addr = (typeof(h.addr))'',0,100));
    maxlength_addr := max(group,length(trim((string)h.addr)));
    avelength_addr := ave(group,length(trim((string)h.addr)));
    populated_city_pcnt := ave(group,if(h.city = (typeof(h.city))'',0,100));
    maxlength_city := max(group,length(trim((string)h.city)));
    avelength_city := ave(group,length(trim((string)h.city)));
    populated_state_pcnt := ave(group,if(h.state = (typeof(h.state))'',0,100));
    maxlength_state := max(group,length(trim((string)h.state)));
    avelength_state := ave(group,length(trim((string)h.state)));
    populated_zip_pcnt := ave(group,if(h.zip = (typeof(h.zip))'',0,100));
    maxlength_zip := max(group,length(trim((string)h.zip)));
    avelength_zip := ave(group,length(trim((string)h.zip)));
    populated_zip4_pcnt := ave(group,if(h.zip4 = (typeof(h.zip4))'',0,100));
    maxlength_zip4 := max(group,length(trim((string)h.zip4)));
    avelength_zip4 := ave(group,length(trim((string)h.zip4)));
    populated_EMAIL_pcnt := ave(group,if(h.EMAIL = (typeof(h.EMAIL))'',0,100));
    maxlength_EMAIL := max(group,length(trim((string)h.EMAIL)));
    avelength_EMAIL := ave(group,length(trim((string)h.EMAIL)));
    populated_phone_pcnt := ave(group,if(h.phone = (typeof(h.phone))'',0,100));
    maxlength_phone := max(group,length(trim((string)h.phone)));
    avelength_phone := ave(group,length(trim((string)h.phone)));
    populated_LoanType_pcnt := ave(group,if(h.LoanType = (typeof(h.LoanType))'',0,100));
    maxlength_LoanType := max(group,length(trim((string)h.LoanType)));
    avelength_LoanType := ave(group,length(trim((string)h.LoanType)));
    populated_BESTTIME_pcnt := ave(group,if(h.BESTTIME = (typeof(h.BESTTIME))'',0,100));
    maxlength_BESTTIME := max(group,length(trim((string)h.BESTTIME)));
    avelength_BESTTIME := ave(group,length(trim((string)h.BESTTIME)));
    populated_MortRate_pcnt := ave(group,if(h.MortRate = (typeof(h.MortRate))'',0,100));
    maxlength_MortRate := max(group,length(trim((string)h.MortRate)));
    avelength_MortRate := ave(group,length(trim((string)h.MortRate)));
    populated_PROPERTYTYPE_pcnt := ave(group,if(h.PROPERTYTYPE = (typeof(h.PROPERTYTYPE))'',0,100));
    maxlength_PROPERTYTYPE := max(group,length(trim((string)h.PROPERTYTYPE)));
    avelength_PROPERTYTYPE := ave(group,length(trim((string)h.PROPERTYTYPE)));
    populated_RateType_pcnt := ave(group,if(h.RateType = (typeof(h.RateType))'',0,100));
    maxlength_RateType := max(group,length(trim((string)h.RateType)));
    avelength_RateType := ave(group,length(trim((string)h.RateType)));
    populated_LTV_pcnt := ave(group,if(h.LTV = (typeof(h.LTV))'',0,100));
    maxlength_LTV := max(group,length(trim((string)h.LTV)));
    avelength_LTV := ave(group,length(trim((string)h.LTV)));
    populated_YrsThere_pcnt := ave(group,if(h.YrsThere = (typeof(h.YrsThere))'',0,100));
    maxlength_YrsThere := max(group,length(trim((string)h.YrsThere)));
    avelength_YrsThere := ave(group,length(trim((string)h.YrsThere)));
    populated_employer_pcnt := ave(group,if(h.employer = (typeof(h.employer))'',0,100));
    maxlength_employer := max(group,length(trim((string)h.employer)));
    avelength_employer := ave(group,length(trim((string)h.employer)));
    populated_credit_pcnt := ave(group,if(h.credit = (typeof(h.credit))'',0,100));
    maxlength_credit := max(group,length(trim((string)h.credit)));
    avelength_credit := ave(group,length(trim((string)h.credit)));
    populated_Income_pcnt := ave(group,if(h.Income = (typeof(h.Income))'',0,100));
    maxlength_Income := max(group,length(trim((string)h.Income)));
    avelength_Income := ave(group,length(trim((string)h.Income)));
    populated_LoanAmt_pcnt := ave(group,if(h.LoanAmt = (typeof(h.LoanAmt))'',0,100));
    maxlength_LoanAmt := max(group,length(trim((string)h.LoanAmt)));
    avelength_LoanAmt := ave(group,length(trim((string)h.LoanAmt)));
    populated_dt_pcnt := ave(group,if(h.dt = (typeof(h.dt))'',0,100));
    maxlength_dt := max(group,length(trim((string)h.dt)));
    avelength_dt := ave(group,length(trim((string)h.dt)));
    populated_ip_pcnt := ave(group,if(h.ip = (typeof(h.ip))'',0,100));
    maxlength_ip := max(group,length(trim((string)h.ip)));
    avelength_ip := ave(group,length(trim((string)h.ip)));
  END;
  RETURN table(h,SummaryLayout);
END;
// The character counts
// First create a deduped inversion to speed things up
SALT20.MAC_Character_Counts.Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,trim((string)le.fname),trim((string)le.lname),trim((string)le.addr),trim((string)le.city),trim((string)le.state),trim((string)le.zip),trim((string)le.zip4),trim((string)le.EMAIL),trim((string)le.phone),trim((string)le.LoanType),trim((string)le.BESTTIME),trim((string)le.MortRate),trim((string)le.PROPERTYTYPE),trim((string)le.RateType),trim((string)le.LTV),trim((string)le.YrsThere),trim((string)le.employer),trim((string)le.credit),trim((string)le.Income),trim((string)le.LoanAmt),trim((string)le.dt),trim((string)le.ip)));
  SELF.FldNo := C;
END;
shared FldInv0 := NORMALIZE(h,22,Into(LEFT,COUNTER));
shared FldIds := dataset([{1,'fname'}
      ,{2,'lname'}
      ,{3,'addr'}
      ,{4,'city'}
      ,{5,'state'}
      ,{6,'zip'}
      ,{7,'zip4'}
      ,{8,'EMAIL'}
      ,{9,'phone'}
      ,{10,'LoanType'}
      ,{11,'BESTTIME'}
      ,{12,'MortRate'}
      ,{13,'PROPERTYTYPE'}
      ,{14,'RateType'}
      ,{15,'LTV'}
      ,{16,'YrsThere'}
      ,{17,'employer'}
      ,{18,'credit'}
      ,{19,'Income'}
      ,{20,'LoanAmt'}
      ,{21,'dt'}
      ,{22,'ip'}],SALT20.MAC_Character_Counts.Field_Identification);
export All_Profiles := SALT20.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
export fname_profile := All_Profiles(FldNo=1);
export lname_profile := All_Profiles(FldNo=2);
export addr_profile := All_Profiles(FldNo=3);
export city_profile := All_Profiles(FldNo=4);
export state_profile := All_Profiles(FldNo=5);
export zip_profile := All_Profiles(FldNo=6);
export zip4_profile := All_Profiles(FldNo=7);
export EMAIL_profile := All_Profiles(FldNo=8);
export phone_profile := All_Profiles(FldNo=9);
export LoanType_profile := All_Profiles(FldNo=10);
export BESTTIME_profile := All_Profiles(FldNo=11);
export MortRate_profile := All_Profiles(FldNo=12);
export PROPERTYTYPE_profile := All_Profiles(FldNo=13);
export RateType_profile := All_Profiles(FldNo=14);
export LTV_profile := All_Profiles(FldNo=15);
export YrsThere_profile := All_Profiles(FldNo=16);
export employer_profile := All_Profiles(FldNo=17);
export credit_profile := All_Profiles(FldNo=18);
export Income_profile := All_Profiles(FldNo=19);
export LoanAmt_profile := All_Profiles(FldNo=20);
export dt_profile := All_Profiles(FldNo=21);
export ip_profile := All_Profiles(FldNo=22);
ErrorRecord := record
  unsigned1 FieldNum;
  unsigned1 ErrorNum;
end;
ErrorRecord NoteErrors(h le,unsigned1 c) := transform
  self.ErrorNum := CHOOSE(c,
    Fields.InValid_fname((string)le.fname),
    Fields.InValid_lname((string)le.lname),
    Fields.InValid_addr((string)le.addr),
    Fields.InValid_city((string)le.city),
    Fields.InValid_state((string)le.state),
    Fields.InValid_zip((string)le.zip),
    Fields.InValid_zip4((string)le.zip4),
    Fields.InValid_EMAIL((string)le.EMAIL),
    Fields.InValid_phone((string)le.phone),
    Fields.InValid_LoanType((string)le.LoanType),
    Fields.InValid_BESTTIME((string)le.BESTTIME),
    Fields.InValid_MortRate((string)le.MortRate),
    Fields.InValid_PROPERTYTYPE((string)le.PROPERTYTYPE),
    Fields.InValid_RateType((string)le.RateType),
    Fields.InValid_LTV((string)le.LTV),
    Fields.InValid_YrsThere((string)le.YrsThere),
    Fields.InValid_employer((string)le.employer),
    Fields.InValid_credit((string)le.credit),
    Fields.InValid_Income((string)le.Income),
    Fields.InValid_LoanAmt((string)le.LoanAmt),
    Fields.InValid_dt((string)le.dt),
    Fields.InValid_ip((string)le.ip),
    0);
  self.FieldNum := IF(self.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
end;
Errors := normalize(h,22,NoteErrors(left,counter));
ErrorRecordsTotals := record
  Errors.FieldNum;
  Errors.ErrorNum;
  unsigned Cnt := count(group);
end;
TotalErrors := table(Errors,ErrorRecordsTotals,FieldNum,ErrorNum);
PrettyErrorTotals := record
  FieldName := CHOOSE(TotalErrors.FieldNum,'fname','lname','addr','city','state','zip','zip4','EMAIL','phone','LoanType','BESTTIME','MortRate','PROPERTYTYPE','RateType','LTV','YrsThere','employer','credit','Income','LoanAmt','dt','ip');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_addr(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_EMAIL(TotalErrors.ErrorNum),Fields.InValidMessage_phone(TotalErrors.ErrorNum),Fields.InValidMessage_LoanType(TotalErrors.ErrorNum),Fields.InValidMessage_BESTTIME(TotalErrors.ErrorNum),Fields.InValidMessage_MortRate(TotalErrors.ErrorNum),Fields.InValidMessage_PROPERTYTYPE(TotalErrors.ErrorNum),Fields.InValidMessage_RateType(TotalErrors.ErrorNum),Fields.InValidMessage_LTV(TotalErrors.ErrorNum),Fields.InValidMessage_YrsThere(TotalErrors.ErrorNum),Fields.InValidMessage_employer(TotalErrors.ErrorNum),Fields.InValidMessage_credit(TotalErrors.ErrorNum),Fields.InValidMessage_Income(TotalErrors.ErrorNum),Fields.InValidMessage_LoanAmt(TotalErrors.ErrorNum),Fields.InValidMessage_dt(TotalErrors.ErrorNum),Fields.InValidMessage_ip(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
end;
ValErr := table(TotalErrors,PrettyErrorTotals);
export ValidityErrors := ValErr;
end;
