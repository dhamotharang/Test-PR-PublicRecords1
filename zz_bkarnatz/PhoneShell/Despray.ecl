// EXPORT Despray := 'todo';

import std;

#workunit('name','PhoneShell Despray');

// RunDate := '20181210_PhonesPlusv2';
// RunDate := '20190125_PhonesPlusv2_GongNeustar';
// RunDate := '20190206_PhonesPlusv2_GongNeustar';
// RunDate := '20190211_PhonesPlusv2_GongNeustar';
// RunDate := '20190221_PhonesPlusv2_GongNeustar';
// RunDate := '20190227_PhonesPlusv2_GongNeustar';
// RunDate := '20190305_PhonesPlusv2_GongNeustar';
// RunDate := '20190311_PhonesPlusv2_GongNeustar';
// RunDate := '20190320_PhonesPlusv2_GongNeustar';
RunDate := '20190326_PhonesPlusv2_GongNeustar';

//Files

File1 := 'scoringqa::out::phone_shell_version_10_phonesplusv2_gong_neustar_gateway_restrictions_base_20181217b_nov18_jan19_input_modelinglayout_w20190326-135254.csv';
File2 := 'scoringqa::out::phone_shell_version_10_phonesplusv2_gong_neustar_nogateway_restrictions_base_20181217b_nov18_jan19_input_modelinglayout_w20190326-135254.csv';
File3 := 'scoringqa::out::phone_shell_version_10_phonesplusv2_gong_neustar_gateway_restrictions_second_20181219b_nov18_jan19_input_modelinglayout_w20190325-194720.csv';
File4 := 'scoringqa::out::phone_shell_version_10_phonesplusv2_gong_neustar_nogateway_restrictions_second_20181219b_nov18_jan19_input_modelinglayout_w20190325-194720.csv';

std.file.despray('~' + file1,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file1[17..],,,,true);  
std.file.despray('~' + file2,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file2[17..],,,,true);  
std.file.despray('~' + file3,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file3[17..],,,,true);  
std.file.despray('~' + file4,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file4[17..],,,,true);  


// File1 := 'scoringqa::out::phone_shell_version_10_phonesplusv2_gong_neustar_gateway_norestrictions_second_20181219b_neustar_exclusive_modelinglayout_w20190320-151729.csv';
// std.file.despray('~' + file1,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file1[17..],,,,true);
// File2 := 'scoringqa::phoneshell::nuestar_exclusive_records_5k.csv';
// std.file.despray('~' + File2,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + File2[24..],,,,true);



// File1 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_gateway_norestrictions_second_20181219b_inputphoneblanked_modelinglayout_w20190306-125533.csv';
// std.file.despray('~' + file1,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file1[17..],,,,true);



// File3 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_gateway_norestrictions_base_20181217b_modelinglayout_w20190304-211834.csv';
// File4 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_gateway_restrictions_base_20181217b_modelinglayout_w20190304-211834.csv';
// File5 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_nogateway_norestrictions_base_20181217b_modelinglayout_w20190304-211834.csv';
// File6 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_nogateway_restrictions_base_20181217b_modelinglayout_w20190304-211834.csv';
// File7 := 'scoringqa::out::bocashell_41_nonfcra_may_july_phonesplusv2_gong_neustar_norestrictions_base_20181217b_w20190304-211834_edina_v41_w20190304-211834.csv';
// File8 := 'scoringqa::out::bocashell_41_nonfcra_may_july_phonesplusv2_gong_neustar_restrictions_base_20181217b_w20190304-211834_edina_v41_w20190304-211834.csv';
// File9 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_gateway_norestrictions_second_20181219b_modelinglayout_w20190305-122006.csv';
// File10 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_gateway_restrictions_second_20181219b_modelinglayout_w20190305-122006.csv';
// File11 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_nogateway_norestrictions_second_20181219b_modelinglayout_w20190305-122006.csv';
// File12 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_nogateway_restrictions_second_20181219b_modelinglayout_w20190305-122006.csv';
// File13 := 'scoringqa::out::bocashell_41_nonfcra_may_july_phonesplusv2_gong_neustar_norestrictions_second_20181219b_w20190305-122006_edina_v41_w20190305-122006.csv';
// File14 := 'scoringqa::out::bocashell_41_nonfcra_may_july_phonesplusv2_gong_neustar_restrictions_second_20181219b_w20190305-122006_edina_v41_w20190305-122006.csv';

