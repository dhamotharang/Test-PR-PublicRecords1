
// Begin code to produce match candidates
import SALT,ut;
export match_candidates(dataset(Layout_BH_BDL) ih) := module
shared s := Specificities(ih).Specificities[1];
h00 := Specificities(ih).input_file;
shared thin_table := table(h00,{GROUP_ID,COMPANY_NAME,RCID,BDL});// Already distributed by specificities module


shared h0 := dedup( sort ( thin_table, whole record, local ), whole record, local );// Only one copy of each record

export Layout_Matches := record//in this module for because of ,foward bug
  unsigned2 Rule;
  integer2 Conf;
  integer2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  integer2 Conf_Prop; // Confidense provided by propogated fields
  unsigned6 BDL1;
  unsigned6 BDL2;
  unsigned6 RCID1 := 0;
  unsigned6 RCID2 := 0;
end;
export Layout_Candidates := record,maxlength(31999) // A record to hold weights of each field value
  {h0} AND NOT [COMPANY_NAME]; // remove wordbag fields which need to be expanded
  unsigned2 GROUP_ID_weight100 := 0; // Contains 100x the specificity
  string240 COMPANY_NAME := h0.COMPANY_NAME; // Expanded wordbag field
  unsigned2 COMPANY_NAME_weight100 := 0; // Contains 100x the specificity
end;
h1 := table(h0,layout_candidates);
//Now add the weights of each field one by one

//Would also create auto-id fields here


layout_candidates add_COMPANY_NAME(layout_candidates le,Specificities(ih).COMPANY_NAME_values_persisted ri) := transform
  self.COMPANY_NAME_weight100 := ri.field_specificity * 100;
  self.COMPANY_NAME := if( ri.field_specificity<>0 or ri.word<>'',self.COMPANY_NAME_weight100+' '+ri.word,le.COMPANY_NAME );// Copy in annotated wordstring
  self := le;
end;
SALT.MAC_Choose_JoinType(h1,s.nulls_COMPANY_NAME,Specificities(ih).COMPANY_NAME_values_persisted,COMPANY_NAME,COMPANY_NAME_weight100,add_COMPANY_NAME,j1);

layout_candidates add_GROUP_ID(layout_candidates le,Specificities(ih).GROUP_ID_values_persisted ri) := transform
  self.GROUP_ID_weight100 := ri.field_specificity * 100;
  self := le;
end;
SALT.MAC_Choose_JoinType(j1,s.nulls_GROUP_ID,Specificities(ih).GROUP_ID_values_persisted,GROUP_ID,GROUP_ID_weight100,add_GROUP_ID,j0);
shared Annotated := distribute(j0,BDL) : persist('temp::Business_Header_BDL2::BDL_BUSINESS_HEADER_mc'); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.GROUP_ID_weight100 + Annotated.COMPANY_NAME_weight100;
shared Linkable := TotalWeight >= 25;
export Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
export Candidates := Annotated(Linkable); //No point in trying to link records with too little data
end;