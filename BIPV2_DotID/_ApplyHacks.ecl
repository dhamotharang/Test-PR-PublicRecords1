// -- BIPV2_DotID._ApplyHacks('BIPV2_DotID',,true).do_all_hacks;
import SALTTOOLS22,STD,wk_ut,tools; 
EXPORT _ApplyHacks(
   string   pModule               = 'BIPV2_DotID'
  ,string   pEsp                  = wk_ut._Constants.LocalEsp + ':8145'
  ,boolean  pShouldSaveAttributes = false
  ,string   pAttributeRegexFilter = ''
) :=
function
  
  // ----------------------------------------------------------------------------
  // -- MOD_Attr_ForeignCorpkey
  // ----------------------------------------------------------------------------
  ds_MOD_Attr_ForeignCorpkey  :=  DATASET([
       {pModule
       ,'MOD_Attr_ForeignCorpkey'
       ,'EXPORT ForceFilter.*?SHARED Cands := match_candidates[(]ih[)][.]ForeignCorpkey_candidates;'  
       ,'HACK Cands to prevent att matches'  
      ,'EXPORT ForceFilter(inhead,infile,id1,id2) := FUNCTIONMACRO\n'
      + '// Every attribute value must match to a value in the other attribute IF they have the same context\n'
      + '  /* HACK - replace Cands0 */\n'
      + '	// Cands0 := BIPV2_DotID.match_candidates(inhead).ForeignCorpkey_candidates;\n'
      + '  Cands0 := BIPV2_DotID._attr_ck_charters;\n'
      + '// We are going to create a record for each candidate pair; this record will have a child dataset for the attribute values of each side\n'
      + '  /* HACK - add ChildRec1 */\n'
      + '	ChildRec1 := RECORD\n'
      + '    salt33.StrType Basis    := Cands0.company_charter_number;\n'
      + '    salt33.StrType Context  := Cands0.company_inc_state; // Context for the basis (\'<\')\n'
      + '  END;\n'
      + '  ChildRec := RECORD\n'
      + '    Cands0.DOTid;\n'
      + '    /* HACK - comment-out three lines, add childs line */\n'
      + '    // Cands0.Basis_Weight100;\n'
      + '    // Cands0.Basis;\n'
      + '    // salt33.StrType Context := salt33.GetNthWord(Cands0.Basis,2,\'|\'); // Context for the basis (\'<\')\n'
      + '		DATASET(ChildRec1) childs := dataset([{Cands0.company_charter_number,Cands0.company_inc_state}],ChildRec1);\n'
      + '  END;\n'
      + '  Cands := TABLE(Cands0,ChildRec);\n'
      + '	/* HACK - add Cands1/Cands2 */\n'
      + '  Cands1 := rollup(sort(Cands                    ,dotid,local) ,left.dotid = right.dotid,transform(recordof(left),self.childs := left.childs + right.childs,self := left),local);\n'
      + '  Cands2 := rollup(sort(distribute(Cands1,dotid) ,dotid,local) ,left.dotid = right.dotid,transform(recordof(left),self.childs := left.childs + right.childs,self := left),local);\n'
      + '	\n'
      + '  layslimmtch := {unsigned6 id1,unsigned6 id2};\n'
      + '  tslim := table(infile,{id1,id2},id1,id2,merge);\n'
      + '  PossRec := RECORD\n'
      + '    tslim;\n'
      + '    DATASET(ChildRec1) Kids1 := DATASET([],ChildRec1);\n'
      + '//    DATASET(ChildRec1) Kids2 := DATASET([],ChildRec1);\n'
      + '    boolean   shouldFilterOut := false;\n'
      + '  END;\n'
      + '//  T  := TABLE(tslim,PossRec); // Allow for addition of children\n'
      + '  D1 := JOIN(Tslim ,Cands2,LEFT.id1 = RIGHT.Dotid,TRANSFORM(PossRec, SELF.Kids1 := RIGHT.childs, SELF := LEFT), HASH);\n'
      + '  D2 := JOIN(D1    ,Cands2,LEFT.id2 = RIGHT.Dotid,TRANSFORM(PossRec/*, SELF.Kids2 := RIGHT.childs*/\n'
      + '    ,self.shouldFilterOut := if(count(table(left.kids1 + RIGHT.childs,{context},context,few))  <  count(table(left.kids1 + RIGHT.childs,{context,basis},context,basis,few)),true,skip) \n'
      + '    ,SELF := LEFT), HASH);\n'
      + '  d2_table := project(d2,layslimmtch);\n'
      + '  \n'
      + '  D2_tokeep := join(infile,d2_table,left.id1 = right.id1 and left.id2 = right.id2,transform(left),left only,hash);\n'
      + '  RETURN D2_tokeep;\n'
      + '\n'
      + 'ENDMACRO;\n'
      + 'SHARED Cands := dataset([],recordof(match_candidates(ih).ForeignCorpkey_candidates));/*HACK Cands to prevent att matches*/\n'
       ,'BH-265 performance improvements.  speed up foreign corpkey attribute file'
       }
  ],Tools.layout_attribute_hacks2);
  
  ds_Proc_Iterate  :=  DATASET([
       {pModule,'Proc_Iterate'
          ,'SHARED ChangeName := \'[~]temp::DOTid::BIPV2_DotID::changes_it\'[+]iter;'  
          ,'not_regex'  
          , 'import bipv2;\n' 
          + 'SHARED ChangeName := \'~temp::DOTid::BIPV2_DotID::changes_it\'+iter+\'_\'+ pversion/*HACK*/;'
          ,'add keysuffix to changes filename'
       }
      ,{pModule,'Proc_Iterate','[(]STRING iter'  ,'string pversion'  ,'(string pversion/*HACK*/,string iter' ,'add pversion parameter'}
  ],Tools.layout_attribute_hacks2);
  
  debug_n_matches_hacks(string patt) := 
  function
  
    ds_results :=
    DATASET([
        {pModule,patt,'(fname_score := IF [(])([[:space:]]fname_score_temp)'  ,''  ,'$1le.fname = ri.fname or/*HACK*/ $2' ,'add fname perfect match condition to force(+) in match join transform to emulate default force behaviour'}
       ,{pModule,patt,'(lname_score := IF [(])([[:space:]]lname_score_temp)'  ,''  ,'$1le.lname = ri.lname or/*HACK*/ $2' ,'add lname perfect match condition to force(+) in match join transform to emulate default force behaviour'}
    ],Tools.layout_attribute_hacks2);

    return ds_results;
    
  end;

  ds_debug := debug_n_matches_hacks('Debug');
  
  ds_matches  :=  DATASET([
       {pModule,'matches','(AND [(] [~]left[.]lname_isnull AND [~]right[.]lname_isnull [)])'  ,'/[*] AND [(] [~]left[.]lname_isnull'  ,'/* $1 *//*HACK*/' ,'comment out lname is null in match join condition to allow for blank to blank matching'}
      ,{pModule,'matches','(AND [(] [~]left[.]fname_isnull AND [~]right[.]fname_isnull [)])'  ,'/[*] AND [(] [~]left[.]fname_isnull'  ,'/* $1 *//*HACK*/' ,'comment out fname is null in match join condition to allow for blank to blank matching'}
      ,{pModule,'matches','JOIN[(]ih, Patched_Infile_thin, LEFT[.]rcid=RIGHT[.]rcid, TRANSFORM[(]RECORDOF[(]ih[)],SELF:=RIGHT,SELF:=LEFT[)], KEEP[(]1[)], SMART[)];'  ,', HASH/[*]HACK[*]/'                                         ,'JOIN(ih, Patched_Infile_thin, LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(ih),SELF:=RIGHT,SELF:=LEFT), KEEP(1), HASH/*HACK*/);'  ,'change pi1 smart join to hash join to prevent mp link closed error in dataland( W20151021-120318 )(maybe prod)'}
      ,{pModule,'matches','last_mjs_t :=_mj_extra[(]hfile,trans[)] [+] mj0;'                                                                                          ,'last_mjs_t := [/][*]_mj_extra[(]hfile,trans[)] [+] [*][/]'  ,'last_mjs_t := /*_mj_extra(hfile,trans) + *//*HACK*/mj0;'                                                                      ,'BH-265 performance improvements.  remove mj extra joins'}
      ,{pModule,'matches','with_attr := attr_match [+] all_mjs;'                                                                                                      ,'with_attr := [/][*]attr_match [+] [*][/]'                   ,'with_attr := /*attr_match + */all_mjs;'                                                                                       ,'BH-265 performance improvements.  remove attribute matches'}
  ],Tools.layout_attribute_hacks2)
  + debug_n_matches_hacks('matches')
  ;
 
  ds_specificities  :=  DATASET([
       {pModule,'specificities','SALT3[34567].mac_edit_distance_pairs'  ,''  ,'/*HACK*/SALT38.mac_edit_distance_pairs' ,'use salt38 version of mac_edit_distance_pairs for performance.'}
      ,{pModule,'specificities','(IMPORT ut,SALT3[34567])'              ,''  ,'$1, /*HACK*/SALT38'                     ,'add import salt38 to use newer macro'                          }
  ],Tools.layout_attribute_hacks2);

  ds_BasicMatch  :=  DATASET([
       {pModule,'BasicMatch'
        ,'h01.*?sort.*?((,(.*?)),DOTid)[)].*?Match[[:space:]]*:=[[:space:]]*JOIN[(]h02,'  
        ,'table[(]h00_match'  
        ,'  h02 := table(h00_match\n'  
        +'            ,{$3,unsigned6 DOTid := min(group,DOTid)}\n'  //replacement
        +'            , $3,merge);/*HACK*/\n'
        +'  Match := JOIN(h02,'
        ,'BH-265 performance improvements.  speed up basic match h02'    }
      ,{pModule,'BasicMatch','PickOne := DEDUP[(] SORT[(] DISTRIBUTE[(] Match,HASH[(]DOTid1[)] [)], DOTid1, DOTid2, LOCAL[)], DOTid1, LOCAL[)];' ,'PickOne := table' ,'PickOne := table( Match  ,{DOTid1  ,unsigned6 DOTid2 := min(group,DOTid2)}, DOTid1, merge);/*HACK*/' ,'BH-265 performance improvements.  speed up basic match PickOne dataset'}
  ],Tools.layout_attribute_hacks2);

