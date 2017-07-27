import ut, Business_Header, Business_Header_SS, did_add;

DNB_Companies_Update := DNB.File_DNB_Companies_Update;

// Project current base to temp format
DNB.Layout_DNB_Base_Temp InitBase(DNB.Layout_DNB_Base l) := transform
self.record_type := 'H'; //reset record type to historical
self.clean_business_name := if(l.trade_style = '' or (l.trade_style <> '' and l.parent_duns_number = '' and l.ultimate_duns_number = ''),
                                Stringlib.StringToUpperCase(l.business_name),
                                Stringlib.StringToUpperCase(l.trade_style));
self.source_group := IF(l.active_duns_number = 'Y', l.duns_number, 'D' + l.duns_number + '-' + stringlib.stringtouppercase(l.business_name));
self := l;
end;

DNB_Base_Init := project(DNB.File_DNB_Base, InitBase(left));

// Format new companies update
DNB_Base_Update := project(DNB_Companies_Update(delete_record_indicator = ''), DNB.TRA_Format_Input(left));

// Append new update
DNB_Base_Append := DNB_Base_Init + DNB_Base_Update;
DNB_Base_Append_Dedup := dedup(DNB_Base_Append, all);
DNB_Base_Append_Dist := distribute(DNB_Base_Append_Dedup, hash(duns_number));

// Process delete records
layout_delete_list := record
DNB_Companies_Update.duns_number;
end;

DNB_Delete_List := table(DNB_Companies_Update(delete_record_indicator<>''), layout_delete_list);
DNB_Delete_List_Dist := distribute(DNB_Delete_List, hash(duns_number));
DNB_Delete_List_Sort := sort(DNB_Delete_List_Dist, duns_number, local);
DNB_Delete_List_Dedup := dedup(DNB_Delete_List_Sort, duns_number, local);


DNB_Yearly_Update_List := table(DNB_Companies_Update, layout_delete_list);
DNB_Yearly_Update_List_Dist := distribute(DNB_Yearly_Update_List, hash(duns_number));
DNB_Yearly_Update_List_Sort := sort(DNB_Yearly_Update_List_Dist, duns_number, local);
DNB_Yearly_Update_List_Dedup := dedup(DNB_Yearly_Update_List_Sort, duns_number, local);

layout_delete_list FindYearlyDeletes(DNB.Layout_DNB_Base_Temp l, layout_delete_list r) := transform
self := l;
end;

DNB_Yearly_Delete_List := join(DNB_Base_Append_Dist(active_duns_number='Y'),
                               DNB_Yearly_Update_List_Dedup,
                               left.duns_number = right.duns_number,
                               FindYearlyDeletes(left, right),
                               left only,
                               local);

DNB_Yearly_Delete_List_Dedup := dedup(DNB_Yearly_Delete_List, duns_number, local);

Layout_DNB_Base_Temp UpdateDelete(Layout_DNB_Base_Temp l, layout_delete_list r) := transform
self.active_duns_number := if(r.duns_number <> '', 'N', l.active_duns_number);
self := l;
end;

DNB_Base_Updated := join(DNB_Base_Append_Dist,
                         if(DNB.DNB_Yearly_Update_Flag = 'Y', DNB_Yearly_Delete_List_Dedup, DNB_Delete_List_Dedup),
                         left.duns_number = right.duns_number,
                         UpdateDelete(left, right),
                         left outer,
                         local);

// Rollup company records
DNB.Layout_DNB_Base_Temp RollupCompanies(DNB.Layout_DNB_Base_Temp l, DNB.Layout_DNB_Base_Temp r) := transform
self.date_first_seen := map(l.date_first_seen = ''
                           or (l.date_first_seen <> '' and r.date_first_seen <> '' and r.date_first_seen < l.date_first_seen) => r.date_first_seen,
                          l.date_first_seen);
self.date_last_seen := map(l.date_last_seen = ''
                           or (l.date_last_seen <> '' and r.date_last_seen <> '' AND r.date_last_seen > l.date_last_seen) => r.date_last_seen,
                          l.date_last_seen);
self := l;
end;


