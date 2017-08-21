// Process to build the AMIDIR Files.
import Lib_FileServices, PromoteSupers, STRATA;

// Please update the build_run with the update date;
build_run := '';

#workunit('name','AMIDIR Build '+ build_run );

mailTarget := 'giri.rajulapalli@lexisnexis.com';

send_mail (string pSubject, string pBody) := lib_fileservices.FileServices.sendemail(mailTarget, pSubject, pBody);

PromoteSupers.MAC_SF_BuildProcess(AMIDIR.Cleaned_AMIDIR_BDID,AMIDIR.Cluster+'base::AMIDIR',a_AMIDIR_Build,2);

build_base  := a_AMIDIR_Build : success(output('base file built successfully')), failure(output('build of base file failed'));

STRATA.CreateAsBusinessHeaderStats(AMIDIR.fAMIDIR_As_Business_Header(AMIDIR.File_AMIDIR_DID_SSN_BDID_BIP),
																	 'AMIDIR',
																	 'data',
																	 build_run,
																	 '',
																	 runAsBusinessHeaderStats);
																	 

build_keys  := Proc_AMIDIR_BuildKeys : success(output('roxie key build completed')), failure(output('roxie key build failed'));

sequential(build_base, 
            parallel(build_keys,
			 		  AMIDIR.Out_Base_Stats_Population,
					  runAsBusinessHeaderStats),
			send_mail('AMIDIR Build '+build_run,' - building base file, keys & stats completed successfully '));