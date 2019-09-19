// -- BIPV2_POWID._ApplyHacks('BIPV2_POWID',,true).do_all_hacks;
/*
BIPV2_POWID._ApplyHacks('BIPV2_POWID',,true).do_all_hacks;
*/
import SALTTOOLS22,STD,wk_ut,tools;
EXPORT _ApplyHacks(
   string   pModule               = 'BIPV2_POWID'
  ,string   pEsp                  = wk_ut._Constants.LocalEsp + ':8145'
  ,boolean  pShouldSaveAttributes = false
) :=
module
  EXPORT fGetAttribute(STRING att                 ):=SALTTOOLS22.mod_Soapcalls.fGetAttributes(pModule,att,pEsp)(COUNT(results)>0)[1].results[1].Text;
  EXPORT fPutAttribute(STRING att,STRING ecl_text ):=OUTPUT(SALTTOOLS22.mod_Soapcalls.fSaveAttribute(pModule,att,ecl_text,pEsp));
  
//BasicMatch 
EXPORT ds_BasicMatch :=   DATASET([
    {  pModule
      ,'BasicMatch'
      ,'h01.*?sort.*?((,(.*?)),Powid)[)].*?Match[[:space:]]*:=[[:space:]]*JOIN[(]h02,'  //regex
      ,'HACKBasicMatch01'  //not regex
      ,   'h01 := table     (h00_match ,{$3,unsigned6 Powid := min(group,Powid)}\n'
        + '                             $2,merge);/*HACKBasicMatch01 TO SPEED UP*/\n'  //replacement
        + 'Match := JOIN(h01,'
      ,'fix dedup skew in basic match'}
    ,{  pModule
      ,'BasicMatch'
      ,'SHARED PickOne := DEDUP[(] SORT[(] DISTRIBUTE[(] Match,HASH[(]Powid1[)] [)], Powid1, Powid2, LOCAL[)], Powid1, LOCAL[)];'  //regex
      ,'HACKBasicMatch02'  //not regex
      ,   'SHARED PickOne := table( Match  ,{Powid1  ,unsigned6 Powid2 := min(group,Powid2)}, Powid1, merge);/*HACKBasicMatch02*/'  //replacement
      ,'speed up pickone'
    }
  ],Tools.layout_attribute_hacks2);
   export  fHackBasicMatch :=  Tools.HackAttribute2(ds_BasicMatch,pShouldSaveAttributes,pESP).saveit;

  // ----------------------------------------------------------------------------
  // -- fHackProc_Iterate
  // ----------------------------------------------------------------------------
  export fHackmatches(
  
     string   pAttribute            = 'matches' 
    ,boolean  pShouldSaveAttribute  = pShouldSaveAttributes
    
  ) :=
  function
  
    dme := dataset([
    {
       ',[[:space:]]*SMART[)]'
      ,''
      ,', HASH/*HACK REMOVE SMART JOINS TO PREVENT MP LINK CLOSED ERROR*/)'
      ,'REMOVE SMART JOINS TO PREVENT MP LINK CLOSED ERROR\n'
    }
  // INTEGER2 company_name_score := IF ( company_name_score_temp > Config.company_name_Force * 100, company_name_score_temp, 0 ); // HACK: FORCE only if both company names fail the force test
     // INTEGER2 company_name_score := IF ( company_name_score_temp > Config.company_name_Force * 100, company_name_score_temp, SKIP ); // Enforce FORCE parameter
  // INTEGER2 cnp_name_score := IF ( cnp_name_score_temp >= Config.cnp_name_Force * 100, cnp_name_score_temp, IF(company_name_score=0,SKIP,0) ); // HACK: FORCE only if both company names fail the force test
     // INTEGER2 cnp_name_score := IF ( cnp_name_score_temp >= Config.cnp_name_Force * 100, cnp_name_score_temp, SKIP ); // Enforce FORCE parameter
  // iComp := (prim_range_score + prim_name_score + MAX(company_name_score,cnp_name_score) + zip_score + cnp_number_score) / 100 + outside; // HACK: Change addition to MAX for the two company name scores
     // iComp := (prim_range_score + prim_name_score + cnp_name_score + company_name_score + cnp_number_score + zip_score) / 100 + outside;
  
    ,{
         'INTEGER2 cnp_name_score := IF [(] cnp_name_score_temp >= Config[.]cnp_name_Force [*] 100, cnp_name_score_temp, SKIP [)]; // Enforce FORCE parameter[[:space:]]*'
       + 'INTEGER2 company_name_score := IF [(] company_name_score_temp > Config[.]company_name_Force [*] 100, company_name_score_temp, SKIP [)];'
      ,  ''
      ,  'INTEGER2 company_name_score := IF ( company_name_score_temp > Config.company_name_Force * 100, company_name_score_temp, 0 ); // HACK: FORCE only if both company names fail the force test\n'
      +  'INTEGER2 cnp_name_score := IF ( cnp_name_score_temp >= Config.cnp_name_Force * 100, cnp_name_score_temp, IF(company_name_score=0,SKIP,0) ); // HACK: FORCE only if both company names fail the force test'
      
      ,'company_name_score FORCE only if both company names fail the force test\n'
    }
    ,{
       'iComp := [(]prim_range_score [+] prim_name_score [+] RID_If_Big_Biz_score [+] cnp_name_score [+] company_name_score [+] cnp_number_score [+] zip_score[)] [/] 100 [+] outside;'
      ,''
      ,'iComp := (prim_range_score + prim_name_score + RID_If_Big_Biz_score + MAX(company_name_score,cnp_name_score) + zip_score + cnp_number_score) / 100 + outside; // HACK: Change addition to MAX for the two company name scores'
      ,'Change addition to MAX for the two company name scores\n'
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
  // EXPORT OutputChanges := OUTPUT(MM.IdChanges,,'~temp::EmpID::BIPV2_POWID::changes_it'+iter+'_'+ bipv2.KeySuffix,OVERWRITE,COMPRESSED);// Changes made
  
    dme := dataset([{
          'SHARED ChangeName := \'[~]temp::POWID::BIPV2_POWID::changes_it\'[+]iter;'
      ,''
      ,   'import bipv2;\n'
        + 'SHARED ChangeName := \'~temp::EmpID::BIPV2_POWID::changes_it\'+iter+\'_\'+ pversion/*HACK*/;'
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
       ,fHackBasicMatch
    );
end;
