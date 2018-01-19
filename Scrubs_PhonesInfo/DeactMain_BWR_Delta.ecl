﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhonesInfo.DeactMain_BWR_Delta - Finding the Delta of Two Files - SALT V3.8.0');
IMPORT Scrubs_PhonesInfo,SALT38;
d := Scrubs_PhonesInfo.DeactMain_Delta(File1,File2); // Instantiate delta module
OUTPUT(d.DifferenceSummary,NAMED('Summary'),ALL);
// The below outputs some of the differences; you may wish to send this to a file for investigation
OUTPUT(d.Differences,NAMED('SomeDifferences'));
