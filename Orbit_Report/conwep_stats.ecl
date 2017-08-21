export conwep_stats(getretval) := macro
import emerges,codes,ut,lib_fileservices,_Control;
myds := emerges.file_ccw_out(CCWRegDate <> '');

Orbit_Report.Run_Stats('conwep',myds,source_state,CCWRegDate,'emailme','st',getretval);

endmacro;