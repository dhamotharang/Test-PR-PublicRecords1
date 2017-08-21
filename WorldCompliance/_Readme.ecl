/***************************

Build Steps
(1) Pick up the WorldCompliance daily file 
   WorldCompliance files can be found here:
		\\tapeload02b\k\sanctions_patriot\world_compliance_(ei)	 
		The file name is "WorldCompliance_txt_YYYY-MM-DD.zip"
		 
(2) copy it to:
		edata12:/hds_3/WorldCompliance/input/"version"
		and unzip it. "Version" is in the format YYYYMMDD and is taken from the file name.
		
		
(3) Spray the files:
			WorldCompliance.SprayFiles(version);

(4) To run the build, execute this ECL:
			WorldCompliance.BuildAll

The output will consist of seven files which will be found here:
		/hds_3/WorldCompliance/output
		
These are the expected file names:
		WorldCompliance Global Sanctions.xml
		WorldCompliance United States PEP.xml
		WorldCompliance International PEP.xml
		WorldCompliance Global State Owned Entities.xml
		WorldCompliance Global Expanded Due Diligence.xml
		WorldCompliance Global Enforcement.xml
		WorldCompliance Global Adverse Media.xml


***************************/
EXPORT _Readme := 'todo';