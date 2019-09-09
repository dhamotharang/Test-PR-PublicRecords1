//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','HealthcareNoMatchHeader_ExternalLinking.BWR_GoExternal - External Linking Keybuild - SALT V3.11.7');
IMPORT HealthcareNoMatchHeader_ExternalLinking,HealthcareNoMatchHeader_Ingest,SALT311;
pSrc      :=  '16935732';
pVersion  :=  '20190905';
pInfile   :=  HealthcareNoMatchHeader_Ingest.Files(pSrc).AllRecords;
HealthcareNoMatchHeader_ExternalLinking.Proc_GoExternal(pSrc,pVersion,pInfile);
 
//If you want/need to shrink your external keys a little then removing some extra credit fields can help
  Shrinkage := HealthcareNoMatchHeader_ExternalLinking.Key_HEADER_NOMATCH(pSrc,pVersion,pInfile).Shrinkage;
//TOPN(Shrinkage,10000,-ShrinkGB);
