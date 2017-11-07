import UCCV2,_control;

export Spray_Input_Files (string filename,string filedate,string gname,string source,string sourcetype,string SuppressionFileName = '') 
:= function

sourceCaps	:=	StringLib.StringToUpperCase(source);
// sourceip := _control.IPAddress.edata10;
sourceip := _control.IPAddress.bctlpedata10;
insource := if(regexfind('from_cp',filename),source+'_from_cp',source);
superfilenameProcessed := if (sourcetype='UCC' or sourceCaps='WA','~thor_data400::in::uccv2::'+source+'::processed',
										'~thor_data400::in::uccv2::'+source+'::'+sourcetype+'::processed');

superfilename := if (sourcetype='UCC' or sourceCaps='WA','~thor_data400::in::uccv2::'+source,
										'~thor_data400::in::uccv2::'+source+'::'+sourcetype);
logicalfilename := if (sourcetype='UCC','~thor_data400::in::uccv2::'+filedate+'::'+insource,
										'~thor_data400::in::uccv2::'+filedate+'::'+insource+'::'+sourcetype);
										
SuppressLogical := '~thor_data400::in::uccv2::'+filedate+'::'+ source + '::suppression';

SuppressSuper		:= '~thor_data400::in::uccv2::'+ source + '::suppression';


reclength := UCCV2.Get_Record_Length(source,sourcetype);

spray_file := map(sourceCaps in ['US_DNB','IL','NY_NEW_YORK','TX','MA'] =>	FileServices.SprayVariable(sourceip,filename,,'\\,',,,gname,logicalfilename,-1,,,true,false),
									sourceCaps='CA'		=>	FileServices.SprayVariable(sourceip,filename,100000,'\\,',,,gname,logicalfilename,-1,,,true,false),
									sourceCaps='WA'		=>	FileServices.SprayXML(sourceip,filename,100000,'Document',,gname,logicalfilename,-1,,,true,false),
									FileServices.SprayFixed(sourceip,filename, reclength,gname,logicalfilename,-1,,,true,false)
									);
									
spray_suppression :=	FileServices.SprayVariable(sourceip,SuppressionFileName,,'\\,',,,gname,SuppressLogical,-1,,,true,false);
				 
add_super := 	fileservices.addsuperfile(superfilename,logicalfilename);
												
add_super_processed := fileservices.addsuperfile(superfilenameprocessed,logicalfilename);

clear_Suppression_Super := 	fileservices.clearsuperfile(SuppressSuper);
add_Suppression_Super := 	fileservices.addsuperfile(SuppressSuper,SuppressLogical);

check_xml := if(source='wa' and FileServices.GetSuperFileSubCount( '~thor_data400::in::uccV2::'+insource )<>0,
	            fail('ERROR -- WA UCC XML FILE ALREADY IN SUPERFILE - MUST ONLY BE ONE; PLEASE INVESTIGATE.'));
										
retval := if (fileservices.superfileexists(superfilename),
							sequential(output('Superfilename: ' + superfilename),
												 output('Logicalfilename: ' + logicalfilename),
												 output('Record Length: ' + reclength),
												 output('Archive superfileName: ' + superfilenameProcessed),
												 //check_xml,
												 spray_file
												 ,add_super,add_super_processed
												 ,if(	sourceCaps='WA',
															sequential(
																				clear_Suppression_Super,
																				if (trim(stringlib.StringToUppercase(SuppressionFileName))<>'', 
																									sequential(	spray_suppression
																															,add_Suppression_Super)
																						)
																				)
														)
												 ),
							output(superfilename + ' does not exist')
							)
					
					: Success(FileServices.SendEmail('christopher.brodeur@lexisnexisrisk.com, randy.reyes@lexisnexisrisk.com, intel357@bellsouth.net', 'UCC - Spray Complete', thorlib.wuid())),
	          Failure(FileServices.SendEmail('christopher.brodeur@lexisnexisrisk.com, randy.reyes@lexisnexisrisk.com, intel357@bellsouth.net', 'UCC - Spray Failure', thorlib.wuid() + '\n' + FAILMESSAGE));

return retval;


end;