import versioncontrol;
export Filenames(string pversion = '') :=
module

   export lInputTemplate	:= _Dataset.thor_cluster_files + 'in::'   + _Dataset.name + '::@version@::data'	;
   export lBaseTemplate		:= _Dataset.thor_cluster_files + 'base::' + _Dataset.name + '::@version@::'			;
   
	 export Input   := versioncontrol.mInputFilenameVersions(lInputTemplate                 );

   export Base :=
   module

			export Companies	:= versioncontrol.mBuildFilenameVersions(lBaseTemplate + 'Companies',pversion   );
			export Contacts		:= versioncontrol.mBuildFilenameVersions(lBaseTemplate + 'Contacts'	,pversion   );

			 export dAll_filenames :=
						Companies.dAll_filenames
					+	Contacts.dAll_filenames
					;
	 end;
                                                                        
   export dAll_filenames :=
        Base.Companies.dAll_filenames
      +	Base.Contacts.dAll_filenames
   ;
end;
