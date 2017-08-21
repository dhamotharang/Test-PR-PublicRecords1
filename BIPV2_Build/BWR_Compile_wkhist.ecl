
dme := dataset('~bipv2_build::qa::workunit_history',wk_ut.layouts.wks_slim,flat);

dproj := project(dme,transform(wk_ut.layouts.wks_slim
  ,self.run_total_thor_time := ''
  ,self.run_total_time_secs := left.total_time_secs
  ,self.total_thor_time     := wk_ut.ConvertSecs2ReadableTime(left.total_time_secs)
  ,self                     := LEFT
));
diterate := iterate(dproj,transform(wk_ut.layouts.wks_slim
  ,self.run_total_time_secs := left.run_total_time_secs + right.run_total_time_secs
  ,self.run_total_thor_time := wk_ut.ConvertSecs2ReadableTime(self.run_total_time_secs)
  ,self                     := right
));

previousdate := BIPV2.KeySuffix_mod2.PreviousBuildDate;

sequential(
   output(diterate ,,'~bipv2_build::' + previousdate + '::workunit_history')
  ,std.file.clearsuperfile('~bipv2_build::qa::workunit_history',true)
  ,std.file.addsuperfile('~bipv2_build::qa::workunit_history','~bipv2_build::' + previousdate + '::workunit_history')
);

/*
myrec := 
RECORD
  string name{xpath('name')};
  string wuid{xpath('wuid')};
  string state{xpath('state')};
  string iteration{xpath('iteration')};
  string version{xpath('version')};
  string total_thor_time{xpath('total_thor_time')};
  real8 total_time_secs{xpath('total_time_secs')};
  string run_total_thor_time{xpath('run_total_thor_time')};
  real8 run_total_time_secs{xpath('run_total_time_secs')};
  string subotal_thor_time{xpath('subotal_thor_time')};
  real8 subtotal_time_secs{xpath('subtotal_time_secs')};
  string time_finished{xpath('time_finished')};
  string errors{xpath('errors')};
 END;

dme := dataset('~bipv2_build::qa::workunit_history',myrec,flat);

dproj := project(dme,transform(wk_ut.layouts.wks_slim
  ,self.ESP                 := wk_ut._Constants.LocalEsp
  ,self.ENV                 := wk_ut._Constants.LocalENV
  ,self.run_total_thor_time := ''
  ,self.run_total_time_secs := left.total_time_secs
  ,self.total_thor_time     := wk_ut.ConvertSecs2ReadableTime(left.total_time_secs)
  ,self                     := LEFT
));
diterate := iterate(dproj,transform(wk_ut.layouts.wks_slim
  ,self.run_total_time_secs := left.run_total_time_secs + right.run_total_time_secs
  ,self.run_total_thor_time := wk_ut.ConvertSecs2ReadableTime(self.run_total_time_secs)
  ,self                     := right
));

output(dme ,named('dme'),all);
output(dproj ,named('dproj'),all);
output(diterate ,named('diterate'),all);

sequential(
   output(diterate ,,'~bipv2_build::20141113::workunit_history')
  ,std.file.clearsuperfile('~bipv2_build::qa::workunit_history',true)
  ,std.file.addsuperfile('~bipv2_build::qa::workunit_history','~bipv2_build::20141113::workunit_history')
);
/*
/*
	export wks_slim :=
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
	end;
*/