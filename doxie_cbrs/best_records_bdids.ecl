export best_records_bdids(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

outrec := record
	unsigned1 level := 0;
	doxie_cbrs.Layout_BH_Best_String;
end;

temprecs := fn_best_records(project(bdids,
	transform(doxie_cbrs.layout_supergroup,
		self.group_id := 0,
		self := left)),false);

return project(temprecs,outrec);
END;