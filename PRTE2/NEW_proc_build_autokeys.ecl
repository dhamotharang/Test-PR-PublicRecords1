//* NEW_proc_build_autokeys 

IMPORT PRTE2,AutoKeyB2,ut, roxiekeybuild,PRTE_CSV;
export NEW_Proc_Build_Autokeys(string filedate) := MODULE


inkey := '~prte::key::foreclosure::autokey::QA::';
inkeyB := '~prte::key::foreclosure::autokey::BUILT::';

NOTHOR(if (fileservices.superfileexists(inkey + 'Payload'),
					FileServices.ClearSuperfile(inkey + 'Payload'),fileservices.createsuperfile(inkey + 'Payload')));

NOTHOR(if(fileservices.superfileexists(inkeyb + 'Payload'),
					FileServices.ClearSuperfile(inkeyb + 'Payload'),fileservices.createsuperfile(inkeyb + 'Payload')));


NOTHOR(if(fileservices.superfileexists(inkey + 'AddressB2'),
					FileServices.ClearSuperfile(inkey + 'AddressB2'),fileservices.createsuperfile(inkey + 'AddressB2')));

NOTHOR(if(fileservices.superfileexists(inkeyb + 'AddressB2'),
					FileServices.ClearSuperfile(inkeyb + 'AddressB2'),fileservices.createsuperfile(inkeyb + 'AddressB2')));


NOTHOR(if(fileservices.superfileexists(inkey + 'CityStNameB2'),
					FileServices.ClearSuperfile(inkey + 'CityStNameB2'),fileservices.createsuperfile(inkey+ 'CityStNameB2')));

NOTHOR(if(fileservices.superfileexists(inkeyb + 'CityStNameB2'),
					FileServices.ClearSuperfile(inkeyb + 'CityStNameB2'),fileservices.createsuperfile(inkeyb + 'CityStNameB2')));
	
NOTHOR(if(fileservices.superfileexists(inkey + 'NameB2'),
					FileServices.ClearSuperfile(inkey + 'NameB2'),fileservices.createsuperfile(inkey + 'NameB2')));

NOTHOR(if(fileservices.superfileexists(inkeyb + 'NameB2'),
					FileServices.ClearSuperfile(inkeyb + 'NameB2'),fileservices.createsuperfile(inkeyb + 'NameB2')));


NOTHOR(if(fileservices.superfileexists(inkey + 'StNameB2'),
					FileServices.ClearSuperfile(inkey + 'StNameB2'),fileservices.createsuperfile(inkey + 'StNameB2')));

NOTHOR(if(fileservices.superfileexists(inkeyb + 'StNameB2'),
					FileServices.ClearSuperfile(inkeyb + 'StNameB2'),fileservices.createsuperfile(inkeyb + 'StNameB2')));

NOTHOR(if(fileservices.superfileexists(inkey + 'ZipB2'),
					FileServices.ClearSuperfile(inkey + 'ZipB2'),fileservices.createsuperfile(inkey + 'ZipB2')));

NOTHOR(if(fileservices.superfileexists(inkeyb + 'ZipB2'),
					FileServices.ClearSuperfile(inkeyb + 'ZipB2'),fileservices.createsuperfile(inkeyb + 'ZipB2')));

NOTHOR(if(fileservices.superfileexists(inkey + 'NameWords2'),
					FileServices.ClearSuperfile(inkey + 'NameWords2'),fileservices.createsuperfile(inkey + 'NameWords2')));

NOTHOR(if(fileservices.superfileexists(inkeyb + 'NameWords2'),
					FileServices.ClearSuperfile(inkeyb + 'NameWords2'),fileservices.createsuperfile(inkeyb + 'NameWords2')));

NOTHOR(if(fileservices.superfileexists(inkey + 'Address'),
					FileServices.ClearSuperfile(inkey + 'Address'),fileservices.createsuperfile(inkey + 'Address')));

NOTHOR(if(fileservices.superfileexists(inkeyb + 'Address'),
					FileServices.ClearSuperfile(inkeyb + 'Address'),fileservices.createsuperfile(inkeyb + 'Address')));

NOTHOR(if(fileservices.superfileexists(inkey + 'CityStName'),
					FileServices.ClearSuperfile(inkey + 'CityStName'),fileservices.createsuperfile(inkey + 'CityStName')));

