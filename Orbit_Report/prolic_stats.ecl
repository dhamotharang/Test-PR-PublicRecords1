export prolic_stats(getretval) := macro
import prof_license,codes,ut,lib_fileservices,_Control;
myds := prof_license.file_prof_license_base(orig_st <> '');

Orbit_Report.Run_Stats('prolic',myds,orig_st,issue_date,'emailme','st',getretval);

endmacro;
