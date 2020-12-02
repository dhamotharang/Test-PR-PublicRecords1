import ut,header,STD;

EXPORT Mod_Despray(string version,string ip,string rootDir) := MODULE
	
	suffix:=version[1..8]+'_'+workunit[11..16]+'.dat';
	drqFname:='~nac::out::xx_drq_'+suffix;
	curr_month:=version[1..6];
	
	drqFile:=Files().Base(  header.convertyyyymmtonumberofmonths((integer)curr_month)
													- header.convertyyyymmtonumberofmonths((integer)case_benefit_month) < 3 );

	out_drq_file:=SEQUENTIAL(
								 FileServices.StartSuperFileTransaction()
								,FileServices.ClearSuperFile('~nac::out::drq_father',true)
								,FileServices.AddSuperFile('~nac::out::drq_father','~nac::out::drq',,true)
								,FileServices.FinishSuperFileTransaction()
								,FileServices.ClearSuperFile('~nac::out::drq')
								,OUTPUT(PROJECT(drqFile,Layouts.load),,drqFname,compressed)
								,FileServices.AddSuperFile('~nac::out::drq', drqFname)
								);

despray_drq := FUNCTION	
	prefix:= 'XX_DRQ_';				 
	dir:= 'drq/';
	fname:= prefix + suffix;
	pThorFilename:='~nac::out::'+fname;
	pDestinationFile:= rootDir + trim(dir) + trim(fname);
	RETURN FileServices.Despray(pThorFilename,ip,pDestinationFile,,,,TRUE);
END;

EXPORT Odespray:=SEQUENTIAL(
				out_drq_file
				,despray_drq	
				);

END;

