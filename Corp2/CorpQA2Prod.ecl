IMPORT STD;

EXPORT CorpQA2Prod( STRING previousVersion ) := FUNCTION    

RETURN SEQUENTIAL(
					PARALLEL(
										STD.File.ClearSuperFile('~thor_data400::base::corp2::prod::corp_xtnd'),
										STD.File.ClearSuperFile('~thor_data400::base::corp2::prod::cont_xtnd'),
										STD.File.ClearSuperFile('~thor_data400::base::corp2::prod::stock_xtnd'),
										STD.File.ClearSuperFile('~thor_data400::base::corp2::prod::event_xtnd'),
										STD.File.ClearSuperFile('~thor_data400::base::corp2::prod::ar_xtnd')
									),
					PARALLEL(
										STD.File.AddSuperFile('~thor_data400::base::corp2::prod::corp_xtnd',	'~thor_data400::base::corp2::' + previousVersion +'::corp_xtnd'),
										STD.File.AddSuperFile('~thor_data400::base::corp2::prod::cont_xtnd',	'~thor_data400::base::corp2::' + previousVersion +'::cont_xtnd'),
										STD.File.AddSuperFile('~thor_data400::base::corp2::prod::stock_xtnd',	'~thor_data400::base::corp2::' + previousVersion +'::stock_xtnd'),
										STD.File.AddSuperFile('~thor_data400::base::corp2::prod::event_xtnd',	'~thor_data400::base::corp2::' + previousVersion +'::event_xtnd'),
										STD.File.AddSuperFile('~thor_data400::base::corp2::prod::ar_xtnd',		'~thor_data400::base::corp2::' + previousVersion +'::ar_xtnd')
									)
								);  
								
END;