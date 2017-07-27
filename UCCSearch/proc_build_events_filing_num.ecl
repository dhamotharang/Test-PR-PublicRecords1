

import uccsearch;

bld_debtor_name_all:=buildindex(UCCSearch.key_events_filing_number);
export proc_build_events_filing_num := parallel(bld_debtor_name_all);