import American_student_list, ut, doxie, autokey, autokeyB2, RoxieKeyBuild;

export Proc_Build_Autokeys (string filedate) := function

//#workunit('name', 'ASL Key Build ' + filedate);

asl_base    := File_american_student_Autokeys;
type_str    := Constants.autokey_typeStr; 
logicalname := Constants.autokey_logical(filedate);
keyname     := Constants.autokey_keyname;
skip_set    := Constants.autokey_skipSet;

AutokeyB2.MAC_Build(asl_base,fname,mname,lname,
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
					keyname,
					logicalname,bld_auto_keys,false,skip_set,true,type_str,
					true,,,zero); 

AutoKeyB2.MAC_AcceptSK_to_QA(keyname, move_auto_keys,, skip_set);

Build_All:=	sequential(bld_auto_keys, move_auto_keys);
																		
return Build_All;														

end;