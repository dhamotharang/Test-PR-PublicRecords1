import data_services, doxie, autokey, autokeyB2, RoxieKeyBuild, prte2_american_student_list, ut;

EXPORT Keys := module

export stu_DID := index(files.DID_base, {unsigned6 l_did := (unsigned)did},{files.DID_base},
                              Data_Services.Data_location.Prefix('american_student')+ constants.keyname + Doxie.Version_SuperKey+'::DID');


export stu_DID_FCRA := index(files.DID_base_fcra, {unsigned6 l_did := (unsigned)did},{files.DID_base_fcra},
                              Data_Services.Data_location.Prefix('american_student')+ constants.keyname_fcra + Doxie.Version_SuperKey+'::DID');

export DID := index(files.DID2_base, {unsigned6 l_did := (unsigned)did},{files.DID2_base},
                        Data_Services.Data_location.Prefix('american_student')+ constants.keyname + Doxie.Version_SuperKey+'::DID2');
                        
export DID_FCRA := function 
ut.MAC_CLEAR_FIELDS(files.DID2_base, DID2_base_cleared, Constants.fields_to_clear);
return index(DID2_base_cleared, {unsigned6 l_did := (unsigned)did},{DID2_base_cleared},
             constants.keyname_fcra + Doxie.Version_SuperKey+'::DID2');
end;                        

export Address_List := index(files.address_matches, {LN_COLLEGE_NAME},{files.address_matches},
				            Data_Services.Data_location.Prefix('american_student')+ constants.keyname + Doxie.Version_SuperKey+ '::address_list');


export autokeys (string filedate) := function

AutokeyB2.MAC_Build(files.american_student_Autokeys,
                    fname,mname,lname,
                    ssn,
                    DOB_FORMATTED,
                    TELEPHONE,
                    prim_name, prim_range, st, p_city_name, zip, sec_range,
                    zero,
                    zero,zero,zero,
                    zero,zero,zero,
                    zero,zero,zero,
                    zero,				 
                    did,
                    blank,
                    zero,
                    zero,
                    blank,blank,blank,blank,blank,blank,
                    zero,
                    constants.ak_keyname,
                    constants.ak_logical(filedate),bld_auto_keys,false,constants.autokey_skipSet,true,constants.autokey_typeStr,
                    true,,,zero); 

AutoKeyB2.MAC_AcceptSK_to_QA(constants.ak_keyname, move_auto_keys,, constants.autokey_skipSet);

Build_All:=	sequential(bld_auto_keys, move_auto_keys);
																		
return Build_All;														

end;

end;