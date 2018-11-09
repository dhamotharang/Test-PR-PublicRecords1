import BankruptcyV2, Doxie, ut, fcra,dops;

export key_bankruptcyV3_fein(boolean isFCRA = false) := function
	todaysdate := ut.GetDate;
	get_recs := BankruptcyV2.file_bankruptcy_search_v3(~IsFCRA OR fcra.bankrupt_is_ok (todaysdate,date_filed));
 FCRATest:=if(isFCRA,get_recs(court_code+case_number not in dops.SuppressID('bankruptcy').GetIDsAsSet(isFCRA)),get_recs);
	temp_rec := record
		FCRATest.tax_id;
		FCRATest.tmsid;
	end;

	temp_rec treformatfein(BankruptcyV2.file_bankruptcy_search_v3 L) := transform
		self.tax_id := if((unsigned6)L.tax_id <> 0,L.tax_id, L.app_tax_id);
		self := L;
	end;

	slim_party := project(FCRATest,treformatfein(left));
	slim_dist   := distribute(slim_party(tax_id <> ''), hash(tmsid, tax_id));
	slim_sort   := sort(slim_dist, tmsid,  tax_id, local);
	slim_dedup  := dedup(slim_sort, tmsid, tax_id, local);

	key_name := BuildKeyName(isFCRA, 'TAXID');

	return index(slim_dedup, {tax_id}, {TMSID}, key_name);
end;