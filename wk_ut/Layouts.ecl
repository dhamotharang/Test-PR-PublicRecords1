import workman;
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
  export lay_results := Workman.layouts.lay_results;
	export wks_slim := Workman.layouts.wks_slim;
	export wks_slim_old :=
	record
		string               name                                                                        {xpath('name')};
		string               wuid                                                                        {xpath('wuid')};
		string               ESP                                                                         {xpath('esp')};    
		string               ENV                                                                         {xpath('env')};    
		string               state                                                                       {xpath('state')};
		string               iteration                                                                   {xpath('iteration')};
		string               version                                                                     {xpath('version')};
		string               total_thor_time                                                             {xpath('total_thor_time')};
		real8                total_time_secs                                                             {xpath('total_time_secs')};
		string               run_total_thor_time                                                         {xpath('run_total_thor_time')} := '';
		real8                run_total_time_secs                                                         {xpath('run_total_time_secs')} := 0.0;
		string               subotal_thor_time                                                           {xpath('subotal_thor_time')}   := '';
		real8                subtotal_time_secs                                                          {xpath('subtotal_time_secs')}  := 0.0;
		string               time_finished                                                               {xpath('time_finished')}       := '' ;
		string               Errors                                                                      {xpath('errors')}              := '' ;
    string               __filename                                                                  { virtual(logicalfilename)};
	end;

	export wks_slim_filename := Workman.layouts.wks_slim_filename;
	export wks_slim_filename_old :=
	record
		string               name                                                                        {xpath('name')};
		string               wuid                                                                        {xpath('wuid')};
		string               ESP                                                                         {xpath('esp')};    
		string               ENV                                                                         {xpath('env')};    
		string               state                                                                       {xpath('state')};
		string               iteration                                                                   {xpath('iteration')};
		string               version                                                                     {xpath('version')};
		string               total_thor_time                                                             {xpath('total_thor_time')};
		real8                total_time_secs                                                             {xpath('total_time_secs')};
		string               run_total_thor_time                                                         {xpath('run_total_thor_time')} := '';
		real8                run_total_time_secs                                                         {xpath('run_total_time_secs')} := 0.0;
		string               subotal_thor_time                                                           {xpath('subotal_thor_time')}   := '';
		real8                subtotal_time_secs                                                          {xpath('subtotal_time_secs')}  := 0.0;
		string               time_finished                                                               {xpath('time_finished')}       := '' ;
		string               Errors                                                                      {xpath('errors')}              := '' ;
    string               __filename                                                                  { virtual(logicalfilename)};
	end;

	export WuidItems :=
	record
	
		string Item{xpath('Item')};
	
	end;

end;
