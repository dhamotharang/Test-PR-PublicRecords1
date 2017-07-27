IMPORT AutoKeyB2,ut, roxiekeybuild;
export Proc_Build_Autokeys(string version) := function
inkey := thor_cluster + 'key::AlloyMedia_student_list::autokey::QA::';
inkeyB := thor_cluster + 'key::AlloyMedia_student_list::autokey::BUILT::';

if(fileservices.superfileexists(inkey + 'Payload'),
					FileServices.ClearSuperfile(inkey + 'Payload'),fileservices.createsuperfile(inkey + 'Payload'));

if(fileservices.superfileexists(inkeyb + 'Payload'),
					FileServices.ClearSuperfile(inkeyb + 'Payload'),fileservices.createsuperfile(inkeyb + 'Payload'));

if(fileservices.superfileexists(inkey + 'AddressB2'),
					FileServices.ClearSuperfile(inkey + 'AddressB2'),fileservices.createsuperfile(inkey + 'AddressB2'));

if(fileservices.superfileexists(inkeyb + 'AddressB2'),
					FileServices.ClearSuperfile(inkeyb + 'AddressB2'),fileservices.createsuperfile(inkeyb + 'AddressB2'));

if(fileservices.superfileexists(inkey + 'CityStNameB2'),
					FileServices.ClearSuperfile(inkey + 'CityStNameB2'),fileservices.createsuperfile(inkey + 'CityStNameB2'));

if(fileservices.superfileexists(inkeyb + 'CityStNameB2'),
					FileServices.ClearSuperfile(inkeyb + 'CityStNameB2'),fileservices.createsuperfile(inkeyb + 'CityStNameB2'));
					
if(fileservices.superfileexists(inkey + 'NameB2'),
					FileServices.ClearSuperfile(inkey + 'NameB2'),fileservices.createsuperfile(inkey + 'NameB2'));

if(fileservices.superfileexists(inkeyb + 'NameB2'),
					FileServices.ClearSuperfile(inkeyb + 'NameB2'),fileservices.createsuperfile(inkeyb + 'NameB2'));

if(fileservices.superfileexists(inkey + 'StNameB2'),
					FileServices.ClearSuperfile(inkey + 'StNameB2'),fileservices.createsuperfile(inkey + 'StNameB2'));

if(fileservices.superfileexists(inkeyb + 'StNameB2'),
					FileServices.ClearSuperfile(inkeyb + 'StNameB2'),fileservices.createsuperfile(inkeyb + 'StNameB2'));

if(fileservices.superfileexists(inkey + 'ZipB2'),
					FileServices.ClearSuperfile(inkey + 'ZipB2'),fileservices.createsuperfile(inkey + 'ZipB2'));

if(fileservices.superfileexists(inkeyb + 'ZipB2'),
					FileServices.ClearSuperfile(inkeyb + 'ZipB2'),fileservices.createsuperfile(inkeyb + 'ZipB2'));

if(fileservices.superfileexists(inkey + 'NameWords2'),
					FileServices.ClearSuperfile(inkey + 'NameWords2'),fileservices.createsuperfile(inkey + 'NameWords2'));

if(fileservices.superfileexists(inkeyb + 'NameWords2'),
					FileServices.ClearSuperfile(inkeyb + 'NameWords2'),fileservices.createsuperfile(inkeyb + 'NameWords2'));

if(fileservices.superfileexists(inkey + 'Address'),
					FileServices.ClearSuperfile(inkey + 'Address'),fileservices.createsuperfile(inkey + 'Address'));

if(fileservices.superfileexists(inkeyb + 'Address'),
					FileServices.ClearSuperfile(inkeyb + 'Address'),fileservices.createsuperfile(inkeyb + 'Address'));

if(fileservices.superfileexists(inkey + 'CityStName'),
					FileServices.ClearSuperfile(inkey + 'CityStName'),fileservices.createsuperfile(inkey + 'CityStName'));

if(fileservices.superfileexists(inkeyb + 'CityStName'),
					FileServices.ClearSuperfile(inkeyb + 'CityStName'),fileservices.createsuperfile(inkeyb + 'CityStName'));
					