// Parallel(
// std.file.despray('~' + file3,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file3[17..],,,,true),  
// std.file.despray('~' + file4,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file4[17..],,,,true),  
// std.file.despray('~' + file5,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file5[17..],,,,true),  
// std.file.despray('~' + file6,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file6[17..],,,,true),  
// std.file.despray('~' + file7,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file7[17..],,,,true),  
// std.file.despray('~' + file8,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file8[17..],,,,true), 
// std.file.despray('~' + file9,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file9[17..],,,,true),
// std.file.despray('~' + file10,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file10[17..],,,,true), 
// std.file.despray('~' + file11,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file11[17..],,,,true), 
// std.file.despray('~' + file12,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file12[17..],,,,true), 
// std.file.despray('~' + file13,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file13[17..],,,,true), 
// std.file.despray('~' + file14,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file14[17..],,,,true)); 



// File1 := 'scoringqa::out::fp202_attributes_gongneustar_phonesplusv2_20181217b_base_w20190227-140623';
// File2 := 'scoringqa::out::fp202_attributes_gongneustar_phonesplusv2_20181219b_second_w20190226-184200';
// File3 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_gateway_norestrictions_base_20181217b_modelinglayout_w20190227-141035.csv';
// File4 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_gateway_restrictions_base_20181217b_modelinglayout_w20190227-141035.csv';
// File5 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_nogateway_norestrictions_base_20181217b_modelinglayout_w20190227-141035.csv';
// File6 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_nogateway_restrictions_base_20181217b_modelinglayout_w20190227-141035.csv';
// File7 := 'scoringqa::out::bocashell_41_nonfcra_may_july_phonesplusv2_gong_neustar_norestrictions_base_20181217b_w20190227-141035_edina_v41_w20190227-141035.csv';
// File8 := 'scoringqa::out::bocashell_41_nonfcra_may_july_phonesplusv2_gong_neustar_restrictions_base_20181217b_w20190227-141035_edina_v41_w20190227-141035.csv';
// File9 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_gateway_norestrictions_second_20181219b_modelinglayout_w20190226-184107.csv';
// File10 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_gateway_restrictions_second_20181219b_modelinglayout_w20190226-184107.csv';
// File11 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_nogateway_norestrictions_second_20181219b_modelinglayout_w20190226-184107.csv';
// File12 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_nogateway_restrictions_second_20181219b_modelinglayout_w20190226-184107.csv';
// File13 := 'scoringqa::out::bocashell_41_nonfcra_may_july_phonesplusv2_gong_neustar_norestrictions_second_20181219b_w20190227-074209_edina_v41_w20190227-074209.csv';
// File14 := 'scoringqa::out::bocashell_41_nonfcra_may_july_phonesplusv2_gong_neustar_restrictions_second_20181219b_w20190227-074209_edina_v41_w20190227-074209.csv';


// std.file.despray('~' + file1,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file1[17..],,,,true);  
// std.file.despray('~' + file2,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file2[17..],,,,true);  
// std.file.despray('~' + file3,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file3[17..],,,,true);  
// std.file.despray('~' + file4,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file4[17..],,,,true);  
// std.file.despray('~' + file5,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file5[17..],,,,true);  
// std.file.despray('~' + file6,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file6[17..],,,,true);  
// std.file.despray('~' + file7,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file7[17..],,,,true);  
// std.file.despray('~' + file8,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file8[17..],,,,true); 
// std.file.despray('~' + file9,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file9[17..],,,,true); 
// std.file.despray('~' + file10,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file10[17..],,,,true); 
// std.file.despray('~' + file11,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file11[17..],,,,true); 
// std.file.despray('~' + file12,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file12[17..],,,,true); 
// std.file.despray('~' + file13,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file13[17..],,,,true); 
// std.file.despray('~' + file14,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file14[17..],,,,true); 



