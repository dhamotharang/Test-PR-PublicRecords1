+++Line:24:RIDField is now compulsory for full adl matching!!!
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
  typeof(h.fname) left_fname;
  integer2 fname_score;
  typeof(h.fname) right_fname;
  typeof(h.lname) left_lname;
  integer2 lname_score;
  typeof(h.lname) right_lname;
  typeof(h.addr) left_addr;
  integer2 addr_score;
  typeof(h.addr) right_addr;
  typeof(h.city) left_city;
  integer2 city_score;
  typeof(h.city) right_city;
  typeof(h.state) left_state;
  integer2 state_score;
  typeof(h.state) right_state;
  typeof(h.zip) left_zip;
  integer2 zip_score;
  typeof(h.zip) right_zip;
  typeof(h.zip4) left_zip4;
  integer2 zip4_score;
  typeof(h.zip4) right_zip4;
  typeof(h.EMAIL) left_EMAIL;
  integer2 EMAIL_score;
  typeof(h.EMAIL) right_EMAIL;
  typeof(h.phone) left_phone;
  integer2 phone_score;
  typeof(h.phone) right_phone;
  typeof(h.LoanType) left_LoanType;
  integer2 LoanType_score;
  typeof(h.LoanType) right_LoanType;
  typeof(h.BESTTIME) left_BESTTIME;
  integer2 BESTTIME_score;
  typeof(h.BESTTIME) right_BESTTIME;
  typeof(h.MortRate) left_MortRate;
  integer2 MortRate_score;
  typeof(h.MortRate) right_MortRate;
  typeof(h.PROPERTYTYPE) left_PROPERTYTYPE;
  integer2 PROPERTYTYPE_score;
  typeof(h.PROPERTYTYPE) right_PROPERTYTYPE;
  typeof(h.RateType) left_RateType;
  integer2 RateType_score;
  typeof(h.RateType) right_RateType;
  typeof(h.LTV) left_LTV;
  integer2 LTV_score;
  typeof(h.LTV) right_LTV;
  typeof(h.YrsThere) left_YrsThere;
  integer2 YrsThere_score;
  typeof(h.YrsThere) right_YrsThere;
  typeof(h.employer) left_employer;
  integer2 employer_score;
  typeof(h.employer) right_employer;
  typeof(h.credit) left_credit;
  integer2 credit_score;
  typeof(h.credit) right_credit;
  typeof(h.Income) left_Income;
  integer2 Income_score;
  typeof(h.Income) right_Income;
  typeof(h.LoanAmt) left_LoanAmt;
  integer2 LoanAmt_score;
  typeof(h.LoanAmt) right_LoanAmt;
  typeof(h.dt) left_dt;
  integer2 dt_score;
  typeof(h.dt) right_dt;
  typeof(h.ip) left_ip;
  integer2 ip_score;
  typeof(h.ip) right_ip;
