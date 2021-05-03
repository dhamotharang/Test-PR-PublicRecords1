IMPORT ALC, VersionControl;

EXPORT fSpray(STRING	pVersion              				= '',
							BOOLEAN	pUseProd											= FALSE,
							STRING	pServerIP											= ALC._Dataset().IPAddress,
							STRING	pDirectory										= '/data/hds_4/ALC/data/' + pVersion,
							STRING	pPilotsFilename								= '*389*',
							STRING	pLawyersFilename							= '*390*',
							STRING	pInsuranceAgentsFilename			= '*392*',
							STRING	pProfessionals1Filename				= '*394a1*',
							STRING	pProfessionals2Filename				= '*394a2*',
							STRING	pProfessionals3Filename				= '*394a3*',
							STRING	pAccountantsFilename					= '*394b*',
							STRING	pDentalProfessionalsFilename	= '*394c*',
							STRING	pPharmacistsFilename					= '*394d*',
							STRING	pNurses1Filename							= '*394e1*',
							STRING	pNurses2Filename							= '*394e2*',
							STRING	pNurses3Filename							= '*394e3*',
							STRING	pNurses4Filename							= '*394e4*'
							
) :=
  DATASET([
					 {pServerIP
					 ,pDirectory
					 ,pPilotsFilename
					 ,0
					 ,ALC.Filenames(pVersion).Pilots_lInputTemplate
					 ,[{ALC.Filenames().Pilots_lInputTemplate}]
					 ,ALC._Dataset().groupname
					 ,pVersion
					 ,''
					 ,'VARIABLE'
					 ,''
					 ,ALC._Dataset().max_record_size
					 ,
					 },

					 {pServerIP
					 ,pDirectory
					 ,pLawyersFilename
					 ,0
					 ,ALC.Filenames(pVersion).Lawyers_lInputTemplate
					 ,[{ALC.Filenames().Lawyers_lInputTemplate}]
					 ,ALC._Dataset().groupname
					 ,pVersion
					 ,''
					 ,'VARIABLE'
					 ,''
					 ,ALC._Dataset().max_record_size
					 ,
					 },

					 {pServerIP
					 ,pDirectory
					 ,pInsuranceAgentsFilename
					 ,0
					 ,ALC.Filenames(pVersion).Insurance_Agents_lInputTemplate
					 ,[{ALC.Filenames().Insurance_Agents_lInputTemplate}]
					 ,ALC._Dataset().groupname
					 ,pVersion
					 ,''
					 ,'VARIABLE'
					 ,''
					 ,ALC._Dataset().max_record_size
					 ,
					 },

					 {pServerIP
					 ,pDirectory
					 ,pProfessionals1Filename
					 ,0
					 ,ALC.Filenames(pVersion).Professionals1_lInputTemplate
					 ,[{ALC.Filenames().Professionals1_lInputTemplate}]
					 ,ALC._Dataset().groupname
					 ,pVersion
					 ,''
					 ,'VARIABLE'
					 ,''
					 ,ALC._Dataset().max_record_size
					 ,
					 },

					 {pServerIP
					 ,pDirectory
					 ,pProfessionals2Filename
					 ,0
					 ,ALC.Filenames(pVersion).Professionals2_lInputTemplate
					 ,[{ALC.Filenames().Professionals2_lInputTemplate}]
					 ,ALC._Dataset().groupname
					 ,pVersion
					 ,''
					 ,'VARIABLE'
					 ,''
					 ,ALC._Dataset().max_record_size
					 ,
					 },

					 {pServerIP
					 ,pDirectory
					 ,pProfessionals3Filename
					 ,0
					 ,ALC.Filenames(pVersion).Professionals3_lInputTemplate
					 ,[{ALC.Filenames().Professionals3_lInputTemplate}]
					 ,ALC._Dataset().groupname
					 ,pVersion
					 ,''
					 ,'VARIABLE'
					 ,''
					 ,ALC._Dataset().max_record_size
					 ,
					 },

					 {pServerIP
					 ,pDirectory
					 ,pAccountantsFilename
					 ,0
					 ,ALC.Filenames(pVersion).Accountants_lInputTemplate
					 ,[{ALC.Filenames().Accountants_lInputTemplate}]
					 ,ALC._Dataset().groupname
					 ,pVersion
					 ,''
					 ,'VARIABLE'
					 ,''
					 ,ALC._Dataset().max_record_size
					 ,
					 },

					 {pServerIP
					 ,pDirectory
					 ,pDentalProfessionalsFilename
					 ,0
					 ,ALC.Filenames(pVersion).Dental_Professionals_lInputTemplate
					 ,[{ALC.Filenames().Dental_Professionals_lInputTemplate}]
					 ,ALC._Dataset().groupname
					 ,pVersion
					 ,''
					 ,'VARIABLE'
					 ,''
					 ,ALC._Dataset().max_record_size
					 ,
					 },

					 {pServerIP
					 ,pDirectory
					 ,pPharmacistsFilename
					 ,0
					 ,ALC.Filenames(pVersion).Pharmacists_lInputTemplate
					 ,[{ALC.Filenames().Pharmacists_lInputTemplate}]
					 ,ALC._Dataset().groupname
					 ,pVersion
					 ,''
					 ,'VARIABLE'
					 ,''
					 ,ALC._Dataset().max_record_size
					 ,
					 },

					 {pServerIP
					 ,pDirectory
					 ,pNurses1Filename
					 ,0
					 ,ALC.Filenames(pVersion).Nurses1_lInputTemplate
					 ,[{ALC.Filenames().Nurses1_lInputTemplate}]
					 ,ALC._Dataset().groupname
					 ,pVersion
					 ,''
					 ,'VARIABLE'
					 ,''
					 ,ALC._Dataset().max_record_size
					 ,
					 },

					 {pServerIP
					 ,pDirectory
					 ,pNurses2Filename
					 ,0
					 ,ALC.Filenames(pVersion).Nurses2_lInputTemplate
					 ,[{ALC.Filenames().Nurses2_lInputTemplate}]
					 ,ALC._Dataset().groupname
					 ,pVersion
					 ,''
					 ,'VARIABLE'
					 ,''
					 ,ALC._Dataset().max_record_size
					 ,
					 },

					 {pServerIP
					 ,pDirectory
					 ,pNurses3Filename
					 ,0
					 ,ALC.Filenames(pVersion).Nurses3_lInputTemplate
					 ,[{ALC.Filenames().Nurses3_lInputTemplate}]
					 ,ALC._Dataset().groupname
					 ,pVersion
					 ,''
					 ,'VARIABLE'
					 ,''
					 ,ALC._Dataset().max_record_size
					 ,
					 },

						{pServerIP
					 ,pDirectory
					 ,pNurses4Filename
					 ,0
					 ,ALC.Filenames(pVersion).Nurses4_lInputTemplate
					 ,[{ALC.Filenames().Nurses4_lInputTemplate}]
					 ,ALC._Dataset().groupname
					 ,pVersion
					 ,''
					 ,'VARIABLE'
					 ,''
					 ,ALC._Dataset().max_record_size
					 ,
					 }


	        ], VersionControl.Layout_Sprays.Info);