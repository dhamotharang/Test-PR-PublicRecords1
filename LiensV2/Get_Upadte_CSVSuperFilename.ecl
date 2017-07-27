import liensv2,ut ;

export Get_Upadte_CSVSuperFilename(string updatetype)  := 

map(updatetype = 'DisJmts' => liensv2.CSVFilenames().DisJmtsupdate,
	    updatetype = 'FSTLien' => LiensV2.CSVFilenames().FSTLienupdate,
		updatetype = 'FSTrles' => LiensV2.CSVFilenames().FSTrlesupdate,
		updatetype = 'SatJmts' => LiensV2.CSVFilenames().SatJmtsupdate,
		updatetype = 'SubJmts' => LiensV2.CSVFilenames().SubJmtsupdate,
		updatetype = 'VacJmts' => LiensV2.CSVFilenames().VacJmtsupdate,
		updatetype = 'judgmts' => LiensV2.CSVFilenames().judgmtsupdate,
		updatetype = 'childsupportlien' => LiensV2.CSVFilenames().MAChildSupport,
		updatetype = 'welflien' => LiensV2.CSVFilenames().MAwelflien,
		updatetype = 'writs' => LiensV2.CSVFilenames().MAWrit,
		updatetype = 'writsname' => LiensV2.CSVFilenames().MAWritName,
								
		'');

