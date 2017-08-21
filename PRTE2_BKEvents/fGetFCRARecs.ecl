import prte2_bankruptcy, fcra;

EXPORT fGetFCRARecs(dataset(recordof(layouts.Base)) BaseFile) := function


get_recs := prte2_bankruptcy.files.Main_Base(fcra.bankrupt_is_ok (constants.todaysdate,date_filed));

recordof(basefile) Get_FCRA__EventRec(recordof(basefile) L, recordof(get_recs) R) 
:= TRANSFORM
SELF := L;
END;


fcra_basefile_evntrec := JOIN(basefile, get_recs,
															LEFT.court_code =  RIGHT.court_code AND
														  LEFT.casekey =  RIGHT.case_number, 					
															Get_FCRA__EventRec(LEFT,RIGHT),LOOKUP);							


return fcra_basefile_evntrec;
end;