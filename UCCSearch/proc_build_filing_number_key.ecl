
import uccsearch;

bld_filing_num_all:=buildindex(UCCSearch.key_filing_number);
export proc_build_filing_number_key := parallel(bld_filing_num_all);