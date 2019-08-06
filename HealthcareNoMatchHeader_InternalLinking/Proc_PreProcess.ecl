#OPTION('multiplePersistInstances', FALSE);
IMPORT HealthcareNoMatchHeader_InternalLinking, HealthcareNoMatchHeader_Ingest, versioncontrol, STD;
EXPORT Proc_PreProcess( 
    STRING	pSrc            = ''
    , STRING  pVersion      = (STRING)STD.Date.Today()
    , STRING  pIter         = ''
  ) :=  FUNCTION

  dAll_filenames  :=  HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).dAll_filenames+
                      HealthcareNoMatchHeader_Ingest.Filenames(pSrc,pVersion).Linking(pIter).dAll_filenames;
                      
  createsupers    :=  versioncontrol.mUtilities.createsupers(dAll_filenames);

  OutputResults   :=  OUTPUT('Proc_PreProcess Complete, Src='+pSrc+', Version='+pVersion);

  runPreProcess   :=  SEQUENTIAL(
                        createsupers
                        ,OutputResults
                      );

  RETURN  runPreProcess;
END;
