//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','HealthCareFacilityHeader_Best.BWR_Delta - Finding the Delta of Two Files - SALT V3.0 Gold');
IMPORT HealthCareFacilityHeader_Best,SALT30;
d := HealthCareFacilityHeader_Best.Delta(File1,File2); // Instantiate delta module
OUTPUT(d.DifferenceSummary,NAMED('Summary'),ALL);
// The below outputs some of the differences; you may wish to send this to a file for investigation
OUTPUT(d.Differences,NAMED('SomeDifferences'));
