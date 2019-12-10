
#workunit('name', 'BWR_MyLife_Test');

//Set the list of dids to pull the data
dids := [296825749, 2370917903];
prefix := 'D2C_Customers.layouts.';

//1 - Full Load
//2 - Quarterly
//3 - Monthly

//Consumer File
ds1 := D2C_Customers.MAC_D2CFiles(1,1, prefix + 'rConsumers');
//Address History File
ds2 := D2C_Customers.MAC_D2CFiles(1,2, prefix + 'rAddressHist');
//Akas File
ds3 := D2C_Customers.MAC_D2CFiles(1,3, prefix + 'rAkas');
//Relatives & Associates File
ds4 := D2C_Customers.MAC_D2CFiles(1,4, prefix + 'rRelatives');
//Bankruptcy File
ds5 := D2C_Customers.MAC_D2CFiles(1,5, prefix + 'rBankruptcy');
//Concealed Weapons Permits File
ds6 := D2C_Customers.MAC_D2CFiles(1,6, prefix + 'rCWP');
//Criminal File
ds7 := D2C_Customers.MAC_D2CFiles(1,7, prefix + 'rCrims');
//Email Addresses File
ds9 := D2C_Customers.MAC_D2CFiles(1,9, prefix + 'rEmails');
//FAA Aircraft File
ds10 := D2C_Customers.MAC_D2CFiles(1,10, prefix + 'rAircraft');
//FAA Pilots File
ds11 := D2C_Customers.MAC_D2CFiles(1,11, prefix + 'rAirmen');
//Hunting Fishing Permits File
ds12 := D2C_Customers.MAC_D2CFiles(1,12, prefix + 'rHunting');
//Liens & Judgments File
ds13 := D2C_Customers.MAC_D2CFiles(1,13, prefix + 'rLiens');
//National UCC Filings File
ds14 := D2C_Customers.MAC_D2CFiles(1,14, prefix + 'rUCC');
//People at Work File
ds15 := D2C_Customers.MAC_D2CFiles(1,15, prefix + 'rPeople_At_Work');
//Phones File
ds16 := D2C_Customers.MAC_D2CFiles(1,16, prefix + 'rPhones');
//Professional Licenses  File
ds17 := D2C_Customers.MAC_D2CFiles(1,17, prefix + 'rProfessional_Licenses');
//Sex Offenders File
ds18 := D2C_Customers.MAC_D2CFiles(1,18, prefix + 'rSex_Offenders');
//Voter Registration File
ds19 := D2C_Customers.MAC_D2CFiles(1,19, prefix + 'rVoter_Registration');
//Deeds & Mortgages File
ds20 := D2C_Customers.MAC_D2CFiles(1,20, prefix + 'rDeeds_Mortgages');
//Tax Assessments File
ds21 := D2C_Customers.MAC_D2CFiles(1,21, prefix + 'rTax_Assessments');
//Student File
ds22 := D2C_Customers.MAC_D2CFiles(1,22, prefix + 'rStudent');

output(ds1(LexID in dids), named('Consumers_data'));
output(ds2(LexID in dids), named('Address_hist_data'));
output(ds3(LexID in dids), named('Akas_data'));
output(ds4(LexID1 in dids), named('Relatives_data'));
output(ds5(LexID in dids), named('Bankruptcy_data'));
output(ds6(LexID in dids), named('Concealed_Weapons_data'));
output(ds7(LexID in dids), named('Criminal_data'));
output(ds9(LexID in dids), named('Email_Address_data'));
output(ds10(LexID in dids), named('Faa_Aircraft_data'));
output(ds11(LexID in dids), named('Faa_Pilot_data'));
output(ds12(LexID in dids), named('Hunting_Fishing_data'));
output(ds13(LexID in dids), named('Liens_Judgments_data'));
output(ds14(LexID in dids), named('National_UCC_data'));
output(ds15(LexID in dids), named('People_at_Work_data'));
output(ds16(LexID in dids), named('Phones_data'));
output(ds17(LexID in dids), named('Professional_Licenses_data'));
output(ds18(LexID in dids), named('Sex_Offenders_data'));
output(ds19(LexID in dids), named('Voter_Registration_data'));
output(ds20(LexID in dids), named('Deeds_Mortgages_data'));
output(ds21(LexID in dids), named('Tax_Assessments_data'));
output(ds22(LexID in dids), named('Student_data'));