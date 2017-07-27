EXPORT Constants := MODULE

EXPORT TIMEOUT := 30; // specified in requirements (may be excessive?)
EXPORT RETRIES := 0;

EXPORT DPPA := '0';
EXPORT GLB  := '8';

EXPORT MATCH   := 'match';
EXPORT NOMATCH := 'nomatch';
EXPORT MISSING := 'missing';

EXPORT REQUIRED := 'R';
EXPORT DESIRED  := 'D';

// bitmap values for required missing fields
EXPORT UNSIGNED FNAME  := 00000000000000001b; // 1
EXPORT UNSIGNED GNAME  := 00000000000000010b; // 2
EXPORT UNSIGNED LNAME  := 00000000000000100b; // 4
EXPORT UNSIGNED SNAME  := 00000000000001000b; // 8
EXPORT UNSIGNED FSNAME := 00000000000010000b; // 16
EXPORT UNSIGNED YOB    := 00000000000100000b; // 32
EXPORT UNSIGNED MOB    := 00000000001000000b; // 64
EXPORT UNSIGNED DOB    := 00000000010000000b; // 128
EXPORT UNSIGNED ADDR1  := 00000000100000000b; // 256
EXPORT UNSIGNED STREET := 00000001000000000b; // 512
EXPORT UNSIGNED BLDGNO := 00000010000000000b; // 1024
EXPORT UNSIGNED SUBRB  := 00000100000000000b; // 2028
EXPORT UNSIGNED CITI   := 00001000000000000b; // 4096
EXPORT UNSIGNED CNTY   := 00010000000000000b; // 8192
EXPORT UNSIGNED DIST   := 00100000000000000b; // 16384
EXPORT UNSIGNED PSTCDE := 01000000000000000b; // 32768
EXPORT UNSIGNED NID    := 10000000000000000b; // 65536

// ISO 3166-2 country codes alpha
EXPORT AU :='AU'; // Australia    - RTACardNumber
EXPORT AT :='AT'; // Austria
EXPORT BR :='BR'; // Brazil       - NationalIDNumber
EXPORT CA :='CA'; // Canada       - SocialInsuranceNumber
EXPORT CN :='CN'; // China        - NationalIDNumber
EXPORT DE :='DE'; // Germany
EXPORT HK :='HK'; // Hong Kong    - HongKongIDNumber
EXPORT IE :='IE'; // Ireland      - PersonalPublicServiceNumber
EXPORT JP :='JP'; // Japan
EXPORT LU :='LU'; // Luxembourg
EXPORT MX :='MX'; // Mexico       - CURPIDNumber
EXPORT NL :='NL'; // Netherlands
EXPORT NZ :='NZ'; // New Zealand
EXPORT SG :='SG'; // Singapore    - NRICNumber
EXPORT ZA :='ZA'; // South Africa - NationalIDNumber
EXPORT CH :='CH'; // Switzerland
EXPORT GB :='GB'; // United Kingdom

EXPORT SrcHasNID := [AU,BR,CA,CN,HK,IE,MX,SG,ZA];

// ISO 3166-1 country codes numeric
EXPORT AU036 :='036'; // Australia
EXPORT AT040 :='040'; // Austria
EXPORT BR076 :='076'; // Brazil
EXPORT CA124 :='124'; // Canada
EXPORT CN156 :='156'; // China
EXPORT DE276 :='276'; // Germany
EXPORT HK344 :='344'; // Hong Kong
EXPORT IE372 :='372'; // Ireland
EXPORT JP392 :='392'; // Japan
EXPORT LU442 :='442'; // Luxembourg
EXPORT MX484 :='484'; // Mexico
EXPORT NL528 :='528'; // Netherlands
EXPORT NZ554 :='554'; // New Zealand
EXPORT SG702 :='702'; // Singapore
EXPORT ZA710 :='710'; // South Africa
EXPORT CH756 :='756'; // Switzerland
EXPORT GB826 :='826'; // United Kingdom

