


import uccsearch;

bld_debtor_name_all:=buildindex(UCCSearch.key_events_name);
export proc_build_events_vendor_key := parallel(bld_debtor_name_all);