IMPORT ut,Data_Services,_control,data_services, dops, wk_ut;

EXPORT Proc_Copy_To_Alpha(string pversion) := FUNCTION

	flagFileName 	:= 'thor_data400::flag::personHeader::boca::hhid_copy_';
	createFlagFile := output(dataset([{pversion}],{string9 version}),,'~'+flagFileName,overwrite);

	lfn1 := 'thor_data400::base::hhid_'+pversion;
	lfn2 := 'thor_data400::key::header::hhid::'+pversion+'::did.ver';
	lfn3 := 'thor_data400::key::header::hhid::'+pversion+'::hhid.ver';
	lfn4 := 'thor400_44::base::hss_household_'+pversion;
	lfn5 := 'thor_data400::key::header::'+pversion+'::hhid';
	lfn6 := flagFileName;
                        
	string srcesp       := _control.IPAddress.prod_thor_esp;
	string destesp      := _control.IPAddress.aprod_thor_esp;
	string srcdali      := _control.IPAddress.prod_thor_dali;
	string destdali     := _control.IPAddress.aprod_thor_dali;
	string destcluster  := 'thor400_112';
	set of string insrccluster := ['thor400_44'];
	string filepattern := '';
	dataset(dops.Layout_filelist) ds := dataset([{lfn1, ''}, {lfn2, ''}, {lfn3, ''}, {lfn4, ''}, {lfn5, ''}, {lfn6, ''}],dops.Layout_filelist);
	string dstSubNameSuffix := '';
	string uniquearbitrarystring := 'Header_hhid_files';
	boolean copywithsoap   := false;
	boolean usecredentials := true;

	ECL := '\n'
		+'#WORKUNIT(\'name\',\'Copy hhid files to Alpha\');\n'
		+'#WORKUNIT(\'protect\',true);\n\n'
		+'import Dops;\n\n'
        +'set of string insrccluster := [\'thor400_44\'];\n\n'
        +'boolean copywithsoap   := false;\n\n'
        +'boolean usecredentials := true;\n\n'
        +'dataset(dops.Layout_filelist) ds := dataset([{\'' + lfn1 + '\', \'\'}, {\'' + lfn2 + '\', \'\'}, {\'' + lfn3 + '\', \'\'}, {\'' + lfn4 + '\', \'\'}, {\'' + lfn5 + '\', \'\'}, {\'' + lfn6 + '\', \'\'}],dops.Layout_filelist);\n\n'
		+'Dops.CopyFiles(\'' + srcesp + '\',\'' + destesp + '\',\'' + srcdali + '\',\'' + destdali + '\',\'' + destcluster + '\', insrccluster,\'' +  filepattern + '\',ds,\'' +  dstSubNameSuffix + '\',\'' + uniquearbitrarystring + '\',copywithsoap,usecredentials).Run;\n\n';
		
	return sequential(				
		createFlagFile,
		wk_ut.CreateWuid(ECL,'hthor',wk_ut._constants.ProdEsp)
	);

end;