end;
export layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,unsigned outside=0) := transform
  self.1 := le.;
  self.2 := ri.;
  self.1 := le.;
  self.2 := ri.;
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
  self.state_score := MAP( le.state_isnull or ri.state_isnull => 0,
                        le.state = ri.state  => le.state_weight100,
                        SALT20.Fn_Fail_Scale(le.state_weight100,s.state_switch));
  self.left_state := le.state;
  self.right_state := ri.state;
  self.zip_score := MAP( le.zip_isnull or ri.zip_isnull => 0,
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT20.Fn_Fail_Scale(le.zip_weight100,s.zip_switch));
  self.left_zip := le.zip;
  self.right_zip := ri.zip;
  self.zip4_score := MAP( le.zip4_isnull or ri.zip4_isnull => 0,
                        le.zip4 = ri.zip4  => le.zip4_weight100,
                        SALT20.Fn_Fail_Scale(le.zip4_weight100,s.zip4_switch));
  self.left_zip4 := le.zip4;
  self.right_zip4 := ri.zip4;
  self.EMAIL_score := MAP( le.EMAIL_isnull or ri.EMAIL_isnull => 0,
                        le.EMAIL = ri.EMAIL  => le.EMAIL_weight100,
                        SALT20.Fn_Fail_Scale(le.EMAIL_weight100,s.EMAIL_switch));
  self.left_EMAIL := le.EMAIL;
  self.right_EMAIL := ri.EMAIL;
  self.phone_score := MAP( le.phone_isnull or ri.phone_isnull => 0,
                        le.phone = ri.phone  => le.phone_weight100,
                        SALT20.Fn_Fail_Scale(le.phone_weight100,s.phone_switch));
  self.left_phone := le.phone;
  self.right_phone := ri.phone;
  self.LoanType_score := MAP( le.LoanType_isnull or ri.LoanType_isnull => 0,
                        le.LoanType = ri.LoanType  => le.LoanType_weight100,
                        SALT20.Fn_Fail_Scale(le.LoanType_weight100,s.LoanType_switch));
  self.left_LoanType := le.LoanType;
  self.right_LoanType := ri.LoanType;
  self.BESTTIME_score := MAP( le.BESTTIME_isnull or ri.BESTTIME_isnull => 0,
                        le.BESTTIME = ri.BESTTIME  => le.BESTTIME_weight100,
                        SALT20.Fn_Fail_Scale(le.BESTTIME_weight100,s.BESTTIME_switch));
  self.left_BESTTIME := le.BESTTIME;
  self.right_BESTTIME := ri.BESTTIME;
  self.MortRate_score := MAP( le.MortRate_isnull or ri.MortRate_isnull => 0,
                        le.MortRate = ri.MortRate  => le.MortRate_weight100,
                        SALT20.Fn_Fail_Scale(le.MortRate_weight100,s.MortRate_switch));
  self.left_MortRate := le.MortRate;
  self.right_MortRate := ri.MortRate;
  self.PROPERTYTYPE_score := MAP( le.PROPERTYTYPE_isnull or ri.PROPERTYTYPE_isnull => 0,
                        le.PROPERTYTYPE = ri.PROPERTYTYPE  => le.PROPERTYTYPE_weight100,
                        SALT20.Fn_Fail_Scale(le.PROPERTYTYPE_weight100,s.PROPERTYTYPE_switch));
  self.left_PROPERTYTYPE := le.PROPERTYTYPE;
  self.right_PROPERTYTYPE := ri.PROPERTYTYPE;
  self.RateType_score := MAP( le.RateType_isnull or ri.RateType_isnull => 0,
                        le.RateType = ri.RateType  => le.RateType_weight100,
                        SALT20.Fn_Fail_Scale(le.RateType_weight100,s.RateType_switch));
  self.left_RateType := le.RateType;
  self.right_RateType := ri.RateType;
  self.LTV_score := MAP( le.LTV_isnull or ri.LTV_isnull => 0,
                        le.LTV = ri.LTV  => le.LTV_weight100,
                        SALT20.Fn_Fail_Scale(le.LTV_weight100,s.LTV_switch));
  self.left_LTV := le.LTV;
  self.right_LTV := ri.LTV;
  self.YrsThere_score := MAP( le.YrsThere_isnull or ri.YrsThere_isnull => 0,
                        le.YrsThere = ri.YrsThere  => le.YrsThere_weight100,
                        SALT20.Fn_Fail_Scale(le.YrsThere_weight100,s.YrsThere_switch));
  self.left_YrsThere := le.YrsThere;
  self.right_YrsThere := ri.YrsThere;
  self.employer_score := MAP( le.employer_isnull or ri.employer_isnull => 0,
                        le.employer = ri.employer  => le.employer_weight100,
                        SALT20.Fn_Fail_Scale(le.employer_weight100,s.employer_switch));
  self.left_employer := le.employer;
  self.right_employer := ri.employer;
  self.credit_score := MAP( le.credit_isnull or ri.credit_isnull => 0,
                        le.credit = ri.credit  => le.credit_weight100,
                        SALT20.Fn_Fail_Scale(le.credit_weight100,s.credit_switch));
  self.left_credit := le.credit;
  self.right_credit := ri.credit;
  self.Income_score := MAP( le.Income_isnull or ri.Income_isnull => 0,
                        le.Income = ri.Income  => le.Income_weight100,
                        SALT20.Fn_Fail_Scale(le.Income_weight100,s.Income_switch));
  self.left_Income := le.Income;
  self.right_Income := ri.Income;
  self.LoanAmt_score := MAP( le.LoanAmt_isnull or ri.LoanAmt_isnull => 0,
                        le.LoanAmt = ri.LoanAmt  => le.LoanAmt_weight100,
                        SALT20.Fn_Fail_Scale(le.LoanAmt_weight100,s.LoanAmt_switch));
  self.left_LoanAmt := le.LoanAmt;
  self.right_LoanAmt := ri.LoanAmt;
  self.dt_score := MAP( le.dt_isnull or ri.dt_isnull => 0,
                        le.dt = ri.dt  => le.dt_weight100,
                        SALT20.Fn_Fail_Scale(le.dt_weight100,s.dt_switch));
  self.left_dt := le.dt;
  self.right_dt := ri.dt;
  self.ip_score := MAP( le.ip_isnull or ri.ip_isnull => 0,
                        le.ip = ri.ip  => le.ip_weight100,
                        SALT20.Fn_Fail_Scale(le.ip_weight100,s.ip_switch));
  self.left_ip := le.ip;
  self.right_ip := ri.ip;
  self.Conf_Prop := (0
  ) / 100; // Score based on propogated fields
  self.Conf := (self.fname_score + self.lname_score + self.addr_score + self.city_score + self.state_score + self.zip_score + self.zip4_score + self.EMAIL_score + self.phone_score + self.LoanType_score + self.BESTTIME_score + self.MortRate_score + self.PROPERTYTYPE_score + self.RateType_score + self.LTV_score + self.YrsThere_score + self.employer_score + self.credit_score + self.Income_score + self.LoanAmt_score + self.dt_score + self.ip_score) / 100 + outside;
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
  dataset(SALT20.Layout_FieldValueList) fname_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) lname_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) addr_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) city_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) state_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) zip_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) zip4_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) EMAIL_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) phone_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) LoanType_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) BESTTIME_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) MortRate_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) PROPERTYTYPE_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) RateType_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) LTV_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) YrsThere_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) employer_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) credit_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) Income_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) LoanAmt_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) dt_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) ip_Values := dataset([],SALT20.Layout_FieldValueList);
