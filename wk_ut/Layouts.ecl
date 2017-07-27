EXPORT Layouts :=
module

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
    ,string Subotal_Thor_Time := ''
    ,real8  Subtotal_Time_secs := 0.0
    ,string time_finished       := ''
//    ,string watcherwuid
//    ,string notify_event
  };

	export WuidItems :=
	record
	
		string Item{xpath('Item')};
	
	end;

end;