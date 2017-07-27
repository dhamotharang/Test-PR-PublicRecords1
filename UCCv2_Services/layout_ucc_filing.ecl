import uccv2;

k_main := uccv2.layout_UCC_common.layout_ucc_new;

export layout_ucc_filing := record
  k_main.tmsid;
	k_main.filing_jurisdiction;
	string25 filing_jurisdiction_name;
	k_main.orig_filing_number;
	k_main.orig_filing_type;
	k_main.orig_filing_date;
	dataset(layout_filing_status) filing_status{maxcount(10)};
end;
