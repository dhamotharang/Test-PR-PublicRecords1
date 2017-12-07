Import Data_Services, Ingenix_NatlProf, doxie, Data_Services, ut;

base_file := Ingenix_NatlProf.Basefile_Sanctions_Bdid(
								length(trim(Stringlib.Stringfilterout(sanc_tin, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ-.^!$+<>@=%?*\'')))=9, 
								sanc_tin NOT IN ['','000000000']);

slim_base	:= record
		base_file.sanc_tin;
		base_file.did;
		base_file.sanc_id;
end;

clean_base	:= DEDUP(project(base_file, slim_base), RECORD, ALL, LOCAL);
	
export key_sanctions_tin := index(clean_base,
                                 {string9 s_sanc_tin := sanc_tin}, {did, sanc_id},
						   Data_Services.Data_Location.Prefix('Provider')+'thor_data400::key::ingenix_sanctions_tin_' + doxie.Version_SuperKey);
							 
							
						 