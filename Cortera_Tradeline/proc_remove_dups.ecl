EXPORT proc_remove_dups(DATASET($.Layout_Tradeline_base) tradelines = $.Files.Base) := FUNCTION

	b1 := SORT(DISTRIBUTE(tradelines(status=''), hash32(account_key)), account_key, ar_date, -filedate, LOCAL);

	b := ITERATE(b1, TRANSFORM(recordof(b1),
						self.status := IF(left.account_key=right.account_key and left.ar_date=right.ar_date,
										IF(right.filedate<left.filedate,'R',''),'');
						self := right;), local);
	return b + tradelines(status<>'');
END;