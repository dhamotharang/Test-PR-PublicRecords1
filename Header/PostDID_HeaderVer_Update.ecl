//////////////////////////////////////////////////////////////////////////////////////
//	
//	AttribHeadere	:	Header.PostDID_HeaderVer_Update
//	Parameters	:	Datasetname
//	Function	:	If the version flag file is available the function 
//					replaces the version in the file with the new prod header 
//					version. If the file is not available the function creates
//					a new file with a prod header version in it.
//
//////////////////////////////////////////////////////////////////////////////////////

import did_add,_Control;

export PostDID_HeaderVer_Update(string datasetname,string pkgvar='header_file_version',STRING roxie_ip=_Control.RoxieEnv.prod_batch_neutral) := function

	// Flag file which contains the prod header version used for last DID process

	flagfilename := '~thor_data400::flag::' + datasetname + '::prodheaderversion';
	
	// Temp file which will be renamed after the process
	
	tempflagfilename := '~thor_data400::temp::' + datasetname + '::prodheaderversion';
	
	// Contains the prod header version
	
	prodversionfilename := '~thor_data400::temp::prodversion';
	
	// Get header version
	
	hdrversion := did_add.get_EnvVariable(pkgvar,roxie_ip)[1..8] : stored(pkgvar);
	
	// LayoHeader for all the above files
	
	prodheaderdate_rec := record
		string10 prodheaderdate;
		string pkgvariable;
	end;
	
	// Datasets
	
	datesetfile_ds := dataset(flagfilename,prodheaderdate_rec,thor);
	
	prodheaderversion_ds := dataset(prodversionfilename,prodheaderdate_rec,thor);
	
	// Replace the version - if the flag file above already exists
	
	prodheaderdate_rec process_rec(datesetfile_ds l) := transform
		self.prodheaderdate := if(l.prodheaderdate <> hdrversion and l.pkgvariable = pkgvar,hdrversion,l.prodheaderdate);
		self := l;
	end;

	process_out := project(datesetfile_ds,process_rec(left));
	
	
	// Create a new file - if the flag file above does not exist.
	
	proj_out := dataset([{hdrversion,pkgvar}],{string10 prodheaderdate,string pkgvariable});

		
	create_out := if(fileservices.fileexists(flagfilename),
						sequential(
									if ( count(datesetfile_ds(pkgvariable = pkgvar)) > 0,
									output(process_out,,tempflagfilename,overwrite),
									output(datesetfile_ds + proj_out,,tempflagfilename,overwrite)
									),
									fileservices.deletelogicalfile(flagfilename),
									fileservices.renamelogicalfile(tempflagfilename,flagfilename)
									),
					output(proj_out,,flagfilename,overwrite)
					);

	
	return create_out;
	
end;