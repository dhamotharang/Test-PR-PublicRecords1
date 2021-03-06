// Logic to handle the matching around FilterPrimNames
 
IMPORT SALT28,ut,std;
EXPORT MOD_Attr_FilterPrimNames(DATASET(layout_DOT_Base) ih,UNSIGNED MatchThreshold = 33) := MODULE
// Construct a function to filter matches to those that obey the force criteria on this attribute file.
EXPORT ForceFilter(inhead,infile,id1,id2) := FUNCTIONMACRO
// Every attribute value has to exactly match every attribute value of the corresponding identifier or both have no values
  Cands0 := BIPV2_ProxID_mj6.file_filter_Prim_names;/*HACK*/
// We are going to create a record for each candidate pair; this record will have a child dataset for the attribute values of each side
////
childrec1 := 
record
    SALT28.StrType Basis    ;/*HACK to get basis only*/
end;
  ChildRec := RECORD
    Cands0.Proxid;
//    Cands0.Basis_Weight100;/*hack*/
    // SALT28.StrType Basis    := SALT28.GetNthWord(Cands0.Basis,1,'|');/*HACK to get basis only*/
    // SALT28.StrType Context  := SALT28.GetNthWord(Cands0.Basis,2,'|'); // Context for the basis ('<')
    dataset(childrec1) childs := dataset([{Cands0.pname_digits}],childrec1);
  END;
  Cands  := TABLE(Cands0,ChildRec);
  Cands1 := rollup(sort(Cands                     ,proxid,local) ,left.proxid = right.proxid,transform(recordof(left),self.childs := left.childs + right.childs,self := left),local);
  Cands2 := rollup(sort(distribute(Cands1,proxid) ,proxid,local) ,left.proxid = right.proxid,transform(recordof(left),self.childs := left.childs + right.childs,self := left),local);
  layslimmtch := {unsigned6 id1,unsigned6 id2};
  tslim := table(infile,{id1,id2},id1,id2,merge);
  PossRec := RECORD
    tslim;
    DATASET(ChildRec1) Kids1 := DATASET([],ChildRec1);
//    DATASET(ChildRec1) Kids2 := DATASET([],ChildRec1);
    boolean   shouldFilterOut := false;
  END;
//  T  := TABLE(tslim,PossRec); // Allow for addition of children
  D1 := JOIN(Tslim ,Cands2,LEFT.id1 = RIGHT.Proxid,TRANSFORM(PossRec, SELF.Kids1 := RIGHT.childs, SELF := LEFT), HASH);
  D2 := JOIN(D1    ,Cands2,LEFT.id2 = RIGHT.Proxid,TRANSFORM(PossRec/* SELF.Kids2 := RIGHT.childs*/
    ,self.shouldFilterOut := if(count(table(left.kids1 + RIGHT.childs,{basis},basis,few)) = 1 and count(left.kids1) = 1 and count(RIGHT.childs) = 1,skip,true) //if have one or more cnp_names in common, that is ok.  if not, filter out that potential match
    ,SELF := LEFT), HASH);
  d2_table := project(d2,layslimmtch);
  
  D2_tokeep := join(infile,d2_table,left.id1 = right.id1 and left.id2 = right.id2,transform(left),left only,hash);
  RETURN D2_tokeep;
ENDMACRO;

SHARED Cands := match_candidates(ih).FilterPrimNames_candidates;
SHARED s := Specificities(ih).Specificities[1];
 
// Generate match candidates based upon this attribute file
 
match_candidates(ih).Layout_Attribute_Matches Score(Cands le,Cands ri,UNSIGNED cnp_name_support = 0) := TRANSFORM
  SELF.rule := 10003; // Signify Attribute File #3
  SELF.Proxid1 := le.Proxid;
  SELF.Proxid2 := ri.Proxid;
  SELF.source_id := le.Basis;
  INTEGER2 cnp_number_score_temp := MAP(                         le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
                        SALT28.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));
  INTEGER2 active_duns_number_score_temp := MAP( le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,
                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,
                        SALT28.Fn_Fail_Scale(le.active_duns_number_weight100,s.active_duns_number_switch));
  INTEGER2 active_enterprise_number_score_temp := MAP( le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,
                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,
                        SALT28.Fn_Fail_Scale(le.active_enterprise_number_weight100,s.active_enterprise_number_switch));
  INTEGER2 active_domestic_corp_key_score_temp := MAP( le.active_domestic_corp_key_isnull OR ri.active_domestic_corp_key_isnull => 0,
                        le.active_domestic_corp_key = ri.active_domestic_corp_key  => le.active_domestic_corp_key_weight100,
                        SALT28.Fn_Fail_Scale(le.active_domestic_corp_key_weight100,s.active_domestic_corp_key_switch));
  INTEGER2 cnp_number_score := IF ( cnp_number_score_temp >= Config.cnp_number_Force * 100, cnp_number_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 active_duns_number_score := IF ( active_duns_number_score_temp >= Config.active_duns_number_Force * 100, active_duns_number_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 active_enterprise_number_score := IF ( active_enterprise_number_score_temp >= Config.active_enterprise_number_Force * 100, active_enterprise_number_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 active_domestic_corp_key_score := IF ( active_domestic_corp_key_score_temp >= Config.active_domestic_corp_key_Force * 100, active_domestic_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
  SELF.Conf_Prop := (cnp_number_score + active_duns_number_score + active_enterprise_number_score + active_domestic_corp_key_score) / 100; // Score based on forced fields
  SELF.Conf := ri.Basis_weight100 *  1.00;
end;
Matches0 := DISTRIBUTE(JOIN(Cands,Cands,LEFT.Basis = RIGHT.Basis AND LEFT.Proxid > RIGHT.Proxid,Score(LEFT,RIGHT)),Proxid1+Proxid2);
 
EXPORT Match := DEDUP( SORT(Matches0,Proxid1,Proxid2,-(Conf+Conf_Prop+support_cnp_name),Source_Id,LOCAL),Proxid1,Proxid2,KEEP(1),LOCAL ); // Keep 1 source_ids per match
END;

