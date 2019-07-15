import SALTTOOLS22,STD,wk_ut;
/*
  lower overall score to 30 -- check
  make prim_name_derived force score a 5 to accomodate hwy -> highway matching  -- check
  additional hacks
  1. cnp_name, address equal hack to match score in matches, debug-- check
  2. hack to mj0 to add blocking criteria to remove cnp_name, address equal from that join(to prevent it blowing up)  -- check
  3. hack to mj0 to add blocking criteria prim_name_derived to that join to make it go faster.  will hack mj extra to allow for multiple prim_name_deriveds -- check
  4. hack BIPV2_ProxID.MOD_Attr_FilterPrimNames to fix it so it runs -- check
  
*/
EXPORT _ApplyProxidHacks(
   string   pModule               = 'BIPV2_ProxID'
  ,string   pEsp                  = 'dataland_esp.br.seisint.com:8145'
  ,boolean  pShouldSaveAttributes = false
) :=
module
  EXPORT fGetAttribute(STRING att                 ):=SALTTOOLS22.mod_Soapcalls.fGetAttributes(pModule,att,pEsp)(COUNT(results)>0)[1].results[1].Text;
  EXPORT fPutAttribute(STRING att,STRING ecl_text ):=OUTPUT(SALTTOOLS22.mod_Soapcalls.fSaveAttribute(pModule,att,ecl_text,pEsp));
  
/*
  BIPV2_ProxID.matches: hack default force for cnp_number,cnp_name & prim_range(make sure they equal each other) in matchjoin attribute
                        add logic so that one side of cnp_name match(when SUPPORTED) is a DBA
                        add mj1 add "AND LEFT.cnp_name[1..4] = RIGHT.cnp_name[1..4]" to join condition and to atmost
                        add mj2 add "AND LEFT.sec_range = RIGHT.sec_range" to join condition and to atmost
                        add all mjs up here:
                        last_mjs_t :=mj0 + mj1 + mj2;
  BIPV2_ProxID.Debug:   hack sample match join to match hacks in matchjoin in matches.            
                        change match sample key so it's score is correct
*/
  export fHackDebugNMatches(
  
     string   pAttribute            = 'Debug' //this can be used for Debug and matches attributes
    ,boolean  pShouldSaveAttribute  = false
    
  ) :=
  function
  
    EclCode := fGetAttribute(pAttribute) : independent;
//  INTEGER2 cnp_number_score := IF ( le.cnp_number = ri.cnp_number or cnp_number_score_temp >= 0, cnp_number_score_temp, SKIP ); // Enforce FORCE parameter
    hackCnpNumberCondition := regexfind('(cnp_number_score := if [(])([^,]+),([^\n]+)',EclCode,nocase) and not regexfind('(cnp_number_score := if [(])[ ]*le.cnp_number = ri.cnp_number [ ]*([^\n]+)',EclCode,nocase);
    
    HackCnpNumber := if(hackCnpNumberCondition 
                        ,regexreplace('(cnp_number_score := if [(])([^,]+),([^\n]+)',EclCode,'$1 le.cnp_number = ri.cnp_number /* $2 */ ,$3',nocase) 
                        ,EclCode
                     );
    HackCnpNumber_message := if(hackCnpNumberCondition  ,'','Did not Hack ' + pAttribute + ' cnp_number\n');
    
//  INTEGER2 prim_range_score := IF ( le.prim_range = ri.prim_range or prim_range_score_temp >= 0 OR company_addr1_score_pre > 0 OR company_address_score_pre > 0, prim_range_score_temp, SKIP ); // Enforce FORCE parameter
    hackPrimRangeCondition := regexfind('prim_range_derived_score := if [(]',HackCnpNumber,nocase) and not regexfind('(prim_range_derived_score := if [(])[ ]*le.prim_range_derived = ri.prim_range_derived or[ ]*([^\n]+)',HackCnpNumber,nocase) ;
    HackPrimRange := if( hackPrimRangeCondition
                        ,regexreplace('(prim_range_derived_score := if [(])([^\n]+)',HackCnpNumber,'$1 le.prim_range_derived = ri.prim_range_derived or $2',nocase) 
                        ,HackCnpNumber
                     );
    HackPrimRange_message := if(hackPrimRangeCondition  ,HackCnpNumber_message,HackCnpNumber_message + ', Did not Hack ' + pAttribute + ' prim_range_derived\n');
    
    SkipOr9999            := if(pAttribute = 'Debug'  ,'-9999','SKIP');
    activedomesticcorpkey := if(pAttribute = 'Debug'  ,'SELF.active_domestic_corp_key_score'  ,'active_domestic_corp_key_score' );
    companyfein           := if(pAttribute = 'Debug'  ,'SELF.company_fein_score'              ,'company_fein_score'             );
    activedunsnumber      := if(pAttribute = 'Debug'  ,'SELF.active_duns_number_score'        ,'active_duns_number_score'       );
    histdunsnumber        := if(pAttribute = 'Debug'  ,'SELF.hist_duns_number_score'          ,'hist_duns_number_score'         );
                             // INTEGER2 cnp_name_score := IF ( cnp_name_score_supp >= Config.cnp_name_Force * 100 OR ( active_domestic_corp_key_score > Config.cnp_name_OR1_active_domestic_corp_key_Force*100) OR ( active_duns_number_score > Config.cnp_name_OR2_active_duns_number_Force*100), cnp_name_score_supp, SKIP ); // Enforce FORCE parameter
    cnp_name_regex        := 'cnp_name_score := IF [(] cnp_name_score_supp >= Config.cnp_name_Force [*] 100 OR [(][ ]*' + activedomesticcorpkey + ' > Config.cnp_name_OR1_active_domestic_corp_key_Force[*]100[)] OR [(][ ]*' + activedunsnumber      + ' > Config.cnp_name_OR2_active_duns_number_Force[*]100[)] OR [(][ ]*' + companyfein + ' > Config.cnp_name_OR3_company_fein_Force[*]100[)], cnp_name_score_supp, ' + SkipOr9999 + ' [)];';
    hackCnpNameCondition  := regexfind(cnp_name_regex,HackPrimRange,nocase) ;
    HackCnpName := if(hackCnpNameCondition
                        ,regexreplace(cnp_name_regex,HackPrimRange,
                          'cnp_name_score := MAP ( le.cnp_name = ri.cnp_name \n'
                        + '    or (cnp_name_score_supp >= Config.cnp_name_Force * 100 and cnp_name_support = 0)\n' 
                        + '    or (cnp_name_score_supp >= Config.cnp_name_Force * 100 and cnp_name_score_temp < Config.cnp_name_Force * 100 and cnp_name_support > 0 /*and regexfind(\'fbn|dba|fictitious|assumed|trade\',le.company_name_type_raw + le.company_name_type_derived + ri.company_name_type_raw + ri.company_name_type_derived,nocase)*/)  \n'  
                        + '    => cnp_name_score_supp\n'
                        + '    ,' + activedomesticcorpkey + ' > Config.active_domestic_corp_key_Force*100 and regexfind(\'fbn|dba|fictitious|assumed|trade\',le.company_name_type_raw + le.company_name_type_derived + ri.company_name_type_raw + ri.company_name_type_derived,nocase)\n'
                        + '    => ' + activedomesticcorpkey + '\n'
                        + '    ,' + activedunsnumber      + ' > Config.active_duns_number_Force      *100 and regexfind(\'fbn|dba|fictitious|assumed|trade\',le.company_name_type_raw + le.company_name_type_derived + ri.company_name_type_raw + ri.company_name_type_derived,nocase)\n'
                        + '    => ' + activedunsnumber + '\n'
                        + '    ,' + companyfein           + ' > Config.company_fein_Force            *100 and regexfind(\'fbn|dba|fictitious|assumed|trade\',le.company_name_type_raw + le.company_name_type_derived + ri.company_name_type_raw + ri.company_name_type_derived,nocase)\n'
                        + '    => ' + companyfein      + '\n'
                        // + '    ,' + histdunsnumber        + ' > Config.hist_duns_number_Force        *100 and regexfind(\'fbn|dba|fictitious|assumed|trade\',le.company_name_type_raw + le.company_name_type_derived + ri.company_name_type_raw + ri.company_name_type_derived,nocase)\n'
                        // + '    => ' + histdunsnumber + '\n'
                        + '    , ' + SkipOr9999 + ' );'
                        ,nocase) 
                        ,HackPrimRange
                     );
    HackCnpName_message := if(hackCnpNameCondition  ,HackPrimRange_message,HackPrimRange_message + ', Did not Hack ' + pAttribute + ' cnp_name\n');
