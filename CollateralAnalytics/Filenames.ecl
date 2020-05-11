import OKC_Student_List,VersionControl;
EXPORT Filenames (STRING	pversion	=	'',
									BOOLEAN	pUseProd	=	FALSE)	:=	MODULE
									
	EXPORT	lInputTemplate	:=	_Dataset(pUseProd).thor_cluster_files	+	'in::'			+	_Dataset().name	+	'::@version@';
	EXPORT	lExceptionInputTemplate	:=	_Dataset(pUseProd).thor_cluster_files	+	'in::'			+	_Dataset().name	+	'::ExceptionList::@version@';
	EXPORT	lBaseTemplate		:=	_Dataset(pUseProd).thor_cluster_files	+	'base::'		+	_Dataset().name	+	'::@version@';
	EXPORT	lExceptionBaseTemplate	:=	_Dataset(pUseProd).thor_cluster_files	+	'base::'			+	_Dataset().name	+	'::ExceptionList::@version@';
	EXPORT	IngestName			:=	_Dataset(pUseProd).thor_cluster_files	+	'ingest::'	+	_Dataset().name	+	'::input';
	EXPORT	ScrubsReport		:=	_Dataset(pUseProd).thor_cluster_files	+	'Scrubs_OKC_Student_List_V2_orbit_stats_summary';
	
	EXPORT	Input:= versioncontrol.mInputFilenameVersions(lInputTemplate);
		
	
	EXPORT	Base	:=	versioncontrol.mBuildFilenameVersions(lBaseTemplate,pversion);

	EXPORT	ExceptionInput:= versioncontrol.mInputFilenameVersions(lExceptionInputTemplate);
		
	
	EXPORT	ExceptionBase	:=	versioncontrol.mBuildFilenameVersions(lExceptionBaseTemplate,pversion);
		
	end;
	