+++Line:25:RIDField is now compulsory for full adl matching!!!
// Various routines to assist in debugging
import SALT20,ut;
export Debug(dataset(layout_files().input.used) ih, Layout_Specificities.R s, MatchThreshold = 0) := module
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
shared h := match_candidates(ih).candidates;
shared LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
export Layout_Sample_Matches := record,maxlength(32000)
  integer2 Conf;
  integer2 Conf_Prop;
  integer2 DateOverlap := 0;
  SALT20.UIDType 1;
  SALT20.UIDType 2;
  SALT20.UIDType 1;
  SALT20.UIDType 2;
  typeof(h.id) left_id;
  integer2 id_score;
  typeof(h.id) right_id;
  typeof(h.fname) left_fname;
  integer2 fname_score;
  typeof(h.fname) right_fname;
  typeof(h.lname) left_lname;
  integer2 lname_score;
  typeof(h.lname) right_lname;
  typeof(h.dob) left_dob;
  integer2 dob_score;
  typeof(h.dob) right_dob;
  typeof(h.Own_Home) left_Own_Home;
  integer2 Own_Home_score;
  typeof(h.Own_Home) right_Own_Home;
  typeof(h.dlnum) left_dlnum;
  integer2 dlnum_score;
  typeof(h.dlnum) right_dlnum;
  typeof(h.State_Of_License) left_State_Of_License;
  integer2 State_Of_License_score;
  typeof(h.State_Of_License) right_State_Of_License;
  typeof(h.addr) left_addr;
  integer2 addr_score;
  typeof(h.addr) right_addr;
  typeof(h.city) left_city;
  integer2 city_score;
  typeof(h.city) right_city;
  typeof(h.st) left_st;
  integer2 st_score;
  typeof(h.st) right_st;
  typeof(h.zip) left_zip;
  integer2 zip_score;
  typeof(h.zip) right_zip;
  typeof(h.Phone_Home) left_Phone_Home;
  integer2 Phone_Home_score;
  typeof(h.Phone_Home) right_Phone_Home;
  typeof(h.Phone_Cell) left_Phone_Cell;
  integer2 Phone_Cell_score;
  typeof(h.Phone_Cell) right_Phone_Cell;
  typeof(h.Phone_Work) left_Phone_Work;
  integer2 Phone_Work_score;
  typeof(h.Phone_Work) right_Phone_Work;
  typeof(h.EMAIL) left_EMAIL;
  integer2 EMAIL_score;
  typeof(h.EMAIL) right_EMAIL;
  typeof(h.ip) left_ip;
  integer2 ip_score;
  typeof(h.ip) right_ip;
  typeof(h.dt) left_dt;
  integer2 dt_score;
  typeof(h.dt) right_dt;
  typeof(h.INCOME_MONTHLY) left_INCOME_MONTHLY;
  integer2 INCOME_MONTHLY_score;
  typeof(h.INCOME_MONTHLY) right_INCOME_MONTHLY;
  typeof(h.Weekly_BiWeekly) left_Weekly_BiWeekly;
  integer2 Weekly_BiWeekly_score;
  typeof(h.Weekly_BiWeekly) right_Weekly_BiWeekly;
  typeof(h.MONTHSEMPLOYED) left_MONTHSEMPLOYED;
  integer2 MONTHSEMPLOYED_score;
  typeof(h.MONTHSEMPLOYED) right_MONTHSEMPLOYED;
  typeof(h.MonthsAtBank) left_MonthsAtBank;
  integer2 MonthsAtBank_score;
  typeof(h.MonthsAtBank) right_MonthsAtBank;
  typeof(h.employer) left_employer;
  integer2 employer_score;
  typeof(h.employer) right_employer;
  typeof(h.Bank) left_Bank;
  integer2 Bank_score;
  typeof(h.Bank) right_Bank;
