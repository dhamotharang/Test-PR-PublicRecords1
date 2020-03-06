import Property, ut, roxiekeybuild,Orbit_report, PromoteSupers;

export Foreclosure_Keys(string filedate) :=
function
	#option ('newWorkflow', true);
	#workunit('name','Foreclosure Build - ' + filedate);
	
	emails	:=	'dknowles@seisint.com;gwitz@seisint.com;kgummadi@seisint.com;melanie.jackson@lexisnexisrisk.com';
	PromoteSupers.MAC_SF_BuildProcess(property.Foreclosure_Clean_AID,'~thor_data400::in::foreclosure',build_clean,,,true);
	PromoteSupers.MAC_SF_BuildProcess(property.Foreclosure_DID,'~thor_data400::base::foreclosure',build_base,,,true );
  PromoteSupers.MAC_SF_BuildProcess(property.Foreclosure_normalized,'~thor_data400::base::foreclosure_normalized',build_normalized,,,true );	
	Orbit_report.Foreclosures_Stats(getretval);
	
	//Get current samples of both CL and BK data that include DID
	SampleForeclosure	:= CHOOSEN(property.file_foreclosure(deed_category = 'U' and process_date >= filedate AND (UNSIGNED)name1_did <> 0 AND source = 'FR'),50);
	SampleBKForeclosure	:= CHOOSEN(property.file_foreclosure(deed_category = 'U' and process_date >= filedate AND (UNSIGNED)name1_did <> 0 AND source = 'I5'),50);

	SampleNOD	:= CHOOSEN(property.file_foreclosure(deed_category = 'N' and process_date >= filedate AND (UNSIGNED)name1_did <> 0 AND source = 'FR'),50);
	SampleBKNOD	:= 	CHOOSEN(property.file_foreclosure(deed_category = 'N' and process_date >= filedate AND (UNSIGNED)name1_did <> 0 AND source = 'B7'),50);
	
	doSamples := sequential (output(SampleNOD + SampleBKNOD,,'~thor_data400::out::foreclosure::samples_NOD',overwrite,named('NOD_Key_Samples'))
													,output(SampleForeclosure + SampleBKForeclosure,,'~thor_data400::out::foreclosure::samples_FDATA',overwrite,named('Foreclosure_Data_Key_Samples')));
												
	return sequential(build_clean,
										build_base,
										build_normalized,
										property.coverage_foreclosure,
										/* property.Out_Moxie_Foreclosure_Keys, ---Depricated */
										Property.proc_build_forclosure_key(filedate),
										Property.proc_build_nod_key(filedate),
										RoxieKeyBuild.updateversion('ForeclosureKeys', filedate, emails,,'N'),
										RoxieKeyBuild.updateversion('ForeclosureKeys', filedate, emails,,'BN'),
										RoxieKeyBuild.updateversion('ForeclosureKeys',filedate,'Gavin.Witz@lexisnexis.com',,'N',,,'A'),
										Property.Proc_OrbitI_CreateBuild(filedate),
										Property.Foreclosure_Proc_Create_Relationships(filedate, emails),
										/* Property.DKC_Foreclosure_Keys, ---Depricated */
										doSamples,
										notify('Foreclosure BaseFile Complete','*'),
										//Property.Foreclosure_Stats_Metadata,
										//property.Out_Base_Dev_Stats(filedate),
										getretval
										);
end;