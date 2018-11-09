EXPORT Spray_AZ (dataset({string ftype,string fdate})infile) := module

import VersionControl,_Control,lib_thorlib;
//spray dentists

	string		pServer			              :=  _Control.IPAddress.bctlpedata11  ;
	 
																 
	string		pDir(string ltype)				:= map ( ltype = 'acupuncturist'  => '/data/hds_4/prolic/az/acupuncturists/'+infile(ftype = 'acupuncturist')[1].fdate,
	                                             ltype = 'osteopath' => '/data/hds_4/prolic/az/osteopathic/'+infile(ftype = 'osteopath')[1].fdate,
																               ltype = 'pharmacy' => '/data/hds_4/prolic/az/pharmacy/'+infile(ftype = 'pharmacy')[1].fdate,
																							                        '/data/hds_4/prolic/az/nurses/'+infile(ftype = 'nurse')[1].fdate
																             );
	                               
	string		pGroupName	             := thorlib.group();
	boolean    pIsTesting              := false;

 string filedt(string pkeyword)           := map ( pkeyword = 'acupuncturist'  => infile(ftype = 'acupuncturist')[1].fdate,
	                                             pkeyword = 'osteopath'      => infile(ftype = 'osteopath')[1].fdate,
																               pkeyword = 'pharmacy'       => infile(ftype = 'pharmacy')[1].fdate,
																							                              infile(ftype = 'nurse')[1].fdate
																             );


	lfile(string pkeyword,string filedate) := '~thor_data400::in::prolic::az::' + pkeyword + filedate+'.raw';
	sfile(string pkeyword) := '~thor_data400::in::prolic::az::' + pkeyword +'::raw';

	spry_acupunture_raw:=DATASET([

		 {pServer,pDir('acupuncturist'),'*.csv' 			,0 ,lfile('acupuncturist'	,filedt('acupuncturist')			),[{sfile('acupuncturist'			)}],pGroupName,'','[0-9]{12}','VARIABLE','','','','','"'}
	
		 	], VersionControl.Layout_Sprays.Info);
			
			
	spry_osteopath_raw:=DATASET([

		 {pServer,pDir('osteopath'),'*.csv' 			,0 ,lfile('osteopath',filedt('osteopath')				),[{sfile('osteopath'			)}],pGroupName,'','[0-9]{12}','VARIABLE'}
		  	], VersionControl.Layout_Sprays.Info);
				
	spry_pharmacy_raw:=DATASET([

		 {pServer,pDir('pharmacy'),'*.csv' 			,0 ,lfile('pharmacy',filedt('pharmacy')				),[{sfile('pharmacy'			)}],pGroupName,'','[0-9]{12}','VARIABLE'}
		  	], VersionControl.Layout_Sprays.Info);
				
	spry_nurse_raw:=DATASET([

		 {pServer,pDir('nurse'),'*.CSV' 			,0 ,lfile('nurse',filedt('nurse')				),[{sfile('nurse'			)}],pGroupName,'','[0-9]{12}','VARIABLE','','','','','"'}
		  	], VersionControl.Layout_Sprays.Info);
				
				
export dospray :=  Sequential( if ( count(infile(ftype = 'acupuncturist')) = 1  , VersionControl.fSprayInputFiles(spry_acupunture_raw,pIsTesting := pIsTesting,pShouldClearSuperfileFirst	:= true)),
	                                if (     count(infile(ftype = 'osteopath')) = 1  , VersionControl.fSprayInputFiles(spry_osteopath_raw,pIsTesting := pIsTesting,pShouldClearSuperfileFirst	:= true)),
	                                if (     count(infile(ftype = 'pharmacy')) = 1  , VersionControl.fSprayInputFiles(spry_pharmacy_raw,pIsTesting := pIsTesting,pShouldClearSuperfileFirst	:= true)),
																		if (	count(infile(ftype = 'nurse')) = 1  , VersionControl.fSprayInputFiles(spry_nurse_raw,pIsTesting := pIsTesting,pShouldClearSuperfileFirst	:= true)),

                                        Output('All_AZ_Files_Sprayed')
																			
													);																																														
																																																											
																																																		
	end;																																																		
