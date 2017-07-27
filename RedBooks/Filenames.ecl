import versioncontrol;

export Filenames(string pversion = '') :=
module


	shared ftemplate(string pFiletype)	:= _Dataset.thor_cluster_files + pFiletype + '::' + _Dataset.name + '::@version@::'; 

	export input :=
	module
		export ISDA  := versioncontrol.mInputFilenameVersions(ftemplate('in') + 'ISDA');
    export ISDAA := versioncontrol.mInputFilenameVersions(ftemplate('in') + 'ISDAA');
    export IAD  := versioncontrol.mInputFilenameVersions(ftemplate('in') + 'IAD');
    export IAG  := versioncontrol.mInputFilenameVersions(ftemplate('in') + 'IAG');

	  export dAll_filenames := 
      ISDA.dAll_filenames
    + ISDAA.dAll_filenames
    + IAD.dAll_filenames
    + IAG.dAll_filenames
    ; 
    
	end; //input

	export base :=
	module
    export Combined  := versioncontrol.mBuildFilenameVersions (ftemplate('base') + 'Combined', pversion);
    export dAll_filenames := Combined.dAll_filenames
   ; 

	end; //base

	export dAll_filenames := base.dAll_filenames;


end;