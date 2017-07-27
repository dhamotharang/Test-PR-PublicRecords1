import AutoKeyB2; 

b := UCCV2.file_SearchAutokey;

AutoKeyB2.MAC_Build (b,
					person_name.fname,person_name.mname,person_name.lname,
					ssn,
					zero,
					zero,
					person_addr.prim_name,person_addr.prim_range,person_addr.st,person_addr.v_city_name,person_addr.zip5,person_addr.sec_range,
					zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,zero,zero,
					party_bits,
					DID,
					company_name,
					fein,
					zero,
					company_addr.prim_name,company_addr.prim_range,company_addr.st,company_addr.v_city_name,company_addr.zip5,company_addr.sec_range,
					bdid,
					UCCV2.Constants.ak_keyname,
					UCCV2.Constants.ak_logical,
					outaction,false,
					[],true,UCCV2.Constants.ak_typeStr) 

AutoKeyB2.MAC_AcceptSK_to_QA(UCCV2.Constants.ak_keyname, mymove)
 
export proc_autokeybuild := sequential(outaction,mymove);
