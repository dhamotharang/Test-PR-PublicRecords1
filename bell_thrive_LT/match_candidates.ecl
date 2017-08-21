// Begin code to produce match candidates
import SALT20,ut;
export match_candidates(dataset(layout_files().input.used) ih) := module
shared s := Specificities(ih).Specificities[1];
h00 := Specificities(ih).input_file;
shared thin_table := table(h00,{fname,lname,addr,city,state,zip,zip4,EMAIL,phone,LoanType,BESTTIME,MortRate,PROPERTYTYPE,RateType,LTV,YrsThere,employer,credit,Income,LoanAmt,dt,ip,});// Already distributed by specificities module
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
  unsigned2 fname_weight100 := 0; // Contains 100x the specificity
  boolean fname_isnull := h0.fname  IN SET(s.nulls_fname,fname); // Simplify later processing 
  unsigned2 lname_weight100 := 0; // Contains 100x the specificity
  boolean lname_isnull := h0.lname  IN SET(s.nulls_lname,lname); // Simplify later processing 
  unsigned2 addr_weight100 := 0; // Contains 100x the specificity
  boolean addr_isnull := h0.addr  IN SET(s.nulls_addr,addr); // Simplify later processing 
  unsigned2 city_weight100 := 0; // Contains 100x the specificity
  boolean city_isnull := h0.city  IN SET(s.nulls_city,city); // Simplify later processing 
  unsigned2 state_weight100 := 0; // Contains 100x the specificity
  boolean state_isnull := h0.state  IN SET(s.nulls_state,state); // Simplify later processing 
  unsigned2 zip_weight100 := 0; // Contains 100x the specificity
  boolean zip_isnull := h0.zip  IN SET(s.nulls_zip,zip); // Simplify later processing 
  unsigned2 zip4_weight100 := 0; // Contains 100x the specificity
  boolean zip4_isnull := h0.zip4  IN SET(s.nulls_zip4,zip4); // Simplify later processing 
  unsigned2 EMAIL_weight100 := 0; // Contains 100x the specificity
  boolean EMAIL_isnull := h0.EMAIL  IN SET(s.nulls_EMAIL,EMAIL); // Simplify later processing 
  unsigned2 phone_weight100 := 0; // Contains 100x the specificity
  boolean phone_isnull := h0.phone  IN SET(s.nulls_phone,phone); // Simplify later processing 
  unsigned2 LoanType_weight100 := 0; // Contains 100x the specificity
  boolean LoanType_isnull := h0.LoanType  IN SET(s.nulls_LoanType,LoanType); // Simplify later processing 
  unsigned2 BESTTIME_weight100 := 0; // Contains 100x the specificity
  boolean BESTTIME_isnull := h0.BESTTIME  IN SET(s.nulls_BESTTIME,BESTTIME); // Simplify later processing 
  unsigned2 MortRate_weight100 := 0; // Contains 100x the specificity
  boolean MortRate_isnull := h0.MortRate  IN SET(s.nulls_MortRate,MortRate); // Simplify later processing 
  unsigned2 PROPERTYTYPE_weight100 := 0; // Contains 100x the specificity
  boolean PROPERTYTYPE_isnull := h0.PROPERTYTYPE  IN SET(s.nulls_PROPERTYTYPE,PROPERTYTYPE); // Simplify later processing 
  unsigned2 RateType_weight100 := 0; // Contains 100x the specificity
  boolean RateType_isnull := h0.RateType  IN SET(s.nulls_RateType,RateType); // Simplify later processing 
  unsigned2 LTV_weight100 := 0; // Contains 100x the specificity
  boolean LTV_isnull := h0.LTV  IN SET(s.nulls_LTV,LTV); // Simplify later processing 
  unsigned2 YrsThere_weight100 := 0; // Contains 100x the specificity
  boolean YrsThere_isnull := h0.YrsThere  IN SET(s.nulls_YrsThere,YrsThere); // Simplify later processing 
  unsigned2 employer_weight100 := 0; // Contains 100x the specificity
  boolean employer_isnull := h0.employer  IN SET(s.nulls_employer,employer); // Simplify later processing 
  unsigned2 credit_weight100 := 0; // Contains 100x the specificity
  boolean credit_isnull := h0.credit  IN SET(s.nulls_credit,credit); // Simplify later processing 
  unsigned2 Income_weight100 := 0; // Contains 100x the specificity
  boolean Income_isnull := h0.Income  IN SET(s.nulls_Income,Income); // Simplify later processing 
  unsigned2 LoanAmt_weight100 := 0; // Contains 100x the specificity
  boolean LoanAmt_isnull := h0.LoanAmt  IN SET(s.nulls_LoanAmt,LoanAmt); // Simplify later processing 
  unsigned2 dt_weight100 := 0; // Contains 100x the specificity
  boolean dt_isnull := h0.dt  IN SET(s.nulls_dt,dt); // Simplify later processing 
  unsigned2 ip_weight100 := 0; // Contains 100x the specificity
  boolean ip_isnull := h0.ip  IN SET(s.nulls_ip,ip); // Simplify later processing 
