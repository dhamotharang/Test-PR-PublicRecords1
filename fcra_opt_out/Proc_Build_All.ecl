import _Control,RoxieKeybuild,Orbit3,Scrubs_FCRA_Opt_Out;

export Proc_Build_All(string filedate,string inFilename = 'no file',string fileflag = 'B', boolean isfullreplace = false) := function

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Actions: Spray Input Files, SuperFile Moves, Build keys, Pull QA Samples
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// file comes in at \\tapeload02b\k\suppression\equifax_opt_out\
// inFilename - Name of the alpharetta opt_out file
////// Parameters ///////

recordlength :=123;
inFile := if (isfullreplace,
									'/data/data_build_1/opt_out/process/' + filedate + '/MONTHLY_DNS_'+filedate+'.DAT',
									'/data/data_build_1/opt_out/process/' + filedate + '/WEEKLY_DNS_'+filedate+'.DAT');
csvFile := '/data/data_build_1/opt_out/aprocess/' + filedate + '/' + inFilename;
sourceIP := _control.IPAddress.bctlpedata10;
GroupName := 'thor400_44';
thorFile := '~thor_data400::in::fcra::'+filedate+'::opt_out';
csvthorFile := '~thor_data400::in::fcra::'+filedate+'::alpharetta::opt_out';

//////////////////////////

spray_file := FileServices.SprayFixed(sourceIP,inFile, recordlength,GroupName,thorFile,-1,,,true,true,true);
spray_csv := FileServices.SprayVariable(sourceIP,csvFile,16384,,,,GroupName,csvthorFile ,-1,,,true,true,true);

// Spray and Add to Superfile

// equifax
spray_super_transact := sequential(
							NOTHOR(if(NOT fileservices.superfileexists('~thor_data400::in::fcra::opt_out'),
							sequential(fileservices.createsuperfile('~thor_data400::in::fcra::opt_out'),
										fileservices.createsuperfile('~thor_data400::in::fcra::processed::opt_out')
										)
							)),
							fileservices.clearsuperfile('~thor_data400::in::fcra::opt_out'),
							spray_file,
							fileservices.addsuperfile('~thor_data400::in::fcra::opt_out',thorFile),
							output(thorFile + ' sprayed and added to superfile')
							);
// alpharetta
spray_csv_transact :=sequential(
							 NOTHOR(if(NOT fileservices.superfileexists('~thor_data400::in::fcra::alpharetta::opt_out'),
							sequential(fileservices.createsuperfile('~thor_data400::in::fcra::alpharetta::opt_out'),
										fileservices.createsuperfile('~thor_data400::in::fcra::processed::alpharetta::opt_out')
										)
							)),
							fileservices.clearsuperfile('~thor_data400::in::fcra::alpharetta::opt_out'),
							spray_csv,
							fileservices.addsuperfile('~thor_data400::in::fcra::alpharetta::opt_out',csvthorFile),
							output(csvFile + ' sprayed and added to superfile')
							);


// Build base file and perform superfile transaction

Roxiekeybuild.Mac_SF_BuildProcess_v2(
										if (isfullreplace,
											fcra_opt_out.clean_opt_out_data(filedate)(trim(source_flag) <> '5'),
										dedup(fcra_opt_out.clean_opt_out_data(filedate) + 
										if(NOTHOR(fileservices.superfileexists('~thor_data400::base::fcra::qa::optout'))
										,file_infile_appended(trim(source_flag) <> '5')),record,all)
										),
                       '~thor_data400::base::fcra',if(isfullreplace,'optout_monthly','optout_weekly'),filedate,bld_file, 3,,true);

// Build Roxie Keys

buildkeys := fcra_opt_out.proc_build_keys(filedate);

// dops update

dops_update := RoxieKeybuild.updateversion('FCRA_OptOutKeys',filedate,'avenkatachalam@seisint.com,kevin.devore@lexisnexis.com,abednego.escobal@lexisnexisrisk.com',,'F');


// sample records for QA

new_records_sample_for_qa	:= output(choosen(fcra_opt_out.file_infile_appended(date_YYYYMMDD = max(fcra_opt_out.file_infile_appended,date_YYYYMMDD)), 100),named('Sample_Records'))              : success(fileservices.sendemail('qualityassurance@seisint.com',
			'FCRA Opt Out Stats ' + filedate,
			'workunit: ' + workunit));

// orbit creation

orbit_update := Orbit3.proc_Orbit3_CreateBuild_AddItem('FCRA Suppressions',(string)filedate,'F');

// Actions

retval := sequential(if (fileflag = 'B' or fileflag = 'E',spray_super_transact),
					if ( inFilename <> 'no file',
					spray_csv_transact, // sequential(
						output('No Alpharetta File')),
						/*fileservices.addsuperfile('~thor_data400::in::fcra::alpharetta::opt_out',
						'~thor_data400::in::fcra::processed::alpharetta::opt_out',,true),
						fileservices.clearsuperfile('~thor_data400::in::fcra::processed::alpharetta::opt_out')
						)),*/
					bld_file,
					// add the respective super to main super which is used to build index
					fileservices.clearsuperfile('~thor_data400::base::fcra::qa::optout'),
					if (isfullreplace,
						fileservices.addsuperfile('~thor_data400::base::fcra::qa::optout','~thor_data400::base::fcra::qa::optout_monthly'),
						fileservices.addsuperfile('~thor_data400::base::fcra::qa::optout','~thor_data400::base::fcra::qa::optout_weekly')
						),
						
					buildkeys,
					Scrubs_FCRA_Opt_Out.fnRunScrubs(filedate,''),
					dops_update,
					new_records_sample_for_qa,
					// move the new file to processed
					If (fileflag = 'B' or fileflag = 'E', fileservices.addsuperfile('~thor_data400::in::fcra::processed::opt_out',thorFile)),
					//fileservices.clearsuperfile('~thor_data400::in::fcra::opt_out'),
					if ( fileflag = 'B' or fileflag = 'A',
					// clear and delete the file because alpha is full replacement
					sequential(fileservices.clearsuperfile('~thor_data400::in::fcra::processed::alpharetta::opt_out',true),
					fileservices.addsuperfile('~thor_data400::in::fcra::processed::alpharetta::opt_out',
					'~thor_data400::in::fcra::alpharetta::opt_out',,true))),
					
					if (isfullreplace,
								parallel(send_monthly_report,
								fileservices.DeleteExternalFile(sourceIP,'/data/data_build_1/opt_out/logs/monthlyrunning.txt')),
								fileservices.DeleteExternalFile(sourceIP,'/data/data_build_1/opt_out/logs/weeklyrunning.txt')
								),
							
					orbit_update
					//fileservices.clearsuperfile('~thor_data400::in::fcra::alpharetta::opt_out')
					);

return retval;

end;