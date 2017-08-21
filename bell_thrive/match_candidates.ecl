// Begin code to produce match candidates
import SALT20,ut;
export match_candidates(dataset(layout_files().input.used) ih) := module
shared s := Specificities(ih).Specificities[1];
h00 := Specificities(ih).input_file;
shared thin_table := table(h00,{id,fname,lname,dob,Own_Home,dlnum,State_Of_License,addr,city,st,zip,Phone_Home,Phone_Cell,Phone_Work,EMAIL,ip,dt,INCOME_MONTHLY,Weekly_BiWeekly,MONTHSEMPLOYED,MonthsAtBank,employer,Bank,});// Already distributed by specificities module
SHARED h0 := DEDUP( SORT ( DISTRIBUTE(thin_table,HASH()), WHOLE RECORD, LOCAL ), WHOLE RECORD, LOCAL );// Only one copy of each record
EXPORT Layout_Matches := RECORD//in this module for because of ,foward bug
  unsigned2 Rule;
  integer2 Conf;
  integer2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  integer2 Conf_Prop; // Confidense provided by propogated fields
  SALT20.UIDType 1;
  SALT20.UIDType 2;
END;
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0};
  unsigned2 id_weight100 := 0; // Contains 100x the specificity
  boolean id_isnull := h0.id  IN SET(s.nulls_id,id); // Simplify later processing 
  unsigned2 fname_weight100 := 0; // Contains 100x the specificity
  boolean fname_isnull := h0.fname  IN SET(s.nulls_fname,fname); // Simplify later processing 
  unsigned2 lname_weight100 := 0; // Contains 100x the specificity
  boolean lname_isnull := h0.lname  IN SET(s.nulls_lname,lname); // Simplify later processing 
  unsigned2 dob_weight100 := 0; // Contains 100x the specificity
  boolean dob_isnull := h0.dob  IN SET(s.nulls_dob,dob); // Simplify later processing 
  unsigned2 Own_Home_weight100 := 0; // Contains 100x the specificity
  boolean Own_Home_isnull := h0.Own_Home  IN SET(s.nulls_Own_Home,Own_Home); // Simplify later processing 
  unsigned2 dlnum_weight100 := 0; // Contains 100x the specificity
  boolean dlnum_isnull := h0.dlnum  IN SET(s.nulls_dlnum,dlnum); // Simplify later processing 
  unsigned2 State_Of_License_weight100 := 0; // Contains 100x the specificity
  boolean State_Of_License_isnull := h0.State_Of_License  IN SET(s.nulls_State_Of_License,State_Of_License); // Simplify later processing 
  unsigned2 addr_weight100 := 0; // Contains 100x the specificity
  boolean addr_isnull := h0.addr  IN SET(s.nulls_addr,addr); // Simplify later processing 
  unsigned2 city_weight100 := 0; // Contains 100x the specificity
  boolean city_isnull := h0.city  IN SET(s.nulls_city,city); // Simplify later processing 
  unsigned2 st_weight100 := 0; // Contains 100x the specificity
  boolean st_isnull := h0.st  IN SET(s.nulls_st,st); // Simplify later processing 
  unsigned2 zip_weight100 := 0; // Contains 100x the specificity
  boolean zip_isnull := h0.zip  IN SET(s.nulls_zip,zip); // Simplify later processing 
  unsigned2 Phone_Home_weight100 := 0; // Contains 100x the specificity
  boolean Phone_Home_isnull := h0.Phone_Home  IN SET(s.nulls_Phone_Home,Phone_Home); // Simplify later processing 
  unsigned2 Phone_Cell_weight100 := 0; // Contains 100x the specificity
  boolean Phone_Cell_isnull := h0.Phone_Cell  IN SET(s.nulls_Phone_Cell,Phone_Cell); // Simplify later processing 
  unsigned2 Phone_Work_weight100 := 0; // Contains 100x the specificity
  boolean Phone_Work_isnull := h0.Phone_Work  IN SET(s.nulls_Phone_Work,Phone_Work); // Simplify later processing 
  unsigned2 EMAIL_weight100 := 0; // Contains 100x the specificity
  boolean EMAIL_isnull := h0.EMAIL  IN SET(s.nulls_EMAIL,EMAIL); // Simplify later processing 
  unsigned2 ip_weight100 := 0; // Contains 100x the specificity
  boolean ip_isnull := h0.ip  IN SET(s.nulls_ip,ip); // Simplify later processing 
  unsigned2 dt_weight100 := 0; // Contains 100x the specificity
  boolean dt_isnull := h0.dt  IN SET(s.nulls_dt,dt); // Simplify later processing 
  unsigned2 INCOME_MONTHLY_weight100 := 0; // Contains 100x the specificity
  boolean INCOME_MONTHLY_isnull := h0.INCOME_MONTHLY  IN SET(s.nulls_INCOME_MONTHLY,INCOME_MONTHLY); // Simplify later processing 
  unsigned2 Weekly_BiWeekly_weight100 := 0; // Contains 100x the specificity
  boolean Weekly_BiWeekly_isnull := h0.Weekly_BiWeekly  IN SET(s.nulls_Weekly_BiWeekly,Weekly_BiWeekly); // Simplify later processing 
  unsigned2 MONTHSEMPLOYED_weight100 := 0; // Contains 100x the specificity
  boolean MONTHSEMPLOYED_isnull := h0.MONTHSEMPLOYED  IN SET(s.nulls_MONTHSEMPLOYED,MONTHSEMPLOYED); // Simplify later processing 
  unsigned2 MonthsAtBank_weight100 := 0; // Contains 100x the specificity
  boolean MonthsAtBank_isnull := h0.MonthsAtBank  IN SET(s.nulls_MonthsAtBank,MonthsAtBank); // Simplify later processing 
  unsigned2 employer_weight100 := 0; // Contains 100x the specificity
  boolean employer_isnull := h0.employer  IN SET(s.nulls_employer,employer); // Simplify later processing 
  unsigned2 Bank_weight100 := 0; // Contains 100x the specificity
  boolean Bank_isnull := h0.Bank  IN SET(s.nulls_Bank,Bank); // Simplify later processing 
