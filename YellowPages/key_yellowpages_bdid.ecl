import doxie;

df := YellowPages.File_Keybuild;

export key_YellowPages_BDID := 
		index(	df(bdid != 0),
				{bdid},
				{df},
				Keynames().Bdid.qa);
 