Layout_Property_Value := RECORD
	// UNSIGNED1 property_count;
	UNSIGNED2 property_total;
	UNSIGNED5 property_owned_purchase_total;
	UNSIGNED2 property_owned_purchase_count;
	UNSIGNED5 property_owned_assessed_total;
	UNSIGNED2 property_owned_assessed_count;
END;

export Layout_Applicant_Property_Values := RECORD
	Layout_Property_Value owned;
	Layout_Property_Value sold;
	Layout_Property_Value ambiguous;
END;