import FBNV2 ;

export Get_Input_Superfilename(string sourcetype)  := 

	map(sourcetype='San_Diego'=>Filenames().San_diego_raw,
			sourcetype='Ventura'=>Filenames().Ventura_raw,
			sourcetype='Orange'=>Filenames().Orange_raw,
			sourcetype='Santa_Clara'=>Filenames().Santa_Clara_raw,
			sourcetype='Harris'=>Filenames().Harris_raw,
			sourcetype='Filing'=>Filenames().Filing_raw,
			sourcetype='Event'=>Filenames().Event_raw,						
			'');
