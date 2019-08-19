// -- BIPV2_DOTID_PLATFORM._ApplyHacks('BIPV2_DOTID_PLATFORM',,true).do_all_hacks;
import SALTTOOLS22,STD,wk_ut,tools;
EXPORT _ApplyHacks(
   string   pModule               = 'BIPV2_DOTID_PLATFORM'
  ,string   pEsp                  = wk_ut._Constants.LocalEsp + ':8145'
  ,boolean  pShouldSaveAttributes = false
) :=
module
  EXPORT fGetAttribute(STRING att                 ):=SALTTOOLS22.mod_Soapcalls.fGetAttributes(pModule,att,pEsp)(COUNT(results)>0)[1].results[1].Text;
  EXPORT fPutAttribute(STRING att,STRING ecl_text ):=OUTPUT(SALTTOOLS22.mod_Soapcalls.fSaveAttribute(pModule,att,ecl_text,pEsp));
  
  // ----------------------------------------------------------------------------
  // -- fHackMatches
  // ----------------------------------------------------------------------------
  export fHackMOD_Attr_ForeignCorpkey(
  
     string   pAttribute            = 'MOD_Attr_ForeignCorpkey' //this can be used for Debug and matches attributes
    ,boolean  pShouldSaveAttribute  = pShouldSaveAttributes
    
  ) :=
  function
    dme := dataset([
    { 
        'EXPORT ForceFilter[(]inhead,infile,id1,id2[)] := FUNCTIONMACRO[[:space:]]*'
      + '// Every attribute value must match to a value in the other attribute IF they have the same context[[:space:]]*'
      + '  Cands0 := BIPV2_DOTID_PLATFORM[.]match_candidates[(]inhead[)][.]ForeignCorpkey_candidates;[[:space:]]*'
      + '// We are going to create a record for each candidate pair; this record will have a child dataset for the attribute values of each side[[:space:]]*'
      + '  ChildRec := RECORD[[:space:]]*'
      + '    Cands0[.]DOTid;[[:space:]]*'
      + '    Cands0[.]Basis_Weight100;[[:space:]]*'
      + '    Cands0[.]Basis;[[:space:]]*'
      + '    SALT32[.]StrType Context := SALT32[.]GetNthWord[(]Cands0[.]Basis,2,\'[|]\'[)]; // Context for the basis [(]\'<\'[)][[:space:]]*'
      + '  END;[[:space:]]*'
      + '  Cands1 := TABLE[(]Cands0,ChildRec[)];[[:space:]]*'
      + '  Cands := DEDUP[(] SORT[(] DISTRIBUTE[(]Cands1,HASH[(]DOTid[)][)], WHOLE RECORD, LOCAL[)], WHOLE RECORD, LOCAL[)];[[:space:]]*'
      + '  // This is an optimized version of the code that takes particular advantage of the FORCE you are using[[:space:]]*'
      + '  Mtch0 := DISTRIBUTE[(]TABLE[(]infile,[{]id1,id2[}][)],HASH[(]id1[)][)];[[:space:]]*'
      + '  Mtch := DEDUP[(] SORT[(] Mtch0, id1, id2, LOCAL [)], id1, id2, LOCAL [)];[[:space:]]*'
      + '  Jnd := JOIN[(]Mtch,Cands,LEFT[.]id1=RIGHT[.]DOTid,LOCAL[)];[[:space:]]*'
      + '  Bads := JOIN[(]DISTRIBUTE[(]Jnd,HASH[(]id2[)][)],Cands,LEFT[.]id2=RIGHT[.]DOTid AND LEFT[.]Context=RIGHT[.]Context AND LEFT[.]Basis<>RIGHT[.]Basis,TRANSFORM[(]LEFT[)],LOCAL[)];[[:space:]]*'
      + '  RETURN JOIN[(]infile,Bads,LEFT[.]id1=RIGHT[.]id1 AND LEFT[.]id2=RIGHT[.]id2,TRANSFORM[(]LEFT[)],LEFT ONLY, SMART[)];[[:space:]]*'
      + 'ENDMACRO;[[:space:]]*'
      ,'/[*] HACK'  
      , 'EXPORT ForceFilter(inhead,infile,id1,id2) := FUNCTIONMACRO\n'
      + '// Every attribute value must match to a value in the other attribute IF they have the same context\n'
      + '  /* HACK - replace Cands0 */\n'
      + '	// Cands0 := BIPV2_DOTID_PLATFORM.match_candidates(inhead).ForeignCorpkey_candidates;\n'
      + '  Cands0 := BIPV2_DOTID_PLATFORM._attr_ck_charters;\n'
      + '// We are going to create a record for each candidate pair; this record will have a child dataset for the attribute values of each side\n'
      + '  /* HACK - add ChildRec1 */\n'
      + '	ChildRec1 := RECORD\n'
      + '    salt32.StrType Basis    := Cands0.company_charter_number;\n'
      + '    salt32.StrType Context  := Cands0.company_inc_state; // Context for the basis (\'<\')\n'
      + '  END;\n'
      + '  ChildRec := RECORD\n'
      + '    Cands0.DOTid;\n'
      + '    /* HACK - comment-out three lines, add childs line */\n'
      + '    // Cands0.Basis_Weight100;\n'
      + '    // Cands0.Basis;\n'
      + '    // salt32.StrType Context := salt32.GetNthWord(Cands0.Basis,2,\'|\'); // Context for the basis (\'<\')\n'
      + '		DATASET(ChildRec1) childs := dataset([{Cands0.company_charter_number,Cands0.company_inc_state}],ChildRec1);\n'
      + '  END;\n'
      + '  Cands := TABLE(Cands0,ChildRec);\n'
      + '	/* HACK - add Cands1/Cands2 */\n'
      + '  Cands1 := rollup(sort(Cands                    ,dotid,local) ,left.dotid = right.dotid,transform(recordof(left),self.childs := left.childs + right.childs,self := left),local);\n'
      + '  Cands2 := rollup(sort(distribute(Cands1,dotid) ,dotid,local) ,left.dotid = right.dotid,transform(recordof(left),self.childs := left.childs + right.childs,self := left),local);\n'
      + '	\n'
      + '  PossRec := RECORD\n'
      + '    infile;\n'
      + '		/* HACK - change to ChildRec1 */\n'
      + '    // DATASET(ChildRec) Kids1 := DATASET([],ChildRec);\n'
      + '    // DATASET(ChildRec) Kids2 := DATASET([],ChildRec);\n'
      + '    DATASET(ChildRec1) Kids1 := DATASET([],ChildRec1);\n'
      + '    DATASET(ChildRec1) Kids2 := DATASET([],ChildRec1);\n'
      + '    unsigned2 countKids1  := 0;\n'
      + '    unsigned2 countKids2  := 0;\n'
      + '    boolean   shouldFilterOut := false;\n'
      + '  END;\n'
      + '  T := TABLE(infile,PossRec); // Allow for addition of children\n'
      + '	/* HACK - replace D1/D2 */\n'
      + '  // D1 := DENORMALIZE(T,Cands,LEFT.id1 = RIGHT.DOTid,GROUP,TRANSFORM(PossRec, SELF.Kids1 := DEDUP(ROWS(RIGHT),Basis,ALL), SELF := LEFT));\n'
      + '  // D2 := DENORMALIZE(D1,Cands,LEFT.id2 = RIGHT.DOTid,GROUP,TRANSFORM(PossRec, SELF.Kids2 := DEDUP(ROWS(RIGHT),Basis,ALL), SELF := LEFT));\n'
      + '  D1 := JOIN(T ,Cands2,LEFT.id1 = RIGHT.DOTid,TRANSFORM(PossRec, SELF.Kids1 := RIGHT.childs,self.countKids1 := count(self.kids1), SELF := LEFT), LEFT OUTER, HASH);\n'
      + '  D2 := JOIN(D1,Cands2,LEFT.id2 = RIGHT.DOTid,TRANSFORM(PossRec, SELF.Kids2 := RIGHT.childs,self.countKids2 := count(RIGHT.childs)\n'
      + '    // ,self.shouldFilterOut := false // default for now\n'
      + '    ,SELF := LEFT), LEFT OUTER, HASH);\n'
      + '\n'
      + '  D2_dist := distribute(D2); //to make sure it does the distribute before the project(optimization sometimes puts it afterwards)\n'
      + '  D2_sort := sort(D2_dist,id1,id2,local); //to make sure it does the distribute before the project(optimization sometimes puts it afterwards)\n'
      + '  \n'
      + '  D3 := project(D2_dist,transform(recordof(left)\n'
      + '    ,self.shouldFilterOut := if(left.countKids1 > 0 and left.countKids2 > 0 \n'
      + '      ,count(table(left.kids1 + left.kids2,{context},context))  <  count(table(left.kids1 + left.kids2,{context,basis},context,basis))  \n'
      + '      ,false\n'
      + '    )\n'
      + '   ,self := left\n'
      + '   ));\n'
      + '\n'
      + '  D3_tofilterout  := D3(shouldFilterOut = true );\n'
      + '  D3_toKeep       := D3(shouldFilterOut = false);\n'
      + '\n'
      + '	/* HACK - change to ChildRec1 */\n'
      + '  // Agree(DATASET(ChildRec) le, DATASET(ChildRec) ri) := FUNCTION\n'
      + '  // Agree(DATASET(ChildRec1) le, DATASET(ChildRec1) ri) := FUNCTION\n'
      + '    // j := JOIN(le,ri,LEFT.Context=RIGHT.Context AND LEFT.Basis<>RIGHT.Basis,TRANSFORM(LEFT));\n'
      + '    // RETURN ~EXISTS(j);\n'
      + '  // END;\n'
      + '  RETURN PROJECT(D3_toKeep,RECORDOF(infile));\n'
      + 'ENDMACRO;\n'
      ,'fix foreign corpkey attribute file' 
    }
    ],tools.layout_attribute_hacks);
    RETURN tools.HackAttribute(pModule,pAttribute,dme,pShouldSaveAttribute).saveit;
  
  end;
  
  export fHackProc_Iterate(
  
     string   pAttribute            = 'Proc_Iterate' 
    ,boolean  pShouldSaveAttribute  = pShouldSaveAttributes
    
  ) :=
  function
  
    dme := dataset([{
          'SHARED ChangeName := \'[~]temp::DOTid::BIPV2_DOTID_PLATFORM::changes_it\'[+]iter;'
      ,''
      ,   'import bipv2;\n'
        + 'SHARED ChangeName := \'~temp::DOTid::BIPV2_DOTID_PLATFORM::changes_it\'+iter+\'_\'+ pversion/*HACK*/;'
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
  export fHackMatches(
  
     string   pAttribute            = 'matches' 
    ,boolean  pShouldSaveAttribute  = pShouldSaveAttributes
    
  ) :=
  function
  
  
  // INTEGER2 lname_score := IF ( le.lname = ri.lname or lname_score_temp > Config.lname_Force * 100, lname_score_temp, SKIP ); // Enforce FORCE parameter
  // INTEGER2 fname_score := IF ( le.fname = ri.fname or fname_score_temp > Config.fname_Force * 100, fname_score_temp, SKIP ); // Enforce FORCE parameter
// AND ( ~left.lname_isnull AND ~right.lname_isnull ) AND ( ~left.fname_isnull AND ~right.fname_isnull )
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
  END;
  export do_all_hacks := 
    sequential(
       fHackMOD_Attr_ForeignCorpkey  ('MOD_Attr_ForeignCorpkey' )
      ,fHackProc_Iterate             ('Proc_Iterate'            )
      ,fHackMatches                  ('matches'                 )
      ,fHackMatches                  ('Debug'                   )
    );
end;
