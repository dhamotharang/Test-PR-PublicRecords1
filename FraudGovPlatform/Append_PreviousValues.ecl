EXPORT Append_PreviousValues (
		dataset(FraudGovPlatform.Layouts.Base.Main) FileBase
   ,dataset(FraudGovPlatform.Layouts.Base.Main) Previous_Build = $.Files().Base.Main_Orig.QA
) := FUNCTION

	building_base := distribute(pull(FileBase), hash32(record_id));
	previous_base := distribute(pull(Previous_Build), hash32(record_id)) ;

	J_previous_values := join (
		previous_base,
		building_base,
		left.record_id = right.record_id,
		transform(FraudGovPlatform.Layouts.Base.Main,
			SELF := if(left.record_id=right.record_id,LEFT, RIGHT )
		),
		RIGHT OUTER, LOCAL
	);	

	return (J_previous_values);
END;