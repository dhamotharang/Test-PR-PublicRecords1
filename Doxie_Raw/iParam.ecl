IMPORT AutoStandardI;

EXPORT iParam :=
MODULE

	EXPORT RelDetails :=
	INTERFACE(AutoStandardI.PermissionI_Tools.params,AutoStandardI.DataPermissionI.params,AutoStandardI.DataRestrictionI.params)
		EXPORT BOOLEAN   AllowAll             := FALSE;
    EXPORT BOOLEAN   AllowGLB             := FALSE;
    EXPORT BOOLEAN   AllowDPPA            := FALSE;
    EXPORT UNSIGNED1 GLBPurpose           := 0;
    EXPORT UNSIGNED1 DPPAPurpose          := 0;
    EXPORT BOOLEAN   IncludeMinors        := FALSE;
		EXPORT STRING6   SSNMask              := 'NONE';// : STORED('SSNMask');
		EXPORT UNSIGNED3 DateVal              := 0;
    EXPORT BOOLEAN   LnBranded            := FALSE;//  : STORED('LnBranded');
		EXPORT BOOLEAN   Probation            := FALSE;
		EXPORT STRING32  ApplicationType      := '';//     : STORED('ApplicationType');
		EXPORT STRING5   IndustryClass        := '';//     : STORED('IndustryClass');
		EXPORT BOOLEAN   IncludeRelatives     := FALSE;//  : STORED('IncludeRelatives');
		EXPORT UNSIGNED1 RelativeDepth        := 0;//      : STORED('RelativeDepth');
		EXPORT UNSIGNED3 MaxRelatives         := 0;//      : STORED('MaxRelatives');
		EXPORT BOOLEAN   isCRS                := FALSE;
		EXPORT BOOLEAN   IncludeAssociates    := FALSE;//  : STORED('IncludeAssociates');
		EXPORT UNSIGNED3 MaxAssociates        := 0;//      : STORED('MaxAssociates');
		EXPORT BOOLEAN   IncludeNeighbors     := FALSE;//  : STORED('IncludeNeighbors');
		EXPORT UNSIGNED3 MaxNeighborhoods     := 4;//      : STORED('MaxNeighborhoods');
		EXPORT UNSIGNED1 NeighborsPerAddress  := 3;//      : STORED('NeighborsPerAddress');
		EXPORT UNSIGNED1 NeighborsPerNA       := 6;//      : STORED('NeighborsPerNA');
		EXPORT UNSIGNED1 NeighborRecency      := 3;//      : STORED('NeighborRecency');
		EXPORT BOOLEAN   Raw                  := FALSE;//  : STORED('Raw');
	END;
	
END;