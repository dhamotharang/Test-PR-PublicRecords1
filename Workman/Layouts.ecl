EXPORT Layouts :=
module

/*
  export wks_slim := 
  {
     string Name                  
    ,string Wuid
    ,string state
    ,string Iteration
    ,string Version
    ,string Total_Thor_Time
    ,real8  Total_Time_secs
    ,string Run_Total_Thor_Time := ''
    ,real8  Run_Total_Time_secs := 0.0
    ,string Subotal_Thor_Time   := ''
    ,real8  Subtotal_Time_secs  := 0.0
    ,string time_finished       := '' 
//    ,string watcherwuid
//    ,string notify_event
  };
*/
  export parallel_ecl :=
  record
    string        ecl                      ;
    string        build_name          := '';  // all defaults will take what is passed into WorkMan.mac_WorkMan
    string        output_filename     := '';
    string        output_superfile    := '';
    string        version             := '';
    string        cluster             := '';
    string        start_iteration     := '';
    string        max_iterations      := '';
    string        min_iterations      := '';
    set of string set_results         := [];
    string        stop_condition      := '';
    set of string named_calculations  := [];
    string        esp                 := WorkMan._Config.LocalEsp;
    boolean       forcerun            := false;
    boolean       forceskip           := false;
    boolean       compile_only        := false;
  end;
  
  export parallel_ecl_wuid := 
  record
    string wuid     ;
    string ecl_query;
    parallel_ecl;
    parallel_ecl ds_atts;
    
  end;
  
  export build_attributes := {string build_name,string attribute ,string value};
  
  export lay_results  := 
  record
    string name ;
    string Value;
  end;
  
	export wks_slim :=
	record
		string               name                                                                        {xpath('name'                    )};
		string               Build_name                                                                  {xpath('build_name'              )};
		string               wuid                                                                        {xpath('wuid'                    )};
		string               owner                                                                       {xpath('owner'                   )};
		string               ESP                                                                         {xpath('esp'                     )};    
		string               ENV                                                                         {xpath('env'                     )};    
		string               state                                                                       {xpath('state'                   )};
		string               iteration                                                                   {xpath('iteration'               )};
		string               version                                                                     {xpath('version'                 )};
		string               total_thor_time                                                             {xpath('total_thor_time'         )};
		real8                total_time_secs                                                             {xpath('total_time_secs'         )};
		string               run_total_thor_time                                                         {xpath('run_total_thor_time'     )} :=  '';
		real8                run_total_time_secs                                                         {xpath('run_total_time_secs'     )} := 0.0;
		string               subotal_thor_time                                                           {xpath('subotal_thor_time'       )} :=  '';
		real8                subtotal_time_secs                                                          {xpath('subtotal_time_secs'      )} := 0.0;
		string               time_finished                                                               {xpath('time_finished'           )} :=  '';
		string               start_iteration                                                             {xpath('start_iteration'         )} :=  '';
		string               max_iterations                                                              {xpath('max_iterations'          )} :=  '';
		string               min_iterations                                                              {xpath('min_iterations'          )} :=  '';
		string               stop_condition_formula                                                      {xpath('stop_condition_formula'  )} :=  '';
		boolean              stop_condition                                                              {xpath('stop_condition'          )} :=  false;
    dataset(lay_results) results                                                                     {xpath('results'                 )} := dataset([],lay_results);
		string               advice                                                                      {xpath('advice'                  )} :=  '';
		string               Errors                                                                      {xpath('errors'                  )} :=  '';
	end;

	export wks_slim_filename :=
  record
    wks_slim;
    string               __filename                                                                  { virtual(logicalfilename)};
  end;


	export WuidItems :=
	record
	
		string Item{xpath('Item')};
	
	end;

  export iterations         := {string wuid__html,string jobname,string watcher_wuid__html,string watcher_jobname};
  export childrunner_wuids  := {string wuid__html,string jobname,string childrunner_wuid__html,string childrunner_jobname,string watcher_wuid__html,string watcher_jobname,string parent_event};

  export WsTiming := 
  RECORD
    UNSIGNED4 count                     ;
    UNSIGNED4 duration                  ;
    UNSIGNED4 max                       ;
    STRING    name      {MAXLENGTH(64)} ;
  END;
  
end;