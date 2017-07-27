import ut, doxie, autokey, AutokeyB2, RoxieKeyBuild,DNB;

export Proc_Build_Keys_DNB(string filedate) := function


RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(dnb.Key_dnb_Dunsnum,
                       '~thor_data400::key::dnb::@version@::Dunsnum','~thor_data400::key::dnb::'+filedate+'::Dunsnum',
                       bld_acc_nbr_key);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(dnb.Key_dnb_BDID,
                       '~thor_data400::key::dnb::@version@::bdid','~thor_data400::key::dnb::'+filedate+'::bdid',
                       bld_bdid_key);

//start txbus autokeys
File_Autokeys := dnb.File_dnb_Autokey;

c := dnb.dnb_autokey_constants(filedate); 

ak_keyname  := c.ak_keyname;
ak_logical  := c.ak_logical;
ak_dataset  := c.ak_dataset;
ak_skipSet  := c.ak_skipSet;
ak_typeStr  := c.ak_typeStr;

// holds logical base name for a autokeys.
logicalname := ak_logical;

// holds key base name for autokeys 
keyname     := ak_keyname;

skip_set    := ak_skipSet;

AutoKeyB2.MAC_Build (ak_dataset,blank,blank,blank,
                     zero,
                     zero,
                     blank,
                     prim_name,prim_range,st,p_city_name,z5,sec_range,
                     zero,
                     zero,zero,zero,
                     zero,zero,zero,
                     zero,zero,zero,
                     zero,
                     zero,
                     Business_Name, // compname which is string thus "blank"
                     zero,
                     telephone_number,
                     prim_name,prim_range,st,p_city_name,z5,sec_range,
                     bdid, // bdid_out
                     ak_keyname,ak_logical,bld_auto_keys,false,
                     ak_skipSet,
										 true,
										 ak_typeStr,
                     true,
										 ,,zero); 

//end Txbus autokeys 

// Move BDID key to build
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dnb::@version@::Dunsnum','~thor_data400::key::dnb::'+filedate+'::Dunsnum',mv_acc_nbr);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dnb::@version@::bdid','~thor_data400::key::dnb::'+filedate+'::bdid',mv_bdid);

// Move BDID key to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dnb::@version@::Dunsnum', 'Q', mv_acc_nbr_key);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dnb::@version@::bdid', 'Q', mv_bdid_key);


// Move autokeys to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dnb::autokey::@version@::payload', 'Q', mv_fdids_key);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::dnb::autokey::@version@::AddressB2','Q',mv_autokey_addrB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::dnb::autokey::@version@::NameB2','Q',mv_autokey_nameB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::dnb::autokey::@version@::StNameB2','Q',mv_autokey_stnamB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::dnb::autokey::@version@::CityStNameB2','Q',mv_autokey_cityB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::dnb::autokey::@version@::ZipB2','Q',mv_autokey_zipB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::dnb::autokey::@version@::NameWords2','Q',mv_autokey_Namewords2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::dnb::autokey::@version@::PhoneB2','Q',mv_autokey_PhoneB2);


Build_dnb_Keys := sequential(parallel(bld_acc_nbr_key, bld_bdid_key, bld_auto_keys), 
                                  parallel(mv_acc_nbr, mv_bdid),
                                  parallel(mv_acc_nbr_key, mv_bdid_key, mv_fdids_key, mv_autokey_addrB2, 
								            mv_autokey_nameB2, mv_autokey_stnamB2, mv_autokey_cityB2, 
								            mv_autokey_zipB2, mv_autokey_Namewords2, mv_autokey_PhoneB2
								));


return Build_dnb_Keys;														

end;
















/*
export Proc_Build_keys_DNB(string filedate) := function

//add qa keys
a0:= parallel(
	 if(fileservices.superfileexists('~thor_data400::key::dnb::qa::bdid'),
					FileServices.ClearSuperfile('~thor_data400::key::dnb::qa::bdid'),fileservices.createsuperfile('~thor_data400::key::dnb::qa::bdid')),
	 if(fileservices.superfileexists('~thor_data400::key::dnb::qa::Dunsnum'),
					FileServices.ClearSuperfile('~thor_data400::key::dnb::qa::Dunsnum'),fileservices.createsuperfile('~thor_data400::key::dnb::qa::Dunsnum'))
);
//'~thor_data400::key::dnb::'+ doxie.Version_SuperKey +'::Bdid'
// clear qa keys
// a1:= parallel(
// fileservices.clearsuperfile('~thor_data400::key::dnb::bdid_qa'),
// fileservices.clearsuperfile('~thor_data400::key::dnb::Dunsnum_qa')
// );

	 if(fileservices.superfileexists('~thor_data400::key::dnb::built::bdid'),
					FileServices.ClearSuperfile('~thor_data400::key::dnb::built::bdid'),fileservices.createsuperfile('~thor_data400::key::dnb::built::bdid'));
	 if(fileservices.superfileexists('~thor_data400::key::dnb::built::Dunsnum'),
					FileServices.ClearSuperfile('~thor_data400::key::dnb::built::Dunsnum'),fileservices.createsuperfile('~thor_data400::key::dnb::built::Dunsnum'));
					
					
// ********************************************
// build index files
// a2 := sequential(
// buildindex(dnb.key_dnb_bdid,'~thor_data400::key::dnb::'+filedate+'::bdid',overwrite),
// buildindex(dnb.key_dnb_Dunsnum,'~thor_data400::key::dnb::'+filedate+'::Dunsnum',overwrite)
// );
// **************************************
// add key to QA key

a3:= sequential(
FileServices.StartSuperFileTransaction(),
FileServices.AddSuperFile('~thor_data400::key::dnb::qa::bdid', '~thor_data400::key::dnb::20081020::bdid'),
FileServices.FinishSuperFileTransaction()
);

a4:= sequential(
FileServices.StartSuperFileTransaction(),
FileServices.AddSuperFile('~thor_data400::key::dnb::qa::Dunsnum', '~thor_data400::key::dnb::20081020::Dunsnum'),
FileServices.FinishSuperFileTransaction()
);

//Create autokeys

c := dnb.dnb_autokey_constants(filedate); 

ak_keyname  := c.ak_keyname;
ak_logical  := c.ak_logical;
ak_dataset  := c.ak_dataset;
ak_skipSet  := c.ak_skipSet;
ak_typeStr  := c.ak_typeStr;

AutoKeyB2.MAC_Build (ak_dataset,blank,blank,blank,
                     zero,
                     zero,
                     blank,
                     prim_name,prim_range,st,p_city_name,z5,sec_range,
                     zero,
                     zero,zero,zero,
                     zero,zero,zero,
                     zero,zero,zero,
                     zero,
                     zero,
                     Business_Name, // compname which is string thus "blank"
                     zero,
                     telephone_number,
                     prim_name,prim_range,st,p_city_name,z5,sec_range,
                     bdid, // bdid_out
                     ak_keyname,ak_logical,bld_auto_keys,false,
                     ak_skipSet,
										 true,
										 ak_typeStr,
                     true,
										 ,,zero);
AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, mymove,, ak_skipSet);
// retval := sequential(bld_auto_keys,mymove);
// retval :=bld_auto_keys;
retval := sequential(a0,parallel(a3,a4),bld_auto_keys,mymove);
return retval;

end;
*/