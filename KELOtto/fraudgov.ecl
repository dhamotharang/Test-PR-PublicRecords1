IMPORT Std, KELOtto, FraudShared, data_services;
#CONSTANT ('Platform','FraudGov');

fraudgov_dataset_base_prep := dataset(data_services.foreign_prod+'fraudgov::base::built::Main', FraudShared.Layouts.Base.Main, thor); 

//PULL(FraudShared.files(,KELOtto.Constants.useOtherEnvironmentDali).base.Main.built);
 

// Prep!!!
// Add an address id (rawaid is always 0)
// email id
// ipaddress id

fraudgov_dataset_base := PROJECT(fraudgov_dataset_base_prep, 
                       TRANSFORM({
                         RECORDOF(LEFT), 
                         STRING SsnFormatted, 
                         STRING Phone_Number_Formatted, 
                         STRING Cell_phone_Formatted, 
                         UNSIGNED8 OttoAddressId, 
                         UNSIGNED8 OttoIpAddressId, 
                         UNSIGNED8 OttoEmailId, 
                         UNSIGNED8 OttoSSNId,
                         UNSIGNED8 OttoBankAccountId,
                         UNSIGNED8 OttoBankAccountId2,
                         UNSIGNED8 OttoDriversLicenseId},
                       SELF.bank_account_number_1 := TRIM(LEFT.bank_account_number_1, LEFT, RIGHT),
                       SELF.bank_account_number_2 := TRIM(LEFT.bank_account_number_2, LEFT, RIGHT),
                       SELF.SsnFormatted := LEFT.ssn[1..3] + '-' + LEFT.ssn[4..5] + '-' + LEFT.ssn[6..9], 
                       SELF.Phone_Number_Formatted := MAP(TRIM(LEFT.clean_phones.phone_number) !='' => '(' + LEFT.clean_phones.phone_number[1..3] + ') ' + LEFT.clean_phones.phone_number[4..6] + '-' + LEFT.clean_phones.phone_number[7..10], ''),
                       SELF.Cell_phone_Formatted := MAP(TRIM(LEFT.clean_phones.cell_phone) != '' => '(' + LEFT.clean_phones.cell_phone[1..3] + ') ' + LEFT.clean_phones.cell_phone[4..6] + '-' + LEFT.clean_phones.cell_phone[7..10], ''),
											 SELF.OttoAddressId := HASH32(LEFT.address_1, LEFT.address_2),
											 SELF.OttoIpAddressId := HASH32(LEFT.ip_address), 
											 SELF.OttoEmailId := HASH32(LEFT.email_address),
                       SELF.OttoSSNId := HASH32(LEFT.ssn),
                       SELF.OttoBankAccountId := HASH32(TRIM(LEFT.bank_routing_number_1, LEFT, RIGHT) + '|' + TRIM(LEFT.bank_account_number_1, LEFT, RIGHT)),
                       SELF.OttoBankAccountId2 := HASH32(TRIM(LEFT.bank_routing_number_2, LEFT, RIGHT) + '|' + TRIM(LEFT.bank_account_number_2, LEFT, RIGHT)),
                       SELF.OttoDriversLicenseId := HASH32(LEFT.drivers_license),
                       // fake bank account and dl risk stuff for testing JP
                       /*
                       SELF.event_type_1 := MAP(LEFT.bank_account_number_1 != '' => CHOOSE((HASH32(LEFT.record_id) % 8)+1, '203','291','202','204','292','200','201','293'), ''),
                       SELF.event_type_2 := MAP(LEFT.drivers_license != '' => CHOOSE((HASH32(LEFT.record_id) % 7)+1, '800','891','801','802','892','893','890'),''),
                       */
                       // end of test code.
											 SELF := LEFT));

// trim the data down for R&D speed.

Set_did:=[1488418290,8389852385,1921409109,2435345412,1834342568,1589581232];

// filter out spurious transactions in the future.
fraudgov_dataset := fraudgov_dataset_base((UNSIGNED)event_date <= Std.Date.Today());// and (did % 3 in [0] OR did = 899999999550 or ssn = '294287743' or event_type_1 = '10000' or bank_account_number_1 != '' or drivers_license != '' or did in set_did));

final := DISTRIBUTE(fraudgov_dataset);

EXPORT fraudgov := final;