import autokeyb2, ut, standard, ut, doxie, autokey,AutoKeyI, RoxieKeyBuild;

export Build_Autokeys(

	 string																			pversion
	,string																			pDatasetName	= 'DNB'
	,dataset(layouts.temporary.layout_autokey	)	pAutoKey			= DNB_DMI.File_Companies_Autokey()
	
) :=
FUNCTION
	
	File_Autokeys := pAutoKey;

	myconstants := _Constants(,pDatasetName);
	
	ak_keyname  := myconstants.altautokeytemplate;
	ak_logical  := Keynames(pversion,,pDatasetName).autokeyroot.new;
	ak_skipSet  := myconstants.ak_skipSet;
	ak_typeStr  := myconstants.ak_typeStr;

	// holds logical base name for a autokeys.
	logicalname := ak_logical;

	// holds key base name for autokeys 
	keyname     := ak_keyname;

	skip_set    := ak_skipSet;

	AutoKeyB2.MAC_Build (pAutoKey,blank,blank,blank,
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

	return bld_auto_keys;														

end;