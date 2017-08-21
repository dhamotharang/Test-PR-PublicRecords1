export Key_Easi_Current_Census := index(Common.File_Census,
		{GEOLINK},			// key
		{Common.File_Census},	// payload	
		Cluster + 'key::easi::qa::' + 'current_census');
