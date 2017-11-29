Layout_Property_Value := RECORD
	UNSIGNED2 property_total;
	UNSIGNED5 property_owned_purchase_total;
	UNSIGNED2 property_owned_purchase_count;
	UNSIGNED5 property_owned_assessed_total;
	UNSIGNED2 property_owned_assessed_count;
END;

Layout_Business_Property_Value := RECORD  //MS-158: add new business property fields to this layout (must be integer due to returning special values -1, -2, -3)
	INTEGER	  property_total;
	INTEGER	  property_owned_assessed_total;
	INTEGER	  property_owned_assessed_count;
END;

export Layout_Applicant_Property_Values := RECORD
	Layout_Property_Value owned;
	Layout_Property_Value sold;
	Layout_Property_Value ambiguous;
	Layout_Business_Property_Value bus_owned;
	Layout_Business_Property_Value bus_sold;
END;