if(fileservices.superfileexists(inkey + 'Name'),
					FileServices.ClearSuperfile(inkey + 'Name'),fileservices.createsuperfile(inkey + 'Name'));

if(fileservices.superfileexists(inkeyb + 'Name'),
					FileServices.ClearSuperfile(inkeyb + 'Name'),fileservices.createsuperfile(inkeyb + 'Name'));

if(fileservices.superfileexists(inkey + 'StName'),
					FileServices.ClearSuperfile(inkey + 'StName'),fileservices.createsuperfile(inkey + 'StName'));

if(fileservices.superfileexists(inkeyb + 'StName'),
					FileServices.ClearSuperfile(inkeyb + 'StName'),fileservices.createsuperfile(inkeyb + 'StName'));

if(fileservices.superfileexists(inkey + 'Zip'),
					FileServices.ClearSuperfile(inkey + 'Zip'),fileservices.createsuperfile(inkey + 'Zip'));

if(fileservices.superfileexists(inkeyb + 'Zip'),
					FileServices.ClearSuperfile(inkeyb + 'Zip'),fileservices.createsuperfile(inkeyb + 'Zip'));

if(fileservices.superfileexists(inkey + 'NameWords2'),
					FileServices.ClearSuperfile(inkey + 'NameWords2'),fileservices.createsuperfile(inkey + 'NameWords2'));

if(fileservices.superfileexists(inkeyb + 'NameWords2'),
					FileServices.ClearSuperfile(inkeyb + 'NameWords2'),fileservices.createsuperfile(inkeyb + 'NameWords2'));

if(fileservices.superfileexists(inkey + 'SSN2'),
					FileServices.ClearSuperfile(inkey + 'SSN2'),fileservices.createsuperfile(inkey + 'SSN2'));

if(fileservices.superfileexists(inkeyb + 'SSN2'),
					FileServices.ClearSuperfile(inkeyb + 'SSN2'),fileservices.createsuperfile(inkeyb + 'SSN2'));
	
	//************************************

// To build the updated keys
layout_autokey:=RECORD
  AlloyMedia_student_list.Files.File_Base.clean_p_city_name;
	AlloyMedia_student_list.Files.File_Base.home_phone_number;
	AlloyMedia_student_list.Files.File_Base.did;
	AlloyMedia_student_list.Files.File_Base.clean_fname;
	AlloyMedia_student_list.Files.File_Base.clean_mname;
	AlloyMedia_student_list.Files.File_Base.clean_lname;
	AlloyMedia_student_list.Files.File_Base.clean_name_suffix;
	AlloyMedia_student_list.Files.File_Base.clean_prim_range;
	AlloyMedia_student_list.Files.File_Base.clean_prim_name;
	AlloyMedia_student_list.Files.File_Base.clean_sec_range;
	AlloyMedia_student_list.Files.File_Base.clean_st;
	AlloyMedia_student_list.Files.File_Base.clean_zip5;
  STRING blank:='';
  INTEGER zero:=0;
END;

autokeydata:=TABLE(Files.File_Base,layout_autokey);
SET OF STRING skipset:=['Q','S','F','B'];

AutoKeyB2.MAC_Build (autokeydata,
						 clean_fname,
						 clean_mname,
						 clean_lname,
						 blank,
						 zero,
						 clean_phone_number,
						 clean_prim_name,
						 clean_prim_range,
						 clean_st,
						 clean_p_city_name,
						 clean_zip5,
						 clean_sec_range,
						 zero,
						 zero,zero,zero,
						 zero,zero,zero,
						 zero,zero,zero,
						 zero,
						 did,
						 blank, // compname which is string thus "blank"
						 zero,
						 zero,
						 blank,
						 blank,
						 blank,
						 blank,
						 blank,
						 blank,
						 zero, // bdid_out
						 thor_cluster+'key::alloymedia_student_list::autokey::',thor_cluster+'key::alloymedia_student_list::'+version+'::autokey::',
						 bld_auto_keys,false,
						 skipset,true,,
						 true,,,zero);
						 
	AutoKeyB2.MAC_AcceptSK_to_QA(thor_cluster+'key::alloymedia_student_list::autokey::', move_auto_keys,, skipset);

retval := sequential(bld_auto_keys,move_auto_keys);

return retval;
end;