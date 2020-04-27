
// WorkMan.mac_Parse_Results(
  // ['PreClusterCount PreClusterCount.Proxid_Cnt','PostClusterCount PostClusterCount.Proxid_Cnt'  ,'MatchesPerformed'] 
  // ,'(PostClusterCount / PreClusterCount * 100.0) > (99.9)'
  // ,['Convergence_PCT','Convergence_Threshold']
  // ,WorkMan._config.LocalEsp
  // ,pOutputEcl := true
// );

Get_Results(string pwuid) := 
MODULE

  export PreClusterCount_raw := WorkMan.get_Result(pWuid,'PreClusterCount PreClusterCount.Proxid_Cnt',WorkMan    .    _config    .    LocalEsp,50);
  export PostClusterCount_raw := WorkMan.get_Result(pWuid,'PostClusterCount PostClusterCount.Proxid_Cnt',WorkMan    .    _config    .    LocalEsp,50);
  export MatchesPerformed_raw := WorkMan.get_Result(pWuid,'MatchesPerformed',WorkMan    .    _config    .    LocalEsp,50);
  export PreClusterCount := (real8)PreClusterCount_raw;
  export PostClusterCount := (real8)PostClusterCount_raw;
  export MatchesPerformed := (real8)MatchesPerformed_raw;
  export Convergence_PCT := (PostClusterCount / PreClusterCount * 100.0);
  export Convergence_Threshold := (99.9);

  export stopcondition := if(trim(pwuid) not in ['','[undefined]']   and trim(PreClusterCount_raw) != '' and trim(PostClusterCount_raw) != '',(PostClusterCount / PreClusterCount * 100.0) > (99.9) ,false);


  export stopcondition_ := if(trim(workman.get_Scalar_Result(workunit,'StopCondition',WorkMan    .    _config    .    LocalEsp)) = 'true' ,true ,false);
   export PreClusterCount_out := workman.get_Scalar_Result(workunit,'PreClusterCount',WorkMan    .    _config    .    LocalEsp);
  export PreClusterCount_ := (real8)PreClusterCount_out;
  export PostClusterCount_out := workman.get_Scalar_Result(workunit,'PostClusterCount',WorkMan    .    _config    .    LocalEsp);
  export PostClusterCount_ := (real8)PostClusterCount_out;
  export MatchesPerformed_out := workman.get_Scalar_Result(workunit,'MatchesPerformed',WorkMan    .    _config    .    LocalEsp);
  export MatchesPerformed_ := (real8)MatchesPerformed_out;
  export Convergence_PCT_ := (typeof(Convergence_PCT))workman.get_Scalar_Result(workunit,'Convergence_PCT',WorkMan    .    _config    .    LocalEsp);
  export Convergence_Threshold_ := (typeof(Convergence_Threshold))workman.get_Scalar_Result(workunit,'Convergence_Threshold',WorkMan    .    _config    .    LocalEsp);
  export email_outputs_out := workman.get_Scalar_Result(workunit,'Email_Outputs',WorkMan   .   _config   .   LocalEsp);
  export ds_results_out    := workman.get_ds_Result    (workunit,'Results_Output',WorkMan.Layouts.lay_results,WorkMan   .   _config   .   LocalEsp);

  export email_outputs := 
      'PreClusterCount		: ' + if(regexfind('^[[:digit:]]+$',trim((string)PreClusterCount_raw)),ut.fIntWithCommas((unsigned8)PreClusterCount_raw),(string)PreClusterCount_raw) + '\n'
    + 'PostClusterCount		: ' + if(regexfind('^[[:digit:]]+$',trim((string)PostClusterCount_raw)),ut.fIntWithCommas((unsigned8)PostClusterCount_raw),(string)PostClusterCount_raw) + '\n'
    + 'MatchesPerformed		: ' + if(regexfind('^[[:digit:]]+$',trim((string)MatchesPerformed_raw)),ut.fIntWithCommas((unsigned8)MatchesPerformed_raw),(string)MatchesPerformed_raw) + '\n'
    + 'Convergence_PCT		: ' + if(regexfind('^[[:digit:]]+$',trim((string)Convergence_PCT)),ut.fIntWithCommas((unsigned8)Convergence_PCT),(string)Convergence_PCT) + '\n'
    + 'Convergence_Threshold	: ' + if(regexfind('^[[:digit:]]+$',trim((string)Convergence_Threshold)),ut.fIntWithCommas((unsigned8)Convergence_Threshold),(string)Convergence_Threshold) + '\n'
    + 'stopcondition formula		: (PostClusterCount / PreClusterCount * 100.0) > (99.9)\n'
    + 'stopcondition			: ' + if(stopcondition = true,'true','false') + '\n'