END;
h1 := TABLE(h0,layout_candidates);
//Now add the weights of each field one by one
//Would also create auto-id fields here
layout_candidates add_ip(layout_candidates le,Specificities(ih).ip_values_persisted ri,boolean patch_default) := transform
  self.ip_weight100 := MAP (le.ip_isnull => 0, patch_default and ri.field_specificity=0 => s.ip_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j21 := join(h1,PULL(Specificities(ih).ip_values_persisted),left.ip=right.ip,add_ip(left,right,true),lookup,left outer);
layout_candidates add_dt(layout_candidates le,Specificities(ih).dt_values_persisted ri,boolean patch_default) := transform
  self.dt_weight100 := MAP (le.dt_isnull => 0, patch_default and ri.field_specificity=0 => s.dt_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j20 := join(j21,PULL(Specificities(ih).dt_values_persisted),left.dt=right.dt,add_dt(left,right,true),lookup,left outer);
layout_candidates add_LoanAmt(layout_candidates le,Specificities(ih).LoanAmt_values_persisted ri,boolean patch_default) := transform
  self.LoanAmt_weight100 := MAP (le.LoanAmt_isnull => 0, patch_default and ri.field_specificity=0 => s.LoanAmt_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j19 := join(j20,PULL(Specificities(ih).LoanAmt_values_persisted),left.LoanAmt=right.LoanAmt,add_LoanAmt(left,right,true),lookup,left outer);
layout_candidates add_Income(layout_candidates le,Specificities(ih).Income_values_persisted ri,boolean patch_default) := transform
  self.Income_weight100 := MAP (le.Income_isnull => 0, patch_default and ri.field_specificity=0 => s.Income_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j18 := join(j19,PULL(Specificities(ih).Income_values_persisted),left.Income=right.Income,add_Income(left,right,true),lookup,left outer);
layout_candidates add_credit(layout_candidates le,Specificities(ih).credit_values_persisted ri,boolean patch_default) := transform
  self.credit_weight100 := MAP (le.credit_isnull => 0, patch_default and ri.field_specificity=0 => s.credit_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j17 := join(j18,PULL(Specificities(ih).credit_values_persisted),left.credit=right.credit,add_credit(left,right,true),lookup,left outer);
layout_candidates add_employer(layout_candidates le,Specificities(ih).employer_values_persisted ri,boolean patch_default) := transform
  self.employer_weight100 := MAP (le.employer_isnull => 0, patch_default and ri.field_specificity=0 => s.employer_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j16 := join(j17,PULL(Specificities(ih).employer_values_persisted),left.employer=right.employer,add_employer(left,right,true),lookup,left outer);
layout_candidates add_YrsThere(layout_candidates le,Specificities(ih).YrsThere_values_persisted ri,boolean patch_default) := transform
  self.YrsThere_weight100 := MAP (le.YrsThere_isnull => 0, patch_default and ri.field_specificity=0 => s.YrsThere_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j15 := join(j16,PULL(Specificities(ih).YrsThere_values_persisted),left.YrsThere=right.YrsThere,add_YrsThere(left,right,true),lookup,left outer);
layout_candidates add_LTV(layout_candidates le,Specificities(ih).LTV_values_persisted ri,boolean patch_default) := transform
  self.LTV_weight100 := MAP (le.LTV_isnull => 0, patch_default and ri.field_specificity=0 => s.LTV_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j14 := join(j15,PULL(Specificities(ih).LTV_values_persisted),left.LTV=right.LTV,add_LTV(left,right,true),lookup,left outer);
layout_candidates add_RateType(layout_candidates le,Specificities(ih).RateType_values_persisted ri,boolean patch_default) := transform
  self.RateType_weight100 := MAP (le.RateType_isnull => 0, patch_default and ri.field_specificity=0 => s.RateType_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j13 := join(j14,PULL(Specificities(ih).RateType_values_persisted),left.RateType=right.RateType,add_RateType(left,right,true),lookup,left outer);
layout_candidates add_PROPERTYTYPE(layout_candidates le,Specificities(ih).PROPERTYTYPE_values_persisted ri,boolean patch_default) := transform
  self.PROPERTYTYPE_weight100 := MAP (le.PROPERTYTYPE_isnull => 0, patch_default and ri.field_specificity=0 => s.PROPERTYTYPE_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j12 := join(j13,PULL(Specificities(ih).PROPERTYTYPE_values_persisted),left.PROPERTYTYPE=right.PROPERTYTYPE,add_PROPERTYTYPE(left,right,true),lookup,left outer);
layout_candidates add_MortRate(layout_candidates le,Specificities(ih).MortRate_values_persisted ri,boolean patch_default) := transform
  self.MortRate_weight100 := MAP (le.MortRate_isnull => 0, patch_default and ri.field_specificity=0 => s.MortRate_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j11 := join(j12,PULL(Specificities(ih).MortRate_values_persisted),left.MortRate=right.MortRate,add_MortRate(left,right,true),lookup,left outer);
layout_candidates add_BESTTIME(layout_candidates le,Specificities(ih).BESTTIME_values_persisted ri,boolean patch_default) := transform
  self.BESTTIME_weight100 := MAP (le.BESTTIME_isnull => 0, patch_default and ri.field_specificity=0 => s.BESTTIME_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j10 := join(j11,PULL(Specificities(ih).BESTTIME_values_persisted),left.BESTTIME=right.BESTTIME,add_BESTTIME(left,right,true),lookup,left outer);
layout_candidates add_LoanType(layout_candidates le,Specificities(ih).LoanType_values_persisted ri,boolean patch_default) := transform
  self.LoanType_weight100 := MAP (le.LoanType_isnull => 0, patch_default and ri.field_specificity=0 => s.LoanType_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j9 := join(j10,PULL(Specificities(ih).LoanType_values_persisted),left.LoanType=right.LoanType,add_LoanType(left,right,true),lookup,left outer);
layout_candidates add_phone(layout_candidates le,Specificities(ih).phone_values_persisted ri,boolean patch_default) := transform
  self.phone_weight100 := MAP (le.phone_isnull => 0, patch_default and ri.field_specificity=0 => s.phone_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j8 := join(j9,PULL(Specificities(ih).phone_values_persisted),left.phone=right.phone,add_phone(left,right,true),lookup,left outer);
layout_candidates add_EMAIL(layout_candidates le,Specificities(ih).EMAIL_values_persisted ri,boolean patch_default) := transform
  self.EMAIL_weight100 := MAP (le.EMAIL_isnull => 0, patch_default and ri.field_specificity=0 => s.EMAIL_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j7 := join(j8,PULL(Specificities(ih).EMAIL_values_persisted),left.EMAIL=right.EMAIL,add_EMAIL(left,right,true),lookup,left outer);
layout_candidates add_zip4(layout_candidates le,Specificities(ih).zip4_values_persisted ri,boolean patch_default) := transform
  self.zip4_weight100 := MAP (le.zip4_isnull => 0, patch_default and ri.field_specificity=0 => s.zip4_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j6 := join(j7,PULL(Specificities(ih).zip4_values_persisted),left.zip4=right.zip4,add_zip4(left,right,true),lookup,left outer);
layout_candidates add_zip(layout_candidates le,Specificities(ih).zip_values_persisted ri,boolean patch_default) := transform
  self.zip_weight100 := MAP (le.zip_isnull => 0, patch_default and ri.field_specificity=0 => s.zip_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j5 := join(j6,PULL(Specificities(ih).zip_values_persisted),left.zip=right.zip,add_zip(left,right,true),lookup,left outer);
layout_candidates add_state(layout_candidates le,Specificities(ih).state_values_persisted ri,boolean patch_default) := transform
  self.state_weight100 := MAP (le.state_isnull => 0, patch_default and ri.field_specificity=0 => s.state_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j4 := join(j5,PULL(Specificities(ih).state_values_persisted),left.state=right.state,add_state(left,right,true),lookup,left outer);
layout_candidates add_city(layout_candidates le,Specificities(ih).city_values_persisted ri,boolean patch_default) := transform
  self.city_weight100 := MAP (le.city_isnull => 0, patch_default and ri.field_specificity=0 => s.city_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j3 := join(j4,PULL(Specificities(ih).city_values_persisted),left.city=right.city,add_city(left,right,true),lookup,left outer);
layout_candidates add_addr(layout_candidates le,Specificities(ih).addr_values_persisted ri,boolean patch_default) := transform
  self.addr_weight100 := MAP (le.addr_isnull => 0, patch_default and ri.field_specificity=0 => s.addr_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j2 := join(j3,PULL(Specificities(ih).addr_values_persisted),left.addr=right.addr,add_addr(left,right,true),lookup,left outer);
layout_candidates add_lname(layout_candidates le,Specificities(ih).lname_values_persisted ri,boolean patch_default) := transform
  self.lname_weight100 := MAP (le.lname_isnull => 0, patch_default and ri.field_specificity=0 => s.lname_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j1 := join(j2,PULL(Specificities(ih).lname_values_persisted),left.lname=right.lname,add_lname(left,right,true),lookup,left outer);
layout_candidates add_fname(layout_candidates le,Specificities(ih).fname_values_persisted ri,boolean patch_default) := transform
  self.fname_weight100 := MAP (le.fname_isnull => 0, patch_default and ri.field_specificity=0 => s.fname_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j0 := join(j1,PULL(Specificities(ih).fname_values_persisted),left.fname=right.fname,add_fname(left,right,true),lookup,left outer);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j0,hash()) : PERSIST('temp::bell_thrive_LT_files().input.used_mc'); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.fname_weight100 + Annotated.lname_weight100 + Annotated.addr_weight100 + Annotated.city_weight100 + Annotated.state_weight100 + Annotated.zip_weight100 + Annotated.zip4_weight100 + Annotated.EMAIL_weight100 + Annotated.phone_weight100 + Annotated.LoanType_weight100 + Annotated.BESTTIME_weight100 + Annotated.MortRate_weight100 + Annotated.PROPERTYTYPE_weight100 + Annotated.RateType_weight100 + Annotated.LTV_weight100 + Annotated.YrsThere_weight100 + Annotated.employer_weight100 + Annotated.credit_weight100 + Annotated.Income_weight100 + Annotated.LoanAmt_weight100 + Annotated.dt_weight100 + Annotated.ip_weight100;
SHARED Linkable := TotalWeight >= 0;
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(Linkable); //No point in trying to link records with too little data
END;
+++Line:24:RIDField is now compulsory for full adl matching!!!
