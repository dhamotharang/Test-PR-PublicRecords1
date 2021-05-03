ds_biz_info := Marketing_List.Files('20200501f_bh821').business_information_prep.logical;
ds_contact  := Marketing_List.Files('20200501f_bh821').business_contact_prep.logical;

// -- lewis wants to count the source 
    // string2                   src_revenue         ;
    // integer                   number_of_employees ;
    // string2                   src_employees       ;
    // string4                   SIC_Primary         ;
    // string2                   src_sics            ;
    // string6                   NAICS_Primary       ;
    // string2                   src_naics           ;

ds_biz_dedup_seleid := table(ds_biz_info  ,{seleid,integer annual_revenue := seleid_level.annual_revenue  ,string2 src_revenue := seleid_level.src_revenue ,integer number_of_employees := seleid_level.number_of_employees ,string2 src_employees := seleid_level.src_employees  ,string4 SIC_Primary := seleid_level.SIC_Primary ,string2 src_sics := seleid_level.src_sics  ,string6 NAICS_Primary := seleid_level.NAICS_Primary  ,string2 src_naics := seleid_level.src_naics} 
                                           ,seleid,seleid_level.annual_revenue  ,seleid_level.src_revenue ,seleid_level.number_of_employees ,seleid_level.src_employees  ,seleid_level.SIC_Primary ,seleid_level.src_sics  ,seleid_level.NAICS_Primary  ,seleid_level.src_naics ,merge);

ds_emp_cnt_sources     := table(ds_biz_dedup_seleid(number_of_employees  >=0 ,trim(src_employees ) != '')  ,{src_employees ,unsigned cnt := count(group)} ,src_employees ,merge);
ds_revenue_cnt_sources := table(ds_biz_dedup_seleid(annual_revenue       >=0 ,trim(src_revenue   ) != '')  ,{src_revenue   ,unsigned cnt := count(group)} ,src_revenue   ,merge);
ds_sic_cnt_sources     := table(ds_biz_dedup_seleid(                          trim(SIC_Primary   ) != '')  ,{src_sics      ,unsigned cnt := count(group)} ,src_sics      ,merge);
ds_naics_cnt_sources   := table(ds_biz_dedup_seleid(                          trim(NAICS_Primary ) != '')  ,{src_naics     ,unsigned cnt := count(group)} ,src_naics     ,merge);

emp_cnt_total     := count(ds_biz_dedup_seleid(number_of_employees  >=0 ,trim(src_employees ) != ''));
revenue_cnt_total := count(ds_biz_dedup_seleid(annual_revenue       >=0 ,trim(src_revenue   ) != ''));
sic_cnt_total     := count(ds_biz_dedup_seleid(                          trim(SIC_Primary   ) != ''));
naics_cnt_total   := count(ds_biz_dedup_seleid(                          trim(NAICS_Primary ) != ''));

layout_stats := {string seleid_level  ,string source  ,string cnt ,string source_pct};

// -- contacts
ds_contact_cnt_sources  := table(ds_contact  ,{string src_name := bipv2.mod_sources.TranslateSource_aggregate(src_name) ,unsigned cnt := count(group)} ,bipv2.mod_sources.TranslateSource_aggregate(src_name) ,merge);
contact_cnt_total       := count(ds_contact);

ds_out := 
    dataset([{'Number of Employees' ,'Total'  ,ut.fIntWithCommas (emp_cnt_total)  ,'100.00'}]  ,layout_stats)
  + project(sort(ds_emp_cnt_sources ,-cnt)  ,transform(layout_stats ,self.seleid_level := 'Number of Employees' ,self.source := mdr.sourcetools.translatesource(left.src_employees),self.cnt := ut.fIntWithCommas(left.cnt)  ,self.source_pct := realformat((left.cnt / emp_cnt_total) * 100.0,8,4)) )
  + dataset([{'SIC Primary'         ,'Total'  ,ut.fIntWithCommas (sic_cnt_total)  ,'100.00'}]  ,layout_stats)
  + project(sort(ds_sic_cnt_sources ,-cnt)  ,transform(layout_stats ,self.seleid_level := 'SIC Primary'         ,self.source := mdr.sourcetools.translatesource(left.src_sics)     ,self.cnt := ut.fIntWithCommas(left.cnt)  ,self.source_pct := realformat((left.cnt / sic_cnt_total) * 100.0,8,4)) )
  + dataset([{'NAICS Primary'       ,'Total'  ,ut.fIntWithCommas (naics_cnt_total)  ,'100.00'}]  ,layout_stats)
  + project(sort(ds_naics_cnt_sources ,-cnt)  ,transform(layout_stats ,self.seleid_level := 'NAICS Primary'         ,self.source := mdr.sourcetools.translatesource(left.src_naics)     ,self.cnt := ut.fIntWithCommas(left.cnt)  ,self.source_pct := realformat((left.cnt / naics_cnt_total) * 100.0,8,4)) )
  + dataset([{'Annual Revenue'      ,'Total'  ,ut.fIntWithCommas (revenue_cnt_total)  ,'100.00'}]  ,layout_stats)
  + project(sort(ds_revenue_cnt_sources ,-cnt)  ,transform(layout_stats ,self.seleid_level := 'Annual Revenue'         ,self.source := mdr.sourcetools.translatesource(left.src_revenue)     ,self.cnt := ut.fIntWithCommas(left.cnt)  ,self.source_pct := realformat((left.cnt / revenue_cnt_total) * 100.0,8,4)) )
  + dataset([{'Contact Name(fname,lname)'      ,'Total'  ,ut.fIntWithCommas (contact_cnt_total)  ,'100.00'}]  ,layout_stats)
  + project(sort(ds_contact_cnt_sources ,-cnt)  ,transform(layout_stats ,self.seleid_level := 'Contact Name(fname,lname)'         ,self.source := left.src_name     ,self.cnt := ut.fIntWithCommas(left.cnt)  ,self.source_pct := realformat((left.cnt / contact_cnt_total) * 100.0,8,4)) )
  ;
  
output(sort(ds_out  ,map(seleid_level = 'Number of Employees' => 1 ,seleid_level = 'SIC Primary' => 2 ,seleid_level = 'NAICS Primary' => 3 ,seleid_level = 'Annual Revenue' => 4 ,seleid_level = 'Contact Name(fname,lname)' => 5 ,6),-(integer)STD.Str.FilterOut(cnt,',') ) ,named('ds_out'));