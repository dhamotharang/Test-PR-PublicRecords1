import liensv2 ;

export Get_Upadte_SuperFilename(string updatetype)  := 

map(updatetype = 'federal' => liensv2.Filenames().federalupdate,
	    updatetype = 'Okclien' => LiensV2.Filenames().okclienupdate,
		updatetype = 'ServAbs' => LiensV2.Filenames().ServAbsupdate,
		updatetype = 'BusDtor' => LiensV2.Filenames().BusDtorupdate,
		updatetype = 'BusSecp' => LiensV2.Filenames().BusSecpupdate,
		updatetype = 'PerDtor' => LiensV2.Filenames().PerDtorupdate,
		updatetype = 'PerSecp' => LiensV2.Filenames().PerSecpupdate,
		updatetype = 'filings' => LiensV2.Filenames().filingsupdate,
		updatetype = 'chgfilg' => LiensV2.Filenames().chgfilgupdate,
		updatetype = 'judgmts' => LiensV2.Filenames().judgmtsupdate,
		updatetype = 'crdatty' => LiensV2.Filenames().crdattyupdate,
        updatetype = 'credtor' => LiensV2.Filenames().credtorupdate,
        updatetype = 'detatty' => LiensV2.Filenames().detattyupdate,
        updatetype = 'debtorn' => LiensV2.Filenames().debtornupdate,
        updatetype = 'judment' => LiensV2.Filenames().judmentupdate,
        updatetype = 'subjdmt' => LiensV2.Filenames().subjdmtupdate,
        updatetype = 'remarks' => LiensV2.Filenames().remarksupdate,					
		'');