EXPORT AUSTRALIA     :='Australia';
EXPORT AUSTRIA       :='Austria';
EXPORT BRAZIL        :='Brazil';
EXPORT CANADA        :='Canada';
EXPORT CHINA         :='China';
EXPORT GERMANY       :='Germany';
EXPORT HONGKONG      :='Hong Kong';
EXPORT IRELAND       :='Ireland';
EXPORT JAPAN         :='Japan';
EXPORT LUXEMBOURG    :='Luxembourg';
EXPORT MEXICO        :='Mexico';
EXPORT NETHERLANDS   :='Netherlands';
EXPORT NEWZEALAND    :='New Zealand';
EXPORT SINGAPORE     :='Singapore';
EXPORT SOUTHAFRICA   :='South Africa';
EXPORT SWITZERLAND   :='Switzerland';
EXPORT UNITEDKINGDOM :='United Kingdom';

export GG2Countries := [AUSTRALIA,
												AUSTRIA,
												BRAZIL,
												CANADA,
												CHINA,
												GERMANY,
												HONGKONG,
												IRELAND,
												JAPAN,
												LUXEMBOURG,
												MEXICO,
												NETHERLANDS,
												NEWZEALAND,
												SINGAPORE,
												SOUTHAFRICA,
												SWITZERLAND,
												UNITEDKINGDOM];

// GG2 output field names
EXPORT FIRSTNAME                  :='FirstName';
EXPORT MIDDLENAME                 :='MiddleName';
EXPORT LASTNAME                   :='LastName';
EXPORT GIVENNAMES                 :='GivenNames';
EXPORT SURNAME                    :='Surname';
EXPORT FIRSTSURNAME               :='FirstSurname';
EXPORT SECONDSURNAME              :='SecondSurname';
EXPORT MAIDENNAME                 :='MaidenName';
EXPORT FIRSTINITIAL               :='FirstInitial';
EXPORT MIDDLEINITIAL              :='MiddleInitial';
EXPORT GIVENINITIALS              :='GivenInitials';
EXPORT GENDER                     :='Gender';
EXPORT YEAROFBIRTH                :='YearOfBirth';
EXPORT MONTHOFBIRTH               :='MonthOfBirth';
EXPORT DAYOFBIRTH                 :='DayOfBirth';
EXPORT ADDRESS1                   :='Address1';
EXPORT ADDRESS2                   :='Address2';
EXPORT STREETNUMBER               :='StreetNumber';
EXPORT HOUSENUMBER                :='HouseNumber';
EXPORT CIVICNUMBER                :='CivicNumber';
EXPORT AREANUMBERS                :='AreaNumbers';
EXPORT STREETNAME                 :='StreetName';
EXPORT STREETTYPE                 :='StreetType';
EXPORT BUILDINGNAME               :='BuildingName';
EXPORT BUILDINGNUMBER             :='BuildingNumber';
EXPORT BLOCKNUMBER                :='BlockNumber';
EXPORT UNITNUMBER                 :='UnitNumber';
EXPORT ROOMNUMBER                 :='RoomNumber';
EXPORT HOUSEEXTENSION             :='HouseExtension';
EXPORT FLOORNUMBER                :='FloorNumber';
EXPORT SUBURB                     :='Suburb';
EXPORT AZA                        :='Aza';
EXPORT CITY                       :='City';
EXPORT MUNICIPALITY               :='Municipality';
EXPORT PROVINCE                   :='Province';
EXPORT COUNTY                     :='County';
EXPORT STATE                      :='State';
EXPORT DISTRICT                   :='District';
EXPORT PREFECTURE                 :='Prefecture';
EXPORT POSTALCODE                 :='PostalCode';
EXPORT COUNTRYCODE                :='CountryCode';
EXPORT TELEPHONE                  :='Telephone';
EXPORT CELLNUMBER                 :='CellNumber';
EXPORT WORKTELEPHONE              :='WorkTelephone';
EXPORT RTACARDNUMBER              :='RTACardNumber';
EXPORT SOCIALINSURANCENUMBER      :='SocialInsuranceNumber';
EXPORT NATIONALIDNUMBER           :='NationalIDNumber';
EXPORT HONGKONGIDNUMBER           :='HongKongIDNumber';
EXPORT PERSONALPUBLICSERVICENUMBER:='PersonalPublicServiceNumber';
EXPORT CURPIDNUMBER               :='CURPIDNumber';
EXPORT STATEOFBIRTH               :='StateOfBirth';
EXPORT NRICNUMBER                 :='NricNumber';
EXPORT NHSNUMBER                  :='NHSNumber';
EXPORT CITYOFISSUE                :='CityOfIssue';
EXPORT COUNTYOFISSUE              :='CountyOfIssue';
EXPORT DISTRICTOFISSUE            :='DistrictOfIssue';
EXPORT PROVINCEOFISSUE            :='ProvinceOfIssue';
EXPORT DRIVERLICENCENUMBER        :='DriverLicenceNumber';
EXPORT DRIVERLICENCEVERSIONNUMBER :='DriverLicenceVersionNumber';
EXPORT DRIVERLICENCESTATE         :='DriverLicenceState';
EXPORT YEAROFEXPIRY               :='YearOfExpiry';
EXPORT MONTHOFEXPIRY              :='MonthOfExpiry';
EXPORT DAYOFEXPIRY                :='DayOfExpiry';
EXPORT PASSPORTNUMBER             :='PassportNumber';
EXPORT PASSPORTFULLNAME           :='PassportFullName';
EXPORT PASSPORTMRZLINE1           :='PassportMRZLine1';
EXPORT PASSPORTMRZLINE2           :='PassportMRZLine2';
EXPORT PASSPORTCOUNTRY            :='PassportCountry';
EXPORT PLACEOFBIRTH               :='PlaceOfBirth';
EXPORT COUNTRYOFBIRTH             :='CountryOfBirth';
EXPORT FAMILYNAMEATBIRTH          :='FamilyNameAtBirth';
EXPORT FAMILYNAMEATCITIZENSHIP    :='FamilyNameAtCitizenship';
EXPORT PASSPORTYEAROFEXPIRY       :='PassportYearOfExpiry';
EXPORT PASSPORTMONTHOFEXPIRY      :='PassportMonthOfExpiry';
EXPORT PASSPORTDAYOFEXPIRY        :='PassportDayOfExpiry';
EXPORT MEDICARENUMBER             :='MedicareNumber';
EXPORT MEDICAREREFERENCE          :='MedicareReference';

