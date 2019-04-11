import ut, _control, Orbit3, Scrubs, Scrubs_IRS5500;

export proc_Spray_Build_all(string filedate, string pFormYear) := function

	// Spray source file (now a csv file vs. a fixed file)
	groupname := IF(_Control.ThisEnvironment.name	 = 'Dataland', 'thor40_241', 'thor400_44');
	
	sprayfile := FileServices.SprayVariable( _Control.IPAddress.bctlpedata11,      																			// source IP
																					'/data/prod_data_build_10/production_data/business_headers/irs/form_5500/data/' +
																						filedate + '/f_5500_' + pFormYear + '_all.csv',													  // source Path
																					,                          																									// max record size
																					,                                																						// field separator
																					'\\n,\\r\\n',                                																// record terminator
																					'"',              	                																				// quoted field delimiter
																					groupName, 																																	// cluster (destination group)
																					'~thor_data400::in::irs::' + filedate + '::f5500', 													// logical filename on thor
																					,                                																						// timeout value
																					,                                																						// esp info
																					,                                																						// max connections
																					TRUE,         																															// overwrite
																					,        																																		// replicate
																					TRUE       																																	// compress
																			 );

	//Superfile Transactions
	superfile_transac := sequential(fileservices.addsuperfile('~thor_data400::in::irs::sprayed::delete::f5500','~thor_data400::in::irs::sprayed::grandfather::f5500',,true),
																	fileservices.clearsuperfile('~thor_data400::in::irs::sprayed::grandfather::f5500'),
																	fileservices.addsuperfile('~thor_data400::in::irs::sprayed::grandfather::f5500','~thor_data400::in::irs::sprayed::father::f5500',,true),
																	fileservices.clearsuperfile('~thor_data400::in::irs::sprayed::father::f5500'),
																	fileservices.addsuperfile('~thor_data400::in::irs::sprayed::father::f5500','~thor_data400::in::irs::sprayed::f5500',,true),
																	fileservices.clearsuperfile('~thor_data400::in::irs::sprayed::f5500'),
																	fileservices.addsuperfile('~thor_data400::in::irs::sprayed::f5500','~thor_data400::in::irs::'+filedate+'::f5500'),
																	fileservices.clearsuperfile('~thor_data400::in::irs::sprayed::delete::f5500',true)
																	);		

	// Thor Build
	doBuild      := irs5500.proc_Build_All(filedate, pFormYear).All;

	//Create Sample New Records for QA
	sampleRecs   := IRS5500.SampleRecsQA; 

	orbit_update := Orbit3.proc_Orbit3_CreateBuild ('IRS 5500',filedate,'N');

	ScrubReport  := Scrubs.ScrubsPlus('IRS5500','Scrubs_IRS5500','Scrubs_IRS5500_Raw','Raw' ,filedate, IRS5500.Email_Notificaton_Lists.Scrubs,false);

	retval       := sequential(sprayfile, superfile_transac, ScrubReport, doBuild, sampleRecs, orbit_update);

	return retval;

end;	