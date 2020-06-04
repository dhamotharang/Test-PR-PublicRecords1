import SALTTOOLS22,STD,wk_ut;

EXPORT _ApplyProxidHacks(
   string   pModule               = 'BIPV2_ProxID_mj6_PlatForm'
  ,string   pEsp                  = wk_ut._Constants.LocalEsp + ':8145'
  ,boolean  pShouldSaveAttributes = false
) :=
module
  EXPORT fGetAttribute(STRING att                 ):=SALTTOOLS22.mod_Soapcalls.fGetAttributes(pModule,att,pEsp)(COUNT(results)>0)[1].results[1].Text;
  EXPORT fPutAttribute(STRING att,STRING ecl_text ):=OUTPUT(SALTTOOLS22.mod_Soapcalls.fSaveAttribute(pModule,att,ecl_text,pEsp));
  

  export fHackDebugNMatches(
  
     string   pAttribute            = 'Debug' //this can be used for Debug and matches attributes
    ,boolean  pShouldSaveAttribute  = false
    
  ) :=
  function
  
    EclCode := fGetAttribute(pAttribute) : independent;
              
    ///////////////
    hackReplaceTransitivesMacroCondition := pAttribute = 'matches' and      regexfind('SALT30[.]mac_avoid_transitives[(]All_Matches,Proxid1,Proxid2,Conf,DateOverlap,Rule,o[)];',EclCode,nocase)
                                                                   and not  regexfind('BIPV2_ProxID_mj6_PlatForm[.]mac_avoid_transitives_scalene'                                    ,EclCode,nocase);
    
    
    HackReplaceTransitivesMacro := if(hackReplaceTransitivesMacroCondition 
                        ,regexreplace(
                          '(SALT30[.]mac_avoid_transitives[(]All_Matches,Proxid1,Proxid2,Conf,DateOverlap,Rule,o[)];)'
                        ,EclCode,
                          '// $1 /* HACK - disable default salt mac_avoid_transitives*/\n'
                        + 'import BIPV2_Tools;\n /*HACK, import module for new transitives macro*/\n'
                        + 'o := BIPV2_ProxID_mj6_PlatForm.mac_avoid_transitives_scalene(All_Matches,Proxid1,Proxid2,Conf,DateOverlap,Rule,MatchThreshold,10); // HACK - Use new transitives macro, bucket size 10*/\n'
                        ,nocase) 
                        ,EclCode
                     );
    HackReplaceTransitivesMacro_message := if(hackReplaceTransitivesMacroCondition or pAttribute = 'Debug','','' + 'Did not Hack ' + pAttribute + ' replacing transitives macro\n');

    ///////////////

    hackRollEntitiesReturnEcl := '(RETURN ROLLUP[(] SORT[(] DISTRIBUTE[(] infile, HASH[(]Proxid[)] [)], Proxid, LOCAL [)], LEFT[.]Proxid = RIGHT[.]Proxid, RollValues[(]LEFT,RIGHT[)],LOCAL[)];)';
    
    hackRollEntitiesReturnCondition := pAttribute = 'Debug' and      regexfind(hackRollEntitiesReturnEcl,HackReplaceTransitivesMacro,nocase) and not regexfind('rollup3',HackReplaceTransitivesMacro,nocase);
    
    
    HackRollEntitiesReturn := if(hackRollEntitiesReturnCondition 
                        ,regexreplace(
                          hackRollEntitiesReturnEcl
                        ,HackReplaceTransitivesMacro,
                          '// $1 /* HACK - disable default return*/\n'
                        + 'rollup1 :=  ROLLUP( SORT( distribute(infile         ) , Proxid ,local), LEFT.Proxid = RIGHT.Proxid, RollValues(LEFT,RIGHT),local); /*HACK, disable default return*/\n'
                        + 'rollup2 :=  ROLLUP( SORT( distribute(rollup1        ) , Proxid ,local), LEFT.Proxid = RIGHT.Proxid, RollValues(LEFT,RIGHT),local); /*HACK, disable default return*/\n'
                        + 'rollup3 :=  ROLLUP( SORT( distribute(rollup2 ,proxid) , Proxid ,local), LEFT.Proxid = RIGHT.Proxid, RollValues(LEFT,RIGHT),local); /*HACK, disable default return*/\n'
                        + 'RETURN rollup3;                                                                                                                    /*HACK, disable default return*/\n'
                        ,nocase) 
                        ,HackReplaceTransitivesMacro
                     );
    HackRollEntitiesReturn_message := if(hackRollEntitiesReturnCondition or pAttribute = 'matches' , HackReplaceTransitivesMacro_message ,HackReplaceTransitivesMacro_message + 'Did not Hack ' + pAttribute + ' replacing return for RollEntities\n');

    /////////////////////////////////
    hackSlimPatchDsEcl := '(Patchlgid3 := SALT30[.]MAC_ParentId_Patch[(])o(,lgid3,Proxid[)];  // Collapse any lgid3 now joined by Proxid)';
    
    hackSlimPatchDsCondition := pAttribute = 'matches' and      regexfind(hackSlimPatchDsEcl,HackRollEntitiesReturn,nocase);
        
    HackSlimPatchDs := if(hackSlimPatchDsCondition 
                        ,regexreplace(
                          hackSlimPatchDsEcl
                        ,HackRollEntitiesReturn,
                          ' o_thin := TABLE(o,{ultid,orgid,lgid3,proxid,dotid,rcid}); // HACK\n'
                        + '$1 o_thin $2/* HACK - slim dataset*/\n'
                        ,nocase) 
                        ,HackRollEntitiesReturn
                     );
    HackSlimPatchDs_message := if(hackSlimPatchDsCondition  or pAttribute = 'Debug',HackRollEntitiesReturn_message,HackRollEntitiesReturn_message + ' ,Did not Hack ' + pAttribute + ' replacing Parentid patch\n');

    //////////////
    hackMacParentIdPatchEcl := 'SALT30[.]MAC_ParentId_Patch';
    
    hackMacParentIdPatchCondition := pAttribute = 'matches' and      regexfind(hackMacParentIdPatchEcl,HackSlimPatchDs,nocase);
        
    HackMacParentIdPatch := if(hackMacParentIdPatchCondition 
                        ,regexreplace(
                          hackMacParentIdPatchEcl
                        ,HackSlimPatchDs,
                          'BIPV2_Tools.MAC_ParentId_Patch'
                        ,nocase) 
                        ,HackSlimPatchDs
                     );
    HackMacParentIdPatch_message := if(hackMacParentIdPatchCondition  or pAttribute = 'Debug',HackSlimPatchDs_message,HackSlimPatchDs_message + ' ,Did not Hack ' + pAttribute + ' replacing Parentid patch call\n');

    ////////////

    hackPatchedInfileEcl := 'EXPORT Patched_Infile := Patchdotid;';
    
    hackPatchedInfileCondition := pAttribute = 'matches' and      regexfind(hackPatchedInfileEcl,hackMacParentIdPatch,nocase);
        
    HackPatchedInfile := if(hackPatchedInfileCondition 
                        ,regexreplace(
                          hackPatchedInfileEcl
                        ,hackMacParentIdPatch,
                          'EXPORT Patched_Infile := JOIN(o, Patchdotid, LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(o),SELF:=RIGHT,SELF:=LEFT), KEEP(1), HASH); // HACK;'
                        ,nocase) 
                        ,hackMacParentIdPatch
                     );
    HackPatchedInfile_message := if(hackPatchedInfileCondition  or pAttribute = 'Debug',hackMacParentIdPatch_message,hackMacParentIdPatch_message + ' ,Did not Hack ' + pAttribute + ' adding join to patched_infile\n');

    ////////////

    hackRemoveAttMatchesEcl := 'with_attr := attr_match [+] all_mjs;';
    
    hackRemoveAttMatchesCondition := pAttribute = 'matches' and      regexfind(hackRemoveAttMatchesEcl,HackPatchedInfile,nocase);
        
    HackRemoveAttMatches := if(hackRemoveAttMatchesCondition 
                        ,regexreplace(
                          hackRemoveAttMatchesEcl
                        ,HackPatchedInfile,
                          'with_attr := /*attr_match + */ all_mjs;// HACK'
                        ,nocase) 
                        ,HackPatchedInfile
                     );
    HackRemoveAttMatches_message := if(hackRemoveAttMatchesCondition  or pAttribute = 'Debug',HackPatchedInfile_message,HackPatchedInfile_message + ' ,Did not Hack ' + pAttribute + ' removing Attribute Matches\n');

    ////////////

    saveatt := fPutAttribute(pAttribute,HackRemoveAttMatches);
    
    return sequential(iff(pShouldSaveAttribute and std.Str.findcount(HackRemoveAttMatches_message,'Did not Hack') != 15 ,saveatt  ,output(dataset([{HackRemoveAttMatches}],{string ecl}),named(pAttribute + 'HackedEcl'))),output(HackRemoveAttMatches_message  ,named(pAttribute + 'Hack_message')));
   
  end;
  
  /////////////Keys
  export fHackKeys(
  
     string   pAttribute            = 'Keys' 
    ,boolean  pShouldSaveAttribute  = false
    
  ) :=
  function
  
    EclCode   := fGetAttribute(pAttribute) : independent;
    IndexNum  := STD.Str.FindCount( EclCode, 'BUILDINDEX');
    HackKeys  := 
      'EXPORT Keys(DATASET(layout_DOT_Base) ih = dataset([],layout_DOT_Base),string liter = \'qa\' ,boolean pUseOtherEnvironment = false) := MODULE\n'
    + 'SHARED s := Specificities(ih).Specificities;\n'
    + 'SHARED mtch := debug(ih ,s[1]).AnnotateMatches(matches(ih).PossibleMatches,matches(ih).All_Attribute_Matches);\n'
    + 'prop_file := match_candidates(ih).candidates; // Use propogated file\n'
    + 'EXPORT Candidates         := INDEX(prop_file,{Proxid},{prop_file},_keynames(liter,pUseOtherEnvironment).match_candidates_debug.logical);\n'
    + 'ms_temp := sort(mtch,Conf,Proxid1,Proxid2,SKEW(1.0)); // Some headers have very skewed IDs\n'
    + 'EXPORT MatchSample        := INDEX(ms_temp,{Conf,Proxid1,Proxid2},{mtch},_keynames(liter,pUseOtherEnvironment).match_sample_debug.logical,SORT KEYED);\n'
    + 'EXPORT Specificities_Key  := INDEX(s,{1},{s},_keynames(liter,pUseOtherEnvironment).specificities_debug.logical);\n'
    + 'am := matches(ih).All_Attribute_Matches;\n'
    + 'EXPORT Attribute_Matches  := INDEX(am,{Proxid1,Proxid2},{am},_keynames(liter,pUseOtherEnvironment).attribute_matches.logical);\n'
    + 'prop_file := matches(ih).Patched_Candidates; // Available for External ADL2\n'
    + 'EXPORT PatchedCandidates  := INDEX(prop_file,{Proxid},{prop_file},_keynames(liter,pUseOtherEnvironment).patched_candidates.logical);\n'
    + 'EXPORT InData             := INDEX(ih,{Proxid},{ih},_keynames(liter,pUseOtherEnvironment).in_data.logical);\n'
    + '\n'
    + '// Create logic to manage the match history key\n'
    + 'EXPORT MatchHistoryName := \'~keep::BIPV2_ProxID_mj6_PlatForm::Proxid::MatchHistory\';\n'
    + 'EXPORT MatchHistoryFile := DATASET(MatchHistoryName,Matches(In_DOT_Base).id_shift_r,THOR); // Read in all the change history\n'
    + ' \n'
    + 'EXPORT MatchHistoryKeyName := \'~\'+\'key::BIPV2_ProxID_mj6_PlatForm::Proxid::History::Match\';\n'
    + '  MH := MatchHistoryFile;\n'
    + ' \n'
    + 'EXPORT MatchHistoryKey := INDEX(MH,{Proxid_after},{MH},MatchHistoryKeyName);                                                \n'
    + '// Build enough to support the debug services such as the compare service\n'
    + 'EXPORT BuildDebug := PARALLEL(BUILDINDEX(Candidates,_keynames(liter).match_candidates_debug.logical,OVERWRITE),BUILDINDEX(Specificities_Key,_keynames(liter).specificities_debug.logical,FEW,OVERWRITE),BUILDINDEX(Attribute_Matches,_keynames(liter).attribute_matches.logical,OVERWRITE));\n'
    + '// Build Everything\n'
    + 'EXPORT BuildAll := PARALLEL(BUILDINDEX(Candidates,_keynames(liter).match_candidates_debug.logical,OVERWRITE),BUILDINDEX(MatchSample,_keynames(liter).match_sample_debug.logical,OVERWRITE),BUILDINDEX(Specificities_Key,_keynames(liter).specificities_debug.logical,FEW,OVERWRITE),BUILDINDEX(PatchedCandidates,_keynames(liter).patched_candidates.logical,OVERWRITE),BUILDINDEX(Attribute_Matches,_keynames(liter).attribute_matches.logical,OVERWRITE)/*,BUILDINDEX(InData,_keynames(liter).in_data.logical,OVERWRITE)*/);\n'
    + 'END;\n'
    ;
    HackKeys_message := if(IndexNum  = 6,'','Did not Hack ' + pAttribute + ' because # of keys(expected 6, found ' + (string)IndexNum + ') changed.  Take a look.\n');
    saveatt := fPutAttribute(pAttribute,HackKeys);
    
    return sequential(iff(pShouldSaveAttribute  and IndexNum = 6,saveatt  ,output(dataset([{HackKeys}],{string ecl}),named(pAttribute + 'HackedEcl'))),output(HackKeys_message  ,named(pAttribute + 'Hack_message')));
  END;
  
  /////////////fHackModFkey
  export fHackModFkey(
  
     string   pAttribute            = 'MOD_Attr_ForeignCorpkey' 
    ,boolean  pShouldSaveAttribute  = false
    
  ) :=
  function
  
    EclCode   := fGetAttribute(pAttribute) : independent;
    IndexNum  := STD.Str.FindCount( EclCode, 'rollup');
    HackKeys  := 
        '// Logic to handle the matching around ForeignCorpkey\n'
      + ' \n'
      + 'IMPORT SALT30,ut,std;\n'
      + 'EXPORT MOD_Attr_ForeignCorpkey(DATASET(layout_DOT_Base) ih,UNSIGNED MatchThreshold = 36) := MODULE\n'
      + '\n'
      + '// Construct a function to filter matches to those that obey the force criteria on this attribute file.\n'
      + 'EXPORT ForceFilter(inhead,infile,id1,id2) := FUNCTIONMACRO\n'
      + '// Every attribute value must match to a value in the other attribute IF they have the same context\n'
      + '//  Cands0 := BIPV2_ProxID_mj6_PlatForm.match_candidates(inhead).ForeignCorpkey_candidates;\n'
      + '  Cands0 := BIPV2_ProxID_mj6_PlatForm._file_Foreign_Corpkey;/*HACK*/\n'
      + '// We are going to create a record for each candidate pair; this record will have a child dataset for the attribute values of each side\n'
      + 'childrec1 := \n'
      + 'record\n'
      + '    SALT30.StrType Basis    := Cands0.company_charter_number;/*HACK to get basis only*/\n'
      + '    SALT30.StrType Context  := Cands0.company_inc_state; // Context for the basis (\'<\')\n'
      + 'end;\n'
      + '\n'
      + '  ChildRec := RECORD\n'
      + '    Cands0.Proxid;\n'
      + '//    Cands0.Basis_Weight100;/*hack*/\n'
      + '    // SALT30.StrType Basis    := SALT30.GetNthWord(Cands0.Basis,1,\'|\');/*HACK to get basis only*/\n'
      + '    // SALT30.StrType Context  := SALT30.GetNthWord(Cands0.Basis,2,\'|\'); // Context for the basis (\'<\')\n'
      + '    dataset(childrec1) childs := dataset([{Cands0.company_charter_number,Cands0.company_inc_state}],childrec1);\n'
      + '  END;\n'
      + '  Cands  := TABLE(Cands0,ChildRec);\n'
      + '  Cands1 := rollup(sort(Cands                     ,proxid,local) ,left.proxid = right.proxid,transform(recordof(left),self.childs := left.childs + right.childs,self := left),local);\n'
      + '  Cands2 := rollup(sort(distribute(Cands1,proxid) ,proxid,local) ,left.proxid = right.proxid,transform(recordof(left),self.childs := left.childs + right.childs,self := left),local);\n'
      + '\n'
      + '  layslimmtch := {unsigned6 id1,unsigned6 id2};\n'
      + '  tslim := table(infile,{id1,id2},id1,id2,merge);\n'
      + '  PossRec := RECORD\n'
      + '    tslim;\n'
      + '    DATASET(ChildRec1) Kids1 := DATASET([],ChildRec1);\n'
      + '//    DATASET(ChildRec1) Kids2 := DATASET([],ChildRec1);\n'
      + '    boolean   shouldFilterOut := false;\n'
      + '  END;\n'
      + '//  T  := TABLE(tslim,PossRec); // Allow for addition of children\n'
      + '  D1 := JOIN(Tslim ,Cands2,LEFT.id1 = RIGHT.Proxid,TRANSFORM(PossRec, SELF.Kids1 := RIGHT.childs, SELF := LEFT), HASH);\n'
      + '  D2 := JOIN(D1    ,Cands2,LEFT.id2 = RIGHT.Proxid,TRANSFORM(PossRec/*, SELF.Kids2 := RIGHT.childs*/\n'
      + '    ,self.shouldFilterOut := if(count(table(left.kids1 + RIGHT.childs,{context},context,few))  <  count(table(left.kids1 + RIGHT.childs,{context,basis},context,basis,few)),true,skip) \n'
      + '    ,SELF := LEFT), HASH);\n'
      + '  d2_table := project(d2,layslimmtch);\n'
      + '  \n'
      + '  D2_tokeep := join(infile,d2_table,left.id1 = right.id1 and left.id2 = right.id2,transform(left),left only,hash);\n'
      + '  RETURN D2_tokeep;\n'
      + '\n'
      + 'ENDMACRO;\n'
      + '\n'
      + '\n'
      + 'SHARED Cands := match_candidates(ih).ForeignCorpkey_candidates;\n'
      + 'SHARED s := Specificities(ih).Specificities[1];\n'
      + ' \n'
      + '// Generate match candidates based upon this attribute file\n'
      + 'match_candidates(ih).Layout_Attribute_Matches Score(Cands le,Cands ri) := TRANSFORM\n'
      + '  SELF.rule := 10000; // Signify Attribute File #0\n'
      + '  SELF.Proxid1 := le.Proxid;\n'
      + '  SELF.Proxid2 := ri.Proxid;\n'
      + '  SELF.source_id := le.Basis;\n'
      + '  INTEGER2 cnp_name_score_temp := MAP( le.cnp_name_isnull OR ri.cnp_name_isnull OR le.cnp_name_weight100 = 0 => 0,\n'
      + '                        le.cnp_name = ri.cnp_name  => le.cnp_name_weight100,\n'
      + '                        SALT30.Fn_Fail_Scale(le.cnp_name_weight100,s.cnp_name_switch));\n'
      + '  INTEGER2 cnp_number_score_temp := MAP(                         le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,\n'
      + '                        SALT30.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));\n'
      + '  INTEGER2 active_enterprise_number_score_temp := MAP( le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,\n'
      + '                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,\n'
      + '                        SALT30.Fn_Fail_Scale(le.active_enterprise_number_weight100,s.active_enterprise_number_switch));\n'
      + '  INTEGER2 active_domestic_corp_key_score_temp := MAP( le.active_domestic_corp_key_isnull OR ri.active_domestic_corp_key_isnull => 0,\n'
      + '                        le.active_domestic_corp_key = ri.active_domestic_corp_key  => le.active_domestic_corp_key_weight100,\n'
      + '                        SALT30.Fn_Fail_Scale(le.active_domestic_corp_key_weight100,s.active_domestic_corp_key_switch));\n'
      + '  INTEGER2 cnp_name_score := IF ( cnp_name_score_temp > Config.cnp_name_Force * 100, cnp_name_score_temp, SKIP ); // Enforce FORCE parameter\n'
      + '  INTEGER2 cnp_number_score := IF ( cnp_number_score_temp >= Config.cnp_number_Force * 100, cnp_number_score_temp, SKIP ); // Enforce FORCE parameter\n'
      + '  INTEGER2 active_enterprise_number_score := IF ( active_enterprise_number_score_temp >= Config.active_enterprise_number_Force * 100, active_enterprise_number_score_temp, SKIP ); // Enforce FORCE parameter\n'
      + '  INTEGER2 active_domestic_corp_key_score := IF ( active_domestic_corp_key_score_temp >= Config.active_domestic_corp_key_Force * 100, active_domestic_corp_key_score_temp, SKIP ); // Enforce FORCE parameter\n'
      + '  SELF.Conf_Prop := (cnp_name_score + cnp_number_score + active_enterprise_number_score + active_domestic_corp_key_score) / 100; // Score based on forced fields\n'
      + '  SELF.Conf := ri.Basis_weight100/100;\n'
      + 'END;\n'
      + 'Matches0 := DISTRIBUTE(JOIN(Cands,Cands,LEFT.Basis = RIGHT.Basis AND LEFT.Proxid > RIGHT.Proxid,Score(LEFT,RIGHT)),Proxid1+Proxid2);\n'
      + ' \n'
      + 'EXPORT Match := DEDUP( SORT(Matches0,Proxid1,Proxid2,-(Conf+Conf_Prop),Source_Id,LOCAL),Proxid1,Proxid2,KEEP(1),LOCAL ); // Keep 1 source_ids per match                                                      \n'
      + '\n'
      + 'END;\n'
          ;
    HackKeys_message := if(IndexNum  != 2,'','Did not Hack ' + pAttribute + ' because it has ' + (string)IndexNum + ' rollups in it, which likely mean it was already hacked.\n');
    saveatt := fPutAttribute(pAttribute,HackKeys);
    
    return sequential(iff(pShouldSaveAttribute  and IndexNum = 0,saveatt  ,output(dataset([{HackKeys}],{string ecl}),named(pAttribute + 'HackedEcl'))),output(HackKeys_message  ,named(pAttribute + 'Hack_message')));
  END;

  /////////////Basic Match
  export fHackBasicMatch(
  
     string   pAttribute            = 'BasicMatch' 
    ,boolean  pShouldSaveAttribute  = false
    
  ) :=
  function
  
    EclCode   := fGetAttribute(pAttribute) : independent;
    
    hackBasicMatchCondition := pAttribute = 'BasicMatch' and not regexfind('h05',EclCode,nocase);