// File1 := 'scoringqa::out::busshell_22_gongneustar_phonesplusv2_20181217b_base_w20190220-182833_sas_layout_busshell.csv';
// File2 := 'scoringqa::out::sba_nonsbfe_score_gongneustar_phonesplusv2_20181217b_base_w20190220-182833';
// File3 := 'scoringqa::out::fp202_attributes_gongneustar_phonesplusv2_20181217b_base_w20190220-183021';
// File4 := 'scoringqa::out::biid_20_gongneustar_phonesplusv2_20181217b_base_w20190220-183021.csv';
// File5 := 'scoringqa::out::biid_20_gongneustar_phonesplusv2_20181219b_second_w20190222-133854.csv';
// File6 := 'scoringqa::out::fp202_attributes_gongneustar_phonesplusv2_20181219b_second_w20190222-133854';
// File7 := 'scoringqa::out::busshell_22_gongneustar_phonesplusv2_20181219b_second_w20190222-133321_sas_layout_busshell.csv';
// File8 := 'scoringqa::out::sba_nonsbfe_score_gongneustar_phonesplusv2_20181219b_second_w20190222-133321';

// std.file.despray('~' + file1,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file1[17..],,,,true);  
// std.file.despray('~' + file2,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file2[17..],,,,true);  
// std.file.despray('~' + file3,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file3[17..],,,,true);  
// std.file.despray('~' + file4,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file4[17..],,,,true);  
// std.file.despray('~' + file5,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file5[17..],,,,true);  
// std.file.despray('~' + file6,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file6[17..],,,,true);  
// std.file.despray('~' + file7,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file7[17..],,,,true);  
// std.file.despray('~' + file8,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file8[17..],,,,true);  


// File1 := 'scoringqa::out::ciid_gongneustar_phonesplusv2_20181219b_second_w20190210-212719';
// File2 := 'scoringqa::out::busshell_22_gongneustar_phonesplusv2_20181219b_second_w20190210-212842_sas_layout_busshell.csv';
// File3 := 'scoringqa::out::ciid_gongneustar_phonesplusv2_20181217b_base_w20190211-135116';
// File4 := 'scoringqa::out::busshell_22_gongneustar_phonesplusv2_20181217b_base_w20190211-135012_sas_layout_busshell.csv';

// std.file.despray('~' + file1,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file1[17..],,,,true);  
// std.file.despray(file2,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file2[17..],,,,true);  
// std.file.despray('~' + file3,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file3[17..],,,,true);  
// std.file.despray( file4,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file4[17..],,,,true);  



// File1 := 'scoringqa::out::bocashell_51_nonfcra_ gongneustar_phonesplusv2_20181217b_base_w20190205-200346_edina_v50';
// File2 := 'scoringqa::out::bocashell_51_nonfcra_ gongneustar_phonesplusv2_20181219b_second_w20190206-144824_edina_v50';
// File3 := 'scoringqa::out::fp3score_gongneustar_phonesplusv2_20181217b_base_w20190205-200346';
// File4 := 'scoringqa::out::fp3score_gongneustar_phonesplusv2_20181219b_second_w20190206-144824';

// std.file.despray('~' + file1,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file1[17..],,,,true);  
// std.file.despray('~' + file2,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file2[17..],,,,true);  
// std.file.despray('~' + file3,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file3[17..],,,,true);  
// std.file.despray('~' + file4,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file4[17..],,,,true);  


