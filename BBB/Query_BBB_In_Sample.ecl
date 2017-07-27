layout_bbb_in := record
string bbb_id {xpath('id')};
string company_name {xpath('name')};
string address {xpath('address')};
string country {xpath('country')};
string phone {xpath('phone')};
string phone_type {xpath('phone@type')};
string listing_month {xpath('date@month')};
string listing_day {xpath('date@day')};
string listing_year {xpath('date@year')};
string http_link {xpath('content/attributes/link')};
string member_title {xpath('content/attributes/title')};
string member_attr_name {xpath('content/attributes/attr@name')};
string member_attr {xpath('content/attributes/attr')};
end;

f := dataset ('~thor_data400::in::bbbdata_xml_20050726',layout_bbb_in,XML('listings/listing'));

count(f);
output(enth(f,5000),all);

