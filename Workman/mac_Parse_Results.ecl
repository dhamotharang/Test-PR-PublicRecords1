/*
  mac_Parse_Results
    -- will return a module with exported attributes to get each result's value that was passed in the set
    -- 
    -- it will also have an export value for the stop condition passed into this macro
    -- it will return a module with these values exported.
    -- this returned module will require a wuid to be passed into it to get these values out of.

  need to define the module with the pwuid parameter outside this macro
  example:

Get_Results(string pwuid) := WorkMan.mac_Parse_Results(
  ['MatchesPerformed','PreClusterCount PreClusterCount.Proxid_Cnt'] 
  ,'MatchesPerformed < (100000) or (100 - (MatchesPerformed / PreClusterCount * 100.0)) > (99.9)'
  ,['MatchesPerformed_Threshold','Pct_Convergence','Convergence_Threshold']
  ,WorkMan._config.LocalEsp
  // ,pOutputEcl := true
);

Get_Results('W20170501-145638');

would generate this code:

Get_Results(string pwuid) := 
MODULE

  export MatchesPerformed_raw := WorkMan.get_Result(pWuid,'MatchesPerformed',WorkMan    .    _config    .    LocalEsp,50);
  export PreClusterCount_raw := WorkMan.get_Result(pWuid,'PreClusterCount PreClusterCount.Proxid_Cnt',WorkMan    .    _config    .    LocalEsp,50);
  export MatchesPerformed := (real8)MatchesPerformed_raw;
  export PreClusterCount := (real8)PreClusterCount_raw;
  export MatchesPerformed_Threshold := (100000);
  export Pct_Convergence := (100 - (MatchesPerformed / PreClusterCount * 100.0));
  export Convergence_Threshold := (99.9);

  export stopcondition := if(trim(pwuid) not in ['','[undefined]']   and trim(MatchesPerformed_raw) != '' and trim(PreClusterCount_raw) != '',MatchesPerformed < (100000) or (100 - (MatchesPerformed / PreClusterCount * 100.0)) > (99.9) ,false);

  export email_outputs := 
      'MatchesPerformed		: ' + if(regexfind('^[[:digit:]]+$',trim((string)MatchesPerformed_raw)),ut.fIntWithCommas((unsigned8)MatchesPerformed_raw),(string)MatchesPerformed_raw) + '\n'
    + 'PreClusterCount		: ' + if(regexfind('^[[:digit:]]+$',trim((string)PreClusterCount_raw)),ut.fIntWithCommas((unsigned8)PreClusterCount_raw),(string)PreClusterCount_raw) + '\n'
    + 'MatchesPerformed_Threshold	: ' + if(regexfind('^[[:digit:]]+$',trim((string)MatchesPerformed_Threshold)),ut.fIntWithCommas((unsigned8)MatchesPerformed_Threshold),(string)MatchesPerformed_Threshold) + '\n'
    + 'Pct_Convergence		: ' + if(regexfind('^[[:digit:]]+$',trim((string)Pct_Convergence)),ut.fIntWithCommas((unsigned8)Pct_Convergence),(string)Pct_Convergence) + '\n'
    + 'Convergence_Threshold	: ' + if(regexfind('^[[:digit:]]+$',trim((string)Convergence_Threshold)),ut.fIntWithCommas((unsigned8)Convergence_Threshold),(string)Convergence_Threshold) + '\n'
    + 'stopcondition formula		: MatchesPerformed < (100000) or (100 - (MatchesPerformed / PreClusterCount * 100.0)) > (99.9)\n'
    + 'stopcondition			: ' + if(stopcondition = true,'true','false') + '\n'
;
  export output_results := parallel(
     output('Workunit Result Outputs Follow:',named('____________Workunit_Result_Outputs_Follow'),overwrite)
    ,output(MatchesPerformed_raw,named('MatchesPerformed'),overwrite)
    ,output(PreClusterCount_raw,named('PreClusterCount'),overwrite)
    ,output(MatchesPerformed_Threshold,named('MatchesPerformed_Threshold'),overwrite)
    ,output(Pct_Convergence,named('Pct_Convergence'),overwrite)
    ,output(Convergence_Threshold,named('Convergence_Threshold'),overwrite)
    ,output( if(stopcondition = true,'true','false')   ,named('StopCondition'),overwrite)
);
  export ds_results := dataset([
     {'MatchesPerformed',if(regexfind('^[[:digit:]]+$',trim((string)MatchesPerformed_raw)),ut.fIntWithCommas((unsigned8)MatchesPerformed_raw),(string)MatchesPerformed_raw) }
    ,{'PreClusterCount',if(regexfind('^[[:digit:]]+$',trim((string)PreClusterCount_raw)),ut.fIntWithCommas((unsigned8)PreClusterCount_raw),(string)PreClusterCount_raw) }
    ,{'MatchesPerformed_Threshold',if(regexfind('^[[:digit:]]+$',trim((string)MatchesPerformed_Threshold)),ut.fIntWithCommas((unsigned8)MatchesPerformed_Threshold),(string)MatchesPerformed_Threshold) }
    ,{'Pct_Convergence',if(regexfind('^[[:digit:]]+$',trim((string)Pct_Convergence)),ut.fIntWithCommas((unsigned8)Pct_Convergence),(string)Pct_Convergence) }
    ,{'Convergence_Threshold',if(regexfind('^[[:digit:]]+$',trim((string)Convergence_Threshold)),ut.fIntWithCommas((unsigned8)Convergence_Threshold),(string)Convergence_Threshold) }
    ,{ 'stopcondition formula','MatchesPerformed < (100000) or (100 - (MatchesPerformed / PreClusterCount * 100.0)) > (99.9)' }
    ,{ 'stopcondition' , if(stopcondition = true,'true','false') }
  ],WorkMan.Layouts.lay_results);
end;


*/

