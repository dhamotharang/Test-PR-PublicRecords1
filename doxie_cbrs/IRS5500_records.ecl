import irs5500;

export IRS5500_records(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

k := irs5500.key_irs5500_BDID;

k tra(k r) := transform
	self := r;
end;

j := join(bdids, k, keyed(left.bdid = right.bdid), tra(right),
				  limit(10000, skip));

return sort(j,-form_plan_year_begin_date,record);
END;