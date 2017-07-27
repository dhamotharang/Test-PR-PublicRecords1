import address, business_header, Data_Services;
 
hri_base_file :=  files().HRIAddressSicCode2.built((integer)zip<>0);

r :=
RECORD
	string10 prim_range;
	string2   predir;
	string28 prim_name;
	string4  addr_suffix;
	string2   postdir;
	string5  unit_desig;
	string8  sec_range;
	string25 city;
	string2   state;
	string5  zip;
	string4  zip4;
     string4   sic_code;
	 string2 	source; //Added
	string12  bdid;
	string4   addr_type;
	real lat;
	real long;
END;
r getll(hri_base_file le) :=
TRANSFORM
	addr1 := Risk_Indicators.MOD_AddressClean.street_address('',le.prim_range, le.predir, le.prim_name,
																														le.addr_suffix, le.postdir, le.unit_desig, le.sec_range);				
	clean := Risk_Indicators.MOD_AddressClean.clean_addr(addr1, le.city, le.state, le.zip);		
	
	zip2ll := ziplib.ZipToGeo21(le.zip);
	SELF.lat := IF((real)(clean[146..155])=0,(real)(zip2ll[1..9]),(real)(clean[146..155]));
	SELF.long := IF((real)(clean[156..166])=0,(real)(zip2ll[11..]),(real)(clean[156..166]));
     self.bdid := intformat(le.bdid,12,1);
	SELF := le;
END;
p := PROJECT(hri_base_file, getll(LEFT))(~(lat=0 AND long=0));

export Key_HRI_Sic_Zip_To_Address  := index(p, 
                                       {sic_code, z5:= zip},
                                       {lat,long,
										prim_range,predir,prim_name,
                                        suffix := addr_suffix,postdir,
	                                   unit_desig,sec_range,city,state,z4:=zip4, bdid, source},
                                      Data_Services.Data_Location.Prefix('HRI')+'thor_data400::key::hri_sic_zip_to_address_qa');