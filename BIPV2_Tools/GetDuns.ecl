/*
  BIPV2_Tools.GetDuns()
    Creates a table of the latest duns_number, cnp_name & status.  Status is either 'Active','Historic' or 'Deleted'.
*/
import dnb_dmi, Data_Services,std;
EXPORT GetDuns(
     pDuns_file       = 'dnb_dmi.files().base.companies.qa'
    ,pPersist_Unique  = '\'\''
) :=
functionmacro
  import _control,ut,Data_Services,std;
  
	Persistname := 'persist::BIPV2_Tools::GetDuns::ds_active_duns_new';
//	#IF(_Control.ThisEnvironment.Name='Prod_Thor')
		import dnb_dmi;
    import BIPV2_Company_Names,ut,Data_Services;
    
    pFile_DNB_Base	:= pDuns_file;
    current_date		:= (STRING8)Std.Date.Today();
    yearsold2				:= (unsigned)current_date[1..4] - 2;
    yrson2					:= (string)yearsold2 + current_date[5..];
    ds_dmi_slim := table(pFile_DNB_Base(rawfields.duns_number != '') ,{string9 duns_number := rawfields.duns_number,string business_name := stringlib.stringtouppercase(trim(rawfields.business_name)),string trade_style := stringlib.stringtouppercase(trim(rawfields.trade_style)),date_last_seen,active_duns_number,string record_type := DNB_DMI.Utilities.RTToText(record_type)},rawfields.duns_number,rawfields.business_name, rawfields.trade_style,date_last_seen,active_duns_number,record_type,merge);
    ds_dmi_norm := normalize(ds_dmi_slim  ,2,transform({string duns_number,string company_name,unsigned4 date_last_seen,string status}
      ,self.company_name  := if(counter = 1 ,left.business_name  ,left.trade_style) 
      ,self.status        := map( left.active_duns_number = 'N' or  left.record_type = 'Deleted'           => 'Deleted'  //deleted
                                 ,left.active_duns_number = 'Y' and left.date_last_seen<=(unsigned)yrson2  => 'Historic' //old/historic
                                 ,                                                                            'Active'   //active
                             )                                
      ,self := left
    ))(company_name != '');
    ds_dmi_dedup := dedup( sort(  distribute(ds_dmi_norm ,hash64(duns_number,company_name)) ,duns_number,company_name,-date_last_seen,local) ,duns_number,company_name,local);
    ds_dmi_rid    := project(ds_dmi_dedup ,transform({unsigned rid,recordof(left)},self.rid := 0,self := left));
    ut.MAC_Sequence_Records(ds_dmi_rid,rid,ds_dmi_pop_rid);
    BIPV2_Company_Names.functions.mac_go(ds_dmi_pop_rid, ds_add_cnp_name, rid, company_name, false, false);
    ds_result_prep := project(ds_add_cnp_name  ,transform({string duns_number,string company_name,string cnp_name,unsigned4 date_last_seen,string status},self := left));
    ds_result := dedup( sort(  distribute(ds_result_prep ,hash64(duns_number,cnp_name)) ,duns_number,cnp_name,-date_last_seen,local) ,duns_number,cnp_name,local);
            
    ds_active_duns_new := ds_result : persist('~'+Persistname + '.new' + pPersist_Unique);
//	#ELSE
//		ds_active_duns      := dataset(Data_Services.foreign_prod+Persistname + pPersist_Unique, {string9 duns_number}, thor);
//		ds_active_duns_new  := dataset(Data_Services.foreign_prod+Persistname+ '.new' + pPersist_Unique, {string duns_number,string company_name,string cnp_name,unsigned4 date_last_seen,string status}, thor);
//	#END
  
  return ds_active_duns_new;
endmacro;
