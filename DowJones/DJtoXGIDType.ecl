/***
IDType Recognized values and mapping to XG IT Type:

IDTypes    XG ID Type    ID Type enumerations:

Driving Licence No.               DriversLicense
DUNS Number                       DUNS
National ID                       National
International Maritime Organization (IMO) Ship No.        Other
Passport No.                       Passport
Social Security No.               SSN
Bank Identifier Code (BIC)       SwiftBIC
National Tax No.               TaxID
****/
EXPORT string DJtoXGIDType(string djType) := CASE(djType,
		'ProprietaryUID' => 'ProprietaryUID',		// internally generated
// DJ types
		'Driving Licence No.' => 'DriversLicense',
		'DUNS Number' => 'DUNS',
		'National ID' => 'National',
		'International Maritime Organization (IMO) Ship No.' => 'Other',
		'Passport No.' => 'Passport',
		'Social Security No.' => 'SSN',
		'Bank Identifier Code (BIC)' => 'SwiftBIC',
		'National Tax No.' => 'TaxID',
		'Company Identification No.' => 'EIN',
		'EU Consolidated Electronic List ID' => '',
		'EU Sanctions Programme Indicator' => '',
		'HM Treasury Group ID' => '',
		'OFAC Program ID' => '',
		'OFAC Unique ID' => '',
		'Others' => 'Other',
		'UN Permanent Reference No.' => '',
		'');
