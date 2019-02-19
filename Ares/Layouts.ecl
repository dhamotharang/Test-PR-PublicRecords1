EXPORT Layouts := Module
	Shared layout_street_addr := record
		string addressLine1  {xpath('addressLine1')};
		string addressLine2  {xpath('addressLine2')};
		string addressLine3  {xpath('addressLine3')};
		string addressLine4  {xpath('addressLine4')};
	end;
	Export layout_link := Record
		string href{xpath('@href')};
		string rel{xpath('@rel')};
	End;
	Export com_addr_comp := Record
		layout_link link;
		string fid {xpath('fid')};
		string name {xpath('name')};
		string useInAddress {xpath('useInAddress')};
	End;
	Shared layout_city := Record(com_addr_comp)
		string citySortKey {xpath('citySortKey')};
	End;
	Shared layout_area := Record(com_addr_comp)
		string areaSortKey {xpath('areaSortKey')};
	end;
	Shared layout_country := Record(com_addr_comp)
		string iso2 {xpath('iso2')};
		string countrySortKey {xpath('countrySortKey')};
	End;
	Export address := Record
		string fid {xpath('@fid')};
		string type {xpath('type')};
		string function_ {xpath('function')};
		layout_street_addr streetAddress {xpath('streetAddress')};
		layout_city city {xpath('city')};
		layout_area area {xpath('area')};
		layout_area subarea {xpath('subarea')};
		layout_country country {xpath('country')};
		string postalCode {xpath('postalCode')};
		string postalCode_position {xpath('postalCode/@afterArea')};
	End;
		
End;