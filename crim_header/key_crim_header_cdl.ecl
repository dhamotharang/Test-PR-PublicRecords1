import doxie;

df := file_crim_header;

export key_crim_header_cdl := 
		index(df,{unsigned6 i_cdl := cdl},{df},'~thor_data400::key::crim_header_cdl_' + doxie.Version_SuperKey);
