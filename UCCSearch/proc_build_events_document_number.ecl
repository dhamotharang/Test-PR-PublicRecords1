

import uccsearch;

bld_debtor_name_all:=buildindex(UCCSearch.key_events_document_number);
export proc_build_events_document_number := parallel(bld_debtor_name_all);