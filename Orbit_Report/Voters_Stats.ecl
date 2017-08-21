export Voters_Stats(getretval) := macro
import votersv2,codes,ut,lib_fileservices,_Control;
voterds := votersv2.File_Voters_Base(source_state <> '' and regdate <> '');

Orbit_Report.Run_Stats('voters',voterds,source_state,regdate,'emailme','st',getretval);

endmacro;
