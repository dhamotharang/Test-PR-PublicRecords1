IMPORT	Business_Credit,	MDR,	ut,	_control;
EXPORT	Constants(string	pFileDate='')	:=
INLINE MODULE

	//	Source
	EXPORT	source		:=	MDR.sourceTools.src_Business_Credit;
	
	//	Server IP to Spray from
	EXPORT	serverIP	:=	IF(	_control.thisenvironment.name='Dataland',
														_Control.IPAddress.bctlpedata12,
														_Control.IPAddress.bctlpedata10);
	
	//	Directory to Spray from
	EXPORT	Directory	:=	IF(	_control.thisenvironment.name='Dataland',
														'/data/hds_180/SBFE/_in/',
														'/data/hds_180/SBFE/in/');
	
	//	Segment Types
	EXPORT	FileHeader									:=  'FA';	//	File Header Segment (FA)
	EXPORT	AccountHeader								:=  'AA';	//	Header Segment (AA)
	EXPORT	AccountBase									:=	'AB';	//	Account Base Segment (AB)
	EXPORT	MasterAccountContract				:=  'MA';	//	Master Account/Contract Segment (MA)
	EXPORT	Address											:=  'AD';	//	Address Segment (AD)
	EXPORT	PhoneNumber									:=  'PN';	//	Phone Number Segment (PN)
	EXPORT	TaxID_SSN										:=  'TI';	//	Tax ID/SSN Segment (TI)
	EXPORT	IndividualOwner							:=	'IS';	//	Individual Guarantor/Owner Segment (IS)
	EXPORT	BusinessOwner								:=	'BS';	//	Business Guarantor/Owner Segment (BS)
	EXPORT	BusinessIndustryIdentifier	:=  'BI';	//	Business Industry Identifier segment (BI)
	EXPORT	Collateral									:=  'CL';	//	Collateral Segment (CL)
	EXPORT	MemberSpecific							:=  'MS';	//	Member Specific Field (MS)
	EXPORT	AccountModificationHistory	:=  'AH';	//	Account Modification History Segment (AH)
	EXPORT	AccountTrailer							:=  'ZZ';	//	Trailer Segment (ZZ)
	EXPORT	FileFooter									:=  'FZ';	//	File Footer/Trailer Segment (FZ)

	EXPORT	FA													:=  FileHeader;
	EXPORT	AA													:=  AccountHeader;
	EXPORT	AB													:=  AccountBase;
	EXPORT	MA													:=  MasterAccountContract;
	EXPORT	AD													:=  Address;
	EXPORT	PN													:=  PhoneNumber;
	EXPORT	TI													:=  TaxID_SSN;
	EXPORT	IS													:=  IndividualOwner;
	EXPORT	BS													:=  BusinessOwner;
	EXPORT	BI													:=  BusinessIndustryIdentifier;
	EXPORT	CL													:=  Collateral;
	EXPORT	MS													:=  MemberSpecific;
	EXPORT	AH													:=  AccountModificationHistory;
	EXPORT	ZZ													:=  AccountTrailer;
	EXPORT	FZ													:=  FileFooter;
	
	//	Build Types
	EXPORT	buildType :=	ENUM(
													UNSIGNED1,
													Daily,			// DAILY build only processes and links the records from today
													Linking,    // LINKING Build processes today's records and then links all records
													FullBuild		// FULLBUILD processes and links all records (Used when we get a new
																			// address or name cleaner or we missed processing some daily records
												);

END;