/*  
  ds_MOD_Attr_ForeignCorpkey  :=  DATASET([
       {pModule,'attribute','regex'  ,'not_regex'  ,'replacement' ,'description'}
      ,{pModule,'attribute','regex'  ,'not_regex'  ,'replacement' ,'description'}
  ],Tools.layout_attribute_hacks2);
*/
  ds_Keys  :=  DATASET([
       {pModule,'Keys','(,BUILDINDEX[(]Attribute_Matches, OVERWRITE[)],BUILDINDEX[(]MatchHistoryKey, OVERWRITE[)])' ,'HACK no att matches or match history' ,'/*$1*//*HACK no att matches or match history*/'                                                 ,'BH-265 performance improvements.  don\'t build att matches and match history keys' }
      ,{pModule,'Keys',',BUILDINDEX[(]PatchedCandidates, OVERWRITE[)][)],Build_InData'                              ,'HACK no patched candidates'           ,'/*,BUILDINDEX(PatchedCandidates, OVERWRITE)*/)/*,Build_InData*//*HACK no patched candidates*/'  ,'BH-265 performance improvements.  don\'t build patched cands and in_data keys'     }
  ],Tools.layout_attribute_hacks2);


  ds_concat := 
      ds_MOD_Attr_ForeignCorpkey
    + ds_Proc_Iterate
    + ds_debug
    + ds_matches
    + ds_specificities
    + ds_BasicMatch
    + ds_Keys
    ;

  ds_result := ds_concat(pAttributeRegexFilter = '' or regexfind(pAttributeRegexFilter  ,theattribute,nocase));

  return Tools.HackAttribute2(ds_result,pShouldSaveAttributes,pEsp).saveit;

end;