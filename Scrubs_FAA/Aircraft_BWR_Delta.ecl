﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FAA.Aircraft_BWR_Delta - Finding the Delta of Two Files - SALT V3.8.2');
IMPORT Scrubs_FAA,SALT38;
d := Scrubs_FAA.Aircraft_Delta(File1,File2); // Instantiate delta module
OUTPUT(d.DifferenceSummary,NAMED('Summary'),ALL);
// The below outputs some of the differences; you may wish to send this to a file for investigation
OUTPUT(d.Differences,NAMED('SomeDifferences'));
