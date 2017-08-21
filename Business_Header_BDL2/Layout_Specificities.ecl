//Layout_Specificities

export Layout_Specificities := module
shared L := Layout_BH_BDL;
export GROUP_ID_ChildRec := record
  typeof(l.GROUP_ID) GROUP_ID;
  unsigned8 cnt;
  unsigned4 id;
end;
export COMPANY_NAME_ChildRec := record
  typeof(l.COMPANY_NAME) COMPANY_NAME;
  unsigned8 cnt;
  unsigned4 id;
end;
export R := RECORD,MAXLENGTH(32000)
 unsigned1 dummy;
  real4 GROUP_ID_specificity;
  real4 GROUP_ID_switch;
  dataset(GROUP_ID_ChildRec) nulls_GROUP_ID;
  real4 COMPANY_NAME_specificity;
  real4 COMPANY_NAME_switch;
  dataset(COMPANY_NAME_ChildRec) nulls_COMPANY_NAME;
end;
end;