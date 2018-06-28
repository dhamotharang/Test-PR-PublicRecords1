import STD,tools,wk_ut;

EXPORT _ApplyHacks(
   string   pModule               = 'BIPV2_ProxID'
  ,string   pEsp                  = wk_ut._Constants.LocalEsp + ':8145'
  ,boolean  pShouldSaveAttributes = false
  ,string   pAttributeRegexFilter = ''
) :=
function
/*
  string  themodule            ;
  string  theattribute         ;
  string  regex                ;
  string  not_regex            ;
  string  replacement          ;
  string  description          ;
*/
  debug_n_matches_hacks(string patt) := 
  function
    SkipOr9999            := if(patt = 'Debug'  ,'-9999','SKIP');
    activedomesticcorpkey := if(patt = 'Debug'  ,'SELF.active_domestic_corp_key_score'  ,'active_domestic_corp_key_score' );
    companyfein           := if(patt = 'Debug'  ,'SELF.company_fein_score'              ,'company_fein_score'             );
    activedunsnumber      := if(patt = 'Debug'  ,'SELF.active_duns_number_score'        ,'active_duns_number_score'       );
    histdunsnumber        := if(patt = 'Debug'  ,'SELF.hist_duns_number_score'          ,'hist_duns_number_score'         );

    // cnp_name_regex := 'cnp_name_score := IF [(] cnp_name_score_supp >= Config.cnp_name_Force [*] 100 OR [(][ ]*' + activedomesticcorpkey + ' > Config.cnp_name_OR1_active_domestic_corp_key_Force[*]100[)] OR [(][ ]*' + activedunsnumber      + ' > Config.cnp_name_OR2_active_duns_number_Force[*]100[)] OR [(][ ]*' + companyfein + ' > Config.cnp_name_OR3_company_fein_Force[*]100[)], cnp_name_score_supp, ' + SkipOr9999 + ' [)];';
    cnp_name_regex := 'cnp_name_score := IF [(] cnp_name_score_supp >= Config.cnp_name_Force [*] 100 OR [ ]*' + activedomesticcorpkey + ' > Config.cnp_name_OR1_active_domestic_corp_key_Force[*]100 OR [ ]*' + activedunsnumber      + ' > Config.cnp_name_OR2_active_duns_number_Force[*]100 OR [ ]*' + companyfein + ' > Config.cnp_name_OR3_company_fein_Force[*]100, cnp_name_score_supp, ' + SkipOr9999 + ' [)];';

    cnp_name_replacement :=                       
      'cnp_name_score := MAP ( le.cnp_name = ri.cnp_name \n'
    + '    or (cnp_name_score_supp >= Config.cnp_name_Force * 100 and cnp_name_support0 = 0)\n' 
    + '    or (cnp_name_score_supp >= Config.cnp_name_Force * 100 and cnp_name_score_temp < Config.cnp_name_Force * 100 and cnp_name_support0 > 0 /*and regexfind(\'fbn|dba|fictitious|assumed|trade\',le.company_name_type_raw + le.company_name_type_derived + ri.company_name_type_raw + ri.company_name_type_derived,nocase)*/)  \n'  
    + '    => cnp_name_score_supp\n'
    + '    ,' + activedomesticcorpkey + ' > Config.active_domestic_corp_key_Force*100  and ~(regexfind(\'legal\',le.company_name_type_derived,nocase) and regexfind(\'legal\',ri.company_name_type_derived,nocase) )\n'
    + '    => ' + '0' + '\n'
    + '    ,' + activedunsnumber      + ' > Config.active_duns_number_Force      *100  and ~(regexfind(\'legal\',le.company_name_type_derived,nocase) and regexfind(\'legal\',ri.company_name_type_derived,nocase) )\n'
    + '    => ' + '0' + '\n'
    + '    ,' + companyfein           + ' > Config.company_fein_Force            *100  and ~(regexfind(\'legal\',le.company_name_type_derived,nocase) and regexfind(\'legal\',ri.company_name_type_derived,nocase) )  and (le.SALT_Partition = \'\' and ri.SALT_Partition = \'\')/*no partitioned sources allowed*/\n'
    + '    => ' + '0'      + '\n'
    // + '    ,' + histdunsnumber        + ' > Config.hist_duns_number_Force        *100 and regexfind(\'fbn|dba|fictitious|assumed|trade\',le.company_name_type_raw + le.company_name_type_derived + ri.company_name_type_raw + ri.company_name_type_derived,nocase)\n'
    // + '    => ' + histdunsnumber + '\n'
    + '    , ' + SkipOr9999 + ' );'
    ;

    // -- cnp_name, address perfect match hack
    overallscore          := if(patt = 'Debug'  ,'SELF.Conf := [(]'     ,'iComp := '      );
    overallscoreparen     := if(patt = 'Debug'  ,'('                    ,''               );
    hackscore             := if(patt = 'Debug'  ,'9000 + iComp1'        ,'MatchThreshold' );
    scoreassignment       := if(patt = 'Debug'  ,'SELF.Conf := iComp;\n',''               );

    ds_results :=
    DATASET([
        {pModule,patt,cnp_name_regex  ,''  ,cnp_name_replacement ,'Hack cnp_name force'}
       ,{pModule,patt,overallscore + '([^\n]+)'  ,'iComp1 := '  ,                         
            'import ut;\n'
          + 'iComp1 := ' + overallscoreparen + '$1\n' 
          + 'iComp  := map( iComp1            >= MatchThreshold                                   => iComp1 \n'
          + '              ,le.company_address = ri.company_address and le.cnp_name = ri.cnp_name and ut.nneq(le.active_duns_number,ri.active_duns_number)=> ' + hackscore + '\n'
          + '              ,le.cnp_name = ri.cnp_name and  le.prim_range_derived = ri.prim_range_derived and le.prim_name_derived = ri.prim_name_derived and ut.nneq(le.v_city_name,ri.v_city_name) and le.st = ri.st and le.zip = ri.zip and ut.nneq(le.active_duns_number,ri.active_duns_number)=> ' + hackscore + '\n'
          + '              ,                                                                         iComp1\n'
          + '          );\n'
          + scoreassignment
        ,'Hack overall score(cnp name, address perfect match)'
        }
       ,{pModule,patt,'(prim_name_derived_score := if [(])([^\n]+)'  ,'(prim_name_derived_score := if [(])[ ]*le.prim_name_derived = ri.prim_name_derived/* HACK */ or[ ]*([^\n]+)'  ,'$1 le.prim_name_derived = ri.prim_name_derived/* HACK */ or $2' ,'Hack prim_name_derived exact match'}
       // ,{pModule,patt,'regex'  ,'not_regex'  ,'replacement' ,'description'}
    ],Tools.layout_attribute_hacks2);
    

    return ds_results;
    
  end;
  
  ds_debug :=
  DATASET([
     {pModule,'Debug','END;[ \n\r\t]*SHARED AppendAttribs.*END;[ \n\r\t]*EXPORT Layout_RolledEntity'  ,''  ,
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
      + 'EXPORT AnnotateClusterMatches(DATASET(match_candidates(ih).layout_candidates) in_data,salt37.UIDType BaseRecord) := FUNCTION//Faster form when rcid known\n'
      + '  j1 := in_data(rcid = BaseRecord);\n'
      + '  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM\n'
      + '    SELF := le;\n'
      + '  END;\n'
      + '  RETURN JOIN(in_data(rcid<>BaseRecord),j1,TRUE,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),ALL);\n'
      + 'END;\n'
      + '\n'
      + 'EXPORT Layout_RolledEntity'
     ,'hack attribute file scores'}
    ,{pModule,'Debug'
      ,'TYPEOF[(]h[.]cnp_number[)] left_cnp_number;'  
      ,'INTEGER2 salt_partition_score'  
      , '  string2 left_salt_partition;\n'
      + '  string2 right_salt_partition;\n'
      + '  INTEGER2 salt_partition_score;\n'
      + '  TYPEOF(h.cnp_number) left_cnp_number;'
      ,'add partition fields for compareservice'
    }
    ,{pModule,'Debug'
      ,'SELF[.]left_cnp_number := le[.]cnp_number;'  
      ,'SELF[.]left_salt_partition'  
      , '  SELF.left_salt_partition  := le.salt_partition;\n'
      + '  SELF.right_salt_partition := ri.salt_partition;\n'
      + '  SELF.salt_partition_score := if(le.SALT_Partition = ri.SALT_Partition OR le.SALT_Partition=\'\' OR ri.SALT_Partition = \'\'  ,0,-9999);/*HACK*/\n'
      + '  SELF.left_cnp_number := le.cnp_number;'
      ,'set partition fields in match sample join'
    }
    ,{pModule,'Debug'
      ,'[(]SELF[.]cnp_number_score [+] '  
      ,'self[.]salt_partition_score [+] '  
      , '(self.salt_partition_score + SELF.cnp_number_score + '
      ,'add partition score to final conf score of match(iComp1)'
    }

  ],Tools.layout_attribute_hacks2)
  ;
  
  ds_matches :=
  DATASET([
     {pModule,'matches','(cnp_number_score := if [(])([^,]+),([^\n]+)'  ,'(cnp_number_score := if [(])[ ]*le.cnp_number = ri.cnp_number [ ]*([^\n]+)'                             ,'$1 le.cnp_number = ri.cnp_number /* $2 */ ,$3'          ,'Add cnp_number equality condition'}
    ,{pModule,'Debug','(cnp_number_score := if [(])([^,]+),([^\n]+)'  ,'(cnp_number_score := if [(])[ ]*le.cnp_number = ri.cnp_number [ ]*([^\n]+)'                             ,'$1 le.cnp_number = ri.cnp_number /* $2 */ ,$3'          ,'Add cnp_number equality condition'}
 // /*not needed in salt37*/   ,{pModule,'matches','(prim_range_derived_score := if [(])([^\n]+)'  ,'(prim_range_derived_score := if [(])[ ]*le.prim_range_derived = ri.prim_range_derived or[ ]*([^\n]+)'   ,'$1 le.prim_range_derived = ri.prim_range_derived or $2' ,'Add prim_range_derived equality condition'}
 // /*not needed in salt37*/   ,{pModule,'Debug','(prim_range_derived_score := if [(])([^\n]+)'  ,'(prim_range_derived_score := if [(])[ ]*le.prim_range_derived = ri.prim_range_derived or[ ]*([^\n]+)'   ,'$1 le.prim_range_derived = ri.prim_range_derived or $2' ,'Add prim_range_derived equality condition'}
    ,{pModule,'matches',',trans[(]LEFT,RIGHT,0[)]'  ,'[(] left.cnp_name = right.cnp_name [)] AND [(] left.company_address = right.company_address [)]'  ,'AND ~(( left.cnp_name = right.cnp_name ) AND ( left.company_address = right.company_address )),trans(LEFT,RIGHT,0)' ,'Hack removing perfect cnp name, address matches from mj0'}
    ,{pModule,'matches','LEFT.cnp_number = RIGHT.cnp_number'  ,'LEFT.prim_name_derived = RIGHT.prim_name_derived'  ,'LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_name_derived = RIGHT.prim_name_derived' ,'Hack adding prim_name_derived equality condition to mj0'}
 
    ,{pModule,'matches','n = 0 => \':cnp_number:st:prim_range_derived\',\'AttributeFile:\'[+][(]STRING[)][(]n-10000[)][)];'  ,''  
                          , '   n = 0 => \':cnp_number:st:prim_range_derived\'\n'
                          + '  ,n = 101 => \':cnp_number:prim_range_derived:cnp_name:st:pname_digits\'                      /* HACK */\n'
                          + '  ,n = 102 => \':cnp_number:prim_range_derived:prim_name_derived:st:cnp_name[1..4]\'                   /* HACK */\n'
                          + '  ,n = 103 => \':prim_range_derived:prim_name_derived:st:sec_range\'                                   /* HACK */\n'
                          + '  ,n = 104 => \':cnp_number:prim_range_derived:v_city_name:st:pname_digits:cnp_name_raw[1..4]\'/* HACK */\n'
                          + '  ,n = 105 => \':cnp_number:prim_range_derived:zip:st:pname_digits:cnp_name_raw[1..4]\'        /* HACK */\n'
                          + '  ,n = 106 => \':cnp_number:cnp_name:company_address\'                                 /* HACK */\n'
                          + '  ,\'AttributeFile:\'+(STRING)(n-10000)\n'
                          + '  );\n'
    ,'Hack Adding Rules for extra mjs'}
    
    ,{pModule,'matches','(salt37[.]mac_avoid_transitives[(]All_Matches,Proxid1,Proxid2,Conf,DateOverlap,Rule,o[)];)'  ,'BIPV2_ProxID[.]mac_avoid_transitives_scalene'  
                        ,  '// $1 /* HACK - disable default salt mac_avoid_transitives*/\n'
                        + 'import BIPV2_Tools;\n /*HACK, import module for new transitives macro*/\n'
                        + 'o := BIPV2_ProxID.mac_avoid_transitives_scalene(All_Matches,Proxid1,Proxid2,Conf,DateOverlap,Rule,MatchThreshold,10); // HACK - Use new transitives macro, bucket size 5*/\n'
    ,'Hack replacing transitives macro'}
    
    ,{pModule,'Debug','(ds_roll := ROLLUP[(] SORT[(] DISTRIBUTE[(] infile, HASH[(]Proxid[)] [)], Proxid, LOCAL [)], LEFT[.]Proxid = RIGHT[.]Proxid, RollValues[(]LEFT,RIGHT[)],LOCAL[)];)'  ,'rollup3'  
    ,                     '// $1 /* HACK - disable default ds_roll*/\n'
                        + 'rollup1 :=  ROLLUP( SORT( distribute(infile  ,random()) , Proxid ,local), LEFT.Proxid = RIGHT.Proxid, RollValues(LEFT,RIGHT),local); /*HACK*/\n'
                        + 'rollup2 :=  ROLLUP( SORT( distribute(rollup1 ,random()) , Proxid ,local), LEFT.Proxid = RIGHT.Proxid, RollValues(LEFT,RIGHT),local); /*HACK*/\n'
                        + 'rollup3 :=  ROLLUP( SORT( distribute(rollup2 ,proxid)   , Proxid ,local), LEFT.Proxid = RIGHT.Proxid, RollValues(LEFT,RIGHT),local); /*HACK*/\n'
                        + 'ds_roll := rollup3;                                                                                                                      /*HACK*/\n'
    ,'hack return rollup to eliminate skew errors'}
    
 // /*not needed salt37*/   ,{pModule,'matches','(Patchlgid3 := salt37[.]MAC_ParentId_Patch[(])o(,lgid3,Proxid[)];  // Collapse any lgid3 now joined by Proxid)'  ,''  ,' o_thin := TABLE(o,{ultid,orgid,lgid3,proxid,dotid,rcid}); // HACK\n' + '$1 o_thin $2/* HACK - slim dataset*/\n' ,'replacing Parentid patch'}
    ,{pModule,'matches','salt37[.]MAC_ParentId_Patch' ,''  ,'BIPV2_Tools.MAC_ParentId_Patch' ,'Hack replacing Parentid patch call'}
    ,{pModule,'matches','salt37[.]MAC_ChildID_Patch'  ,''  ,'BIPV2_Tools.MAC_ChildID_Patch' ,'replacing Childid patch call'}

    ,{pModule,'matches'
      ,'AllAttrMatches := SORT[(]Mod_Attr_SrcRidVlid[(]ih[)][.]Match[+]Mod_Attr_ForeignCorpkey[(]ih[)][.]Match[+]Mod_Attr_RAAddresses[(]ih[)][.]Match[+]Mod_Attr_FilterPrimNames[(]ih[)][.]Match,Proxid1'  
      ,'SrcRidVlid[(]ih[)][.]Match/[*]'  
      ,'AllAttrMatches := SORT(Mod_Attr_SrcRidVlid(ih).Match/*+Mod_Attr_ForeignCorpkey(ih).Match+Mod_Attr_RAAddresses(ih).Match+Mod_Attr_FilterPrimNames(ih).Match*/,Proxid1' 
      ,'only use srcridvlid att matches for speedup'
    }

  // /*not needed salt37*/  ,{pModule,'matches','EXPORT Patched_Infile := Patchdotid;'  ,''  ,'EXPORT Patched_Infile := JOIN(o, Patchdotid, LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(o),SELF:=RIGHT,SELF:=LEFT), KEEP(1), HASH); // HACK;' ,'adding join to patched_infile'}
    // ,{pModule,'attribute','regex'  ,'not_regex'  ,'replacement' ,'description'}
    // ,{pModule,'attribute','regex'  ,'not_regex'  ,'replacement' ,'description'}
    // ,{pModule,'attribute','regex'  ,'not_regex'  ,'replacement' ,'description'}

  ],Tools.layout_attribute_hacks2)
  
  + debug_n_matches_hacks('matches')  
  + debug_n_matches_hacks('Debug') 
  + ds_debug;
  ;

  ds_keys :=   DATASET([
     {pModule,'Keys'
     ,'^.*$'  
     ,'keynames'  
    , 'EXPORT Keys(DATASET(layout_DOT_Base) ih = dataset([],layout_DOT_Base),string liter = \'qa\' ,boolean pUseOtherEnvironment = false) := MODULE\n'
    + 'SHARED s := Specificities(ih).Specificities;\n'
    + 'SHARED mtch := debug(ih ,s[1]).AnnotateMatches(matches(ih).PossibleMatches,matches(ih).All_Attribute_Matches);\n'
    + 'prop_file := project(match_candidates(ih).candidates,BIPV2_ProxID._Old_layouts.mc); // Use propogated file\n'
    + 'EXPORT Candidates         := INDEX(prop_file,{Proxid},{prop_file},keynames(liter,pUseOtherEnvironment).match_candidates_debug.logical);\n'
    + 'ms_temp := project(sort(mtch,Conf,Proxid1,Proxid2,SKEW(1.0))  ,BIPV2_ProxID._Old_layouts.ms); // Some headers have very skewed IDs\n'
    + 'EXPORT MatchSample        := INDEX(ms_temp,{Conf,Proxid1,Proxid2},{ms_temp},keynames(liter,pUseOtherEnvironment).match_sample_debug.logical,SORT KEYED);\n'

    + 's_prep := project(s  ,transform(BIPV2_ProxID._Old_layouts.specs,//self._unnamed_1 := left._unnamed_1;\n'
    + 'self.active_duns_number_max         := left.active_duns_number_maximum      ;\n'
    + 'self.active_enterprise_number_max   := left.active_enterprise_number_maximum;\n'
    + 'self.active_domestic_corp_key_max   := left.active_domestic_corp_key_maximum;\n'
    + 'self.hist_enterprise_number_max     := left.hist_enterprise_number_maximum  ;\n'
    + 'self.hist_duns_number_max           := left.hist_duns_number_maximum        ;\n'
    + 'self.hist_domestic_corp_key_max     := left.hist_domestic_corp_key_maximum  ;\n'
    + 'self.foreign_corp_key_max           := left.foreign_corp_key_maximum        ;\n'
    + 'self.unk_corp_key_max               := left.unk_corp_key_maximum            ;\n'
    + 'self.ebr_file_number_max            := left.ebr_file_number_maximum         ;\n'
    + 'self.company_fein_max               := left.company_fein_maximum            ;\n'
    + 'self.cnp_name_max                   := left.cnp_name_maximum                ;\n'
    + 'self.cnp_number_max                 := left.cnp_number_maximum              ;\n'
    + 'self.cnp_btype_max                  := left.cnp_btype_maximum               ;\n'
    + 'self.company_phone_max              := left.company_phone_maximum           ;\n'
    + 'self.prim_name_derived_max          := left.prim_name_derived_maximum       ;\n'
    + 'self.sec_range_max                  := left.sec_range_maximum               ;\n'
    + 'self.v_city_name_max                := left.v_city_name_maximum             ;\n'
    + 'self.st_max                         := left.st_maximum                      ;\n'
    + 'self.zip_max                        := left.zip_maximum                     ;\n'
    + 'self.prim_range_derived_max         := left.prim_range_derived_maximum      ;\n'
    + 'self.company_csz_max                := left.company_csz_maximum             ;\n'
    + 'self.company_addr1_max              := left.company_addr1_maximum           ;\n'
    + 'self.company_address_max            := left.company_address_maximum         ;\n'
    + 'self.srcridvlid_max                 := left.srcridvlid_maximum              ;\n'
    + 'self.foreigncorpkey_max             := left.foreigncorpkey_maximum          ;\n'
    + 'self.raaddresses_max                := left.raaddresses_maximum             ;\n'
    + 'self.filterprimnames_max            := left.filterprimnames_maximum         ;\n' 
    + 'self := left;));\n'

    + 'EXPORT Specificities_Key  := INDEX(s_prep,{1},{s_prep},keynames(liter,pUseOtherEnvironment).specificities_debug.logical);\n'
    + 'am := matches(ih).All_Attribute_Matches;\n'
    + 'EXPORT Attribute_Matches  := INDEX(am,{Proxid1,Proxid2},{am},keynames(liter,pUseOtherEnvironment).attribute_matches.logical);\n'
    + 'prop_file := matches(ih).Patched_Candidates; // Available for External ADL2\n'
    + 'EXPORT PatchedCandidates  := INDEX(prop_file,{Proxid},{prop_file},keynames(liter,pUseOtherEnvironment).patched_candidates.logical);\n'
    + 'EXPORT InData             := INDEX(ih,{Proxid},{ih},keynames(liter,pUseOtherEnvironment).in_data.logical);\n'
    + '\n'
    + '// Create logic to manage the match history key\n'
    + '//EXPORT MatchHistoryName := \'~keep::BIPV2_ProxID::Proxid::MatchHistory\';\n'
    + '//EXPORT MatchHistoryFile := DATASET(MatchHistoryName,Matches(In_DOT_Base).id_shift_r,THOR); // Read in all the change history\n'
    + '//EXPORT MatchHistoryKeyName := \'~\'+\'key::BIPV2_ProxID::Proxid::History::Match\';\n'
    + '//  MH := MatchHistoryFile;\n'
    + '//EXPORT MatchHistoryKey := INDEX(MH,{Proxid_after},{MH},MatchHistoryKeyName);\n'
    + '// Build enough to support the data services such as cleave/best\n'
    + '// EXPORT InDataKeyName := \'~\'+\'key::BIPV2_ProxID::Proxid::Datafile::in_data\';\n'
    + '// EXPORT InData := INDEX(ih,{Proxid},{ih},InDataKeyName);\n'
    + '// SHARED Build_InData := BUILDINDEX(InData, OVERWRITE);\n'
    + '// EXPORT BuildData := PARALLEL(Build_Specificities_Key,Build_InData);\n'
    + '// Build enough to support the debug services such as the compare service\n'
    + 'EXPORT BuildDebug := PARALLEL(BUILDINDEX(Candidates,keynames(liter).match_candidates_debug.logical,OVERWRITE),BUILDINDEX(Specificities_Key,keynames(liter).specificities_debug.logical,FEW,OVERWRITE),BUILDINDEX(Attribute_Matches,keynames(liter).attribute_matches.logical,OVERWRITE));\n'
    + '// Build Everything\n'
    + 'EXPORT BuildAll := PARALLEL(BUILDINDEX(Candidates,keynames(liter).match_candidates_debug.logical,OVERWRITE),BUILDINDEX(MatchSample,keynames(liter).match_sample_debug.logical,OVERWRITE),BUILDINDEX(Specificities_Key,keynames(liter).specificities_debug.logical,FEW,OVERWRITE)/*,BUILDINDEX(PatchedCandidates,keynames(liter).patched_candidates.logical,OVERWRITE)*/,BUILDINDEX(Attribute_Matches,keynames(liter).attribute_matches.logical,OVERWRITE)/*,BUILDINDEX(InData,keynames(liter).in_data.logical,OVERWRITE)*/);\n'
    + 'END;\n'
    ,'Hack keys to build them with dates embedded.'}
  ],Tools.layout_attribute_hacks2);

  ds_MOD_Attr_ForeignCorpkey :=   DATASET([
     {pModule,'MOD_Attr_ForeignCorpkey'
     ,'^.*$'  
     ,'hack'  
       ,'// Logic to handle the matching around ForeignCorpkey\n'
      + ' \n'
      + 'IMPORT salt37,ut,std;\n'
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
      + '    salt37.StrType Basis    := Cands0.company_charter_number;/*HACK to get basis only*/\n'
      + '    salt37.StrType Context  := Cands0.company_inc_state; // Context for the basis (\'<\')\n'
      + 'end;\n'
      + '\n'
      + '  ChildRec := RECORD\n'
      + '    Cands0.Proxid;\n'
      + '//    Cands0.Basis_Weight100;/*hack*/\n'
      + '    // salt37.StrType Basis    := salt37.GetNthWord(Cands0.Basis,1,\'|\');/*HACK to get basis only*/\n'
      + '    // salt37.StrType Context  := salt37.GetNthWord(Cands0.Basis,2,\'|\'); // Context for the basis (\'<\')\n'
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
      + 'SHARED Cands := dataset([],recordof(match_candidates(ih).ForeignCorpkey_candidates));\n'
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
      + '                        salt37.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));\n'
      + '  INTEGER2 active_enterprise_number_score_temp := MAP( le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,\n'
      + '                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,\n'
      + '                        salt37.Fn_Fail_Scale(le.active_enterprise_number_weight100,s.active_enterprise_number_switch));\n'
      + '  INTEGER2 active_domestic_corp_key_score_temp := MAP( le.active_domestic_corp_key_isnull OR ri.active_domestic_corp_key_isnull => 0,\n'
      + '                        le.active_domestic_corp_key = ri.active_domestic_corp_key  => le.active_domestic_corp_key_weight100,\n'
      + '                        salt37.Fn_Fail_Scale(le.active_domestic_corp_key_weight100,s.active_domestic_corp_key_switch));\n'
      + '  INTEGER2 active_duns_number_score_temp := MAP( le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,\n'
      + '                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,\n'
      + '                        salt37.Fn_Fail_Scale(le.active_duns_number_weight100,s.active_duns_number_switch));\n'
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
    ,'Hack foreign corpkey to prevent skew and performance errors.'}
  ],Tools.layout_attribute_hacks2);

  ds_MOD_Attr_RAAddresses :=   DATASET([
     {pModule,'MOD_Attr_RAAddresses'
     ,'^.*$'  
     ,'hack'  
     ,  '// Logic to handle the matching around RAAddresses\n'
      + ' \n'
      + 'IMPORT salt37,ut,std;\n'
      + 'EXPORT MOD_Attr_RAAddresses(DATASET(layout_DOT_Base) ih,UNSIGNED MatchThreshold = 36) := MODULE\n'
      + '// Construct a function to filter matches to those that obey the force criteria on this attribute file.\n'
      + 'EXPORT ForceFilter(inhead,infile,id1,id2) := FUNCTIONMACRO\n'
      + '// Every attribute value has to exactly match every attribute value of the corresponding identifier or both have no values\n'
      + '  Cands0 := BIPV2_ProxID.file_RA_Addresses;/*HACK*/\n'
      + '// We are going to create a record for each candidate pair; this record will have a child dataset for the attribute values of each side\n'
      + '////\n'
      + 'childrec1 := \n'
      + 'record\n'
      + '    salt37.StrType Basis    := Cands0.cname;/*HACK to get basis only*/\n'
      + 'end;\n'
      + '\n'
      + '  ChildRec := RECORD\n'
      + '    Cands0.Proxid;\n'
      + '//    Cands0.Basis_Weight100;/*hack*/\n'
      + '    // salt37.StrType Basis    := salt37.GetNthWord(Cands0.Basis,1,\'|\');/*HACK to get basis only*/\n'
      + '    // salt37.StrType Context  := salt37.GetNthWord(Cands0.Basis,2,\'|\'); // Context for the basis (\'<\')\n'
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
      + 'SHARED Cands := dataset([],recordof(match_candidates(ih).RAAddresses_candidates));\n'
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
      + '                        salt37.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));\n'
      + '  INTEGER2 active_enterprise_number_score_temp := MAP( le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,\n'
      + '                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,\n'
      + '                        salt37.Fn_Fail_Scale(le.active_enterprise_number_weight100,s.active_enterprise_number_switch));\n'
      + '  INTEGER2 active_domestic_corp_key_score_temp := MAP( le.active_domestic_corp_key_isnull OR ri.active_domestic_corp_key_isnull => 0,\n'
      + '                        le.active_domestic_corp_key = ri.active_domestic_corp_key  => le.active_domestic_corp_key_weight100,\n'
      + '                        salt37.Fn_Fail_Scale(le.active_domestic_corp_key_weight100,s.active_domestic_corp_key_switch));\n'
      + '  INTEGER2 active_duns_number_score_temp := MAP( le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,\n'
      + '                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,\n'
      + '                        salt37.Fn_Fail_Scale(le.active_duns_number_weight100,s.active_duns_number_switch));\n'
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
    ,'Hack RA addresses to prevent skew and performance errors.'}
  ],Tools.layout_attribute_hacks2);

  ds_MOD_Attr_FilterPrimNames :=   DATASET([
     {pModule,'MOD_Attr_FilterPrimNames'
     ,'^.*$'  
     ,'hack'  
       ,'// Logic to handle the matching around FilterPrimNames\n'
      + ' \n'
      + 'IMPORT salt37,ut,std;\n'
      + 'EXPORT MOD_Attr_FilterPrimNames(DATASET(layout_DOT_Base) ih,UNSIGNED MatchThreshold = 30) := MODULE\n'
      + '// Construct a function to filter matches to those that obey the force criteria on this attribute file.\n'
      + 'EXPORT ForceFilter(inhead,infile,id1,id2) := FUNCTIONMACRO\n'
      + '// Every attribute value has to exactly match every attribute value of the corresponding identifier or both have no values\n'
      + '  Cands0 := BIPV2_ProxID.file_filter_Prim_names;/*HACK*/\n'
      + '// We are going to create a record for each candidate pair; this record will have a child dataset for the attribute values of each side\n'
      + '////\n'
      + 'childrec1 := \n'
      + 'record\n'
      + '    salt37.StrType Basis    ;/*HACK to get basis only*/\n'
      + 'end;\n'
      + '  ChildRec := RECORD\n'
      + '    Cands0.Proxid;\n'
      + '//    Cands0.Basis_Weight100;/*hack*/\n'
      + '    // salt37.StrType Basis    := salt37.GetNthWord(Cands0.Basis,1,\'|\');/*HACK to get basis only*/\n'
      + '    // salt37.StrType Context  := salt37.GetNthWord(Cands0.Basis,2,\'|\'); // Context for the basis (\'<\')\n'
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
      + 'SHARED Cands := dataset([],recordof(match_candidates(ih).FilterPrimNames_candidates));\n'
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
      + '                        salt37.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));\n'
      + '  INTEGER2 active_duns_number_score_temp := MAP( le.active_duns_number_isnull OR ri.active_duns_number_isnull => 0,\n'
      + '                        le.active_duns_number = ri.active_duns_number  => le.active_duns_number_weight100,\n'
      + '                        salt37.Fn_Fail_Scale(le.active_duns_number_weight100,s.active_duns_number_switch));\n'
      + '  INTEGER2 active_enterprise_number_score_temp := MAP( le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,\n'
      + '                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,\n'
      + '                        salt37.Fn_Fail_Scale(le.active_enterprise_number_weight100,s.active_enterprise_number_switch));\n'
      + '  INTEGER2 active_domestic_corp_key_score_temp := MAP( le.active_domestic_corp_key_isnull OR ri.active_domestic_corp_key_isnull => 0,\n'
      + '                        le.active_domestic_corp_key = ri.active_domestic_corp_key  => le.active_domestic_corp_key_weight100,\n'
      + '                        salt37.Fn_Fail_Scale(le.active_domestic_corp_key_weight100,s.active_domestic_corp_key_switch));\n'
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
    ,'Hack filter prim names att file to prevent skew and performance errors.'}
  ],Tools.layout_attribute_hacks2);


  ds_BasicMatch :=   DATASET([
    {  pModule
      ,'BasicMatch'
      ,'h01.*?sort.*?((,(.*?)),Proxid)[)].*?Match[[:space:]]*:=[[:space:]]*JOIN[(]h02,'  //regex
      ,'h01 := table'  //not regex
      ,   'h01 := table     (h00_match ,{$3,unsigned6 Proxid := min(group,Proxid)}\n'
        + '                             $2,merge);/*HACK TO SPEED UP*/\n'  //replacement
        + 'Match := JOIN(h01,'
      ,'fix dedup skew in basic match'
    }

  // SHARED PickOne := DEDUP( SORT( DISTRIBUTE( Match,HASH(Proxid1) ), Proxid1, Proxid2, LOCAL), Proxid1, LOCAL); // Lowest collector ID for each singleton
  // SHARED PickOne := table( Match  ,{Proxid1  ,unsigned6 Proxid2 := min(group,Proxid2)}, Proxid1, merge);/*HACK*/ // Lowest collector ID for each singleton
    ,{  pModule
      ,'BasicMatch'
      ,'SHARED PickOne := DEDUP[(] SORT[(] DISTRIBUTE[(] Match,HASH[(]Proxid1[)] [)], Proxid1, Proxid2, LOCAL[)], Proxid1, LOCAL[)];'  //regex
      ,'SHARED PickOne := table'  //not regex
      ,   'SHARED PickOne := table( Match  ,{Proxid1  ,unsigned6 Proxid2 := min(group,Proxid2)}, Proxid1, merge);/*HACK*/'  //replacement
      ,'speed up pickone'
    }



  ],Tools.layout_attribute_hacks2);

  ds_CompareService :=   DATASET([
     {pModule,'ProxidCompareService'
     ,'^.*$'  
     ,'_fun_CompareService'  
     ,  '/*--SOAP--\n'
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
      + '\n'
    ,'Hack ProxidCompareService to call the function.'}
  ],Tools.layout_attribute_hacks2);

  // ds_Fields :=   DATASET([
     // {pModule,'Fields','(EXPORT Proxid_Twoparents := DEDUP[(]JOIN[(])f,f,(LEFT[.]Proxid=RIGHT[.]Proxid AND LEFT[.]lgid3>RIGHT[.]lgid3,TRANSFORM[(][{]salt37[.]UIDType lgid31,salt37[.]UIDType Proxid,salt37[.]UIDType lgid32[}],SELF[.]lgid31:=LEFT[.]lgid3,SELF[.]lgid32:=RIGHT[.]lgid3,SELF[.]Proxid:=LEFT[.]Proxid[)],HASH[)],WHOLE RECORD,ALL[)];)'   ,'HACK [-] Proxid'  ,'f_thin := TABLE(f(proxid<>0,lgid3<>0),{proxid,lgid3},proxid,lgid3,MERGE); // HACK Proxid two parents to dedup self join dataset\n' + '$1 f_thin,f_thin, $2 /* HACK - Proxid Two Parents to dedup dataset*/\n' ,'hack Proxid_Twoparents'    }
    // ,{pModule,'Fields','(EXPORT lgid3_Twoparents := DEDUP[(]JOIN[(])f,f,(LEFT[.]lgid3=RIGHT[.]lgid3 AND LEFT[.]orgid>RIGHT[.]orgid,TRANSFORM[(][{]salt37[.]UIDType orgid1,salt37[.]UIDType lgid3,salt37[.]UIDType orgid2[}],SELF[.]orgid1:=LEFT[.]orgid,SELF[.]orgid2:=RIGHT[.]orgid,SELF[.]lgid3:=LEFT[.]lgid3[)],HASH[)],WHOLE RECORD,ALL[)];)'         ,'HACK [-] lgid3'   ,'f_thin := TABLE(f(lgid3<>0,orgid<>0),{lgid3,orgid},lgid3,orgid,MERGE); // HACK lgid3 two parents to dedup self join dataset\n'+ '$1 f_thin,f_thin, $2 /* HACK - lgid3 Two Parents to dedup dataset*/\n'       ,'hack lgid3_Twoparents'     }
    // ,{pModule,'Fields','(EXPORT orgid_Twoparents := DEDUP[(]JOIN[(])f,f,(LEFT[.]orgid=RIGHT[.]orgid AND LEFT[.]ultid>RIGHT[.]ultid,TRANSFORM[(][{]salt37[.]UIDType ultid1,salt37[.]UIDType orgid,salt37[.]UIDType ultid2[}],SELF[.]ultid1:=LEFT[.]ultid,SELF[.]ultid2:=RIGHT[.]ultid,SELF[.]orgid:=LEFT[.]orgid[)],HASH[)],WHOLE RECORD,ALL[)];)'         ,'HACK [-] orgid'   ,'f_thin := TABLE(f(orgid<>0,ultid<>0),{orgid,ultid},orgid,ultid,MERGE); // HACK orgid two parents to dedup self join dataset\n'+ '$1 f_thin,f_thin, $2 /* HACK - orgid Two Parents to dedup dataset*/\n'       ,'hack orgid_Twoparents'     }    
    // ,{pModule,'Fields','(EXPORT Proxid_Unbased := JOIN[(]f)(,bases,LEFT[.]Proxid=RIGHT[.]Proxid,TRANSFORM[(]LEFT[)],LEFT ONLY,HASH[)];)'  ,'HACK Proxid Unbased'  ,'$1 (Proxid<>0) $2 // HACK Proxid Unbased.  Add filter\n'  ,'hack ProxidUnbased'        }
    // ,{pModule,'Fields','(EXPORT lgid3_Unbased := JOIN[(]f)(,bases,LEFT[.]lgid3=RIGHT[.]lgid3,TRANSFORM[(]LEFT[)],LEFT ONLY,HASH[)];)'     ,'HACK lgid3 Unbased'   ,'$1 (lgid3<>0) $2 // HACK lgid3 Unbased.  Add filter\n'    ,'hack lgid3Unbased'         }
    // ,{pModule,'Fields','(EXPORT orgid_Unbased := JOIN[(]f)(,bases,LEFT[.]orgid=RIGHT[.]orgid,TRANSFORM[(]LEFT[)],LEFT ONLY,HASH[)];)'     ,'HACK orgid Unbased'   ,'$1 (orgid<>0) $2 // HACK orgid Unbased.  Add filter\n'    ,'hack orgidUnbased'         }
    // ,{pModule,'Fields','(EXPORT ultid_Unbased := JOIN[(]f)(,bases,LEFT[.]ultid=RIGHT[.]ultid,TRANSFORM[(]LEFT[)],LEFT ONLY,HASH[)];)'     ,'HACK ultid Unbased'   ,'$1 (ultid<>0) $2 // HACK ultid Unbased.  Add filter\n'    ,'hack ultidUnbased'         }
    // ,{pModule,'Fields','(f := TABLE[(]infile,[{]Proxid,rcid,lgid3,orgid,ultid[}][)]);'                                                    ,'HACK IDIntegrity'     ,'$1 : global; // HACK IDIntegrity to speed it up\n'        ,'hack IDIntegrity SpeedBoost'}
  // ],Tools.layout_attribute_hacks2);

  ds_config  :=  DATASET([
       {pModule,'Config','DoSliceouts := TRUE'  ,'DoSliceouts := false'  ,'DoSliceouts := false' ,'disable Sliceouts'}
  ],Tools.layout_attribute_hacks2);

  ds_Proc_Iterate  :=  DATASET([
       {pModule,'Proc_Iterate','STRING iter'                        ,',string keyversion' ,'STRING iter,string keyversion/*HACK -- add keyversion*/'            ,'add keyversion to parameters'          }
      ,{pModule,'Proc_Iterate','Keys[(]InFile[)].BuildAll;'         ,''                   ,'Keys(InFile,keyversion).BuildAll; // HACK keys to add keyersion'    ,'add keyversion parameter to keys call' }
      ,{pModule,'Proc_Iterate','changes_it\'[+]iter;'               ,''                   ,'changes_it\'+keyversion;/* HACK use keyversion for changes file*/'  ,'change to keyversion for changes file' }
  ],Tools.layout_attribute_hacks2);

  ds_match_candidates  :=  DATASET([
       {pModule,'match_candidates','(,HINT[(]parallel_match[)])'  ,'/*,HINT[(]parallel_match[)][*]//[*]HACK to prevent memory limit exceeded error[*]/'  ,'/*$1*//*HACK to prevent memory limit exceeded error*/' ,'remove hint(parallel_match)'}
      ,{pModule,'match_candidates'
       
       , '(Grpd := GROUP[(] SORT[(][[:space:]\n]*DISTRIBUTE[(] TABLE[(] propogated, [{] propogated, UNSIGNED2 Buddies := 0 [}][)],HASH[(]Proxid[)][)],[[:space:]\n]*Proxid,)' 
       + '([^)]*[)],[[:space:]\n]*Proxid,)'  
       ,'Proxid, SALT_Partition'  
       ,'$1 SALT_Partition/*Hack*/ ,$2 SALT_Partition/*Hack*/ ,' 

       // ,'(Grpd := GROUP[(] SORT[(][[:space:]\n]*DISTRIBUTE[(] TABLE[(] propogated, [{] propogated, UNSIGNED2 Buddies := 0 [}][)],HASH[(]Proxid[)][)],[[:space:]\n]*Proxid,)([[:alnum:]_,]*[)],[[:space:]\n]*Proxid,)'  
       // ,'Proxid, SALT_Partition'  
       // ,'$1 SALT_Partition ,$2 SALT_Partition,' 

       ,'add partition to h0 to get more matches'}
  ],Tools.layout_attribute_hacks2);

