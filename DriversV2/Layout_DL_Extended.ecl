export Layout_DL_Extended	:= record
	DriversV2.Layout_DL;	
	string30	OrigLicenseClass	:=	'';
	string30	OrigLicenseType		:=	'';
	unsigned4	DateReceived			:=	0;
	string65	RawFullName				:=	'';
	string08	orig_CANCELDATE		:=	'';
	string08	orig_ORIGCDLDATE	:=	'';
	string3		orig_County				:=	'';	
	string1		orig_DriverEd			:=	'';	
	string1		orig_HabitualOffender				:=	'';	
	string1		SCHOOL_BUS_PHYSICAL_TYPE		:=	'';
	string8		SCHOOL_BUS_PHYSICAL_EXPDATE	:=	'';
	string1		IssuedRecord			:=	'';
	// New fields being added for possible future use. MA is sending us permit data 
	// but we are not passing this along to the keys as of yet. Just storing the data.
	string1   Permit_Flag				:=	'';
	string2   Permit_Class1			:=	'';
	string8   Permit_Exp_Date1	:=	'';
	string2   Permit_Class2			:=	'';
	string8   Permit_Exp_Date2	:=	'';
	string2   Permit_Class3			:=	'';
	string8  	Permit_Exp_Date3	:=	'';
	string2   Permit_Class4			:=	'';
	string8   Permit_Exp_Date4	:=	'';
	string2   Permit_Class5			:=	'';
	string8   Permit_Exp_Date5	:=	'';			
end;