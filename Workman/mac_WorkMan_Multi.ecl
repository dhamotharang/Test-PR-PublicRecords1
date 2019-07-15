import tools,ut,_control,WorkMan;
/*
  Wait4Workunits() -- waits for all of the workunits in the dataset passed to complete/abort/fail before returning. 
                      they can be from different environments, i.e. different esps
*/
EXPORT mac_WorkMan_Multi(

   pSetWuids                                                  //                                       
  ,pDs_Prep                                                   //dataset with info for each parallel wuid
  ,piteration
  ,pversion
  ,pBuildName         = '\'\''
  ,pOutputSuperfile   = '\'\''                                      // superfile to add the above file to. 
  ,pESP               = 'WorkMan._Config.LocalEsp'
  ,pNotifyEmails      = 'WorkMan._Config.EmailAddressNotify'
  ,pFailureEmails     = 'WorkMan._Config.EmailAddressNotify'          // email addresses to which to send any failures 
  ,pShouldEmail       = 'true'
  ,pPollingFrequency  = '\'5\''
	,pOutputEcl					= 'false'					                      // Should output the ecl as a string(for testing) or actually run the ecl

) := 
functionmacro

  #uniquename(WORKMAN_MAC_WORKMAN_EVENT)

  watchercluster  := WorkMan._Config.Esp2Hthor(pESP);
  localesp        := WorkMan._Config.LocalEsp;
  
  set_build_names   := set(pDs_Prep(build_name != '') ,trim(build_name ));
  set_versions      := set(pDs_Prep(version    != '') ,trim(version    ));

  // wuidsstring     := project(dataset([{''}],{string junk}),transform({string wuid},self.wuid := if(pSetWuids[counter] = '','','\'' + pSetWuids[counter] + '\'')))(wuid != '');
  // wuidsstring     := normalize(dataset([{''}],{string junk}),count(pSetWuids),transform({string wuid},self.wuid := if(pSetWuids[counter] = '','','\'' + pSetWuids[counter] + '\'')))(wuid != '');
  // wuidsstring2    := '[' + rollup(wuidsstring,true,transform({string wuid},self.wuid := left.wuid + ',' + right.wuid))[1].wuid + ']';

  // -----------------
  ds_prep_slim := project(pDs_Prep  ,{string wuid,string esp});
  layouttools := tools.macf_LayoutTools(recordof(ds_prep_slim),false);
  ds_rollup_prep := project(ds_prep_slim  ,transform({unsigned rid,string eclcode  ,recordof(pDs_Prep)}
    ,self     := left
    ,self.rid := counter
    ,self     := []
   ));
   
  ds_rollup_string := rollup(ds_rollup_prep ,true ,transform(recordof(left)
    ,self.eclcode := if(left.rid = 1  ,  'dataset([\n'
                                        +'\t {\'' + left.wuid  + '\'  ,\'' + left.esp  + '\'}\n'
                                        +'\t,{\'' + right.wuid + '\'  ,\'' + right.esp + '\'}\n'
                                      , left.eclcode 
                                        +'\t,{\'' + right.wuid + '\'  ,\'' + right.esp + '\'}\n'
    )
    ,self := right
  ));

  string_ds_wuids := ds_rollup_string[1].eclcode + '], ' +  layouttools.string_layout_record + ');\n';
  // -----------------

  notifymultiecl  := 
      '#workunit(\'name\',\'--WorkMan.mac_NotifyMulti-- ' + pBuildName + ', ' + pversion + ', ' + piteration + '\');\n'
    + 'ds_wuids := ' + string_ds_wuids
    + 'WorkMan.mac_NotifyMulti(ds_wuids,\'' + %'WORKMAN_MAC_WORKMAN_EVENT'% + '\',\'' + pNotifyEmails + '\',\'' + pPollingFrequency + '\',\'' + localesp + '\');';
  
  // -- should always be kicked off locally.  then, WorkMan.mac_NotifyMulti can monitor each wuid that it is responsible for from any esp all at once.
  createwatcherworkunit1 := WorkMan.CreateWuid(
     notifymultiecl
    ,watchercluster
    ,localesp//pESP--hack
  ); 

  watcher_wuid_result := trim(WorkMan.get_Scalar_Result(workunit,'Current_Parallel_Watcher_Wuid'));
  createwatcherworkunit1_html := '<a href="http://' + pESP + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + watcher_wuid_result   + '#/stub/Summary">Watcher Workunit</a>';
  
  
  wait4it1 := wait(event(%'WORKMAN_MAC_WORKMAN_EVENT'%,'*'));

  // -- get all wuids and dedup to get the last per 
  ds_wuids := WorkMan.get_DS_Result(workunit        ,'Workunits',WorkMan.layouts.wks_slim);
  ds_wuids2 := if(trim(WorkMan.get_Scalar_Result(workunit,'Workunits')) not in ['','[undefined]']
                ,ds_wuids
                ,dataset([],WorkMan.layouts.wks_slim)
               );
               
  // -- get the current running wuids and add html results
  current_childrunner_wuids_norm       := project(ds_prep_slim ,transform({dataset(WorkMan.layouts.wks_slim) ds_child_wuids}
    ,self.ds_child_wuids := if(trim(WorkMan.get_Scalar_Result(left.wuid,'Workunits',left.esp)) not in ['','[undefined]'] 
                              ,WorkMan.get_DS_Result(left.wuid ,'Workunits',WorkMan.layouts.wks_slim,left.esp)
                              ,dataset([],WorkMan.layouts.wks_slim)
                            )
  ));
  current_childrunner_wuids := normalize(current_childrunner_wuids_norm ,left.ds_child_wuids ,transform(WorkMan.layouts.wks_slim
    ,self := right
  ));
  
  // -- get all workunits run by workman, either from the superfile, or from the workunits dataset result
  #IF(trim(pOutputSuperfile) != '')            
    ds_all_wuids := dataset(pOutputSuperfile,WorkMan.layouts.wks_slim,thor,opt);
  #ELSE
    ds_all_wuids := dataset([],WorkMan.layouts.wks_slim);
  #END

  ds_all_wuids_version := ds_all_wuids(version = pversion);
  ds_wuids_all      := dedup(sort(ds_wuids2(version = pversion) + current_childrunner_wuids + ds_all_wuids_version,wuid,-time_finished),wuid);

  // -- get how many times this macro has been called for this wuid
  get_times_called      := workman.get_Scalar_Result(workunit  ,'Times_Called');
  times_called          := (unsigned)get_times_called + 1;

  // -- if buildname is passed in, use it in the event name to make it more unique
  #UNIQUENAME(WORKMAN_MAC_WORKMAN_EVENT_NAME   )
  #SET(WORKMAN_MAC_WORKMAN_EVENT_NAME  ,'__#__' + trim(pBuildName,all) + '_' + trim(pversion) + '_' + '__$__')
  // #SET(WORKMAN_MAC_WORKMAN_EVENT_NAME  ,'__#__' + trim(pBuildName,all) + '_' + trim(pversion) + '_' + trim(regexreplace('[-]',pSetWuids[1],'_',nocase)) + '_' + count(pSetWuids) + '__$__')
  #UNIQUENAME(WORKMAN_MAC_WORKMAN_EVENT   ,%'WORKMAN_MAC_WORKMAN_EVENT_NAME'%)


  // #UNIQUENAME(CNTR)
  // #UNIQUENAME(SET_WUIDS_HTML)
  // #SET(CNTR,1)
  // #SET(SET_WUIDS_HTML ,'[')
  // #LOOP
    // #IF(%CNTR% > COUNT(pSetWuids))
      // #BREAK
    // #END
    
    // #IF(%CNTR% != 1)
      // #APPEND(SET_WUIDS_HTML  ,',')
    // #END

    // #APPEND(SET_WUIDS_HTML  ,'\'<a href="http://' + pESP + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + trim(pSetWuids[%CNTR%]) + '#/stub/Summary">' + trim(pSetWuids[%CNTR%]) + '</a>\'')

    // #SET(CNTR ,%CNTR% + 1)
    
  // #END
  // #append(SET_WUIDS_HTML ,']')

  // ds_set_wuids_html := normalize(dataset([{''}],{string stuff})  ,count(pSetWuids) ,transform({string wuid_html}
                    // ,self.wuid_html := '\'<a href="http://' + pESP + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + trim(pSetWuids[counter]) + '#/stub/Summary">' + trim(pSetWuids[counter]) + '</a>\''
                  // ));
  ds_set_wuids_html := project(pDs_Prep ,transform({string wuid_html}
                    ,self.wuid_html := '\'<a href="http://' + trim(left.esp) + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + trim(left.wuid) + '#/stub/Summary">' + trim(left.wuid) + '</a>\''
                  ));
  set_wuids_html := set(ds_set_wuids_html ,wuid_html);

  // -- get the current running wuids and add html results  FIGURE THIS OUT NEXT!!!!
