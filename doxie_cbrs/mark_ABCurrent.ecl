import did_add,doxie_cbrs,ut;
doxie_cbrs.mac_Selection_Declare()
export mark_ABCurrent(dataset(doxie_cbrs.layout_best_records_prs) inf,dataset(doxie_cbrs.layout_references) bdids) :=
FUNCTION

rlr := table(doxie_cbrs.reverse_lookup_records(bdids,Include_ReversePhone_val), {phone10, listed_name});


inf tra(inf le, rlr ri) := transform
	self.isCurrent := (integer)ri.phone10 > 0;
	self := le;
end;

wcur := join(inf, rlr,
							(integer)left.phone > 0 and
						  (integer)left.phone = (integer)right.phone10 and
							ut.CompanySimilar100(datalib.companyclean(left.company_name),datalib.companyclean(right.listed_name)) < 40/* and
							DID_Add.Address_Match_Score
								(left.prim_range, left.prim_name, left.sec_range, (string)left.zip, 	
								 right.prim_range, right.prim_name, right.sec_range, (string)right.z5) < 255*/,
							tra(left, right), left outer, keep(1));

return wcur;

END;