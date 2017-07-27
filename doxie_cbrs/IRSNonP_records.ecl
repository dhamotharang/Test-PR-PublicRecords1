import govdata;

export IRSNonP_records(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

k := govdata.Key_IRS_NonProfit_BDID;

k tra(k r) := transform
	self := r;
end;

return join(bdids, k, keyed(left.bdid = right.bdid), tra(right),
				  limit(10000, skip));
END;