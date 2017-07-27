IMPORT Foreclosure_Services,AutoKeyB2,ut, roxiekeybuild;
export Proc_Build_Autokeys(string filedate) := function
inkey := '~thor_data400::key::foreclosure::autokey::QA::';
inkeyB := '~thor_data400::key::foreclosure::autokey::BUILT::';

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

c := Foreclosure_Services.Constants(filedate); 

// ak_keyname  := c.str_autokeyname;
ak_keyname  := c.ak_keyname;
ak_logical  := c.ak_logical;
ak_dataset  := c.ak_dataset;
ak_skipSet  := c.ak_skipSet;
ak_typeStr  := c.ak_typeStr;

// To build the updated keys
layout_autokey := record
		ak_dataset;
end;

AutoKeyB2.MAC_Build (ak_dataset,name_first,name_middle,name_last,
						 ssn,
						 zero,
						 blank,
						 site_prim_name,
						 site_prim_range,
						 site_st,
						 site_p_city_name,
						 site_zip,
						 site_sec_range,
						 zero,
						 zero,zero,zero,
						 zero,zero,zero,
						 zero,zero,zero,
						 zero,
						 did,
						 name_Company, // compname which is string thus "blank"
						 zero,
						 zero,
						 site_prim_name,
						 site_prim_range,
						 site_st,
						 site_p_city_name,
						 site_zip,
						 site_sec_range,
						 bdid, // bdid_out
						 ak_keyname,
						 ak_logical,
						 bld_auto_keys,false,
						 ak_skipSet,true,ak_typeStr,
						 true,,,zero);
						 
	AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, move_auto_keys,, ak_skipSet);

retval := sequential(bld_auto_keys,move_auto_keys);

return retval;
end;