/////////hack debug scores for attribute files
    DebugScoresRegex                  := 'END;[ \n\r\t]*SHARED AppendAttribs.*END;[ \n\r\t]*EXPORT Layout_RolledEntity';
    hackAttFileDebugScoresCondition   := pAttribute = 'Debug' and regexfind(DebugScoresRegex,HackCnpName,nocase) ;
    HackAttFileDebugScores := if(hackAttFileDebugScoresCondition
                        ,regexreplace(DebugScoresRegex,HackCnpName,
                          'END;\n'
                        + 'SHARED AppendAttribs(DATASET(layout_sample_matches) am,DATASET(match_candidates(ih).layout_attribute_matches) ia) := FUNCTION\n'
                        + '  Layout_Sample_Matches add_attr(am le, ia ri) := TRANSFORM\n'
                        + '    SELF.Attribute_Conf := ri.Conf;\n'
                        + '    SELF.Matching_Attributes := ri.Source_Id;\n'
                        + '    SELF.Conf := le.Conf + ri.Conf;\n'
                        + '  SELF.support_cnp_name := le.support_cnp_name+ri.support_cnp_name;\n'
                        + '    SELF := le;\n'
                        + '  END;\n'
                        + '  RETURN JOIN(am,ia,LEFT.Proxid1=RIGHT.Proxid1 AND LEFT.Proxid2=RIGHT.Proxid2,add_attr(LEFT,RIGHT),LEFT OUTER,HASH);\n'
                        + 'END;\n'
                        + '  \n'
                        + 'EXPORT AnnotateMatchesFromRecordData(DATASET(match_candidates(ih).layout_candidates) in_data  ,DATASET(match_candidates(ih).layout_matches)  im,DATASET(match_candidates(ih).layout_attribute_matches) ia) := FUNCTION//Faster form when rcid known\n'
                        + '\n'
                        + '  p0 := project(im,transform(match_candidates(ih).layout_attribute_matches,self := left,self := []));\n'
                        + '  j0 := join(p0,ia,left.proxid1 = right.proxid1 and left.proxid2 = right.proxid2,transform(match_candidates(ih).layout_attribute_matches,self.support_cnp_name := right.support_cnp_name,self.source_id := right.source_id,self := left,self := []),left outer,hash);\n'
                        + '  \n'
                        + '  j1 := JOIN(in_data,j0,LEFT.rcid = RIGHT.rcid1,HASH);\n'
                        + '  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM\n'
                        + '    SELF := le;\n'
                        + '  END;\n'
                        + '//  output(topn(ia,100,proxid1,proxid2),named(\'ia\'));\n'
                        + '//  output(topn(ia,100,proxid2,proxid1),named(\'ia_reverse\'));\n'
                        + '//  output(choosen(p0,100),named(\'p0\'));\n'
                        + '//  output(choosen(p0(rule = 10000),100),named(\'p0_rule10000\'));\n'
                        + '//  output(choosen(j0,100),named(\'j0\'));\n'
                        + '//  output(choosen(j0(support_cnp_name > 0),100),named(\'j0_withsupport\'));\n'
                        + '  returndataset := JOIN(j1,in_data,LEFT.rcid2 = RIGHT.rcid  ,sample_match_join( PROJECT(LEFT,strim(LEFT)) ,RIGHT,,left.support_cnp_name) ,HASH);\n'
                        + '//  output(choosen(returndataset(support_cnp_name > 0),100),named(\'returndataset\'));\n'
                        + '  \n'
                        + '  RETURN returndataset;\n'
                        + 'END;\n'
                        + '  \n'
                        + 'EXPORT AnnotateMatches(DATASET(match_candidates(ih).layout_matches)  im,dataset(Match_Candidates(ih).layout_attribute_matches) ia) := FUNCTION\n'
                        + '  RETURN AppendAttribs( AnnotateMatchesFromRecordData(h,im,ia), ia );\n'
                        + 'END;\n'
                        + '///////////////\n'
                        + '\n'
                        + 'EXPORT AnnotateMatchesFromData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im,dataset(Match_Candidates(ih).layout_attribute_matches) ia) := FUNCTION\n'
                        + '  j1 := JOIN(in_data,im,LEFT.Proxid = RIGHT.Proxid1,HASH);\n'
                        + '  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM\n'
                        + '    SELF := le;\n'
                        + '  END;\n'
                        + '  r := JOIN(j1,in_data,LEFT.Proxid2 = RIGHT.Proxid,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);\n'
                        + '  d := DEDUP( SORT( r, Proxid1, Proxid2, -Conf, LOCAL ), Proxid1, Proxid2, LOCAL ); // Proxid2 distributed by join\n'
                        + '  RETURN AppendAttribs( d, ia );\n'
                        + 'END;\n'
                        + '\n'
                        + 'EXPORT AnnotateClusterMatches(DATASET(match_candidates(ih).layout_candidates) in_data,salt30.UIDType BaseRecord) := FUNCTION//Faster form when rcid known\n'
                        + '  j1 := in_data(rcid = BaseRecord);\n'
                        + '  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM\n'
                        + '    SELF := le;\n'
                        + '  END;\n'
                        + '  RETURN JOIN(in_data(rcid<>BaseRecord),j1,TRUE,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),ALL);\n'
                        + 'END;\n'
                        + '\n'
                        + 'EXPORT Layout_RolledEntity'
                        ,nocase) 
                        ,HackCnpName
                     );
    HackAttFileDebugScores_message := if(hackAttFileDebugScoresCondition or pAttribute != 'Debug' ,HackCnpName_message,HackCnpName_message + ', Did not Hack ' + pAttribute + ' Attribute File Scores\n');
    
    //cnp_name, address perfect match--need to add debug here too
    overallscore          := if(pAttribute = 'Debug'  ,'SELF.Conf := [(]'     ,'iComp := '      );
    overallscoreparen     := if(pAttribute = 'Debug'  ,'('                    ,''               );
    hackscore             := if(pAttribute = 'Debug'  ,'9000 + iComp1'        ,'MatchThreshold' );
    scoreassignment       := if(pAttribute = 'Debug'  ,'SELF.Conf := iComp;\n',''               );
    hackOverallScoreCondition := regexfind(overallscore,HackAttFileDebugScores,nocase) and not regexfind('iComp1 := ',HackAttFileDebugScores,nocase);
    
    HackOverallScore := if(hackOverallScoreCondition 
                        ,regexreplace(overallscore + '([^\n]+)',HackAttFileDebugScores,
                          'iComp1 := ' + overallscoreparen + '$1\n' 
                        + 'iComp  := map( iComp1            >= MatchThreshold                                   => iComp1 \n'
                        + '              ,le.company_address = ri.company_address and le.cnp_name = ri.cnp_name and ut.nneq(le.active_duns_number,ri.active_duns_number)=> ' + hackscore + '\n'
                        + '              ,le.cnp_name = ri.cnp_name and  le.prim_range_derived = ri.prim_range_derived and le.prim_name_derived = ri.prim_name_derived and ut.nneq(le.v_city_name,ri.v_city_name) and le.st = ri.st and le.zip = ri.zip and ut.nneq(le.active_duns_number,ri.active_duns_number)=> ' + hackscore + '\n'
                        + '              ,                                                                         iComp1\n'
                        + '          );\n'
                        + scoreassignment
                        ,nocase) 
                        ,HackAttFileDebugScores
                     );
    HackOverallScore_message := if(hackOverallScoreCondition  ,HackAttFileDebugScores_message,HackAttFileDebugScores_message + ',Did not Hack ' + pAttribute + ' overall score(cnp name, address perfect match)\n');
    /////////////
    hackRemovePerfectMatchCondition := pAttribute = 'matches' and regexfind(',trans[(]LEFT,RIGHT,0[)]',HackOverallScore,nocase) and not regexfind('[(] left.cnp_name = right.cnp_name [)] AND [(] left.company_address = right.company_address [)]',HackOverallScore,nocase);
    
    HackRemovePerfectMatch := if(hackRemovePerfectMatchCondition 
                        ,regexreplace(',trans[(]LEFT,RIGHT,0[)]',HackOverallScore,
                          'AND ~(( left.cnp_name = right.cnp_name ) AND ( left.company_address = right.company_address )),trans(LEFT,RIGHT,0)'
                        ,nocase) 
                        ,HackOverallScore
                     );
    HackRemovePerfectMatch_message := if(hackRemovePerfectMatchCondition or pAttribute != 'matches' ,HackOverallScore_message,HackOverallScore_message + ',Did not Hack ' + pAttribute + ' removing perfect cnp name, address matches from mj0\n');
    /////////////
    hackAddPrimNameCondition := pAttribute = 'matches' and regexfind('LEFT.cnp_number = RIGHT.cnp_number',HackRemovePerfectMatch,nocase) and not regexfind('LEFT.prim_name_derived = RIGHT.prim_name_derived',HackRemovePerfectMatch,nocase);
    
    HackAddPrimName := if(hackAddPrimNameCondition 
                        ,regexreplace('LEFT.cnp_number = RIGHT.cnp_number',HackRemovePerfectMatch,
                          'LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_name_derived = RIGHT.prim_name_derived'
                        ,nocase) 
                        ,HackRemovePerfectMatch
                     );
    HackAddPrimName_message := if(hackAddPrimNameCondition or pAttribute != 'matches' ,HackRemovePerfectMatch_message,HackRemovePerfectMatch_message + ',Did not Hack ' + pAttribute + ' adding prim_name_derived equality condition to mj0\n');
    ///////////////
    
    // hackAddPrimNameBlankCondition := pAttribute = 'matches' and regexfind('AND [(] ~left[.]prim_name_derived_isnull AND ~right[.]prim_name_derived_isnull [)]',HackAddPrimName,nocase) and not regexfind('/*AND [(] ~left[.]prim_name_derived_isnull AND ~right[.]prim_name_derived_isnull [)]*/',HackAddPrimName,nocase);
    
    // HackAddPrimNameBlank := if(hackAddPrimNameBlankCondition 
                        // ,regexreplace('AND [(] ~left[.]prim_name_derived_isnull AND ~right[.]prim_name_derived_isnull [)]',HackAddPrimName,
                          // '/*AND ( ~left.prim_name_derived_isnull AND ~right.prim_name_derived_isnull )*/'
                        // ,nocase) 
                        // ,HackAddPrimName
                     // );
    // HackAddPrimNameBlank_message := if(hackAddPrimNameBlankCondition or pAttribute != 'matches' ,HackAddPrimName_message,HackAddPrimName_message + ',Did not Hack ' + pAttribute + ' allowing blank prim_name_deriveds in mj0\n');
    ///////////////
    ///////////////
    hackRulesCondition := pAttribute = 'matches' and regexfind('n = 0 => \':cnp_number:st:prim_range_derived\',\'AttributeFile:\'[+][(]STRING[)][(]n-10000[)][)];',HackAddPrimName,nocase);
    
    HackRules := if(hackRulesCondition 
                        ,regexreplace(
                          'n = 0 => \':cnp_number:st:prim_range_derived\',\'AttributeFile:\'[+][(]STRING[)][(]n-10000[)][)];'
                        ,HackAddPrimName,
                            '   n = 0 => \':cnp_number:st:prim_range_derived\'\n'
                          + '  ,n = 101 => \':cnp_number:prim_range_derived:cnp_name:st:pname_digits\'                      /* HACK */\n'
                          + '  ,n = 102 => \':cnp_number:prim_range_derived:prim_name_derived:st:cnp_name[1..4]\'                   /* HACK */\n'
                          + '  ,n = 103 => \':prim_range_derived:prim_name_derived:st:sec_range\'                                   /* HACK */\n'
                          + '  ,n = 104 => \':cnp_number:prim_range_derived:v_city_name:st:pname_digits:cnp_name_raw[1..4]\'/* HACK */\n'
                          + '  ,n = 105 => \':cnp_number:prim_range_derived:zip:st:pname_digits:cnp_name_raw[1..4]\'        /* HACK */\n'
                          + '  ,n = 106 => \':cnp_number:cnp_name:company_address\'                                 /* HACK */\n'
                          + '  ,\'AttributeFile:\'+(STRING)(n-10000)\n'
                          + '  );\n'
                        ,nocase) 
                        ,HackAddPrimName
                     );
    HackRules_message := if((hackRulesCondition) or pAttribute != 'matches' ,HackAddPrimName_message,HackAddPrimName_message + ',Did not Hack ' + pAttribute + ' Adding Rules for extra mjs\n');
    ///////////////
    hackPrimNameExactCondition := regexfind('prim_name_derived_score := if [(]',HackRules,nocase) and not regexfind('(prim_name_derived_score := if [(])[ ]*le.prim_name_derived = ri.prim_name_derived/* HACK */ or[ ]*([^\n]+)',HackRules,nocase) ;
    HackPrimNameExact := if( hackPrimNameExactCondition
                        ,regexreplace('(prim_name_derived_score := if [(])([^\n]+)',HackRules,'$1 le.prim_name_derived = ri.prim_name_derived/* HACK */ or $2',nocase) 
                        ,HackRules
                     );
    HackPrimNameExact_message := if(hackPrimNameExactCondition  ,HackRules_message,HackRules_message + ', Did not Hack ' + pAttribute + ' prim_name_derived exact match\n');
    ///////////////
    hackReplaceTransitivesMacroCondition := pAttribute = 'matches' and      regexfind('salt30[.]mac_avoid_transitives[(]All_Matches,Proxid1,Proxid2,Conf,DateOverlap,Rule,o[)];',HackPrimNameExact,nocase)
                                                                   and not  regexfind('BIPV2_ProxID[.]mac_avoid_transitives_scalene'                                            ,HackPrimNameExact,nocase);
    
    
    HackReplaceTransitivesMacro := if(hackReplaceTransitivesMacroCondition 
                        ,regexreplace(
                          '(salt30[.]mac_avoid_transitives[(]All_Matches,Proxid1,Proxid2,Conf,DateOverlap,Rule,o[)];)'
                        ,HackPrimNameExact,
                          '// $1 /* HACK - disable default salt mac_avoid_transitives*/\n'
                        + 'import BIPV2_Tools;\n /*HACK, import module for new transitives macro*/\n'
                        + 'o := BIPV2_ProxID.mac_avoid_transitives_scalene(All_Matches,Proxid1,Proxid2,Conf,DateOverlap,Rule,MatchThreshold,10); // HACK - Use new transitives macro, bucket size 5*/\n'
                        ,nocase) 
                        ,HackPrimNameExact
                     );
    HackReplaceTransitivesMacro_message := if((hackReplaceTransitivesMacroCondition) or pAttribute != 'matches' ,HackPrimNameExact_message,HackPrimNameExact_message + 'Did not Hack ' + pAttribute + ' replacing transitives macro\n');
    ///////////////
    hackRollEntitiesReturnEcl := '(RETURN ROLLUP[(] SORT[(] DISTRIBUTE[(] infile, HASH[(]Proxid[)] [)], Proxid, LOCAL [)], LEFT[.]Proxid = RIGHT[.]Proxid, RollValues[(]LEFT,RIGHT[)],LOCAL[)];)';
    
    hackRollEntitiesReturnCondition := pAttribute = 'Debug' and      regexfind(hackRollEntitiesReturnEcl,HackReplaceTransitivesMacro,nocase) and not regexfind('rollup3',HackReplaceTransitivesMacro,nocase);
    
    
    HackRollEntitiesReturn := if(hackRollEntitiesReturnCondition 
                        ,regexreplace(
                          hackRollEntitiesReturnEcl
                        ,HackReplaceTransitivesMacro,
                          '// $1 /* HACK - disable default return*/\n'
                        + 'rollup1 :=  ROLLUP( SORT( distribute(infile  ,random()) , Proxid ,local), LEFT.Proxid = RIGHT.Proxid, RollValues(LEFT,RIGHT),local); /*HACK, import module for new transitives macro*/\n'
                        + 'rollup2 :=  ROLLUP( SORT( distribute(rollup1 ,random()) , Proxid ,local), LEFT.Proxid = RIGHT.Proxid, RollValues(LEFT,RIGHT),local); /*HACK, import module for new transitives macro*/\n'
                        + 'rollup3 :=  ROLLUP( SORT( distribute(rollup2 ,proxid)   , Proxid ,local), LEFT.Proxid = RIGHT.Proxid, RollValues(LEFT,RIGHT),local); /*HACK, import module for new transitives macro*/\n'
                        + 'RETURN rollup3;                                                                                                                      /*HACK, import module for new transitives macro*/\n'
                        ,nocase) 
                        ,HackReplaceTransitivesMacro
                     );
    HackRollEntitiesReturn_message := if(hackRollEntitiesReturnCondition or pAttribute != 'Debug' ,HackReplaceTransitivesMacro_message,HackReplaceTransitivesMacro_message + 'Did not Hack ' + pAttribute + ' replacing return for RollEntities\n');
       
    //////////////
    // 5) In the ?matches? attribute, where you see ?salt30.MAC_ParentId_Patch? change it to ?BIPV2_Tools.MAC_ParentId_Patch?.  Immediately before the first of these calls, add this line:
  // o_thin := TABLE(o,{ultid,orgid,lgid3,proxid,dotid,rcid}); // HACK
