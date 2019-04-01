import FBNV2 ;

export Get_Input_Superfilename(string source)  := 

	map(source='SAN_DIEGO'=>Filenames().San_diego_raw,
			source='VENTURA'=>Filenames().Ventura_raw,
			source='ORANGE'=>Filenames().Orange_raw,
			source='SANTA_CLARA'=>Filenames().Santa_Clara_raw,
			source='HARRIS'=>Filenames().Harris_raw,
			source='FILING'=>Filenames().Filing_raw,
			source='EVENT'=>Filenames().Event_raw,						
			'');
