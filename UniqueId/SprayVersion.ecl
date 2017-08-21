import _control,STD;
EXPORT SprayVersion(string	pFileDate)	:=
function
	//Spray Raw File
/*	sprayEntityFile		:=	STD.File.SprayXml(	_control.IPAddress.edata12,
																								'/data_999/sanctions/bridger/in/'+pFileDate+'/MasterListEntityConverted.xml',
																								32768,
																								'Entity',,
																								'thor40_241',
																								'~thor::in::uniqueid::entity::'	+	pFileDate
																								,,,,true,false,false
																							);
	
	sprayCountryFile	:=	STD.File.SprayXml(	_control.IPAddress.edata12,
																								'/data_999/sanctions/bridger/in/'+pFileDate+'/MasterListCountryConverted.xml',
																								32768,
																								'Country',,
																								'thor40_241',
																								'~thor::in::uniqueid::country::'	+	pFileDate
																								,,,,true,false,false
																							);*/
	sprayEntityFile		:=	STD.File.SprayXml(	_control.IPAddress.bctlpedata10,
																								'/data/hds_3/uniqueid/input/'+pFileDate+'/MasterListEntityConverted.xml',
																								32768,
																								'Entity',,
																								'thor400_44',
																								'~thor::in::uniqueid::entity::'	+	pFileDate
																								,,,,true,false,false
																							);
	
	sprayCountryFile	:=	STD.File.SprayXml(	 _control.IPAddress.bctlpedata10,
																								'/data/hds_3/uniqueid/input/'+pFileDate+'/MasterListCountryConverted.xml',
																								32768,
																								'Country',,
																								'thor400_44',
																								'~thor::in::uniqueid::country::'	+	pFileDate
																								,,,,true,false,false
																							);
	
	sprayFile	:=	parallel(sprayEntityFile,sprayCountryFile);
	
	sfname := '~thor::in::uniqueid::entity';
	sfcountry := '~thor::in::uniqueid::country';
	
	addSuper	:=	sequential(	STD.File.StartSuperFileTransaction(),
														STD.File.ClearSuperFile(sfname),
														STD.File.AddSuperFile(sfname,'~thor::in::uniqueid::entity::'	+	pFileDate),
														STD.File.ClearSuperFile(sfcountry),
														STD.File.AddSuperFile(sfcountry,'~thor::in::uniqueid::country::'	+	pFileDate),
														STD.File.FinishSuperFileTransaction()
													);
	

	return SEQUENTIAL(
					sprayFile,
					IF(NOT STD.File.SuperFileExists(sfname), STD.File.CreateSuperFile(sfname)),
					IF(NOT STD.File.SuperFileExists(sfcountry), STD.File.CreateSuperFile(sfcountry)),
					AddSuper);
END;