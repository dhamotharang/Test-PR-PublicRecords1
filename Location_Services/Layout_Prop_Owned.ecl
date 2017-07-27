import risk_indicators;

export Layout_Prop_Owned := record, maxlength(50000)
	layout_address;
	string11	sales_price;
	string8	purchase_date;
	string8	refinance_date;
	string2	Years_Owned;
	string80	seller1;
	string80	seller2;
	string80	Purchaser1;
	string80	Purchaser2;
	dataset(layout_name_did) current_residents;
	boolean	owner_is_resident;
	string1	foreclosure_flag;
	dataset(layout_phone) phones_children;
	dataset(risk_indicators.Layout_Desc) HRI_address;
end;
