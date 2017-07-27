layout_User := record
	string	ReferenceCode {xpath('ReferenceCode')};
	string	BillingCode {xpath('BillingCode')};
	string	QueryId {xpath('QueryId')};
	unsigned1	GLBPurpose {xpath('GLBPurpose')};
	unsigned1	DLPurpose {xpath('DLPurpose')};
end;

layout_options := record
	boolean CheckAllLists {xpath('CheckAllLists')};
	string CheckLists {xpath('CheckLists')};
	boolean Blind {xpath('Blind')};
end;

layout_searchBy := record
	DATASET(Attus.Layout_Query_Items) QueryItems {xpath('QueryItems/QueryItem')};
end;

export Layout_Attus_In := record
	layout_user User {xpath('User')};
	layout_Options Options {xpath('Options')};
	layout_searchBy SearchBy {xpath('SearchBy')};
end;
