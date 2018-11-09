import did_add,_Control,ut;

//////////////////////////////////////////////////////////////////////////////////////
//	
//	AttribHeadere	:	Header.IsNewProdHeaderVersion
//	Parameters	:	Datasetname
//	Function	:	Returns a boolean value based on the following
//					1. Returns a false value if the flag file exists and the prod
//					   version is equal to the date in flag file.
//					2. Returns a true value if the flag file does not exists or the
//					   versions are different
//
//////////////////////////////////////////////////////////////////////////////////////
import _Control;
export IsNewProdHeaderVersion(string datasetname,string pkgvar='header_build_version',STRING roxie_ip=_Control.RoxieEnv.prod_batch_neutral,dataset(header.Layout_PackageVariable) ds  = dataset([],header.Layout_PackageVariable)) := 
function

	// Flag file name
	flagfilename := '~thor_data400::flag::'+ datasetname + '::prodheaderversion';
	
	l_pkgvariable := record
		header.Layout_PackageVariable - roxie_ip;
		boolean ischanged := false;
	end;
	
	
	datesetfile_ds := dedup(sort(dataset(flagfilename,l_pkgvariable - ischanged,thor,opt),pkgvariable),pkgvariable);

	l_ds := if (count(ds) > 0, dedup(sort(ds,pkgvariable),pkgvariable), dataset([{'',pkgvar,roxie_ip}],header.Layout_PackageVariable));

	l_pkgvariable process_rec(l_ds l) := transform
		
		self.ischanged := if ( count(datesetfile_ds(pkgvariable = l.pkgvariable)) > 0,
												if (did_add.get_EnvVariable(l.pkgvariable,l.roxie_ip)[1..8] <> datesetfile_ds(pkgvariable = l.pkgvariable)[1].prodheaderdate[1..8], true, false),
												true
												);
		self := l;
	end;

	process_out := project(l_ds,process_rec(left));
	
	// Validate
	return if(count(process_out(ischanged = true)) = 0,					
					false,
					true
				 );

end;
