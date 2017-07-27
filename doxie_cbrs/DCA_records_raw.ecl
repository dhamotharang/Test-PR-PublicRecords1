import dca;

export DCA_records_raw(dataset(doxie_cbrs.layout_references) bdids = dataset([], doxie_cbrs.layout_references)) 
	:= FUNCTION

k := DCA.Key_DCA_BDID;

k tra(k r) := transform
	self := r;
end;

return join(bdids, k, keyed(left.bdid = right.bdid), tra(right),
				  limit(10000, skip));
END;