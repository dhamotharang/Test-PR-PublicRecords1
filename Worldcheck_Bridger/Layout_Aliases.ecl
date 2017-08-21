EXPORT Layout_Aliases := record
		string Type{xpath('Type')};
		string Category{xpath('Category')};
		unicode First_Name{xpath('First_Name')};
		unicode Middle_Name{xpath('Middle_Name')};
		unicode Last_Name{xpath('Last_Name')};
		unicode Generation{xpath('Generation')};
		unicode Full_Name{xpath('Full_Name')};
		unicode Comments{xpath('Comments')};
	end;