end;
export layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,unsigned outside=0) := transform
  self.1 := le.;
  self.2 := ri.;
  self.1 := le.;
  self.2 := ri.;
  self.id_score := MAP( le.id_isnull or ri.id_isnull => 0,
                        le.id = ri.id  => le.id_weight100,
                        SALT20.Fn_Fail_Scale(le.id_weight100,s.id_switch));
  self.left_id := le.id;
  self.right_id := ri.id;
  self.fname_score := MAP( le.fname_isnull or ri.fname_isnull => 0,
                        le.fname = ri.fname  => le.fname_weight100,
                        SALT20.Fn_Fail_Scale(le.fname_weight100,s.fname_switch));
  self.left_fname := le.fname;
  self.right_fname := ri.fname;
  self.lname_score := MAP( le.lname_isnull or ri.lname_isnull => 0,
                        le.lname = ri.lname  => le.lname_weight100,
                        SALT20.Fn_Fail_Scale(le.lname_weight100,s.lname_switch));
  self.left_lname := le.lname;
  self.right_lname := ri.lname;
  self.dob_score := MAP( le.dob_isnull or ri.dob_isnull => 0,
                        le.dob = ri.dob  => le.dob_weight100,
                        SALT20.Fn_Fail_Scale(le.dob_weight100,s.dob_switch));
  self.left_dob := le.dob;
  self.right_dob := ri.dob;
  self.Own_Home_score := MAP( le.Own_Home_isnull or ri.Own_Home_isnull => 0,
                        le.Own_Home = ri.Own_Home  => le.Own_Home_weight100,
                        SALT20.Fn_Fail_Scale(le.Own_Home_weight100,s.Own_Home_switch));
  self.left_Own_Home := le.Own_Home;
  self.right_Own_Home := ri.Own_Home;
  self.dlnum_score := MAP( le.dlnum_isnull or ri.dlnum_isnull => 0,
                        le.dlnum = ri.dlnum  => le.dlnum_weight100,
                        SALT20.Fn_Fail_Scale(le.dlnum_weight100,s.dlnum_switch));
  self.left_dlnum := le.dlnum;
  self.right_dlnum := ri.dlnum;
  self.State_Of_License_score := MAP( le.State_Of_License_isnull or ri.State_Of_License_isnull => 0,
                        le.State_Of_License = ri.State_Of_License  => le.State_Of_License_weight100,
                        SALT20.Fn_Fail_Scale(le.State_Of_License_weight100,s.State_Of_License_switch));
  self.left_State_Of_License := le.State_Of_License;
  self.right_State_Of_License := ri.State_Of_License;
  self.addr_score := MAP( le.addr_isnull or ri.addr_isnull => 0,
                        le.addr = ri.addr  => le.addr_weight100,
                        SALT20.Fn_Fail_Scale(le.addr_weight100,s.addr_switch));
  self.left_addr := le.addr;
  self.right_addr := ri.addr;
  self.city_score := MAP( le.city_isnull or ri.city_isnull => 0,
                        le.city = ri.city  => le.city_weight100,
                        SALT20.Fn_Fail_Scale(le.city_weight100,s.city_switch));
  self.left_city := le.city;
  self.right_city := ri.city;
  self.st_score := MAP( le.st_isnull or ri.st_isnull => 0,
                        le.st = ri.st  => le.st_weight100,
                        SALT20.Fn_Fail_Scale(le.st_weight100,s.st_switch));
  self.left_st := le.st;
  self.right_st := ri.st;
  self.zip_score := MAP( le.zip_isnull or ri.zip_isnull => 0,
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT20.Fn_Fail_Scale(le.zip_weight100,s.zip_switch));
  self.left_zip := le.zip;
  self.right_zip := ri.zip;
  self.Phone_Home_score := MAP( le.Phone_Home_isnull or ri.Phone_Home_isnull => 0,
                        le.Phone_Home = ri.Phone_Home  => le.Phone_Home_weight100,
                        SALT20.Fn_Fail_Scale(le.Phone_Home_weight100,s.Phone_Home_switch));
  self.left_Phone_Home := le.Phone_Home;
  self.right_Phone_Home := ri.Phone_Home;
  self.Phone_Cell_score := MAP( le.Phone_Cell_isnull or ri.Phone_Cell_isnull => 0,
                        le.Phone_Cell = ri.Phone_Cell  => le.Phone_Cell_weight100,
                        SALT20.Fn_Fail_Scale(le.Phone_Cell_weight100,s.Phone_Cell_switch));
  self.left_Phone_Cell := le.Phone_Cell;
  self.right_Phone_Cell := ri.Phone_Cell;
  self.Phone_Work_score := MAP( le.Phone_Work_isnull or ri.Phone_Work_isnull => 0,
                        le.Phone_Work = ri.Phone_Work  => le.Phone_Work_weight100,
                        SALT20.Fn_Fail_Scale(le.Phone_Work_weight100,s.Phone_Work_switch));
  self.left_Phone_Work := le.Phone_Work;
  self.right_Phone_Work := ri.Phone_Work;
  self.EMAIL_score := MAP( le.EMAIL_isnull or ri.EMAIL_isnull => 0,
                        le.EMAIL = ri.EMAIL  => le.EMAIL_weight100,
                        SALT20.Fn_Fail_Scale(le.EMAIL_weight100,s.EMAIL_switch));
  self.left_EMAIL := le.EMAIL;
  self.right_EMAIL := ri.EMAIL;
  self.ip_score := MAP( le.ip_isnull or ri.ip_isnull => 0,
                        le.ip = ri.ip  => le.ip_weight100,
                        SALT20.Fn_Fail_Scale(le.ip_weight100,s.ip_switch));
  self.left_ip := le.ip;
  self.right_ip := ri.ip;
  self.dt_score := MAP( le.dt_isnull or ri.dt_isnull => 0,
                        le.dt = ri.dt  => le.dt_weight100,
                        SALT20.Fn_Fail_Scale(le.dt_weight100,s.dt_switch));
  self.left_dt := le.dt;
  self.right_dt := ri.dt;
  self.INCOME_MONTHLY_score := MAP( le.INCOME_MONTHLY_isnull or ri.INCOME_MONTHLY_isnull => 0,
                        le.INCOME_MONTHLY = ri.INCOME_MONTHLY  => le.INCOME_MONTHLY_weight100,
                        SALT20.Fn_Fail_Scale(le.INCOME_MONTHLY_weight100,s.INCOME_MONTHLY_switch));
  self.left_INCOME_MONTHLY := le.INCOME_MONTHLY;
  self.right_INCOME_MONTHLY := ri.INCOME_MONTHLY;
  self.Weekly_BiWeekly_score := MAP( le.Weekly_BiWeekly_isnull or ri.Weekly_BiWeekly_isnull => 0,
                        le.Weekly_BiWeekly = ri.Weekly_BiWeekly  => le.Weekly_BiWeekly_weight100,
                        SALT20.Fn_Fail_Scale(le.Weekly_BiWeekly_weight100,s.Weekly_BiWeekly_switch));
  self.left_Weekly_BiWeekly := le.Weekly_BiWeekly;
  self.right_Weekly_BiWeekly := ri.Weekly_BiWeekly;
  self.MONTHSEMPLOYED_score := MAP( le.MONTHSEMPLOYED_isnull or ri.MONTHSEMPLOYED_isnull => 0,
                        le.MONTHSEMPLOYED = ri.MONTHSEMPLOYED  => le.MONTHSEMPLOYED_weight100,
                        SALT20.Fn_Fail_Scale(le.MONTHSEMPLOYED_weight100,s.MONTHSEMPLOYED_switch));
  self.left_MONTHSEMPLOYED := le.MONTHSEMPLOYED;
  self.right_MONTHSEMPLOYED := ri.MONTHSEMPLOYED;
  self.MonthsAtBank_score := MAP( le.MonthsAtBank_isnull or ri.MonthsAtBank_isnull => 0,
                        le.MonthsAtBank = ri.MonthsAtBank  => le.MonthsAtBank_weight100,
                        SALT20.Fn_Fail_Scale(le.MonthsAtBank_weight100,s.MonthsAtBank_switch));
  self.left_MonthsAtBank := le.MonthsAtBank;
  self.right_MonthsAtBank := ri.MonthsAtBank;
  self.employer_score := MAP( le.employer_isnull or ri.employer_isnull => 0,
                        le.employer = ri.employer  => le.employer_weight100,
                        SALT20.Fn_Fail_Scale(le.employer_weight100,s.employer_switch));
  self.left_employer := le.employer;
  self.right_employer := ri.employer;
  self.Bank_score := MAP( le.Bank_isnull or ri.Bank_isnull => 0,
                        le.Bank = ri.Bank  => le.Bank_weight100,
                        SALT20.Fn_Fail_Scale(le.Bank_weight100,s.Bank_switch));
  self.left_Bank := le.Bank;
  self.right_Bank := ri.Bank;
  self.Conf_Prop := (0
  ) / 100; // Score based on propogated fields
  self.Conf := (self.id_score + self.fname_score + self.lname_score + self.dob_score + self.Own_Home_score + self.dlnum_score + self.State_Of_License_score + self.addr_score + self.city_score + self.st_score + self.zip_score + self.Phone_Home_score + self.Phone_Cell_score + self.Phone_Work_score + self.EMAIL_score + self.ip_score + self.dt_score + self.INCOME_MONTHLY_score + self.Weekly_BiWeekly_score + self.MONTHSEMPLOYED_score + self.MonthsAtBank_score + self.employer_score + self.Bank_score) / 100 + outside;
