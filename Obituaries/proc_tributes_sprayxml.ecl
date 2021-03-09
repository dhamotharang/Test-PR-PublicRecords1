IMPORT _Control;


EXPORT proc_tributes_sprayxml(string filedate) := module
shared		inpath		:= '/data/hds_4/death_master/in/newspaper/';
shared		maxRecordSize	:=	8000;
shared		filename  := 'lexisnexis_newspaper_weekly*.xml';		
shared		groupname := _Constants().groupname;
shared		srcFileName := inpath + fileName;
shared		spFileName_xml  := '~thor_data400::raw::tributes_newspaper_'+filedate+'_xml';
shared		spFileName      := '~thor_data400::raw::tributes_newspaper_'+filedate;
shared		superfile_xml   := '~thor_data400::raw::tributes_newspaper_xml';
shared		superfile       := '~thor_data400::raw::tributes_newspaper';

clear_super_xml
	:=
		IF(FileServices.SuperFileExists(superfile_xml)
			,FileServices.ClearSuperFile(superfile_xml)
			,FileServices.CreateSuperFile(superfile_xml)
			);

clear_super
	:=
		IF(FileServices.SuperFileExists(superfile)
			,FileServices.ClearSuperFile(superfile)
			,FileServices.CreateSuperFile(superfile)
			);	
	
spray_xml := 	FileServices.SprayXml(
									_Control.IPAddress.bctlpedata10
									,srcFileName
									,maxRecordSize
									,'Object'
									,
									,groupname
									,spFileName_xml
									,
									,
									,
									,true
									,true
									,false
									);
			
super_xml	
	:=	
	SEQUENTIAL(
             FileServices.StartSuperFileTransaction(),
						 FileServices.AddSuperFile(superfile_xml,spFileName_xml),
						 FileServices.FinishSuperFileTransaction()
	);
	
xform_all := output(files.newspaper_raw_xml, ,spFileName, csv(SEPARATOR(','),quote('"'),TERMINATOR('\n')),overwrite);

super_all	
	:=	
	SEQUENTIAL(
             FileServices.StartSuperFileTransaction(),
						 FileServices.ClearSuperFile(superfile),
						 FileServices.AddSuperFile(superfile,spFileName),
						 FileServices.FinishSuperFileTransaction()
	);
	
export sprayfiles := SEQUENTIAL(
																clear_super_xml
																,clear_super
																,spray_xml
																,super_xml
																,xform_all
																,super_all);
																			
	end;
	
