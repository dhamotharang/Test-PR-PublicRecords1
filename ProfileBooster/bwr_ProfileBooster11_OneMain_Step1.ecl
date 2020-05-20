// STEP 1 IN PB 1.1 THOR ONE MAIN AUTOMATION PROCESS
// CREATES THE INPUT FILE TO RUN AGAINST PB 1.0 THOR VERSION
// READS THE MARKETING WATCHDOG KEY, SORTS, DEDUPS AND WRITES OUT THE FILE (ABOUT 233 MILLION RECORDS)
// WE THEN BREAK THE ORIGINAL FULL FILE INTO 4 PARTS FOR EASIER PROCESSING AND REPROCESSING IF ONE FAILS
// HOW ARE WE GOING TO HANDLE THIS WITH _PB WHEN THIS FILE IS ONLY _QA????

#workunit('priority','high'); 

IMPORT INFUTOR, WATCHDOG, UT;

EXPORT bwr_ProfileBooster11_OneMain_Step1(string NotifyList) := FUNCTION

EmailList := If(NotifyList = '', ProfileBooster.Constants.ECL_Developers_Slim, ProfileBooster.Constants.ECL_Developers_Slim + ',' + NotifyList);
eyeball_count := 25;

base := Watchdog.Key_Watchdog_marketing_V2(   // Pointing to the Watchdog file
						adl_ind IN ['CORE', 'NO_SSN'] AND // , 'AMBIG', 'C_MERGE' ADL type should be 'CORE' or 'No_SSN' to filter out deceased
						fname <> '' AND lname <> '' AND 
						prim_name <> '' AND
						city_name <> '' AND st <> '' AND
						zip <> '' AND // zip4 <> '' AND
						(dob = 0 OR ut.Age(dob)>18 OR dob = -1) // Age>21 or best DoB missing
						); 

output(count(base), named('base_count'));

base3_pre := DISTRIBUTE(base, hash(fname,lname,prim_name,city_name,st,zip,ssn));
base3 := DEDUP(SORT(base3_pre, 
										hash(fname,mname,lname,name_suffix,prim_name,city_name,st,zip,ssn), LOCAL), 
										hash(fname,mname,lname,name_suffix,prim_name,city_name,st,zip,ssn), LOCAL);
										


LayoutPBInputThor := RECORD
	// USING A SUBSET OF ProfileBooster.Layouts.Layout_PB_In HERE, THAT IS WHAT THE FUNCTION TAKES IN
	qstring12  AcctNo := (string)base3.did;
  // unsigned4 seq;
	unsigned6 LexID := base3.did;
	// STRING70  Name_Full;
	// STRING5   Name_Title;
	qSTRING20  Name_First := base3.fname;
	qSTRING20  Name_Middle := base3.mname;
	qSTRING20  Name_Last := base3.lname;
	qSTRING5   Name_Suffix := base3.name_suffix;
	qSTRING9   ssn := base3.ssn;
	// STRING8   dob;
	qSTRING10	phone10 := base3.phone;
	// need to keep addressline1 and addressline2 for output to the customer
	string       addressline1 := TRIM(
															 IF(base3.prim_range<>'', TRIM(base3.prim_range)+' ', '') + 
															 IF(base3.predir<>'', TRIM(base3.predir)+' ', '') + 
															 IF(base3.prim_name<>'', TRIM(base3.prim_name)+' ', '') + 
															 IF(base3.suffix<>'', TRIM(base3.suffix)+' ', '') + 
															 IF(base3.postdir<>'', TRIM(base3.postdir)+' ', ''));
	string       addressline2 := TRIM(
															 IF(base3.unit_desig<>'', TRIM(base3.unit_desig)+' ', '') + 
															 IF(base3.sec_range<>'', TRIM(base3.sec_range)+' ', ''));
  string50 streetaddress := TRIM(
															 IF(base3.prim_range<>'', TRIM(base3.prim_range)+' ', '') + 	// start of address line 1
															 IF(base3.predir<>'', TRIM(base3.predir)+' ', '') + 
															 IF(base3.prim_name<>'', TRIM(base3.prim_name)+' ', '') + 
															 IF(base3.suffix<>'', TRIM(base3.suffix)+' ', '') + 
															 IF(base3.postdir<>'', TRIM(base3.postdir)+' ', '') + 
															 IF(base3.unit_desig<>'', TRIM(base3.unit_desig)+' ', '') + 	// start of address line 2
															 IF(base3.sec_range<>'', TRIM(base3.sec_range)+' ', '')); 
	// STRING120 street_addr;
	// String10  streetnumber;
	// String2		streetpredirection;
	// String28	streetname;
	// String4		streetsuffix;
	// String2		streetpostdirection;
	// String10	unitdesignation;
	// String8		unitnumber;
	qSTRING25  City_name := base3.city_name;
	STRING2   st := base3.st;
	qSTRING5   z5 := base3.zip;
	qSTRING4 z4 := base3.zip4;	// added this extra for output to the customer
	// STRING25 	country;
	// unsigned3	HistoryDate;
END;
out_dat := TABLE(base3, LayoutPBInputThor);

countRecs := count(out_dat);

