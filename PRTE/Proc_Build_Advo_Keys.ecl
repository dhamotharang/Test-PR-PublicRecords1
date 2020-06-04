IMPORT 	_control,  PRTE_CSV,  advo,  std;
export Proc_Build_Advo_Keys (string pIndexVersion)	:=
function

	dKeyadvo__addr_search1					:= 	fileservices.copy('~thor_data400::key::advo::qa::addr_search1','thor400_36','~prte::key::advo::' + pIndexVersion + '::addr_search1',,,,,true,true);

	dKeyadvo__addr_search2 :=  	fileservices.copy('~thor_data400::key::advo::qa::addr_search2','thor400_36','~prte::key::advo::' + pIndexVersion + '::addr_search2',,,,,true,true);

 	dKeyadvo__addr_search1_history :=  	fileservices.copy('~thor_data400::key::advo::qa::addr_search1_history','thor400_36','~prte::key::advo::' + pIndexVersion + '::addr_search1_history',,,,,true,true);

	dKeyadvo__city :=   fileservices.copy('~thor_data400::key::advo::qa::city','thor400_36','~prte::key::advo::' + pIndexVersion + '::city',,,,,true,true);

  dKeyadvo__geolink :=   fileservices.copy('~thor_data400::key::advo::qa::geolink','thor400_36','~prte::key::advo::' + pIndexVersion + '::geolink',,,,,true,true);
	
  dKeyadvo__zip :=   fileservices.copy('~thor_data400::key::advo::qa::zip','thor400_36','~prte::key::advo::' + pIndexVersion + '::zip',,,,,true,true);
	
  dKeyhotlist__addr_search_state :=  fileservices.copy('~thor_data400::key::uspis_hotlist::qa::addr_search_state','thor400_36','~prte::key::uspis_hotlist::' + pIndexVersion + '::addr_search_state',,,,,true,true);
	
  dKeyhotlist__addr_search_zip :=  fileservices.copy('~thor_data400::key::uspis_hotlist::qa::addr_search_zip','thor400_36','~prte::key::uspis_hotlist::' + pIndexVersion + '::addr_search_zip',,,,,true,true);
	


	dKeyadvo__addr_search1_fcra :=  	STD.File.copy('~thor_data400::key::advo::fcra::qa::addr_search1','thor400_36','~prte::key::advo::fcra::' + pIndexVersion + '::addr_search1',,,,,true,true);

 	dKeyadvo__addr_search1_history_fcra :=  	STD.File.copy('~thor_data400::key::advo::fcra::qa::addr_search1_history','thor400_36','~prte::key::advo::fcra::' + pIndexVersion + '::addr_search1_history',,,,,true,true);
return	sequential(
											parallel(
																dKeyadvo__addr_search1,
																dKeyadvo__addr_search2,
																dKeyadvo__addr_search1_history,
																dKeyadvo__city,
																dKeyadvo__geolink,
																dKeyadvo__zip,
																dKeyhotlist__addr_search_state,
																dKeyhotlist__addr_search_zip,
																dKeyadvo__addr_search1_fcra,
																dKeyadvo__addr_search1_history_fcra																
															 ),
											PRTE.UpdateVersion('CDSKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 l_inloc:='B',												//	B = Boca, A = Alpharetta
																				 l_inenvment:='N',										//	N = Non-FCRA, F = FCRA
																				 l_includeboolean :='N'								//	N = Do not include boolean, Y = Include boolean, too
																				),
											 PRTE.UpdateVersion('FCRA_CDSKeys',										//	Package name
																				 pIndexVersion,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 l_inloc:='B',												//	B = Boca, A = Alpharetta
																				 l_inenvment:='F',										//	N = Non-FCRA, F = FCRA
																				 l_includeboolean :='N'								//	N = Do not include boolean, Y = Include boolean, too
																				)																	
										 );
end;

