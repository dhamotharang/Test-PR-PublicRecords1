import doxie;

df := YellowPages.File_Keybuild_Bid;

export key_YellowPages_BID := 
		index(	df(bdid != 0),
				{bdid},
				{df},
				Keynames().Bid.qa);
