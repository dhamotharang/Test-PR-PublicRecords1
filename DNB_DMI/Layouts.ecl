/*2012-09-25T21:49:38Z (Julie Franzer)
Modified for bipv2
*/
import utilfile,address,standard,dnb,bipv2;
export Layouts :=
module



	export Input := 
	module
		export raw :=
		record

			string full_record{maxlength(10000)};

		end;
		
		export fixed :=
		record

			string5692 full_record;

		end;

		export lsic_codes :=
		record
			 string8	sic;
			 string60 sicdesc;
		end;
		
		export lexec_names :=
		record
			 string13 exec_first_name;
			 string1 	exec_middle_initial;
			 string15 exec_last_name;
			 string3 	exec_suffix;
			 string2 	exec_mrc_title_code;
			 string30 exec_title;
			 string30 exec_vanity_title;		
		end;
		
		export Flattened :=
		record
			 string9 duns_number;
			 string90 business_name;
			 string30 trade_style;
			 string25 street;
			 string20 city;
			 string2 state;
			 string9 zip_code;
			 string17 mail_address;
			 string14 mail_city;
			 string2 mail_state;
			 string5 mail_zip_code;
			 string10 telephone_number;
			 string21 county_name;
			 string4 msa_code;
			 string40 msa_name;
			 string128 line_of_business_description;
			 string8 sic1;
			 string60 sic1desc;
			 string8 sic1a;
			 string60 sic1adesc;
			 string8 sic1b;
			 string60 sic1bdesc;
			 string8 sic1c;
			 string60 sic1cdesc;
			 string8 sic1d;
			 string60 sic1ddesc;
			 string8 sic2;
			 string60 sic2desc;
			 string8 sic2a;
			 string60 sic2adesc;
			 string8 sic2b;
			 string60 sic2bdesc;
			 string8 sic2c;
			 string60 sic2cdesc;
			 string8 sic2d;
			 string60 sic2ddesc;
			 string8 sic3;
			 string60 sic3desc;
			 string8 sic3a;
			 string60 sic3adesc;
			 string8 sic3b;
			 string60 sic3bdesc;
			 string8 sic3c;
			 string60 sic3cdesc;
			 string8 sic3d;
			 string60 sic3ddesc;
			 string8 sic4;
			 string60 sic4desc;
			 string8 sic4a;
			 string60 sic4adesc;
			 string8 sic4b;
			 string60 sic4bdesc;
			 string8 sic4c;
			 string60 sic4cdesc;
			 string8 sic4d;
			 string60 sic4ddesc;
			 string8 sic5;
			 string60 sic5desc;
			 string8 sic5a;
			 string60 sic5adesc;
			 string8 sic5b;
			 string60 sic5bdesc;
			 string8 sic5c;
			 string60 sic5cdesc;
			 string8 sic5d;
			 string60 sic5ddesc;
			 string8 sic6;
			 string60 sic6desc;
			 string8 sic6a;
			 string60 sic6adesc;
			 string8 sic6b;
			 string60 sic6bdesc;
			 string8 sic6c;
			 string60 sic6cdesc;
			 string8 sic6d;
			 string60 sic6ddesc;
			 string1 industry_group;
			 string4 year_started;
			 string10 date_of_incorporation;
			 string2 state_of_incorporation_abbr;
			 string15 annual_sales_volume;
			 string1 annual_sales_code;
			 string10 employees_here;
			 string10 employees_total;
			 string1 employees_here_code;
			 string1 internal_use;
			 string10 annual_sales_revision_date;
			 string12 net_worth;
			 string15 trend_sales;
			 string10 trend_employment_total;
			 string15 base_sales;
			 string10 base_employment_total;
			 string4 percentage_sales_growth;
			 string4 percentage_employment_growth;
			 string9 square_footage;
			 string1 sals_territory;
			 string1 owns_rents;
			 string9 number_of_accounts;
			 string9 bank_duns_number;
			 string30 bank_name;
			 string30 accounting_firm_name;
			 string1 small_business_indicator;
			 string1 minority_owned;
			 string1 cottage_indicator;
			 string1 foreign_owned;
			 string1 manufacturing_here_indicator;
			 string1 public_indicator;
			 string1 importer_exporter_indicator;
			 string1 structure_type;
			 string1 type_of_establishment;
			 string9 parent_duns_number;
			 string9 ultimate_duns_number;
			 string9 headquarters_duns_number;
			 string30 parent_company_name;
			 string30 ultimate_company_name;
			 string9 dias_code;
			 string3 hierarchy_code;
			 string1 ultimate_indicator;

			 string13 exec1_first_name			;
			 string1 	exec1_middle_initial	;
			 string15 exec1_last_name			;
			 string3 	exec1_suffix					;
			 string2 	exec1_mrc_title_code	;
			 string30 exec1_title					;
			 string30 exec1_vanity_title		;
			 string13 exec2_first_name			;
			 string1 	exec2_middle_initial	;
			 string15 exec2_last_name			;
			 string3 	exec2_suffix					;
			 string2 	exec2_mrc_title_code	;
			 string30 exec2_title					;
			 string30 exec2_vanity_title		;
			 string13 exec3_first_name			;
			 string1 	exec3_middle_initial	;
			 string15 exec3_last_name			;
			 string3 	exec3_suffix					;
			 string2 	exec3_mrc_title_code	;
			 string30 exec3_title					;
			 string30 exec3_vanity_title		;
			 string13 exec4_first_name			;
			 string1 	exec4_middle_initial	;
			 string15 exec4_last_name			;
			 string3 	exec4_suffix					;
			 string2 	exec4_mrc_title_code	;
			 string30 exec4_title					;
			 string30 exec4_vanity_title		;
			 string13 exec5_first_name			;
			 string1 	exec5_middle_initial	;
			 string15 exec5_last_name			;
			 string3 	exec5_suffix					;
			 string2 	exec5_mrc_title_code	;
			 string30 exec5_title					;
			 string30 exec5_vanity_title		;
			 string13 exec6_first_name			;
			 string1 	exec6_middle_initial	;
			 string15 exec6_last_name			;
			 string3 	exec6_suffix					;
			 string2 	exec6_mrc_title_code	;
			 string30 exec6_title					;
			 string30 exec6_vanity_title		;
			 string13 exec7_first_name			;
			 string1 	exec7_middle_initial	;
			 string15 exec7_last_name			;
			 string3 	exec7_suffix					;
			 string2 	exec7_mrc_title_code	;
			 string30 exec7_title					;
			 string30 exec7_vanity_title		;
			 string13 exec8_first_name			;
			 string1 	exec8_middle_initial	;
			 string15 exec8_last_name			;
			 string3 	exec8_suffix					;
			 string2 	exec8_mrc_title_code	;
			 string30 exec8_title					;
			 string30 exec8_vanity_title		;
			 string13 exec9_first_name			;
			 string1 	exec9_middle_initial	;
			 string15 exec9_last_name			;
			 string3 	exec9_suffix					;
			 string2 	exec9_mrc_title_code	;
			 string30 exec9_title					;
			 string30 exec9_vanity_title		;
			 string13 exec10_first_name			;
			 string1 	exec10_middle_initial	;
			 string15 exec10_last_name			;
			 string3 	exec10_suffix					;
			 string2 	exec10_mrc_title_code	;
			 string30 exec10_title					;
			 string30 exec10_vanity_title		;
			 string13 exec11_first_name			;
			 string1 	exec11_middle_initial	;
			 string15 exec11_last_name			;
			 string3 	exec11_suffix					;
			 string2 	exec11_mrc_title_code	;
			 string30 exec11_title					;
			 string30 exec11_vanity_title		;
			 string13 exec12_first_name			;
			 string1 	exec12_middle_initial	;
			 string15 exec12_last_name			;
			 string3 	exec12_suffix					;
			 string2 	exec12_mrc_title_code	;
			 string30 exec12_title					;
			 string30 exec12_vanity_title		;
			 string13 exec13_first_name			;
			 string1 	exec13_middle_initial	;
			 string15 exec13_last_name			;
			 string3 	exec13_suffix					;
			 string2 	exec13_mrc_title_code	;
			 string30 exec13_title					;
			 string30 exec13_vanity_title		;
			 string13 exec14_first_name			;
			 string1 	exec14_middle_initial	;
			 string15 exec14_last_name			;
			 string3 	exec14_suffix					;
			 string2 	exec14_mrc_title_code	;
			 string30 exec14_title					;
			 string30 exec14_vanity_title		;
			 string13 exec15_first_name			;
			 string1 	exec15_middle_initial	;
			 string15 exec15_last_name			;
			 string3 	exec15_suffix					;
			 string2 	exec15_mrc_title_code	;
			 string30 exec15_title					;
			 string30 exec15_vanity_title		;
			 string13 exec16_first_name			;
			 string1 	exec16_middle_initial	;
			 string15 exec16_last_name			;
			 string3 	exec16_suffix					;
			 string2 	exec16_mrc_title_code	;
			 string30 exec16_title					;
			 string30 exec16_vanity_title		;
			 string13 exec17_first_name			;
			 string1 	exec17_middle_initial	;
			 string15 exec17_last_name			;
			 string3 	exec17_suffix					;
			 string2 	exec17_mrc_title_code	;
			 string30 exec17_title					;
			 string30 exec17_vanity_title		;
			 string13 exec18_first_name			;
			 string1 	exec18_middle_initial	;
			 string15 exec18_last_name			;
			 string3 	exec18_suffix					;
			 string2 	exec18_mrc_title_code	;
			 string30 exec18_title					;
			 string30 exec18_vanity_title		;
			 string13 exec19_first_name			;
			 string1 	exec19_middle_initial	;
			 string15 exec19_last_name			;
			 string3 	exec19_suffix					;
			 string2 	exec19_mrc_title_code	;
			 string30 exec19_title					;
			 string30 exec19_vanity_title		;
			 string13 exec20_first_name			;
			 string1 	exec20_middle_initial	;
			 string15 exec20_last_name			;
			 string3 	exec20_suffix					;
			 string2 	exec20_mrc_title_code	;
			 string30 exec20_title					;
			 string30 exec20_vanity_title		;
			 string13 exec21_first_name			;
			 string1 	exec21_middle_initial	;
			 string15 exec21_last_name			;
			 string3 	exec21_suffix					;
			 string2 	exec21_mrc_title_code	;
			 string30 exec21_title					;
			 string30 exec21_vanity_title		;
			 string13 exec22_first_name			;
			 string1 	exec22_middle_initial	;
			 string15 exec22_last_name			;
			 string3 	exec22_suffix					;
			 string2 	exec22_mrc_title_code	;
			 string30 exec22_title					;
			 string30 exec22_vanity_title		;
			 string13 exec23_first_name			;
			 string1 	exec23_middle_initial	;
			 string15 exec23_last_name			;
			 string3 	exec23_suffix					;
			 string2 	exec23_mrc_title_code	;
			 string30 exec23_title					;
			 string30 exec23_vanity_title		;
			 string13 exec24_first_name			;
			 string1 	exec24_middle_initial	;
			 string15 exec24_last_name			;
			 string3 	exec24_suffix					;
			 string2 	exec24_mrc_title_code	;
			 string30 exec24_title					;
			 string30 exec24_vanity_title		;
			 string13 exec25_first_name			;
			 string1 	exec25_middle_initial	;
			 string15 exec25_last_name			;
			 string3 	exec25_suffix					;
			 string2 	exec25_mrc_title_code	;
			 string30 exec25_title					;
			 string30 exec25_vanity_title		;
			 string13 exec26_first_name			;
			 string1 	exec26_middle_initial	;
			 string15 exec26_last_name			;
			 string3 	exec26_suffix					;
			 string2 	exec26_mrc_title_code	;
			 string30 exec26_title					;
			 string30 exec26_vanity_title		;
			 string13 exec27_first_name			;
			 string1 	exec27_middle_initial	;
			 string15 exec27_last_name			;
			 string3 	exec27_suffix					;
			 string2 	exec27_mrc_title_code	;
			 string30 exec27_title					;
			 string30 exec27_vanity_title		;
			 string13 exec28_first_name			;
			 string1 	exec28_middle_initial	;
			 string15 exec28_last_name			;
			 string3 	exec28_suffix					;
			 string2 	exec28_mrc_title_code	;
			 string30 exec28_title					;
			 string30 exec28_vanity_title		;
			 string13 exec29_first_name			;
			 string1 	exec29_middle_initial	;
			 string15 exec29_last_name			;
			 string3 	exec29_suffix					;
			 string2 	exec29_mrc_title_code	;
			 string30 exec29_title					;
			 string30 exec29_vanity_title		;
			 string13 exec30_first_name			;
			 string1 	exec30_middle_initial	;
			 string15 exec30_last_name			;
			 string3 	exec30_suffix					;
			 string2 	exec30_mrc_title_code	;
			 string30 exec30_title					;
			 string30 exec30_vanity_title		;

			 string30 internal_use1;
			 string10 internal_use2;
			 string1 internal_use3;
			 string1 hot_list_new_indicator;
			 string1 hot_list_ownership_change_indicator;
			 string1 hot_list_ceo_change_indicator;
			 string1 hot_list_company_name_change_ind;
			 string1 hot_list_address_change_indicator;
			 string1 hot_list_telephone_change_indicator;
			 string4 hot_list_new_change_date;
			 string4 hot_list_ownership_change_date;
			 string4 hot_list_ceo_change_date;
			 string4 hot_list_company_name_chg_date;
			 string4 hot_list_address_change_date;
			 string4 hot_list_telephone_change_date;
			 string6 report_date;
			 string1 delete_record_indicator;
		end;

		export Sprayed :=
		record,maxlength(10000)
			 string9              duns_number                                                                 ;
			 string90             business_name                                                               ;
			 string30             trade_style                                                                 ;
			 string25             Street                                                                      ;
			 string20             city                                                                        ;
			 string2              state                                                                       ;
			 string9              zip_code                                                                    ;
			 string17             mail_address                                                                ;
			 string14             mail_city                                                                   ;
			 string2              mail_state                                                                  ;
			 string5              mail_zip_code                                                               ;
			 string10             telephone_number                                                            ;
			 string21             County_Name                                                                 ;
			 string4              msa_code                                                                    ;
			 string40             msa_name                                                                    ;
			 string128            line_of_business_description                                                ;
			 lsic_codes						sic_codes[30]																																;
			 string1              industry_group                                                              ;
			 string4              year_started                                                                ;
			 string10             date_of_incorporation                                                       ;
			 string2              state_of_incorporation_abbr                                                 ;
			 string15             annual_sales_volume                                                         ;
			 string1              annual_sales_code                                                           ;
			 string10             employees_here                                                              ;
			 string10             employees_total                                                             ;
			 string1              employees_here_code                                                         ;
			 string1              internal_use                                                                ;
			 string10             annual_sales_revision_date                                                  ;
			 string12             net_worth                                                                   ;
			 string15             trend_sales                                                                 ;
			 string10             trend_employment_total                                                     ;
			 string15             base_sales                                                                  ;
			 string10             base_employment_total                                                       ;
			 string4              percentage_sales_growth                                                     ;
			 string4              percentage_employment_growth                                                ;
			 string9              square_footage                                                              ;
			 string1              sals_territory                                                              ;
			 string1              owns_rents                                                                  ;
			 string9              number_of_accounts                                                          ;
			 string9              bank_duns_number                                                            ;
			 string30             bank_name                                                                   ;
			 string30             accounting_firm_name                                                        ;
			 string1              small_business_indicator                                                    ;
			 string1              minority_owned                                                              ;
			 string1              cottage_indicator                                                           ;
			 string1              foreign_owned                                                               ;
			 string1              manufacturing_here_indicator                                                ;
			 string1              public_indicator                                                            ;
			 string1              importer_exporter_indicator                                                 ;
			 string1              structure_type                                                              ;
			 string1              type_of_establishment                                                       ;
			 string9              parent_duns_number                                                          ;
			 string9              ultimate_duns_number                                                        ;
			 string9              headquarters_duns_number                                                    ;
			 string30             parent_company_name                                                         ;
			 string30             ultimate_company_name                                                       ;
			 string9              dias_code                                                                   ;
			 string3              hierarchy_code                                                              ;
			 string1              ultimate_indicator                                                          ;
			 lexec_names					exec_names[30]																															;
			 string30             internal_use1                                                               ;
			 string10             internal_use2                                                               ;
			 string1              internal_use3                                                               ;
			 string1              hot_list_new_indicator                                                      ;
			 string1              hot_list_ownership_change_indicator                                         ;
			 string1              hot_list_ceo_change_indicator                                               ;
			 string1              hot_list_company_name_change_ind                                            ;
			 string1              hot_list_address_change_indicator                                           ;
			 string1              hot_list_telephone_change_indicator                                         ;
			 string4              hot_list_new_change_date                                                    ;
			 string4              hot_list_ownership_change_date                                              ;
			 string4              hot_list_ceo_change_date                                                    ;
			 string4              hot_list_company_name_chg_date                                              ;
			 string4              hot_list_address_change_date                                                ;
			 string4              hot_list_telephone_change_date                                              ;
			 string6              report_date                                                                 ;
			 string1              delete_record_indicator                                                     ;
			 string1              lf                                                                          ;
		end;

		export Sprayed2 := Sprayed - lf;
		export Sprayed3 := Sprayed2 - sic_codes - exec_names;

		export SprayedSign :=
		record
			 string9              duns_number                                                                 ;
			 string90             business_name                                                               ;
			 string30             trade_style                                                                 ;
			 string25             Street                                                                      ;
			 string20             city                                                                        ;
			 string2              state                                                                       ;
			 string9              zip_code                                                                    ;
			 string17             mail_address                                                                ;
			 string14             mail_city                                                                   ;
			 string2              mail_state                                                                  ;
			 string5              mail_zip_code                                                               ;
			 string10             telephone_number                                                            ;
			 string21             County_Name                                                                 ;
			 string4              msa_code                                                                    ;
			 string40             msa_name                                                                    ;
			 string128            line_of_business_description                                                ;
			 lsic_codes						sic_codes[30]																																;
			 string1              industry_group                                                              ;
			 string4              year_started                                                                ;
			 string8	            date_of_incorporation                                                       ;
			 string2              state_of_incorporation_abbr                                                 ;
			 string1   						annual_sales_volume_sign																										;
			 string15             annual_sales_volume                                                         ;
			 string1              annual_sales_code                                                           ;
			 string1   						employees_here_sign																													; 
			 string10             employees_here                                                              ;
			 string1   						employees_total_sign																												;
			 string10             employees_total                                                             ;
			 string1              employees_here_code                                                         ;
			 string1              internal_use                                                                ;
			 string8              annual_sales_revision_date                                                  ;
			 string1   						net_worth_sign																															; 
			 string12             net_worth                                                                   ;
			 string1   						trend_sales_sign																														;
			 string15             trend_sales                                                                 ;
			 string1   						trend_employment_total_sign																									;
			 string10             trend_employment_total                                                     ;
			 string1   						base_sales_sign																															;
			 string15             base_sales                                                                  ;
			 string1   						base_employment_total_sign																									; 
			 string10             base_employment_total                                                       ;
			 string1  						percentage_sales_growth_sign																								;
			 string4              percentage_sales_growth                                                     ;
			 string1   						percentage_employment_growth_sign																						;
			 string4              percentage_employment_growth                                                ;
			 string9              square_footage                                                              ;
			 string1              sals_territory                                                              ;
			 string1              owns_rents                                                                  ;
			 string9              number_of_accounts                                                          ;
			 string9              bank_duns_number                                                            ;
			 string30             bank_name                                                                   ;
			 string30             accounting_firm_name                                                        ;
			 string1              small_business_indicator                                                    ;
			 string1              minority_owned                                                              ;
			 string1              cottage_indicator                                                           ;
			 string1              foreign_owned                                                               ;
			 string1              manufacturing_here_indicator                                                ;
			 string1              public_indicator                                                            ;
			 string1              importer_exporter_indicator                                                 ;
			 string1              structure_type                                                              ;
			 string1              type_of_establishment                                                       ;
			 string9              parent_duns_number                                                          ;
			 string9              ultimate_duns_number                                                        ;
			 string9              headquarters_duns_number                                                    ;
			 string30             parent_company_name                                                         ;
			 string30             ultimate_company_name                                                       ;
			 string9              dias_code                                                                   ;
			 string3              hierarchy_code                                                              ;
			 string1              ultimate_indicator                                                          ;
			 lexec_names					exec_names[30]																															;
			 string30             internal_use1                                                               ;
			 string10             internal_use2                                                               ;
			 string1              internal_use3                                                               ;
			 string1              hot_list_new_indicator                                                      ;
			 string1              hot_list_ownership_change_indicator                                         ;
			 string1              hot_list_ceo_change_indicator                                               ;
			 string1              hot_list_company_name_change_ind                                            ;
			 string1              hot_list_address_change_indicator                                           ;
			 string1              hot_list_telephone_change_indicator                                         ;
			 string6              hot_list_new_change_date                                                    ;
			 string6              hot_list_ownership_change_date                                              ;
			 string6              hot_list_ceo_change_date                                                    ;
			 string6              hot_list_company_name_chg_date                                              ;
			 string6              hot_list_address_change_date                                                ;
			 string6              hot_list_telephone_change_date                                              ;
			 string8              report_date                                                                 ;
			 string1              delete_record_indicator                                                     ;
			 string1              lf                                                                          ;
		end;

		export SprayedSignFlat :=
		record
			 string9              duns_number                                                                 ;
			 string90             Business_Name                                                               ;
			 string30             trade_style                                                                 ;
			 string25             street                                                                      ;
			 string20             city                                                                        ;
			 string2              state                                                                       ;
			 string9              zip_code                                                                    ;
			 string17             mail_address                                                                ;
			 string14             Mail_City                                                                   ;
			 string2              Mail_State                                                                  ;
			 string5              Mail_Zip_Code                                                               ;
			 string10             telephone_number                                                            ;
			 string21             county_name                                                                 ;
			 string4              msa_code                                                                    ;
			 string40             msa_name                                                                    ;
			 string128            line_of_business_description                                                ;
			 string8              Sic1                                                                        ;
			 string60             sic1desc                                                                    ;
			 string8              sic1a                                                                       ;
			 string60             sic1adesc                                                                   ;
			 string8              sic1b                                                                       ;
			 string60             sic1bdesc                                                                   ;
			 string8              sic1c                                                                       ;
			 string60             sic1cdesc                                                                   ;
			 string8              sic1d                                                                       ;
			 string60             sic1ddesc                                                                   ;
			 string8              Sic2                                                                        ;
			 string60             sic2desc                                                                    ;
			 string8              sic2a                                                                       ;
			 string60             sic2adesc                                                                   ;
			 string8              sic2b                                                                       ;
			 string60             sic2bdesc                                                                   ;
			 string8              sic2c                                                                       ;
			 string60             sic2cdesc                                                                   ;
			 string8              sic2d                                                                       ;
			 string60             sic2ddesc                                                                   ;
			 string8              Sic3                                                                        ;
			 string60             sic3desc                                                                    ;
			 string8              sic3a                                                                       ;
			 string60             sic3adesc                                                                   ;
			 string8              sic3b                                                                       ;
			 string60             sic3bdesc                                                                   ;
			 string8              sic3c                                                                       ;
			 string60             sic3cdesc                                                                   ;
			 string8              sic3d                                                                       ;
			 string60             sic3ddesc                                                                   ;
			 string8              Sic4                                                                        ;
			 string60             sic4desc                                                                    ;
			 string8              sic4a                                                                       ;
			 string60             sic4adesc                                                                   ;
			 string8              sic4b                                                                       ;
			 string60             sic4bdesc                                                                   ;
			 string8              sic4c                                                                       ;
			 string60             sic4cdesc                                                                   ;
			 string8              sic4d                                                                       ;
			 string60             sic4ddesc                                                                   ;
			 string8              Sic5                                                                        ;
			 string60             sic5desc                                                                    ;
			 string8              sic5a                                                                       ;
			 string60             sic5adesc                                                                   ;
			 string8              sic5b                                                                       ;
			 string60             sic5bdesc                                                                   ;
			 string8              sic5c                                                                       ;
			 string60             sic5cdesc                                                                   ;
			 string8              sic5d                                                                       ;
			 string60             sic5ddesc                                                                   ;
			 string8              Sic6                                                                        ;
			 string60             sic6desc                                                                    ;
			 string8              sic6a                                                                       ;
			 string60             sic6adesc                                                                   ;
			 string8              sic6b                                                                       ;
			 string60             sic6bdesc                                                                   ;
			 string8              sic6c                                                                       ;
			 string60             sic6cdesc                                                                   ;
			 string8              sic6d                                                                       ;
			 string60             sic6ddesc                                                                   ;
			 string1              industry_group                                                              ;
			 string4              YEAR_STARTED                                                                ;
			 string8              date_of_incorporation                                                       ;
			 string2              state_of_incorporation_abbr                                                 ;
			 string1              annual_sales_volume_sign                                                    ;
			 string15             annual_sales_volume                                                         ;
			 string1              annual_sales_code                                                           ;
			 string1              employees_here_sign                                                         ;
			 string10             employees_here                                                              ;
			 string1              employees_total_sign                                                        ;
			 string10             employees_total                                                             ;
			 string1              employees_here_code                                                         ;
			 string1              internal_use                                                                ;
			 string8              annual_sales_revision_date                                                  ;
			 string1              net_worth_sign                                                              ;
			 string12             net_worth                                                                   ;
			 string1              trend_sales_sign                                                            ;
			 string15             trend_sales                                                                 ;
			 string1              trend_employment_total_sign                                                 ;
			 string10             trend_employment_total                                                     ;
			 string1              base_sales_sign                                                             ;
			 string15             base_sales                                                                  ;
			 string1              base_employment_total_sign                                                  ;
			 string10             base_employment_total                                                       ;
			 string1              percentage_sales_growth_sign                                                ;
			 string4              percentage_sales_growth                                                     ;
			 string1              percentage_employment_growth_sign                                           ;
			 string4              percentage_employment_growth                                                ;
			 string9              square_footage                                                              ;
			 string1              sals_territory                                                              ;
			 string1              owns_rents                                                                  ;
			 string9              number_of_accounts                                                          ;
			 string9              bank_duns_number                                                            ;
			 string30             bank_name                                                                   ;
			 string30             accounting_firm_name                                                        ;
			 string1              small_business_indicator                                                    ;
			 string1              minority_owned                                                              ;
			 string1              cottage_indicator                                                           ;
			 string1              foreign_owned                                                               ;
			 string1              manufacturing_here_indicator                                                ;
			 string1              public_indicator                                                            ;
			 string1              importer_exporter_indicator                                                 ;
			 string1              structure_type                                                              ;
			 string1              type_of_establishment                                                       ;
			 string9              parent_duns_number                                                          ;
			 string9              ultimate_duns_number                                                        ;
			 string9              headquarters_duns_number                                                    ;
			 string30             parent_company_name                                                         ;
			 string30             ultimate_company_name                                                       ;
			 string9              dias_code                                                                   ;
			 string3              hierarchy_code                                                              ;
			 string1              ultimate_indicator                                                          ;
			 string30             internal_use1                                                               ;
			 string10             internal_use2                                                               ;
			 string1              internal_use3                                                               ;
			 string1              hot_list_new_indicator                                                      ;
			 string1              hot_list_ownership_change_indicator                                         ;
			 string1              hot_list_ceo_change_indicator                                               ;
			 string1              hot_list_company_name_change_ind                                            ;
			 string1              hot_list_address_change_indicator                                           ;
			 string1              hot_list_telephone_change_indicator                                         ;
			 string6              hot_list_new_change_date                                                    ;
			 string6              hot_list_ownership_change_date                                              ;
			 string6              hot_list_ceo_change_date                                                    ;
			 string6              hot_list_company_name_chg_date                                              ;
			 string6              hot_list_address_change_date                                                ;
			 string6              hot_list_telephone_change_date                                              ;
			 string8              report_date                                                                 ;
			 string1              delete_record_indicator                                                     ;
		end;

		export FlattenedWONames :=
		record
			 string9 duns_number;
			 string90 business_name;
			 string30 trade_style;
			 string25 street;
			 string20 city;
			 string2 state;
			 string9 zip_code;
			 string17 mail_address;
			 string14 mail_city;
			 string2 mail_state;
			 string5 mail_zip_code;
			 string10 telephone_number;
			 string21 county_name;
			 string4 msa_code;
			 string40 msa_name;
			 string128 line_of_business_description;
			 string8 sic1;
			 string60 sic1desc;
			 string8 sic1a;
			 string60 sic1adesc;
			 string8 sic1b;
			 string60 sic1bdesc;
			 string8 sic1c;
			 string60 sic1cdesc;
			 string8 sic1d;
			 string60 sic1ddesc;
			 string8 sic2;
			 string60 sic2desc;
			 string8 sic2a;
			 string60 sic2adesc;
			 string8 sic2b;
			 string60 sic2bdesc;
			 string8 sic2c;
			 string60 sic2cdesc;
			 string8 sic2d;
			 string60 sic2ddesc;
			 string8 sic3;
			 string60 sic3desc;
			 string8 sic3a;
			 string60 sic3adesc;
			 string8 sic3b;
			 string60 sic3bdesc;
			 string8 sic3c;
			 string60 sic3cdesc;
			 string8 sic3d;
			 string60 sic3ddesc;
			 string8 sic4;
			 string60 sic4desc;
			 string8 sic4a;
			 string60 sic4adesc;
			 string8 sic4b;
			 string60 sic4bdesc;
			 string8 sic4c;
			 string60 sic4cdesc;
			 string8 sic4d;
			 string60 sic4ddesc;
			 string8 sic5;
			 string60 sic5desc;
			 string8 sic5a;
			 string60 sic5adesc;
			 string8 sic5b;
			 string60 sic5bdesc;
			 string8 sic5c;
			 string60 sic5cdesc;
			 string8 sic5d;
			 string60 sic5ddesc;
			 string8 sic6;
			 string60 sic6desc;
			 string8 sic6a;
			 string60 sic6adesc;
			 string8 sic6b;
			 string60 sic6bdesc;
			 string8 sic6c;
			 string60 sic6cdesc;
			 string8 sic6d;
			 string60 sic6ddesc;
			 string1 industry_group;
			 string4 year_started;
			 string10 date_of_incorporation;
			 string2 state_of_incorporation_abbr;
			 string15 annual_sales_volume;
			 string1 annual_sales_code;
			 string10 employees_here;
			 string10 employees_total;
			 string1 employees_here_code;
			 string1 internal_use;
			 string10 annual_sales_revision_date;
			 string12 net_worth;
			 string15 trend_sales;
			 string10 trend_employment_total;
			 string15 base_sales;
			 string10 base_employment_total;
			 string4 percentage_sales_growth;
			 string4 percentage_employment_growth;
			 string9 square_footage;
			 string1 sals_territory;
			 string1 owns_rents;
			 string9 number_of_accounts;
			 string9 bank_duns_number;
			 string30 bank_name;
			 string30 accounting_firm_name;
			 string1 small_business_indicator;
			 string1 minority_owned;
			 string1 cottage_indicator;
			 string1 foreign_owned;
			 string1 manufacturing_here_indicator;
			 string1 public_indicator;
			 string1 importer_exporter_indicator;
			 string1 structure_type;
			 string1 type_of_establishment;
			 string9 parent_duns_number;
			 string9 ultimate_duns_number;
			 string9 headquarters_duns_number;
			 string30 parent_company_name;
			 string30 ultimate_company_name;
			 string9 dias_code;
			 string3 hierarchy_code;
			 string1 ultimate_indicator;
			 string30 internal_use1;
			 string10 internal_use2;
			 string1 internal_use3;
			 string1 hot_list_new_indicator;
			 string1 hot_list_ownership_change_indicator;
			 string1 hot_list_ceo_change_indicator;
			 string1 hot_list_company_name_change_ind;
			 string1 hot_list_address_change_indicator;
			 string1 hot_list_telephone_change_indicator;
			 string4 hot_list_new_change_date;
			 string4 hot_list_ownership_change_date;
			 string4 hot_list_ceo_change_date;
			 string4 hot_list_company_name_chg_date;
			 string4 hot_list_address_change_date;
			 string4 hot_list_telephone_change_date;
			 string6 report_date;
			 string1 delete_record_indicator;
		end;
		
		export contacts := 
		record

			 string9              duns_number             ;
			 string90             business_name           ;
			 lexec_names																	;
			 string8              report_date             ;
			 string1              delete_record_indicator ;

		end;
	
		export oldcompanies :=
		record

			string8   													date_first_seen		;
			string8   													date_last_seen		;
			FlattenedWONames															;
			Address.Layout_Clean182_fips				clean_mail_address;
			Address.Layout_Clean182_fips				clean_address			;
			string1   													lf								;
			string															__filename 				{ virtual(logicalfilename)};
		
		end;
		
		export oldcontacts :=
		record

			string8   													date_first_seen					;
			string8   													date_last_seen					;
			string9              								duns_number       			;
			string90            								company_name    				;
			lexec_names																									;
			Address.Layout_Clean_Name						clean_name							;
			string1              								delete_record_indicator ;
			string1   													lf											; 
			string															__filename							 { virtual(logicalfilename)};
		
		end;


	end;
	
	export Base :=
	module
	
		// Jira# CCPA-93, The below layout with 2 new fields are added for CCPA (California Consumer Protection Act) project.
		// The Orbit infrastructure is not available yet, so leaving unpopulated for now.
		export CCPA_fields := 
		record
			unsigned4 													global_sid 		:= 0;
			unsigned8 													record_sid 		:= 0;
		end;
	
		export CompaniesChild := 
		record

			unsigned6														rid								;
			unsigned6														bdid							;
			unsigned1														bdid_score				;
			unsigned4   												date_first_seen		;
			unsigned4   												date_last_seen		;
			unsigned4   												date_vendor_first_reported	;
			unsigned4   												date_vendor_last_reported		;
			input.sprayedsign - lf - exec_names	rawfields					;
			Address.Layout_Clean182_fips				clean_mail_address;
			Address.Layout_Clean182_fips				clean_address			;
			unsigned1  													record_type				; //CHOOSE(c,'UNKNOWN','Unchanged','Updated','Old','New');
			string1  														active_duns_number; // 'Y' Active Duns Number
																															// 'N' Inactive Duns Number (deleted)
			unsigned8 													mail_rawaid 	:= 0;
			unsigned8 													mail_aceaid 	:= 0;
			unsigned8 													rawaid 				:= 0;
			unsigned8 													aceaid 				:= 0;
			CCPA_fields;
		end;    

		export Companies := 
		record

			unsigned6														rid								;
			unsigned6														bdid							;
			unsigned1														bdid_score				;
			unsigned4   												date_first_seen		;
			unsigned4   												date_last_seen		;
			unsigned4   												date_vendor_first_reported	;
			unsigned4   												date_vendor_last_reported		;
			input.sprayedsignflat								rawfields					;
			Address.Layout_Clean182_fips				clean_mail_address;
			Address.Layout_Clean182_fips				clean_address			;
			unsigned1  													record_type				; //CHOOSE(c,'UNKNOWN','Unchanged','Updated','Old','New');
			string1  														active_duns_number; // 'Y' Active Duns Number
																													// 'N' Inactive Duns Number (deleted)
			unsigned8 													mail_rawaid 	:= 0;
			unsigned8 													mail_aceaid 	:= 0;
			unsigned8 													rawaid 				:= 0;
			unsigned8 													aceaid 				:= 0;
			CCPA_fields;
		end;   
		
		export CompaniesForBIP2 := 
		record

			unsigned6														rid								;
			unsigned6														bdid							;
			unsigned1														bdid_score				;
			unsigned4   												date_first_seen		;
			unsigned4   												date_last_seen		;
			unsigned4   												date_vendor_first_reported	;
			unsigned4   												date_vendor_last_reported		;
			input.sprayedsignflat								rawfields					;
			Address.Layout_Clean182_fips				clean_mail_address;
			Address.Layout_Clean182_fips				clean_address			;
			unsigned1  													record_type				; //CHOOSE(c,'UNKNOWN','Unchanged','Updated','Old','New');
			string1  														active_duns_number; // 'Y' Active Duns Number
																													// 'N' Inactive Duns Number (deleted)
			unsigned8 													mail_rawaid 	:= 0;
			unsigned8 													mail_aceaid 	:= 0;
			unsigned8 													rawaid 				:= 0;
			unsigned8 													aceaid 				:= 0;
			BIPV2.IDlayouts.l_xlink_ids;
			CCPA_fields;
		end;  		

		export Companies_ForStrata := 
		record

			unsigned6														rid								;
			unsigned6														bdid							;
			unsigned1														bdid_score				;
			unsigned4   												date_first_seen		;
			unsigned4   												date_last_seen		;
			unsigned4   												date_vendor_first_reported	;
			unsigned4   												date_vendor_last_reported		;
			input.sprayedsignflat								rawfields					;
			Address.Layout_Clean182_fips				clean_mail_address;
			Address.Layout_Clean182_fips				clean_address			;
			string15  													record_type				; //CHOOSE(c,'UNKNOWN','Unchanged','Updated','Old','New');
			string1  														active_duns_number; // 'Y' Active Duns Number
																													// 'N' Inactive Duns Number (deleted)
			unsigned8 													mail_rawaid 	:= 0;
			unsigned8 													mail_aceaid 	:= 0;
			unsigned8 													rawaid 				:= 0;
			unsigned8 													aceaid 				:= 0;
			BIPV2.IDlayouts.l_xlink_ids;
			CCPA_fields;
		end;    

		export Companies_prev := 
		record

			unsigned6														bdid							;
			string8   													date_first_seen		;
			string8   													date_last_seen		;
			input.sprayedsignflat								rawfields					;
			Address.Layout_Clean182_fips				clean_mail_address;
			Address.Layout_Clean182_fips				clean_address			;
			string1   													record_type				; // 'C' Current or 'H' Historical
			string1  														active_duns_number; // 'Y' Active Duns Number
																															// 'N' Inactive Duns Number (deleted)
			CCPA_fields;																					
		end;    
		
		export Contacts := 
		record

			unsigned6												rid												;
			unsigned6 											did									:= 0	;
			unsigned6 											bdid								:= 0	;
			unsigned4  											date_first_seen						;
			unsigned4  											date_last_seen						;
			unsigned4   										date_vendor_first_reported	;
			unsigned4   										date_vendor_last_reported		;
			string9  												duns_number								;
			input.lexec_names								rawfields									;
			Address.Layout_Clean_Name				clean_name								;
			string90												company_name 				:= ''	;
			Address.Layout_Clean182_fips		clean_company_address			;
			string10												company_phone10 		:= ''	;
			unsigned1  											record_type								; 
			unsigned1  											company_record_type				; 
			string1  												active_duns_number				; // 'Y' Active Duns Number
																																	// 'N' Inactive Duns Number (deleted)
			unsigned8 											rawaid 							:= 0	;
			unsigned8 											aceaid 							:= 0	;
			CCPA_fields;
		end;                                                		

		export Contacts_forstrata := 
		record

			unsigned6												rid												;
			unsigned6 											did									:= 0	;
			unsigned6 											bdid								:= 0	;
			unsigned4  											date_first_seen						;
			unsigned4  											date_last_seen						;
			unsigned4   										date_vendor_first_reported	;
			unsigned4   										date_vendor_last_reported		;
			string9  												duns_number								;
			input.lexec_names								rawfields									;
			Address.Layout_Clean_Name				clean_name								;
			string90												company_name 				:= ''	;
			Address.Layout_Clean182_fips		clean_company_address			;
			string10												company_phone10 		:= ''	;
			string15  											record_type								; 
			string15  											company_record_type				; 
			string1  												active_duns_number				; // 'Y' Active Duns Number
																																	// 'N' Inactive Duns Number (deleted)
			unsigned8 											rawaid 							:= 0	;
			unsigned8 											aceaid 							:= 0	;
			CCPA_fields;
		end;                                                		

		shared lcleanaddr := Address.Layout_Clean182_fips - 
	cr_sort_sz		
