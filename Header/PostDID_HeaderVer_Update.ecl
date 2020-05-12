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
#option('skipFileFormatCrcCheck', 1);
export PostDID_HeaderVer_Update(string datasetname,string pkgvar='header_build_version',STRING roxie_ip=_Control.RoxieEnv.prod_batch_neutral) := function

	// Flag file which contains the prod header version used for last DID process

	flagfilename := '~thor_data400::flag::' + datasetname + '::prodheaderversion';
	
	// Temp file which will be renamed after the process
	
	logicalflagfilename := '~thor_data400::flag::' + datasetname + '::prodheaderversion::'+workunit;
	
	newflagfilename := nothor(IF (STD.File.SuperFileExists(flagfilename)
														,if (STD.File.FindSuperFileSubName(flagfilename,logicalflagfilename) = 0
																	,logicalflagfilename
																	,logicalflagfilename+'_1'
																)
												,logicalflagfilename));
	
	getlogical := dataset('~thor_data400::flag::' + datasetname + '::prodheaderversion_holdlogical',{string logicalname},thor,opt)[1].logicalname;
	
	// Get header version
	
	hdrversion := did_add.get_EnvVariable(pkgvar,roxie_ip)[1..8] : stored(pkgvar);
	
	// LayoHeader for all the above files
	
	prodheaderdate_rec := record
		string prodheaderdate;
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
	
	proj_out := dataset([{hdrversion,pkgvar}],{string prodheaderdate,string pkgvariable});

		
	create_out := 
                sequential(
														output(dataset([{newflagfilename}],{string logicalname})
																,,'~thor_data400::flag::' + datasetname + '::prodheaderversion_holdlogical'
																,overwrite)
                            ,if(~STD.File.SuperFileExists(flagfilename)
															,STD.File.CreateSuperFile(flagfilename))
														,if(~STD.File.SuperFileExists(flagfilename+'_delete')
															,STD.File.CreateSuperFile(flagfilename+'_delete'))
														,sequential(
                                	if ( count(datesetfile_ds(pkgvariable = pkgvar)) > 0,
                                        output(process_out,,getlogical,overwrite),
                                        output(datesetfile_ds + proj_out,,getlogical,overwrite)
																			)
																)
                            
														,STD.File.AddSuperFile(flagfilename+'_delete',flagfilename,,true)
                            ,std.file.clearsuperfile (flagfilename)
                            ,std.file.addsuperfile   (flagfilename,getlogical)
														,std.file.clearsuperfile   (flagfilename+'_delete',true)
                            
                );

	return create_out;
	
end; 