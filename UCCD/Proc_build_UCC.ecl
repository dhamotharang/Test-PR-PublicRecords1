
import UCCD;

do_first := UCCD.Proc_AddExp;
build_Roxie:=uccd.Proc_Build_Roxie;
do_second := UCCD.moxie_ucc_pre_key_steps;
do_third  := UCCD.moxie_ucc_post_key_steps;

//get_priority := output('building base..') : success(do_first);

export proc_build_UCC := sequential(do_first,build_Roxie, do_second, do_third);




