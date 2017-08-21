//Debug
// Various routines to assist in debugging

import SALT,ut,salt24;
export Debug(dataset(Layout_BH_BDL) ih, Layout_Specificities.R s, MatchThreshold = 25) := module
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
shared h := match_candidates(ih).candidates;
shared LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes

export Layout_Sample_Matches := record,maxlength(32000)
  integer2 Conf;
  integer2 Conf_Prop;
  integer2 DateOverlap := 0;
  unsigned6 BDL1;
  unsigned6 BDL2;
  unsigned6 RCID1;
  unsigned6 RCID2;
  typeof(h.GROUP_ID) left_GROUP_ID;
  integer2 GROUP_ID_score;
  typeof(h.GROUP_ID) right_GROUP_ID;
  typeof(h.COMPANY_NAME) left_COMPANY_NAME;
  integer2 COMPANY_NAME_score;
  typeof(h.COMPANY_NAME) right_COMPANY_NAME;
end;
export layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,unsigned outside=0) := transform
  self.BDL1 := le.BDL;
  self.BDL2 := ri.BDL;
  self.RCID1 := le.RCID;
  self.RCID2 := ri.RCID;
  self.GROUP_ID_score := MAP( le.GROUP_ID  IN SET(s.nulls_GROUP_ID,GROUP_ID) or ri.GROUP_ID  IN SET(s.nulls_GROUP_ID,GROUP_ID) => SKIP,
                        le.GROUP_ID = ri.GROUP_ID  => le.GROUP_ID_weight100,
                        SKIP);

  self.left_GROUP_ID := le.GROUP_ID;
  self.right_GROUP_ID := ri.GROUP_ID;
  self.COMPANY_NAME_score := MAP( le.COMPANY_NAME  IN SET(s.nulls_COMPANY_NAME,COMPANY_NAME) or ri.COMPANY_NAME  IN SET(s.nulls_COMPANY_NAME,COMPANY_NAME) => 0,
                        le.COMPANY_NAME = ri.COMPANY_NAME  => le.COMPANY_NAME_weight100,
                        SALT24.fn_match_bagofwords(le.COMPANY_NAME,ri.COMPANY_NAME,2,1));

  self.left_COMPANY_NAME := le.COMPANY_NAME;
  self.right_COMPANY_NAME := ri.COMPANY_NAME;
  self.Conf_Prop := (0) / 100; // Score based on propogated fields
  self.Conf := (self.GROUP_ID_score + self.COMPANY_NAME_score) / 100 + outside;
end;

export AnnotateMatchesFromData(dataset(match_candidates(ih).layout_candidates) in_data,dataset(match_candidates(ih).layout_matches)  im) := function
  j1 := join(in_data,im,left.BDL = right.BDL1,hash);
  match_candidates(ih).layout_candidates strim(j1 le) := transform
    self := le;
  end;
  r := join(j1,in_data,left.BDL2 = right.BDL,sample_match_join( project(left,strim(left)),right),hash);
  d := dedup( sort( r, BDL1, BDL2, -Conf, local ), BDL1, BDL2, local ); // BDL2 distributed by join
  return d;
end;

export AnnotateMatchesFromRecordData(dataset(match_candidates(ih).layout_candidates) in_data,dataset(match_candidates(ih).layout_matches)  im) := function//Faster form when RCID known
  j1 := join(in_data,im,left.RCID = right.RCID1,hash);
  match_candidates(ih).layout_candidates strim(j1 le) := transform
    self := le;
  end;
  return join(j1,in_data,left.RCID2 = right.RCID,sample_match_join( project(left,strim(left)),right),hash);
end;
export AnnotateMatches(dataset(match_candidates(ih).layout_matches)  im) := function
  return AnnotateMatchesFromRecordData(h,im);
end;

shared Layout_FieldValueList := record,maxlength(2096)
  STRING Val;
end;
export Layout_RolledEntity := record,maxlength(63000)
  unsigned6 BDL;
  dataset(Layout_FieldValueList) GROUP_ID_Values;
  dataset(Layout_FieldValueList) COMPANY_NAME_Values;
end;

export RolledEntities(dataset(match_candidates(ih).layout_candidates) in_data) := function

Layout_RolledEntity into(in_data le) := transform
  self.BDL := le.BDL;
  self.GROUP_ID_Values := IF ( le.GROUP_ID IN SET(s.nulls_GROUP_ID,GROUP_ID),dataset([],Layout_FieldValueList),dataset([{trim((string)le.GROUP_ID)}],Layout_FieldValueList));
  self.COMPANY_NAME_Values := IF ( le.COMPANY_NAME IN SET(s.nulls_COMPANY_NAME,COMPANY_NAME),dataset([],Layout_FieldValueList),dataset([{trim((string)le.COMPANY_NAME)}],Layout_FieldValueList));
end;
AsFieldValues := project(in_data,into(left));
Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := transform
  self.BDL := le.BDL;
  self.GROUP_ID_values := if ( count(le.GROUP_ID_values)>=100 or exists(le.GROUP_ID_values(Val=ri.GROUP_ID_values[1].Val)), le.GROUP_ID_values, le.GROUP_ID_values+ri.GROUP_ID_values);
  self.COMPANY_NAME_values := if ( count(le.COMPANY_NAME_values)>=100 or exists(le.COMPANY_NAME_values(Val=ri.COMPANY_NAME_values[1].Val)), le.COMPANY_NAME_values, le.COMPANY_NAME_values+ri.COMPANY_NAME_values);
end;
  return rollup( sort( distribute( AsFieldValues, BDL ), BDL, local ), left.BDL = right.BDL, RollValues(left,right),local);
end;
end;