DNB_Base_Updated_Sort := sort(DNB_Base_Updated, duns_number, active_duns_number,
-report_date,
-annual_sales_revision_date,
business_name,
trade_style,
street,
city,
state,
zip_code,
mail_address,
mail_city,
mail_state,
mail_zip_code,
telephone_number,
county_name,
msa_code,
msa_name,
line_of_business_description,
sic1,
sic1desc,
sic1a,
sic1adesc,
sic1b,
sic1bdesc,
sic1c,
sic1cdesc,
sic1d,
sic1ddesc,
sic2,
sic2desc,
sic2a,
sic2adesc,
sic2b,
sic2bdesc,
sic2c,
sic2cdesc,
sic2d,
sic2ddesc,
sic3,
sic3desc,
sic3a,
sic3adesc,
sic3b,
sic3bdesc,
sic3c,
sic3cdesc,
sic3d,
sic3ddesc,
sic4,
sic4desc,
sic4a,
sic4adesc,
sic4b,
sic4bdesc,
sic4c,
sic4cdesc,
sic4d,
sic4ddesc,
sic5,
sic5desc,
sic5a,
sic5adesc,
sic5b,
sic5bdesc,
sic5c,
sic5cdesc,
sic5d,
sic5ddesc,
sic6,
sic6desc,
sic6a,
sic6adesc,
sic6b,
sic6bdesc,
sic6c,
sic6cdesc,
sic6d,
sic6ddesc,
industry_group,
year_started,
date_of_incorporation,
state_of_incorporation_abbr,
annual_sales_volume_sign,
annual_sales_volume,
annual_sales_code,
employees_here_sign,
employees_here,
employees_total_sign,
employees_total,
employees_here_code,
internal_use,
net_worth_sign,
net_worth,
trend_sales_sign,
trend_sales,
trend_employment_total_sign,
trend_employment_total,
base_sales_sign,
base_sales,
base_employment_total_sign,
base_employment_total,
percentage_sales_growth_sign,
percentage_sales_growth,
percentage_employment_growth_sign,
percentage_employment_growth,
square_footage,
sales_territory,
owns_rents,
number_of_accounts,
bank_duns_number,
bank_name,
accounting_firm_name,
small_business_indicator,
minority_owned,
cottage_indicator,
foreign_owned,
manufacturing_here_indicator,
public_indicator,
importer_exporter_indicator,
structure_type,
type_of_establishment,
parent_duns_number,
ultimate_duns_number,
headquarters_duns_number,
parent_company_name,
ultimate_company_name,
dias_code,
hierarchy_code,
ultimate_indicator,
internal_use1,
internal_use2,
internal_use3,
hot_list_new_indicator,
hot_list_ownership_change_indicator,
hot_list_ceo_change_indicator,
hot_list_company_name_change_ind,
hot_list_address_change_indicator,
hot_list_telephone_change_indicator,
hot_list_new_change_date,
hot_list_ownership_change_date,
hot_list_ceo_change_date,
hot_list_company_name_chg_date,
hot_list_address_change_date,
hot_list_telephone_change_date,
local);

