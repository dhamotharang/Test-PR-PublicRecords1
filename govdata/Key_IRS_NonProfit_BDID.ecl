Import Data_Services, doxie, ut;

BDID_Layout := record
	govdata.Layout_IRS_NonProfit_Base -[exempt_org_status_code];
end;

df_filtered	:= govdata.File_IRS_NonProfit_Base(bdid != 0);
df					:= project(df_filtered,transform(BDID_Layout,self := left));

export Key_IRS_NonProfit_BDID := index(df,{bdid},{df},Data_Services.Data_location.Prefix('irs')+'thor_data400::key::irs_nonprofit_bdid_' + doxie.Version_SuperKey);