// File1 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_gateway_norestrictions_base_20181217b_modelinglayout_w20190124-201831.csv';
// File2 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_gateway_restrictions_base_20181217b_modelinglayout_w20190124-201831.csv';
// File3 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_nogateway_norestrictions_base_20181217b_modelinglayout_w20190124-201831.csv';
// File4 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_nogateway_restrictions_base_20181217b_modelinglayout_w20190124-201831.csv';
// File5 := 'scoringqa::out::bocashell_41_nonfcra_may_july_phonesplusv2_gong_neustar_norestrictions_base_20181217b_edina_v41_w20190124-201831.csv';
// File6 := 'scoringqa::out::bocashell_41_nonfcra_may_july_phonesplusv2_gong_neustar_restrictions_base_20181217b_edina_v41_w20190124-201831.csv';
// File7 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_gateway_norestrictions_second_20181219a_modelinglayout_w20190125-102140.csv';
// File8 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_gateway_restrictions_second_20181219a_modelinglayout_w20190125-102140.csv';
// File9 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_nogateway_norestrictions_second_20181219a_modelinglayout_w20190125-102140.csv';
// File10 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_nogateway_restrictions_second_20181219a_modelinglayout_w20190125-102140.csv';
// File11 := 'scoringqa::out::bocashell_41_nonfcra_may_july_phonesplusv2_gong_neustar_norestrictions_second_20181219a_edina_v41_w20190125-102140.csv';
// File12 := 'scoringqa::out::bocashell_41_nonfcra_may_july_phonesplusv2_gong_neustar_restrictions_second_20181219a_edina_v41_w20190125-102140.csv';
// File13 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_gateway_norestrictions_second_20181219b_modelinglayout_w20190125-161544.csv';
// File14 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_gateway_restrictions_second_20181219b_modelinglayout_w20190125-161544.csv';
// File15 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_nogateway_norestrictions_second_20181219b_modelinglayout_w20190125-161544.csv';
// File16 := 'scoringqa::out::phone_shell_version_10_may_july__phonesplusv2_gong_neustar_nogateway_restrictions_second_20181219b_modelinglayout_w20190125-161544.csv';
// File17 := 'scoringqa::out::bocashell_41_nonfcra_may_july_phonesplusv2_gong_neustar_norestrictions_second_20181219b_edina_v41_w20190125-161544.csv';
// File18 := 'scoringqa::out::bocashell_41_nonfcra_may_july_phonesplusv2_gong_neustar_restrictions_second_20181219b_edina_v41_w20190125-161544.csv';

