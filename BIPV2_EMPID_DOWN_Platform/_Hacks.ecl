// -- BIPV2_EMPID_DOWN_Platform._Hacks('BIPV2_EMPID_DOWN_Platform',,true).do_all_hacks;
import SALTTOOLS22,STD,wk_ut,tools;
EXPORT _Hacks(
   string   pModule               = 'BIPV2_EMPID_DOWN_Platform'
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
    ,boolean  pShouldSaveAttribute  = pShouldSaveAttributes
    
  ) :=
  function
    dboth := dataset([
    { 
          '(lname_score := IF [(])([[:space:]]lname_score_temp)'
      ,''
      ,   '$1le.lname = ri.lname or/*HACK*/ $2'
      ,'add lname perfect match condition to force(+) in match join transform to emulate default force behaviour\n'
    }
    ,{
          '(fname_score := IF [(])([[:space:]]fname_score_temp)'
      ,''
      ,   '$1le.fname = ri.fname or/*HACK*/ $2'
      ,'add fname perfect match condition to force(+) in match join transform to emulate default force behaviour\n'
    }
    ],tools.layout_attribute_hacks);
    
    dmatches := dataset([
     {
          '(AND [(] [~]left[.]lname_isnull AND [~]right[.]lname_isnull [)])'
      ,'/[*] AND [(] [~]left[.]lname_isnull'
      ,   '/* $1 *//*HACK*/'
      ,'comment out lname is null in match join condition to allow for blank to blank matching\n'
    }
    ,{
          '(AND [(] [~]left[.]fname_isnull AND [~]right[.]fname_isnull [)])'
      ,'/[*] AND [(] [~]left[.]fname_isnull'
      ,   '/* $1 *//*HACK*/'
      ,'comment out fname is null in match join condition to allow for blank to blank matching\n'
    }
    ,{
          'JOIN[(]ih, Patched_Infile_thin, LEFT[.]rcid=RIGHT[.]rcid, TRANSFORM[(]RECORDOF[(]ih[)],SELF:=RIGHT,SELF:=LEFT[)], KEEP[(]1[)], SMART[)];'
      ,', HASH/[*]HACK[*]/'
      ,   'JOIN(ih, Patched_Infile_thin, LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(ih),SELF:=RIGHT,SELF:=LEFT), KEEP(1), HASH/*HACK*/);'
      ,'change pi1 smart join to hash join to prevent mp link closed error in dataland( W20151021-120318 )(maybe prod)\n'
    }
    ],tools.layout_attribute_hacks);
    dme := if(pAttribute = 'matches'  ,dboth + dmatches ,dboth);
    RETURN tools.HackAttribute(pModule,pAttribute,dme,pShouldSaveAttribute).saveit;
  
  end;
  
  export fHackProc_Iterate(
  
     string   pAttribute            = 'Proc_Iterate' 
    ,boolean  pShouldSaveAttribute  = pShouldSaveAttributes
    
  ) :=
  function
// - added keysuffix to changes filename.  so it will be unique per build and prevent superfile error too.
  // import bipv2;
  // EXPORT OutputChanges := OUTPUT(MM.IdChanges,,'~temp::EmpID::BIPV2_EMPID_DOWN_Platform::changes_it'+iter+'_'+ bipv2.KeySuffix,OVERWRITE,COMPRESSED);// Changes made
  
    dme := dataset([{
          'SHARED ChangeName := \'[~]temp::EmpID::BIPV2_EMPID_DOWN_Platform::changes_it\'[+]iter;'
      ,''
      ,   'import bipv2;\n'
        + 'SHARED ChangeName := \'~temp::EmpID::BIPV2_EMPID_DOWN_Platform::changes_it\'+iter+\'_\'+ pversion/*HACK*/;'
      ,'add keysuffix to changes filename\n'
    }
    ,{
          '[(]STRING iter'
      ,'string pversion'
      ,   '(string pversion/*HACK*/,string iter'
      ,'add pversion parameter\n'
    }
    ],tools.layout_attribute_hacks);
    RETURN tools.HackAttribute(pModule,pAttribute,dme,pShouldSaveAttribute).saveit;
  END;
  // export fHackFields(
  
     // string   pAttribute            = 'Fields' 
    // ,boolean  pShouldSaveAttribute  = pShouldSaveAttributes
    
  // ) :=
  // function
  
    // dme := dataset([{
          // 'NOT IN T'
      // ,'[[]\'T\'[]]/[*]HACK[*]/'
      // ,   'NOT IN [\'T\']/*HACK*/'
      // ,'change [T] to [\'T\']\n'
    // }
    // ],tools.layout_attribute_hacks);
    // RETURN tools.HackAttribute(pModule,pAttribute,dme,pShouldSaveAttribute).saveit;
  // END;
  export do_all_hacks := 
    sequential(
       fHackMatches         ('matches'              )
      ,fHackMatches         ('Debug'                )
      ,fHackProc_Iterate    ('Proc_Iterate'         )
      // ,fHackFields          ('Fields'               )
    );
end;
