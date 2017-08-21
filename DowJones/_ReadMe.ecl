/***************************

Build Steps
(1) Pick up the dow jones daily file 
   Dow Jones files can be found here:
	   \\tapeload02b\k\sanctions_patriot\factiva_(en)
(2) copy it to:
		edata12:/hds_3/DowJones/input
		and unzip it
		
(3) To run the build, execute this ECL:
			#STORED('DJVersion','version');
			DowJones.BuildAll

		Where 'version' is the date in yyyymmdd format.
			e.g. '20130627'
			This must match the date embedded in the DJ file name
			
(4) When the job completes, it will show the input record count and the output record count, which need to match up
The output will consist of nine files which will be found here:
		/hds_3/DowJones/output
		
These are the expected file names:
FACTIVA PFA AFRICA.xml
FACTIVA PFA ASIA.xml
FACTIVA PFA CANADA.xml
FACTIVA PFA EUROPE.xml
FACTIVA PFA MIDDLE EAST.xml
FACTIVA PFA NORTH_AMERICA.xml
FACTIVA PFA SOUTH AMERICA.xml
FACTIVA PFA UNKNOWN.xml
FACTIVA PFA USA.xml


***************************/
EXPORT _ReadMe := 'todo';