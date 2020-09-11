import STD,ut,lib_fileservices,VersionControl,dops;
EXPORT Enclarity_as_Ingenix_false := module
#option('multiplePersistInstances',FALSE) ;



EnclarityDate 		:= dops.GetBuildVersion('EnclarityKeys','B','N','C'); // boca, non-FCRA,production

IngenixDt 		:= dops.GetBuildVersion('IngenixKeys','B','N','C'); // cert

output(EnclarityDate,named('Enclarity_Cert_Date'));
output(IngenixDt,named('Ingenix_Cert_Date'));




string filedate := if ( Ingenix_NatlProf.DaysApart (EnclarityDate[1..8],IngenixDt[1..8]) > 0 , EnclarityDate , ut.getDateOffset( 1 , IngenixDt[1..8]) ) ;

output(filedate,named('Ingenix_Keybuild_date'));

boolean pUseProd  :=  true;


v_chk := if( EnclarityDate <> IngenixDt , true,false);



Mac_Ingenix_Monthly_Spray_Build(EnclarityDate,' ', filedate, pUseProd, pout, false);

export  run_chk := map ( 
													
													v_chk = true  =>   Sequential(FileServices.SendEmail('Sudhir.Kasavajjala@lexisnexis.com; kevin.reeder@lexisnexis.com','Ingenix Build status '+STD.Date.Today(),'Enclarity build version is newer than prod version and therefore Ingenix Build will be started'),
									               
                                                                           pout),
																																						
																															  Sequential(
									                                                          output('Enclarity build version is in sync with prod version'),
															                                               FileServices.SendEmail('Sudhir.Kasavajjala@lexisnexis.com; kevin.reeder@lexisnexis.com','Ingenix Build status '+STD.Date.Today(),'Enclarity build version is in sync with prod version and therefore Ingenix Build will be on hold'))
															 
																																						
											    
						);
						
end;
						