// and then on the first MAC_ParentId_Patch call change the ?o? parameter to ?o_thin?
  // Patchlgid3 := salt30.MAC_ParentId_Patch(o,lgid3,Proxid);  // Collapse any lgid3 now joined by Proxid
  // Patchorgid := salt30.MAC_ParentId_Patch(Patchlgid3,orgid,lgid3);  // Collapse any orgid now joined by lgid3
  // Patchultid := salt30.MAC_ParentId_Patch(Patchorgid,ultid,orgid);  // Collapse any ultid now joined by orgid
    hackSlimPatchDsEcl := '(Patchlgid3 := salt30[.]MAC_ParentId_Patch[(])o(,lgid3,Proxid[)];  // Collapse any lgid3 now joined by Proxid)';
    
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
    HackSlimPatchDs_message := if((hackSlimPatchDsCondition ) or pAttribute != 'matches' ,HackRollEntitiesReturn_message,HackRollEntitiesReturn_message + ' ,Did not Hack ' + pAttribute + ' replacing Parentid patch\n');
    //////////////
    hackMacParentIdPatchEcl := 'salt30[.]MAC_ParentId_Patch';
    
    hackMacParentIdPatchCondition := pAttribute = 'matches' and      regexfind(hackMacParentIdPatchEcl,HackSlimPatchDs,nocase);
        
    HackMacParentIdPatch := if(hackMacParentIdPatchCondition 
                        ,regexreplace(
                          hackMacParentIdPatchEcl
                        ,HackSlimPatchDs,
                          'BIPV2_Tools.MAC_ParentId_Patch'
                        ,nocase) 
                        ,HackSlimPatchDs
                     );
    HackMacParentIdPatch_message := if((hackMacParentIdPatchCondition ) or pAttribute != 'matches' ,HackSlimPatchDs_message,HackSlimPatchDs_message + ' ,Did not Hack ' + pAttribute + ' replacing Parentid patch call\n');
    ////////////
    hackMacChildIdPatchEcl := 'salt30[.]MAC_ChildID_Patch';
    
    hackMacChildIdPatchCondition := pAttribute = 'matches' and      regexfind(hackMacChildIdPatchEcl,HackMacParentIdPatch,nocase);
        
    HackMacChildIdPatch := if(hackMacChildIdPatchCondition 
                        ,regexreplace(
                          hackMacChildIdPatchEcl
                        ,HackMacParentIdPatch,
                          'BIPV2_Tools.MAC_ChildID_Patch'
                        ,nocase) 
                        ,HackMacParentIdPatch
                     );
    HackMacChildIdPatch_message := if((hackMacChildIdPatchCondition) or pAttribute != 'matches'  ,HackMacParentIdPatch_message,HackMacParentIdPatch_message + ' ,Did not Hack ' + pAttribute + ' replacing Childid patch call\n');
    ////////////
    hackPatchedInfileEcl := 'EXPORT Patched_Infile := Patchdotid;';
    
    hackPatchedInfileCondition := pAttribute = 'matches' and      regexfind(hackPatchedInfileEcl,hackMacChildIdPatch,nocase);
        
    HackPatchedInfile := if(hackPatchedInfileCondition 
                        ,regexreplace(
                          hackPatchedInfileEcl
                        ,hackMacChildIdPatch,
                          'EXPORT Patched_Infile := JOIN(o, Patchdotid, LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(o),SELF:=RIGHT,SELF:=LEFT), KEEP(1), HASH); // HACK;'
                        ,nocase) 
                        ,hackMacChildIdPatch
                     );
    HackPatchedInfile_message := if((hackPatchedInfileCondition) or pAttribute != 'matches'  ,hackMacChildIdPatch_message,hackMacChildIdPatch_message + ' ,Did not Hack ' + pAttribute + ' adding join to patched_infile\n');
    ////////////
    //  INTEGER2 cnp_name_score_supp := MIN[(]IF[(]cnp_name_support>0,MAX[(]cnp_name_score_temp,cnp_name_support[*]100/[*]HACK[*]/),cnp_name_score_temp),s.cnp_name_MAX*100); // Add support
    //  INTEGER2 cnp_name_score_supp := MIN[(]IF[(]cnp_name_support>0,MAX[(]cnp_name_score_temp,cnp_name_support[*]100[)],cnp_name_score_temp[)],s.cnp_name_MAX[*]100[)]; // Add support
    // hackcnp_name_supportScaleEcl := 'INTEGER2 cnp_name_score_supp := MIN[(]IF[(]cnp_name_support>0,MAX[(]cnp_name_score_temp,cnp_name_support[)]';
    
    // hackcnp_name_supportScaleCondition := regexfind(hackcnp_name_supportScaleEcl,HackPatchedInfile,nocase);
        
    // Hackcnp_name_supportScale := if(hackcnp_name_supportScaleCondition 
                        // ,regexreplace(
                          // hackcnp_name_supportScaleEcl
                        // ,HackPatchedInfile,
                          // 'INTEGER2 cnp_name_score_supp := MIN(IF(cnp_name_support>0,MAX(cnp_name_score_temp,cnp_name_support*100/*HACK make support same scale*/)'
                        // ,nocase) 
                        // ,HackPatchedInfile
                     // );
    // Hackcnp_name_supportScale_message := if(hackcnp_name_supportScaleCondition ,HackPatchedInfile_message,HackPatchedInfile_message + ' ,Did not Hack ' + pAttribute + ' multiplying cnp_name_support by 100\n');
    ////////////
    saveatt := fPutAttribute(pAttribute,HackPatchedInfile);
    
    return sequential(iff(pShouldSaveAttribute and std.Str.findcount(HackPatchedInfile_message,'Did not Hack') != 15 ,saveatt  ,output(dataset([{HackPatchedInfile}],{string ecl}),named(pAttribute + 'HackedEcl'))),output(HackPatchedInfile_message  ,named(pAttribute + 'Hack_message')));
   
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
    + 'EXPORT Candidates         := INDEX(prop_file,{Proxid},{prop_file},keynames(liter,pUseOtherEnvironment).match_candidates_debug.logical);\n'
    + 'ms_temp := sort(mtch,Conf,Proxid1,Proxid2,SKEW(1.0)); // Some headers have very skewed IDs\n'
    + 'EXPORT MatchSample        := INDEX(ms_temp,{Conf,Proxid1,Proxid2},{mtch},keynames(liter,pUseOtherEnvironment).match_sample_debug.logical,SORT KEYED);\n'
    + 'EXPORT Specificities_Key  := INDEX(s,{1},{s},keynames(liter,pUseOtherEnvironment).specificities_debug.logical);\n'
    + 'am := matches(ih).All_Attribute_Matches;\n'
    + 'EXPORT Attribute_Matches  := INDEX(am,{Proxid1,Proxid2},{am},keynames(liter,pUseOtherEnvironment).attribute_matches.logical);\n'
    + 'prop_file := matches(ih).Patched_Candidates; // Available for External ADL2\n'
    + 'EXPORT PatchedCandidates  := INDEX(prop_file,{Proxid},{prop_file},keynames(liter,pUseOtherEnvironment).patched_candidates.logical);\n'
    + 'EXPORT InData             := INDEX(ih,{Proxid},{ih},keynames(liter,pUseOtherEnvironment).in_data.logical);\n'
    + '\n'
    + '// Create logic to manage the match history key\n'
    + 'EXPORT MatchHistoryName := \'~keep::BIPV2_ProxID::Proxid::MatchHistory\';\n'
    + 'EXPORT MatchHistoryFile := DATASET(MatchHistoryName,Matches(In_DOT_Base).id_shift_r,THOR); // Read in all the change history\n'
    + 'EXPORT MatchHistoryKeyName := \'~\'+\'key::BIPV2_ProxID::Proxid::History::Match\';\n'
    + '  MH := MatchHistoryFile;\n'
    + 'EXPORT MatchHistoryKey := INDEX(MH,{Proxid_after},{MH},MatchHistoryKeyName);\n'
    + '// Build enough to support the data services such as cleave/best\n'
    + '// EXPORT InDataKeyName := \'~\'+\'key::BIPV2_ProxID::Proxid::Datafile::in_data\';\n'
    + '// EXPORT InData := INDEX(ih,{Proxid},{ih},InDataKeyName);\n'
    + '// SHARED Build_InData := BUILDINDEX(InData, OVERWRITE);\n'
    + '// EXPORT BuildData := PARALLEL(Build_Specificities_Key,Build_InData);\n'
    + '// Build enough to support the debug services such as the compare service\n'
    + 'EXPORT BuildDebug := PARALLEL(BUILDINDEX(Candidates,keynames(liter).match_candidates_debug.logical,OVERWRITE),BUILDINDEX(Specificities_Key,keynames(liter).specificities_debug.logical,FEW,OVERWRITE),BUILDINDEX(Attribute_Matches,keynames(liter).attribute_matches.logical,OVERWRITE));\n'
    + '// Build Everything\n'
    + 'EXPORT BuildAll := PARALLEL(BUILDINDEX(Candidates,keynames(liter).match_candidates_debug.logical,OVERWRITE),BUILDINDEX(MatchSample,keynames(liter).match_sample_debug.logical,OVERWRITE),BUILDINDEX(Specificities_Key,keynames(liter).specificities_debug.logical,FEW,OVERWRITE),BUILDINDEX(PatchedCandidates,keynames(liter).patched_candidates.logical,OVERWRITE),BUILDINDEX(Attribute_Matches,keynames(liter).attribute_matches.logical,OVERWRITE)/*,BUILDINDEX(InData,keynames(liter).in_data.logical,OVERWRITE)*/);\n'
    + 'END;\n'
    ;
    HackKeys_message := if(IndexNum  = 7,'','Did not Hack ' + pAttribute + ' because # of keys(expected 7, found ' + (string)IndexNum + ') changed.  Take a look.\n');
    saveatt := fPutAttribute(pAttribute,HackKeys);
    
    return sequential(iff(pShouldSaveAttribute  and IndexNum = 7,saveatt  ,output(dataset([{HackKeys}],{string ecl}),named(pAttribute + 'HackedEcl'))),output(HackKeys_message  ,named(pAttribute + 'Hack_message')));
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
      + 'IMPORT salt30,ut,std;\n'
      + 'EXPORT MOD_Attr_ForeignCorpkey(DATASET(layout_DOT_Base) ih,UNSIGNED MatchThreshold = 36) := MODULE\n'
      + '\n'
      + '// Construct a function to filter matches to those that obey the force criteria on this attribute file.\n'
      + 'EXPORT ForceFilter(inhead,infile,id1,id2) := FUNCTIONMACRO\n'
      + '// Every attribute value must match to a value in the other attribute IF they have the same context\n'
      + '//  Cands0 := BIPV2_ProxID.match_candidates(inhead).ForeignCorpkey_candidates;\n'
      + '  Cands0 := BIPV2_ProxID.file_Foreign_Corpkey;/*HACK*/\n'
      + '// We are going to create a record for each candidate pair; this record will have a child dataset for the attribute values of each side\n'
      + 'childrec1 := \n'
      + 'record\n'
      + '    salt30.StrType Basis    := Cands0.company_charter_number;/*HACK to get basis only*/\n'
      + '    salt30.StrType Context  := Cands0.company_inc_state; // Context for the basis (\'<\')\n'
      + 'end;\n'
      + '\n'
      + '  ChildRec := RECORD\n'
      + '    Cands0.Proxid;\n'
      + '//    Cands0.Basis_Weight100;/*hack*/\n'
      + '    // salt30.StrType Basis    := salt30.GetNthWord(Cands0.Basis,1,\'|\');/*HACK to get basis only*/\n'
      + '    // salt30.StrType Context  := salt30.GetNthWord(Cands0.Basis,2,\'|\'); // Context for the basis (\'<\')\n'
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
      + ' \n'
      + 'match_candidates(ih).Layout_Attribute_Matches Score(Cands le,Cands ri,UNSIGNED cnp_name_support = 0) := TRANSFORM\n'
      + '  SELF.rule := 10001; // Signify Attribute File #1\n'
      + '  SELF.Proxid1 := le.Proxid;\n'
      + '  SELF.Proxid2 := ri.Proxid;\n'
      + '  SELF.source_id := le.Basis;\n'
      + '  INTEGER2 cnp_number_score_temp := MAP(                         le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,\n'
      + '                        salt30.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));\n'
      + '  INTEGER2 active_enterprise_number_score_temp := MAP( le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,\n'
      + '                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,\n'
      + '                        salt30.Fn_Fail_Scale(le.active_enterprise_number_weight100,s.active_enterprise_number_switch));\n'
      + '  INTEGER2 active_domestic_corp_key_score_temp := MAP( le.active_domestic_corp_key_isnull OR ri.active_domestic_corp_key_isnull => 0,\n'
      + '                        le.active_domestic_corp_key = ri.active_domestic_corp_key  => le.active_domestic_corp_key_weight100,\n'
      + '                        salt30.Fn_Fail_Scale(le.active_domestic_corp_key_weight100,s.active_domestic_corp_key_switch));\n'
      + '  INTEGER2 active_duns_number_score_temp := MAP( le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,\n'
      + '                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,\n'
      + '                        salt30.Fn_Fail_Scale(le.active_duns_number_weight100,s.active_duns_number_switch));\n'
      + '  INTEGER2 cnp_number_score := IF ( cnp_number_score_temp >= 0, cnp_number_score_temp, SKIP ); // Enforce FORCE parameter\n'
      + '  INTEGER2 active_enterprise_number_score := IF ( active_enterprise_number_score_temp >= 0, active_enterprise_number_score_temp, SKIP ); // Enforce FORCE parameter\n'
      + '  INTEGER2 active_domestic_corp_key_score := IF ( active_domestic_corp_key_score_temp >= 0, active_domestic_corp_key_score_temp, SKIP ); // Enforce FORCE parameter\n'
      + '  INTEGER2 active_duns_number_score := IF ( active_duns_number_score_temp >= 0, active_duns_number_score_temp, SKIP ); // Enforce FORCE parameter\n'
      + '  SELF.Conf_Prop := (cnp_number_score + active_enterprise_number_score + active_domestic_corp_key_score + active_duns_number_score) / 100; // Score based on forced fields\n'
      + '  SELF.Conf := ri.Basis_weight100 *  1.00/100;\n'
      + 'end;\n'
      + 'Matches0 := DISTRIBUTE(JOIN(Cands,Cands,LEFT.Basis = RIGHT.Basis AND LEFT.Proxid > RIGHT.Proxid,Score(LEFT,RIGHT)),Proxid1+Proxid2);\n'
      + ' \n'
      + 'EXPORT Match := DEDUP( SORT(Matches0,Proxid1,Proxid2,-(Conf+Conf_Prop+support_cnp_name),Source_Id,LOCAL),Proxid1,Proxid2,KEEP(1),LOCAL ); // Keep 1 source_ids per match\n'
      + 'END;\n'
          ;
    HackKeys_message := if(IndexNum  != 2,'','Did not Hack ' + pAttribute + ' because it has ' + (string)IndexNum + ' rollups in it, which likely mean it was already hacked.\n');
    saveatt := fPutAttribute(pAttribute,HackKeys);
    
    return sequential(iff(pShouldSaveAttribute  and IndexNum = 0,saveatt  ,output(dataset([{HackKeys}],{string ecl}),named(pAttribute + 'HackedEcl'))),output(HackKeys_message  ,named(pAttribute + 'Hack_message')));
  END;
  /////////////fHackModRAAdress
  export fHackModRAAdress(
  
     string   pAttribute            = 'MOD_Attr_RAAddresses' 
    ,boolean  pShouldSaveAttribute  = false
    
  ) :=
  function
  
    EclCode   := fGetAttribute(pAttribute) : independent;
    IndexNum  := STD.Str.FindCount( EclCode, 'rollup');
    HackKeys  := 
        '// Logic to handle the matching around RAAddresses\n'
      + ' \n'
      + 'IMPORT salt30,ut,std;\n'
      + 'EXPORT MOD_Attr_RAAddresses(DATASET(layout_DOT_Base) ih,UNSIGNED MatchThreshold = 36) := MODULE\n'
      + '// Construct a function to filter matches to those that obey the force criteria on this attribute file.\n'
      + 'EXPORT ForceFilter(inhead,infile,id1,id2) := FUNCTIONMACRO\n'
      + '// Every attribute value has to exactly match every attribute value of the corresponding identifier or both have no values\n'
      + '  Cands0 := BIPV2_ProxID.file_RA_Addresses;/*HACK*/\n'
      + '// We are going to create a record for each candidate pair; this record will have a child dataset for the attribute values of each side\n'
      + '////\n'
      + 'childrec1 := \n'
      + 'record\n'
      + '    salt30.StrType Basis    := Cands0.cname;/*HACK to get basis only*/\n'
      + 'end;\n'
      + '\n'
      + '  ChildRec := RECORD\n'
      + '    Cands0.Proxid;\n'
      + '//    Cands0.Basis_Weight100;/*hack*/\n'
      + '    // salt30.StrType Basis    := salt30.GetNthWord(Cands0.Basis,1,\'|\');/*HACK to get basis only*/\n'
      + '    // salt30.StrType Context  := salt30.GetNthWord(Cands0.Basis,2,\'|\'); // Context for the basis (\'<\')\n'
      + '    dataset(childrec1) childs := dataset([{Cands0.cname}],childrec1);\n'
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
      + '  D2 := JOIN(D1    ,Cands2,LEFT.id2 = RIGHT.Proxid,TRANSFORM(PossRec/* SELF.Kids2 := RIGHT.childs*/\n'
      + '    ,self.shouldFilterOut := if(count(table(left.kids1 + RIGHT.childs,{basis},basis,few))  <  count(left.kids1 + RIGHT.childs),skip,true) //if have one or more cnp_names in common, that is ok.  if not, filter out that potential match\n'
      + '    ,SELF := LEFT), HASH);\n'
      + '  d2_table := project(d2,layslimmtch);\n'
      + '  \n'
      + '  D2_tokeep := join(infile,d2_table,left.id1 = right.id1 and left.id2 = right.id2,transform(left),left only,hash);\n'
      + '\n'
      + '  RETURN D2_tokeep;\n'
      + '\n'
      + 'ENDMACRO;\n'
      + '\n'
      + 'SHARED Cands := match_candidates(ih).RAAddresses_candidates;\n'
      + 'SHARED s := Specificities(ih).Specificities[1];\n'
      + ' \n'
      + '// Generate match candidates based upon this attribute file\n'
      + ' \n'
      + 'match_candidates(ih).Layout_Attribute_Matches Score(Cands le,Cands ri,UNSIGNED cnp_name_support = 0) := TRANSFORM\n'
      + '  SELF.rule := 10002; // Signify Attribute File #2\n'
      + '  SELF.Proxid1 := le.Proxid;\n'
      + '  SELF.Proxid2 := ri.Proxid;\n'
      + '  SELF.source_id := le.Basis;\n'
      + '  INTEGER2 cnp_number_score_temp := MAP(                         le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,\n'
      + '                        salt30.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));\n'
      + '  INTEGER2 active_enterprise_number_score_temp := MAP( le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,\n'
      + '                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,\n'
      + '                        salt30.Fn_Fail_Scale(le.active_enterprise_number_weight100,s.active_enterprise_number_switch));\n'
      + '  INTEGER2 active_domestic_corp_key_score_temp := MAP( le.active_domestic_corp_key_isnull OR ri.active_domestic_corp_key_isnull => 0,\n'
      + '                        le.active_domestic_corp_key = ri.active_domestic_corp_key  => le.active_domestic_corp_key_weight100,\n'
      + '                        salt30.Fn_Fail_Scale(le.active_domestic_corp_key_weight100,s.active_domestic_corp_key_switch));\n'
      + '  INTEGER2 active_duns_number_score_temp := MAP( le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,\n'
      + '                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,\n'
      + '                        salt30.Fn_Fail_Scale(le.active_duns_number_weight100,s.active_duns_number_switch));\n'
      + '  INTEGER2 cnp_number_score := IF ( cnp_number_score_temp >= 0, cnp_number_score_temp, SKIP ); // Enforce FORCE parameter\n'
      + '  INTEGER2 active_enterprise_number_score := IF ( active_enterprise_number_score_temp >= 0, active_enterprise_number_score_temp, SKIP ); // Enforce FORCE parameter\n'
      + '  INTEGER2 active_domestic_corp_key_score := IF ( active_domestic_corp_key_score_temp >= 0, active_domestic_corp_key_score_temp, SKIP ); // Enforce FORCE parameter\n'
      + '  INTEGER2 active_duns_number_score := IF ( active_duns_number_score_temp >= 0, active_duns_number_score_temp, SKIP ); // Enforce FORCE parameter\n'
      + '  SELF.Conf_Prop := (cnp_number_score + active_enterprise_number_score + active_domestic_corp_key_score + active_duns_number_score) / 100; // Score based on forced fields\n'
      + '  SELF.Conf := ri.Basis_weight100 *  1.00/100;\n'
      + 'end;\n'
      + 'Matches0 := DISTRIBUTE(JOIN(Cands,Cands,LEFT.Basis = RIGHT.Basis AND LEFT.Proxid > RIGHT.Proxid,Score(LEFT,RIGHT)),Proxid1+Proxid2);\n'
      + ' \n'
      + 'EXPORT Match := DEDUP( SORT(Matches0,Proxid1,Proxid2,-(Conf+Conf_Prop+support_cnp_name),Source_Id,LOCAL),Proxid1,Proxid2,KEEP(1),LOCAL ); // Keep 1 source_ids per match\n'
      + 'END;\n'
          ;
    HackKeys_message := if(IndexNum  != 2,'','Did not Hack ' + pAttribute + ' because it has ' + (string)IndexNum + ' rollups in it, which likely mean it was already hacked.\n');
    saveatt := fPutAttribute(pAttribute,HackKeys);
    
    return sequential(iff(pShouldSaveAttribute  and IndexNum = 0,saveatt  ,output(dataset([{HackKeys}],{string ecl}),named(pAttribute + 'HackedEcl'))),output(HackKeys_message  ,named(pAttribute + 'Hack_message')));
  END;
  /////////////fHackModFilterprim_name_deriveds
  export fHackModFilterprim_name_deriveds(
  
     string   pAttribute            = 'MOD_Attr_FilterPrimNames' 
    ,boolean  pShouldSaveAttribute  = false
    
  ) :=
  function
  
    EclCode   := fGetAttribute(pAttribute) : independent;
    IndexNum  := STD.Str.FindCount( EclCode, 'rollup');
    HackKeys  := 
        '// Logic to handle the matching around FilterPrimNames\n'
      + ' \n'
      + 'IMPORT salt30,ut,std;\n'
      + 'EXPORT MOD_Attr_FilterPrimNames(DATASET(layout_DOT_Base) ih,UNSIGNED MatchThreshold = 30) := MODULE\n'
      + '// Construct a function to filter matches to those that obey the force criteria on this attribute file.\n'
      + 'EXPORT ForceFilter(inhead,infile,id1,id2) := FUNCTIONMACRO\n'
      + '// Every attribute value has to exactly match every attribute value of the corresponding identifier or both have no values\n'
      + '  Cands0 := BIPV2_ProxID.file_filter_Prim_names;/*HACK*/\n'
      + '// We are going to create a record for each candidate pair; this record will have a child dataset for the attribute values of each side\n'
      + '////\n'
      + 'childrec1 := \n'
      + 'record\n'
      + '    salt30.StrType Basis    ;/*HACK to get basis only*/\n'
      + 'end;\n'
      + '  ChildRec := RECORD\n'
      + '    Cands0.Proxid;\n'
      + '//    Cands0.Basis_Weight100;/*hack*/\n'
      + '    // salt30.StrType Basis    := salt30.GetNthWord(Cands0.Basis,1,\'|\');/*HACK to get basis only*/\n'
      + '    // salt30.StrType Context  := salt30.GetNthWord(Cands0.Basis,2,\'|\'); // Context for the basis (\'<\')\n'
      + '    dataset(childrec1) childs := dataset([{Cands0.pname_digits}],childrec1);\n'
      + '  END;\n'
      + '  Cands  := TABLE(Cands0,ChildRec);\n'
      + '  Cands1 := rollup(sort(Cands                     ,proxid,local) ,left.proxid = right.proxid,transform(recordof(left),self.childs := left.childs + right.childs,self := left),local);\n'
      + '  Cands2 := rollup(sort(distribute(Cands1,proxid) ,proxid,local) ,left.proxid = right.proxid,transform(recordof(left),self.childs := left.childs + right.childs,self := left),local);\n'
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
      + '  D2 := JOIN(D1    ,Cands2,LEFT.id2 = RIGHT.Proxid,TRANSFORM(PossRec/* SELF.Kids2 := RIGHT.childs*/\n'
      + '    ,self.shouldFilterOut := if(count(table(left.kids1 + RIGHT.childs,{basis},basis,few)) = 1 and count(left.kids1) = 1 and count(RIGHT.childs) = 1,skip,true) //if have one or more cnp_names in common, that is ok.  if not, filter out that potential match\n'
      + '    ,SELF := LEFT), HASH);\n'
      + '  d2_table := project(d2,layslimmtch);\n'
      + '  \n'
      + '  D2_tokeep := join(infile,d2_table,left.id1 = right.id1 and left.id2 = right.id2,transform(left),left only,hash);\n'
      + '  RETURN D2_tokeep;\n'
      + 'ENDMACRO;\n'
      + '\n'
      + 'SHARED Cands := match_candidates(ih).FilterPrimNames_candidates;\n'
      + 'SHARED s := Specificities(ih).Specificities[1];\n'
      + ' \n'
      + '// Generate match candidates based upon this attribute file\n'
      + ' \n'
      + 'match_candidates(ih).Layout_Attribute_Matches Score(Cands le,Cands ri,UNSIGNED cnp_name_support = 0) := TRANSFORM\n'
      + '  SELF.rule := 10003; // Signify Attribute File #3\n'
      + '  SELF.Proxid1 := le.Proxid;\n'
      + '  SELF.Proxid2 := ri.Proxid;\n'
      + '  SELF.source_id := le.Basis;\n'
      + '  INTEGER2 cnp_number_score_temp := MAP(                         le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,\n'
      + '                        salt30.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));\n'
      + '  INTEGER2 active_duns_number_score_temp := MAP( le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,\n'
      + '                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,\n'
      + '                        salt30.Fn_Fail_Scale(le.active_duns_number_weight100,s.active_duns_number_switch));\n'
      + '  INTEGER2 active_enterprise_number_score_temp := MAP( le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,\n'
      + '                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,\n'
      + '                        salt30.Fn_Fail_Scale(le.active_enterprise_number_weight100,s.active_enterprise_number_switch));\n'
      + '  INTEGER2 active_domestic_corp_key_score_temp := MAP( le.active_domestic_corp_key_isnull OR ri.active_domestic_corp_key_isnull => 0,\n'
      + '                        le.active_domestic_corp_key = ri.active_domestic_corp_key  => le.active_domestic_corp_key_weight100,\n'
      + '                        salt30.Fn_Fail_Scale(le.active_domestic_corp_key_weight100,s.active_domestic_corp_key_switch));\n'
      + '  INTEGER2 cnp_number_score := IF ( cnp_number_score_temp >= Config.cnp_number_Force * 100, cnp_number_score_temp, SKIP ); // Enforce FORCE parameter\n'
      + '  INTEGER2 active_duns_number_score := IF ( active_duns_number_score_temp >= Config.active_duns_number_Force * 100, active_duns_number_score_temp, SKIP ); // Enforce FORCE parameter\n'
      + '  INTEGER2 active_enterprise_number_score := IF ( active_enterprise_number_score_temp >= Config.active_enterprise_number_Force * 100, active_enterprise_number_score_temp, SKIP ); // Enforce FORCE parameter\n'
      + '  INTEGER2 active_domestic_corp_key_score := IF ( active_domestic_corp_key_score_temp >= Config.active_domestic_corp_key_Force * 100, active_domestic_corp_key_score_temp, SKIP ); // Enforce FORCE parameter\n'
      + '  SELF.Conf_Prop := (cnp_number_score + active_duns_number_score + active_enterprise_number_score + active_domestic_corp_key_score) / 100; // Score based on forced fields\n'
      + '  SELF.Conf := ri.Basis_weight100 *  1.00/100;\n'
      + 'end;\n'
      + 'Matches0 := DISTRIBUTE(JOIN(Cands,Cands,LEFT.Basis = RIGHT.Basis AND LEFT.Proxid > RIGHT.Proxid,Score(LEFT,RIGHT)),Proxid1+Proxid2);\n'
      + ' \n'
      + 'EXPORT Match := DEDUP( SORT(Matches0,Proxid1,Proxid2,-(Conf+Conf_Prop+support_cnp_name),Source_Id,LOCAL),Proxid1,Proxid2,KEEP(1),LOCAL ); // Keep 1 source_ids per match\n'
      + 'END;\n'
      + '\n'
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
      + 'IMPORT SALT24,BIPV2_ProxID,ut,tools;\n'
      + 'STRING50 Proxidonestr := \'1234\'  : STORED(\'ProxidOne\');\n'
      + 'STRING20 Proxidtwostr := \'12345\'  : STORED(\'Proxidtwo\');\n'
      + 'combo := \'qa\';\n'
      + '\n'
      + 'BIPV2_ProxID._fun_CompareService((unsigned6)Proxidonestr,(unsigned6)Proxidtwostr,combo);\n'
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
// 2) In the Fields attribute, add this line immediately before ?proxid_Twoparents?:
  // f_thin := TABLE(f(proxid<>0,lgid3<>0),{proxid,lgid3},proxid,lgid3,MERGE); // HACK
