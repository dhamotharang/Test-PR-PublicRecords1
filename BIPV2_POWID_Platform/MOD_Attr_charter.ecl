// Logic to handle the matching around charter
 
IMPORT SALT32,ut,std;
EXPORT MOD_Attr_charter(DATASET(layout_POWID) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
// Construct a function to filter matches to those that obey the force criteria on this attribute file.
EXPORT ForceFilter(inhead,infile,id1,id2) := FUNCTIONMACRO
// Every attribute value must match to a value in the other attribute IF they have the same context
  Cands0 := BIPV2_POWID_Platform.match_candidates(inhead).charter_candidates;
// We are going to create a record for each candidate pair; this record will have a child dataset for the attribute values of each side
  ChildRec := RECORD
    Cands0.POWID;
    Cands0.Basis_Weight100;
    Cands0.Basis;
    SALT32.StrType Context := SALT32.GetNthWord(Cands0.Basis,2,'|'); // Context for the basis ('<')
  END;
  Cands1 := TABLE(Cands0,ChildRec);
  Cands := DEDUP( SORT( DISTRIBUTE(Cands1,HASH(POWID)), WHOLE RECORD, LOCAL), WHOLE RECORD, LOCAL);
  // This is an optimized version of the code that takes particular advantage of the FORCE you are using
  Mtch0 := DISTRIBUTE(TABLE(infile,{id1,id2}),HASH(id1));
  Mtch := DEDUP( SORT( Mtch0, id1, id2, LOCAL ), id1, id2, LOCAL );
  Jnd := JOIN(Mtch,Cands,LEFT.id1=RIGHT.POWID,LOCAL);
  Bads := JOIN(DISTRIBUTE(Jnd,HASH(id2)),Cands,LEFT.id2=RIGHT.POWID AND LEFT.Context=RIGHT.Context AND LEFT.Basis<>RIGHT.Basis,TRANSFORM(LEFT),LOCAL);
  RETURN JOIN(infile,Bads,LEFT.id1=RIGHT.id1 AND LEFT.id2=RIGHT.id2,TRANSFORM(LEFT),LEFT ONLY, SMART);
ENDMACRO;
SHARED Cands := match_candidates(ih).charter_candidates;
SHARED s := Specificities(ih).Specificities[1];
 
// Generate match candidates based upon this attribute file
 
match_candidates(ih).Layout_Attribute_Matches Score(Cands le,Cands ri) := TRANSFORM
  SELF.rule := 10000; // Signify Attribute File #0
  SELF.POWID1 := le.POWID;
  SELF.POWID2 := ri.POWID;
  SELF.source_id := le.Basis;
  INTEGER2 prim_range_score_temp := MAP(
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT32.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch));
  INTEGER2 prim_name_score_temp := MAP(
                        le.prim_name_isnull OR ri.prim_name_isnull OR le.prim_name_weight100 = 0 => 0,
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT32.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch));
  INTEGER2 RID_If_Big_Biz_score_temp := MAP(
                        le.RID_If_Big_Biz_isnull OR ri.RID_If_Big_Biz_isnull => 0,
                        le.RID_If_Big_Biz = ri.RID_If_Big_Biz  => le.RID_If_Big_Biz_weight100,
                        SALT32.Fn_Fail_Scale(le.RID_If_Big_Biz_weight100,s.RID_If_Big_Biz_switch));
  INTEGER2 cnp_name_score_temp := MAP(
                        le.cnp_name_isnull OR ri.cnp_name_isnull OR le.cnp_name_weight100 = 0 => 0,
                        le.cnp_name = ri.cnp_name  => le.cnp_name_weight100,
                        SALT32.MatchBagOfWords(le.cnp_name,ri.cnp_name,31744,0));
  INTEGER2 company_name_score_temp := MAP(
                        le.company_name_isnull OR ri.company_name_isnull OR le.company_name_weight100 = 0 => 0,
                        le.company_name = ri.company_name  => le.company_name_weight100,
                        SALT32.MatchBagOfWords(le.company_name,ri.company_name,2128912,1));
  INTEGER2 cnp_number_score_temp := MAP(
                        le.cnp_number_isnull OR ri.cnp_number_isnull => 0,
                        le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
                        SALT32.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));
  INTEGER2 prim_range_score := IF ( prim_range_score_temp >= Config.prim_range_Force * 100, prim_range_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 prim_name_score := IF ( prim_name_score_temp > Config.prim_name_Force * 100, prim_name_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 RID_If_Big_Biz_score := IF ( RID_If_Big_Biz_score_temp >= Config.RID_If_Big_Biz_Force * 100, RID_If_Big_Biz_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 cnp_name_score := IF ( cnp_name_score_temp >= Config.cnp_name_Force * 100, cnp_name_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 company_name_score := IF ( company_name_score_temp > Config.company_name_Force * 100, company_name_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 cnp_number_score := IF ( cnp_number_score_temp >= Config.cnp_number_Force * 100, cnp_number_score_temp, SKIP ); // Enforce FORCE parameter
  SELF.Conf_Prop := (prim_range_score + prim_name_score + RID_If_Big_Biz_score + cnp_name_score + company_name_score + cnp_number_score) / 100; // Score based on forced fields
  SELF.Conf := ri.Basis_weight100/100;
END;
Matches0 := DISTRIBUTE(JOIN(Cands,Cands,LEFT.Basis = RIGHT.Basis AND LEFT.POWID > RIGHT.POWID,Score(LEFT,RIGHT)),POWID1+POWID2);
 
EXPORT Match := DEDUP( SORT(Matches0,POWID1,POWID2,-(Conf+Conf_Prop),Source_Id,LOCAL),POWID1,POWID2,KEEP(1),LOCAL ); // Keep 1 source_ids per match
END;
