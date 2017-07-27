export Layout_DL_Extended	:= record
	DriversV2.Layout_DL;	
	string30		OrigLicenseClass	:=	'';
	string30		OrigLicenseType		:=	'';
	unsigned4		DateReceived			:=	0;
	string65		RawFullName				:=	'';
	string08		orig_CANCELDATE		:=	'';
	string08		orig_ORIGCDLDATE	:=	'';
	string3			orig_County				:=	'';	
	string1			orig_DriverEd			:=	'';	
	string1			orig_HabitualOffender				:=	'';	
	string1			SCHOOL_BUS_PHYSICAL_TYPE		:=	'';
	string8			SCHOOL_BUS_PHYSICAL_EXPDATE	:=	'';
	string1			IssuedRecord			:=	'';
end;