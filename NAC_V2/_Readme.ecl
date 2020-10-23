EXPORT _Readme := 'todo';
/*
These jobs are scheduled via chron

NAC_V2.BWR_input_nac2_prod 					  // monitor new incoming SNAP NCF2files
NAC_V2.BWR_input_ppa_prod 					  // monitor new incoming PPA NCF2files
NAC_V2.BWR_SatContributoryBuild				// Saturday key build
NAC_V2.BWR_S_K_ContributoryBuild			// Sunday - Thursday key build

Process incoming contributory file: ProcessContributoryFile
	Spray NCF2 input file
  Archive incoming file
	Process file: do error validation, convert to extended format
	Return NCX2 report (if err threshold exceeded, then abort transaction)
  IF onboarding add processed file to sfOnboarding
  ELSE add proecessed file to sfReady

Build NAC2 Base file: fn_Base2_from_Base1
  Convert base1 file to base2 format
  Move sfReady to sfProcessing
  Convert sfProcessing to Base2 format
  Move sfProcessing to sfProcessed
  
*/