- lot						
- lot_order			
- dbpc					
- chk_digit			
- rec_type	
- geo_blk		
- geo_match	
- err_stat	
- cart
		;
		
		export Contacts_prev := 
		record

			unsigned6												did									:= 0	;
			unsigned6												bdid								:= 0	;
			string8													date_first_seen						;
			string8 												date_last_seen						;
			string9 												duns_number								;
			input.lexec_names								rawfields									;
			Address.Layout_Clean_Name				clean_name								;
			string90												company_name				:= ''	;
			lcleanaddr											clean_company_address			;
			string10												company_phone10 		:= ''	;
			string1   											record_type								; // 'C' Current or 'H' Historical
			string1  												active_duns_number				; // 'Y' Active Duns Number
																																	// 'N' Inactive Duns Number (deleted)
			CCPA_fields;
		end;                                                		

		export CompaniesSPC := 
		record

			unsigned6														rid								;
			unsigned6														bdid							;
			string8   													date_first_seen		;
			string8   													date_last_seen		;
			unsigned4   												date_vendor_first_reported	;
			unsigned4   												date_vendor_last_reported		;
			input.sprayedsignflat								rawfields					;
		end;    

		export ContactsSPC := 
		record

			unsigned6 											rid									:= 0	;
			unsigned6 											did									:= 0	;
			unsigned6 											bdid								:= 0	;
			string8  												date_first_seen						;
			string8  												date_last_seen						;
			unsigned4   										date_vendor_first_reported	;
			unsigned4   										date_vendor_last_reported		;
			string9  												duns_number								;
			input.lexec_names								rawfields									;
			string90												company_name 				:= ''	;
			Address.Layout_Clean182_fips		clean_company_address			;
			string10												company_phone10 		:= ''	;
		end;                                                		
		

