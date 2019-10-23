EXPORT Constants := MODULE
	EXPORT WUStatusInProgress		:= ['RUNNING', 'SUBMITTED', 'COMPILING', 'COMPILED', 'BLOCKED'];
	EXPORT IngestWUWilcard      := '*ingest*';
	EXPORT IngestWURegex        := 'INSURANCE.*HEADER.*.*INGEST';
	EXPORT XlinkSpecWUWilcard   := '*specificities*';
	EXPORT XlinkSpecWURegex     := 'PROC_XLINK_SPECIFICITIES';
	EXPORT XlinkSpecEventName   := 'InsHeaderXlinkSpecificities';
	EXPORT XlinkIncBuildWUWilcard   := '*xlink*';
	EXPORT XlinkIncBuildWURegex     := 'INCREMENTAL.*XLINKKEYBUILD';
	EXPORT XlinkIncBuildEventName   := 'InsHeaderXlinkIncBuild';
	EXPORT IncBuildWUWilcard        := '*INCREMENTAL*';
  EXPORT IncBuildWURegex          := 'INSURANCE.*HEADER.*.*INCREMENTAL';
	EXPORT FullBuildDeltaEventName  := 'InsHeaderDeltaBuild';
	EXPORT FulldeltaWUWilcard       := '*fulldelta*';
	EXPORT FulldeltaWURegex         := 'INSURANCE.*HEADER.*.*.PROC.*.*FULLDELTA';
	EXPORT DaysOldForNew        := 180;
	
	EXPORT RecordChangeType := ENUM(UNSIGNED1,Unknown,Ancient,Old,Unchanged,Updated,New);
  EXPORT RCTToText(unsigned1 c) := CHOOSE(c,'UNKNOWN','Ancient','Old','Unchanged','Updated','New','UNKNOWN');

	EXPORT SrcToUse(STRING srcIn) := IF(srcIn[1..3] IN ['ICP','ICA','IVS'], srcIn[1..3], srcIn);
END;
