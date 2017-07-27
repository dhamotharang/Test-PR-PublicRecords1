import _Control,RoxieKeybuild;

export Proc_Build_All(string filedate) := function

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Actions: Spray Input Files, SuperFile Moves, Build keys, Pull QA Samples
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// file comes in at \\tapeload02b\k\suppression\equifax_opt_out\
////// Parameters ///////

recordlength :=123;
inFile := '/data_build_1/opt_out/FULL_DNS_'+filedate+'.DAT';
sourceIP := _control.IPAddress.edata12;
GroupName := 'thor_200';
thorFile := '~thor_data400::in::fcra::'+filedate+'::opt_out';

//////////////////////////

spray_file := FileServices.SprayFixed(sourceIP,inFile, recordlength,GroupName,thorFile,-1,,,true,true);

// Spray and Add to Superfile

spray_super_transact := sequential(
							if(NOT fileservices.superfileexists('~thor_data400::in::fcra::opt_out'),
							sequential(fileservices.createsuperfile('~thor_data400::in::fcra::opt_out'),
										fileservices.createsuperfile('~thor_data400::in::fcra::processed::opt_out')
										)
							),
							fileservices.clearsuperfile('~thor_data400::in::fcra::opt_out'),
							spray_file,
							fileservices.addsuperfile('~thor_data400::in::fcra::opt_out',thorFile),
							output(thorFile + ' sprayed and added to superfile')
							);

// Build base file and perform superfile transaction

Roxiekeybuild.Mac_SF_BuildProcess_v2(dedup(fcra_opt_out.clean_opt_out_data(filedate) + 
								if(fileservices.superfileexists('~thor_data400::base::fcra::qa::optout')
										,file_infile_appended),record),
                       '~thor_data400::base::fcra','optout',filedate,bld_file, 2);

// Build Roxie Keys

buildkeys := fcra_opt_out.proc_build_keys(filedate);

// dops update

dops_update := RoxieKeybuild.updateversion('FCRA_OptOutKeys',filedate,'avenkatachalam@seisint.com,jwindle@seisint.com');																	


// Actions

retval := sequential(spray_super_transact,
					bld_file,
					buildkeys,
					dops_update,
					// move the new file to processed
					fileservices.addsuperfile('~thor_data400::in::fcra::processed::opt_out',thorFile),
					fileservices.clearsuperfile('~thor_data400::in::fcra::opt_out')
					);

return retval;

end;