import uccv2;

k_main := uccv2.layout_UCC_common.layout_ucc_new;

export layout_ucc_signer := record
	k_main.signer_name;
	k_main.title;
end;
