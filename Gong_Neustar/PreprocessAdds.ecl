import	ut;
EXPORT PreprocessAdds(dataset(layout_Neustar) adds,string rundate = ut.Now()) := function

	adds1 := PROJECT(adds, TRANSFORM(Layout_Neustar,
										self.unknownField := IntFormat(COUNTER, 10, 0);	// in order to return to original sequence
										self := LEFT;
								));


		AddSort := SORT(adds1, RECORD, EXCEPT add_date,unknownField, TransactionID, latitude, longitude,filename);
		AddsD := ROLLUP(AddSort, TRANSFORM(Gong_Neustar.layout_neustar,
									self.Add_date := earlier(LEFT.add_date,RIGHT.add_date);
									self := LEFT;),
								RECORD, EXCEPT add_date,unknownField, TransactionID, latitude, longitude,filename);
		AddsResort := SORT(AddsD, (integer)unknownField);
		
		return ProcessAdds(AddsResort, rundate);
END;