//////////////////
    grabh01fields := regexreplace('^.*?h01.*?sort.*?(,[^)]*).*$',EclCode      ,'$1' ,nocase);
    removeproxid  := regexreplace(',Proxid'                     ,grabh01fields,''   ,nocase);
    
    h01 := 'h01 := SORT      (h00_match '   + grabh01fields     + ',local);\n';
    h02 := 'h02 := DEDUP     (h01       '   + removeproxid      + ',local);\n';
    h03 := 'h03 := DISTRIBUTE(h02,hash64('  + removeproxid[2..] + '));\n';
    h04 := 'h04 := SORT      (h03       '   + grabh01fields     + ',local);\n';
    h05 := 'h05 := DEDUP     (h04       '   + removeproxid      + ',local);\n';
    Match := 'Match := JOIN(h05,';

    allhackedecl := h01 + h02 + h03 + h04 + h05 + Match;
    
//////////////    
    HackBasicMatch := if(hackBasicMatchCondition 
                        ,regexreplace('h01[[:space:]]*:=.*?Match[[:space:]]*:=[[:space:]]*JOIN[(]h02,',EclCode,allhackedecl,nocase)
                        ,EclCode
                     );
    HackBasicMatch_message := if(hackBasicMatchCondition ,'','Did not Hack ' + pAttribute + ' to fix dedup skew\n');


    saveatt := fPutAttribute(pAttribute,HackBasicMatch);
    
    return sequential(iff(pShouldSaveAttribute  and hackBasicMatchCondition,saveatt  ,output(dataset([{HackBasicMatch}],{string ecl}),named(pAttribute + 'HackedEcl'))),output(HackBasicMatch_message  ,named(pAttribute + 'Hack_message')));
  END;

  /////////////fHackCompareService
  export fHackCompareService(
  
     string   pAttribute            = 'ProxidCompareService' 
    ,boolean  pShouldSaveAttribute  = false
    
  ) :=
  function
  
    EclCode         := fGetAttribute(pAttribute) : independent;
    AlreadyHacked   := STD.Str.FindCount( EclCode, '_fun_CompareService');
    HackKeys  := 
        '/*--SOAP--\n'
      + '<message name="ProxidCompareService">\n'
      + '<part name="ProxidOne" type="xsd:string"/>\n'
      + '<part name="ProxidTwo" type="xsd:string"/>\n'
      + '</message>\n'
      + '*/\n'
      + '/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/\n'
      + 'EXPORT ProxidCompareService := MACRO\n'
      + 'IMPORT SALT24,BIPV2_ProxID_mj6_PlatForm,ut,tools;\n'
      + 'STRING50 Proxidonestr := \'1234\'  : STORED(\'ProxidOne\');\n'
      + 'STRING20 Proxidtwostr := \'12345\'  : STORED(\'Proxidtwo\');\n'
      + 'combo := \'qa\';\n'
      + '\n'
      + 'BIPV2_ProxID_mj6_PlatForm._fun_CompareService((unsigned6)Proxidonestr,(unsigned6)Proxidtwostr,combo);\n'
      + 'ENDMACRO;\n'
      ;
    HackKeys_message  := if(AlreadyHacked  = 0,'','Did not Hack ' + pAttribute + ' because it has tools.mac_LayoutTools in it, which likely means it was already hacked.\n');
    saveatt           := fPutAttribute(pAttribute,HackKeys);
    
    return sequential(iff(pShouldSaveAttribute  and AlreadyHacked = 0,saveatt  ,output(dataset([{HackKeys}],{string ecl}),named(pAttribute + 'HackedEcl'))),output(HackKeys_message  ,named(pAttribute + 'Hack_message')));
  END;

  /////////////Fields
  export fHackFields(
  
     string   pAttribute            = 'Fields' 
    ,boolean  pShouldSaveAttribute  = false
    
  ) :=
  function

