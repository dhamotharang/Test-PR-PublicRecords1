import uccv2;

k_main := uccv2.layout_UCC_common.layout_ucc_new;

export layout_ucc_filing_src := record
  k_main.tmsid;
	k_main.filing_jurisdiction;
	string25 filing_jurisdiction_name;
	k_main.orig_filing_number;
	k_main.orig_filing_type;
	k_main.orig_filing_date;
	k_main.orig_filing_time;
	dataset(layout_filing_status) filing_status{maxcount(10)};
	k_main.cmnt_effective_date;
	k_main.description;
end;
