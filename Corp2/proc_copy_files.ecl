import business_header, ut, versioncontrol, lib_fileservices, _control;

export proc_copy_files(boolean pToDataland = true, boolean isTesting = true) :=
function

	all_files_to_copy :=  
/*						  filenames.dall_filenames		// commented out because still can't copy compressed files
						+ */keynames().dall_filenames
						;
	
	VersionControl.Layout_fCopyFiles.Input tgetsuperfiles(versioncontrol.layout_versions.builds l) :=
	transform
	
		self.srclogicalname				:= l.logicalname;
		self.destinationgroup 			:= if(pToDataland, 'thor_dataland_linux'	, 'thor_data400');
		self.destinationlogicalname		:= l.logicalname;	
		self.srcdali					:= if(pToDataland	, _Control.IPAddress.prod_thor_dali
															, _Control.IPAddress.dataland_dali
											);
		self.dSuperfilenames			:=	  l.dSuperfiles(regexfind('^(.*)::[qQ][aA]::(.*)$', name));

	end;
	
	passtofunction := project(all_files_to_copy, tgetsuperfiles(left));
	
	whattodo := sequential(
					 output(passtofunction, all)
					,if(not(isTesting), 
						VersionControl.fCopyFiles(passtofunction))
				 );
	
	return whattodo;

end;