// Grpd := GROUP( SORT(
    // DISTRIBUTE( TABLE( propogated, { propogated, UNSIGNED2 Buddies := 0 }),HASH(Proxid)),
    // Proxid,SALT_Partition,active_duns_number,active_enterprise_number,active_domestic_corp_key,hist_enterprise_number,hist_duns_number,hist_domestic_corp_key,foreign_corp_key,unk_corp_key,ebr_file_number,company_fein,cnp_name,cnp_number,cnp_btype,company_phone,prim_name_derived,sec_range,v_city_name,st,zip,prim_range_derived,dt_first_seen,dt_last_seen, LOCAL),
    // Proxid,SALT_Partition



      // ,{pModule,'attribute','regex'  ,'not_regex'  ,'replacement' ,'description'}

      // ,{pModule,'attribute','regex'  ,'not_regex'  ,'replacement' ,'description'}

  ds_concat := 
      ds_matches
    + ds_keys
    + ds_MOD_Attr_ForeignCorpkey
    + ds_MOD_Attr_RAAddresses
    + ds_MOD_Attr_FilterPrimNames
    + ds_BasicMatch
    + ds_CompareService
    // + ds_Fields  //salt 3.7 has all of these improvements built in
    + ds_config
    + ds_Proc_Iterate
    + ds_match_candidates
    ;
  ds_result := ds_concat(pAttributeRegexFilter = '' or regexfind(pAttributeRegexFilter  ,theattribute,nocase));
  
  return Tools.HackAttribute2(ds_result,pShouldSaveAttributes,pEsp).saveit;

end;