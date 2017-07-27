// -- BIPV2_EmpID._Hacks('BIPV2_EmpID',,true).do_all_hacks;
/*
BIPV2_EmpID._Hacks('BIPV2_EmpID',,true).do_all_hacks;
*/
import SALTTOOLS22,STD,wk_ut,tools;
EXPORT _Hacks(
   string   pModule               = 'BIPV2_EmpID'
  ,string   pEsp                  = wk_ut._Constants.LocalEsp + ':8145'
  ,boolean  pShouldSaveAttributes = false
) :=
module
  EXPORT fGetAttribute(STRING att                 ):=SALTTOOLS22.mod_Soapcalls.fGetAttributes(pModule,att,pEsp)(COUNT(results)>0)[1].results[1].Text;
  EXPORT fPutAttribute(STRING att,STRING ecl_text ):=OUTPUT(SALTTOOLS22.mod_Soapcalls.fSaveAttribute(pModule,att,ecl_text,pEsp));
  
  // ----------------------------------------------------------------------------
  // -- fHackProc_Iterate
  // ----------------------------------------------------------------------------
  export fHackmatches(
  
     string   pAttribute            = 'matches' 
    ,boolean  pShouldSaveAttribute  = pShouldSaveAttributes
    
  ) :=
  function
  
    dme := dataset([{
          ',[[:space:]]*SMART[)]'
      ,''
      ,   ', HASH/*HACK REMOVE SMART JOINS TO PREVENT MP LINK CLOSED ERROR*/)'
      ,'REMOVE SMART JOINS TO PREVENT MP LINK CLOSED ERROR\n'
    }
    ],tools.layout_attribute_hacks);
    RETURN tools.HackAttribute(pModule,pAttribute,dme,pShouldSaveAttribute).saveit;
  END;
  
  
  
  // ----------------------------------------------------------------------------
  // -- fHackProc_Iterate
  // ----------------------------------------------------------------------------
  export fHackProc_Iterate(
  
     string   pAttribute            = 'Proc_Iterate' 
    ,boolean  pShouldSaveAttribute  = pShouldSaveAttributes
    
  ) :=
  function
// - added keysuffix to changes filename.  so it will be unique per build and prevent superfile error too.
  // import bipv2;
  // EXPORT OutputChanges := OUTPUT(MM.IdChanges,,'~temp::EmpID::BIPV2_EmpID::changes_it'+iter+'_'+ bipv2.KeySuffix,OVERWRITE,COMPRESSED);// Changes made
  
    dme := dataset([{
          'SHARED ChangeName := \'[~]temp::EmpID::BIPV2_EmpID::changes_it\'[+]iter;'
      ,''
      ,   'SHARED ChangeName := \'~temp::EmpID::BIPV2_EmpID::changes_it\'+iter+\'_\'+ pversion/*HACK*/;'
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
  export do_all_hacks := 
    sequential(
        fHackProc_Iterate     ('Proc_Iterate'   )
       ,fHackmatches          ('matches'        )
    );
end;