DNB_Base_Updated_Rollup := rollup(DNB_Base_Updated_Sort,
left.report_date = right.report_date and
//left.annual_sales_revision_date = right.annual_sales_revision_date and
left.duns_number = right.duns_number and
left.active_duns_number = right.active_duns_number and
left.business_name = right.business_name and
left.trade_style =right.trade_style and
left.street = right.street and
left.city = right.city and
left.state = right.state and
left.zip_code = right.zip_code and
left.mail_address = right.mail_address and
left.mail_city = right.mail_city and
left.mail_state = right.mail_state and
left.mail_zip_code= right.mail_zip_code and
left.telephone_number = right.telephone_number and
left.county_name = right.county_name and
left.msa_code = right.msa_code and
left.msa_name = right.msa_name and
left.line_of_business_description = right.line_of_business_description and
left.sic1 = right.sic1 and
left.sic1desc = right.sic1desc and
left.sic1a = right.sic1a and
left.sic1adesc = right.sic1adesc and
left.sic1b = right.sic1b and
left.sic1bdesc = right.sic1bdesc and
left.sic1c = right.sic1c and
left.sic1cdesc = right.sic1cdesc and
left.sic1d= right.sic1d and
left.sic1ddesc = right.sic1ddesc and
left.sic2 = right.sic2 and
left.sic2desc = right.sic2desc and
left.sic2a = right.sic2a and
left.sic2adesc = right.sic2adesc and
left.sic2b = right.sic2b and
left.sic2bdesc = right.sic2bdesc and
left.sic2c = right.sic2c and
left.sic2cdesc = right.sic2cdesc and
left.sic2d = right.sic2d and
left.sic2ddesc = right.sic2ddesc and
left.sic3 = right.sic3 and
left.sic3desc = right.sic3desc and
left.sic3a = right.sic3a and
left.sic3adesc = right.sic3adesc and
left.sic3b = right.sic3b and
left.sic3bdesc = right.sic3bdesc and
left.sic3c = right.sic3c and
left.sic3cdesc = right.sic3cdesc and
left.sic3d = right.sic3d and
left.sic3ddesc = right.sic3ddesc and
left.sic4 = right.sic4 and
left.sic4desc = right.sic4desc and
left.sic4a = right.sic4a and
left.sic4adesc = right.sic4adesc and
left.sic4b = right.sic4b and
left.sic4bdesc = right.sic4bdesc and
left.sic4c = right.sic4c and
left.sic4cdesc = right.sic4cdesc and
left.sic4d = right.sic4d and
left.sic4ddesc = right.sic4ddesc and
left.sic5 = right.sic5 and
left.sic5desc = right.sic5desc and
left.sic5a = right.sic5a and
left.sic5adesc = right.sic5adesc and
left.sic5b = right.sic5b and
left.sic5bdesc = right.sic5bdesc and
left.sic5c = right.sic5c and
left.sic5cdesc = right.sic5cdesc and
left.sic5d = right.sic5d and
left.sic5ddesc = right.sic5ddesc and
left.sic6 = right.sic6 and
left.sic6desc = right.sic6desc and
left.sic6a = right.sic6a and
left.sic6adesc = right.sic6adesc and
left.sic6b = right.sic6b and
left.sic6bdesc = right.sic6bdesc and
left.sic6c = right.sic6c and
left.sic6cdesc = right.sic6cdesc and
left.sic6d = right.sic6d and
left.sic6ddesc = right.sic6ddesc and
left.industry_group = right.industry_group and
left.year_started = right.year_started and
left.date_of_incorporation = right.date_of_incorporation and
left.state_of_incorporation_abbr = right.state_of_incorporation_abbr and
left.annual_sales_volume_sign = right.annual_sales_volume_sign and
left.annual_sales_volume = right.annual_sales_volume and
left.annual_sales_code = right.annual_sales_code and
left.employees_here_sign = right.employees_here_sign and
left.employees_here = right.employees_here and
left.employees_total_sign = right.employees_total_sign and
left.employees_total = right.employees_total and
left.employees_here_code = right.employees_here_code and
left.internal_use = right.internal_use and
left.net_worth_sign = right.net_worth_sign and
left.net_worth = right.net_worth and
left.trend_sales_sign = right.trend_sales_sign and
left.trend_sales = right.trend_sales and
left.trend_employment_total_sign = right.trend_employment_total_sign and
left.trend_employment_total = right.trend_employment_total and
left.base_sales_sign = right.base_sales_sign and
left.base_sales = right.base_sales and
left.base_employment_total_sign = right.base_employment_total_sign and
left.base_employment_total = right.base_employment_total and
left.percentage_sales_growth_sign = right.percentage_sales_growth_sign and
left.percentage_sales_growth = right.percentage_sales_growth and
left.percentage_employment_growth_sign = right.percentage_employment_growth_sign and
left.percentage_employment_growth = right.percentage_employment_growth and
left.square_footage = right.square_footage and
left.sales_territory = right.sales_territory and
left.owns_rents = right.owns_rents and
left.number_of_accounts = right.number_of_accounts and
left.bank_duns_number = right.bank_duns_number and
left.bank_name = right.bank_name and
left.accounting_firm_name = right.accounting_firm_name and
left.small_business_indicator = right.small_business_indicator and
left.minority_owned = right.minority_owned and
left.cottage_indicator = right.cottage_indicator and
left.foreign_owned = right.foreign_owned and
left.manufacturing_here_indicator = right.manufacturing_here_indicator and
left.public_indicator = right.public_indicator and
left.importer_exporter_indicator = right.importer_exporter_indicator and
left.structure_type = right.structure_type and
left.type_of_establishment = right.type_of_establishment and
left.parent_duns_number = right.parent_duns_number and
left.ultimate_duns_number = right.ultimate_duns_number and
left.headquarters_duns_number = right.headquarters_duns_number and
left.parent_company_name = right.parent_company_name and
left.ultimate_company_name = right.ultimate_company_name and
left.dias_code = right.dias_code and
left.hierarchy_code = right.hierarchy_code and
left.ultimate_indicator = right.ultimate_indicator and
left.internal_use1 = right.internal_use1 and
left.internal_use2 =right.internal_use2 and
left.internal_use3 = right.internal_use3 and
left.hot_list_new_indicator = right.hot_list_new_indicator and
left.hot_list_ownership_change_indicator = right.hot_list_ownership_change_indicator and
left.hot_list_ceo_change_indicator = right.hot_list_ceo_change_indicator and
left.hot_list_company_name_change_ind = right.hot_list_company_name_change_ind and
left.hot_list_address_change_indicator = right.hot_list_address_change_indicator and
left.hot_list_telephone_change_indicator = right.hot_list_telephone_change_indicator and
left.hot_list_new_change_date = right.hot_list_new_change_date and
left.hot_list_ownership_change_date = right.hot_list_ownership_change_date and
left.hot_list_ceo_change_date = right.hot_list_ceo_change_date and
left.hot_list_company_name_chg_date = right.hot_list_company_name_chg_date and
left.hot_list_address_change_date = right.hot_list_address_change_date and
left.hot_list_telephone_change_date = right.hot_list_telephone_change_date,
RollupCompanies(left, right),
local);

