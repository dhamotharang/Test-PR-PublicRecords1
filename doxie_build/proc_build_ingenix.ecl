import ingenix_natlprof, doxie_build;

export proc_build_ingenix(filedate) := macro

do_first := ingenix_natlprof.proc_build_ingenix_base;
do_second := doxie_build.proc_build_ingenix_keys(filedate);
do_third := ingenix_natlprof.Proc_AcceptSK_ToQA;

get_priority := output('building base..') : success(do_first);

sequential(get_priority, do_second, do_third);

endmacro;