/*
// File1 := 'scoringqa::out::phone_shell_version_10_may_july_no_gateways_restrictions_phonesplusv2_gong_base_w20181210-175048_modelinglayout_w20181210-175048.csv';
// File2 := 'scoringqa::out::phone_shell_version_10_may_july_no_gateways_norestrictions_phonesplusv2_gong_base_w20181210-172057_modelinglayout_w20181210-172057.csv';
// File3 := 'scoringqa::out::phone_shell_version_10_may_july_gateways_restrictions_phonesplusv2_gong_base_w20181210-175137_modelinglayout_w20181210-175137.csv';
// File4 := 'scoringqa::out::phone_shell_version_10_may_july_gateways_norestrictions_phonesplusv2_gong_base_w20181210-172146_modelinglayout_w20181210-172146.csv';
// File5 := 'scoringqa::out::phone_shell_version_20_may_july_gateways_restrictions_phonesplusv2_gong_base_w20181210-183928_modelinglayout_w20181210-183928.csv';
// File6 := 'scoringqa::out::phone_shell_version_20_may_july_gateways_norestrictions_phonesplusv2_gong_base_w20181210-181256_modelinglayout_w20181210-181256.csv';
// File7 := 'scoringqa::out::phone_shell_version_20_may_july_no_gateways_restrictions_phonesplusv2_gong_base_w20181210-183948_modelinglayout_w20181210-183948.csv';
// File8 := 'scoringqa::out::phone_shell_version_20_may_july_no_gateways_norestrictions_phonesplusv2_gong_base_w20181210-181320_modelinglayout_w20181210-181320.csv';
// File9 := 'scoring::out::phoneshell_project_bocashell_41_nonfcra_may_july_restrictions_phonesplusv2_gong_base_w20181210-192150_edina_v41';
// File10 := 'scoring::out::phoneshell_project_bocashell_41_nonfcra_may_july_norestrictions_phonesplusv2_gong_base_w20181210-190155_edina_v41';
// File11 := 'scoring::out::phoneshell_project_bocashell_54_nonfcra_may_july_restrictions_phonesplusv2_gong_base_w20181210-192156_edina_v54';
// File12 := 'scoring::out::phoneshell_project_bocashell_54_nonfcra_may_july_norestrictions_phonesplusv2_gong_base_w20181210-190247_edina_v54';

// File13 := 'scoringqa::out::phone_shell_version_10_may_july_no_gateways_restrictions_phonesplusv2_gong_second_w20181210-105609_modelinglayout_w20181210-105609.csv';
// File14 := 'scoringqa::out::phone_shell_version_10_may_july_no_gateways_norestrictions_phonesplusv2_gong_second_w20181210-095523_modelinglayout_w20181210-095523.csv';
// File15 := 'scoringqa::out::phone_shell_version_10_may_july_gateways_restrictions_phonesplusv2_gong_second_w20181210-105640_modelinglayout_w20181210-105640.csv';
// File16 := 'scoringqa::out::phone_shell_version_10_may_july_gateways_norestrictions_phonesplusv2_gong_second_w20181210-095614_modelinglayout_w20181210-095614.csv';
// File17 := 'scoringqa::out::phone_shell_version_20_may_july_gateways_restrictions_phonesplusv2_gong_second_w20181210-112642_modelinglayout_w20181210-112642.csv';
// File18 := 'scoringqa::out::phone_shell_version_20_may_july_gateways_norestrictions_phonesplusv2_gong_second_w20181210-095803_modelinglayout_w20181210-095803.csv';
// File19 := 'scoringqa::out::phone_shell_version_20_may_july_no_gateways_restrictions_phonesplusv2_gong_second_w20181210-112704_modelinglayout_w20181210-112704.csv';
// File20 := 'scoringqa::out::phone_shell_version_20_may_july_no_gateways_norestrictions_phonesplusv2_gong_second_w20181210-100954_modelinglayout_w20181210-100954.csv';
// File21 := 'scoring::out::phoneshell_project_bocashell_41_nonfcra_may_july_restrictions_phonesplusv2_gong_second_w20181210-121950_edina_v41';
// File22 := 'scoring::out::phoneshell_project_bocashell_41_nonfcra_may_july_norestrictions_phonesplusv2_gong_second_w20181210-115551_edina_v41';
// File23 := 'scoring::out::phoneshell_project_bocashell_54_nonfcra_may_july_restrictions_phonesplusv2_gong_second_w20181210-141501_edina_v54';
// File24 := 'scoring::out::phoneshell_project_bocashell_54_nonfcra_may_july_norestrictions_phonesplusv2_gong_second_w20181210-115721_edina_v54';
*/


/*
File1 := 'scoringqa::out::phone_shell_version_10_may_july_no_gateways_norestrictions_w20181203-101008_modelinglayout_w20181203-101008.csv';
// File2 := 'scoringqa::out::phone_shell_version_10_may_july_gateways_norestrictions_w20181118-150045_modelinglayout_w20181118-150045.csv';
// File2 := 'scoringqa::out::phone_shell_version_10_may_july_gateways_norestrictions_w20181119-164651_modelinglayout_w20181119-164651.csv';
// File3 := 'scoringqa::out::phone_shell_version_20_may_july_no_gateways_norestrictions_w20181118-150402_modelinglayout_w20181118-150402.csv';
// File4 := 'scoringqa::out::phone_shell_version_20_may_july_gateways_norestrictions_w20181118-150420_modelinglayout_w20181118-150420.csv';
// File4 := 'scoringqa::out::phone_shell_version_20_may_july_gateways_norestrictions_w20181119-164814_modelinglayout_w20181119-164814.csv';
// File5 := 'scoring::out::phoneshell_project_bocashell_54_nonfcra_may_july_norestrictions_w20181118-151648_edina_v54';
// File5 := 'scoring::out::phoneshell_project_bocashell_54_nonfcra_may_july_norestrictions_w20181119-164456_edina_v54';
// File6 := 'scoringqa::out::phone_shell_version_10_may_july_no_gateways_restrictions_w20181118-145227_modelinglayout_w20181118-145227.csv';
// File7 := 'scoringqa::out::phone_shell_version_10_may_july_gateways_restrictions_w20181118-144827_modelinglayout_w20181118-144827.csv';
// File8 := 'scoringqa::out::phone_shell_version_20_may_july_no_gateways_restrictions_w20181118-145337_modelinglayout_w20181118-145337.csv';
// File9 := 'scoringqa::out::phone_shell_version_20_may_july_gateways_restrictions_w20181118-145246_modelinglayout_w20181118-145246.csv';
// File10 := 'scoring::out::phoneshell_project_bocashell_54_nonfcra_may_july_restrictions_w20181118-151411_edina_v54';
File11 := 'scoring::out::phoneshell_project_bocashell_41_nonfcra_may_july_norestrictions_w20181203-101032_edina_v54';
*/


