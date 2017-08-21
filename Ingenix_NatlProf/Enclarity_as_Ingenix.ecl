import STD,lib_fileservices,VersionControl,dops;
EXPORT Enclarity_as_Ingenix(string IngenixDate,string forcetorun = 'N') := module
#option('multiplePersistInstances',FALSE) ;
#workunit('name', 'Yogurt:Enclarity as Ingenix Build');

EnclarityDate 		:= dops.GetBuildVersion('EnclarityKeys','B','N','C'); // boca, non-FCRA,production

IngenixDt 		:= dops.GetBuildVersion('IngenixKeys','B','N','C'); // cert

string filedate := if ( forcetorun = 'N',EnclarityDate, IngenixDate );

boolean pUseProd  :=  true;

output(EnclarityDate,named('Enclarity_Cert_Date'));
output(IngenixDt,named('Ingenix_Cert_Date'));


v_chk := if( EnclarityDate <> IngenixDt , true,false);


Mac_Ingenix_Monthly_Spray_Build(EnclarityDate, IngenixDate, filedate, pUseProd, pout, true);



export  run_chk := map ( 
													
													v_chk = true or forcetorun = 'Y' =>   Sequential(FileServices.SendEmail('Sudhir.Kasavajjala@lexisnexis.com; kevin.reeder@lexisnexis.com','Ingenix Build status '+STD.Date.Today(),'Enclarity build version is newer than prod version and therefore Ingenix Build will be started'),
									               
                                                                           pout),
																																						
																															   Sequential(
									                                                          output('Enclarity build version is in sync with prod version'),
															                                               FileServices.SendEmail('Sudhir.Kasavajjala@lexisnexis.com; kevin.reeder@lexisnexis.com','Ingenix Build status '+STD.Date.Today(),'Enclarity build version is in sync with prod version and therefore Ingenix Build will be on hold'))
																																						
											    
						);
						
end;
