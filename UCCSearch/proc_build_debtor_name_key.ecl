
import uccsearch;

bld_debtor_name_all:=buildindex(UCCSearch.key_debtor_name);
export proc_build_debtor_name_key := parallel(bld_debtor_name_all);

