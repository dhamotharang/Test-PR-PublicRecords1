IMPORT Foreclosure_Services,AutoKeyB2,ut, roxiekeybuild;

export Proc_Build_NOD_Autokeys(string filedate) :=
FUNCTION

	c := BKForeclosure.Constants(filedate); 

	ak_keyname  := c.ak_nod_keyname;
	ak_logical  := c.ak_nod_logical;
	ak_dataset  := c.ak_nod_dataset;
	ak_skipSet  := c.ak_nod_skipSet;
	ak_typeStr  := c.ak_nod_typeStr;

	// To build the updated keys
	layout_autokey := record
			ak_dataset;
	end;

	AutoKeyB2.MAC_Build (ak_dataset,cln_fname,cln_mname,cln_lname,
							 ssn,
							 zero,
							 blank,
							 prim_name,
							 prim_range,
							 st,
							 p_city_name,
							 zip,
							 sec_range,
							 zero,
							 zero,zero,zero,
							 zero,zero,zero,
							 zero,zero,zero,
							 zero,
							 did,
							 cname, // compname which is string thus "blank"
							 zero,
							 zero,
							 prim_name,
							 prim_range,
							 st,
							 p_city_name,
							 zip,
							 sec_range,
							 zero, // bdid
							 ak_keyname,
							 ak_logical,
							 bld_auto_keys,false,
							 ak_skipSet,true,ak_typeStr,
							 true,,,zero);
							 
	AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, move_auto_keys,, ak_skipSet);

	retval := sequential(bld_auto_keys,move_auto_keys);

	return retval;
end;