//************************************************************
// Group and Iterate to Set Current/Historical Indicator
//************************************************************

// Record Type has been initialized to historical 'H'
DNB_Base_Updated_Rollup_Sort := sort(DNB_Base_Updated_Rollup, duns_number, local);
DNB_Base_Updated_Rollup_Grpd := group(DNB_Base_Updated_Rollup_Sort, duns_number, local);
DNB_Base_Updated_Rollup_Grpd_Sort := sort(DNB_Base_Updated_Rollup_Grpd, -date_last_seen, -date_first_seen);

DNB.Layout_DNB_Base_Temp SetRecordType(DNB.Layout_DNB_Base_Temp l, DNB.Layout_DNB_Base_Temp r) := transform
self.record_type := if(l.record_type = '' and r.active_duns_number = 'Y', 'C', r.record_type);
self := r;
END;

DNB_Base_ToBDID := group(iterate(DNB_Base_Updated_Rollup_Grpd_Sort, SetRecordType(left, right)));

// First do a direct source match to the current Business Headers
Business_Header.MAC_Source_Match(DNB_Base_ToBDID, DNB_Base_BDID_Init,
                        FALSE, bdid,
                        FALSE, 'D',
                        TRUE, source_group,
                        clean_business_name,
                        prim_range, prim_name, sec_range, zip,
                        TRUE, telephone_number,
                        FALSE, fein_field,
						TRUE, source_group)

// Then do a standard BDID match for the records which did not BDID,
// since the Corporate file may be newer than the Business Headers
BDID_Matchset := ['A'];

DNB_Base_BDID_Match := DNB_Base_BDID_Init(bdid <> 0);
DNB_Base_BDID_NoMatch := DNB_Base_BDID_Init(bdid = 0);


Business_Header_SS.MAC_Add_BDID_Flex(DNB_Base_BDID_NoMatch,
                                  BDID_Matchset,
                                  clean_business_name,
                                  prim_range, prim_name, zip,
                                  sec_range, st,
                                  telephone_number, fein_field,
                                  bdid, Layout_DNB_Base_Temp,
                                  FALSE, BDID_score_field,
                                  DNB_Base_BDID_Rematch)

DNB_Base_BDID_All := DNB_Base_BDID_Match + DNB_Base_BDID_Rematch;

DNB.Layout_DNB_Base FormatOutput(DNB.Layout_DNB_Base_Temp L) := TRANSFORM
SELF := L;
END;

DNB_Base_BDID := PROJECT(DNB_Base_BDID_All, FormatOutput(LEFT));


export DNB_Updated_Companies := DNB_Base_BDID : persist('TEMP::DNB_Updated_Companies');