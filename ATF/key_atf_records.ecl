import doxie,ut,atf, Data_Services;
df := ATF.searchFileATF;

// export key_atf_lnum := index(df,{license_number},{license_number,df.atf_id},ut.foreign_prod + 'thor_data400::key::atf_firearms_lnum_' + doxie.Version_SuperKey);
export key_atf_records := index(df,{atf_id},{df},data_services.data_location.prefix() + 'thor_data400::key::atf::firearms::records_' + doxie.Version_SuperKey);