EXPORT mac_Parse_Results(
   pSetResults          = '[]'        // output these results after each iteration.  These are named results from the workunit kicked off.
  ,pStopCondition       = '\'\''      //  This will pull the MatchesPerformed value from the finished iteration, and if it is less than 1 million
                                      // it will not kick off the next iteration, it will stop there.
  ,pSetNameCalculations = '[]'      
  ,pEsp                 = 'workman._Config.LocalEsp'
  ,pOutputEcl           = 'false'
) :=
functionmacro

  // -- loop through each item in the set
  // -- get the real name, $1 from WorkMan.mac_parsefieldname and that will be the name that is exported
  // -- generate code to define the export and call WorkMan.get_Result for each
  // -- at the end, generate code for the condition, exported as stopcondition.
  // -- return a module with the wuid as a parameter that is passed to each WorkMan.get_Result
  import std;
  
  #uniquename(CNTR                        )
  #uniquename(FILLER_TABS                 )
  #uniquename(CODE_PREPEND                )
  #uniquename(CODE_BODY1                  )
  #uniquename(CODE_BODY2                  )
  #uniquename(CODE_BODY3                  )
  #uniquename(CODE_APPEND                 )
  #uniquename(STOP_CONDITION              )
  #uniquename(CURRENT_RESULT              )
  #uniquename(PARSED_RESULT               )
  #uniquename(OUTPUT_NAME_RAW             )
  #uniquename(OUTPUT_NAME                 )
  #uniquename(OUTPUT_NAME_LEN             )
  #uniquename(OUTPUT_NAME_TABS            )
  #uniquename(OUTPUT_RESULT               )
  #uniquename(DS_RESULTS                  )
  #uniquename(GET_BOOLEANS                )
  #uniquename(OUTPUT_TYPE                 )
  #uniquename(OUTPUT_RESULTS              )
  #uniquename(EMAIL_OUTPUTS               )
  #uniquename(SET_CALCULATIONS            )
  #uniquename(COUNT_SET_CALCULATIONS      )
  #uniquename(COUNT_SET_NAME_CALCULATIONS )
  #uniquename(STOP_CONDITION_POP_OUTPUTS  )
  
  #SET(FILLER_TABS    ,'\t\t\t\t')
  #SET (CODE_PREPEND  ,'MODULE\n\n' )

  #SET(STOP_CONDITION_POP_OUTPUTS ,'')
  #SET(CODE_BODY1     ,''         )
  #SET(CODE_BODY2     ,''         )
  #SET(EMAIL_OUTPUTS  ,'  export email_outputs := \n'         )
  #IF(count(pSetResults) != 0)
    #SET   (OUTPUT_RESULTS ,'  export output_results := parallel(\n'         )
    #APPEND(OUTPUT_RESULTS ,'     output(\'------------------------------------------------------------------------------\',named(\'___________________\'),overwrite)\n'        )
    #APPEND(OUTPUT_RESULTS ,'    ,output(\'-- Workunit Result Outputs Follow:\'                                            ,named(\'____________________\'),overwrite)\n'        )
    #APPEND(OUTPUT_RESULTS ,'    ,output(\'------------------------------------------------------------------------------\',named(\'_____________________\'),overwrite)\n'        )
    #SET   (DS_RESULTS ,'  export ds_results := dataset([\n'         )
  #ELSE
    #SET(OUTPUT_RESULTS ,'  export output_results := parallel(STD.System.Debug.Sleep(1));\n'         )
    #SET   (DS_RESULTS ,'  export ds_results := dataset([],WorkMan.Layouts.lay_results);\n'         )

  #END
  #SET(CNTR         ,1          )

  #IF(trim(pStopCondition) != '')
    #SET    (STOP_CONDITION ,pStopCondition)
    // #SET    (CODE_APPEND    ,'\n  export stopcondition := if(trim(pwuid) not in [\'\',\'[undefined]\']  ,' + %'STOP_CONDITION'% + ' ,false);\n\n')
    #SET    (CODE_APPEND    ,'\n  export stopcondition := if(trim(pwuid) not in [\'\',\'[undefined]\']  ')//,' + %'STOP_CONDITION'% + ' ,false);\n\n')

    #SET(GET_BOOLEANS ,regexreplace('([[:alnum:]_]+)[[:space:]]*(!=|<>|=)[[:space:]]*(true|false)'  ,%'STOP_CONDITION'%   ,'$1,' ,nocase))
    #SET(GET_BOOLEANS ,regexreplace('(true|false)[[:space:]]*(!=|<>|=)[[:space:]]*([[:alnum:]_]+)'  ,%'GET_BOOLEANS'%     ,'$3,' ,nocase))
    #SET(GET_BOOLEANS ,regexreplace('.*?([[:alnum:]_]+,)'                                           ,%'GET_BOOLEANS'%     ,'$1,' ,nocase))
    #SET(GET_BOOLEANS ,',' + %'GET_BOOLEANS'%)
  #ELSE
    #SET    (CODE_APPEND    ,'\n  export stopcondition := false;\n\n')
  #END

  #LOOP
  
    #IF(%CNTR% > count(pSetResults))
      #BREAK
    #END

    #IF(%CNTR% != 1)
      #APPEND(EMAIL_OUTPUTS  ,'    + ')
      #APPEND(OUTPUT_RESULTS ,'    ,' )
      #APPEND(DS_RESULTS     ,'    ,' )
    #ELSE
      #APPEND(EMAIL_OUTPUTS  ,'      ')
      #APPEND(OUTPUT_RESULTS ,'    ,' )
      #APPEND(DS_RESULTS     ,'     ' )
    #END
    
    #SET(CURRENT_RESULT ,pSetResults[%CNTR%])
    #SET(PARSED_RESULT  ,WorkMan.mac_parsefieldname(%'CURRENT_RESULT'%))
 
    #SET(OUTPUT_NAME      ,std.str.extract(%'PARSED_RESULT'%,1) )
    #SET(OUTPUT_NAME_RAW  ,%'OUTPUT_NAME'% + '_raw' )
 
    #IF(trim(pStopCondition) != '')
      #IF(regexfind(',' + trim(%'OUTPUT_NAME'%) + ',',%'GET_BOOLEANS'%,nocase))
        #SET(OUTPUT_TYPE  ,'(boolean)')
      #ELSE
        #SET(OUTPUT_TYPE  ,'(real8)')
      #END
      #IF(regexfind(trim(%'OUTPUT_NAME'%)  ,%'STOP_CONDITION'%,nocase))
        #APPEND(STOP_CONDITION_POP_OUTPUTS  , ' and trim(' + trim(%'OUTPUT_NAME_RAW'%) + ') != \'\'' )
      #END
    #ELSE
      #SET(OUTPUT_TYPE  ,'')
    #END
 
    #APPEND(CODE_BODY1 ,'  export ' + %'OUTPUT_NAME_RAW'% + ' := WorkMan.get_Result(pWuid,\'' + trim(pSetResults[%CNTR%]) + '\',' + #TEXT(pEsp) + ',50);\n')
    #APPEND(CODE_BODY2 ,'  export ' + %'OUTPUT_NAME'%     + ' := ' + %'OUTPUT_TYPE'% + %'OUTPUT_NAME_RAW'% + ';\n')

    #SET(OUTPUT_NAME      ,std.str.extract(%'PARSED_RESULT'%,1) )
    #SET(OUTPUT_NAME_LEN  ,length(trim(%'OUTPUT_NAME'%)))
    #IF(%OUTPUT_NAME_LEN% <= 8)
      #SET(OUTPUT_NAME_TABS ,%'FILLER_TABS'%)
    #ELSIF(%OUTPUT_NAME_LEN% between 9 and 14)
      #SET(OUTPUT_NAME_TABS ,%'FILLER_TABS'%[1..3])
    #ELSIF(%OUTPUT_NAME_LEN% between 15 and 20)
      #SET(OUTPUT_NAME_TABS ,%'FILLER_TABS'%[1..2])
    #ELSE
      #SET(OUTPUT_NAME_TABS ,%'FILLER_TABS'%[1])
    #END
