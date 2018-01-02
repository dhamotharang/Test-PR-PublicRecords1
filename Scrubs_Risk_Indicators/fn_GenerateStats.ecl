import Risk_Indicators,Scrubs_Risk_Indicators, data_services,file_compare,std;
EXPORT fn_GenerateStats(STRING Version) := function 

DistributeFieldsSSN:= record
STRING9 ssn;
end;

DistributeFieldsAdd:= record
string10 prim_range;
string28 prim_name;
string5 zip;
end;	

DistributeFieldsDOB:=record
string dob;
end;

DistributeFieldslname:=record
string lname;
end;

DistributeFields_ADL_SUS:=record
string did;
end;

DistributeFieldsRiskAdd:= record
string10 prim_range;
string28 prim_name;
string8 sec_range;
string5 zip;
end;	

IgnoreFieldsSSNTable := record
unsigned3 official_first_seen;
unsigned3 official_last_seen;
end;



 OldKey01 := INDEX(Risk_Indicators.Key_SSN_Table_v4,data_services.foreign_prod + 'thor_data400::key::death_master::father::SSN_Table_v4');
 NewKey01 := INDEX(Risk_Indicators.Key_SSN_Table_v4,data_services.foreign_prod + 'thor_data400::key::death_master::qa::SSN_Table_v4');
 OldKey02 := INDEX(Risk_Indicators.Key_SSN_Table_v4_filtered,data_services.foreign_prod + 'thor_data400::key::death_master::father::ssn_table_v4_filtered');
 NewKey02 := INDEX(Risk_Indicators.Key_SSN_Table_v4_filtered,data_services.foreign_prod + 'thor_data400::key::death_master::qa::ssn_table_v4_filtered');
 OldKey03 := INDEX(Risk_Indicators.Key_Address_Table_v4,data_services.foreign_prod + 'thor_data400::key::death_master::father::address_table_v4');
 NewKey03 := INDEX(Risk_Indicators.Key_Address_Table_v4,data_services.foreign_prod + 'thor_data400::key::death_master::qa::address_table_v4');
 OldKey04 := INDEX(Risk_Indicators.Key_ADL_Risk_Table_v4,data_services.foreign_prod + 'thor_data400::key::death_master::father::adl_risk_table_v4');
 NewKey04 := INDEX(Risk_Indicators.Key_ADL_Risk_Table_v4,data_services.foreign_prod + 'thor_data400::key::death_master::qa::adl_risk_table_v4');
 OldKey10 := INDEX(Risk_Indicators.Key_SSN_Table_v4_2,data_services.foreign_prod + 'thor_data400::key::death_master::father::ssn_table_v4_2');
 NewKey10 := INDEX(Risk_Indicators.Key_SSN_Table_v4_2,data_services.foreign_prod + 'thor_data400::key::death_master::qa::ssn_table_v4_2');
 OldKey11 := INDEX(Risk_Indicators.Key_Suspicious_Identities,data_services.foreign_prod + 'thor_data400::key::death_master::father::suspicious_identities');
 NewKey11 := INDEX(Risk_Indicators.Key_Suspicious_Identities,data_services.foreign_prod + 'thor_data400::key::death_master::qa::suspicious_identities');
 OldKey12 := INDEX(Risk_Indicators.Correlation_Risk.key_ssn_name_summary,data_services.foreign_prod + 'thor_data400::key::death_master::father::ssn_name_summary');
 NewKey12 := INDEX(Risk_Indicators.Correlation_Risk.key_ssn_name_summary,data_services.foreign_prod + 'thor_data400::key::death_master::qa::ssn_name_summary');
 OldKey13 := INDEX(Risk_Indicators.Correlation_Risk.key_ssn_addr_summary,data_services.foreign_prod + 'thor_data400::key::death_master::father::ssn_addr_summary');
 NewKey13 := INDEX(Risk_Indicators.Correlation_Risk.key_ssn_addr_summary,data_services.foreign_prod + 'thor_data400::key::death_master::qa::ssn_addr_summary');
 OldKey14 := INDEX(Risk_Indicators.Correlation_Risk.key_ssn_dob_summary,data_services.foreign_prod + 'thor_data400::key::death_master::father::ssn_dob_summary');
 NewKey14 := INDEX(Risk_Indicators.Correlation_Risk.key_ssn_dob_summary,data_services.foreign_prod + 'thor_data400::key::death_master::qa::ssn_dob_summary');
 OldKey15 := INDEX(Risk_Indicators.Correlation_Risk.key_ssn_phone_summary,data_services.foreign_prod + 'thor_data400::key::death_master::father::ssn_phone_summary');
 NewKey15 := INDEX(Risk_Indicators.Correlation_Risk.key_ssn_phone_summary,data_services.foreign_prod + 'thor_data400::key::death_master::qa::ssn_phone_summary');
 OldKey16 := INDEX(Risk_Indicators.Correlation_Risk.key_phone_dob_summary,data_services.foreign_prod + 'thor_data400::key::death_master::father::phone_dob_summary');
 NewKey16 := INDEX(Risk_Indicators.Correlation_Risk.key_phone_dob_summary,data_services.foreign_prod + 'thor_data400::key::death_master::qa::phone_dob_summary');
 OldKey17 := INDEX(Risk_Indicators.Correlation_Risk.key_addr_name_summary,data_services.foreign_prod + 'thor_data400::key::death_master::father::addr_name_summary');
 NewKey17 := INDEX(Risk_Indicators.Correlation_Risk.key_addr_name_summary,data_services.foreign_prod + 'thor_data400::key::death_master::qa::addr_name_summary');
 OldKey18 := INDEX(Risk_Indicators.Correlation_Risk.key_addr_dob_summary,data_services.foreign_prod + 'thor_data400::key::death_master::father::addr_dob_summary');
 NewKey18 := INDEX(Risk_Indicators.Correlation_Risk.key_addr_dob_summary,data_services.foreign_prod + 'thor_data400::key::death_master::qa::addr_dob_summary');
 OldKey19 := INDEX(Risk_Indicators.Correlation_Risk.key_name_dob_summary,data_services.foreign_prod + 'thor_data400::key::death_master::father::name_dob_summary');
 NewKey19 := INDEX(Risk_Indicators.Correlation_Risk.key_name_dob_summary,data_services.foreign_prod + 'thor_data400::key::death_master::qa::name_dob_summary');
 OldKey20 := INDEX(Risk_Indicators.Correlation_Risk.key_phone_addr_summary,data_services.foreign_prod + 'thor_data400::key::death_master::father::phone_addr_summary');
 NewKey20 := INDEX(Risk_Indicators.Correlation_Risk.key_phone_addr_summary,data_services.foreign_prod + 'thor_data400::key::death_master::qa::phone_addr_summary');
 OldKey21 := INDEX(Risk_Indicators.Correlation_Risk.key_phone_lname_summary,data_services.foreign_prod + 'thor_data400::key::death_master::father::phone_lname_summary');
 NewKey21 := INDEX(Risk_Indicators.Correlation_Risk.key_phone_lname_summary,data_services.foreign_prod + 'thor_data400::key::death_master::qa::phone_lname_summary');
 OldKey22 := INDEX(Risk_Indicators.Correlation_Risk.key_phone_addr_header_summary,data_services.foreign_prod + 'thor_data400::key::death_master::father::phone_addr_header_summary');
 NewKey22 := INDEX(Risk_Indicators.Correlation_Risk.key_phone_addr_header_summary,data_services.foreign_prod + 'thor_data400::key::death_master::qa::phone_addr_header_summary');
 OldKey23 := INDEX(Risk_Indicators.Correlation_Risk.key_phone_lname_header_summary,data_services.foreign_prod + 'thor_data400::key::death_master::father::phone_lname_header_summary');
 NewKey23 := INDEX(Risk_Indicators.Correlation_Risk.key_phone_lname_header_summary,data_services.foreign_prod + 'thor_data400::key::death_master::qa::phone_lname_header_summary');
         
 PulledOldKey01:=Pull(OldKey01);
 PulledNewKey01:=Pull(NewKey01);
 PulledOldKey02:=Pull(OldKey02);
 PulledNewKey02:=Pull(NewKey02);
 PulledOldKey03:=Pull(OldKey03);
 PulledNewKey03:=Pull(NewKey03);
 PulledOldKey04:=Pull(OldKey04);
 PulledNewKey04:=Pull(NewKey04);
 PulledOldKey10:=Pull(OldKey10);
 PulledNewKey10:=Pull(NewKey10);
 PulledOldKey11:=Pull(OldKey11);
 PulledNewKey11:=Pull(NewKey11);
 PulledOldKey12:=Pull(OldKey12);
 PulledNewKey12:=Pull(NewKey12);
 PulledOldKey13:=Pull(OldKey13);
 PulledNewKey13:=Pull(NewKey13);
 PulledOldKey14:=Pull(OldKey14);
 PulledNewKey14:=Pull(NewKey14);
 PulledOldKey15:=Pull(OldKey15);
 PulledNewKey15:=Pull(NewKey15);
 PulledOldKey16:=Pull(OldKey16);
 PulledNewKey16:=Pull(NewKey16);
 PulledOldKey17:=Pull(OldKey17);
 PulledNewKey17:=Pull(NewKey17);
 PulledOldKey18:=Pull(OldKey18);
 PulledNewKey18:=Pull(NewKey18);
 PulledOldKey19:=Pull(OldKey19);
 PulledNewKey19:=Pull(NewKey19);
 PulledOldKey20:=Pull(OldKey20);
 PulledNewKey20:=Pull(NewKey20);
 PulledOldKey21:=Pull(OldKey21);
 PulledNewKey21:=Pull(NewKey21);
 PulledOldKey22:=Pull(OldKey22);
 PulledNewKey22:=Pull(NewKey22);
 PulledOldKey23:=Pull(OldKey23);
 PulledNewKey23:=Pull(NewKey23);
 