end;
shared RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := transform
  self. := le.;
  self.fname_values := SALT20.fn_combine_fieldvaluelist(le.fname_values,ri.fname_values);
  self.lname_values := SALT20.fn_combine_fieldvaluelist(le.lname_values,ri.lname_values);
  self.addr_values := SALT20.fn_combine_fieldvaluelist(le.addr_values,ri.addr_values);
  self.city_values := SALT20.fn_combine_fieldvaluelist(le.city_values,ri.city_values);
  self.state_values := SALT20.fn_combine_fieldvaluelist(le.state_values,ri.state_values);
  self.zip_values := SALT20.fn_combine_fieldvaluelist(le.zip_values,ri.zip_values);
  self.zip4_values := SALT20.fn_combine_fieldvaluelist(le.zip4_values,ri.zip4_values);
  self.EMAIL_values := SALT20.fn_combine_fieldvaluelist(le.EMAIL_values,ri.EMAIL_values);
  self.phone_values := SALT20.fn_combine_fieldvaluelist(le.phone_values,ri.phone_values);
  self.LoanType_values := SALT20.fn_combine_fieldvaluelist(le.LoanType_values,ri.LoanType_values);
  self.BESTTIME_values := SALT20.fn_combine_fieldvaluelist(le.BESTTIME_values,ri.BESTTIME_values);
  self.MortRate_values := SALT20.fn_combine_fieldvaluelist(le.MortRate_values,ri.MortRate_values);
  self.PROPERTYTYPE_values := SALT20.fn_combine_fieldvaluelist(le.PROPERTYTYPE_values,ri.PROPERTYTYPE_values);
  self.RateType_values := SALT20.fn_combine_fieldvaluelist(le.RateType_values,ri.RateType_values);
  self.LTV_values := SALT20.fn_combine_fieldvaluelist(le.LTV_values,ri.LTV_values);
  self.YrsThere_values := SALT20.fn_combine_fieldvaluelist(le.YrsThere_values,ri.YrsThere_values);
  self.employer_values := SALT20.fn_combine_fieldvaluelist(le.employer_values,ri.employer_values);
  self.credit_values := SALT20.fn_combine_fieldvaluelist(le.credit_values,ri.credit_values);
  self.Income_values := SALT20.fn_combine_fieldvaluelist(le.Income_values,ri.Income_values);
  self.LoanAmt_values := SALT20.fn_combine_fieldvaluelist(le.LoanAmt_values,ri.LoanAmt_values);
  self.dt_values := SALT20.fn_combine_fieldvaluelist(le.dt_values,ri.dt_values);
  self.ip_values := SALT20.fn_combine_fieldvaluelist(le.ip_values,ri.ip_values);
