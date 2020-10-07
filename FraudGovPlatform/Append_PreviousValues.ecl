   IMPORT FraudShared;
EXPORT Append_PreviousValues (
		dataset(FraudShared.Layouts.Base.Main) FileBase
   ,dataset(FraudShared.Layouts.Base.Main) Previous_Build = $.Files().Base.Main_Orig.QA
) := FUNCTION

	building_base := distribute(pull(FileBase), hash32(record_id));
	previous_base := distribute(pull(Previous_Build), hash32(record_id)) ;

	J_previous_values := join (
		building_base,
		previous_base,
		left.record_id = right.record_id,
		transform(FraudShared.Layouts.Base.Main,
			SELF := if(left.record_id=right.record_id, RIGHT, LEFT )
		),
		RIGHT OUTER, LOCAL
	);	

	return (J_previous_values);
END;