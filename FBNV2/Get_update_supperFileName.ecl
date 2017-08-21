import FBNV2 ;

export Get_Update_SupperFilename(string updatetype)  := 


	map(updatetype='San_Diego'=>Filenames().San_diego_newupdate,
	updatetype='Ventura'=>Filenames().Ventura_newupdate,
	updatetype='Orange'=>Filenames().orange_newupdate,
	updatetype='San_Bernardino'=>Filenames().San_Bernardinoupdate,
	updatetype='Santa_Clara'=>Filenames().Santa_Clara_newupdate,
	updatetype='Dallas'=>Filenames().Dallasupdate,
	updatetype='Harris'=>Filenames().Harris_newupdate,
	updatetype='Filing'=>Filenames().Filing_newupdate,
	updatetype='Event'=>Filenames().Event_newupdate,
	updatetype='NYC'=>Filenames().NYCupdate,
	updatetype='InfoUSA'=>Filenames().infoUSAupdate,						
	'');
	
	