END;
h1 := TABLE(h0,layout_candidates);
//Now add the weights of each field one by one
//Would also create auto-id fields here
layout_candidates add_Bank(layout_candidates le,Specificities(ih).Bank_values_persisted ri,boolean patch_default) := transform
  self.Bank_weight100 := MAP (le.Bank_isnull => 0, patch_default and ri.field_specificity=0 => s.Bank_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j22 := join(h1,PULL(Specificities(ih).Bank_values_persisted),left.Bank=right.Bank,add_Bank(left,right,true),lookup,left outer);
layout_candidates add_employer(layout_candidates le,Specificities(ih).employer_values_persisted ri,boolean patch_default) := transform
  self.employer_weight100 := MAP (le.employer_isnull => 0, patch_default and ri.field_specificity=0 => s.employer_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j21 := join(j22,PULL(Specificities(ih).employer_values_persisted),left.employer=right.employer,add_employer(left,right,true),lookup,left outer);
layout_candidates add_MonthsAtBank(layout_candidates le,Specificities(ih).MonthsAtBank_values_persisted ri,boolean patch_default) := transform
  self.MonthsAtBank_weight100 := MAP (le.MonthsAtBank_isnull => 0, patch_default and ri.field_specificity=0 => s.MonthsAtBank_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j20 := join(j21,PULL(Specificities(ih).MonthsAtBank_values_persisted),left.MonthsAtBank=right.MonthsAtBank,add_MonthsAtBank(left,right,true),lookup,left outer);
layout_candidates add_MONTHSEMPLOYED(layout_candidates le,Specificities(ih).MONTHSEMPLOYED_values_persisted ri,boolean patch_default) := transform
  self.MONTHSEMPLOYED_weight100 := MAP (le.MONTHSEMPLOYED_isnull => 0, patch_default and ri.field_specificity=0 => s.MONTHSEMPLOYED_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j19 := join(j20,PULL(Specificities(ih).MONTHSEMPLOYED_values_persisted),left.MONTHSEMPLOYED=right.MONTHSEMPLOYED,add_MONTHSEMPLOYED(left,right,true),lookup,left outer);
layout_candidates add_Weekly_BiWeekly(layout_candidates le,Specificities(ih).Weekly_BiWeekly_values_persisted ri,boolean patch_default) := transform
  self.Weekly_BiWeekly_weight100 := MAP (le.Weekly_BiWeekly_isnull => 0, patch_default and ri.field_specificity=0 => s.Weekly_BiWeekly_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j18 := join(j19,PULL(Specificities(ih).Weekly_BiWeekly_values_persisted),left.Weekly_BiWeekly=right.Weekly_BiWeekly,add_Weekly_BiWeekly(left,right,true),lookup,left outer);
layout_candidates add_INCOME_MONTHLY(layout_candidates le,Specificities(ih).INCOME_MONTHLY_values_persisted ri,boolean patch_default) := transform
  self.INCOME_MONTHLY_weight100 := MAP (le.INCOME_MONTHLY_isnull => 0, patch_default and ri.field_specificity=0 => s.INCOME_MONTHLY_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j17 := join(j18,PULL(Specificities(ih).INCOME_MONTHLY_values_persisted),left.INCOME_MONTHLY=right.INCOME_MONTHLY,add_INCOME_MONTHLY(left,right,true),lookup,left outer);
layout_candidates add_dt(layout_candidates le,Specificities(ih).dt_values_persisted ri,boolean patch_default) := transform
  self.dt_weight100 := MAP (le.dt_isnull => 0, patch_default and ri.field_specificity=0 => s.dt_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j16 := join(j17,PULL(Specificities(ih).dt_values_persisted),left.dt=right.dt,add_dt(left,right,true),lookup,left outer);
layout_candidates add_ip(layout_candidates le,Specificities(ih).ip_values_persisted ri,boolean patch_default) := transform
  self.ip_weight100 := MAP (le.ip_isnull => 0, patch_default and ri.field_specificity=0 => s.ip_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j15 := join(j16,PULL(Specificities(ih).ip_values_persisted),left.ip=right.ip,add_ip(left,right,true),lookup,left outer);
layout_candidates add_EMAIL(layout_candidates le,Specificities(ih).EMAIL_values_persisted ri,boolean patch_default) := transform
  self.EMAIL_weight100 := MAP (le.EMAIL_isnull => 0, patch_default and ri.field_specificity=0 => s.EMAIL_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j14 := join(j15,PULL(Specificities(ih).EMAIL_values_persisted),left.EMAIL=right.EMAIL,add_EMAIL(left,right,true),lookup,left outer);
layout_candidates add_Phone_Work(layout_candidates le,Specificities(ih).Phone_Work_values_persisted ri,boolean patch_default) := transform
  self.Phone_Work_weight100 := MAP (le.Phone_Work_isnull => 0, patch_default and ri.field_specificity=0 => s.Phone_Work_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j13 := join(j14,PULL(Specificities(ih).Phone_Work_values_persisted),left.Phone_Work=right.Phone_Work,add_Phone_Work(left,right,true),lookup,left outer);
layout_candidates add_Phone_Cell(layout_candidates le,Specificities(ih).Phone_Cell_values_persisted ri,boolean patch_default) := transform
  self.Phone_Cell_weight100 := MAP (le.Phone_Cell_isnull => 0, patch_default and ri.field_specificity=0 => s.Phone_Cell_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j12 := join(j13,PULL(Specificities(ih).Phone_Cell_values_persisted),left.Phone_Cell=right.Phone_Cell,add_Phone_Cell(left,right,true),lookup,left outer);
layout_candidates add_Phone_Home(layout_candidates le,Specificities(ih).Phone_Home_values_persisted ri,boolean patch_default) := transform
  self.Phone_Home_weight100 := MAP (le.Phone_Home_isnull => 0, patch_default and ri.field_specificity=0 => s.Phone_Home_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j11 := join(j12,PULL(Specificities(ih).Phone_Home_values_persisted),left.Phone_Home=right.Phone_Home,add_Phone_Home(left,right,true),lookup,left outer);
layout_candidates add_zip(layout_candidates le,Specificities(ih).zip_values_persisted ri,boolean patch_default) := transform
  self.zip_weight100 := MAP (le.zip_isnull => 0, patch_default and ri.field_specificity=0 => s.zip_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j10 := join(j11,PULL(Specificities(ih).zip_values_persisted),left.zip=right.zip,add_zip(left,right,true),lookup,left outer);
layout_candidates add_st(layout_candidates le,Specificities(ih).st_values_persisted ri,boolean patch_default) := transform
  self.st_weight100 := MAP (le.st_isnull => 0, patch_default and ri.field_specificity=0 => s.st_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j9 := join(j10,PULL(Specificities(ih).st_values_persisted),left.st=right.st,add_st(left,right,true),lookup,left outer);
layout_candidates add_city(layout_candidates le,Specificities(ih).city_values_persisted ri,boolean patch_default) := transform
  self.city_weight100 := MAP (le.city_isnull => 0, patch_default and ri.field_specificity=0 => s.city_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j8 := join(j9,PULL(Specificities(ih).city_values_persisted),left.city=right.city,add_city(left,right,true),lookup,left outer);
layout_candidates add_addr(layout_candidates le,Specificities(ih).addr_values_persisted ri,boolean patch_default) := transform
  self.addr_weight100 := MAP (le.addr_isnull => 0, patch_default and ri.field_specificity=0 => s.addr_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j7 := join(j8,PULL(Specificities(ih).addr_values_persisted),left.addr=right.addr,add_addr(left,right,true),lookup,left outer);
layout_candidates add_State_Of_License(layout_candidates le,Specificities(ih).State_Of_License_values_persisted ri,boolean patch_default) := transform
  self.State_Of_License_weight100 := MAP (le.State_Of_License_isnull => 0, patch_default and ri.field_specificity=0 => s.State_Of_License_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j6 := join(j7,PULL(Specificities(ih).State_Of_License_values_persisted),left.State_Of_License=right.State_Of_License,add_State_Of_License(left,right,true),lookup,left outer);
layout_candidates add_dlnum(layout_candidates le,Specificities(ih).dlnum_values_persisted ri,boolean patch_default) := transform
  self.dlnum_weight100 := MAP (le.dlnum_isnull => 0, patch_default and ri.field_specificity=0 => s.dlnum_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j5 := join(j6,PULL(Specificities(ih).dlnum_values_persisted),left.dlnum=right.dlnum,add_dlnum(left,right,true),lookup,left outer);
layout_candidates add_Own_Home(layout_candidates le,Specificities(ih).Own_Home_values_persisted ri,boolean patch_default) := transform
  self.Own_Home_weight100 := MAP (le.Own_Home_isnull => 0, patch_default and ri.field_specificity=0 => s.Own_Home_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j4 := join(j5,PULL(Specificities(ih).Own_Home_values_persisted),left.Own_Home=right.Own_Home,add_Own_Home(left,right,true),lookup,left outer);
layout_candidates add_dob(layout_candidates le,Specificities(ih).dob_values_persisted ri,boolean patch_default) := transform
  self.dob_weight100 := MAP (le.dob_isnull => 0, patch_default and ri.field_specificity=0 => s.dob_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j3 := join(j4,PULL(Specificities(ih).dob_values_persisted),left.dob=right.dob,add_dob(left,right,true),lookup,left outer);
layout_candidates add_lname(layout_candidates le,Specificities(ih).lname_values_persisted ri,boolean patch_default) := transform
  self.lname_weight100 := MAP (le.lname_isnull => 0, patch_default and ri.field_specificity=0 => s.lname_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j2 := join(j3,PULL(Specificities(ih).lname_values_persisted),left.lname=right.lname,add_lname(left,right,true),lookup,left outer);
layout_candidates add_fname(layout_candidates le,Specificities(ih).fname_values_persisted ri,boolean patch_default) := transform
  self.fname_weight100 := MAP (le.fname_isnull => 0, patch_default and ri.field_specificity=0 => s.fname_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j1 := join(j2,PULL(Specificities(ih).fname_values_persisted),left.fname=right.fname,add_fname(left,right,true),lookup,left outer);
layout_candidates add_id(layout_candidates le,Specificities(ih).id_values_persisted ri,boolean patch_default) := transform
  self.id_weight100 := MAP (le.id_isnull => 0, patch_default and ri.field_specificity=0 => s.id_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j0 := join(j1,PULL(Specificities(ih).id_values_persisted),left.id=right.id,add_id(left,right,true),lookup,left outer);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j0,hash()) : PERSIST('temp::bell_thrive_files().input.used_mc'); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.id_weight100 + Annotated.fname_weight100 + Annotated.lname_weight100 + Annotated.dob_weight100 + Annotated.Own_Home_weight100 + Annotated.dlnum_weight100 + Annotated.State_Of_License_weight100 + Annotated.addr_weight100 + Annotated.city_weight100 + Annotated.st_weight100 + Annotated.zip_weight100 + Annotated.Phone_Home_weight100 + Annotated.Phone_Cell_weight100 + Annotated.Phone_Work_weight100 + Annotated.EMAIL_weight100 + Annotated.ip_weight100 + Annotated.dt_weight100 + Annotated.INCOME_MONTHLY_weight100 + Annotated.Weekly_BiWeekly_weight100 + Annotated.MONTHSEMPLOYED_weight100 + Annotated.MonthsAtBank_weight100 + Annotated.employer_weight100 + Annotated.Bank_weight100;
SHARED Linkable := TotalWeight >= 0;
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(Linkable); //No point in trying to link records with too little data
END;
+++Line:25:RIDField is now compulsory for full adl matching!!!
