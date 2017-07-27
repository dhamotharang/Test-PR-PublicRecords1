import risk_indicators;

export Layout_Prev_Property := record, maxlength(500000)
	layout_address;
	string2	Years_Owned;
	string8	Purchase_Date;
	string11	Purchase_Price;
	string8	Refinance_Date;
	string80	Seller1; // note: used to be "orig_seller" -- is the person
	string80	Seller2; // who sold it to the subject
	string8	Sale_Date;
	string11	Sales_Price;
	string80	Purchaser1;
	string80	Purchaser2;
	dataset(Layout_name_did) Current_Residents; // note: residents not actually current
										// this name is for lazy middleware guys =o)
	string11	Net_Profit_from_Sale;
	string5	Pcnt_Gain_or_Loss;
	string1	Foreclosure_Flag;
	dataset(layout_phone) phones_children;
	dataset(risk_indicators.layout_desc) hri_address;
end;
