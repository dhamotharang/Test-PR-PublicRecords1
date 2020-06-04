// -- BIPV2_LGID3_PlatForm._ApplyHacks('BIPV2_LGID3_PlatForm',,true).do_all_hacks;

import SALTTOOLS22,STD,wk_ut,tools;


EXPORT _ApplyHacks(
   string   pModule               = 'BIPV2_LGID3_PlatForm'
  ,string   pEsp                  = wk_ut._Constants.LocalEsp + ':8145'
  ,boolean  pShouldSaveAttributes = false
) :=
module
  EXPORT fGetAttribute(STRING att                 ):=SALTTOOLS22.mod_Soapcalls.fGetAttributes(pModule,att,pEsp)(COUNT(results)>0)[1].results[1].Text;
  EXPORT fPutAttribute(STRING att,STRING ecl_text ):=OUTPUT(SALTTOOLS22.mod_Soapcalls.fSaveAttribute(pModule,att,ecl_text,pEsp));
  
  // ----------------------------------------------------------------------------
  // -- fHackMatches
  // ----------------------------------------------------------------------------
  export fHackMatches(
  
     string   pAttribute            = 'matches' //this can be used for Debug and matches attributes
    ,boolean  pShouldSaveAttribute  = false
    
  ) :=
  function

    dme := dataset([
    {
       '(n = 0 =>.*?)(,\'AttributeFile:\'[+][(]STRING[)][(]n-10000[)][)];)'
      ,'n = 100'
      ,'$1\n'
      + ',n = 100 => \':duns_number\'\n'
      + ',n = 101 => \':company_fein\'\n'
      + '$2\n'
      ,'add rules for extra mjs' 
    }
    ,{
       'SALT30[.]mac_avoid_transitives[(]All_Matches,LGID31,LGID32,Conf,DateOverlap,Rule,o[)];'
      ,'BIPV2_Tools[.]mac_avoid_transitives'
      ,'// $1 /* HACK - disable default salt mac_avoid_transitives*/\n'
      + 'import BIPV2_Tools; /*HACK - import for new transitives macro*/\n'
      + 'BIPV2_Tools.mac_avoid_transitives(All_Matches,LGID31,LGID32,Conf,DateOverlap,Rule,o); // HACK - Use new transitives macro*/\n'
      ,'replace transitives macro'
    }
    ,{ 
       '(EXPORT matches[(]DATASET[(]layout_LGID3[)] ih,UNSIGNED MatchThreshold = Config[.]MatchThreshold[)] := MODULE)'
      ,'ih_thin'
      ,'$1\n'
     + 'SHARED ih_thin := TABLE(ih,{ultid,orgid,seleid,lgid3,proxid,dotid,rcid}); // HACK - slim layout for ut.MAC_Patch_Id, etc later on.\n'
      ,'add ih_thin dataset\n' 
    }
    ,{
       'SALT30[.]MAC_ParentId_Patch'
      ,''
      ,'BIPV2_Tools.MAC_ParentId_Patch'
      ,'replace SALT30.MAC_ParentId_Patch with BIPV2_Tools.MAC_ParentId_Patch\n' 
    }
    ,{
       'SALT30[.]MAC_ChildId_Patch'
      ,''
      ,'BIPV2_Tools.MAC_ChildId_Patch'
      ,'replace SALT30.MAC_ChildId_Patch with BIPV2_Tools.MAC_ChildId_Patch\n' 
    }
    ,{
       'ut.MAC_Patch_Id[(]ih,LGID3,BasicMatch[(]ih[)][.]patch_file,LGID31,LGID32,ihbp[)];'
      ,''
      ,'ut.MAC_Patch_Id(ih_thin,LGID3,BasicMatch(ih).patch_file,LGID31,LGID32,ihbp);'
      ,'replace ih with ih_thin in call to ut.MAC_Patch_Id\n' 
    }
    ,{
       'EXPORT Patched_Infile := PatchDotID;'
      ,''
      ,'SHARED Patched_Infile_thin := PatchDotID : INDEPENDENT; // HACK\n'
     + 'EXPORT Patched_Infile := JOIN(ih, Patched_Infile_thin, LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(ih),SELF:=RIGHT,SELF:=LEFT), KEEP(1), HASH); // HACK\n'
      ,'replace Patched_Infile to join back to full layout\n' 
    }
    ,{
       'id_shift_r note_change[(]ih le,patched_infile ri[)] := TRANSFORM'
      ,''
      ,'id_shift_r note_change(ih_thin le,patched_infile_thin ri) := TRANSFORM // HACK'
      ,'change parameters to thin layouts in note_change transform\n' 
    }

    ,{
       'EXPORT IdChanges := JOIN[(]ih,patched_infile'
      ,''
      ,'EXPORT IdChanges := JOIN(ih_thin/*HACK*/,patched_infile_thin/*HACK*/'
      ,'Thin files going into IDChanges\n' 
    }
    ,{
       'EXPORT PreIDs := BIPV2_LGID3_PlatForm.Fields[.]UIDConsistency[(]ih[)]; // Export whole consistency module'
      ,''
      ,'EXPORT PreIDs := BIPV2_LGID3_PlatForm.Fields.UIDConsistency(ih_thin/*HACK*/); // Export whole consistency module'
      ,'Thin files going into PreIDs\n' 
    }

    ,{
       'EXPORT PostIDs := BIPV2_LGID3_PlatForm.Fields.UIDConsistency[(]Patched_Infile[)]; // Export whole consistency module'
      ,''
      ,'EXPORT PostIDs := BIPV2_LGID3_PlatForm.Fields.UIDConsistency(Patched_Infile_thin); // Export whole consistency module'
      ,'Thin files going into PostIDs\n' 
    }
    
    ,{
       'EXPORT DuplicateRids0 := COUNT[(]Patched_Infile[)] - PostIDs.IdCounts[[]1[]][.]rcid_Count; // Should be zero'
      ,''
      ,'EXPORT DuplicateRids0 := COUNT(Patched_Infile_thin) - PostIDs.IdCounts[1].rcid_Count; // Should be zero'
      ,'Thin files going into DuplicateRids0\n' 
    }
    ],tools.layout_attribute_hacks);

    RETURN tools.HackAttribute(pModule,pAttribute,dme,pShouldSaveAttribute).saveit;
  
  end;
  
  /////////////Keys
  export fHackBasicMatch(
  
     string   pAttribute            = 'BasicMatch' 
    ,boolean  pShouldSaveAttribute  = false
    
  ) :=
  function
  
    dme := dataset([{
       '(// It is important.*?EXPORT basic_match_count := COUNT[(]PickOne[)];)'
      ,'EXPORT basic_match_count := 0'
      , '/* $1 */\n'
      + '// HACK - disable BasicMatch altogether\n'
      + 'EXPORT patch_file := dataset([],Rec);\n'
      + 'EXPORT input_file := h00_match;\n'
      + 'EXPORT basic_match_count := 0;\n'
      ,'fix dedup skew\n'
    }
    ],tools.layout_attribute_hacks);

    RETURN tools.HackAttribute(pModule,pAttribute,dme,pShouldSaveAttribute).saveit;
    
  END;

  /////////////fHackCompareService
  export fHackCompareService(
  
     string   pAttribute            = 'LGID3CompareService' 
    ,boolean  pShouldSaveAttribute  = false
    
  ) :=
  function
  
    dme := dataset([{
       // '^(?!.*?BIPV2_LGID3_PlatForm[.]_fn_CompareService.*).*$'
       '.*LGID3CompareService.*'
       
      ,'BIPV2_LGID3_PlatForm._fn_CompareService'
      
      ,
        '/*--SOAP--\n'
      + '<message name="LGID3CompareService">\n'
      + '<part name="LGID3One" type="xsd:string"/>\n'
      + '<part name="LGID3Two" type="xsd:string"/>\n'
      + '</message>\n'
      + '*/\n'
      + '/*--INFO-- Compare two IDs to see if they should be joined.<p>If it is easier you may place the two IDs on the first line and they will be parsed into first and second.</p>*/\n'
      + 'EXPORT LGID3CompareService := MACRO\n'
      + '  IMPORT SALT30,BIPV2_LGID3_PlatForm,ut;\n'
      + 'STRING50 LGID3onestr := \'\'  : STORED(\'LGID3One\');\n'
      + 'STRING20 LGID3twostr := \'*\'  : STORED(\'LGID3two\');\n'
      + 'BIPV2_LGID3_PlatForm._fn_CompareService((unsigned6)LGID3onestr,(unsigned6)LGID3twostr);\n'
      + 'ENDMACRO;\n'
      
      ,'because it has _fn_CompareService in it, which likely means it was already hacked.\n'
    }
    ],tools.layout_attribute_hacks);

    RETURN tools.HackAttribute(pModule,pAttribute,dme,pShouldSaveAttribute).saveit;

  END;

  /////////////Keys
  export fHackMatch_Candidates(
  
     string   pAttribute            = 'match_candidates' 
    ,boolean  pShouldSaveAttribute  = false
    
  ) :=
  function
  
    dme := dataset([{
       '(,HINT[(]parallel_match[)])'
      ,'/*,HINT[(]parallel_match[)][*]//[*]HACK to prevent memory limit exceeded error[*]/'
      ,'/*$1*//*HACK to prevent memory limit exceeded error*/'
      ,'remove hint(parallel_match)\n'
    }
    ],tools.layout_attribute_hacks);

    RETURN tools.HackAttribute(pModule,pAttribute,dme,pShouldSaveAttribute).saveit;

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
  EXPORT Proxid_Twoparents := DEDUP(JOIN(f,f,LEFT.Proxid=RIGHT.Proxid AND LEFT.lgid3>RIGHT.lgid3,TRANSFORM({salt30.UIDType lgid31,salt30.UIDType Proxid,salt30.UIDType lgid32},SELF.lgid31:=LEFT.lgid3,SELF.lgid32:=RIGHT.lgid3,SELF.Proxid:=LEFT.Proxid),HASH),WHOLE RECORD,ALL);
  EXPORT lgid3_Twoparents := DEDUP(JOIN(f,f,LEFT.lgid3=RIGHT.lgid3 AND LEFT.orgid>RIGHT.orgid,TRANSFORM({salt30.UIDType orgid1,salt30.UIDType lgid3,salt30.UIDType orgid2},SELF.orgid1:=LEFT.orgid,SELF.orgid2:=RIGHT.orgid,SELF.lgid3:=LEFT.lgid3),HASH),WHOLE RECORD,ALL);
  EXPORT orgid_Twoparents := DEDUP(JOIN(f,f,LEFT.orgid=RIGHT.orgid AND LEFT.ultid>RIGHT.ultid,TRANSFORM({salt30.UIDType ultid1,salt30.UIDType orgid,salt30.UIDType ultid2},SELF.ultid1:=LEFT.ultid,SELF.ultid2:=RIGHT.ultid,SELF.orgid:=LEFT.orgid),HASH),WHOLE RECORD,ALL);

  EXPORT Proxid_Unbased := JOIN(f,bases,LEFT.Proxid=RIGHT.Proxid,TRANSFORM(LEFT),LEFT ONLY,HASH);
  EXPORT lgid3_Unbased := JOIN(f,bases,LEFT.lgid3=RIGHT.lgid3,TRANSFORM(LEFT),LEFT ONLY,HASH);
  EXPORT orgid_Unbased := JOIN(f,bases,LEFT.orgid=RIGHT.orgid,TRANSFORM(LEFT),LEFT ONLY,HASH);
  EXPORT ultid_Unbased := JOIN(f,bases,LEFT.ultid=RIGHT.ultid,TRANSFORM(LEFT),LEFT ONLY,HASH);
