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

import did_add,_Control,std;

export PostDID_HeaderVer_Update(string datasetname,string pkgvar='header_build_version',STRING roxie_ip=_Control.RoxieEnv.prod_batch_neutral) := function

	// Flag file which contains the prod header version used for last DID process

	flagfilename := '~thor_data400::flag::' + datasetname + '::prodheaderversion';
	
	// Temp file which will be renamed after the process
	
	newflagfilename := '~thor_data400::flag::' + datasetname + '::prodheaderversion::'+workunit;
	
	// Get header version
	
	hdrversion := did_add.get_EnvVariable(pkgvar,roxie_ip)[1..8] : stored(pkgvar);
	
	// LayoHeader for all the above files
	
	prodheaderdate_rec := record
		string10 prodheaderdate;
		string pkgvariable;
	end;
	
	// Datasets
	
	datesetfile_ds := dataset(flagfilename,prodheaderdate_rec,thor,OPT);
	
	// Replace the version - if the flag file above already exists
	
	prodheaderdate_rec process_rec(datesetfile_ds l) := transform
		self.prodheaderdate := if(l.prodheaderdate <> hdrversion and l.pkgvariable = pkgvar,hdrversion,l.prodheaderdate);
		self := l;
	end;

	process_out := project(datesetfile_ds,process_rec(left));
	
	
	// Create a new file - if the flag file above does not exist.
	
	proj_out := dataset([{hdrversion,pkgvar}],{string10 prodheaderdate,string pkgvariable});

		
	create_out := 
                sequential(
                            if(fileservices.fileexists(flagfilename),sequential(
                                std.file.startsuperfiletransaction(),
                                std.file.clearsuperfile(flagfilename),
                                std.file.finishsuperfiletransaction(),
                                if ( count(datesetfile_ds(pkgvariable = pkgvar)) > 0,
                                        output(process_out,,newflagfilename,overwrite),
                                        output(datesetfile_ds + proj_out,,newflagfilename,overwrite)
                                )),
                                sequential( std.file.createsuperfile(flagfilename),
                                            output(proj_out,,newflagfilename,overwrite)
                                )
                            ),
                            std.file.startsuperfiletransaction(),
                            std.file.clearsuperfile (flagfilename,true),  //delete when clearing
                            std.file.addsuperfile   (flagfilename,newflagfilename),
                            std.file.finishsuperfiletransaction()
                );

	return create_out;
	
end; 