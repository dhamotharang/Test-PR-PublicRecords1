//This is the code to execute in a builder window
#workunit('name','HealthCareProviderHeader.BWR_Delta - Finding the Delta of Two Files - SALT V2.9 Gold');
IMPORT HealthCareProviderHeader,SALT29;
d := HealthCareProviderHeader.Delta(old_hdr,new_hdr); // Instantiate delta module
OUTPUT(d.DifferenceSummary,NAMED('Summary'),ALL);
// The below outputs some of the differences; you may wish to send this to a file for investigation
OUTPUT(d.Differences,NAMED('SomeDifferences'));

