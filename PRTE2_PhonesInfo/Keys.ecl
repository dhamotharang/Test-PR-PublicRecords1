IMPORT  doxie;

EXPORT keys := MODULE

	
	df_trans	:=  Files.trans_base;   
	
	export key_trans	:= index(df_trans
																				,{phone}
																				,{df_trans}
																				,Constants.KeyName_trans + doxie.Version_SuperKey);


  df_type	:=  Files.type_base;   
	
	export key_type	:= index(df_type
																				,{phone}
																				,{df_type}
																				,Constants.KeyName_type + doxie.Version_SuperKey);

END;