// 2)	In the Fields attribute, add this line immediately before proxid_Twoparents:
  // f_thin := TABLE(f(proxid<>0,lgid3<>0),{proxid,lgid3},proxid,lgid3,MERGE); // HACK
// and then change the self-JOIN parameters to reference f_thin instead of f
// 3)	Do the same as #2 for lgid3_Twoparents and orgid_Twoparents, with the applicable field-pairs for each
// 4)	Also near the end of the Fields attribute, change each of the "*_Unbased" JOINs so the left side will filter-out null values... "f" becomes "f(parentid<>0)"
/*
  EXPORT Proxid_Twoparents := DEDUP(JOIN(f,f,LEFT.Proxid=RIGHT.Proxid AND LEFT.lgid3>RIGHT.lgid3,TRANSFORM({SALT30.UIDType lgid31,SALT30.UIDType Proxid,SALT30.UIDType lgid32},SELF.lgid31:=LEFT.lgid3,SELF.lgid32:=RIGHT.lgid3,SELF.Proxid:=LEFT.Proxid),HASH),WHOLE RECORD,ALL);
  EXPORT lgid3_Twoparents := DEDUP(JOIN(f,f,LEFT.lgid3=RIGHT.lgid3 AND LEFT.orgid>RIGHT.orgid,TRANSFORM({SALT30.UIDType orgid1,SALT30.UIDType lgid3,SALT30.UIDType orgid2},SELF.orgid1:=LEFT.orgid,SELF.orgid2:=RIGHT.orgid,SELF.lgid3:=LEFT.lgid3),HASH),WHOLE RECORD,ALL);
  EXPORT orgid_Twoparents := DEDUP(JOIN(f,f,LEFT.orgid=RIGHT.orgid AND LEFT.ultid>RIGHT.ultid,TRANSFORM({SALT30.UIDType ultid1,SALT30.UIDType orgid,SALT30.UIDType ultid2},SELF.ultid1:=LEFT.ultid,SELF.ultid2:=RIGHT.ultid,SELF.orgid:=LEFT.orgid),HASH),WHOLE RECORD,ALL);

  EXPORT Proxid_Unbased := JOIN(f,bases,LEFT.Proxid=RIGHT.Proxid,TRANSFORM(LEFT),LEFT ONLY,HASH);
  EXPORT lgid3_Unbased := JOIN(f,bases,LEFT.lgid3=RIGHT.lgid3,TRANSFORM(LEFT),LEFT ONLY,HASH);
  EXPORT orgid_Unbased := JOIN(f,bases,LEFT.orgid=RIGHT.orgid,TRANSFORM(LEFT),LEFT ONLY,HASH);
  EXPORT ultid_Unbased := JOIN(f,bases,LEFT.ultid=RIGHT.ultid,TRANSFORM(LEFT),LEFT ONLY,HASH);
*/
  
    EclCode   := fGetAttribute(pAttribute) : independent;
    
    // Proxid Two Parents hack
    hackProxidTwoParentsEcl := '(EXPORT Proxid_Twoparents := DEDUP[(]JOIN[(])f,f,(LEFT[.]Proxid=RIGHT[.]Proxid AND LEFT[.]lgid3>RIGHT[.]lgid3,TRANSFORM[(][{]SALT30[.]UIDType lgid31,SALT30[.]UIDType Proxid,SALT30[.]UIDType lgid32[}],SELF[.]lgid31:=LEFT[.]lgid3,SELF[.]lgid32:=RIGHT[.]lgid3,SELF[.]Proxid:=LEFT[.]Proxid[)],HASH[)],WHOLE RECORD,ALL[)];)';
    
    hackProxidTwoParentsCondition := pAttribute = 'Fields' and regexfind(hackProxidTwoParentsEcl,EclCode,nocase);
    
    HackProxidTwoParents := if(hackProxidTwoParentsCondition 
                        ,regexreplace(
                          hackProxidTwoParentsEcl
                        ,EclCode,
                          'f_thin := TABLE(f(proxid<>0,lgid3<>0),{proxid,lgid3},proxid,lgid3,MERGE); // HACK Proxid two parents to dedup self join dataset\n'
                        + '$1 f_thin,f_thin, $2 /* HACK - Proxid Two Parents to dedup dataset*/\n'
                        ,nocase) 
                        ,EclCode
                     );
    HackProxidTwoParents_message := if(hackProxidTwoParentsCondition ,'','' + ' ,Did not Hack ' + pAttribute + ' hacking Proxid_Twoparents\n');

    // lgid3 Two Parents hack
    hacklgid3TwoParentsEcl := '(EXPORT lgid3_Twoparents := DEDUP[(]JOIN[(])f,f,(LEFT[.]lgid3=RIGHT[.]lgid3 AND LEFT[.]orgid>RIGHT[.]orgid,TRANSFORM[(][{]SALT30[.]UIDType orgid1,SALT30[.]UIDType lgid3,SALT30[.]UIDType orgid2[}],SELF[.]orgid1:=LEFT[.]orgid,SELF[.]orgid2:=RIGHT[.]orgid,SELF[.]lgid3:=LEFT[.]lgid3[)],HASH[)],WHOLE RECORD,ALL[)];)';
    
    hacklgid3TwoParentsCondition := pAttribute = 'Fields' and regexfind(hacklgid3TwoParentsEcl,HackProxidTwoParents,nocase);
    
    Hacklgid3TwoParents := if(hacklgid3TwoParentsCondition 
                        ,regexreplace(
                          hacklgid3TwoParentsEcl
                        ,HackProxidTwoParents,
                          'f_thin := TABLE(f(lgid3<>0,orgid<>0),{lgid3,orgid},lgid3,orgid,MERGE); // HACK lgid3 two parents to dedup self join dataset\n'
                        + '$1 f_thin,f_thin, $2 /* HACK - lgid3 Two Parents to dedup dataset*/\n'
                        ,nocase) 
                        ,HackProxidTwoParents
                     );
    Hacklgid3TwoParents_message := if(hacklgid3TwoParentsCondition ,HackProxidTwoParents_message,HackProxidTwoParents_message + ' ,Did not Hack ' + pAttribute + ' hacking lgid3_Twoparents\n');

    // orgid Two Parents hack
    hackorgidTwoParentsEcl := '(EXPORT orgid_Twoparents := DEDUP[(]JOIN[(])f,f,(LEFT[.]orgid=RIGHT[.]orgid AND LEFT[.]ultid>RIGHT[.]ultid,TRANSFORM[(][{]SALT30[.]UIDType ultid1,SALT30[.]UIDType orgid,SALT30[.]UIDType ultid2[}],SELF[.]ultid1:=LEFT[.]ultid,SELF[.]ultid2:=RIGHT[.]ultid,SELF[.]orgid:=LEFT[.]orgid[)],HASH[)],WHOLE RECORD,ALL[)];)';
    
    hackorgidTwoParentsCondition := pAttribute = 'Fields' and regexfind(hackorgidTwoParentsEcl,Hacklgid3TwoParents,nocase);
    
    HackorgidTwoParents := if(hackorgidTwoParentsCondition 
                        ,regexreplace(
                          hackorgidTwoParentsEcl
                        ,Hacklgid3TwoParents,
                          'f_thin := TABLE(f(orgid<>0,ultid<>0),{orgid,ultid},orgid,ultid,MERGE); // HACK orgid two parents to dedup self join dataset\n'
                        + '$1 f_thin,f_thin, $2 /* HACK - orgid Two Parents to dedup dataset*/\n'
                        ,nocase) 
                        ,Hacklgid3TwoParents
                     );
    HackorgidTwoParents_message := if(hackorgidTwoParentsCondition ,Hacklgid3TwoParents_message,Hacklgid3TwoParents_message + ' ,Did not Hack ' + pAttribute + ' hacking orgid_Twoparents\n');

    // Proxid Unbased hack
    hackProxidUnbasedEcl := '(EXPORT Proxid_Unbased := JOIN[(]f)(,bases,LEFT[.]Proxid=RIGHT[.]Proxid,TRANSFORM[(]LEFT[)],LEFT ONLY,HASH[)];)';

    hackProxidUnbasedCondition := pAttribute = 'Fields' and regexfind(hackProxidUnbasedEcl,HackorgidTwoParents,nocase);
    
    HackProxidUnbased := if(hackProxidUnbasedCondition 
                        ,regexreplace(
                          hackProxidUnbasedEcl
                        ,HackorgidTwoParents,
                          '$1 (Proxid<>0) $2 // HACK Proxid Unbased.  Add filter\n'
                        ,nocase) 
                        ,HackorgidTwoParents
                     );
    HackProxidUnbased_message := if(hackProxidUnbasedCondition ,HackorgidTwoParents_message,HackorgidTwoParents_message + ' ,Did not Hack ' + pAttribute + ' hacking ProxidUnbased\n');

    // lgid3 Unbased hack
    hacklgid3UnbasedEcl := '(EXPORT lgid3_Unbased := JOIN[(]f)(,bases,LEFT[.]lgid3=RIGHT[.]lgid3,TRANSFORM[(]LEFT[)],LEFT ONLY,HASH[)];)';
    
    hacklgid3UnbasedCondition := pAttribute = 'Fields' and regexfind(hacklgid3UnbasedEcl,HackProxidUnbased,nocase);
    
    Hacklgid3Unbased := if(hacklgid3UnbasedCondition 
                        ,regexreplace(
                          hacklgid3UnbasedEcl
                        ,HackProxidUnbased,
                          '$1 (lgid3<>0) $2 // HACK lgid3 Unbased.  Add filter\n'
                        ,nocase) 
                        ,HackProxidUnbased
                     );
    Hacklgid3Unbased_message := if(hacklgid3UnbasedCondition ,HackProxidUnbased_message,HackProxidUnbased_message + ' ,Did not Hack ' + pAttribute + ' hacking lgid3Unbased\n');

    // orgid Unbased hack
    hackorgidUnbasedEcl := '(EXPORT orgid_Unbased := JOIN[(]f)(,bases,LEFT[.]orgid=RIGHT[.]orgid,TRANSFORM[(]LEFT[)],LEFT ONLY,HASH[)];)';
    
    hackorgidUnbasedCondition := pAttribute = 'Fields' and regexfind(hackorgidUnbasedEcl,Hacklgid3Unbased,nocase);
    
    HackorgidUnbased := if(hackorgidUnbasedCondition 
                        ,regexreplace(
                          hackorgidUnbasedEcl
                        ,Hacklgid3Unbased,
                          '$1 (orgid<>0) $2 // HACK orgid Unbased.  Add filter\n'
                        ,nocase) 
                        ,Hacklgid3Unbased
                     );
    HackorgidUnbased_message := if(hackorgidUnbasedCondition ,Hacklgid3Unbased_message,Hacklgid3Unbased_message + ' ,Did not Hack ' + pAttribute + ' hacking orgidUnbased\n');

    // ultid Unbased hack
    hackultidUnbasedEcl := '(EXPORT ultid_Unbased := JOIN[(]f)(,bases,LEFT[.]ultid=RIGHT[.]ultid,TRANSFORM[(]LEFT[)],LEFT ONLY,HASH[)];)';
    
    hackultidUnbasedCondition := pAttribute = 'Fields' and regexfind(hackultidUnbasedEcl,HackorgidUnbased,nocase);
    
    HackultidUnbased := if(hackultidUnbasedCondition 
                        ,regexreplace(
                          hackultidUnbasedEcl
                        ,HackorgidUnbased,
                          '$1 (ultid<>0) $2 // HACK ultid Unbased.  Add filter\n'
                        ,nocase) 
                        ,HackorgidUnbased
                     );
    HackultidUnbased_message := if(hackultidUnbasedCondition ,HackorgidUnbased_message,HackorgidUnbased_message + ' ,Did not Hack ' + pAttribute + ' hacking ultidUnbased\n');

    // id integrity speed up hack
    hackIDIntegritySpeedBoostEcl := '(f := TABLE[(]infile,[{]Proxid,rcid,lgid3,orgid,ultid[}][)]);';
    
    hackIDIntegritySpeedBoostCondition := pAttribute = 'Fields' and regexfind(hackIDIntegritySpeedBoostEcl,HackultidUnbased,nocase);
    
    HackIDIntegritySpeedBoost := if(hackIDIntegritySpeedBoostCondition 
                        ,regexreplace(
                          hackIDIntegritySpeedBoostEcl
                        ,HackultidUnbased,
                          '$1 : global; // HACK IDIntegrity to speed it up\n'
                        ,nocase) 
                        ,HackultidUnbased
                     );
    HackIDIntegritySpeedBoost_message := if(hackIDIntegritySpeedBoostCondition ,HackultidUnbased_message,HackultidUnbased_message + ' ,Did not Hack ' + pAttribute + ' hacking IDIntegritySpeedBoost\n');

    // Save Attribute
    saveatt := fPutAttribute(pAttribute,HackIDIntegritySpeedBoost);
    
    all_conditions := (hackProxidTwoParentsCondition or hacklgid3TwoParentsCondition or hackorgidTwoParentsCondition or hackProxidUnbasedCondition or hacklgid3UnbasedCondition or hackorgidUnbasedCondition or hackultidUnbasedCondition or hackIDIntegritySpeedBoostCondition);
    
    return sequential(iff(pShouldSaveAttribute  and all_conditions,saveatt  ,output(dataset([{HackIDIntegritySpeedBoost}],{string ecl}),named(pAttribute + 'HackedEcl'))),output(HackIDIntegritySpeedBoost_message  ,named(pAttribute + 'Hack_message')));
    
  END;

  /////////////Best or match_candidates
  export fHackMC(
  
     string   pAttribute            = 'match_candidates' 
    ,boolean  pShouldSaveAttribute  = false
    
  ) :=
  function
  
    EclCode   := fGetAttribute(pAttribute) : independent;
    
