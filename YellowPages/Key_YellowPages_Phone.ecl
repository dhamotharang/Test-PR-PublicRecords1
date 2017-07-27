import doxie;

df := YellowPages.File_Keybuild(phone10 != '');

export Key_YellowPages_Phone := 
		index(	df,
				{phone10},
				{business_name, prim_range, prim_name, sec_range, zip, geo_lat, geo_long},
				Keynames().Phone.qa);

