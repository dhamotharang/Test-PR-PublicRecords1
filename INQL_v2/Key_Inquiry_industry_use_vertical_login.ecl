import doxie,ut,INQL_v2,Data_Services;

import doxie, data_services;

df := INQL_v2.File_Inquiry_industry_use_vertical_login.MBS_slim;

export Key_Inquiry_Industry_use_vertical_login(boolean IsFCRA = false)
 := INDEX(df, {string20 s_company_id := company_id, string4 s_product_id := product_id,string20 s_gc_id := gc_id }, {df} - company_id - product_id - gc_id
      ,Data_Services.Data_location.Prefix('Inquiry') + 'thor_data400::key::inquiry_table'+if(IsFCRA,'::fcra::','::') + 'industry_use_vertical_login_' +doxie.Version_SuperKey);
 