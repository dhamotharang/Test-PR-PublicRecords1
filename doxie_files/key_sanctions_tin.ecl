Import Data_Services, Ingenix_NatlProf, doxie, Data_Services, ut;

base_file := Ingenix_NatlProf.file_sanctions_cleaned_dided_dates(
								length(Stringlib.Stringfilterout(sanc_tin, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ-.^!$+<>@=%?*\''))=9, 
								sanc_tin NOT IN ['','000000000']);

	clean_base	:= DEDUP(base_file, RECORD, ALL, LOCAL);
	
export key_sanctions_tin := index(clean_base,
                                 {string9 s_sanc_tin := sanc_tin}, {did, sanc_id},
						   Data_Services.Data_Location.Prefix('Provider')+'thor_data400::key::ingenix_sanctions_tin_' + doxie.Version_SuperKey);
							 
							
						 