import corp2,jigsaw,spoke,zoom,one_click_data,teletrack,garnishments,POEsFromEmails,POEsFromUtilities,SalesChannel,thrive,Database_USA,DataBridge,OPM;

export Source_filenames :=
		corp2.Filenames							().Base_xtnd.Cont.dall_filenames
	+ corp2.Filenames							().Base_xtnd.Corp.dall_filenames
	//+	jigsaw.Filenames						().Base.dall_filenames    //*** Removed Jigsaw due to expiration of contract with the vendor -  as per Joe Lezcano
	+	spoke.Filenames							().Base.dall_filenames
	+	zoom.Filenames							().Base.dall_filenames
	+	one_click_data.Filenames		().Base.dall_filenames
	+	teletrack.Filenames					().Base.dall_filenames
	+	garnishments.Filenames			().Base.dall_filenames
	+	POEsFromEmails.Filenames		().Base.dall_filenames
	+	POEsFromUtilities.Filenames	().Base.dall_filenames
	+	SalesChannel.Filenames			().Base.dall_filenames
	+	Thrive.Filenames  					().Base.dall_filenames
	+	Database_USA.Filenames			().Base.dall_filenames
	+	DataBridge.Filenames				().Base.dall_filenames
	+ OPM.Filenames								().Base.dall_filenames
	;