//
//Despray


/*
std.file.despray('~' + file1,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file1[17..],,,,true);  
std.file.despray('~' + file2,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file2[17..],,,,true);  
std.file.despray('~' + file3,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file3[17..],,,,true);  
std.file.despray('~' + file4,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file4[17..],,,,true);  
std.file.despray('~' + file5,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file5[17..],,,,true);  
std.file.despray('~' + file6,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file6[17..],,,,true); 
std.file.despray('~' + file7,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file7[17..],,,,true); 
std.file.despray('~' + file8,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file8[17..],,,,true); 
std.file.despray('~' + file9,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file9[15..] + '.csv',,,,true); 
std.file.despray('~' + file10,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file10[15..] + '.csv',,,,true); 
std.file.despray('~' + file11,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file11[15..] + '.csv',,,,true); 
std.file.despray('~' + file12,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file12[15..] + '.csv',,,,true); 

std.file.despray('~' + file13,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file13[17..],,,,true);  
std.file.despray('~' + file14,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file14[17..],,,,true);  
std.file.despray('~' + file15,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file15[17..],,,,true);  
std.file.despray('~' + file16,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file16[17..],,,,true);  
std.file.despray('~' + file17,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file17[17..],,,,true);  
std.file.despray('~' + file18,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file18[17..],,,,true); 
std.file.despray('~' + file19,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file19[17..],,,,true); 
std.file.despray('~' + file20,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file20[17..],,,,true); 
std.file.despray('~' + file21,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file21[15..] + '.csv',,,,true); 
std.file.despray('~' + file22,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file22[15..] + '.csv',,,,true); 
std.file.despray('~' + file23,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file23[15..] + '.csv',,,,true); 
std.file.despray('~' + file24,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file24[15..] + '.csv',,,,true); 
*/


// std.file.despray('~' + file1,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file1[17..],,,,true);  
// std.file.despray('~' + file2,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file2[17..],,,,true);  
// std.file.despray('~' + file3,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file3[17..],,,,true);  
// std.file.despray('~' + file4,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file4[17..],,,,true);  
// std.file.despray('~' + file5,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file5[17..],,,,true);  
// std.file.despray('~' + file6,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file6[17..],,,,true); 
// std.file.despray('~' + file7,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file7[17..],,,,true); 
// std.file.despray('~' + file8,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file8[17..],,,,true); 
// std.file.despray('~' + file9,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file9[17..],,,,true); 
// std.file.despray('~' + file10,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file10[17..],,,,true); 
// std.file.despray('~' + file11,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file11[17..],,,,true); 
// std.file.despray('~' + file12,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file12[17..],,,,true); 
// std.file.despray('~' + file13,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file13[17..],,,,true);  
// std.file.despray('~' + file14,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file14[17..],,,,true);  
// std.file.despray('~' + file15,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file15[17..],,,,true);  
// std.file.despray('~' + file16,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file16[17..],,,,true);  
// std.file.despray('~' + file17,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file17[17..],,,,true);  
// std.file.despray('~' + file18,'10.48.72.34', 'C:\\Users\\karnbe01\\PhoneShell\\Collections\\' + RunDate + '\\' + file18[17..],,,,true); 



