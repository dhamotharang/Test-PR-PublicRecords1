// sub record
Layout_Relatives_Property_Value := RECORD
	UNSIGNED2 relatives_property_count;
	UNSIGNED2 relatives_property_total;
	UNSIGNED5 relatives_property_owned_purchase_total;
	UNSIGNED2 relatives_property_owned_purchase_count;
	UNSIGNED5 relatives_property_owned_assessed_total;
	UNSIGNED2 relatives_property_owned_assessed_count;
END;



export Layout_Relatives_Property_Values := RECORD
	Layout_Relatives_Property_Value owned;
	Layout_Relatives_Property_Value sold;
	Layout_Relatives_Property_Value ambiguous;
END;