///////
    hackRemoveParallelMatchEcl := 'HASH,HINT[(]parallel_match[)][)];';
    
    hackRemoveParallelMatchCondition := pAttribute in ['match_candidates'] and regexfind(hackRemoveParallelMatchEcl,EclCode,nocase);
    
    HackRemoveParallelMatch := if(hackRemoveParallelMatchCondition 
                        ,regexreplace(
                          hackRemoveParallelMatchEcl
                        ,EclCode,
                          'HASH/*,HINT(parallel_match)*/);  //HACK comment out hint(parallel_match) for now\n'
                        ,nocase) 
                        ,EclCode
                     );
    HackRemoveParallelMatch_message := if(hackRemoveParallelMatchCondition ,'','' + ' ,Did not Hack ' + pAttribute + ' removing hint(parallel_match)\n');

    // Save Attribute
    saveatt := fPutAttribute(pAttribute,HackRemoveParallelMatch);
    
    all_conditions := (HackRemoveParallelMatchCondition);
    
    return sequential(iff(pShouldSaveAttribute  and all_conditions,saveatt  ,output(dataset([{HackRemoveParallelMatch}],{string ecl}),named(pAttribute + 'HackedEcl'))),output(HackRemoveParallelMatch_message  ,named(pAttribute + 'Hack_message')));
    
  END;

  /////////////Config

  export fHackConfig(
  
     string   pAttribute            = 'Config' 
    ,boolean  pShouldSaveAttribute  = false
    
  ) :=
  function
  
    EclCode   := fGetAttribute(pAttribute) : independent;
    
    hackConfigCondition := pAttribute = 'Config' and not regexfind('DoSliceouts := false',EclCode,nocase);

    HackConfig := if(hackConfigCondition 
                        ,regexreplace('DoSliceouts := TRUE',EclCode,'DoSliceouts := false',nocase)
                        ,EclCode
                     );
    HackConfig_message := if(hackConfigCondition ,'','Did not Hack ' + pAttribute + ' to disable Sliceouts\n');


