// Logic to handle the matching around UnderLinks
 
IMPORT SALT30,ut,std;
EXPORT MOD_Attr_UnderLinks(DATASET(layout_LGID3) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED Cands := match_candidates(ih).UnderLinks_candidates;
SHARED s := Specificities(ih).Specificities[1];
 
// Generate match candidates based upon this attribute file
 
match_candidates(ih).Layout_Attribute_Matches Score(Cands le,Cands ri) := TRANSFORM
  SELF.rule := 10000; // Signify Attribute File #0
  SELF.LGID31 := le.LGID3;
  SELF.LGID32 := ri.LGID3;
  SELF.source_id := le.Basis;
  INTEGER2 Lgid3IfHrchy_score_temp := MAP(
                        le.Lgid3IfHrchy_isnull OR ri.Lgid3IfHrchy_isnull => 0,
                        le.Lgid3IfHrchy = ri.Lgid3IfHrchy  => le.Lgid3IfHrchy_weight100,
                        SALT30.Fn_Fail_Scale(le.Lgid3IfHrchy_weight100,s.Lgid3IfHrchy_switch));
  INTEGER2 sbfe_id_score := MAP(
                        le.sbfe_id_isnull OR ri.sbfe_id_isnull => 0,
                        le.sbfe_id = ri.sbfe_id  => le.sbfe_id_weight100,
                        SALT30.Fn_Fail_Scale(le.sbfe_id_weight100,s.sbfe_id_switch));
  INTEGER2 company_fein_score := MAP(
                        le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        SALT30.Fn_Fail_Scale(le.company_fein_weight100,s.company_fein_switch));
  INTEGER2 cnp_number_score_temp := MAP(
                        le.cnp_number_isnull OR ri.cnp_number_isnull => 0,
                        le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
                        SALT30.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));
  INTEGER2 company_inc_state_score_temp := MAP(
                        le.company_inc_state_isnull OR ri.company_inc_state_isnull OR le.company_inc_state_weight100 = 0 => 0,
                        le.company_inc_state = ri.company_inc_state  => le.company_inc_state_weight100,
                        SALT30.Fn_Fail_Scale(le.company_inc_state_weight100,s.company_inc_state_switch));
   /*HACKMOD_Attr_UnderLinks02*/ INTEGER2 Lgid3IfHrchy_score := IF ( Lgid3IfHrchy_score_temp >= Config.Lgid3IfHrchy_Force * 100, Lgid3IfHrchy_score_temp,0);
   /*HACKMOD_Attr_UnderLinks03*/ INTEGER2 cnp_number_score := IF ( cnp_number_score_temp >= Config.cnp_number_Force * 100 OR ( sbfe_id_score > Config.cnp_number_OR1_sbfe_id_Force*100), cnp_number_score_temp,0);
   /*HACKMOD_Attr_UnderLinks01*/ INTEGER2 company_inc_state_score := IF ( company_inc_state_score_temp > Config.company_inc_state_Force * 100 OR ( company_fein_score > Config.company_inc_state_OR4_company_fein_Force*100) OR ( sbfe_id_score > Config.company_inc_state_OR5_sbfe_id_Force*100), company_inc_state_score_temp,0);
  SELF.Conf_Prop := (Lgid3IfHrchy_score + sbfe_id_score + company_fein_score + cnp_number_score + company_inc_state_score) / 100; // Score based on forced fields
   /*HACKMOD_Attr_UnderLinks04*/ SELF.Conf := Config.MatchThreshold+1;
END;
Matches0 := DISTRIBUTE(JOIN(Cands,Cands,LEFT.Basis = RIGHT.Basis AND LEFT.LGID3 > RIGHT.LGID3,Score(LEFT,RIGHT)),LGID31+LGID32);
 
EXPORT Match := DEDUP( SORT(Matches0,LGID31,LGID32,-(Conf+Conf_Prop),Source_Id,LOCAL),LGID31,LGID32,KEEP(1),LOCAL ); // Keep 1 source_ids per match
END;
