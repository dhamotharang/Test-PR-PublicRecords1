export Key_Easi_Current_Yr := index(Common.File_Current,
		{GEOLINK},			// key
		{Common.File_Current},	// payload	
		Cluster + 'key::easi::qa::' + 'current_yr');