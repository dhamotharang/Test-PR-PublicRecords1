import uccv2;

k_main := uccv2.layout_UCC_common.layout_ucc_new;

export layout_ucc_filofc := record
	k_main.filing_agency;
	k_main.address;
	k_main.city;
	k_main.state;
	k_main.county;
	k_main.zip;
end;
