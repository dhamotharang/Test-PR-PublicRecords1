export Layout_BBB_Non_Members_In := record
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
string non_member_title {xpath('content/attributes/title')};
string non_member_category {xpath('content/attributes/category')};
end;