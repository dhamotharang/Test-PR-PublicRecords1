//#workunit('name', 'D&B Companies Out Creation ' + DNB.version);
import ut;

// Format D&B Companies File for Output
DNB.Layout_DNB_Companies_Out FormatDNBCompaniesOutput(DNB.Layout_DNB_Base L) := transform
self.bdid := if(L.bdid <> 0, intformat(L.bdid, 12, 1), '');
self := L;
end;

DNB_Companies_Out_Init := project(DNB.File_DNB_Base(business_name <> ''), FormatDNBCompaniesOutput(left));

//  Rollup the companies based on designated fields
DNB_Companies_Out_Dist := distribute(DNB_Companies_Out_Init, hash(duns_number, bdid));
DNB_Companies_Out_Sort := sort(DNB_Companies_Out_Dist, duns_number, bdid, local);
DNB_Companies_Out_Grp := group(DNB_Companies_Out_Sort, duns_number, bdid, local);
DNB_Companies_Out_Grp_Sort := sort(DNB_Companies_Out_Grp, business_name, -zip_code, -state, -city, -street,
                                     -telephone_number, -sic1a, -sic1adesc, -sic2a, -sic2adesc, -industry_group,
                                     -year_started, -date_of_incorporation, -state_of_incorporation_abbr,
                                     -annual_sales_volume, -annual_sales_code, -employees_here,
                                     -employees_total, -employees_here_code, -annual_sales_revision_date,
                                     -net_worth, -trend_sales, -owns_rents, -small_business_indicator,
                                     -minority_owned, foreign_owned, -public_indicator, -structure_type,
                                     -type_of_establishment);

DNB.Layout_DNB_Companies_Out RollupCompanies(DNB.Layout_DNB_Companies_Out l, DNB.Layout_DNB_Companies_Out r) := transform
self.date_first_seen := map(l.date_first_seen = ''
                           or (l.date_first_seen <> '' and r.date_first_seen <> '' and r.date_first_seen < l.date_first_seen) => r.date_first_seen,
                          l.date_first_seen);
self.date_last_seen := map(l.date_last_seen = ''
                           or (l.date_last_seen <> '' and r.date_last_seen <> '' and r.date_last_seen > l.date_last_seen) => r.date_last_seen,
                          l.date_last_seen);
self.record_type := if(l.record_type = 'C', l.record_type, r.record_type);
self := l;
end;

DNB_Companies_Out_Grp_Rollup := ROLLUP(DNB_Companies_Out_Grp_Sort,
                                       (left.business_name = right.business_name or right.business_name = '') and
                                       (left.zip_code = right.zip_code or right.zip_code = '') and
                                       (left.state = right.state or right.state = '') and
                                       (left.city = right.city or right.city = '') and
                                       (left.street = right.street or right.street = '') and
                                       (left.telephone_number = right.telephone_number or right.telephone_number = '') and
                                       (left.sic1a = right.sic1a or right.sic1a = '') and
                                       (left.sic1adesc = right.sic1adesc or right.sic1adesc = '') and
                                       (left.sic2a = right.sic2a or right.sic2a = '') and
                                       (left.sic2adesc = right.sic2adesc or right.sic2adesc = '') and
                                       (left.industry_group = right.industry_group or right.industry_group = '') and
                                       (left.year_started = right.year_started or right.year_started = '') and
                                       (left.date_of_incorporation = right.date_of_incorporation or right.date_of_incorporation = '') and
                                       (left.state_of_incorporation_abbr = right.state_of_incorporation_abbr or right.state_of_incorporation_abbr = '') and
                                       (left.annual_sales_volume = right.annual_sales_volume or right.annual_sales_volume = '') and
                                       (left.annual_sales_code = right.annual_sales_code or right.annual_sales_code = '' or (right.annual_sales_code = '2' and right.annual_sales_volume = '')) and
                                       (left.employees_here = right.employees_here or right.employees_here = '') and
                                       (left.employees_total = right.employees_total or right.employees_total = '') and
                                       (left.employees_here_code = right.employees_here_code or right.employees_here_code = '' or (right.employees_here_code = '2' and right.employees_here = '')) and
                                       (left.annual_sales_revision_date = right.annual_sales_revision_date or right.annual_sales_revision_date = '') and
                                       (left.net_worth = right.net_worth or right.net_worth = '') and
                                       (left.trend_sales = right.trend_sales or right.trend_sales = '') and
                                       (left.owns_rents = right.owns_rents or right.owns_rents = '' or right.owns_rents = '0') and
                                       (left.small_business_indicator = right.small_business_indicator or right.small_business_indicator = '') and
                                       (left.minority_owned = right.minority_owned or right.minority_owned = '') and
                                       (left.foreign_owned = right.foreign_owned or right.foreign_owned = '') and
                                       (left.public_indicator = right.public_indicator or right.public_indicator = '') and
                                       (left.structure_type = right.structure_type or right.structure_type = '' or right.structure_type = '0') and
                                       (left.type_of_establishment = right.type_of_establishment or right.type_of_establishment = ''),
                                       RollupCompanies(left, right));

// Retain only most current record for each Duns Number/BDID
DNB_Companies_Out_Grp_Rollup_Sort := sort(DNB_Companies_Out_Grp_Rollup, record_type, -date_last_seen, -date_first_seen);
DNB_Companies_Out_Grp_Rollup_Again := group(rollup(DNB_Companies_Out_Grp_Rollup_Sort,
                                                   left.duns_number = right.duns_number,
                                                   RollupCompanies(left, right)));

// Retain only Headquarters Location(s) for individual BDIDs
DNB_Companies_BDID := DNB_Companies_Out_Grp_Rollup_Again(bdid <> '');
DNB_Companies_No_BDID := DNB_Companies_Out_Grp_Rollup_Again(bdid = '');

DNB_Companies_BDID_Dist := distribute(DNB_Companies_BDID, hash(bdid));
DNB_Companies_BDID_Sort := sort(DNB_Companies_BDID_Dist, bdid, local);
DNB_Companies_BDID_Grp := group(DNB_Companies_BDID_Sort, bdid, local);
DNB_Companies_BDID_Grp_Sort := sort(DNB_Companies_BDID_Grp, headquarters_duns_number);
DNB_Companies_BDID_Grp_Dedup := group(dedup(DNB_Companies_BDID_Grp_Sort,
                                      left.headquarters_duns_number = '' and right.headquarters_duns_number <> ''));

DNB_Companies_BDID_All := DNB_Companies_No_BDID + DNB_Companies_BDID_Grp_Dedup;

//output(DNB_Companies_BDID_All,,'OUT::DNB_Companies_' + DNB.version, overwrite);
ut.MAC_SF_BuildProcess(DNB_Companies_BDID_All,'~thor_Data400::out::DNB_Companies',do1,2)
export Make_DNB_Companies_Out := do1;