// ds_prep_slim
  // Current_Running_Wuids       := normalize(dataset([{''}],{string stuff}) ,count(pSetWuids) ,transform({string wuid,dataset(Workman.Layouts.childrunner_wuids) iter_wuids}
  Current_Running_Wuids       := project(ds_prep_slim ,transform({string wuid,string esp,dataset(Workman.Layouts.childrunner_wuids) iter_wuids}
    ,self.iter_wuids  := WorkMan.get_DS_Result(left.wuid ,'Current_Running_Wuids__html',Workman.Layouts.childrunner_wuids,left.esp)
    ,self.wuid        := left.wuid
    ,self.esp         := left.esp
  ));
  // Current_Running_Wuids       := WorkMan.get_DS_Result    (current_childrunner ,'Iteration_Wuids__html',Workman.Layouts.iterations,pESP,,pDont_Wait);
  Current_Running_Wuids_proj  := normalize(Current_Running_Wuids  ,left.iter_wuids,transform(Workman.Layouts.childrunner_wuids  
    // ,self.childrunner_wuid__html  := '<a href="http://' + pESP + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + left.wuid + '#/stub/Summary">' + left.wuid + '</a>'
    // ,self.childrunner_jobname     := WorkMan.get_Jobname(left.wuid,pESP)
    // ,self.parent_event            := %'WORKMAN_MAC_WORKMAN_EVENT'%
    ,self                         := left
    ,self                         := right
  ));

  // WorkMan.get_DS_Result(pSetWuids[counter] ,'Current_Running_Wuids__html',Workman.Layouts.childrunner_wuids,pESP);
 
  
  
  // -- compile the current build attributes vs the previous builds
  ds_build_attributes_prep := project(pDs_Prep  ,transform(
     {string outputfilename,dataset(WorkMan.layouts.wks_slim) outputfilename_dataset ,unsigned count_outputfile,Workman.layouts.build_attributes,recordof(pDs_Prep) - build_name}
    ,self.OutputFilename                  := regexreplace('@version@' ,left.output_filename  ,pversion);
    ,self.outputfilename_dataset          := dataset(self.OutputFilename      ,WorkMan.layouts.wks_slim  ,thor ,opt);
    ,self.count_outputfile                := count(self.outputfilename_dataset);
    ,self.build_name                      := left.build_name;
    ,self.attribute                       := ''
    ,self.value                           := ''
    ,self                                 := left
  ));
  
  build_attributes := normalize(ds_build_attributes_prep ,9 ,transform(Workman.layouts.build_attributes
    , prev_ds := left.outputfilename_dataset[left.count_outputfile];
      self.build_name                      := left.build_name;
      self.attribute                       := choose(counter ,'count_outputfile'            ,'pStartIteration'    ,'MAX_ITERATIONS'     ,'MIN_ITERATIONS'     ,'pStopCondition'     ,'previous_start_iteration' ,'previous_max_iterations','previous_min_iterations','previous_stop_condition_formula','');
      self.value                           := choose(counter ,(string)left.count_outputfile ,left.start_iteration ,left.max_iterations  ,left.min_iterations  ,left.stop_condition  ,prev_ds.start_iteration    ,prev_ds.max_iterations   ,prev_ds.min_iterations   ,prev_ds.stop_condition_formula   ,'');
  ));
  
  build_names := set(pDs_Prep ,trim(build_name));

  get_build_attributes     := WorkMan.get_DS_Result    (workunit ,'Current_Build_attributes',Workman.layouts.build_attributes);
  compile_build_attributes := get_build_attributes + build_attributes;
  
  // -- Check for failures in this build.
  WorkMan_mac_Work_states       := project(ds_prep_slim ,transform({string wuid,string esp,string state}
    ,self.state  := WorkMan.get_State(left.wuid  ,left.esp)
    ,self.wuid   := left.wuid
    ,self.esp    := left.esp
  ));

  ds_FailedOrAborted  := ds_wuids_all(version = pversion,trim(state) in ['failed','aborted','unknown'], not regexfind('(skip|move on)',advice,nocase) );
  ds_failedmac_work   := WorkMan_mac_Work_states(trim(state) in ['failed','aborted','unknown']);
  anyFailedOrAborted  := exists(ds_FailedOrAborted) or exists(ds_failedmac_work);
  check_for_failures  := iff(anyFailedOrAborted ,fail('Fail workunit because at least one wuid ' + ds_FailedOrAborted[1].wuid + ' has ' + ds_FailedOrAborted[1].state + '.'));

  // -- compile skipped builds
  get_skipped_builds       := project(ds_prep_slim ,transform({string wuid,string esp,dataset(WorkMan.layouts.wks_slim) iter_wuids}
    ,self.iter_wuids  := WorkMan.get_DS_Result(left.wuid ,'Total_Skipped_Builds',WorkMan.layouts.wks_slim,left.esp)
    ,self.wuid        := left.wuid
    ,self.esp    := left.esp
  ));
  get_skipped_builds_norm  := normalize(get_skipped_builds  ,left.iter_wuids,transform(WorkMan.layouts.wks_slim  
    // ,self.childrunner_wuid__html  := '<a href="http://' + pESP + ':8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + left.wuid + '#/stub/Summary">' + left.wuid + '</a>'
    // ,self.childrunner_jobname     := WorkMan.get_Jobname(left.wuid,pESP)
    // ,self.parent_event            := %'WORKMAN_MAC_WORKMAN_EVENT'%
    // ,self                         := left
    ,self                         := right
  ));
  ds_existing_skipped_builds := WorkMan.get_DS_Result(workunit ,'Total_Skipped_Builds',WorkMan.layouts.wks_slim);
  ds_concat_skipped_builds := ds_existing_skipped_builds + get_skipped_builds_norm;
  set_blank_versions := [''];


  // -- Create Watcher for Wuids in set.  Can't do it in this wuid because the set has to be a constant
  return_result := sequential(
     output('---------------------Workman_Outputs_Follow-----------------'  ,named('Workman_Outputs_Follow'       ),overwrite     )
    ,output(WorkMan.getTimeDate()                                           ,named('DateTime'                     ),overwrite     )
    ,output(ds_wuids2                                                       ,named('Workunits'                    ),overwrite,ALL )
    ,output(times_called                                                    ,named('Times_Called'                 ),overwrite     )
    ,output(%'WORKMAN_MAC_WORKMAN_EVENT'%                                   ,named('Current_Parent_Event'         ),overwrite     )

    ,output(set_blank_versions                                              ,named('Current_Version'              ),overwrite     )
    ,output(set_blank_versions                                              ,named('Current_Running_Build'        ),overwrite     )

    ,output(set_versions                                                    ,named('Current_Version'              ),overwrite     )

    ,output(set_build_names                                                 ,named('Current_Running_Build'        ),overwrite     )  //multiple
    ,output(build_attributes                                                ,named('Current_Build_attributes'     ),overwrite     )
    ,output(pSetWuids                                                       ,named('Current_Running_Wuid'         ),overwrite     )
    ,output(set_wuids_html                                                  ,named('Current_Running_Wuid__html'   ),overwrite     )

    ,output(createwatcherworkunit1                                           ,named('Current_Parallel_Watcher_Wuid'         ),overwrite     )
    ,output(createwatcherworkunit1_html                                      ,named('Current_Parallel_Watcher_Wuid__html'   ),overwrite     )
		// ,email_skipped_builds
		,output(dataset([],WorkMan.layouts.wks_slim)                   					,named('Consecutive_Skipped_Builds'   ),overwrite   ,all )


    ,output(WorkMan.do_WUWaitComplete(watcher_wuid_result,,,pESP) ,named('Waiting'                      ),overwrite     )
      // ,wait(%'WORKMAN_MAC_WORKMAN_EVENT'%)  // in 6.4.4  works but the other things after the wait do not get run. HPCC-11172 -- assert error after master workunit notified when used in if-then.
    ,output(WorkMan.getTimeDate()                                           ,named('DateTime_Finished'            ),overwrite     )
    ,output(Current_Running_Wuids_proj                                      ,named('Current_Running_Wuids__html'  ),extend   ,all ) 
    ,output(ds_concat_skipped_builds(trim(wuid) != '')                      ,named('Total_Skipped_Builds'         ),overwrite   ,all )
    ,output(ds_wuids_all                                                    ,named('Workunits'                    ),overwrite,ALL )
    // ,copy_remote_workman_file  //not needed since the mac_workman calls will do this 
    ,check_for_failures
    ,output('---------------------Workman_Outputs_End-----------------'     ,named('Workman_Outputs_End'       ),overwrite     )
  );
    
  // thiswuid            := if(WorkMan.get_Scalar_Result(workunit       ,'Workunits') != '',WorkMan.get_DS_Result(workunit        ,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  // Run_Total_Time_secs := sum(thiswuid(not regexfind('^.*?total$',trim(name),nocase)),Total_Time_secs);
  // Run_Total_Thor_Time := WorkMan.ConvertSecs2ReadableTime((real8)Run_Total_Time_secs);

  // getthiswuids            := WorkMan.get_DS_Result(workunit,'Workunits',WorkMan.layouts.wks_slim); 

  // iterwuids  := iterate(project(getthiswuids + getwuids,transform(recordof(left),self.Run_Total_Time_secs := left.Total_Time_secs,self := left)),transform(recordof(left)
    // ,self.Run_Total_Time_secs := if(counter = 1,Run_Total_Time_secs,left.Run_Total_Time_secs) + right.Run_Total_Time_secs
    // ,self.Run_Total_Thor_Time := WorkMan.ConvertSecs2ReadableTime((real8)self.Run_Total_Time_secs),self := right));
  
  // outputresults       := output(iterwuids,named('Workunits'),overwrite);

  return if(pOutputEcl = false  ,return_result
                                ,sequential(output(notifymultiecl,named('NotifyMultiEcl')))
  );

endmacro;
