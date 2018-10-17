subUnit := record
	string quantity {xpath('quantity')};
	string name {xpath('name')};
end;

layout_place := record
	string link_href {xpath('link/@href')};
  string link_rel {xpath('link/@rel')};
	string placeType {xpath('placeType')};
end;

layout_use := record
	string fid {xpath('./@fid')};
	layout_place place {xpath('place')};
	string status {xpath('status')};
	string primary {xpath('primary')};
	string startDate {xpath('startDate')};
	string startDate_accuracy {xpath('startDate/@accuracy')};
end;

export layout_currency := record
	string deleted {xpath('@deleted')};
	string fid {xpath('@fid')};
	string id {xpath('@id')};
	string resource {xpath('@resource')};
	string source {xpath('@source')};
	string isoCode {xpath('isoCode')};
	string name {xpath('name')};
	string symbol {xpath('symbol')};
	dataset(subUnit) subUnits {xpath('subUnits/subUnit')};
	dataset(layout_use) uses {xpath('uses/use')};
end;
