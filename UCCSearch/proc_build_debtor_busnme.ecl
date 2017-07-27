
import uccsearch;

bld_debtor_name_all:=buildindex(UCCSearch.key_debtor_busnme);
export proc_build_debtor_busnme := parallel(bld_debtor_name_all);