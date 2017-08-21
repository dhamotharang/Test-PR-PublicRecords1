export huntfish_stats(getretval) := macro
import emerges,codes,ut,lib_fileservices,_Control;

myds1 := eMerges.file_hunters_out(file_acquired_date <> '');

orbit_report.get_huntfish_data('huntfish',myds1,source_state,file_acquired_date,'emailme','st',getretval);

endmacro;
