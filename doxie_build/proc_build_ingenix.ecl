import ingenix_natlprof;

do_first := ingenix_natlprof.proc_build_ingenix_base;
do_second := doxie_build.proc_build_ingenix_keys;

get_priority := output('building base..') : success(do_first);

export proc_build_ingenix := sequential(get_priority, do_second);