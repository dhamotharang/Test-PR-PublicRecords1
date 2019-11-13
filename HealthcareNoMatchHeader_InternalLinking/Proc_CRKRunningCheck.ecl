IMPORT  STD, HealthcareNoMatchHeader_InternalLinking;
EXPORT  Proc_CRKRunningCheck( 
          STRING	pWuString = '*Healthcare NoMatch Customer Record Key*' 
        ) :=  FUNCTION    
  wuList := NOTHOR(STD.System.Workunit.WorkunitList('',,,,pWuString)(STD.Str.ToUpperCase(wuid) <> STD.Str.ToUpperCase(WORKUNIT)));
  wuListRunning     :=  wuList(STD.Str.ToUpperCase(state) IN HealthcareNoMatchHeader_InternalLinking.proc_Constants.WUStatusInProgress);
  cntRunningIngest  :=  COUNT(wuListRunning);
  RETURN  cntRunningIngest  > 0;
END;