end;
export AnnotateMatchesFromData(dataset(match_candidates(ih).layout_candidates) in_data,dataset(match_candidates(ih).layout_matches)  im) := function
  j1 := join(in_data,im,left. = right.1,hash);
  match_candidates(ih).layout_candidates strim(j1 le) := transform
    self := le;
  end;
  r := join(j1,in_data,left.2 = right.,sample_match_join( project(left,strim(left)),right),hash);
  d := dedup( sort( r, 1, 2, -Conf, local ), 1, 2, local ); // 2 distributed by join
  return d;
end;
export AnnotateMatchesFromRecordData(dataset(match_candidates(ih).layout_candidates) in_data,dataset(match_candidates(ih).layout_matches)  im) := function//Faster form when  known
  j1 := join(in_data,im,left. = right.1,hash);
  match_candidates(ih).layout_candidates strim(j1 le) := transform
    self := le;
  end;
  return join(j1,in_data,left.2 = right.,sample_match_join( project(left,strim(left)),right),hash);
end;
export AnnotateClusterMatches(dataset(match_candidates(ih).layout_candidates) in_data,SALT20.UIDType BaseRecord) := function//Faster form when  known
  j1 := in_data( = BaseRecord);
  match_candidates(ih).layout_candidates strim(j1 le) := transform
    self := le;
  end;
  return join(in_data(<>BaseRecord),j1,true,sample_match_join( project(left,strim(left)),right),all);