//////////////////
        
   hackMatchThresholdCondition := pAttribute = 'Config' and not regexfind('MatchThreshold := 0',HackConfig,nocase);

    HackMatchThreshold := if(hackMatchThresholdCondition 
                        ,regexreplace('MatchThreshold := [[:digit:]]{1,2};',HackConfig,'MatchThreshold := 0; /*HACK to ensure matchthreshold is zero.  matching is done by FORCE(s) alone.*/',nocase)
                        ,HackConfig
                     );
    HackMatchThreshold_message := if(hackMatchThresholdCondition ,HackConfig_message,HackConfig_message + 'Did not Hack ' + pAttribute + ' to change MatchThreshold to zero\n');

//////////////    

    saveatt := fPutAttribute(pAttribute,HackMatchThreshold);
    
    return sequential(iff(pShouldSaveAttribute  and HackMatchThresholdCondition,saveatt  ,output(dataset([{HackMatchThreshold}],{string ecl}),named(pAttribute + 'HackedEcl'))),output(HackMatchThreshold_message  ,named(pAttribute + 'Hack_message')));
  END;

//////////////////////////////
//////////////////////////////
  export fHackProc_Iterate(
  
     string   pAttribute            = 'Proc_Iterate' 
    ,boolean  pShouldSaveAttribute  = false
    
  ) :=
  function
  
    EclCode   := fGetAttribute(pAttribute) : independent;
    
    hackProc_IterateCondition := pAttribute = 'Proc_Iterate' and not regexfind(',string keyversion',EclCode,nocase);

    HackProc_Iterate := if(hackProc_IterateCondition 
                        ,regexreplace('STRING iter',EclCode,'STRING iter,string keyversion/*HACK -- add keyversion*/',nocase)
                        ,EclCode
                     );
    HackProc_Iterate_message := if(hackProc_IterateCondition ,'','Did not Hack ' + pAttribute + ' to add keyversion to parameters.\n');


