IMPORT Std, FraudgovKEL, FraudShared, data_services, ut,doxie,Suppress;
#CONSTANT ('Platform','FraudGov');
RunKelDemo :=false:stored('RunKelDemo');

FileIn := If(RunKelDemo=false,'fraudgov::base::built::Main','fraudgov::in::sprayed::demodata');

fraudgov_dataset_Input := dataset(data_services.foreign_prod+FileIn, FraudShared.Layouts.Base.Main, thor); 

// Supress CCPA
mod_access := MODULE(doxie.IDataAccess) END; // default mod_access
Supress_CCPA := Suppress.MAC_SuppressSource(fraudgov_dataset_Input, mod_access, did, NULL,TRUE);			

fraudgov_dataset_base_prep	:= Supress_CCPA;

//PULL(FraudShared.files(,FraudgovKEL.Constants.useOtherEnvironmentDali).base.Main.built);
 

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

Main         :=  FraudShared.Layouts.Base.Main - cleaned_name;

fraudgov_dataset_base := PROJECT(fraudgov_dataset_base_prep, 
                       TRANSFORM({
                         Main, 
												 Layout_Clean_name cleaned_name,
                         STRING SsnFormatted, 
                         STRING Phone_Number_Formatted, 
                         STRING Cell_phone_Formatted, 
												 STRING Work_phone_Formatted,
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
											 SELF.Work_phone_Formatted := MAP(TRIM(LEFT.clean_phones.work_phone) != '' => '(' + LEFT.clean_phones.work_phone[1..3] + ') ' + LEFT.clean_phones.work_phone[4..6] + '-' + LEFT.clean_phones.work_phone[7..10], ''),
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


Set_incarcerated :=[1827476821,534129826,526759047,527051771,1821981777,6672297807,593005830,148817897437,367245121,675778281,1915541466,3481771341,2276270774,870827823,1383194201,46497666030,436144045,2679710352,188867426707,43877742503,765854572,148780558675,1749351853,1501573728,31586766681,1114876192,1934356903,1850405015,1371817878,167401080066,2396718209,756376509,193953567453,2577902354,2713111104,1660387572,2508979098,36651851059,6601023603,237186462711,659231636,150191143780,1494665688,1161797222,142067250441,149836013443,139402809773,2159071645,113144129980,376586860,402345123,167509230,114634410852,1106655635,2186532992,2316117104,168028641252,2595547542,141004135630,15173002,1140618113,147322718713,108379862872,0,4230168185,444324819,38973667625,211832407,2722023829,2154752325,2727354695,1101484466,237413401954,13931228315,148795771274,301563514,122751249706,1671090744,1748628418,1888126032,154508991757,1617342537,13057073917,155542429498,533687812,668687990,223311182,105003805884,753550513,224223671,1483643237,450630455,13874269785,2588542324,108663767933,7507222963,64893769376,193048736507,191446594631,37876922];
Set_deceased:=[005833281834,001221827365,002209147253,001121716198,001892209088,001015604649,006596394694,001572128934,001626021421,000366396035,002082436265,000067483195,193624502313,001223722398,005932460606,002448688047,000832128245,001920526549,000667829288,001135744453,000930695925,002076432220,002325394720,002650916976,001118089236,001591026867,006599937540,001248312984,002419000127,001154915008,000953608420,000300538964,000022789263,190422171676,002454663194,001879567162,000408622523,002194326335,154000969919,002191250495,000677223347,190240556257,001538005865,001945222164,000161911916,000774366026,001413067774,038562693324,038562693324,000466370453,001609447496,001774357015,000521898550,043843880213,001506286503,000036296523,002243815736,001618782818,002588210869,000502808424,002476722094,000166164997,002386852440,000783005329,000685235819,000873656160,000843589875,000032085445,006676580373,002244721351,001562280857,002210304308,000036389194,002083789087,060012961335,000771778303,134331934516,014027789599,001192633844,002164675371,005882637569,002407266410,238181708623,001717322926,002306408759,000022298459,001521767177,001425532139,000220376278,001114418758,000375896705,000523261063,001948275730,183279543021,194042664866,000551358055,001186200784,000015171447,001775135918];
Set_Addresses := [12638153115695167395,10246789559473286115];

tempFinal := DATASET('~foreign::10.173.14.201::temp::fraudgov', RECORDOF(Final), THOR);//(did in Set_incarcerated OR did in Set_deceased or did % 1000000 = 1 or OttoAddressId in Set_Addresses);

EXPORT fraudgov := Final;//final; // tempFinal; // 