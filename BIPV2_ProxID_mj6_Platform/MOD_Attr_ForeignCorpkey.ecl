// Logic to handle the matching around ForeignCorpkey
 
IMPORT SALT30,ut,std;
EXPORT MOD_Attr_ForeignCorpkey(DATASET(layout_DOT_Base) ih,UNSIGNED MatchThreshold = 36) := MODULE

// Construct a function to filter matches to those that obey the force criteria on this attribute file.
EXPORT ForceFilter(inhead,infile,id1,id2) := FUNCTIONMACRO
// Every attribute value must match to a value in the other attribute IF they have the same context
//  Cands0 := BIPV2_ProxID_mj6_PlatForm.match_candidates(inhead).ForeignCorpkey_candidates;
  Cands0 := BIPV2_ProxID_mj6_PlatForm._file_Foreign_Corpkey;/*HACK*/
// We are going to create a record for each candidate pair; this record will have a child dataset for the attribute values of each side
childrec1 := 
record
    SALT30.StrType Basis    := Cands0.company_charter_number;/*HACK to get basis only*/
    SALT30.StrType Context  := Cands0.company_inc_state; // Context for the basis ('<')
end;

  ChildRec := RECORD
    Cands0.Proxid;
//    Cands0.Basis_Weight100;/*hack*/
    // SALT30.StrType Basis    := SALT30.GetNthWord(Cands0.Basis,1,'|');/*HACK to get basis only*/
    // SALT30.StrType Context  := SALT30.GetNthWord(Cands0.Basis,2,'|'); // Context for the basis ('<')
    dataset(childrec1) childs := dataset([{Cands0.company_charter_number,Cands0.company_inc_state}],childrec1);
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
  D2 := JOIN(D1    ,Cands2,LEFT.id2 = RIGHT.Proxid,TRANSFORM(PossRec/*, SELF.Kids2 := RIGHT.childs*/
    ,self.shouldFilterOut := if(count(table(left.kids1 + RIGHT.childs,{context},context,few))  <  count(table(left.kids1 + RIGHT.childs,{context,basis},context,basis,few)),true,skip) 
    ,SELF := LEFT), HASH);
  d2_table := project(d2,layslimmtch);
  
  D2_tokeep := join(infile,d2_table,left.id1 = right.id1 and left.id2 = right.id2,transform(left),left only,hash);
  RETURN D2_tokeep;

ENDMACRO;


SHARED Cands := match_candidates(ih).ForeignCorpkey_candidates;
SHARED s := Specificities(ih).Specificities[1];
 
// Generate match candidates based upon this attribute file
match_candidates(ih).Layout_Attribute_Matches Score(Cands le,Cands ri) := TRANSFORM
  SELF.rule := 10000; // Signify Attribute File #0
  SELF.Proxid1 := le.Proxid;
  SELF.Proxid2 := ri.Proxid;
  SELF.source_id := le.Basis;
  INTEGER2 cnp_name_score_temp := MAP( le.cnp_name_isnull OR ri.cnp_name_isnull OR le.cnp_name_weight100 = 0 => 0,
                        le.cnp_name = ri.cnp_name  => le.cnp_name_weight100,
                        SALT30.Fn_Fail_Scale(le.cnp_name_weight100,s.cnp_name_switch));
  INTEGER2 cnp_number_score_temp := MAP(                         le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
                        SALT30.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));
  INTEGER2 active_enterprise_number_score_temp := MAP( le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,
                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,
                        SALT30.Fn_Fail_Scale(le.active_enterprise_number_weight100,s.active_enterprise_number_switch));
  INTEGER2 active_domestic_corp_key_score_temp := MAP( le.active_domestic_corp_key_isnull OR ri.active_domestic_corp_key_isnull => 0,
                        le.active_domestic_corp_key = ri.active_domestic_corp_key  => le.active_domestic_corp_key_weight100,
                        SALT30.Fn_Fail_Scale(le.active_domestic_corp_key_weight100,s.active_domestic_corp_key_switch));
  INTEGER2 cnp_name_score := IF ( cnp_name_score_temp > Config.cnp_name_Force * 100, cnp_name_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 cnp_number_score := IF ( cnp_number_score_temp >= Config.cnp_number_Force * 100, cnp_number_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 active_enterprise_number_score := IF ( active_enterprise_number_score_temp >= Config.active_enterprise_number_Force * 100, active_enterprise_number_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 active_domestic_corp_key_score := IF ( active_domestic_corp_key_score_temp >= Config.active_domestic_corp_key_Force * 100, active_domestic_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
  SELF.Conf_Prop := (cnp_name_score + cnp_number_score + active_enterprise_number_score + active_domestic_corp_key_score) / 100; // Score based on forced fields
  SELF.Conf := ri.Basis_weight100/100;
END;
Matches0 := DISTRIBUTE(JOIN(Cands,Cands,LEFT.Basis = RIGHT.Basis AND LEFT.Proxid > RIGHT.Proxid,Score(LEFT,RIGHT)),Proxid1+Proxid2);
 
EXPORT Match := DEDUP( SORT(Matches0,Proxid1,Proxid2,-(Conf+Conf_Prop),Source_Id,LOCAL),Proxid1,Proxid2,KEEP(1),LOCAL ); // Keep 1 source_ids per match                                                      

END;