end;
  return rollup( sort( distribute( infile, hash() ), , local ), left. = right., RollValues(left,right),local);
end;
export RolledEntities(dataset(match_candidates(ih).layout_candidates) in_data) := function
Layout_RolledEntity into(in_data le) := transform
  self. := le.;
  self.fname_Values := IF ( le.fname  IN SET(s.nulls_fname,fname),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.fname)}],SALT20.Layout_FieldValueList));
  self.lname_Values := IF ( le.lname  IN SET(s.nulls_lname,lname),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.lname)}],SALT20.Layout_FieldValueList));
  self.addr_Values := IF ( le.addr  IN SET(s.nulls_addr,addr),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.addr)}],SALT20.Layout_FieldValueList));
  self.city_Values := IF ( le.city  IN SET(s.nulls_city,city),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.city)}],SALT20.Layout_FieldValueList));
  self.state_Values := IF ( le.state  IN SET(s.nulls_state,state),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.state)}],SALT20.Layout_FieldValueList));
  self.zip_Values := IF ( le.zip  IN SET(s.nulls_zip,zip),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.zip)}],SALT20.Layout_FieldValueList));
  self.zip4_Values := IF ( le.zip4  IN SET(s.nulls_zip4,zip4),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.zip4)}],SALT20.Layout_FieldValueList));
  self.EMAIL_Values := IF ( le.EMAIL  IN SET(s.nulls_EMAIL,EMAIL),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.EMAIL)}],SALT20.Layout_FieldValueList));
  self.phone_Values := IF ( le.phone  IN SET(s.nulls_phone,phone),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.phone)}],SALT20.Layout_FieldValueList));
  self.LoanType_Values := IF ( le.LoanType  IN SET(s.nulls_LoanType,LoanType),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.LoanType)}],SALT20.Layout_FieldValueList));
  self.BESTTIME_Values := IF ( le.BESTTIME  IN SET(s.nulls_BESTTIME,BESTTIME),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.BESTTIME)}],SALT20.Layout_FieldValueList));
  self.MortRate_Values := IF ( le.MortRate  IN SET(s.nulls_MortRate,MortRate),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.MortRate)}],SALT20.Layout_FieldValueList));
  self.PROPERTYTYPE_Values := IF ( le.PROPERTYTYPE  IN SET(s.nulls_PROPERTYTYPE,PROPERTYTYPE),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.PROPERTYTYPE)}],SALT20.Layout_FieldValueList));
  self.RateType_Values := IF ( le.RateType  IN SET(s.nulls_RateType,RateType),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.RateType)}],SALT20.Layout_FieldValueList));
  self.LTV_Values := IF ( le.LTV  IN SET(s.nulls_LTV,LTV),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.LTV)}],SALT20.Layout_FieldValueList));
  self.YrsThere_Values := IF ( le.YrsThere  IN SET(s.nulls_YrsThere,YrsThere),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.YrsThere)}],SALT20.Layout_FieldValueList));
  self.employer_Values := IF ( le.employer  IN SET(s.nulls_employer,employer),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.employer)}],SALT20.Layout_FieldValueList));
  self.credit_Values := IF ( le.credit  IN SET(s.nulls_credit,credit),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.credit)}],SALT20.Layout_FieldValueList));
  self.Income_Values := IF ( le.Income  IN SET(s.nulls_Income,Income),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.Income)}],SALT20.Layout_FieldValueList));
  self.LoanAmt_Values := IF ( le.LoanAmt  IN SET(s.nulls_LoanAmt,LoanAmt),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.LoanAmt)}],SALT20.Layout_FieldValueList));
  self.dt_Values := IF ( le.dt  IN SET(s.nulls_dt,dt),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.dt)}],SALT20.Layout_FieldValueList));
  self.ip_Values := IF ( le.ip  IN SET(s.nulls_ip,ip),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.ip)}],SALT20.Layout_FieldValueList));
