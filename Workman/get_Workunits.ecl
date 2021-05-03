import LIB_Date,STD,ut,WsWorkunits;

thecurrentdate  := (STRING8)Std.Date.Today();      
begin_year      := thecurrentdate[1..4] + '0101';

EXPORT get_Workunits(

   string pUser
  ,string pDateBegin  = begin_year
  ,string pDateEnd    = thecurrentdate
  ,string pEsp        = _Config.LocalEsp
  
) :=
function
  lesp := pesp;
  // -- first thing is to find out how many times we will have to call get wuids
  days_apart := LIB_Date.DaysApart(pDateBegin,pDateEnd);

  // -- slice this up on 4 day intervals
  ds_wuid_prep := normalize(dataset([{''}],{string stuff}) ,(days_apart / 4) + 1 ,transform(
    {string startwuid ,string endwuid ,unsigned cnt,unsigned8 current_daysapart ,unsigned8 totaldaysapart ,string overallstartdate  ,string overallenddate  ,string user}
    ,endwuid := if(counter = 1 ,'W' + ut.date_math(pDateBegin,4) + '-000001' ,'W' + ut.date_math(pDateBegin,4 *  counter     ) +  '-000001');
     self.startwuid         := if(counter = 1 ,'W' + pDateBegin                 + '-000001' ,'W' + ut.date_math(pDateBegin,4 * (counter - 1)) +  '-000001');
     self.endwuid           := if(endwuid[2..9] > pDateEnd ,'W' + pDateEnd + '-000001' ,endwuid);
     self.cnt               := counter;
     self.current_daysapart := LIB_Date.DaysApart(pDateBegin  ,self.endwuid[2..9]);
     self.totaldaysapart    := days_apart;
     self.overallstartdate  := pDateBegin;
     self.overallenddate    := pDateEnd;
     self.user              := pUser;
    
  ))(startwuid != endwuid);

  logit(string plog) := STD.System.Log.addWorkunitInformation(plog + ' failed on ' + ut.GetTimeDate());

  outputwuidslice(string pwuidstart,string pwuidend,string pwuidowner)  := output(WorkMan.get_WorkunitList(pwuidstart,pwuidend  ,pwuidowner,pOnline := true,pArchived := true,pUseGlobal := false,pesp := lesp) ,named('Workunits'),extend);// : recovery(logit(pwuidstart + '-' + pwuidend)  ,4);
  
  output_wuids := apply(ds_wuid_prep ,outputwuidslice(startwuid,endwuid,user)); 

  ds_get_all_wuids := Workman.get_DS_Result(workunit ,'Workunits' ,WsWorkunits.Layouts.WsWorkunitRecord);

  ds_prep   := project(ds_get_all_wuids ,transform({string date,string weekday,unsigned cnt_wuids,dataset({string wuid}) wuids} ,self.wuids := dataset([{left.wuid}],{string wuid}),self.date := left.wuid[2..9],self.cnt_wuids := 1,self.weekday := ut.Weekday((unsigned)trim(left.wuid[2..9]))));
  ds_sort   := dedup(sort(ds_prep ,date ,weekday  ,wuids[1].wuid)  ,date  ,weekday  ,wuids[1].wuid);
  ds_rollup := rollup(ds_sort ,left.date = right.date and left.weekday = right.weekday  ,transform(recordof(left) ,self.wuids := left.wuids + right.wuids,self.cnt_wuids := count(self.wuids) ,self := left));

  return sequential(
            parallel(
               output(ds_wuid_prep ,named('ds_wuid_prep'),all)
              ,output_wuids
            )
           ,output(count(ds_sort                ) ,named('Total_wuids_for_this_year'))
           ,output(sort (ds_rollup ,date,weekday) ,named('WuidsByWeekday'           ),all)
  );
  // return when(ds_wuid_prep ,output_wuids);


end;