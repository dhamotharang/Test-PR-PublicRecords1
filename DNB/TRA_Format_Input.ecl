// Map signed field digit to number
integer Map_Signed_Field(string sfield) :=
         (integer)
          (map(sfield[length(trim(sfield))] in ['{','A','B','C','D','E','F','G','H','I'] => '+',
              sfield[length(trim(sfield))] in ['}','j','k','l','m','n','o','p','q','r'] => '-',
              '+') +

           map(sfield[length(trim(sfield))] in ['{','}'] => sfield[1..(length(trim(sfield))-1)] + '0',
               sfield[length(trim(sfield))] in ['A','j'] => sfield[1..(length(trim(sfield))-1)] + '1',
               sfield[length(trim(sfield))] in ['B','k'] => sfield[1..(length(trim(sfield))-1)] + '2',
               sfield[length(trim(sfield))] in ['C','l'] => sfield[1..(length(trim(sfield))-1)] + '3',
               sfield[length(trim(sfield))] in ['D','m'] => sfield[1..(length(trim(sfield))-1)] + '4',
               sfield[length(trim(sfield))] in ['E','n'] => sfield[1..(length(trim(sfield))-1)] + '5',
               sfield[length(trim(sfield))] in ['F','o'] => sfield[1..(length(trim(sfield))-1)] + '6',
               sfield[length(trim(sfield))] in ['G','p'] => sfield[1..(length(trim(sfield))-1)] + '7',
               sfield[length(trim(sfield))] in ['H','q'] => sfield[1..(length(trim(sfield))-1)] + '8',
               sfield[length(trim(sfield))] in ['I','r'] => sfield[1..(length(trim(sfield))-1)] + '9',
               sfield[length(trim(sfield))]));

// Convert 4-character date to 6-character date
string6 CvtDate4to6(string4 yearMMYY) :=
   if(yearMMYY in ['    ','0000'], '',
      if(yearMMYY[3..4] > (stringlib.GetDateYYYYMMDD())[3..4], '19' + yearMMYY[3..4] + yearMMYY[1..2], '20'  + yearMMYY[3..4] + yearMMYY[1..2]));

// Convert 6-character date to 8-character date
string8 CvtDate6to8(string6 yearMMDDYY) :=
   if(yearMMDDYY in ['      ','000000'], '',
      if(yearMMDDYY[5..6] > (stringlib.GetDateYYYYMMDD())[3..4], '19' + yearMMDDYY[5..6] + yearMMDDYY[1..4], '20'  + yearMMDDYY[5..6] + yearMMDDYY[1..4]));



export DNB.Layout_DNB_Base_Temp TRA_Format_Input(DNB.Layout_DNB_Base_In l) := transform
// Map signed fields
self.annual_sales_volume_sign := map(Map_Signed_Field(l.annual_sales_volume) < 0 => '-',
                                     Map_Signed_Field(l.annual_sales_volume) > 0 => '+', ' ');
self.annual_sales_volume := if(Map_Signed_Field(l.annual_sales_volume) <> 0,
                               (string)abs(Map_Signed_Field(l.annual_sales_volume)), '');  //signed field
self.employees_here_sign := map(Map_Signed_Field(l.employees_here) < 0 => '-',
                                Map_Signed_Field(l.employees_here) > 0 => '+', ' ');
self.employees_here := if(Map_Signed_Field(l.employees_here) <> 0,
                          (string)abs(Map_Signed_Field(l.employees_here)), '');  //signed field
self.employees_total_sign := map(Map_Signed_Field(l.employees_total) < 0 => '-',
                                 Map_Signed_Field(l.employees_total) > 0 => '+', ' ');
self.employees_total := if(Map_Signed_Field(l.employees_total) <> 0,
                           (string)abs(Map_Signed_Field(l.employees_total)), ''); //signed field
self.net_worth_sign := map(Map_Signed_Field(l.net_worth) < 0 => '-',
                           Map_Signed_Field(l.net_worth) > 0 => '+', ' ');
self.net_worth := if(Map_Signed_Field(l.net_worth) <> 0,
                     (string)abs(Map_Signed_Field(l.net_worth)), '');  //signed field
self.trend_sales_sign := map(Map_Signed_Field(l.trend_sales) < 0 => '-',
                             Map_Signed_Field(l.trend_sales) > 0 => '+', ' ');
self.trend_sales := if(Map_Signed_Field(l.trend_sales) <> 0,
                       (string)abs(Map_Signed_Field(l.trend_sales)), '');  //signed field