end;
export AnnotateMatches(dataset(match_candidates(ih).layout_matches)  im) := function
  return AnnotateMatchesFromRecordData(h,im);
end;
export Layout_RolledEntity := record,maxlength(63000)
  SALT20.UIDType ;
  dataset(SALT20.Layout_FieldValueList) id_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) fname_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) lname_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) dob_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) Own_Home_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) dlnum_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) State_Of_License_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) addr_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) city_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) st_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) zip_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) Phone_Home_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) Phone_Cell_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) Phone_Work_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) EMAIL_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) ip_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) dt_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) INCOME_MONTHLY_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) Weekly_BiWeekly_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) MONTHSEMPLOYED_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) MonthsAtBank_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) employer_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) Bank_Values := dataset([],SALT20.Layout_FieldValueList);
end;
shared RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := transform
  self. := le.;
  self.id_values := SALT20.fn_combine_fieldvaluelist(le.id_values,ri.id_values);
  self.fname_values := SALT20.fn_combine_fieldvaluelist(le.fname_values,ri.fname_values);
  self.lname_values := SALT20.fn_combine_fieldvaluelist(le.lname_values,ri.lname_values);
  self.dob_values := SALT20.fn_combine_fieldvaluelist(le.dob_values,ri.dob_values);
  self.Own_Home_values := SALT20.fn_combine_fieldvaluelist(le.Own_Home_values,ri.Own_Home_values);
  self.dlnum_values := SALT20.fn_combine_fieldvaluelist(le.dlnum_values,ri.dlnum_values);
  self.State_Of_License_values := SALT20.fn_combine_fieldvaluelist(le.State_Of_License_values,ri.State_Of_License_values);
  self.addr_values := SALT20.fn_combine_fieldvaluelist(le.addr_values,ri.addr_values);
  self.city_values := SALT20.fn_combine_fieldvaluelist(le.city_values,ri.city_values);
  self.st_values := SALT20.fn_combine_fieldvaluelist(le.st_values,ri.st_values);
  self.zip_values := SALT20.fn_combine_fieldvaluelist(le.zip_values,ri.zip_values);
  self.Phone_Home_values := SALT20.fn_combine_fieldvaluelist(le.Phone_Home_values,ri.Phone_Home_values);
  self.Phone_Cell_values := SALT20.fn_combine_fieldvaluelist(le.Phone_Cell_values,ri.Phone_Cell_values);
  self.Phone_Work_values := SALT20.fn_combine_fieldvaluelist(le.Phone_Work_values,ri.Phone_Work_values);
  self.EMAIL_values := SALT20.fn_combine_fieldvaluelist(le.EMAIL_values,ri.EMAIL_values);
  self.ip_values := SALT20.fn_combine_fieldvaluelist(le.ip_values,ri.ip_values);
  self.dt_values := SALT20.fn_combine_fieldvaluelist(le.dt_values,ri.dt_values);
  self.INCOME_MONTHLY_values := SALT20.fn_combine_fieldvaluelist(le.INCOME_MONTHLY_values,ri.INCOME_MONTHLY_values);
  self.Weekly_BiWeekly_values := SALT20.fn_combine_fieldvaluelist(le.Weekly_BiWeekly_values,ri.Weekly_BiWeekly_values);
  self.MONTHSEMPLOYED_values := SALT20.fn_combine_fieldvaluelist(le.MONTHSEMPLOYED_values,ri.MONTHSEMPLOYED_values);
  self.MonthsAtBank_values := SALT20.fn_combine_fieldvaluelist(le.MonthsAtBank_values,ri.MonthsAtBank_values);
  self.employer_values := SALT20.fn_combine_fieldvaluelist(le.employer_values,ri.employer_values);
  self.Bank_values := SALT20.fn_combine_fieldvaluelist(le.Bank_values,ri.Bank_values);
