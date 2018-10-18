
type_summary := record
	string type_ {xpath('type')};
	string type_abbreviation {xpath('type/@abbreviation')};
end;

name := record
	string type_ {xpath('type')};
	string value {xpath('value')};
end;

layout_names := record
		string departmentSortKey {xpath('departmentSortKey')};
		dataset(name) names {xpath('name')};
end;

layout_link := record
	string link_href {xpath('link/@href')};
  string link_rel {xpath('link/@rel')};
	string placeType {xpath('placeType')};
end;

layout_link_place := record
	string link_href {xpath('link/@href')};
  string link_rel {xpath('link/@rel')};
	string name {xpath('name')};
end;

layout_summary := record
	string status {xpath('status')};
	dataset(type_summary) types {xpath('types')};
	layout_names names {xpath('names')};
	layout_link institution {xpath('institution')};
	layout_link office {xpath('office')};
	string useInAddress{xpath('useInAddress')};
end;

street_addr_layout := record
	string addressLine1  {xpath('addressLine1')};
	string addressLine2  {xpath('addressLine2')};
	string addressLine3  {xpath('addressLine3')};
	string addressLine4  {xpath('addressLine4')};
end;

layout_address := record
	string link_href  {xpath('link/@href')}; 
	string link_rel   {xpath('link/@rel')};
	string type_       {xpath('type')};
	string addr_function   {xpath('function')};
	street_addr_layout streetAddress {xpath('streetAddress')};
	layout_link_place city           {xpath('city')};
	layout_link_place subarea        {xpath('subarea')};
	layout_link_place area           {xpath('area')};
	layout_link_place country        {xpath('country')};
	string postalCode {xpath('postalCode')};
end;

telecom := record
	string link_href 		 {xpath('link/@href')};
	string link_rel          {xpath('link/@rel')};
	string type_              {xpath('type')};
	string phoneCountryCode  {xpath('phoneCountryCode')};
	string phoneAreaCode     {xpath('phoneAreaCode')};
	string phoneNumber       {xpath('phoneNumber')};
	string value             {xpath('value')};
end;

layout_location := record
	string primary {xpath('./@primary')};
	layout_address address {xpath('address')};
	dataset(telecom) telecom {xpath('telecom')};
end;


export layout_department := record
	string deleted {xpath('@deleted')};
	string fid {xpath('@fid')};
	string id_ {xpath('@id')};
	string resource {xpath('@resource')};
	string source {xpath('@source')};
	string tfpid {xpath('@tfpid')};
	layout_summary summary {xpath('summary')};	
	dataset(layout_location) locations {xpath('locations/location')};	

end;
