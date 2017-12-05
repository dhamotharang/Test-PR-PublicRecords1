import OKC_Student_List,VersionControl;
EXPORT Filenames (STRING	pversion	=	'',
									BOOLEAN	pUseProd	=	FALSE)	:=	MODULE
									
	EXPORT	lInputTemplate	:=	_Dataset(pUseProd).thor_cluster_files	+	'in::'			+	_Dataset().name	+	'::@version@::';
	EXPORT	lBaseTemplate		:=	_Dataset(pUseProd).thor_cluster_files	+	'base::'		+	_Dataset().name	+	'::@version@';
	EXPORT	IngestName			:=	_Dataset(pUseProd).thor_cluster_files	+	'ingest::'	+	_Dataset().name	+	'::input';
	EXPORT	ScrubsReport		:=	_Dataset(pUseProd).thor_cluster_files	+	'Scrubs_OKC_Student_List_V2_orbit_stats_summary';
	EXPORT	QuarantineRecs	:=	_Dataset(pUseProd).thor_cluster_files	+	'quarantine::'	+	_Dataset().name	+	'::' + pversion;

	EXPORT	Input:= MODULE
		EXPORT	Student						:=	versioncontrol.mInputFilenameVersions(lInputTemplate+'student');
		EXPORT	Address						:=	versioncontrol.mInputFilenameVersions(lInputTemplate+'address');
		EXPORT	Phone							:=	versioncontrol.mInputFilenameVersions(lInputTemplate+'phone');
		
		EXPORT	dAll_filenames	:=Student.dAll_filenames + Address.dAll_filenames + Phone.dAll_filenames;
	END;
	
	EXPORT	Base	:=	MODULE
		EXPORT	Fname	:=	versioncontrol.mBuildFilenameVersions(lBaseTemplate,pversion);
		EXPORT	dAll_filenames	:=
			Fname.dAll_filenames;
	END;
	
	export dAll_FileNames	:=
		Base.dAll_Filenames;
	
	end;
	