end;
  return rollup( sort( distribute( infile, hash() ), , local ), left. = right., RollValues(left,right),local);
end;
export RolledEntities(dataset(match_candidates(ih).layout_candidates) in_data) := function
Layout_RolledEntity into(in_data le) := transform
  self. := le.;
  self.id_Values := IF ( le.id  IN SET(s.nulls_id,id),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.id)}],SALT20.Layout_FieldValueList));
  self.fname_Values := IF ( le.fname  IN SET(s.nulls_fname,fname),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.fname)}],SALT20.Layout_FieldValueList));
  self.lname_Values := IF ( le.lname  IN SET(s.nulls_lname,lname),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.lname)}],SALT20.Layout_FieldValueList));
  self.dob_Values := IF ( le.dob  IN SET(s.nulls_dob,dob),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.dob)}],SALT20.Layout_FieldValueList));
  self.Own_Home_Values := IF ( le.Own_Home  IN SET(s.nulls_Own_Home,Own_Home),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.Own_Home)}],SALT20.Layout_FieldValueList));
  self.dlnum_Values := IF ( le.dlnum  IN SET(s.nulls_dlnum,dlnum),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.dlnum)}],SALT20.Layout_FieldValueList));
  self.State_Of_License_Values := IF ( le.State_Of_License  IN SET(s.nulls_State_Of_License,State_Of_License),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.State_Of_License)}],SALT20.Layout_FieldValueList));
  self.addr_Values := IF ( le.addr  IN SET(s.nulls_addr,addr),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.addr)}],SALT20.Layout_FieldValueList));
  self.city_Values := IF ( le.city  IN SET(s.nulls_city,city),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.city)}],SALT20.Layout_FieldValueList));
  self.st_Values := IF ( le.st  IN SET(s.nulls_st,st),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.st)}],SALT20.Layout_FieldValueList));
  self.zip_Values := IF ( le.zip  IN SET(s.nulls_zip,zip),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.zip)}],SALT20.Layout_FieldValueList));
  self.Phone_Home_Values := IF ( le.Phone_Home  IN SET(s.nulls_Phone_Home,Phone_Home),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.Phone_Home)}],SALT20.Layout_FieldValueList));
  self.Phone_Cell_Values := IF ( le.Phone_Cell  IN SET(s.nulls_Phone_Cell,Phone_Cell),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.Phone_Cell)}],SALT20.Layout_FieldValueList));
  self.Phone_Work_Values := IF ( le.Phone_Work  IN SET(s.nulls_Phone_Work,Phone_Work),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.Phone_Work)}],SALT20.Layout_FieldValueList));
  self.EMAIL_Values := IF ( le.EMAIL  IN SET(s.nulls_EMAIL,EMAIL),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.EMAIL)}],SALT20.Layout_FieldValueList));
  self.ip_Values := IF ( le.ip  IN SET(s.nulls_ip,ip),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.ip)}],SALT20.Layout_FieldValueList));
  self.dt_Values := IF ( le.dt  IN SET(s.nulls_dt,dt),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.dt)}],SALT20.Layout_FieldValueList));
  self.INCOME_MONTHLY_Values := IF ( le.INCOME_MONTHLY  IN SET(s.nulls_INCOME_MONTHLY,INCOME_MONTHLY),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.INCOME_MONTHLY)}],SALT20.Layout_FieldValueList));
  self.Weekly_BiWeekly_Values := IF ( le.Weekly_BiWeekly  IN SET(s.nulls_Weekly_BiWeekly,Weekly_BiWeekly),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.Weekly_BiWeekly)}],SALT20.Layout_FieldValueList));
  self.MONTHSEMPLOYED_Values := IF ( le.MONTHSEMPLOYED  IN SET(s.nulls_MONTHSEMPLOYED,MONTHSEMPLOYED),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.MONTHSEMPLOYED)}],SALT20.Layout_FieldValueList));
  self.MonthsAtBank_Values := IF ( le.MonthsAtBank  IN SET(s.nulls_MonthsAtBank,MonthsAtBank),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.MonthsAtBank)}],SALT20.Layout_FieldValueList));
  self.employer_Values := IF ( le.employer  IN SET(s.nulls_employer,employer),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.employer)}],SALT20.Layout_FieldValueList));
  self.Bank_Values := IF ( le.Bank  IN SET(s.nulls_Bank,Bank),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.Bank)}],SALT20.Layout_FieldValueList));