;
  export ds_results := dataset([
     {'PreClusterCount',if(regexfind('^[[:digit:]]+$',trim((string)PreClusterCount_raw)),ut.fIntWithCommas((unsigned8)PreClusterCount_raw),(string)PreClusterCount_raw) }
    ,{'PostClusterCount',if(regexfind('^[[:digit:]]+$',trim((string)PostClusterCount_raw)),ut.fIntWithCommas((unsigned8)PostClusterCount_raw),(string)PostClusterCount_raw) }
    ,{'MatchesPerformed',if(regexfind('^[[:digit:]]+$',trim((string)MatchesPerformed_raw)),ut.fIntWithCommas((unsigned8)MatchesPerformed_raw),(string)MatchesPerformed_raw) }
    ,{'Convergence_PCT',if(regexfind('^[[:digit:]]+$',trim((string)Convergence_PCT)),ut.fIntWithCommas((unsigned8)Convergence_PCT),(string)Convergence_PCT) }
    ,{'Convergence_Threshold',if(regexfind('^[[:digit:]]+$',trim((string)Convergence_Threshold)),ut.fIntWithCommas((unsigned8)Convergence_Threshold),(string)Convergence_Threshold) }
    ,{ 'stopcondition formula','(PostClusterCount / PreClusterCount * 100.0) > (99.9)' }
    ,{ 'stopcondition' , if(stopcondition = true,'true','false') }
  ],WorkMan.Layouts.lay_results);
  export output_results := parallel(
     output('------------------------------------------------------------------------------',named('___________________'),overwrite)
    ,output('-- Workunit Result Outputs Follow:'                                            ,named('____________________'),overwrite)
    ,output('------------------------------------------------------------------------------',named('_____________________'),overwrite)
    ,output(PreClusterCount_raw,named('PreClusterCount'),overwrite)
    ,output(PostClusterCount_raw,named('PostClusterCount'),overwrite)
    ,output(MatchesPerformed_raw,named('MatchesPerformed'),overwrite)
    ,output(Convergence_PCT,named('Convergence_PCT'),overwrite)
    ,output(Convergence_Threshold,named('Convergence_Threshold'),overwrite)
    ,output( if(stopcondition = true,'true','false')   ,named('StopCondition'),overwrite)
    ,output( ds_results      ,named('Results_Output'),overwrite)
    ,output( email_outputs   ,named('Email_Outputs'),overwrite)
);
end;



/*
  eclsetResults   := [ 'PreClusterCount PreClusterCount.Proxid_Cnt'        
                      ,'PostClusterCount PostClusterCount.Proxid_Cnt'       
                      ,'MatchesPerformed'      
                      ,'BasicMatchesPerformed'
                      ,'SlicesPerformed'
                      ,'ProxidsCreatedByCleave'
                      ,'LinkBlockSplits'
                      ,'recordsrejected0'
                      ,'unlinkablerecords0'
                     ];
  StopCondition   := '(PostClusterCount / PreClusterCount * 100.0) > (99.9)';
  SetNameCalculations := ['Convergence_PCT','Convergence_Threshold'];
*/


// output(Get_Results('')  );


// -- old way: 1 minute, 27 seconds
getresults := Get_Results('W20191004-104040');
sequential(
   getresults.output_results
  ,output(getresults.stopcondition  ,named('test_stop_condition'),overwrite)
  ,output(getresults.stopcondition  ,named('test_stop_condition'),overwrite)
  ,output(getresults.ds_results     ,named('ds_results'))
  ,output(getresults.email_outputs  ,named('email_outputs'))
);

// -- new way:
// getresults := Get_Results('W20191004-104040');
// sequential(
   // getresults.output_results
  // ,output(getresults.stopcondition_  ,named('test_stop_condition'),overwrite)
  // ,output(getresults.stopcondition_  ,named('test_stop_condition'),overwrite)
  // ,output(getresults.ds_results_out     ,named('ds_results'))
  // ,output(getresults.email_outputs_out  ,named('email_outputs'))
// );



// output(Get_Results('W20191004-104040')  );

/*
.output_results
.stopcondition    //have it in output
.stopcondition    //have it in output
Get_Results(child_wuid2).ds_results
.email_outputs
*/