end;
AsFieldValues := project(in_data,into(left));
  return RollEntities(AsFieldValues);
end;
Layout_RolledEntity into(ih le) := transform
  self. := le.;
  self.fname_Values := IF ( le.fname  IN SET(s.nulls_fname,fname),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.fname)}],SALT20.Layout_FieldValueList));
  self.lname_Values := IF ( le.lname  IN SET(s.nulls_lname,lname),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.lname)}],SALT20.Layout_FieldValueList));
  self.addr_Values := IF ( le.addr  IN SET(s.nulls_addr,addr),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.addr)}],SALT20.Layout_FieldValueList));
  self.city_Values := IF ( le.city  IN SET(s.nulls_city,city),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.city)}],SALT20.Layout_FieldValueList));
  self.state_Values := IF ( le.state  IN SET(s.nulls_state,state),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.state)}],SALT20.Layout_FieldValueList));
  self.zip_Values := IF ( le.zip  IN SET(s.nulls_zip,zip),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.zip)}],SALT20.Layout_FieldValueList));
  self.zip4_Values := IF ( le.zip4  IN SET(s.nulls_zip4,zip4),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.zip4)}],SALT20.Layout_FieldValueList));
  self.EMAIL_Values := IF ( le.EMAIL  IN SET(s.nulls_EMAIL,EMAIL),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.EMAIL)}],SALT20.Layout_FieldValueList));
  self.phone_Values := IF ( le.phone  IN SET(s.nulls_phone,phone),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.phone)}],SALT20.Layout_FieldValueList));
  self.LoanType_Values := IF ( le.LoanType  IN SET(s.nulls_LoanType,LoanType),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.LoanType)}],SALT20.Layout_FieldValueList));
  self.BESTTIME_Values := IF ( le.BESTTIME  IN SET(s.nulls_BESTTIME,BESTTIME),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.BESTTIME)}],SALT20.Layout_FieldValueList));
  self.MortRate_Values := IF ( le.MortRate  IN SET(s.nulls_MortRate,MortRate),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.MortRate)}],SALT20.Layout_FieldValueList));
  self.PROPERTYTYPE_Values := IF ( le.PROPERTYTYPE  IN SET(s.nulls_PROPERTYTYPE,PROPERTYTYPE),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.PROPERTYTYPE)}],SALT20.Layout_FieldValueList));
  self.RateType_Values := IF ( le.RateType  IN SET(s.nulls_RateType,RateType),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.RateType)}],SALT20.Layout_FieldValueList));
  self.LTV_Values := IF ( le.LTV  IN SET(s.nulls_LTV,LTV),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.LTV)}],SALT20.Layout_FieldValueList));
  self.YrsThere_Values := IF ( le.YrsThere  IN SET(s.nulls_YrsThere,YrsThere),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.YrsThere)}],SALT20.Layout_FieldValueList));
  self.employer_Values := IF ( le.employer  IN SET(s.nulls_employer,employer),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.employer)}],SALT20.Layout_FieldValueList));
  self.credit_Values := IF ( le.credit  IN SET(s.nulls_credit,credit),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.credit)}],SALT20.Layout_FieldValueList));
  self.Income_Values := IF ( le.Income  IN SET(s.nulls_Income,Income),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.Income)}],SALT20.Layout_FieldValueList));
  self.LoanAmt_Values := IF ( le.LoanAmt  IN SET(s.nulls_LoanAmt,LoanAmt),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.LoanAmt)}],SALT20.Layout_FieldValueList));
  self.dt_Values := IF ( le.dt  IN SET(s.nulls_dt,dt),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.dt)}],SALT20.Layout_FieldValueList));
  self.ip_Values := IF ( le.ip  IN SET(s.nulls_ip,ip),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.ip)}],SALT20.Layout_FieldValueList));
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
  unsigned1 fname_size := 0;
  unsigned1 lname_size := 0;
  unsigned1 addr_size := 0;
  unsigned1 city_size := 0;
  unsigned1 state_size := 0;
  unsigned1 zip_size := 0;
  unsigned1 zip4_size := 0;
  unsigned1 EMAIL_size := 0;
  unsigned1 phone_size := 0;
  unsigned1 LoanType_size := 0;
  unsigned1 BESTTIME_size := 0;
  unsigned1 MortRate_size := 0;
  unsigned1 PROPERTYTYPE_size := 0;
  unsigned1 RateType_size := 0;
  unsigned1 LTV_size := 0;
  unsigned1 YrsThere_size := 0;
  unsigned1 employer_size := 0;
  unsigned1 credit_size := 0;
  unsigned1 Income_size := 0;
  unsigned1 LoanAmt_size := 0;
  unsigned1 dt_size := 0;
  unsigned1 ip_size := 0;
