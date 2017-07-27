import doxie;
export layout_acctno_did := record
     qstring20 acctno;
	doxie.layout_references;
	unsigned1 best_address_number;
end;