// and then change the self-JOIN parameters to reference ?f_thin? instead of ?f?
// 3) Do the same as #2 for ?lgid3_Twoparents? and ?orgid_Twoparents?, with the applicable field-pairs for each
// 4) Also near the end of the Fields attribute, change each of the "*_Unbased" JOINs so the left side will filter-out null values... "f" becomes "f(parentid<>0)"
/*
  EXPORT Proxid_Twoparents := DEDUP(JOIN(f,f,LEFT.Proxid=RIGHT.Proxid AND LEFT.lgid3>RIGHT.lgid3,TRANSFORM({salt30.UIDType lgid31,salt30.UIDType Proxid,salt30.UIDType lgid32},SELF.lgid31:=LEFT.lgid3,SELF.lgid32:=RIGHT.lgid3,SELF.Proxid:=LEFT.Proxid),HASH),WHOLE RECORD,ALL);
  EXPORT lgid3_Twoparents := DEDUP(JOIN(f,f,LEFT.lgid3=RIGHT.lgid3 AND LEFT.orgid>RIGHT.orgid,TRANSFORM({salt30.UIDType orgid1,salt30.UIDType lgid3,salt30.UIDType orgid2},SELF.orgid1:=LEFT.orgid,SELF.orgid2:=RIGHT.orgid,SELF.lgid3:=LEFT.lgid3),HASH),WHOLE RECORD,ALL);
  EXPORT orgid_Twoparents := DEDUP(JOIN(f,f,LEFT.orgid=RIGHT.orgid AND LEFT.ultid>RIGHT.ultid,TRANSFORM({salt30.UIDType ultid1,salt30.UIDType orgid,salt30.UIDType ultid2},SELF.ultid1:=LEFT.ultid,SELF.ultid2:=RIGHT.ultid,SELF.orgid:=LEFT.orgid),HASH),WHOLE RECORD,ALL);
  EXPORT Proxid_Unbased := JOIN(f,bases,LEFT.Proxid=RIGHT.Proxid,TRANSFORM(LEFT),LEFT ONLY,HASH);
  EXPORT lgid3_Unbased := JOIN(f,bases,LEFT.lgid3=RIGHT.lgid3,TRANSFORM(LEFT),LEFT ONLY,HASH);
  EXPORT orgid_Unbased := JOIN(f,bases,LEFT.orgid=RIGHT.orgid,TRANSFORM(LEFT),LEFT ONLY,HASH);
  EXPORT ultid_Unbased := JOIN(f,bases,LEFT.ultid=RIGHT.ultid,TRANSFORM(LEFT),LEFT ONLY,HASH);
*/
  
    EclCode   := fGetAttribute(pAttribute) : independent;
    
    // Proxid Two Parents hack
    hackProxidTwoParentsEcl := '(EXPORT Proxid_Twoparents := DEDUP[(]JOIN[(])f,f,(LEFT[.]Proxid=RIGHT[.]Proxid AND LEFT[.]lgid3>RIGHT[.]lgid3,TRANSFORM[(][{]salt30[.]UIDType lgid31,salt30[.]UIDType Proxid,salt30[.]UIDType lgid32[}],SELF[.]lgid31:=LEFT[.]lgid3,SELF[.]lgid32:=RIGHT[.]lgid3,SELF[.]Proxid:=LEFT[.]Proxid[)],HASH[)],WHOLE RECORD,ALL[)];)';
    
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
    hacklgid3TwoParentsEcl := '(EXPORT lgid3_Twoparents := DEDUP[(]JOIN[(])f,f,(LEFT[.]lgid3=RIGHT[.]lgid3 AND LEFT[.]orgid>RIGHT[.]orgid,TRANSFORM[(][{]salt30[.]UIDType orgid1,salt30[.]UIDType lgid3,salt30[.]UIDType orgid2[}],SELF[.]orgid1:=LEFT[.]orgid,SELF[.]orgid2:=RIGHT[.]orgid,SELF[.]lgid3:=LEFT[.]lgid3[)],HASH[)],WHOLE RECORD,ALL[)];)';
    
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
    hackorgidTwoParentsEcl := '(EXPORT orgid_Twoparents := DEDUP[(]JOIN[(])f,f,(LEFT[.]orgid=RIGHT[.]orgid AND LEFT[.]ultid>RIGHT[.]ultid,TRANSFORM[(][{]salt30[.]UIDType ultid1,salt30[.]UIDType orgid,salt30[.]UIDType ultid2[}],SELF[.]ultid1:=LEFT[.]ultid,SELF[.]ultid2:=RIGHT[.]ultid,SELF[.]orgid:=LEFT[.]orgid[)],HASH[)],WHOLE RECORD,ALL[)];)';
    
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
  /////////////Config
  // EXPORT DoSliceouts := TRUE; // If set to false slice-outs do not occur (saves time)
  export fHackConfig(
  
     string   pAttribute            = 'Config' 
    ,boolean  pShouldSaveAttribute  = false
    
  ) :=
  function
  
    EclCode   := fGetAttribute(pAttribute) : independent;
    
    hackConfigCondition := pAttribute = 'Config' and not regexfind('DoSliceouts := false',EclCode,nocase);