/*	
	export Keybuild :=
	record

		string2   									source										;
		unsigned6 									did												;
		unsigned1 									did_score									;
		unsigned6 									bdid											;
		unsigned1 									bdid_score								;
		unsigned4  									dt_first_seen							;
		unsigned4  									dt_last_seen							;
		string40  									vendor_id									;

		Address.Layout_Clean_Name		subject_name							;
		Address.Layout_Clean_Slim		subject_address						;
		unsigned5  									subject_phone							;
		unsigned4  									subject_ssn								;
		unsigned4  									subject_dob								;
		string35  									subject_job_title					;
		unsigned8 									subject_rawaid 				:= 0;
		unsigned8 									subject_aceaid 				:= 0;

		string120  									company_name							;
		Address.Layout_Clean_Slim		company_address						;
		unsigned5  									company_phone							;
		unsigned4  									company_fein							;
		unsigned8										company_rawaid				:= 0;
		unsigned8										company_aceaid				:= 0;

		utilraw											rawfields									;
*/
	end;                                                		

	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temporary :=
	module
	  export DidSlim := 
	  record
			unsigned8		unique_id				;
			string20 		fname						;
			string20 		mname						;
			string20 		lname						;
			string5  		name_suffix		  ;
			string10  	prim_range			;
			string28		prim_name				;
			string8			sec_range			 	;
			string5			zip5						;
			string2			state						;
			string10		phone						;
			string8			dob							;
			string9			ssn							;
			unsigned6		did					:= 0;
			unsigned1		did_score		:= 0;
	  end;

	  export BdidSlim := 
	  record
			unsigned6		unique_id					;
			string100 	company_name			;
			string10  	prim_range				;
			string28		prim_name					;
			string5			zip5							;
			string8			sec_range					;
			string2			state		 					;
			string10		phone		  		    ;
			string9			fein		  		    ;
			string34		source_group	    ;
			unsigned6		bdid					:= 0;
			unsigned1		bdid_score		:= 0;
			BIPV2.IDlayouts.l_xlink_ids;
	  end;
		
		export SlimWithContacts := 
			record
				BdidSlim;
				string20 fname;
				string20 mname;
				string20 lname;		
				string2  source;
				unsigned6 rid;
			end;					
		
	  export UniqueId := 
		record
 		  unsigned8		unique_id	;
		  Base.Companies				;
		end;

		export aid_prep :=
		record
		
			string			mail_address1		;
			string			mail_address2		;
			string			address1				;
			string			address2				;
			Base.companies							;
		
		end;
		export Layout_DNB_autokey := record
				unsigned6 bdid := 0;
				string9   duns_number :='';
				string90  business_name :='';
				string10  telephone_number :='';
				standard.Addr_Slim;
			end;

		export layout_autokey := record
			Layout_DNB_autokey;
			unsigned1 zero := 0;
			string1 blank := '';
			Base.CCPA_fields;
		end;
		
		export AppendCompanyInfo :=
		record
			base.contacts;
			unsigned4  	company_date_first_seen						;
			unsigned4  	company_date_last_seen						;
		end;
	end;

	EXPORT DUNS_2_Ultimate_DUNS :=
	RECORD
		UNSIGNED4 duns_number;
		UNSIGNED4 ultimate_duns_number;
	END;
	
end;