end;
t0 := table(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := transform
  SELF.fname_size := SALT20.Fn_SwitchSpec(s.fname_switch,count(le.fname_values));
  SELF.lname_size := SALT20.Fn_SwitchSpec(s.lname_switch,count(le.lname_values));
  SELF.addr_size := SALT20.Fn_SwitchSpec(s.addr_switch,count(le.addr_values));
  SELF.city_size := SALT20.Fn_SwitchSpec(s.city_switch,count(le.city_values));
  SELF.state_size := SALT20.Fn_SwitchSpec(s.state_switch,count(le.state_values));
  SELF.zip_size := SALT20.Fn_SwitchSpec(s.zip_switch,count(le.zip_values));
  SELF.zip4_size := SALT20.Fn_SwitchSpec(s.zip4_switch,count(le.zip4_values));
  SELF.EMAIL_size := SALT20.Fn_SwitchSpec(s.EMAIL_switch,count(le.EMAIL_values));
  SELF.phone_size := SALT20.Fn_SwitchSpec(s.phone_switch,count(le.phone_values));
  SELF.LoanType_size := SALT20.Fn_SwitchSpec(s.LoanType_switch,count(le.LoanType_values));
  SELF.BESTTIME_size := SALT20.Fn_SwitchSpec(s.BESTTIME_switch,count(le.BESTTIME_values));
  SELF.MortRate_size := SALT20.Fn_SwitchSpec(s.MortRate_switch,count(le.MortRate_values));
  SELF.PROPERTYTYPE_size := SALT20.Fn_SwitchSpec(s.PROPERTYTYPE_switch,count(le.PROPERTYTYPE_values));
  SELF.RateType_size := SALT20.Fn_SwitchSpec(s.RateType_switch,count(le.RateType_values));
  SELF.LTV_size := SALT20.Fn_SwitchSpec(s.LTV_switch,count(le.LTV_values));
  SELF.YrsThere_size := SALT20.Fn_SwitchSpec(s.YrsThere_switch,count(le.YrsThere_values));
  SELF.employer_size := SALT20.Fn_SwitchSpec(s.employer_switch,count(le.employer_values));
  SELF.credit_size := SALT20.Fn_SwitchSpec(s.credit_switch,count(le.credit_values));
  SELF.Income_size := SALT20.Fn_SwitchSpec(s.Income_switch,count(le.Income_values));
  SELF.LoanAmt_size := SALT20.Fn_SwitchSpec(s.LoanAmt_switch,count(le.LoanAmt_values));
  SELF.dt_size := SALT20.Fn_SwitchSpec(s.dt_switch,count(le.dt_values));
  SELF.ip_size := SALT20.Fn_SwitchSpec(s.ip_switch,count(le.ip_values));
  SELF := le;
end;  t := project(t0,NoteSize(left));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  unsigned2 Size := t.fname_size+t.lname_size+t.addr_size+t.city_size+t.state_size+t.zip_size+t.zip4_size+t.EMAIL_size+t.phone_size+t.LoanType_size+t.BESTTIME_size+t.MortRate_size+t.PROPERTYTYPE_size+t.RateType_size+t.LTV_size+t.YrsThere_size+t.employer_size+t.credit_size+t.Income_size+t.LoanAmt_size+t.dt_size+t.ip_size;
end;
export Chubbies := table(t,Layout_Chubbies);
end;