EXPORT outputFields := DATASET([
	{AUSTRALIA,[{1,FIRSTNAME},
						{2,MIDDLENAME},
						{3,LASTNAME},
						{6,YEAROFBIRTH},
						{7,MONTHOFBIRTH},
						{8,DAYOFBIRTH},
						{10,STREETNUMBER},
						{11,STREETNAME},
						{12,STREETTYPE},
						{13,UNITNUMBER},
						{14,SUBURB},
						{15,STATE},
						{19,POSTALCODE},
						{20,TELEPHONE},
						{23,RTACARDNUMBER},
						{25,DRIVERLICENCENUMBER},
						{26,DRIVERLICENCESTATE},
						{27,YEAROFEXPIRY},
						{28,MONTHOFEXPIRY},
						{29,DAYOFEXPIRY},
						{30,PASSPORTNUMBER},
						{34,PASSPORTCOUNTRY},
						{35,PLACEOFBIRTH},
						{36,COUNTRYOFBIRTH},
						{37,FAMILYNAMEATBIRTH},
						{38,FAMILYNAMEATCITIZENSHIP},
						{39,PASSPORTYEAROFEXPIRY},
						{40,PASSPORTMONTHOFEXPIRY},
						{41,PASSPORTDAYOFEXPIRY},
						{50,MEDICARENUMBER},
						{51,MEDICAREREFERENCE}]},
	{AUSTRIA,[{1,FIRSTNAME},
						{3,LASTNAME},
						{6,YEAROFBIRTH},
						{7,MONTHOFBIRTH},
						{8,DAYOFBIRTH},
						{10,HOUSENUMBER},
						{11,STREETNAME},
						{11,CITY},
						{19,POSTALCODE},
						{20,TELEPHONE}]},
	{BRAZIL,[{1,FIRSTNAME},
						{2,LASTNAME},
						{3,GENDER},
						{6,YEAROFBIRTH},
						{7,MONTHOFBIRTH},
						{8,DAYOFBIRTH},
						{10,ADDRESS1},
						{11,STREETNUMBER},
						{12,STREETNAME},
						{13,UNITNUMBER},
						{14,SUBURB},
						{15,CITY},
						{16,STATE},
						{19,POSTALCODE},
						{20,TELEPHONE},
						{23,NATIONALIDNUMBER}]},
	{CANADA,[{1,FIRSTNAME},
						{2,MIDDLENAME},
						{3,LASTNAME},
						{6,YEAROFBIRTH},
						{7,MONTHOFBIRTH},
						{8,DAYOFBIRTH},
						{10,CIVICNUMBER},
						{11,STREETNAME},
						{12,STREETTYPE},
						{13,UNITNUMBER},
						{14,MUNICIPALITY},
						{15,PROVINCE},
						{19,POSTALCODE},
						{20,TELEPHONE},
						{23,SOCIALINSURANCENUMBER}]},
	{CHINA,[{1,GIVENNAMES},
						{2,SURNAME},
						{6,YEAROFBIRTH},
						{7,MONTHOFBIRTH},
						{8,DAYOFBIRTH},
						{10,STREETNUMBER},
						{11,STREETNAME},
						{12,STREETTYPE},
						{13,BUILDINGNAME},
						{14,BUILDINGNUMBER},
						{15,ROOMNUMBER},
						{16,CITY},
						{17,COUNTY},
						{18,DISTRICT},
						{19,PROVINCE},
						{20,TELEPHONE},
						{23,NATIONALIDNUMBER},
						{24,CITYOFISSUE},
						{25,COUNTYOFISSUE},
						{26,DISTRICTOFISSUE},
						{27,PROVINCEOFISSUE}]},
	{GERMANY,[{1,FIRSTNAME},
						{2,MIDDLENAME},
						{3,MAIDENNAME},
						{4,LASTNAME},
						{5,GENDER},
						{6,YEAROFBIRTH},
						{7,MONTHOFBIRTH},
						{8,DAYOFBIRTH},
						{10,HOUSENUMBER},
						{11,STREETNAME},
						{12,CITY},
						{19,POSTALCODE},
						{20,TELEPHONE}]},
	{HONGKONG,[{1,FIRSTNAME},
						{2,LASTNAME},
						{6,YEAROFBIRTH},
						{7,MONTHOFBIRTH},
						{8,DAYOFBIRTH},
						{10,STREETNAME},
						{11,BUILDINGNAME},
						{12,BUILDINGNUMBER},
						{13,UNITNUMBER},
						{14,FLOORNUMBER},
						{15,CITY},
						{16,DISTRICT},
						{20,TELEPHONE},
						{23,HONGKONGIDNUMBER}]},
	{IRELAND,[{1,FIRSTNAME},
						{2,MIDDLENAME},
						{3,LASTNAME},
						{6,YEAROFBIRTH},
						{7,MONTHOFBIRTH},
						{8,DAYOFBIRTH},
						{10,ADDRESS1},
						{11,CITY},
						{12,COUNTY},
						{20,TELEPHONE},
						{23,PERSONALPUBLICSERVICENUMBER}]},
	{JAPAN,[{1,FIRSTNAME},
						{2,SURNAME},
						{3,GENDER},
						{6,YEAROFBIRTH},
						{7,MONTHOFBIRTH},
						{8,DAYOFBIRTH},
						{10,AREANUMBERS},
						{11,BUILDINGNAME},
						{12,AZA},
						{13,MUNICIPALITY},
						{14,PREFECTURE},
						{19,POSTALCODE},
						{20,TELEPHONE}]},
	{LUXEMBOURG,[{1,FIRSTNAME},
						{2,LASTNAME},
						{6,YEAROFBIRTH},
						{7,MONTHOFBIRTH},
						{8,DAYOFBIRTH},
						{10,HOUSENUMBER},
						{11,STREETNAME},
						{12,CITY},
						{19,POSTALCODE},
						{20,TELEPHONE}]},
	{MEXICO,[{1,FIRSTNAME},
						{2,FIRSTSURNAME},
						{3,SECONDSURNAME},
						{4,GENDER},
						{6,YEAROFBIRTH},
						{7,MONTHOFBIRTH},
						{8,DAYOFBIRTH},
						{10,ADDRESS1},
						{11,CITY},
						{12,STATE},
						{19,POSTALCODE},
						{20,TELEPHONE},
						{23,CURPIDNUMBER},
						{24,STATEOFBIRTH}]},
	{NETHERLANDS,[{1,GIVENNAMES},
						{2,MIDDLENAME},
						{3,LASTNAME},
						{6,YEAROFBIRTH},
						{7,MONTHOFBIRTH},
						{8,DAYOFBIRTH},
						{10,HOUSENUMBER},
						{11,STREETNAME},
						{13,HOUSEEXTENSION},
						{14,CITY},
						{19,POSTALCODE},
						{20,TELEPHONE}]},
	{NEWZEALAND,[{1,FIRSTNAME},
						{2,MIDDLENAME},
						{3,LASTNAME},
						{6,YEAROFBIRTH},
						{7,MONTHOFBIRTH},
						{8,DAYOFBIRTH},
						{10,HOUSENUMBER},
						{11,STREETNAME},
						{12,STREETTYPE},
						{13,UNITNUMBER},
						{14,SUBURB},
						{15,CITY},
						{19,POSTALCODE},
						{20,TELEPHONE},
						{25,DRIVERLICENCENUMBER},
						{26,DRIVERLICENCEVERSIONNUMBER}]},
	{SINGAPORE,[{1,FIRSTNAME},
						{2,LASTNAME},
						{6,YEAROFBIRTH},
						{7,MONTHOFBIRTH},
						{8,DAYOFBIRTH},
						{10,STREETNUMBER},
						{11,STREETNAME},
						{12,STREETTYPE},
						{13,BLOCKNUMBER},
						{14,BUILDINGNAME},
						{15,CITY},
						{19,POSTALCODE},
						{20,TELEPHONE},
						{23,NRICNUMBER}]},
	{SOUTHAFRICA,[{1,FIRSTNAME},
						{2,MIDDLENAME},
						{3,LASTNAME},
						{6,YEAROFBIRTH},
						{7,MONTHOFBIRTH},
						{8,DAYOFBIRTH},
						{10,ADDRESS1},
						{11,ADDRESS2},
						{12,SUBURB},
						{13,CITY},
						{14,PROVINCE},
						{19,POSTALCODE},
						{20,TELEPHONE},
						{21,CELLNUMBER},
						{22,WORKTELEPHONE},
						{23,NATIONALIDNUMBER}]},
	{SWITZERLAND,[{1,FIRSTNAME},
						{2,LASTNAME},
						{3,GENDER},
						{6,YEAROFBIRTH},
						{7,MONTHOFBIRTH},
						{8,DAYOFBIRTH},
						{10,STREETNAME},
						{11,BUILDINGNUMBER},
						{12,UNITNUMBER},
						{15,CITY},
						{19,POSTALCODE},
						{20,TELEPHONE}]},
	{UNITEDKINGDOM,[{1,FIRSTNAME},
						{2,MIDDLENAME},
						{3,LASTNAME},
						{6,YEAROFBIRTH},
						{7,MONTHOFBIRTH},
						{8,DAYOFBIRTH},
						{10,STREETNAME},
						{12,STREETTYPE},
						{11,BUILDINGNAME},
						{12,BUILDINGNUMBER},
						{13,UNITNUMBER},
						{14,CITY},
						{19,POSTALCODE},
						{20,TELEPHONE}]}
	],Layouts.OutFields);

END;