return parallel(
									file_compare.Fn_File_Compare(PulledOldKey01,PulledNewKey01,,IgnoreFieldsSSNTable,DistributeFieldsSSN,false,true,true,true,'Risk_Indicators','ssn_table_v4', Version),
									file_compare.Fn_File_Compare(PulledOldKey02,PulledNewKey02,,IgnoreFieldsSSNTable,DistributeFieldsSSN,false,true,true,true,'Risk_Indicators','ssn_table_v4_filtered', Version),
									file_compare.Fn_File_Compare(PulledOldKey03,PulledNewKey03,,,DistributeFieldsRiskAdd,false,false,true,true,'Risk_Indicators','address_table_v4', Version),
									file_compare.Fn_File_Compare(PulledOldKey04,PulledNewKey04,,,DistributeFields_ADL_SUS,false,false,true,true,'Risk_Indicators','adl_risk_table_v4', Version),
									file_compare.Fn_File_Compare(PulledOldKey10,PulledNewKey10,,IgnoreFieldsSSNTable,DistributeFieldsSSN,false,true,true,true,'Risk_Indicators','ssn_table_v4_2', Version),
									file_compare.Fn_File_Compare(PulledOldKey11,PulledNewKey11,,,DistributeFields_ADL_SUS,false,false,true,true,'Risk_Indicators','suspicious_identities', Version),
									file_compare.Fn_File_Compare(PulledOldKey12,PulledNewKey12,,,DistributeFieldsSSN,false,false,true,true,'Risk_Indicators','ssn_name_summary', Version),
									file_compare.Fn_File_Compare(PulledOldKey13,PulledNewKey13,,,DistributeFieldsSSN,false,false,true,true,'Risk_Indicators','ssn_addr_summary', Version),
									file_compare.Fn_File_Compare(PulledOldKey14,PulledNewKey14,,,DistributeFieldsSSN,false,false,true,true,'Risk_Indicators','ssn_dob_summary', Version),
									file_compare.Fn_File_Compare(PulledOldKey15,PulledNewKey15,,,DistributeFieldsSSN,false,false,true,true,'Risk_Indicators','ssn_phone_summary', Version),
									file_compare.Fn_File_Compare(PulledOldKey16,PulledNewKey16,,,DistributeFieldsDOB,false,false,true,true,'Risk_Indicators','phone_dob_summary', Version),
									file_compare.Fn_File_Compare(PulledOldKey17,PulledNewKey17,,,DistributeFieldsAdd,false,false,true,true,'Risk_Indicators','addr_name_summary', Version),
									file_compare.Fn_File_Compare(PulledOldKey18,PulledNewKey18,,,DistributeFieldsAdd,false,false,true,true,'Risk_Indicators','addr_dob_summary', Version),
									file_compare.Fn_File_Compare(PulledOldKey19,PulledNewKey19,,,DistributeFieldsDOB,false,false,true,true,'Risk_Indicators','name_dob_summary', Version),
									file_compare.Fn_File_Compare(PulledOldKey20,PulledNewKey20,,,DistributeFieldsAdd,false,false,true,true,'Risk_Indicators','phone_addr_summary', Version),
									file_compare.Fn_File_Compare(PulledOldKey21,PulledNewKey21,,,DistributeFieldslname,false,false,true,true,'Risk_Indicators','phone_lname_summary', Version),
									file_compare.Fn_File_Compare(PulledOldKey22,PulledNewKey22,,,DistributeFieldsAdd,false,false,true,true,'Risk_Indicators','phone_addr_header_summary', Version),
									file_compare.Fn_File_Compare(PulledOldKey23,PulledNewKey23,,,DistributeFieldslname,false,false,true,true,'Risk_Indicators','phone_lname_header_summary', Version),
									);
									
																		
end;