*/

    dme := dataset([{
       '(EXPORT lgid3_Twoparents := DEDUP[(]JOIN[(])f,f,(LEFT[.]lgid3=RIGHT[.]lgid3 AND LEFT[.]seleid>RIGHT[.]seleid,TRANSFORM[(][{]salt30[.]UIDType seleid1,salt30[.]UIDType lgid3,salt30[.]UIDType seleid2[}],SELF[.]seleid1:=LEFT[.]seleid,SELF[.]seleid2:=RIGHT[.]seleid,SELF[.]lgid3:=LEFT[.]lgid3[)],HASH[)],WHOLE RECORD,ALL[)];)'
      ,''
      ,  'f_thin := TABLE(f(lgid3<>0,seleid<>0),{lgid3,seleid},lgid3,seleid,MERGE); // HACK lgid3 two parents to dedup self join dataset\n'
       + '$1 f_thin,f_thin, $2 /* HACK - lgid3 Two Parents to dedup dataset*/\n'
      ,'thin f before going into lgid3_Twoparents\n'
    }
    ,{
       '(EXPORT seleid_Twoparents := DEDUP[(]JOIN[(])f,f,(LEFT[.]seleid=RIGHT[.]seleid AND LEFT[.]orgid>RIGHT[.]orgid,TRANSFORM[(][{]salt30[.]UIDType orgid1,salt30[.]UIDType seleid,salt30[.]UIDType orgid2[}],SELF[.]orgid1:=LEFT[.]orgid,SELF[.]orgid2:=RIGHT[.]orgid,SELF[.]seleid:=LEFT[.]seleid[)],HASH[)],WHOLE RECORD,ALL[)];)' 
       ,''
       ,  'f_thin := TABLE(f(seleid<>0,orgid<>0),{seleid,orgid},seleid,orgid,MERGE); // HACK seleid two parents to dedup self join dataset\n'
        + '$1 f_thin,f_thin, $2 /* HACK - seleid Two Parents to dedup dataset*/\n'
      ,'thin f before going into seleid_Twoparents\n'
    }

    ,{
       '(EXPORT orgid_Twoparents := DEDUP[(]JOIN[(])f,f,(LEFT[.]orgid=RIGHT[.]orgid AND LEFT[.]ultid>RIGHT[.]ultid,TRANSFORM[(][{]salt30[.]UIDType ultid1,salt30[.]UIDType orgid,salt30[.]UIDType ultid2[}],SELF[.]ultid1:=LEFT[.]ultid,SELF[.]ultid2:=RIGHT[.]ultid,SELF[.]orgid:=LEFT[.]orgid[)],HASH[)],WHOLE RECORD,ALL[)];)' 
       ,''
       ,  'f_thin := TABLE(f(orgid<>0,ultid<>0),{orgid,ultid},orgid,ultid,MERGE); // HACK orgid two parents to dedup self join dataset\n'
        + '$1 f_thin,f_thin, $2 /* HACK - orgid Two Parents to dedup dataset*/\n'
      ,'thin f before going into orgid_Twoparents\n'
    }
    ,{
       '(EXPORT lgid3_Unbased := JOIN[(]f)(,bases,LEFT[.]lgid3=RIGHT[.]lgid3,TRANSFORM[(]LEFT[)],LEFT ONLY,HASH[)];)' 
       ,''
       ,'$1 (lgid3<>0) $2 // HACK lgid3 Unbased.  Add filter\n'
      ,'hacking lgid3_unbased\n'
    }
    ,{
       '(EXPORT seleid_Unbased := JOIN[(]f)(,bases,LEFT[.]seleid=RIGHT[.]seleid,TRANSFORM[(]LEFT[)],LEFT ONLY,HASH[)];)' 
       ,''
       ,'$1 (seleid<>0) $2 // HACK seleid Unbased.  Add filter\n'
      ,'hacking seleid_unbased\n'
    }
    ,{
       '(EXPORT orgid_Unbased := JOIN[(]f)(,bases,LEFT[.]orgid=RIGHT[.]orgid,TRANSFORM[(]LEFT[)],LEFT ONLY,HASH[)];)' 
       ,''
       ,'$1 (orgid<>0) $2 // HACK orgid Unbased.  Add filter\n'
      ,'hacking orgid_unbased\n'
    }
    ,{
       '(EXPORT ultid_Unbased := JOIN[(]f)(,bases,LEFT[.]ultid=RIGHT[.]ultid,TRANSFORM[(]LEFT[)],LEFT ONLY,HASH[)];)' 
       ,''
       ,'$1 (ultid<>0) $2 // HACK ultid Unbased.  Add filter\n'
      ,'hacking ultid_unbased\n'
    }
    ,{
       '(f := TABLE[(]infile,[{]LGID3,rcid,seleid,orgid,ultid[}][)]);' 
       ,''
       ,'$1 : global; // HACK IDIntegrity to speed it up\n'
      ,'hacking IDIntegritySpeedBoost\n\n'
    }
    ],tools.layout_attribute_hacks);

    RETURN tools.HackAttribute(pModule,pAttribute,dme,pShouldSaveAttribute).saveit;

    
  END;

  export fHackConfig(
  
     string   pAttribute            = 'Config' 
    ,boolean  pShouldSaveAttribute  = false
    
  ) :=
  function
  

    dme := dataset([{
       'DoSliceouts := TRUE'
      ,'DoSliceouts := false'
      ,'DoSliceouts := false'
      ,'turn off sliceouts\n'
    }
    ],tools.layout_attribute_hacks);

    RETURN tools.HackAttribute(pModule,pAttribute,dme,pShouldSaveAttribute).saveit;

  END;

  export fHackProc_Iterate(
  
     string   pAttribute            = 'Proc_Iterate' 
    ,boolean  pShouldSaveAttribute  = false
    
  ) :=
  function
  
    dme := dataset([{
          'ChangeName := \'[~]temp::LGID3::BIPV2_LGID3_PlatForm::changes_it\'[+]iter;'
      ,''
      ,   'import bipv2;\n'
        + 'ChangeName := \'~temp::LGID3::BIPV2_LGID3_PlatForm::changes_it\'+iter+\'_\'+ bipv2.KeySuffix;'
      ,'add keysuffix to changes filename\n'
    }
    ],tools.layout_attribute_hacks);

    RETURN tools.HackAttribute(pModule,pAttribute,dme,pShouldSaveAttribute).saveit;

  END;

  export do_all_hacks := 
    sequential(
       fHackMatches         ('matches'              ,pShouldSaveAttributes)
      ,fHackBasicMatch      ('BasicMatch'           ,pShouldSaveAttributes)
      ,fHackCompareService  ('LGID3CompareService'  ,pShouldSaveAttributes)
      ,fHackMatch_Candidates('match_candidates'     ,pShouldSaveAttributes)
      ,fHackFields          ('Fields'               ,pShouldSaveAttributes)
      ,fHackConfig          ('Config'               ,pShouldSaveAttributes)
      ,fHackProc_Iterate    ('Proc_Iterate'         ,pShouldSaveAttributes)
    );
end;
