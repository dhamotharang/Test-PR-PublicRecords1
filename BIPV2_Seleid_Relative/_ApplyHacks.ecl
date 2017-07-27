// -- BIPV2_LGID3._ApplyHacks('BIPV2_LGID3',,true).do_all_hacks;

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
       ',IF[(]again,OutputFileA,OutputFile[)],OutputChanges'
      ,'/[*],IF[(]again,OutputFileA,OutputFile[)],OutputChanges[*]/'
      ,'/*,IF(again,OutputFileA,OutputFile),OutputChanges*//*HACK*/'
      ,'disable output file and changes file\n'
    }
    ,{
      'BUILDINDEX[(]keys[(]InFile[)][.]ASSOC,OVERWRITE[)];'
      ,'BIPV2_Seleid_Relative[.]keynames[(]bipv2[.]keyversion[)][.]assoc[.]logical'
      ,'BUILDINDEX(keys(InFile).ASSOC ,BIPV2_Seleid_Relative.keynames(BIPV2_Seleid_Relative.KeyInfix).assoc.logical/*HACK*/,OVERWRITE);'
      ,'build relative key correctly'
    
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
       'KeyInfix'
      ,'BIPV2_Seleid_Relative[.]config[.]keyinfix_specificities'
      ,'BIPV2_Seleid_Relative.config.keyinfix_specificities/*HACK*/'
      ,'replace keyinfix with config.keyinfix_specificities for specs keys to allow for 2 step specificities to not have to be run each time \n'
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
       'EXPORT MatchThreshold := 41;'
      ,'EXPORT keyinfix_specificities := \'qa\';'
      ,'EXPORT MatchThreshold := 41;\n' + 'EXPORT keyinfix_specificities := \'qa\';/*HACK*/'
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
  
    dme := dataset([{
       'EXPORT RelKeyNameASSOC := \'~\'[+]KeyPrefix'
      ,'EXPORT RelKeyNameASSOC := BIPV2_Seleid_Relative[.]_Constants[(]_Constants[.]IsDataland[)][.]prefix [+]KeyPrefix'
      ,'import tools;/*HACK*/\n' + 'EXPORT RelKeyNameASSOC := BIPV2_Seleid_Relative._Constants(tools._Constants.IsDataland).prefix +KeyPrefix/*HACK*/'
      ,'Replace ~ with BIPV2_Seleid_Relative._Constants so it points to prod on dataland'
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
      
      , '/*HACK FOLLOWS*/'
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
       'J2 := SORT(J1,Seleid2,dedup_val);'
      ,'DJ := DISTRIBUTE[(]J1, HASH[(]Seleid1[)], MERGE[(]Seleid1[)][)];'
      ,   '/*HACKS FOLLOW*/'
        + 'DJ := DISTRIBUTE(J1, HASH(Seleid1), MERGE(Seleid1));\n'
        + 'R  := GROUP(DJ, Seleid1, LOCAL);\n'
        + 'J2 := SORT(R,Seleid2,dedup_val);\n'
        + '/*HACKS END*/'
      ,'recreate manually the dist,group, and sort for notelink join'
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
