import Bank_Routing, ut, doxie, autokey, autokeyB2, RoxieKeyBuild;

export Proc_Build_Autokeys (string filedate) := function

//#workunit('name', 'BRTN Key Build ' + filedate);

brtn_base   := File_Bank_Routing_Autokeys;
type_str    := Constants.autokey_typeStr; 
logicalname := Constants.autokey_logical(filedate);
keyname     := Constants.autokey_keyname;
skip_set    := Constants.autokey_skipSet;

AutokeyB2.MAC_Build(brtn_base, blank, blank, blank,
					zero,
					zero,
					zero,
					blank, blank, blank, blank, blank, blank,
					zero,
					zero, zero, zero,
					zero, zero, zero,
					zero, zero, zero,
					zero,				 
					zero,
					institution_name_full,
					zero,
					TELEPHONE,
					prim_name, prim_range, st, p_city_name, zip, sec_range,
					seleid,
					keyname,
					logicalname,bld_auto_keys,false,skip_set,true,type_str,
					true,,,zero); 

AutoKeyB2.MAC_AcceptSK_to_QA(keyname, move_auto_keys,, skip_set);

Build_All:=	sequential(bld_auto_keys, move_auto_keys);
																		
return Build_All;														

end;