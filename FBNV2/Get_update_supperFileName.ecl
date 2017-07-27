import FBNV2 ;

export Get_Update_SupperFilename(string updatetype)  := 

map(updatetype='San_diego'=>Filenames().San_diegoupdate,
	updatetype='Ventura'=>Filenames().Venturaupdate,
	updatetype='Orange'=>Filenames().orangeupdate,
	updatetype='San_Bernardino'=>Filenames().San_Bernardinoupdate,
	updatetype='Santa_Clara'=>Filenames().Santa_Claraupdate,
	updatetype='Dallas'=>Filenames().Dallasupdate,
	updatetype='Harris'=>Filenames().Harrisupdate,
	updatetype='Filing'=>Filenames().Filingupdate,
	updatetype='Event'=>Filenames().Eventupdate,
	updatetype='NYC'=>Filenames().NYCupdate,
	updatetype='InfoUSA'=>Filenames().infoUSAupdate,						
	'');