end;
AsFieldValues := project(in_data,into(left));
  return RollEntities(AsFieldValues);
end;
Layout_RolledEntity into(ih le) := transform
  self. := le.;
  self.id_Values := IF ( le.id  IN SET(s.nulls_id,id),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.id)}],SALT20.Layout_FieldValueList));
  self.fname_Values := IF ( le.fname  IN SET(s.nulls_fname,fname),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.fname)}],SALT20.Layout_FieldValueList));
  self.lname_Values := IF ( le.lname  IN SET(s.nulls_lname,lname),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.lname)}],SALT20.Layout_FieldValueList));
  self.dob_Values := IF ( le.dob  IN SET(s.nulls_dob,dob),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.dob)}],SALT20.Layout_FieldValueList));
  self.Own_Home_Values := IF ( le.Own_Home  IN SET(s.nulls_Own_Home,Own_Home),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.Own_Home)}],SALT20.Layout_FieldValueList));
  self.dlnum_Values := IF ( le.dlnum  IN SET(s.nulls_dlnum,dlnum),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.dlnum)}],SALT20.Layout_FieldValueList));
  self.State_Of_License_Values := IF ( le.State_Of_License  IN SET(s.nulls_State_Of_License,State_Of_License),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.State_Of_License)}],SALT20.Layout_FieldValueList));
  self.addr_Values := IF ( le.addr  IN SET(s.nulls_addr,addr),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.addr)}],SALT20.Layout_FieldValueList));
  self.city_Values := IF ( le.city  IN SET(s.nulls_city,city),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.city)}],SALT20.Layout_FieldValueList));
  self.st_Values := IF ( le.st  IN SET(s.nulls_st,st),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.st)}],SALT20.Layout_FieldValueList));
  self.zip_Values := IF ( le.zip  IN SET(s.nulls_zip,zip),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.zip)}],SALT20.Layout_FieldValueList));
  self.Phone_Home_Values := IF ( le.Phone_Home  IN SET(s.nulls_Phone_Home,Phone_Home),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.Phone_Home)}],SALT20.Layout_FieldValueList));
  self.Phone_Cell_Values := IF ( le.Phone_Cell  IN SET(s.nulls_Phone_Cell,Phone_Cell),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.Phone_Cell)}],SALT20.Layout_FieldValueList));
  self.Phone_Work_Values := IF ( le.Phone_Work  IN SET(s.nulls_Phone_Work,Phone_Work),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.Phone_Work)}],SALT20.Layout_FieldValueList));
  self.EMAIL_Values := IF ( le.EMAIL  IN SET(s.nulls_EMAIL,EMAIL),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.EMAIL)}],SALT20.Layout_FieldValueList));
  self.ip_Values := IF ( le.ip  IN SET(s.nulls_ip,ip),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.ip)}],SALT20.Layout_FieldValueList));
  self.dt_Values := IF ( le.dt  IN SET(s.nulls_dt,dt),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.dt)}],SALT20.Layout_FieldValueList));
  self.INCOME_MONTHLY_Values := IF ( le.INCOME_MONTHLY  IN SET(s.nulls_INCOME_MONTHLY,INCOME_MONTHLY),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.INCOME_MONTHLY)}],SALT20.Layout_FieldValueList));
  self.Weekly_BiWeekly_Values := IF ( le.Weekly_BiWeekly  IN SET(s.nulls_Weekly_BiWeekly,Weekly_BiWeekly),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.Weekly_BiWeekly)}],SALT20.Layout_FieldValueList));
  self.MONTHSEMPLOYED_Values := IF ( le.MONTHSEMPLOYED  IN SET(s.nulls_MONTHSEMPLOYED,MONTHSEMPLOYED),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.MONTHSEMPLOYED)}],SALT20.Layout_FieldValueList));
  self.MonthsAtBank_Values := IF ( le.MonthsAtBank  IN SET(s.nulls_MonthsAtBank,MonthsAtBank),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.MonthsAtBank)}],SALT20.Layout_FieldValueList));
  self.employer_Values := IF ( le.employer  IN SET(s.nulls_employer,employer),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.employer)}],SALT20.Layout_FieldValueList));
  self.Bank_Values := IF ( le.Bank  IN SET(s.nulls_Bank,Bank),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.Bank)}],SALT20.Layout_FieldValueList));
