

import _Control,RoxieKeybuild;

export Proc_Build_All(string filedate,string inFilename = 'no file') := function

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Actions: Spray Input Files, SuperFile Moves, Build keys, Pull QA Samples
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// file comes in at \\ not sure yet
// 
////// Parameters ///////

recordlength :=1502;
inFile := '/thor_back5/vin_data/process/' + filedate + '/PREFIX.TXT';

sourceIP := _control.IPAddress.edata12;
GroupName := 'thor400_88_dev';
thorFile := '~thor_data400::in::vina::'+filedate+'::vin';

//////////////////////////

spray_file := FileServices.SprayFixed(sourceIP,inFile, recordlength,GroupName,thorFile,-1,,,true,true);

// Spray and Add to Superfile
//Could not locate super file thor_data400::key::vina::did_built
// Could not locate super file thor_data400::key::vina::vin_built
// Error: System error: -1: CDistributedFileDirectory::removeEntry Cannot remove file thor_data400::key::vina::20090323::vin as owned by SuperFile thor_data400::key::vina::vin_built
// equifax
spray_super_transact := sequential(

		if(NOT fileservices.superfileexists('~thor_data400::key::vina::vin_built'),
			fileservices.createsuperfile('~thor_data400::key::vina::vin_built')	),
		if(NOT fileservices.superfileexists('~thor_data400::key::vina::vin_QA'),
			fileservices.createsuperfile('~thor_data400::key::vina::vin_QA')),


		if(NOT fileservices.superfileexists('~thor_data400::in::vina::vin'),
		sequential(fileservices.createsuperfile('~thor_data400::in::vina::vin'),
			fileservices.createsuperfile('~thor_data400::in::vina::processed::vin')
			)
		),
		fileservices.clearsuperfile('~thor_data400::in::vina::vin'),
		fileservices.clearsuperfile('~thor_data400::in::vina::processed::vin'),
		spray_file,
		fileservices.addsuperfile('~thor_data400::in::vina::vin',thorFile),
		output(thorFile + ' sprayed and added to superfile')
		);


// Build base file and perform superfile transaction
/*
Roxiekeybuild.Mac_SF_BuildProcess_v2(dedup(fcra_opt_out.clean_opt_out_data(filedate) + 
				if(fileservices.superfileexists('~thor_data400::base::fcra::qa::optout')
				,file_infile_appended(trim(source_flag) <> '5')),record),
                '~thor_data400::base::fcra','optout',filedate,bld_file, 2);
*/
// Build Roxie Keys

buildkeys := VINA.proc_build_keys(filedate);

// dops update

dops_update := RoxieKeybuild.updateversion('Vina_VinKeys',filedate,'avenkatachalam@seisint.com,jwindle@seisint.com');																	


// sample records for QA
f := dataset(thorFile,VINA.layout_vina_infile,thor);

new_records_sample_for_qa	:= output(choosen(f, 100),named('Sample_Records'))
 : success(fileservices.sendemail('qualityassurance@seisint.com',
			'VINA Stats ' + filedate,
			'workunit: ' + workunit));

// Actions

retval := sequential(spray_super_transact,
	//	bld_file,
		fileservices.clearsuperfile('~thor_data400::key::vina::vin_built'),
		fileservices.clearsuperfile('~thor_data400::key::vina::vin_delete'),
		fileservices.clearsuperfile('~thor_data400::key::vina::vin_qa'),
		buildkeys,
		dops_update,
		new_records_sample_for_qa,
		// move the new file to processed
		fileservices.addsuperfile('~thor_data400::in::vina::processed::vin',thorFile),
		fileservices.clearsuperfile('~thor_data400::in::vina::vin')
		,VINA.Build_Strata(filedate,false,,false)
		);

return retval;

end;