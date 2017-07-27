f := BBB.File_BBB_Non_Members_In;

layout_stat := record
unsigned1 maxsize_bbb_id := max(group, length(trim(f.bbb_id)));
unsigned1 maxsize_company_name := max(group, length(trim(f.company_name)));
unsigned1 maxsize_address := max(group, length(trim(f.address)));
unsigned1 maxsize_country := max(group, length(trim(f.country)));
unsigned1 maxsize_listing_month := max(group, length(trim(f.listing_month)));
unsigned1 maxsize_listing_day := max(group, length(trim(f.listing_day)));
unsigned1 maxsize_listing_year := max(group, length(trim(f.listing_year)));
unsigned1 maxsize_phone := max(group, length(trim(f.phone)));
unsigned1 maxsize_phone_type := max(group, length(trim(f.phone_type)));
unsigned1 maxsize_http_link := max(group, length(trim(f.http_link)));
unsigned1 maxsize_non_member_title := max(group, length(trim(f.non_member_title)));
unsigned1 maxsize_non_member_category := max(group, length(trim(f.non_member_category)));
end;

fstat := table(f, layout_stat, few);

output(fstat,all);