// theRest := countRecs - 9000;	// this is how many records we have left after processing 180,000,000
// output(count(base3), named('base3_count'));
// output(theRest, named('theRest'));
// output(countRecs, named('out_dat_count'));
// output(out_dat, named('out_dat'));
// output(out_dat, , '~thor400::profilebooster::SpringLeaf_full_infile.csv', CSV(QUOTE('"')), EXPIRE(30), OVERWRITE);

// Now we have the full input file, lets break it up into 4 seperate smaller files in case we have issues
// file1 := choosen(out_dat, 3000/*how many*/, 1/*starting at*/);
// file2 := choosen(out_dat, 3000/*how many*/, 3001/*starting at*/);	// records 1-60,000,000
// file3 := choosen(out_dat, 3000/*how many*/, 6002/*starting at*/);
// file4 := choosen(out_dat, therest/*how many*/, 9003/*starting at*/);
// output(file1, named('file1'));
// output(file2, named('file2'));
// output(file3, named('file3'));
// output(file4, named('file4'));
// output(file1,, '~thor400::profilebooster::springleaf_full_file_pb_in_layout_60mil_part1.csv', CSV(quote('"')), expire(30), overwrite):FAILURE(FileServices.SendEmail(EmailList,'OneMain Step1 - create part1 failed', 'The failed workunit is:' + WORKUNIT + FAILMESSAGE));
// output(file2,, '~thor400::profilebooster::springleaf_full_file_pb_in_layout_60mil_part2.csv', CSV(quote('"')), expire(30), overwrite):FAILURE(FileServices.SendEmail(EmailList,'OneMain Step1 - create part2 failed', 'The failed workunit is:' + WORKUNIT + FAILMESSAGE));
// output(file3,, '~thor400::profilebooster::springleaf_full_file_pb_in_layout_60mil_part3.csv', CSV(quote('"')), expire(30), overwrite):FAILURE(FileServices.SendEmail(EmailList,'OneMain Step1 - create part3 failed', 'The failed workunit is:' + WORKUNIT + FAILMESSAGE));
// output(file4,, '~thor400::profilebooster::springleaf_full_file_pb_in_layout_final_part4.csv', CSV(quote('"')), expire(30), overwrite):FAILURE(FileServices.SendEmail(EmailList,'OneMain Step1 - create part4 failed', 'The failed workunit is:' + WORKUNIT + FAILMESSAGE));
	

theRest := countRecs - 180000000;	// this is how many records we have left after processing 180,000,000
output(theRest, named('theRest'));
output(countRecs, named('out_dat_count'));
output(choosen(out_dat, eyeball_count), named('out_dat'));
output(out_dat, , '~thor400::profileboosterV11::SpringLeaf_full_infile.csv', CSV(QUOTE('"')), EXPIRE(30), OVERWRITE);

//Now we have the full input file, lets break it up into 4 seperate smaller files in case we have issues
file1 := choosen(out_dat, 60000000/*how many*/, 1/*starting at*/);  // records 1-60,000,000
file2 := choosen(out_dat, 60000000/*how many*/, 60000001/*starting at*/);	// records 60,000,001 - 120,000,000
file3 := choosen(out_dat, 60000000/*how many*/, 120000001/*starting at*/);  // records 120,000,001 - 180,000,000
file4 := choosen(out_dat, therest/*how many*/, 180000001/*starting at*/);
output(choosen(file1, 10), named('file1'));
output(choosen(file2, 10), named('file2'));
output(choosen(file3, 10), named('file3'));
output(choosen(file4, 10), named('file4'));
output(file1,, '~thor400::profileboosterV11::springleaf_full_file_pb_in_layout_60mil_part1.csv', csv(heading(1), quote('"')), expire(30), overwrite):FAILURE(FileServices.SendEmail(EmailList,'OneMain Step1 - create part1 failed', 'The failed workunit is:' + WORKUNIT + FAILMESSAGE));
output(file2,, '~thor400::profileboosterV11::springleaf_full_file_pb_in_layout_60mil_part2.csv', csv(heading(1), quote('"')), expire(30), overwrite):FAILURE(FileServices.SendEmail(EmailList,'OneMain Step1 - create part2 failed', 'The failed workunit is:' + WORKUNIT + FAILMESSAGE));
output(file3,, '~thor400::profileboosterV11::springleaf_full_file_pb_in_layout_60mil_part3.csv', csv(heading(1), quote('"')), expire(30), overwrite):FAILURE(FileServices.SendEmail(EmailList,'OneMain Step1 - create part3 failed', 'The failed workunit is:' + WORKUNIT + FAILMESSAGE));
output(file4,, '~thor400::profileboosterV11::springleaf_full_file_pb_in_layout_final_part4.csv', csv(heading(1), quote('"')), expire(30), overwrite):FAILURE(FileServices.SendEmail(EmailList,'OneMain Step1 - create part4 failed', 'The failed workunit is:' + WORKUNIT + FAILMESSAGE));

	
// email results of this bwr
FileServices.SendEmail(EmailList, 'OneMain Step1 PB11 finished ' + WORKUNIT, 
												'Input count  ' + countRecs + '    File1 count ' + count(File1) + '    File2 count ' + count(File2) +
												'    File3 count ' + count(File3) + '    File4 count ' + count(File4)):
FAILURE(FileServices.SendEmail(EmailList,'OneMain Step1 PB11 failed', 'The failed workunit is:' + WORKUNIT + FAILMESSAGE));

RETURN 'SUCCESSFULL';

END;