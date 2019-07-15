IMPORT  doxie;

EXPORT keys := MODULE

	df_phones_ported_metadata	:=  project(Files.phones_ported_metadata_base, Layouts.layout_phones_ported_metadata_base_in);   
	export key_phones_ported_metadata	:= index(df_phones_ported_metadata
																				,{phone}
																				,{df_phones_ported_metadata}
																				,Constants.KeyName_phones_ported_metadata + doxie.Version_SuperKey);


	df_carrier_reference	:=  Files.carrier_reference_base;   
	export key_carrier_reference	:= index(df_carrier_reference
																				,{ocn,name}
																				,{df_carrier_reference}
																				,Constants.KeyName_carrier_reference + doxie.Version_SuperKey);

df_Lerg6Main	:=  Files.Lerg6Main;   
	export key_Lerg6Main	:= index(df_Lerg6Main
	                                    ,{npa, nxx, block_id}
																	    ,{df_Lerg6Main}
																			,Constants.KeyName_lerg6 + doxie.Version_SuperKey);


END;
