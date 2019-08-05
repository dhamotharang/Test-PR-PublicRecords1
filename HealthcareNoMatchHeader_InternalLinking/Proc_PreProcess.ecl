#OPTION('multiplePersistInstances', FALSE);
IMPORT HealthcareNoMatchHeader_InternalLinking, STD;
EXPORT Proc_PreProcess( 
    STRING	pSrc            = ''
    , STRING  pVersion      = (STRING)STD.Date.Today()
  ) :=  FUNCTION

  OutputResults     :=  OUTPUT('Proc_PreProcess Complete, Src='+pSrc+', Version='+pVersion);

  runPreProcess :=  SEQUENTIAL(
                      OutputResults
                    );

  RETURN  runPreProcess;
END;
