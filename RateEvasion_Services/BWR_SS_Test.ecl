/* This member is RateEvasion_Services.BWR_SS_test */
#STORED ('DPPAPurpose',4);
#STORED ('GLBPurpose',5);

//#STORED('IncludeIdentity','true');
//#STORED('IncludeScore','true');
//#STORED('IncludePreviousAddresses','true');
//#STORED('IncludeReversePhoneLookup','true');
//#STORED('IncludeDriverLicense','true');
//#STORED('IncludeMotorVehicles','true');
//#STORED('IncludeBrandedTitles','true');
//#STORED('IncludeAdditionalDrivers','true');
//#STORED('IncludePotentialAdditionalDrivers','true');



RateEvasion_Services.SearchService()

/*
#STORED ('DPPAPurpose',4);
#STORED ('GLBPurpose',5);
#STORED ('SSNMask','FIRST5'); OR ...'LAST4 OR ...'ALL'

#STORED('IncludeIdentity','true');
#STORED('IncludeScore','true');
#STORED('IncludePreviousAddresses','true');
#STORED('IncludeReversePhoneLookup','true');
#STORED('IncludeDriverLicense','true');
#STORED('IncludeMotorVehicles','true');	
#STORED('IncludeBrandedTitles','true');
#STORED('IncludeAdditionalDrivers','true');
#STORED('IncludePotentialAdditionalDrivers','true');

//all search fields
#STORED('UnParsedFullName','');
#STORED('FirstName','');
#STORED('MiddleName','');
#STORED('LastName','');
#STORED('NameSuffix','Jr');  // find an example in the data ???
//#STORED('Prefix','Dr');  // find an example in the data ???

#STORED('prim_range','1234');
#STORED('predir','N');
#STORED('prim_name','main');
#STORED('postdir','S');
#STORED('suffix','ST');
#STORED('sec_range','1');
#STORED('Addr',' ');
#STORED('City','cccccc');
#STORED('State','xx');
#STORED('Zip','12345');
//County 
//PostalCode
//StateCityZip

// AKAs                                                             ???
// Previous Address                                             ???

#STORED('phone','aaapppxxxx');
#STORED('DriversLicense',' ');
#STORED('DLState','xx');
#STORED('SSN','123456789');
#STORED('DOBYear','yyyy'); //???
#STORED('DOBMonth','mm'); //???
#STORED('DOBDay','dd'); //???
#STORED('VIN',' ');  // version 1
#STORED('VINs','1 2 3 4 5 6 7 8'); // version2                                 ???

#STORED('did','2769187182'); //the did for David A Wright


// ********* OPTIONS **********
//test here in BWR or on roxie 1way with xml input??? 
#STORED('StrictMatch','false');  //??? 

#STORED('allowNicknames','true'); // or UseNickNames ???
#STORED('PhoneticMatch','true'); // or UsePhonetics ???
#STORED('IncludeAlsoFound','true'); // or use NoDeepDive=false ???
#STORED ('PenaltThreshold',5);  // or strictmatch=false???
#STORED('StartingRecord','1');


//***************** Specific tests ****************

// test various combinations of include* options
#STORED('IncludeIdentity','true');
#STORED('IncludeScore','true');
#STORED('IncludePreviousAddresses','true');
#STORED('IncludeReversePhoneLookup','true');
#STORED('IncludeDriverLicense','true');
#STORED('IncludeMotorVehicles','true');
//#STORED('IncludeBrandedTitles','true');
#STORED('IncludeAdditionalDrivers','true');
#STORED('IncludePotentialAdditionalDrivers','true');


// test1a search by name & city & state - Returns 1 person in moxie
//#STORED('StrictMatch','true');
#STORED('FirstName','david');
#STORED('MiddleName','a');
#STORED('LastName','wright');
#STORED('City','brookville');
#STORED('State','OH');

// test1b search by name & address? - Returns 1 person in moxie
#STORED('StrictMatch','true'); //???
#STORED('FirstName','james');
//#STORED('MiddleName','l');
#STORED('LastName','knapp');
#STORED('prim_range','307');
//#STORED('predir','');
#STORED('prim_name','brooke woode');
//#STORED('postdir','');
#STORED('suffix','dr');
//#STORED('sec_range','');
//#STORED('Addr','307 brooke woode dr');
#STORED('City','brookville');
#STORED('State','OH');
#STORED('Zip','45309');

// test2a search by SSN - 
#STORED('SSN','298387726'); // james l knapp
#STORED('SSN','516602238'); // elizabth j knapp
#STORED('SSN','285525529'); // david a wright
// test2b search by SSN - Returns OthersWithSameSSN info
#STORED('SSN','295709531'); // alva l wright
// test2c search by a deceased SSN - Returns SSNInfo area with deceased field info
#STORED('SSN','298072844'); // merrill e wright

// test3 search by name & dob - 
#STORED('FirstName','james');
//#STORED('MiddleName','l');
#STORED('LastName','knapp');
#STORED('DOBYear','1945');
#STORED('DOBMonth','11');
#STORED('DOBDay','09');

// test4 search by name? & phone# - 
//#STORED('FirstName','james');
//#STORED('MiddleName',' ');
//#STORED('LastName','knapp');
#STORED('phone','9378336806');

// test5a search by name? & DL#/State - 
//#STORED('FirstName','james');
//#STORED('MiddleName','l');
//#STORED('LastName','knapp');
#STORED('DriversLicense','RT268382');  //james l knapp
#STORED('DLState','OH');
// test5b search by name & DL#/State - 
//#STORED('FirstName','elizabeth
//#STORED('MiddleName','j);
//#STORED('LastName','knapp');
#STORED('DriversLicense','RG663780');  //elizabeth j knapp
#STORED('DLState','OH');
// test5c search by DL#/State - 
//#STORED('FirstName','david');
//#STORED('MiddleName','a');
//#STORED('LastName','wright');
#STORED('DriversLicense','RN742031');  //david a wright
#STORED('DLState','OH');

//!!! HAVE NOT TRIED SOAP VINs FIELD YET, MAY NEED TO CHANGE TO VIN (NO s)  type=xsd:string
// test6a search by name? & 1 vin - 
//interation_key=20080903OHAE & 20080903OHDI
//#STORED('FirstName','james');
//#STORED('MiddleName','l');
//#STORED('LastName','knapp');
#STORED('VINs','1GCDC14K8PZ122802'); // 19?? Chevy/GMC? pick-up truck

// test6b search by name? & 1 vin - 
//interation_key=20080109OHAE & 20090126OHDI
//#STORED('FirstName','elizabeth
//#STORED('MiddleName','j);
//#STORED('LastName','knapp');
#STORED('VINs','5FNRL38456B413291'); // 200? Honda Odessey? 

// test6c search by name? & 1 vin - 
//interation_key=20080109OHAE??? & 20090126OHDI???
//#STORED('FirstName','david');
//#STORED('MiddleName','a');
//#STORED('LastName','wright');
#STORED('VINs','1HGEJ6676XL037543');  // 1999 Honda Civic
//#STORED('VINs','1GCNDX03E2WD170695'); // 1998 Chevy Venture

// test6d search by name? & 2 VINs -
//#STORED('FirstName','david');
//#STORED('MiddleName','a');
//#STORED('LastName','wright');
#STORED('VINs','1HGEJ6676XL037543 1GCNDX03E2WD170695');
//#STORED('VINs','1 2 3 4 5 6 7 8');                                      ???

//test7 - did searching
#STORED('did','1408992236'); // james l knapp
#STORED('did','1408345777'); // elizabeth j knapp
#STORED('did','2769187182'); // david a wright
#STORED('did','2769187182'); // david a wright


******test options:
nicknames on
phonetics on
strictmatch on and off
includealsofound/deepdive  negate in ss first???
pulled did/ssn (find one on the pulled file also in the header data???)
ssnmask=FIRST5???

//******
//nicknames test, finds gerald wright in ???
#STORED('FirstName','gerry');
#STORED('LastName','wright');
#STORED('Zip','     ');
#STORED('allowNicknames','true');

//phonetics test - should find ??? wright in ???
#STORED('FirstName','????');
#STORED('LastName','right');
#STORED('Zip','?????');
#STORED('PhoneticMatch','true');

//deepdive test - when IAF set to true, returns 3 annie b walkers in 32310 + 1 in 32304
#STORED('UnParsedFullName','annie b walker');
#STORED('Zip','32310');
#STORED('IncludeAlsoFound','true'); // NOTE: do this through xml input on roxie wsecl; 
                                    // using nodeepdive=false in a BWR does not work. 


*/
// For testing/debugging in a web form xml text area
//SearchService ();
/*
<RateEvasionSearchRequest>
<row>
<User>
  <ReferenceCode></ReferenceCode>
  <BillingCode></BillingCode>
  <QueryId></QueryId>
  <GLBPurpose></GLBPurpose>
  <DLPurpose></DLPurpose>
  <SSNMask></SSNMask>
  <EndUser>
    <CompanyName></CompanyName>
    <StreetAddress1></StreetAddress1>
    <City></City>
    <State></State>
    <Zip5></Zip5>
  </EndUser>
  <MaxWaitSeconds></MaxWaitSeconds>
</User>
<CarFaxUniqueId></CarFaxUniqueId>
<TargetCompanyId></TargetCompanyId>
<Options>
  <StrictMatch>false</StrictMatch>
  <UseNicknames>false</UseNicknames>
  <IncludeAlsoFound>false</IncludeAlsoFound>
  <UsePhonetics>false</UsePhonetics>
	<PenaltyThreshold>20</PenaltyThreshold>
  <StartingRecord>1</StartingRecord>
	<IncludeIdentity>false</IncludeIdentity>
	<IncludeScore>false</IncludeScore>
	<IncludePreviousAddresses>false</IncludePreviousAddresses>
	<IncludeReversePhoneLookup>false</IncludeReversePhoneLookup>
	<IncludeDriverLicense>false</IncludeDriverLicense>
	<IncludeMotorVehicles>false</IncludeMotorVehicles>
	<IncludeBrandedTitles>false</IncludeBrandedTitles>
	<IncludeAdditionalDrivers>false</IncludeAdditionalDrivers>
	<IncludePotentialAdditionalDrivers>false</IncludePotentialAdditionalDrivers>
</Options>
<SearchBy>
  <Name>
    <Full></Full>
    <First></First>
    <Middle></Middle>
    <Last></Last>
    <Suffix></Suffix>
    <Prefix></Prefix>
  </Name>
  <Address>
    <StreetName></StreetName>
    <StreetNumber></StreetNumber>
    <StreetPreDirection></StreetPreDirection>
    <StreetPostDirection></StreetPostDirection>
    <StreetSuffix></StreetSuffix>
    <UnitDesignation></UnitDesignation>
    <UnitNumber></UnitNumber>
    <StreetAddress1></StreetAddress1>
    <StreetAddress2></StreetAddress2>
    <State></State>
    <City></City>
    <Zip5></Zip5>
    <Zip4></Zip4>
    <County></County>
    <PostalCode></PostalCode>
    <StateCityZip></StateCityZip>
  </Address>
  <AKA>
    <Full></Full>
    <First></First>
    <Middle></Middle>
    <Last></Last>
    <Suffix></Suffix>
    <Prefix></Prefix>
  </AKA>
  <PreviousAddress>
    <StreetName></StreetName>
    <StreetNumber></StreetNumber>
    <StreetPreDirection></StreetPreDirection>
    <StreetPostDirection></StreetPostDirection>
    <StreetSuffix></StreetSuffix>
    <UnitDesignation></UnitDesignation>
    <UnitNumber></UnitNumber>
    <StreetAddress1></StreetAddress1>
    <StreetAddress2></StreetAddress2>
    <State></State>
    <City></City>
    <Zip5></Zip5>
    <Zip4></Zip4>
    <County></County>
    <PostalCode></PostalCode>
    <StateCityZip></StateCityZip>
  </PreviousAddress>
  <SSN></SSN>
  <DOB>
    <Year></Year>
    <Month></Month>
    <Day></Day>
  </DOB>
  <Phone10></Phone10>
  <DriversLicenseNumber></DriversLicenseNumber>
  <DriversLicenseState></DriversLicenseState>
  <VINs>
	  <VIN></VIN>
	  <VIN></VIN>
	  <VIN></VIN>
	  <VIN></VIN>
    <VIN></VIN>
	  <VIN></VIN>
	  <VIN></VIN>
	  <VIN></VIN>
	</VINs/>
</SearchBy>
</row>
</RateEvasionSearchRequest>
*/
