import doxie;

df := YellowPages.File_Keybuild;

export Key_YellowPages_Addr := 
			index(df,
				{prim_range,	prim_name,		sec_range,	zip},
				{phone10,		business_name,	geo_lat,	geo_long},
				Keynames().Addr.qa);