self.trend_employment_total_sign := map(Map_Signed_Field(l.trend_employment_total) < 0 => '-',
                                        Map_Signed_Field(l.trend_employment_total) > 0 => '+', ' ');
self.trend_employment_total := if(Map_Signed_Field(l.trend_employment_total) <> 0,
                                  (string)abs(Map_Signed_Field(l.trend_employment_total)), '');  //signed field
self.base_sales_sign := map(Map_Signed_Field(l.base_sales) < 0 => '-',
                            Map_Signed_Field(l.base_sales) > 0 => '+', ' ');
self.base_sales := if(Map_Signed_Field(l.base_sales) <> 0,
                     (string)abs(Map_Signed_Field(l.base_sales)), '');  //signed field
self.base_employment_total_sign := map(Map_Signed_Field(l.base_employment_total) < 0 => '-',
                                       Map_Signed_Field(l.base_employment_total) > 0 => '+', ' ');
self.base_employment_total := if(Map_Signed_Field(l.base_employment_total) <> 0,
                                 (string)abs(Map_Signed_Field(l.base_employment_total)), '');  //signed field
self.percentage_sales_growth_sign := map(Map_Signed_Field(l.percentage_sales_growth) < 0 => '-',
                                         Map_Signed_Field(l.percentage_sales_growth) > 0 => '+', ' ');
self.percentage_sales_growth := if(Map_Signed_Field(l.percentage_sales_growth) <> 0,
                                   (string)abs(Map_Signed_Field(l.percentage_sales_growth)), '');  //signed field
self.percentage_employment_growth_sign := map(Map_Signed_Field(l.percentage_employment_growth) < 0 => '-',
                                              Map_Signed_Field(l.percentage_employment_growth) > 0 => '+', ' ');
self.percentage_employment_growth := if(Map_Signed_Field(l.percentage_employment_growth) <> 0,
                                        (string)abs(Map_Signed_Field(l.percentage_employment_growth)), '');  //signed field
self.date_of_incorporation := if(l.date_of_incorporation <> '', l.date_of_incorporation[7..10] + l.date_of_incorporation[1..2] + l.date_of_incorporation[4..5], '');
self.annual_sales_revision_date := if(l.annual_sales_revision_date <> '', l.annual_sales_revision_date[7..10] + l.annual_sales_revision_date[1..2] + l.annual_sales_revision_date[4..5], '');
self.hot_list_new_change_date := CvtDate4to6(l.hot_list_new_change_date);
self.hot_list_ownership_change_date := CvtDate4to6(l.hot_list_ownership_change_date);
self.hot_list_ceo_change_date := CvtDate4to6(l.hot_list_ceo_change_date);
self.hot_list_company_name_chg_date := CvtDate4to6(l.hot_list_company_name_chg_date);
self.hot_list_address_change_date := CvtDate4to6(l.hot_list_address_change_date);
self.hot_list_telephone_change_date := CvtDate4to6(l.hot_list_telephone_change_date);
self.report_date := CvtDate6to8(l.report_date);
self.square_footage := if((integer)l.square_footage <> 0, (string)((integer)l.square_footage), '');
self.number_of_accounts := if((integer)l.number_of_accounts <> 0, (string)((integer)l.number_of_accounts), '');
self.parent_duns_number := if((integer)l.parent_duns_number <> 0, l.parent_duns_number, '');
self.ultimate_duns_number := if((integer)l.ultimate_duns_number <> 0, l.ultimate_duns_number, '');
self.headquarters_duns_number := if((integer)l.headquarters_duns_number <> 0, l.headquarters_duns_number, '');
self.bank_duns_number := if((integer)l.bank_duns_number <> 0, l.bank_duns_number, '');
self.dias_code := if((integer)l.dias_code <> 0, (string)((integer)l.dias_code), '');
self.hierarchy_code := if((integer)l.hierarchy_code <> 0, (string)((integer)l.hierarchy_code), '');
self.telephone_number := if((integer)l.telephone_number <> 0, l.telephone_number, '');
self.year_started := if((integer)l.year_started <> 0, l.year_started, '');
self.msa_code := if((integer)l.msa_code <> 0, l.msa_code, '');
self.clean_business_name := if(l.trade_style = '' or (l.trade_style <> '' and l.parent_duns_number = '' and l.ultimate_duns_number = ''),
                                Stringlib.StringToUpperCase(l.business_name),
                                Stringlib.StringToUpperCase(l.trade_style));
self.source_group := l.duns_number;
self.record_type := 'H';
self.active_duns_number := 'Y';
self := l;
end;