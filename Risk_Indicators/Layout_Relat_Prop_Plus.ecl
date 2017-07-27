export Layout_Relat_Prop_Plus := RECORD
	Layout_Relat_Prop;
	unsigned4 purchase_date_by_did := 0;
	unsigned4 sale_date_by_did := 0;
	Layouts.Layout_Recent_Property_Sales;	
END;