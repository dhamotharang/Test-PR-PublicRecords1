import std;
office_in := files.ds_office(summary.status='active');
layout_raw := layout_office;
layout_expanded := record(layout_raw)
	string institution_id;
	string office_type_code;
	string institution_fullname;
	string branch_name;
	string primary_city_id;
	string primary_physical_city_id;
	string primary_city_country_id := '';
	string primary_country_id := '';
	string primary_physical_country_id := '';
	string primary_physical_city_country_id := '';	
	string physical_address1 := '';
	string physical_address2 := '';
	string city_name := '';
	string st_prov_rgn_abbv := '';
	string st_prov_rgn := '';
	string postal_code := '';
	string country_name := '';
	string employer_tax_id := '';
	string physical_area_id := '';
	string country_iso2 := '';
end;

layout_expanded expand_office(office_in l) := Transform
	self.institution_id := std.str.splitwords(l.summary.institution.href,'/')[3];
	self.office_type_code := l.summary.types[1].type;
	self.institution_fullname := if(l.summary.names.officeTitleOverride != '', 
																	l.summary.names.officeTitleOverride, 
																	l.summary.names.officeTitlePrefix + l.summary.names.names(type='Legal Title')[1].value + l.summary.names.officeTitleSuffix);
	self.branch_name := l.summary.names.names(type='Office Name')[1].value;			
	self.primary_city_id 					:= std.str.splitwords(l.locations(primary='true')[1].address[1].city.link.href,'/')[3];
	self.primary_physical_city_id := std.str.splitwords(l.locations(primary='true')[1].address(type='physical')[1].city.link.href,'/')[3];
	self.physical_address1 := l.locations(primary='true')[1].address(type='physical')[1].streetAddress.addressLine1;
	self.physical_address2 := l.locations(primary='true')[1].address(type='physical')[1].streetAddress.addressLine2;
	self.physical_area_id := std.str.splitwords(l.locations(primary='true')[1].address(type='physical')[1].area.link.href,'/')[3];
	self.postal_code := l.locations(primary='true')[1].address(type='physical')[1].postalCode;
	self.primary_country_id	:= std.str.splitwords(l.locations(primary='true')[1].address[1].country.link.href,'/')[3];
	self.primary_physical_country_id	:= std.str.splitwords(l.locations(primary='true')[1].address(type='physical')[1].country.link.href,'/')[3];
	self.employer_tax_id := l.summary.identifiers(type = 'US Tax ID')[1].value;
	// self.st_prov_rgn_abbv := 
	// self.primary_city_country_id 	:= std.str.splitwords(files.ds_city(id = self.primary_city_id)[1].within.place(regexfind( '/country/id', link_href))[1].link_href,'/')[3];
	self := l;
End;
pre_join := distribute(Project(office_in, expand_office(left)), hash(primary_city_id));
city := distribute(files.ds_city, hash(id));

layout_expanded xform_countryid(pre_join l, city r) := Transform
	self.primary_city_country_id := std.str.splitwords(r.within.place(regexfind( '/country/id', link_href))[1].link_href,'/')[3];
	self := l;
End;

office_w_countryid := join(pre_join, city, left.primary_city_id = right.id, xform_countryid(left,right), keep(1), local);

office_w_countryid_dist := distribute(office_w_countryid, hash(primary_physical_city_id));

layout_expanded xform_cityname(office_w_countryid_dist l, city r) := Transform
	self.city_name := r.summary.names.names(type = 'Full Name')[1].value;
	self.primary_physical_city_country_id := std.str.splitwords(r.within.place(regexfind( '/country/id', link_href))[1].link_href,'/')[3];
	self := l;	
End;

office_w_cityname := join(office_w_countryid_dist, city, left.primary_physical_city_id = right.id, xform_cityname(left,right), keep(1), local);

layout_expanded xform_area(office_w_cityname l, Ares.files.ds_area r) := transform
	self.st_prov_rgn_abbv := r.summary.names(type='Display Name')[1].value;
	self.st_prov_rgn := r.summary.names(type='Full Name')[1].value;
	self := l;
end;

office_w_area := join(office_w_cityname, Ares.files.ds_area, left.physical_area_id = right.id, xform_area(left,right));

layout_expanded xform_iso(office_w_area l, Ares.Files.ds_country r) := transform
	self.country_iso2 := r.summary.iso2;
	self := l;
end;

office_w_iso2 := join(office_w_area, Ares.Files.ds_country, left.primary_country_id = right.id, xform_iso(left, right));

layout_expanded xform_countryname(office_w_iso2 l, Ares.Files.ds_country r) := transform
	country_name := r.summary.names.names(type='Country Name')[1].value;
	self.country_name := if(country_name = 'USA', 'United States', country_name);
	self := l;
end;

office_w_country_name := join(office_w_iso2, Ares.Files.ds_country, left.primary_physical_country_id = right.id, xform_countryname(left,right));





EXPORT file_office_flat := office_w_country_name ;// : persist('persist::ares::file_office_flat', SINGLE);


