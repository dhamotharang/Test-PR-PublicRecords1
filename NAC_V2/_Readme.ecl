EXPORT _Readme := 'todo';
/*
This jobs are scheduled via chron

NAC_V2.BWR_InputPrepSchedule					// monitor new files
NAC_V2.BWR_SatContributoryBuild				// Saturday key build
NAC_V2.BWR_S_K_ContributoryBuild			// Sunday - Thursday key build

Steps:
	Spray NCF2 input file
	Process file (process_NCF2_File)
	Return NCX2 report (if err threshold exceeded, then abort transaction
	Convert to Base2 format

*/