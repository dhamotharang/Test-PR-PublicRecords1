EXPORT Layouts :=
module

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


  
end;