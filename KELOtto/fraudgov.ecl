IMPORT Std, FraudGovPlatform, KELOtto, data_services, ut,doxie,Suppress;
#CONSTANT ('Platform','FraudGov');
RunKelDemo :=false:stored('RunKelDemo');

FileIn := If(RunKelDemo=false,'fraudgov::base::built::Main','fraudgov::in::sprayed::demodata');

fraudgov_dataset_Input := dataset(data_services.foreign_prod+FileIn, FraudGovPlatform.Layouts.Base.Main, thor); 

// Supress CCPA
mod_access := MODULE(doxie.IDataAccess) END; // default mod_access
Supress_CCPA := Suppress.MAC_SuppressSource(fraudgov_dataset_Input, mod_access, did, NULL,TRUE);			

fraudgov_dataset_base_prep	:= Supress_CCPA;

//PULL(FraudGovPlatform.files(,KELOtto.Constants.useOtherEnvironmentDali).base.Main.built);
 

// Prep!!!
// Add an address id (rawaid is always 0)
// email id
// ipaddress id
//Need to define layout to remove the string20 for the cleaned name to avoid confusing KEL
Layout_Clean_Name := 	record
	string  title					;
	string fname					;
	string mname					;
	string lname					;
	string name_suffix		;
	string  name_score			;
end;

Main         :=  FraudGovPlatform.Layouts.Base.Main - cleaned_name;

fraudgov_dataset_base := PROJECT(fraudgov_dataset_base_prep, 
                       TRANSFORM({
                         Main, 
												 Layout_Clean_name cleaned_name,
                         STRING SsnFormatted, 
                         STRING Phone_Number_Formatted, 
                         STRING Cell_phone_Formatted, 
												 STRING EmailLastDomain,
                         UNSIGNED8 OttoAddressId, 
                         UNSIGNED8 OttoIpAddressId, 
                         UNSIGNED8 OttoEmailId, 
                         UNSIGNED8 OttoSSNId,
                         UNSIGNED8 OttoBankAccountId,
                         UNSIGNED8 OttoBankAccountId2,
                         UNSIGNED8 OttoDriversLicenseId,
                         UNSIGNED2 Confidence_that_activity_was_deceitful_id}, 
												 //STRING2 Customer_State},
											 SELF.EmailLastDomain := Std.Str.ToUpperCase(Std.Str.SplitWords(LEFT.email_Address, '.')[Std.Str.CountWords(LEFT.email_address, '.')]),
                       SELF.bank_account_number_1 := TRIM(LEFT.bank_account_number_1, LEFT, RIGHT),
                       SELF.bank_account_number_2 := TRIM(LEFT.bank_account_number_2, LEFT, RIGHT),
                       SELF.SsnFormatted := LEFT.ssn[1..3] + '-' + LEFT.ssn[4..5] + '-' + LEFT.ssn[6..9], 
                       SELF.Phone_Number_Formatted := MAP(TRIM(LEFT.clean_phones.phone_number) !='' => '(' + LEFT.clean_phones.phone_number[1..3] + ') ' + LEFT.clean_phones.phone_number[4..6] + '-' + LEFT.clean_phones.phone_number[7..10], ''),
                       SELF.Cell_phone_Formatted := MAP(TRIM(LEFT.clean_phones.cell_phone) != '' => '(' + LEFT.clean_phones.cell_phone[1..3] + ') ' + LEFT.clean_phones.cell_phone[4..6] + '-' + LEFT.clean_phones.cell_phone[7..10], ''),
											 SELF.OttoAddressId := HASH64(TRIM(LEFT.address_1)+ '|' + TRIM(LEFT.address_2)), 
											 SELF.OttoIpAddressId := HASH64(LEFT.ip_address), 
											 SELF.OttoEmailId := HASH64(LEFT.email_address),
                       SELF.OttoSSNId := HASH64(LEFT.ssn),
                       SELF.OttoBankAccountId := HASH64(TRIM(LEFT.bank_routing_number_1, LEFT, RIGHT) + '|' + TRIM(LEFT.bank_account_number_1, LEFT, RIGHT)),
                       SELF.OttoBankAccountId2 := HASH64(TRIM(LEFT.bank_routing_number_2, LEFT, RIGHT) + '|' + TRIM(LEFT.bank_account_number_2, LEFT, RIGHT)),
                       SELF.OttoDriversLicenseId := HASH64(STD.Str.CleanSpaces(TRIM(LEFT.drivers_license, LEFT, RIGHT)+ '|' + TRIM(LEFT.drivers_license_state, LEFT, RIGHT))),
                       SELF.Confidence_that_activity_was_deceitful_id := LEFT.classification_Activity.Confidence_that_activity_was_deceitful_id,
											 SELF.event_date := MAP(LEFT.event_date = '' => MAP(LEFT.ln_report_date='' => '20100101', LEFT.ln_report_date), LEFT.event_date), 											 
											 //SELF.Customer_State := LEFT.classification_source.Customer_State,
                       // fake bank account and dl risk stuff for testing JP
                       /*
                       SELF.event_type_1 := MAP(LEFT.bank_account_number_1 != '' => CHOOSE((HASH32(LEFT.record_id) % 8)+1, '203','291','202','204','292','200','201','293'), ''),
                       SELF.event_type_2 := MAP(LEFT.drivers_license != '' => CHOOSE((HASH32(LEFT.record_id) % 7)+1, '800','891','801','802','892','893','890'),''),
                       */
                       // end of test code.
											 // Clean name to avoid blank labels
											 SELF.cleaned_name.fname := TRIM(ut.fn_RemoveSpecialChars(LEFT.cleaned_name.fname)),
											 SELF.cleaned_name.lname := TRIM(ut.fn_RemoveSpecialChars(LEFT.cleaned_name.lname)),
											 SELF := LEFT));

// trim the data down for R&D speed.

Set_record_id:=[59386231,59812325,78505368,82750428,13496281,64149144,74043112,36862566,27306783,16682315,24115489,64277425,54716128,39415142,74043117,46852676,64700532,16682317,30490796,6310390,12222565,79991118,61730801,18596980,1810079,8817473,73619491,24755656,24967707,3722291,69378543,55354691,83175873,31128598,37075118,67675944,29643810,68953831];

Set_did:=[101469336770, 2064197553,199600630,802421875,1612657577,1375235801,1466482754,1215789174,2231445703,1056261901,464680867,102723930787,298166078,1752427243,1213942861,1970080308,1894039365,2248303771,529728450,1357828170,2578799228,2773009559,56371566];

// filter out spurious transactions in the future.
fraudgov_dataset := fraudgov_dataset_base((UNSIGNED)event_date <= Std.Date.Today() and did != 1);//  AND (record_id in Set_record_id OR did % 100000 in [0] OR did = 899999999550 OR email_address != '' or ssn = '294287743' or event_type_1 = '10000' or ip_address[1..3] = '209' or bank_account_number_1 != '' or drivers_license != '' or did in set_did OR classification_Activity.Confidence_that_activity_was_deceitful_id = 3));

final := DISTRIBUTE(fraudgov_dataset);

EXPORT fraudgov := final;