//////
    hackkeycallEcl := 'Keys[(]InFile[)].BuildAll';
    
    hackkeycallCondition := pAttribute = 'Proc_Iterate' and regexfind(hackkeycallEcl,HackProc_Iterate,nocase);
    
    Hackkeycall := if(hackkeycallCondition 
                        ,regexreplace(
                          hackkeycallEcl
                        ,HackProc_Iterate,
                          'Keys(InFile,keyversion).BuildAll; // HACK keys to add keyersion'
                        ,nocase) 
                        ,HackProc_Iterate
                     );
    Hackkeycall_message := if(hackkeycallCondition ,HackProc_Iterate_message,HackProc_Iterate_message + ' ,Did not Hack ' + pAttribute + ' to add keyversion parameter to keys call.\n');

//////
    hackOutputChangesEcl := 'changes_it\'[+]iter;';
    
    hackOutputChangesCondition := pAttribute = 'Proc_Iterate' and regexfind(hackOutputChangesEcl,Hackkeycall,nocase);
    
    hackOutputChanges := if(hackOutputChangesCondition 
                        ,regexreplace(
                          hackOutputChangesEcl
                        ,Hackkeycall,
                          'changes_it\'+keyversion;/* HACK use keyversion for changes file*/'
                        ,nocase) 
                        ,Hackkeycall
                     );
    hackOutputChanges_message := if(hackOutputChangesCondition ,Hackkeycall_message,Hackkeycall_message + ' ,Did not Hack ' + pAttribute + ' to change to keyversion for changes file.\n');

    saveatt := fPutAttribute(pAttribute,hackOutputChanges);
    
    return sequential(iff(pShouldSaveAttribute  and hackOutputChangesCondition,saveatt  ,output(dataset([{hackOutputChanges}],{string ecl}),named(pAttribute + 'HackedEcl'))),output(hackOutputChanges_message  ,named(pAttribute + 'Hack_message')));
  END;


  export do_all_hacks := 
    sequential(
       fHackDebugNMatches         ('matches'                 ,pShouldSaveAttributes)
      ,fHackDebugNMatches         ('Debug'                   ,pShouldSaveAttributes)
      ,fHackKeys                  ('Keys'                    ,pShouldSaveAttributes)
      ,fHackModFkey               ('MOD_Attr_ForeignCorpkey' ,pShouldSaveAttributes)
      ,fHackBasicMatch            ('BasicMatch'              ,pShouldSaveAttributes)
      ,fHackCompareService        ('ProxidCompareService'    ,pShouldSaveAttributes)
      ,fHackFields                ('Fields'                  ,pShouldSaveAttributes)
      ,fHackMC                    ('match_candidates'        ,pShouldSaveAttributes)
      ,fHackConfig                ('Config'                  ,pShouldSaveAttributes)
      ,fHackProc_Iterate          ('Proc_Iterate'            ,pShouldSaveAttributes)
    );
end;
