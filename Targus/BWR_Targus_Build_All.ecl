///////////////////////////////////////////////////////////////////////////////////////////////////////////
/*This dataset is a monthly full file replacement.
The raw data can be found on \\tapeload02b\k\telephone\wp_targus_(ex).
You must ftp the appropriate months data over to edata12:/hds_2/telephones/whitepages/targus
Once complete you may use the unzipit* script to unzip all the files within the proper directories.  

Then concatenate all state files into one .all file for the following:
/ConsumerEnhanced = ConsEnh.all
/ConsumerPlus     = ConsPlus.all

Note: You may automate further by having the script also ftp,concatenate and remove .zip files.  
Then have the script to kick off the thor job.

Once build has completed you will be notified via email.  
Please update the version for TargusKeys on https://securedev.accurint.com/dops/updateroxie.pl?sortfield=2*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////

#workunit('name','Targus White Pages '+ Targus.version)

import Targus,ut, lib_FileServices;

email := FileServices.sendemail('qualityassurance@seisint.com','TARGUS MONTHLY SAMPLE READY','at ' + thorlib.WUID());


sequential(Targus.spray_targusOrig,
			Targus.proc_build_base,
			Targus.proc_build_keys(Targus.version), //F12 here to update version date (version date = filedate)
			
	parallel(Targus.sample_TargusBase,
			  Targus.strata_popFileConsumerBase,
			  Targus.strata_consumerAsHeaderstats
			 ),email
			);



