import AutoKeyB2; 

export proc_build_autokeys(string filedate) := function

b := DNB_FEINv2.file_SearchAutokey ;

AutoKeyB2.MAC_Build (b,
					blank,blank,blank,
					zero,
					zero,
					zero,
					company_addr.prim_name,company_addr.prim_range,company_addr.st,company_addr.v_city_name,company_addr.zip5,company_addr.sec_range,
					zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,
					zero,
					clean_cname,
					fein,
					zero,
					company_addr.prim_name,company_addr.prim_range,company_addr.st,company_addr.v_city_name,company_addr.zip5,company_addr.sec_range,
					intbdid,
					dnb_feinv2.Constants(filedate).ak_keyname,
					dnb_feinv2.Constants(filedate).ak_logical,
					outaction,false,
					['C'],true,,
					true,,,zero) 

AutoKeyB2.MAC_AcceptSK_to_QA(dnb_feinv2.Constants(filedate).ak_keyname, mymove)

retval := sequential(outaction,mymove);

 
return retval;

end;
