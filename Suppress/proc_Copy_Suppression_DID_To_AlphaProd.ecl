EXPORT proc_Copy_Suppression_DID_To_AlphaProd(
   pversion         
  ,pcluster         = '\'hthor_prod_eclcc\''
  ,pEmailList       = 'Aleida.Lima@LexisNexis.com, Alex.Livingston@lexisnexisrisk.com, Kevin.Wilmoth@lexisnexisrisk.com, Ayeesha.Kayttala@lexisnexisrisk.com'     // -- for testing, make sure to put in your email address to receive the emails
  ,pCompileTest     = 'false'
  ,pdoParallel      = 'true'
  ,pLESP            = '\'alpha_prod_thor_esp.risk.regn.net\''  
  // ,pLESP            = '\'alpha_dev_thor_esp.risk.regn.net\''  
  ,pds_debug        = '\'dataset([],WsWorkunits.Layouts.DebugValues)\''
) :=
functionmacro
  import std;
  cluster           := pcluster                         ;
  
  suppresssuper := std.file.superfilecontents('~thor_data400::key::suppression::qa::link_type_did')[1].name ;
  suppressversion := nothor(regexfind('[[:digit:]]{14}[[:alpha:]]?',suppresssuper,0));

 ecl_text :=   '#workunit(\'name\',\'suppress.Copy_Suppression_DID_To_AlphaProd @version@\');\n\n'
              + '#workunit(\'priority\',\'high\');\n'
              + 'suppress.Copy_Suppression_DID_To_AlphaProd(\'' + trim(suppressversion) + '\'  ,false,true,false);'
              ;

  import Workman,tools,suppress;
  kickbuild := Workman.mac_WorkMan(ecl_text ,pversion,cluster,1         ,1       ,pESP := pLESP ,pBuildName := 'Copy_Suppression_DID_To_AlphaProd',pNotifyEmails := pEmailList
      ,pOutputFilename   := '~suppress::' + pversion + '::workunit_history::suppress.Copy_Suppression_DID_To_AlphaProd'
      ,pOutputSuperfile  := '~suppress::qa::workunit_history' 
      ,pCompileOnly      := pCompileTest
      ,pDont_Wait        := pdoParallel
      ,pDebugValues      := pds_debug
  );

  return kickbuild;
endmacro;
