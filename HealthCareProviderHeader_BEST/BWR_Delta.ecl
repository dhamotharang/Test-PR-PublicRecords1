//This is the code to execute in a builder window
#workunit('name','HealthCareProviderHeader_BEST.BWR_Delta - Finding the Delta of Two Files - SALT V2.9 Beta 3');
IMPORT HealthCareProviderHeader_BEST,SALT29;
d := HealthCareProviderHeader_BEST.Delta(File1,File2); // Instantiate delta module
OUTPUT(d.DifferenceSummary,NAMED('Summary'),ALL);
// The below outputs some of the differences; you may wish to send this to a file for investigation
OUTPUT(d.Differences,NAMED('SomeDifferences'));
