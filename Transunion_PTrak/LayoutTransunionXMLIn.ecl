EXPORT LayoutTransunionXMLIn := MODULE

EXPORT NameRec := RECORD, MAXLENGTH (5000)
	STRING FullName			{xpath('FL')};
	STRING NameTittle		{xpath('TL')};
	STRING FirstName		{xpath('GN')};
	STRING MiddleName		{xpath('MN')};
	STRING MiddleInitial	{xpath('MI')};
	STRING LastName			{xpath('LN')};
	STRING Suffix			{xpath('SF')};
	STRING Gender			{xpath('GD')};
	STRING Dob_MM			{xpath('DB/MM')};
	STRING Dob_DD			{xpath('DB/DD')};
	STRING Dob_YYYY			{xpath('DB/YY')};
	STRING DeathIndicator	{xpath('DF')};
END;


EXPORT AddressRec := RECORD,  MAXLENGTH (5000)
	//STRING FullAddress		{xpath('FA')};
	STRING Address1			{xpath('S1')} := '';
	STRING Address2			{xpath('S2')}:= '';
	STRING City				{xpath('CY')}:= '';
	STRING State			{xpath('ST')}:= '';
	//STRING Providence		{xpath('PV')};
	//STRING Country		{xpath('CT')};
	STRING ZipCode				{xpath('ZP')}:= '';
	//STRING County			{xpath('CU')};
	//STRING Lattitude		{xpath('LA')};
	//STRING Longitude		{xpath('LO')};
	//STRING AddressType		{xpath('LO')};
	//STRING AddressCreateDate{xpath('AC')};
	STRING UpdatedDate		{xpath('AU')};
END;

EXPORT AKARec := RECORD,  MAXLENGTH (5000)
	STRING NameTittle		{xpath('TL')};
	STRING FirstName		{xpath('GN')};
	STRING MiddleName		{xpath('MN')};
	STRING MiddleInitial	{xpath('MI')};
	STRING LastName			{xpath('LN')};
	STRING Suffix			{xpath('SF')};
END;

/* XML Record layout for the People file format.  Fields not utilized 
for the P-Track convertion are commented out*/

EXPORT LayoutTransunionXMLMainIn := RECORD, MAXLENGTH (10000)
	STRING TransferDate						{xpath('TD')};
	NameRec CurrentName						{xpath('CN')};
	//STRING SpouseName						{xpath('SN')};
	STRING SSNFull							{xpath('FS')};
	STRING SSNFirst5Digit					{xpath('SS/F5')};
	STRING SSNLast4Digit					{xpath('SS/L4')};
	STRING ConsumerUpdateDate				{xpath('CD')};
	//STRING CompanyofEmployment			{xpath('CO')};
	STRING DateOfDeath						{xpath('DC')};
	//STRING TelephoneAreCode				{xpath('AR')};
	STRING TelephoneNumber					{xpath('TP')};
	//STRING TelephoneType					{xpath('TT')};
	//STRING LastResidenceOfDeceased		{xpath('LR')};
	//STRING ResidenceStateOfDeathBeneficiar{xpath('BR/ST')};
	//STRING ResidenceZipOfDeathBeneficiar	{xpath('BR/ZP')};
	//STRING HomeState						{xpath('HS')};	
	//STRING LegalResidenceState			{xpath('LS')};	
	//STRING DutyBase						{xpath('DY')};
	//STRING Occupation						{xpath('OC')};
	//STRING GeneralOccupation				{xpath('OCG')};
	//STRING PrimaryOccupation				{xpath('OCP')};
	//STRING DutyOccupation					{xpath('OCD')};
	//STRING SecondaryOccupation			{xpath('OCS')};
	//STRING Education						{xpath('ED')};
	//STRING SourceEntry					{xpath('SE')};
	//STRING LastUpdateDateByVendor			{xpath('VU')};
	//STRING DateOnVendorFile				{xpath('VD')};
	//STRING DriverLicenseNumber			{xpath('DL')};
	//STRING DBI							{xpath('DBI')};
	//STRING MilitaryStatus 				{xpath('MS')};
	//STRING MilitaryBranch 				{xpath('MB')};
	//STRING MilitaryPayGrade				{xpath('MP')};
	//STRING MilitaryActiveDate				{xpath('MVD')};
	//STRING MilitaryEstimatedSeperationDate{xpath('MES')};
	//STRING MilitarySeperationDate			{xpath('MSD')};
	//STRING MilitaryServiceYears			{xpath('MY')};
	//STRING MilitaryOccupationSpecialty	{xpath('MPM')};
	//STRING PrimaryMilitarySpecialty		{xpath('MOP')};
	//STRING DutyMilitarySpecialty			{xpath('MOD')};
	//STRING SecondaryMilitarySpecialty		{xpath('MOS')};
	//STRING MedicalExpirationDate			{xpath('MX')};
	//STRING CertificationExpirationDate	{xpath('CX')};
	//STRING PilotNumber					{xpath('PN')};
	//STRING PilotCertificationClass		{xpath('PC')};
	//STRING PilotFAARegion					{xpath('FR')};
	//STRING PilotRating					{xpath('PR')};
	//STRING PilotRegion					{xpath('RG')};
	//STRING District						{xpath('DT')};
	
	//STRING PilotMedicalClass				{xpath('PM')};
	//STRING MedicalDate					{xpath('MD')};
	STRING CitedID							{xpath('CI')};
	STRING FileID							{xpath('FI')};
	STRING Publication						{xpath('PU')};

	AddressRec CurrentAddress				{xpath('CA')};
	dataset(AddressRec) PreviousAddress		{xpath('PA')};
	AKARec  FormerName						{xpath('FN')};
	AKARec  AliasName 						{xpath('AK')};
	AKARec  AdditionalName					{xpath('AN')};
	STRING VendorDocumentIdentifier			{xpath('VI')};
END;
END;
//output(DATASET('~thor400_84::temp::transunion',LayoutTransunionXMLIn, XML('batch/doc')));
// output(DATASET('~thor400_84::temp::transunion',{string x{xpath('<>')}}, XML('batch/doc')));
