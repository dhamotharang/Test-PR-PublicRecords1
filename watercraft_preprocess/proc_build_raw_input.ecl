IMPORT Watercraft, Watercraft_preprocess;

//Runs the preprocess of all raw input files. Output will be used in the Watercraft build process
/*Folderdate is where files are located, ie: '14q2' or '14q3'.  InfolinkQtr is in filename, ie: WI2014_Q3.  'Q3' would be the InfolinkQtr.*/ 
EXPORT proc_build_raw_input(string version, string folderdate, string InfolinkQtr) := function

SprayFiles			:= Watercraft_preprocess.proc_spray_states(version,folderdate,InfolinkQtr);

BuildCommonSrch	:= Watercraft_preprocess.proc_clean_name_rollup;

BuildCommonMain	:= Watercraft_preprocess.proc_main_join_rollup;

BuildCommonCG		:= Watercraft_preprocess.proc_coastguard_join_rollup;

return Sequential(SprayFiles,
									BuildCommonSrch,
									BuildCommonMain,
									BuildCommonCG);
									
end;