end;
AsFieldValues := project(ih,into(left));
export InFile_Rolled := RollEntities(AsFieldValues);
export RemoveProps(dataset(match_candidates(ih).layout_candidates) im) := function
  im rem(im le) := transform
    self := le;
  end;
  return project(im,rem(left));
end;
// Now to compute the chubbies; those clusters which are really rather larger than one would expect
// this is presently defined in terms of number of field values * the improbability of that occuring by chance
// this could be used as poor mans dodgy-dids; but it does not allow for value planing (co-occurrence)
AllRolled := InFile_Rolled;
Layout_Chubbies0 := RECORD,MAXLENGTH(63000)
  AllRolled;
  unsigned1 id_size := 0;
  unsigned1 fname_size := 0;
  unsigned1 lname_size := 0;
  unsigned1 dob_size := 0;
  unsigned1 Own_Home_size := 0;
  unsigned1 dlnum_size := 0;
  unsigned1 State_Of_License_size := 0;
  unsigned1 addr_size := 0;
  unsigned1 city_size := 0;
  unsigned1 st_size := 0;
  unsigned1 zip_size := 0;
  unsigned1 Phone_Home_size := 0;
  unsigned1 Phone_Cell_size := 0;
  unsigned1 Phone_Work_size := 0;
  unsigned1 EMAIL_size := 0;
  unsigned1 ip_size := 0;
  unsigned1 dt_size := 0;
  unsigned1 INCOME_MONTHLY_size := 0;
  unsigned1 Weekly_BiWeekly_size := 0;
  unsigned1 MONTHSEMPLOYED_size := 0;
  unsigned1 MonthsAtBank_size := 0;
  unsigned1 employer_size := 0;
  unsigned1 Bank_size := 0;
