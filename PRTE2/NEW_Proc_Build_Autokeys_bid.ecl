//* NEW_Proc_Build_Autokeys_bid :
IMPORT PRTE2,AutoKeyB2,ut, roxiekeybuild, Data_Services,Doxie;


export NEW_Proc_Build_Autokeys_bid(string filedate) := MODULE


inkey := '~prte::key::foreclosure::autokey::QA::bid::';
inkeyB := '~prte::key::foreclosure::autokey::BUILT::bid::';

NOTHOR(if(fileservices.superfileexists(inkey + 'Payload'),
					FileServices.ClearSuperfile(inkey + 'Payload'),fileservices.createsuperfile(inkey + 'Payload')));

NOTHOR(if(fileservices.superfileexists(inkeyb + 'Payload'),
					FileServices.ClearSuperfile(inkeyb + 'Payload'),fileservices.createsuperfile(inkeyb + 'Payload')));

NOTHOR(if(fileservices.superfileexists(inkey + 'AddressB2'),
					FileServices.ClearSuperfile(inkey + 'AddressB2'),fileservices.createsuperfile(inkey + 'AddressB2')));

NOTHOR(if(fileservices.superfileexists(inkeyb + 'AddressB2'),
					FileServices.ClearSuperfile(inkeyb + 'AddressB2'),fileservices.createsuperfile(inkeyb + 'AddressB2')));

NOTHOR(if(fileservices.superfileexists(inkey + 'CityStNameB2'),
					FileServices.ClearSuperfile(inkey + 'CityStNameB2'),fileservices.createsuperfile(inkey + 'CityStNameB2')));

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
	

  EXPORT file_out2 := Join_files(filedate).All_Foreclosures_Expanded;	

		
	EXPORT File_Foreclosure_Autokey_bid_CT :=
		project(file_out2,

		transform(recordof(file_out2) - [bid,bid_score],
		 	self.bdid := left.bid,
			self.bdid_score := left.bid_score,
			self := left));	
	
df_in := File_Foreclosure_Autokey_bid_CT(bdid != 0);


df2 := project (df_in, {unsigned6 bdid, df_in.foreclosure_id});

EXPORT df3 := dedup (sort (df2, record), record);


EXPORT Key_Foreclosures_BID3 := index(df3,{bdid},{string70 fid := foreclosure_id},'~prte::key::foreclosure_bid_' + doxie.Version_SuperKey);		

//*BDID:	
	export File_Foreclosure_Autokey_bdid_CT :=
	project(file_out2,
		transform(recordof(file_out2) - [bid,bid_score],
			self.bdid := left.bdid,
			self.bdid_score := left.bdid_score,
			self := left));
	df_in_bdid := File_Foreclosure_Autokey_bdid_CT(bdid != 0);
	
	df2_bdid := project (df_in_bdid, {unsigned6 bdid, df_in_bdid.foreclosure_id});
	EXPORT df3_bdid := dedup (sort (df2_bdid, record), record);	
//*DID:	
df_in_did := file_out2(did != 0);

df2_did := project (df_in_did, {unsigned6 did, df_in_did.foreclosure_id});
EXPORT df3_did := dedup (sort (df2_did, record), record);
	str_autokeyname := '~prte::key::foreclosure::autokey::qa::bid::';
	ak_keyname	:= '~prte::key::foreclosure::autokey::@version@::bid::';
	ak_logical	:= '~prte::key::foreclosure::' + filedate + '::autokey::bid::';
	ak_skipSet	:= ['P','Q','F'];
	ak_typeStr	:= 'AK';
	ak_dataset  := File_Foreclosure_Autokey_bid_CT;
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

EXPORT retval := sequential(bld_auto_keys,move_auto_keys);

end;