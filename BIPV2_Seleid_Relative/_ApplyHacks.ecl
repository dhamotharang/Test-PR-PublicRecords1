// -- BIPV2_Seleid_Relative._ApplyHacks('BIPV2_Seleid_Relative',,true).do_all_hacks;
import SALTTOOLS22,STD,wk_ut,tools;
EXPORT _ApplyHacks(
   string   pModule               = 'BIPV2_Seleid_Relative'
  ,string   pEsp                  = wk_ut._Constants.LocalEsp + ':8145'
  ,boolean  pShouldSaveAttributes = false
) :=
module
  EXPORT fGetAttribute(STRING att                 ):=SALTTOOLS22.mod_Soapcalls.fGetAttributes(pModule,att,pEsp)(COUNT(results)>0)[1].results[1].Text;
  EXPORT fPutAttribute(STRING att,STRING ecl_text ):=OUTPUT(SALTTOOLS22.mod_Soapcalls.fSaveAttribute(pModule,att,ecl_text,pEsp));
  
  export fHackProc_Iterate(
  
     string   pAttribute            = 'Proc_Iterate' 
    ,boolean  pShouldSaveAttribute  = false
    
  ) :=
  function
  
    dme := dataset([{
           ',IF[(]again,OutputFileA,OutputFile[)],IF[(]again,OutputChangesA,OutputChanges[)]'
      ,'/[*],IF[(]again,OutputFileA,OutputFile[)],IF[(]again,OutputChangesA,OutputChanges[)][*]/'
      ,'/*,IF(again,OutputFileA,OutputFile),IF(again,OutputChangesA,OutputChanges)*//*HACK*/'
      ,'disable output file and changes file\n'
    }

    ,{
       'InFile0 = BIPV2_Seleid_Relative[.]In_Base,'
      ,'HACK TO ADD PVERSION'
      ,'InFile0 = BIPV2_Seleid_Relative.In_Base,string pversion = BIPV2_Seleid_Relative.KeyInfix/*HACK TO ADD PVERSION*/,'
      ,'add pversion to parameters in proc_iterate\n'
    }
    
    ,{
       'Keys[(]InFile[)]'
      ,'HACK PASS IN PVERSION TO KEYS'
      ,'Keys(InFile,pversion/*HACK PASS IN PVERSION TO KEYS*/)'
      ,'HACK PASS IN PVERSION TO KEYS in proc_iterate\n'
    }
    
    ],tools.layout_attribute_hacks);
    RETURN tools.HackAttribute(pModule,pAttribute,dme,pShouldSaveAttribute).saveit;
  END;

  export fHackspecificities(
  
     string   pAttribute            = 'specificities' 
    ,boolean  pShouldSaveAttribute  = false
    
  ) :=
  function

    dme := dataset([{
          'SALT3[1234567].mac_edit_distance_pairs'
      ,''
      ,   '/*HACK*/SALT38.mac_edit_distance_pairs'
      ,'use newer version of macro for performance\n'
    }
		,{
          '(IMPORT ut,SALT3[1234567])'
      ,''
      ,   '$1, /*HACK*/SALT38'
      ,'use newer version of macro for performance\n'
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
       'KeyInfix_specificities := KeyInfix'
      ,'KeyInfix_specificities := \'qa\';'
      ,'KeyInfix_specificities := \'qa\';/*HACK*/'
      ,'replace keyinfix with config.keyinfix_specificities for specs keys to allow for 2 step specificities to not have to be run each time \n'
    }
    ],tools.layout_attribute_hacks);
    RETURN tools.HackAttribute(pModule,pAttribute,dme,pShouldSaveAttribute).saveit;
  END;
  export fHackKeys(
  
     string   pAttribute            = 'Keys' 
    ,boolean  pShouldSaveAttribute  = false
    
  ) :=
  function
  
    dme := dataset([


    {

       'EXPORT Keys'
      ,'HACK TO ADD doxie import'
      ,'import doxie;/*HACK TO ADD doxie import*/\nEXPORT Keys'
      ,'HACK TO ADD doxie import\n'
    }
   ,{

       'Keys[(]DATASET[(]layout_Base[)] ih[)]'
      ,'HACK TO ADD PVERSION'
      ,'Keys(DATASET(layout_Base) ih,string pversion = BIPV2_Seleid_Relative.KeyInfix/*HACK TO ADD PVERSION*/)'
      ,'add pversion to parameters for keys attribute\n'
    }

   ,{

       'RelKeyNameASSOC := \'~\'[+]KeyPrefix[+]\'::\'[+]\'key::BIPV2_Seleid_Relative\'[+]\'::\'[+]Config.KeyInfix[+]\'::Seleid::Rel::ASSOC\''
      ,'HACK TO NAME ASSOC KEY TO ROXIE SUPERKEY'
      ,'RelKeyNameASSOC := BIPV2_Seleid_Relative.keynames(doxie.Version_SuperKey).assoc.logical;/*HACK TO NAME ASSOC KEY TO ROXIE SUPERKEY*/'
      ,'name assoc key properly in keys attribute\n'
    }

    ,{
       'RelationshipKeys := BUILDINDEX[(]ASSOC, OVERWRITE[)]'
      ,'HACK TO BUILD ASSOC KEY IN CORRECT NAME FOR ROXIE'
      ,'RelationshipKeys := BUILDINDEX(ASSOC,BIPV2_Seleid_Relative.keynames(pversion).assoc.logical, OVERWRITE)/*HACK TO BUILD ASSOC KEY IN CORRECT NAME FOR ROXIE*/'
      ,'BUILD ASSOC KEY IN CORRECT NAME FOR ROXIE\n'    
    }
    
    ,{
       'EXPORT BuildDebug := PARALLEL[(]Build_Specificities_Key, PARALLEL[(]BUILDINDEX[(]Candidates, OVERWRITE[)],BUILDINDEX[(]MatchHistoryKey, OVERWRITE[)][)][)];'
      ,'REMOVE MATCH HISTORY HACK'
      ,'EXPORT BuildDebug := PARALLEL(Build_Specificities_Key, PARALLEL(BUILDINDEX(Candidates, OVERWRITE)/*,BUILDINDEX(MatchHistoryKey, OVERWRITE)*//*REMOVE MATCH HISTORY HACK*/));'
      ,'comment out match history.  not needed and fails anyway.\n'
    
    }

    ,{
       ':= MODULE'
      ,'HACK INLINE FOR ROXIE'
      ,':= INLINE MODULE/*HACK INLINE FOR ROXIE*/'
      ,'ADD INLINE TO MODULE DEFINITION FOR ROXIE\n'
    
    }
    ,{
       'EXPORT SpecificitiesDebugKeyName := \'[~]\'[+]\'key::BIPV2_Seleid_Relative::Seleid::Debug::specificities_debug\';'
      ,'HACK TO NAME SPECS KEY TO ROXIE SUPERKEY'
      ,'EXPORT SpecificitiesDebugKeyName := BIPV2_Seleid_Relative.keynames(doxie.Version_SuperKey).specs.logical;/*HACK TO NAME SPECS KEY TO ROXIE SUPERKEY*/'
      ,'NAME SPECIFICITIES KEY THE CORRECT NAME FOR ROXIE\n'
    
    }
    ,{
       'EXPORT CandidatesKeyName := \'~\'[+]\'key::BIPV2_Seleid_Relative::Seleid::Debug::match_candidates_debug\';'
      ,'HACK TO NAME MC KEY TO ROXIE SUPERKEY'
      ,'EXPORT CandidatesKeyName := BIPV2_Seleid_Relative.keynames(doxie.Version_SuperKey).mc.logical;/*HACK TO NAME MC KEY TO ROXIE SUPERKEY*/'
      ,'NAME MC KEY THE CORRECT NAME FOR ROXIE\n'    
    }

    ,{
       'BUILDINDEX[(]Specificities_Key, OVERWRITE, FEW[)];'
      ,'HACK TO BUILD SPECS KEY IN CORRECT NAME FOR ROXIE'
      ,'BUILDINDEX(Specificities_Key,BIPV2_Seleid_Relative.keynames(pversion).specs.logical, OVERWRITE, FEW);/*HACK TO BUILD SPECS KEY IN CORRECT NAME FOR ROXIE*/'
      ,'BUILD MC KEY IN CORRECT NAME FOR ROXIE\n'    
    }

    ,{
       'BUILDINDEX[(]Candidates, OVERWRITE[)]'
      ,'HACK TO BUILD MC KEY IN CORRECT NAME FOR ROXIE'
      ,'BUILDINDEX(Candidates,BIPV2_Seleid_Relative.keynames(pversion).mc.logical, OVERWRITE)/*HACK TO BUILD MC KEY IN CORRECT NAME FOR ROXIE*/'
      ,'BUILD MC KEY IN CORRECT NAME FOR ROXIE\n'    
    }



    ],tools.layout_attribute_hacks);
    RETURN tools.HackAttribute(pModule,pAttribute,dme,pShouldSaveAttribute).saveit;
  END;
  export fHackmatch_candidates(
  
     string   pAttribute            = 'match_candidates' 
    ,boolean  pShouldSaveAttribute  = false
    
  ) :=
  function
  
    dme := dataset([{
       ',HINT[(]parallel_match[)]'
      ,'/[*],HINT[(]parallel_match[)][*]/'
      ,'/*,HINT(parallel_match)*//*HACK*/'
      ,'comment out hint(parallel_match) to avoid out of memory error'
    }
    ],tools.layout_attribute_hacks);
    RETURN tools.HackAttribute(pModule,pAttribute,dme,pShouldSaveAttribute).saveit;
  END;
  export fHackRelationships(
  
     string   pAttribute            = 'relationships' 
    ,boolean  pShouldSaveAttribute  = false
    
  ) :=
  function
  
    dme := dataset([
     {
       '(IMPORT SALT[[:digit:]]{2},ut;)'
      ,'import mdr;'
      ,'$1\n' + 'import mdr;//HACK'
      ,'add import mdr;'
    }
    ,{
       'SHARED CandidatesNAMEST := TABLE[(]BaseFile([(]cnp_name_weight100 [+] st_weight100>=[[:digit:]]+[)]),SlimRec[)];'
      ,'CandidatesNAMEST1'
      
      , '/*HACK FOLLOWS*/\n'
      + '/******* To filter any franchise from name st relationship *****/\n'
      + 'CandidatesNAMEST1 := BaseFile $1;\n\n'
      + '// select the franchise seleids in the basefile.\n'
      + 'frandxSeleId := DEDUP(TABLE(basefile(MDR.sourceTools.SourceIsFrandx(source)), \n'
      + '									{basefile.seleId}), ALL);\n\n'
      + '// left only here to eliminate all the franchise seleids from name relationship.\n'
      + 'noFrandxCandidates := JOIN(DISTRIBUTE(CandidatesNAMEST1, HASH(seleid)), \n'
      + '														DISTRIBUTE(frandxSeleId, HASH(seleid)),\n'
      + '														left.seleid = right.seleid, left only, local);\n'
      + 'SlimRec1 := RECORD\n'
      + '  noFrandxCandidates.Seleid;\n'
      + '  noFrandxCandidates.cnp_name;\n'
      + ' noFrandxCandidates.cnp_name_weight100;\n'
      + '  noFrandxCandidates.st;\n'
      + ' noFrandxCandidates.st_weight100;\n'
      + ' noFrandxCandidates.dt_first_seen;\n'
      + ' noFrandxCandidates.dt_last_seen;\n'
      + 'END;\n'
      + 'SHARED CandidatesNAMEST := TABLE(noFrandxCandidates,SlimRec1);\n '
      + '/*HACKS END*/'
      ,'Remove franchise from NAME ST relationship'
    }
    ,{
       'J1 := JOIN[(]le,ri,LEFT[.]Seleid>RIGHT[.]Seleid AND LEFT[.]cnp_name=RIGHT[.]cnp_name AND LEFT[.]st=RIGHT[.]st,NoteLink[(]LEFT,RIGHT[)],ATMOST[(]LEFT[.]cnp_name=RIGHT[.]cnp_name AND LEFT[.]st=RIGHT[.]st,10000[)],GROUP[(]LEFT.Seleid[)][)];'
      ,'J1 := JOIN[(]le,ri,LEFT[.]Seleid>RIGHT[.]Seleid AND LEFT[.]cnp_name=RIGHT[.]cnp_name AND LEFT[.]st=RIGHT[.]st,NoteLink[(]LEFT,RIGHT[)],ATMOST[(]LEFT[.]cnp_name=RIGHT[.]cnp_name AND LEFT[.]st=RIGHT[.]st,10000[)]/[*],GROUP[(]LEFT.Seleid[)][*]//[*]HACK[*]/,local[)];'
      ,'J1 := JOIN(le,ri,LEFT.Seleid>RIGHT.Seleid AND LEFT.cnp_name=RIGHT.cnp_name AND LEFT.st=RIGHT.st,NoteLink(LEFT,RIGHT),ATMOST(LEFT.cnp_name=RIGHT.cnp_name AND LEFT.st=RIGHT.st,10000)/*,GROUP(LEFT.Seleid)*//*HACK*/,local);'
      ,'add local and remove group(left.seleid) to NoteLink join to avoid out of memory error'
    }
    ,{
       'J2 := SORT[(]J1,Seleid2,dedup_val[)];'
      ,'DJ := DISTRIBUTE[(]J1, HASH[(]Seleid1[)], MERGE[(]Seleid1[)][)];'
      ,   '/*HACKS FOLLOW*/'
        + 'DJ := DISTRIBUTE(J1, HASH(Seleid1), MERGE(Seleid1));\n'
        + 'R  := GROUP(DJ, Seleid1, LOCAL);\n'
        + 'J2 := SORT(R,Seleid2,dedup_val);\n'
        + '/*HACKS END*/'
      ,'recreate manually the dist,group, and sort for notelink join'
     }
    ,{
       ':= MODULE'
      ,'HACK INLINE FOR ROXIE'
      ,':= INLINE MODULE/*HACK INLINE FOR ROXIE*/'
      ,'ADD INLINE TO MODULE DEFINITION FOR ROXIE\n'
    
    }
    ],tools.layout_attribute_hacks);
    RETURN tools.HackAttribute(pModule,pAttribute,dme,pShouldSaveAttribute).saveit;
  END;
  
/*  out of memory here:
    <att name="definition" value="BIPV2_Seleid_Relative.relationships(37,5)"/>
    <att name="name" value="j1"/>
    <att name="_kind" value="17"/>
    <att name="local" value="1"/>
    <att name="ecl" value="JOIN(LEFT.seleid > RIGHT.seleid AND LEFT.cnp_name = RIGHT.cnp_name AND LEFT.st = RIGHT.st, notelink(LEFT, RIGHT), atmost(LEFT.cnp_name = RIGHT.cnp_name AND LEFT.st = RIGHT.st, 10000), lookup, many, local);\n"/>
relationships:
*/
  export do_all_hacks := 
    sequential(
       fHackProc_Iterate    ('Proc_Iterate'     ,pShouldSaveAttributes)
      ,fHackspecificities   ('specificities'    ,pShouldSaveAttributes)
      ,fHackConfig          ('Config'           ,pShouldSaveAttributes)
      ,fHackKeys            ('Keys'             ,pShouldSaveAttributes)
      ,fHackRelationships   ('relationships'    ,pShouldSaveAttributes)
      ,fHackmatch_candidates('match_candidates' ,pShouldSaveAttributes)
    );
end;
