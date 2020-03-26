IMPORT ut, roxiekeybuild, Orbit3;

EXPORT procBuildAll(STRING pFileDate = ut.GetDate) := FUNCTION

FileDate := pFileDate : INDEPENDENT;

Samples := SEQUENTIAL(
  output('InstantID Samples'),
  output(CHOOSEN(SORT(InstantID_Archiving.Files_Base_Batch.Key_Files, -date_added), 100));
  output(CHOOSEN(TABLE(InstantID_Archiving.Files_Base_Batch.Key_Files, {date_added[..8], COUNT(GROUP)}, date_added[..8], few), ALL)));
	

/*inrec := InstantID_Archiving.Layout_Base;
df_IID_rec := dataset('~thor_data400::base::instantid_archive::key_files::father', inrec, thor);
df_IID_new_rec := dataset('~thor_data400::base::instantid_archive::key_files', inrec, thor);


Updated_Samples := Sequential (
	Output('Updated InstantID Samples'),
	Output(join(df_IID_rec, df_IID_new_rec, left.transaction_id=right.transaction_id,right only)));*/


BuildKeyFile := SEQUENTIAL(
	OUTPUT(InstantID_Archiving.fnCreateBase(FileDate),, '~thor_data400::out::InstantID_Archive::' + FileDate + '::key_files', overwrite, __compressed__),
	FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::base::InstantID_Archive::key_files','~thor_data400::base::InstantID_Archive::key_files::father','~thor_data400::base::InstantID_Archive::key_files::grandfather'],
	'~thor_data400::out::InstantID_Archive::' + FileDate + '::key_files', true),
	
	OUTPUT(InstantID_Archiving.fnCreateBase_batch(FileDate),, '~thor_data400::out::InstantID_Archive::' + FileDate + '::key_batch_files', overwrite, __compressed__),
	FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::base::InstantID_Archive::key_batch_files','~thor_data400::base::InstantID_Archive::key_batch_files::father','~thor_data400::base::InstantID_Archive::key_batch_files::grandfather'],
		'~thor_data400::out::InstantID_Archive::' + FileDate + '::key_batch_files', true)
	);
	
	create_orbit_build:= Orbit3.proc_Orbit3_CreateBuild ('Instant ID Archiving',FileDate,'N');
	

RETURN SEQUENTIAL(
						instantid_archiving.fnSprayFiles(); 
						InstantID_Archiving.fnSprayFilesBatch();
						BuildKeyFile;
						InstantID_Archiving.Build_Base_Files;
						InstantID_Archiving.Build_Batch_Base_Files(filedate);
						InstantID_Archiving.procBuildKeys(filedate); 
						InstantID_Archiving.procBuildAutoKeys(filedate);
						//Samples;
						InstantID_Archiving.Updated_Samples;
						RoxieKeyBuild.updateversion('InstantIDArchiveKeys', FileDate, 'cecelie.reid@lexisnexis.com, wenhong.ma@lexisnexis.com, christopher.brodeur@lexisnexis.com, intel357@bellsouth.net, manuel.tarectecan@lexisnexis.com, randy.reyes@lexisnexis.com', , 'N');
						if(ut.Weekday((integer)filedate) <> 'SATURDAY' and ut.Weekday((integer)filedate) <> 'SUNDAY',
					  create_orbit_build,
					  output('No Orbit Entries Needed for weekend builds'));
						fileservices.sendemail('wenhong.ma@lexisnexis.com, christopher.brodeur@lexisnexis.com, cecelie.reid@lexisnexis.com, intel357@bellsouth.net, manuel.tarectecan@lexisnexis.com, randy.reyes@lexisnexis.com', 'InstantID Archiving Build Complete ' + WORKUNIT,WORKUNIT);
						);
END;