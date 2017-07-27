IMPORT Data_Services, DEA, doxie;

df := DEA.File_DEAv2(Dea_Registration_Number != '');

full_layout := RECORD
	DEA.Layout_DEA_In_Modified;
	STRING18 county_name := '';
	STRING12 did;
	STRING3  score;
	STRING9  best_ssn;
	STRING12 bdid;
END;

df_proj := PROJECT(df, TRANSFORM(full_layout, SELF.name_score := ''; SELF.score := ''; SELF := LEFT;));

EXPORT Key_dea_reg_num := INDEX(df_proj,
				                        {Dea_Registration_Number},
				                        {df_proj},
                                Data_Services.Data_location.Prefix('DEA') + 'thor_data400::key::dea::' +
																	 doxie.Version_SuperKey + '::reg_num');