// 8 or less, 4 tabs
// 9 - 14 = 3 tabs
// 15 - 20 = 2 tabs
// 21+ 1 tab
// FILLER_TABS


 // + if(regexfind('^[[:digit:]]+$',trim(MatchesPerformed_raw)),ut.fIntWithCommas((unsigned8)MatchesPerformed_raw),MatchesPerformed_raw) + 
     
    #APPEND(EMAIL_OUTPUTS  ,'\'' + %'OUTPUT_NAME'% + %'OUTPUT_NAME_TABS'% + ': \' + if(regexfind(\'^[[:digit:]]+$\',trim((string)' + %'OUTPUT_NAME_RAW'% + ')),ut.fIntWithCommas((unsigned8)' + %'OUTPUT_NAME_RAW'% + '),(string)' + %'OUTPUT_NAME_RAW'% + ') + \'\\n\'\n') 
    // #APPEND(EMAIL_OUTPUTS  ,'\'' + %'OUTPUT_NAME'% + %'OUTPUT_NAME_TABS'% + ': \' + ' + %'OUTPUT_NAME_RAW'% + ' + \'\\n\'\n') 
    #APPEND(OUTPUT_RESULTS ,'output(' + %'OUTPUT_NAME_RAW'% + ',named(\'' + %'OUTPUT_NAME'% + '\'),overwrite)\n') 

    #APPEND(DS_RESULTS  ,'{\'' + %'OUTPUT_NAME'% + '\',if(regexfind(\'^[[:digit:]]+$\',trim((string)' + %'OUTPUT_NAME_RAW'% + ')),ut.fIntWithCommas((unsigned8)' + %'OUTPUT_NAME_RAW'% + '),(string)' + %'OUTPUT_NAME_RAW'% + ') }\n') 

    #SET(CNTR ,%CNTR% + 1) 
  
  #END
  

  #SET(SET_CALCULATIONS             ,WorkMan.mac_get_calculations(pStopCondition) )
  #SET(CNTR                         ,1                                            )
  #SET(CODE_BODY3                   ,''                                           )
  #SET(OUTPUT_NAME                  ,''                                           )
  #SET(COUNT_SET_CALCULATIONS       ,count(%SET_CALCULATIONS%   )                 )
  #SET(COUNT_SET_NAME_CALCULATIONS  ,count(pSetNameCalculations )                 )

  #LOOP
  
    #IF(%CNTR% > %COUNT_SET_CALCULATIONS%)
      #BREAK
    #END

    #APPEND(EMAIL_OUTPUTS ,'    + ')
    #APPEND(DS_RESULTS    ,'    ,' )

    #IF(%CNTR% <= %COUNT_SET_NAME_CALCULATIONS%)
      #SET(OUTPUT_NAME  ,pSetNameCalculations[%CNTR%]     )
    #ELSE
      #SET(OUTPUT_NAME  ,'Calculation_' + trim(%'CNTR'%)  )
    #END
    
    #APPEND(CODE_BODY3 ,'  export ' + %'OUTPUT_NAME'% + ' := ' + %SET_CALCULATIONS%[%CNTR%] + ';\n')

    #SET(OUTPUT_NAME_LEN  ,length(trim(%'OUTPUT_NAME'%)))
    #IF(%OUTPUT_NAME_LEN% <= 8)
      #SET(OUTPUT_NAME_TABS ,%'FILLER_TABS'%)
    #ELSIF(%OUTPUT_NAME_LEN% between 9 and 14)
      #SET(OUTPUT_NAME_TABS ,%'FILLER_TABS'%[1..3])
    #ELSIF(%OUTPUT_NAME_LEN% between 15 and 20)
      #SET(OUTPUT_NAME_TABS ,%'FILLER_TABS'%[1..2])
    #ELSE
      #SET(OUTPUT_NAME_TABS ,%'FILLER_TABS'%[1])
    #END

    #APPEND(EMAIL_OUTPUTS  ,'\'' + %'OUTPUT_NAME'% + %'OUTPUT_NAME_TABS'% + ': \' + if(regexfind(\'^[[:digit:]]+$\',trim((string)' + %'OUTPUT_NAME'% + ')),ut.fIntWithCommas((unsigned8)' + %'OUTPUT_NAME'% + '),(string)' + %'OUTPUT_NAME'% + ') + \'\\n\'\n') 
    #APPEND(DS_RESULTS     ,'{\'' + %'OUTPUT_NAME'% + '\',if(regexfind(\'^[[:digit:]]+$\',trim((string)' + %'OUTPUT_NAME'% + ')),ut.fIntWithCommas((unsigned8)' + %'OUTPUT_NAME'% + '),(string)' + %'OUTPUT_NAME'% + ') }\n') 
    // #APPEND(EMAIL_OUTPUTS ,'\'' + %'OUTPUT_NAME'% + %'OUTPUT_NAME_TABS'% + ': \' + ' + %'OUTPUT_NAME'% + ' + \'\\n\'\n') 
    #APPEND(OUTPUT_RESULTS ,'    ,output(' + %'OUTPUT_NAME'% + ',named(\'' + %'OUTPUT_NAME'% + '\'),overwrite)\n') 

    #SET(CNTR ,%CNTR% + 1) 

  #END
    
  #IF(trim(pStopCondition) != '')
  
    #APPEND(EMAIL_OUTPUTS ,'    + \'stopcondition formula\t\t: ' + %'STOP_CONDITION'% + '\\n\'\n')
    #APPEND(EMAIL_OUTPUTS ,'    + \'stopcondition\t\t\t: \' + if(stopcondition = true,\'true\',\'false\') + \'\\n\'\n')
    #APPEND(EMAIL_OUTPUTS    ,';\n')

    #APPEND(DS_RESULTS     ,'    ,{ \'stopcondition formula\',\'' + %'STOP_CONDITION'% + '\' }\n') 
    #APPEND(DS_RESULTS     ,'    ,{ \'stopcondition\' , if(stopcondition = true,\'true\',\'false\') }\n')


    #APPEND(OUTPUT_RESULTS ,'    ,output( if(stopcondition = true,\'true\',\'false\')   ,named(\'StopCondition\'),overwrite)\n')
  #ELSIF(count(pSetResults) = 0)
    #APPEND (EMAIL_OUTPUTS    ,'\'\';\n')
  #ELSE
    #APPEND (EMAIL_OUTPUTS    ,';\n')
  #END
  #IF(trim(%'STOP_CONDITION_POP_OUTPUTS'%) != '')
    #APPEND(CODE_APPEND    ,%'STOP_CONDITION_POP_OUTPUTS'% + ',' + %'STOP_CONDITION'% + ' ,false);\n\n')
  #END


  #IF(count(pSetResults) != 0)
    #APPEND(OUTPUT_RESULTS    ,');\n')
    #APPEND(DS_RESULTS  ,  '  ],WorkMan.Layouts.lay_results);\n')
  #END
  
  #SET(OUTPUT_RESULT  ,'return ' + %'CODE_PREPEND'% + %'CODE_BODY1'% + %'CODE_BODY2'% + %'CODE_BODY3'% + %'CODE_APPEND'% + %'EMAIL_OUTPUTS'% + %'OUTPUT_RESULTS'% + %'DS_RESULTS'% + 'end;\n')
  
	#if(pOutputEcl = true)
		return %'OUTPUT_RESULT'%[8..];
	#ELSE
		%OUTPUT_RESULT%		
	#END
  
endmacro;