end;
t0 := table(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := transform
  SELF.id_size := SALT20.Fn_SwitchSpec(s.id_switch,count(le.id_values));
  SELF.fname_size := SALT20.Fn_SwitchSpec(s.fname_switch,count(le.fname_values));
  SELF.lname_size := SALT20.Fn_SwitchSpec(s.lname_switch,count(le.lname_values));
  SELF.dob_size := SALT20.Fn_SwitchSpec(s.dob_switch,count(le.dob_values));
  SELF.Own_Home_size := SALT20.Fn_SwitchSpec(s.Own_Home_switch,count(le.Own_Home_values));
  SELF.dlnum_size := SALT20.Fn_SwitchSpec(s.dlnum_switch,count(le.dlnum_values));
  SELF.State_Of_License_size := SALT20.Fn_SwitchSpec(s.State_Of_License_switch,count(le.State_Of_License_values));
  SELF.addr_size := SALT20.Fn_SwitchSpec(s.addr_switch,count(le.addr_values));
  SELF.city_size := SALT20.Fn_SwitchSpec(s.city_switch,count(le.city_values));
  SELF.st_size := SALT20.Fn_SwitchSpec(s.st_switch,count(le.st_values));
  SELF.zip_size := SALT20.Fn_SwitchSpec(s.zip_switch,count(le.zip_values));
  SELF.Phone_Home_size := SALT20.Fn_SwitchSpec(s.Phone_Home_switch,count(le.Phone_Home_values));
  SELF.Phone_Cell_size := SALT20.Fn_SwitchSpec(s.Phone_Cell_switch,count(le.Phone_Cell_values));
  SELF.Phone_Work_size := SALT20.Fn_SwitchSpec(s.Phone_Work_switch,count(le.Phone_Work_values));
  SELF.EMAIL_size := SALT20.Fn_SwitchSpec(s.EMAIL_switch,count(le.EMAIL_values));
  SELF.ip_size := SALT20.Fn_SwitchSpec(s.ip_switch,count(le.ip_values));
  SELF.dt_size := SALT20.Fn_SwitchSpec(s.dt_switch,count(le.dt_values));
  SELF.INCOME_MONTHLY_size := SALT20.Fn_SwitchSpec(s.INCOME_MONTHLY_switch,count(le.INCOME_MONTHLY_values));
  SELF.Weekly_BiWeekly_size := SALT20.Fn_SwitchSpec(s.Weekly_BiWeekly_switch,count(le.Weekly_BiWeekly_values));
  SELF.MONTHSEMPLOYED_size := SALT20.Fn_SwitchSpec(s.MONTHSEMPLOYED_switch,count(le.MONTHSEMPLOYED_values));
  SELF.MonthsAtBank_size := SALT20.Fn_SwitchSpec(s.MonthsAtBank_switch,count(le.MonthsAtBank_values));
  SELF.employer_size := SALT20.Fn_SwitchSpec(s.employer_switch,count(le.employer_values));
  SELF.Bank_size := SALT20.Fn_SwitchSpec(s.Bank_switch,count(le.Bank_values));
  SELF := le;
end;  t := project(t0,NoteSize(left));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  unsigned2 Size := t.id_size+t.fname_size+t.lname_size+t.dob_size+t.Own_Home_size+t.dlnum_size+t.State_Of_License_size+t.addr_size+t.city_size+t.st_size+t.zip_size+t.Phone_Home_size+t.Phone_Cell_size+t.Phone_Work_size+t.EMAIL_size+t.ip_size+t.dt_size+t.INCOME_MONTHLY_size+t.Weekly_BiWeekly_size+t.MONTHSEMPLOYED_size+t.MonthsAtBank_size+t.employer_size+t.Bank_size;
end;
export Chubbies := table(t,Layout_Chubbies);
end;