//////////////////
        
//////////////    
    HackConfig := if(hackConfigCondition 
                        ,regexreplace('DoSliceouts := TRUE',EclCode,'DoSliceouts := false',nocase)
                        ,EclCode
                     );
    HackConfig_message := if(hackConfigCondition ,'','Did not Hack ' + pAttribute + ' to disable Sliceouts\n');
    saveatt := fPutAttribute(pAttribute,HackConfig);
    
    return sequential(iff(pShouldSaveAttribute  and hackConfigCondition,saveatt  ,output(dataset([{HackConfig}],{string ecl}),named(pAttribute + 'HackedEcl'))),output(HackConfig_message  ,named(pAttribute + 'Hack_message')));
  END;
  /////////////Config
  // EXPORT DoSliceouts := TRUE; // If set to false slice-outs do not occur (saves time)
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
    hackkeycallEcl := 'Keys[(]InFile[)].BuildAll;';
    
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
/////
//
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
////////
    saveatt := fPutAttribute(pAttribute,Hackoutputchanges);
    
    return sequential(iff(pShouldSaveAttribute  and HackoutputchangesCondition,saveatt  ,output(dataset([{Hackoutputchanges}],{string ecl}),named(pAttribute + 'HackedEcl'))),output(Hackoutputchanges_message  ,named(pAttribute + 'Hack_message')));
  END;
  // ---------------------------------------------
  // -- Match Candidates
  // ---------------------------------------------
  export fHackMatch_Candidates(
  
     string   pAttribute            = 'match_candidates' 
    ,boolean  pShouldSaveAttribute  = false
    
  ) :=
  function
  
    EclCode   := fGetAttribute(pAttribute) : independent;
