IMPORT FraudShared,_Validate,Std,ut,tools,Data_Services;
EXPORT Build_Keys_UnitTests(
	string pversion,
	string pversion_previous  = ''
) := 
module

v := STD.File.GetSuperFileSubName('~thor_data400::key::fraudgov::qa::id', 1);
qa_version  := (string)STD.Str.SplitWords(v,'::')[4]:independent;

vVersion_previous := 
	if (pversion_previous = '', 
		qa_version,
		pversion_previous );

//AmountPaid

AmountPaid := FraudShared.Key_AmountPaid('FraudGov'); 
AmountPaid_DS	:=	Dataset([],recordof(AmountPaid));
AmountPaid_Current := Index(AmountPaid_DS,{amount_paid,entity_type_id,entity_sub_type_id},{record_id,uid},'~thor_data400::key::fraudgov::'+pversion+'::amountpaid');
AmountPaid_Previous := Index(AmountPaid_DS,{amount_paid,entity_type_id,entity_sub_type_id},{record_id,uid},'~thor_data400::key::fraudgov::'+vVersion_previous+'::amountpaid');


//Auto_address
Auto_Address := FraudShared.Key_Auto_Address('FraudGov');
Auto_Address_DS	:=	Dataset([],recordof(Auto_Address));
Auto_Address_Current := Index(Auto_Address_DS,{Auto_Address_DS},'~thor_data400::key::fraudgov::'+pversion+'::autokey::address');
Auto_Address_Previous := Index(Auto_Address_DS,{Auto_Address_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::autokey::address');

//Auto_addressb2
Auto_addressb2 := FraudShared.Key_Auto_addressb2('FraudGov');
Auto_addressb2_DS	:=	Dataset([],recordof(Auto_addressb2));
Auto_addressb2_Current := Index(Auto_addressb2_DS,{Auto_addressb2_DS},'~thor_data400::key::fraudgov::'+pversion+'::autokey::addressb2');
Auto_addressb2_Previous := Index(Auto_addressb2_DS,{Auto_addressb2_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::autokey::addressb2');

//Auto_citystname
Auto_citystname := FraudShared.Key_Auto_citystname('FraudGov');
Auto_citystname_DS	:=	Dataset([],recordof(Auto_citystname));
Auto_citystname_Current := Index(Auto_citystname_DS,{Auto_citystname_DS},'~thor_data400::key::fraudgov::'+pversion+'::autokey::citystname');
Auto_citystname_Previous := Index(Auto_citystname_DS,{Auto_citystname_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::autokey::citystname');

//Auto_citystnameb2
Auto_citystnameb2 := FraudShared.Key_Auto_citystnameb2('FraudGov');
Auto_citystnameb2_DS	:=	Dataset([],recordof(Auto_citystnameb2));
Auto_citystnameb2_Current := Index(Auto_citystnameb2_DS,{Auto_citystnameb2_DS},'~thor_data400::key::fraudgov::'+pversion+'::autokey::citystnameb2');
Auto_citystnameb2_Previous := Index(Auto_citystnameb2_DS,{Auto_citystnameb2_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::autokey::citystnameb2');

//Auto_fein2
Auto_fein2 := FraudShared.Key_Auto_fein2('FraudGov');
Auto_fein2_DS	:=	Dataset([],recordof(Auto_fein2));
Auto_fein2_Current := Index(Auto_fein2_DS,{Auto_fein2_DS},'~thor_data400::key::fraudgov::'+pversion+'::autokey::fein2');
Auto_fein2_Previous := Index(Auto_fein2_DS,{Auto_fein2_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::autokey::fein2');

//Auto_name
Auto_name := FraudShared.Key_Auto_name('FraudGov');
Auto_name_DS	:=	Dataset([],recordof(Auto_name));
Auto_name_Current := Index(Auto_name_DS,{Auto_name_DS},'~thor_data400::key::fraudgov::'+pversion+'::autokey::name');
Auto_name_Previous := Index(Auto_name_DS,{Auto_name_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::autokey::name');

//Auto_nameb2
Auto_nameb2 := FraudShared.Key_Auto_nameb2('FraudGov');
Auto_nameb2_DS	:=	Dataset([],recordof(Auto_nameb2));
Auto_nameb2_Current := Index(Auto_nameb2_DS,{Auto_nameb2_DS},'~thor_data400::key::fraudgov::'+pversion+'::autokey::nameb2');
Auto_nameb2_Previous := Index(Auto_nameb2_DS,{Auto_nameb2_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::autokey::nameb2');

//Auto_namewords2
Auto_namewords2 := FraudShared.Key_Auto_namewords2('FraudGov');
Auto_namewords2_DS	:=	Dataset([],recordof(Auto_namewords2));
Auto_namewords2_Current := Index(Auto_namewords2_DS,{Auto_namewords2_DS},'~thor_data400::key::fraudgov::'+pversion+'::autokey::namewords2');
Auto_namewords2_Previous := Index(Auto_namewords2_DS,{Auto_namewords2_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::autokey::namewords2');

//Auto_Payload
Auto_Payload := FraudShared.Key_Auto_Payload('FraudGov');
Auto_Payload_DS	:=	Dataset([],recordof(Auto_Payload));
Auto_Payload_Current := Index(Auto_Payload_DS,{fakeid},{Auto_Payload_DS},'~thor_data400::key::fraudgov::'+pversion+'::autokey::payload');
Auto_Payload_Previous := Index(Auto_Payload_DS,{fakeid},{Auto_Payload_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::autokey::payload');

//Auto_phone2
Auto_phone2 := FraudShared.Key_Auto_phone2('FraudGov');
Auto_phone2_DS	:=	Dataset([],recordof(Auto_phone2));
Auto_phone2_Current := Index(Auto_phone2_DS,{Auto_phone2_DS},'~thor_data400::key::fraudgov::'+pversion+'::autokey::phone2');
Auto_phone2_Previous := Index(Auto_phone2_DS,{Auto_phone2_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::autokey::phone2');

//Auto_phoneb2
Auto_phoneb2 := FraudShared.Key_Auto_phoneb2('FraudGov');
Auto_phoneb2_DS	:=	Dataset([],recordof(Auto_phoneb2));
Auto_phoneb2_Current := Index(Auto_phoneb2_DS,{Auto_phoneb2_DS},'~thor_data400::key::fraudgov::'+pversion+'::autokey::phoneb2');
Auto_phoneb2_Previous := Index(Auto_phoneb2_DS,{Auto_phoneb2_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::autokey::phoneb2');

//Auto_ssn2
Auto_ssn2 := FraudShared.Key_Auto_ssn2('FraudGov');
Auto_ssn2_DS	:=	Dataset([],recordof(Auto_ssn2));
Auto_ssn2_Current := Index(Auto_ssn2_DS,{Auto_ssn2_DS},'~thor_data400::key::fraudgov::'+pversion+'::autokey::ssn2');
Auto_ssn2_Previous := Index(Auto_ssn2_DS,{Auto_ssn2_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::autokey::ssn2');

//Auto_stname
Auto_stname := FraudShared.Key_Auto_stname('FraudGov');
Auto_stname_DS	:=	Dataset([],recordof(Auto_stname));
Auto_stname_Current := Index(Auto_stname_DS,{Auto_stname_DS},'~thor_data400::key::fraudgov::'+pversion+'::autokey::stname');
Auto_stname_Previous := Index(Auto_stname_DS,{Auto_stname_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::autokey::stname');

//Auto_stnameb2
Auto_stnameb2 := FraudShared.Key_Auto_stnameb2('FraudGov');
Auto_stnameb2_DS	:=	Dataset([],recordof(Auto_stnameb2));
Auto_stnameb2_Current := Index(Auto_stnameb2_DS,{Auto_stnameb2_DS},'~thor_data400::key::fraudgov::'+pversion+'::autokey::stnameb2');
Auto_stnameb2_Previous := Index(Auto_stnameb2_DS,{Auto_stnameb2_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::autokey::stnameb2');

//Auto_zip
Auto_zip := FraudShared.Key_Auto_zip('FraudGov');
Auto_zip_DS	:=	Dataset([],recordof(Auto_zip));
Auto_zip_Current := Index(Auto_zip_DS,{Auto_zip_DS},'~thor_data400::key::fraudgov::'+pversion+'::autokey::zip');
Auto_zip_Previous := Index(Auto_zip_DS,{Auto_zip_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::autokey::zip');

//Auto_zipb2
Auto_zipb2 := FraudShared.Key_Auto_zipb2('FraudGov');
Auto_zipb2_DS	:=	Dataset([],recordof(Auto_zipb2));
Auto_zipb2_Current := Index(Auto_zipb2_DS,{Auto_zipb2_DS},'~thor_data400::key::fraudgov::'+pversion+'::autokey::zipb2');
Auto_zipb2_Previous := Index(Auto_zipb2_DS,{Auto_zipb2_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::autokey::zipb2');

//BankAccount
BankAccount := FraudShared.Key_BankAccount('FraudGov');
BankAccount_DS	:=	Dataset([],recordof(BankAccount));
BankAccount_Current := Index(BankAccount_DS,{bank_account_number,entity_type_id,entity_sub_type_id},{record_id,uid},'~thor_data400::key::fraudgov::'+pversion+'::BankAccount',opt);
BankAccount_Previous := Index(BankAccount_DS,{bank_account_number,entity_type_id,entity_sub_type_id},{record_id,uid},'~thor_data400::key::fraudgov::'+vVersion_previous+'::BankAccount',opt);

//BankName
BankName := FraudShared.Key_BankName('FraudGov');
BankName_DS	:=	Dataset([],recordof(BankName));
BankName_Current := Index(BankName_DS,{bank_name,entity_type_id,entity_sub_type_id},{record_id,uid},'~thor_data400::key::fraudgov::'+pversion+'::BankName',opt);
BankName_Previous := Index(BankName_DS,{bank_name,entity_type_id,entity_sub_type_id},{record_id,uid},'~thor_data400::key::fraudgov::'+vVersion_previous+'::BankName',opt);


//BankRoutingNumber
BankRoutingNumber := FraudShared.Key_BankRoutingNumber('FraudGov');
BankRoutingNumber_DS	:=	Dataset([],recordof(BankRoutingNumber));
BankRoutingNumber_Current := Index(BankRoutingNumber_DS,{bank_routing_number ,entity_type_id,entity_sub_type_id},{record_id,uid},'~thor_data400::key::fraudgov::'+pversion+'::BankRoutingNumber',opt);
BankRoutingNumber_Previous := Index(BankRoutingNumber_DS,{bank_routing_number ,entity_type_id,entity_sub_type_id},{record_id,uid},'~thor_data400::key::fraudgov::'+vVersion_previous+'::BankRoutingNumber',opt);


//CityState
CityState := FraudShared.Key_CityState('FraudGov');
CityState_DS	:=	Dataset([],recordof(CityState));
CityState_Current := Index(CityState_DS,{p_city_name,st,entity_type_id,entity_sub_type_id},{record_id,uid},'~thor_data400::key::fraudgov::'+pversion+'::CityState');
CityState_Previous := Index(CityState_DS,{p_city_name,st,entity_type_id,entity_sub_type_id},{record_id,uid},'~thor_data400::key::fraudgov::'+vVersion_previous+'::CityState');


//CustomerId
CustomerId := FraudShared.Key_CustomerId('FraudGov');
CustomerId_DS	:=	Dataset([],recordof(CustomerId));
CustomerId_Current := Index(CustomerId_DS,{customer_id,entity_type_id,entity_sub_type_id},{record_id,uid},'~thor_data400::key::fraudgov::'+pversion+'::CustomerId');
CustomerId_Previous := Index(CustomerId_DS,{customer_id,entity_type_id,entity_sub_type_id},{record_id,uid},'~thor_data400::key::fraudgov::'+vVersion_previous+'::CustomerId');


//Deviceid
Deviceid := FraudShared.Key_Deviceid('FraudGov');
Deviceid_DS	:=	Dataset([],recordof(Deviceid));
Deviceid_Current := Index(Deviceid_DS,{device_id,entity_type_id,entity_sub_type_id},{record_id,uid},'~thor_data400::key::fraudgov::'+pversion+'::deviceid');
Deviceid_Previous := Index(Deviceid_DS,{device_id,entity_type_id,entity_sub_type_id},{record_id,uid},'~thor_data400::key::fraudgov::'+vVersion_previous+'::deviceid');

//Did
Did := FraudShared.Key_Did('FraudGov');
Did_DS	:=	Dataset([],recordof(Did));
Did_Current := Index(Did_DS,{did,entity_type_id,entity_sub_type_id},{record_id,uid},'~thor_data400::key::fraudgov::'+pversion+'::did');
Did_Previous := Index(Did_DS,{did,entity_type_id,entity_sub_type_id},{record_id,uid},'~thor_data400::key::fraudgov::'+vVersion_previous+'::did');

//DriversLicense
DriversLicense := FraudShared.Key_DriversLicense('FraudGov');
DriversLicense_DS	:=	Dataset([],recordof(DriversLicense));
DriversLicense_Current := Index(DriversLicense_DS,{drivers_license ,drivers_license_state,entity_type_id,entity_sub_type_id},{record_id,uid},'~thor_data400::key::fraudgov::'+pversion+'::DriversLicense',opt);
DriversLicense_Previous := Index(DriversLicense_DS,{drivers_license ,drivers_license_state,entity_type_id,entity_sub_type_id},{record_id,uid},'~thor_data400::key::fraudgov::'+vVersion_previous+'::DriversLicense',opt);

//Email
Email := FraudShared.Key_Email('FraudGov');
Email_DS	:=	Dataset([],recordof(Email));
Email_Current := Index(Email_DS,{email_address,entity_type_id,entity_sub_type_id},{record_id,uid},'~thor_data400::key::fraudgov::'+pversion+'::Email');
Email_Previous := Index(Email_DS,{email_address,entity_type_id,entity_sub_type_id},{record_id,uid},'~thor_data400::key::fraudgov::'+vVersion_previous+'::Email');

//Gcid_2_Mbsfdnmasterid
Gcid_2_Mbsfdnmasterid := FraudShared.Key_Gcid_2_Mbsfdnmasterid('FraudGov');
Gcid_2_Mbsfdnmasterid_DS	:=	Dataset([],recordof(Gcid_2_Mbsfdnmasterid));
Gcid_2_Mbsfdnmasterid_Current := Index(Gcid_2_Mbsfdnmasterid_DS,{gc_id},{Gcid_2_Mbsfdnmasterid_DS},'~thor_data400::key::fraudgov::'+pversion+'::gcid_2_mbsfdnmasterid');
Gcid_2_Mbsfdnmasterid_Previous := Index(Gcid_2_Mbsfdnmasterid_DS,{gc_id},{Gcid_2_Mbsfdnmasterid_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::gcid_2_mbsfdnmasterid');

//Host
Host := FraudShared.Key_Host('FraudGov');
Host_DS	:=	Dataset([],recordof(Host));
Host_Current := Index(Host_DS,{hash64_host, hash64_user, entity_type_id,entity_sub_type_id},{record_id,uid},'~thor_data400::key::fraudgov::'+pversion+'::Host');
Host_Previous := Index(Host_DS,{hash64_host, hash64_user, entity_type_id,entity_sub_type_id},{record_id,uid},'~thor_data400::key::fraudgov::'+vVersion_previous+'::Host');

//HouseholdId
HouseholdId := FraudShared.Key_HouseholdId('FraudGov');
HouseholdId_DS	:=	Dataset([],recordof(HouseholdId));
HouseholdId_Current := Index(HouseholdId_DS,{household_id,entity_type_id,entity_sub_type_id},{record_id,uid},'~thor_data400::key::fraudgov::'+pversion+'::householdid');
HouseholdId_Previous := Index(HouseholdId_DS,{household_id,entity_type_id,entity_sub_type_id},{record_id,uid},'~thor_data400::key::fraudgov::'+vVersion_previous+'::householdid');

//ID
Id := FraudShared.Key_Id('FraudGov');
Id_DS	:=	Dataset([],recordof(Id));
Id_Current := Index(Id_DS,{record_id,uid},{Id_DS},'~thor_data400::key::fraudgov::'+pversion+'::id');
Id_Previous := Index(Id_DS,{record_id,uid},{Id_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::id');


//IpRange
IpRange := FraudShared.Key_IpRange('FraudGov');
IpRange_DS	:=	Dataset([],recordof(iprange));
IpRange_Current := Index(IpRange_DS,{digit1, digit2, digit3, digit4, digit5, digit6, digit7, digit8, digit9, digit10, digit11, digit12, entity_type_id,entity_sub_type_id},{IpRange_DS},'~thor_data400::key::fraudgov::'+pversion+'::iprange');
IpRange_Previous := Index(IpRange_DS,{digit1, digit2, digit3, digit4, digit5, digit6, digit7, digit8, digit9, digit10, digit11, digit12, entity_type_id,entity_sub_type_id},{IpRange_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::iprange');

//Isp
Isp := FraudShared.Key_Isp('FraudGov');
Isp_DS	:=	Dataset([],recordof(isp));
Isp_Current := Index(Isp_DS,{Isp,entity_type_id,entity_sub_type_id},{Isp_DS},'~thor_data400::key::fraudgov::'+pversion+'::Isp');
Isp_Previous := Index(Isp_DS,{Isp,entity_type_id,entity_sub_type_id},{Isp_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::Isp');


//MacAddress
MacAddress := FraudShared.Key_MacAddress('FraudGov');
MacAddress_DS	:=	Dataset([],recordof(MacAddress));
MacAddress_Current := Index(MacAddress_DS,{mac_address,entity_type_id,entity_sub_type_id},{MacAddress_DS},'~thor_data400::key::fraudgov::'+pversion+'::MacAddress');
MacAddress_Previous := Index(MacAddress_DS,{mac_address,entity_type_id,entity_sub_type_id},{MacAddress_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::MacAddress');


//MbsFdnIndType
MbsFdnIndType := FraudShared.Key_MbsFdnIndType('FraudGov');
MbsFdnIndType_DS	:=	Dataset([],recordof(MbsFdnIndType));
MbsFdnIndType_Current := Index(MbsFdnIndType_DS,{description},{MbsFdnIndType_DS},'~thor_data400::key::fraudgov::'+pversion+'::mbsfdnindtype');
MbsFdnIndType_Previous := Index(MbsFdnIndType_DS,{description},{MbsFdnIndType_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::mbsfdnindtype');

//mbsfdnmasteridexclusion
mbsfdnmasteridexclusion := FraudShared.Key_mbsfdnmasteridexclusion('FraudGov');
mbsfdnmasteridexclusion_DS	:=	Dataset([],recordof(mbsfdnmasteridexclusion));
mbsfdnmasteridexclusion_Current := Index(mbsfdnmasteridexclusion_DS,{fdn_file_info_id},{mbsfdnmasteridexclusion_DS},'~thor_data400::key::fraudgov::'+pversion+'::mbsfdnmasteridexclusion',opt);
mbsfdnmasteridexclusion_Previous := Index(mbsfdnmasteridexclusion_DS,{fdn_file_info_id},{mbsfdnmasteridexclusion_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::mbsfdnmasteridexclusion',opt);

//mbsfdnmasteridindtypeinclusion
mbsfdnmasteridindtypeinclusion := FraudShared.Key_mbsfdnmasteridindtypeinclusion('FraudGov');
mbsfdnmasteridindtypeinclusion_DS	:=	Dataset([],recordof(mbsfdnmasteridindtypeinclusion));
mbsfdnmasteridindtypeinclusion_Current := Index(mbsfdnmasteridindtypeinclusion_DS,{fdn_file_info_id},{mbsfdnmasteridindtypeinclusion_DS},'~thor_data400::key::fraudgov::'+pversion+'::mbsfdnmasteridindtypeinclusion');
mbsfdnmasteridindtypeinclusion_Previous := Index(mbsfdnmasteridindtypeinclusion_DS,{fdn_file_info_id},{mbsfdnmasteridindtypeinclusion_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::mbsfdnmasteridindtypeinclusion');

//mbsindtypeexclusion
mbsindtypeexclusion := FraudShared.Key_mbsindtypeexclusion('FraudGov');
mbsindtypeexclusion_DS	:=	Dataset([],recordof(mbsindtypeexclusion));
mbsindtypeexclusion_Current := Index(mbsindtypeexclusion_DS,{fdn_file_info_id},{mbsindtypeexclusion_DS},'~thor_data400::key::fraudgov::'+pversion+'::mbsindtypeexclusion');
mbsindtypeexclusion_Previous := Index(mbsindtypeexclusion_DS,{fdn_file_info_id},{mbsindtypeexclusion_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::mbsindtypeexclusion');

//Mbsproductinclude
Mbsproductinclude := FraudShared.Key_Mbsproductinclude('FraudGov');
Mbsproductinclude_DS	:=	Dataset([],recordof(Mbsproductinclude));
Mbsproductinclude_Current := Index(Mbsproductinclude_DS,{fdn_file_info_id},{Mbsproductinclude_DS},'~thor_data400::key::fraudgov::'+pversion+'::mbsproductinclude');
Mbsproductinclude_Previous := Index(Mbsproductinclude_DS,{fdn_file_info_id},{Mbsproductinclude_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::mbsproductinclude');


//ReportedDate
ReportedDate := FraudShared.Key_ReportedDate('FraudGov');
ReportedDate_DS	:=	Dataset([],recordof(ReportedDate));
ReportedDate_Current := Index(ReportedDate_DS,{Reported_Date,entity_type_id,entity_sub_type_id},{ReportedDate_DS},'~thor_data400::key::fraudgov::'+pversion+'::ReportedDate');
ReportedDate_Previous := Index(ReportedDate_DS,{Reported_Date,entity_type_id,entity_sub_type_id},{ReportedDate_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::ReportedDate');

//SerialNumber
SerialNumber := FraudShared.Key_SerialNumber('FraudGov');
SerialNumber_DS	:=	Dataset([],recordof(SerialNumber));
SerialNumber_Current := Index(SerialNumber_DS,{Serial_Number,entity_type_id,entity_sub_type_id},{SerialNumber_DS},'~thor_data400::key::fraudgov::'+pversion+'::SerialNumber');
SerialNumber_Previous := Index(SerialNumber_DS,{Serial_Number,entity_type_id,entity_sub_type_id},{SerialNumber_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::SerialNumber');


//User
User := FraudShared.Key_User('FraudGov');
User_DS	:=	Dataset([],recordof(User));
User_Current := Index(User_DS,{hash64_user,hash64_host,entity_type_id,entity_sub_type_id},{User_DS},'~thor_data400::key::fraudgov::'+pversion+'::User');
User_Previous := Index(User_DS,{hash64_user,hash64_host,entity_type_id,entity_sub_type_id},{User_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::User');

//Zip
Zip := FraudShared.Key_Zip('FraudGov');
Zip_DS	:=	Dataset([],recordof(Zip));
Zip_Current := Index(Zip_DS,{zip,entity_type_id,entity_sub_type_id},{Zip_DS},'~thor_data400::key::fraudgov::'+pversion+'::Zip');
Zip_Previous := Index(Zip_DS,{zip,entity_type_id,entity_sub_type_id},{Zip_DS},'~thor_data400::key::fraudgov::'+vVersion_previous+'::Zip');


ds:= dataset([
								{'AmountPaid',count(AmountPaid_Current),count(AmountPaid_Previous)}
								,{'Auto_Address',count(Auto_Address_Current),count(Auto_Address_Previous)}
								,{'Auto_addressb2',count(Auto_addressb2_Current),count(Auto_addressb2_Previous)}
								,{'Auto_citystname',count(Auto_citystname_Current),count(Auto_citystname_Previous)}
								,{'Auto_citystnameb2',count(Auto_citystnameb2_Current),count(Auto_citystnameb2_Previous)}
								,{'Auto_fein2',count(Auto_fein2_Current),count(Auto_fein2_Previous)}
								,{'Auto_name',count(Auto_name_Current),count(Auto_name_Previous)}
								,{'Auto_nameb2',count(Auto_nameb2_Current),count(Auto_nameb2_Previous)}
								,{'Auto_namewords2',count(Auto_namewords2_Current),count(Auto_namewords2_Previous)}
								,{'Auto_phone2',count(Auto_phone2_Current),count(Auto_phone2_Previous)}
								,{'Auto_phoneb2',count(Auto_phoneb2_Current),count(Auto_phoneb2_Previous)}
								,{'Auto_ssn2',count(Auto_ssn2_Current),count(Auto_ssn2_Previous)}
								,{'Auto_stname',count(Auto_stname_Current),count(Auto_stname_Previous)}
								,{'Auto_stnameb2',count(Auto_stnameb2_Current),count(Auto_stnameb2_Previous)}
								,{'Auto_zip',count(Auto_zip_Current),count(Auto_zip_Previous)}
								,{'Auto_zipb2',count(Auto_zipb2_Current),count(Auto_zipb2_Previous)}
								,{'BankAccount',count(BankAccount_Current),count(BankAccount_Previous)}
								,{'BankName',count(BankName_Current),count(BankName_Previous)}
								,{'BankRoutingNumber',count(BankRoutingNumber_Current),count(BankRoutingNumber_Previous)}
								,{'CityState',count(CityState_Current),count(CityState_Previous)}
								,{'CustomerId',count(CustomerId_Current),count(CustomerId_Previous)}
								,{'Deviceid',count(Deviceid_Current),count(Deviceid_Previous)}
								,{'Did',count(Did_Current),count(Did_Previous)}
								,{'DriversLicense',count(DriversLicense_Current),count(DriversLicense_Previous)}						
								,{'Email',count(Email_Current),count(Email_Previous)}
								,{'Gcid_2_Mbsfdnmasterid',count(Gcid_2_Mbsfdnmasterid_Current),count(Gcid_2_Mbsfdnmasterid_Previous)}
								,{'Host',count(Host_Current),count(Host_Previous)}
								,{'HouseholdId',count(HouseholdId_Current),count(HouseholdId_Previous)}
								,{'ID',count(Id_Current),count(Id_Previous)}
								,{'IpRange',count(IpRange_Current),count(IpRange_Previous)}
								,{'Isp',count(Isp_Current),count(Isp_Previous)}
								,{'MacAddress',count(MacAddress_Current),count(MacAddress_Previous)}		
								,{'MbsFdnIndType',count(MbsFdnIndType_Current),count(MbsFdnIndType_Previous)}
								,{'mbsfdnmasteridexclusion',count(mbsfdnmasteridexclusion_Current),count(mbsfdnmasteridexclusion_Previous)}
								,{'mbsfdnmasteridindtypeinclusion',count(mbsfdnmasteridindtypeinclusion_Current),count(mbsfdnmasteridindtypeinclusion_Previous)}
								,{'mbsindtypeexclusion',count(mbsindtypeexclusion_Current),count(mbsindtypeexclusion_Previous)}
								,{'Mbsproductinclude',count(Mbsproductinclude_Current),count(Mbsproductinclude_Previous)}
								,{'ReportedDate',count(ReportedDate_Current),count(ReportedDate_Previous)}		
								,{'SerialNumber',count(SerialNumber_Current),count(SerialNumber_Previous)}		
								,{'User',count(User_Current),count(User_Previous)}
								,{'Zip',count(Zip_Current),count(Zip_Previous)}											

								// DEPRECATED
								// ,{'Appproviderid',count(Appproviderid_Current),count(Appproviderid_Previous)}
								// ,{'Auto_Payload',count(Auto_Payload_Current),count(Auto_Payload_Previous)}
								// ,{'Bdid',count(Bdid_Current),count(Bdid_Previous)}
								// ,{'County',count(County_Current),count(County_Previous)}
								// ,{'CustomerProgram',count(CustomerProgram_Current),count(CustomerProgram_Previous)}
								// ,{'Ip',count(Ip_Current),count(Ip_Previous)}
								// ,{'ClusterDetails',count(ClusterDetails_Current),count(ClusterDetails_Previous)}
								// ,{'ElementPivot',count(ElementPivot_Current),count(ElementPivot_Previous)}
								// ,{'ScoreBreakdown',count(ScoreBreakdown_Current),count(ScoreBreakdown_Previous)}
								// ,{'WeightingChart',count(WeightingChart_Current),count(WeightingChart_Previous)}
								// ,{'Linkids',count(Linkids_Current),count(Linkids_Previous)}
								// ,{'Lnpid',count(Lnpid_Current),count(Lnpid_Previous)}		
								// ,{'Mbs',count(Mbs_Current),count(Mbs_Previous)}
								// ,{'MbsDeltaBase',count(MbsDeltaBase_Current),count(MbsDeltaBase_Previous)}
								// ,{'mbsvelocityrules',count(mbsvelocityrules_Current),count(mbsvelocityrules_Previous)}
								// ,{'Npi',count(Npi_Current),count(Npi_Previous)}
								// ,{'Professionalid',count(Professionalid_Current),count(Professionalid_Previous)}
								// ,{'Tin',count(Tin_Current),count(Tin_Previous)}										

								]
						,{string keyname,unsigned Current,unsigned Previous});
	res_tbl := table(ds,{keyname,Current,Previous,difference:=(Unsigned6)Current-Previous},few);

	myReport := RECORD
		string unittest;
		string rule := 'Variance Below 1%';
		string result;
		unsigned beforec := 0;
		unsigned afterc := 0;
		string value := '';
	END;
			
	export keys_tests := project (res_tbl, transform(myReport , 
		self.unittest := left.keyname,
		self.beforec := left.Previous,
		self.afterc := left.Current,
		self.result := if ( (DECIMAL5_2)(( left.difference / left.Previous) * 100) BETWEEN 0 AND 5 ,'Passed','Review'),
		self.value := (string)left.difference + ' (' + (string)(DECIMAL5_2)(Round(( left.difference / left.Previous) * 100,2)) + '% '+if(left.difference >= 0, 'Up','Down')+')',
		self := left;));


	tools.mac_WriteFile(fraudgovplatform.Filenames(pversion).Base.KeysUnitTests.New,keys_tests,Build_Base_Test,pCompress:=true,pHeading:=false,pOverwrite:=true);

	// Return
	export full_build :=
		sequential(
			Build_Base_Test
			, Promote(pversion).buildfiles.New2Built
			, if(EXISTS(keys_tests( result  = 'Failed')),FAIL('Unit Test Failed'))
		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Build_Base_KnownFraud atribute')
	);

			
END;