NOTHOR(if(fileservices.superfileexists(inkeyb + 'CityStName'),
					FileServices.ClearSuperfile(inkeyb + 'CityStName'),fileservices.createsuperfile(inkeyb + 'CityStName')));
					
NOTHOR(if(fileservices.superfileexists(inkey + 'Name'),
					FileServices.ClearSuperfile(inkey + 'Name'),fileservices.createsuperfile(inkey + 'Name')));

NOTHOR(if(fileservices.superfileexists(inkeyb + 'Name'),
					FileServices.ClearSuperfile(inkeyb + 'Name'),fileservices.createsuperfile(inkeyb + 'Name')));

NOTHOR(if(fileservices.superfileexists(inkey + 'StName'),
					FileServices.ClearSuperfile(inkey + 'StName'),fileservices.createsuperfile(inkey + 'StName')));

NOTHOR(if(fileservices.superfileexists(inkeyb + 'StName'),
					FileServices.ClearSuperfile(inkeyb + 'StName'),fileservices.createsuperfile(inkeyb + 'StName')));

NOTHOR(if(fileservices.superfileexists(inkey + 'Zip'),
					FileServices.ClearSuperfile(inkey + 'Zip'),fileservices.createsuperfile(inkey + 'Zip')));

NOTHOR(if(fileservices.superfileexists(inkeyb + 'Zip'),
					FileServices.ClearSuperfile(inkeyb + 'Zip'),fileservices.createsuperfile(inkeyb + 'Zip')));

NOTHOR(if(fileservices.superfileexists(inkey + 'NameWords2'),
					FileServices.ClearSuperfile(inkey + 'NameWords2'),fileservices.createsuperfile(inkey + 'NameWords2')));

NOTHOR(if(fileservices.superfileexists(inkeyb + 'NameWords2'),
					FileServices.ClearSuperfile(inkeyb + 'NameWords2'),fileservices.createsuperfile(inkeyb + 'NameWords2')));

NOTHOR(if(fileservices.superfileexists(inkey + 'SSN2'),
					FileServices.ClearSuperfile(inkey + 'SSN2'),fileservices.createsuperfile(inkey + 'SSN2')));

NOTHOR(if(fileservices.superfileexists(inkeyb + 'SSN2'),
					FileServices.ClearSuperfile(inkeyb + 'SSN2'),fileservices.createsuperfile(inkeyb + 'SSN2')));
	
//************************************
//*


EXPORT file_out1 := Join_files(filedate).File_Foreclosure_Autokey_CT;
OUTPUT (choosen(file_out1,100),NAMED('fileout1'));

SHARED File_Foreclosure_Autokey_bdid :=
	project(file_out1,
		transform(recordof(file_out1) - [bid,bid_score],
			self.bdid := left.bdid,
			self.bdid_score := left.bdid_score,
			self := left));

OUTPUT(File_Foreclosure_Autokey_bdid,,'~prte::ct::foreclosure::bdid',OVERWRITE);		
		
file_out2 := Join_Files(filedate).File_Foreclosures_Joined_CT;
file_out3 := file_out2(document_type !='');

output (file_out3,,'~prte::ct::foreclosure::fileout3',overwrite);
File_Foreclosure_FID :=
  project(file_out3,
	    Transform(PRTE_CSV.Foreclosure.rthor_data400__key__foreclosure__fid,
			self.fid := left.foreclosure_id,
      self.state := left.st,
			
			self := left,			
			self := [] ));
EXPORT foreclosure_ak_dataset2 := DEDUP(File_Foreclosure_FID(fid != ''),record,all);

OUTPUT(foreclosure_ak_dataset2,,'~prte::ct::foreclosure::ak_dataset2',OVERWRITE);
		
		
//*  APPEND FILES HERE *//			
			
  EXPORT foreclosure_ak_dataset := File_Foreclosure_Autokey_bdid;

  SHARED ak_dataset  := foreclosure_ak_dataset;
  export ak_keyname	:= '~prte::key::foreclosure::autokey::@version@::';
	export ak_logical	:= '~prte::key::foreclosure::' + filedate + '::autokey::';
	export ak_skipSet	:= ['P','Q','F'];
	export ak_typeStr	:= 'AK';


// To build the updated keys,  USE THE SHORT VERSION THAT MATCHES PRODUCTION, ak_dataset:
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


EXPORT retval := sequential(bld_auto_keys);

END;