/*,HINT(parallel_match)*//*HACK to prevent memory limit exceeded error*/
    
    hackMatchCandidatesCondition := pAttribute = 'match_candidates' and not regexfind('/*,HINT[(]parallel_match[)][*]//[*]HACK to prevent memory limit exceeded error[*]/',EclCode,nocase) and  regexfind(',HINT[(]parallel_match[)]',EclCode,nocase);
    HackMatchCandidates := if(hackMatchCandidatesCondition 
                        ,regexreplace('(,HINT[(]parallel_match[)])',EclCode
                        , '/*$1*//*HACK to prevent memory limit exceeded error*/'
                        ,nocase)
                        ,EclCode
                     );
    HackMatchCandidates_message := if(hackMatchCandidatesCondition ,'','Did not Hack ' + pAttribute + ' to remove hint(parallel_match)\n');
///////
//SHARED SrcRidVlid_prop5 := JOIN(SrcRidVlid_prop4,cnp_number_props,left.Proxid=right.Proxid,LOCAL);
    // hackcnpNumber_Left_outerCondition := pAttribute = 'match_candidates' and regexfind('SHARED SrcRidVlid_prop5 := JOIN[(]SrcRidVlid_prop4,cnp_name_props,left[.]Proxid=right[.]Proxid,LOCAL[)];',HackMatchCandidates,nocase);
    // HackcnpNumber_Left_outer := if(hackcnpNumber_Left_outerCondition 
                        // ,regexreplace('SHARED SrcRidVlid_prop5 := JOIN[(]SrcRidVlid_prop4,cnp_name_props,left[.]Proxid=right[.]Proxid,LOCAL[)];',HackMatchCandidates
                        // , 'SHARED SrcRidVlid_prop5 := JOIN(SrcRidVlid_prop4,cnp_name_props,left.Proxid=right.Proxid,LEFT OUTER/*HACK to allow blank cnp_number proxids through*/,LOCAL);'
                        // ,nocase)
                        // ,HackMatchCandidates
                     // );
    // HackcnpNumber_Left_outer_message := if(hackcnpNumber_Left_outerCondition ,HackMatchCandidates_message,HackMatchCandidates_message + 'Did not Hack ' + pAttribute + ' to add ,left outer to cnp_number join: SrcRidVlid_prop5\n');
    saveatt := fPutAttribute(pAttribute,HackMatchCandidates);
    
    return sequential(iff(pShouldSaveAttribute  and hackMatchCandidatesCondition,saveatt  ,output(dataset([{HackMatchCandidates}],{string ecl}),named(pAttribute + 'HackedEcl'))),output(HackMatchCandidates_message  ,named(pAttribute + 'Hack_message')));
  END;
  export do_all_hacks := 
    sequential(
       fHackDebugNMatches         ('matches'                 ,pShouldSaveAttributes)
      ,fHackDebugNMatches         ('Debug'                   ,pShouldSaveAttributes)
      ,fHackKeys                  ('Keys'                    ,pShouldSaveAttributes)
      ,fHackModFkey               ('MOD_Attr_ForeignCorpkey' ,pShouldSaveAttributes)
      ,fHackModRAAdress           ('MOD_Attr_RAAddresses'    ,pShouldSaveAttributes)
      ,fHackModFilterprim_name_deriveds   ('MOD_Attr_FilterPrimNames',pShouldSaveAttributes)
      ,fHackBasicMatch            ('BasicMatch'              ,pShouldSaveAttributes)
      ,fHackCompareService        ('ProxidCompareService'    ,pShouldSaveAttributes)
      ,fHackFields                ('Fields'                  ,pShouldSaveAttributes)
      ,fHackConfig                ('Config'                  ,pShouldSaveAttributes)
      ,fHackProc_Iterate          ('Proc_Iterate'            ,pShouldSaveAttributes)
      ,fHackMatch_Candidates      ('match_candidates'        ,pShouldSaveAttributes)
    );
end;
