Import Data_Services, doxie, ut, MDR, Risk_Indicators, PRTE2_Business_Header;

dBH_BDID_SIC := Business_Header.BH_BDID_SIC();
dBH_Best		 := business_header.files().Base.business_header_best.built;

layout_sic := record
	string10 		prim_range	;
	string2   	predir			;
	string28 		prim_name		;
	string4  		addr_suffix	;
	string2   	postdir			;
	string5  		unit_desig	;
	string8  		sec_range		;
	string25 		city				;
	string2   	state				;
	string5  		zip					;
	string4  		zip4				;
	string4   	sic_code		;
  string2 		source			; 
	unsigned6  	bdid				;
	string4   	addr_type		;
end;

BH_BDID_SIC_filt := dBH_BDID_SIC((integer)sic_code <> 0,not MDR.sourceTools.SourceIsDunn_Bradstreet(source));

BH_BDID_SIC_Dist  := distribute(BH_BDID_SIC_filt, hash(bdid, sic_code));
BH_BDID_SIC_Sort  := sort(BH_BDID_SIC_Dist, bdid, sic_code, local);
BH_BDID_SIC_Dedup := dedup(BH_BDID_SIC_Sort, bdid, sic_code, local);

BH_Bdid_Sic_Uniq_Dist := distribute(BH_BDID_SIC_Dedup, hash(bdid));
BH_Best_Dist 					:= distribute(dBH_best(zip <> 0), hash(bdid));

f_sic_addr_out := join(BH_Bdid_Sic_Uniq_Dist, BH_Best_Dist,
                       left.bdid = right.bdid, left outer, local) ;
											 
f_sic_addr_valid := f_sic_addr_out(prim_name<>'');

f_sic_addr_dist := distribute(f_sic_addr_valid,hash(prim_range,predir,prim_name,
																										addr_suffix,postdir,unit_desig,
                                                    sec_range,city,state,zip,zip4,sic_code));
	 
f_sic_addr_sort := sort(f_sic_addr_dist,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,
                        sec_range,city,state,zip,zip4,sic_code,local);

f_sic_addr_dedup := dedup(f_sic_addr_sort,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,
                          sec_range,city,state,zip,zip4,sic_code,local);
										
layout_sic slim_addr(f_sic_addr_dedup l) := transform
	self.addr_type := '2240';  //** Business address
	self.zip := intformat(l.zip,5,1);
	self.zip4 := intformat(l.zip4,4,1);
	self.bdid := l.bdid;
	self.source := l.source;
	self := l;
end;

f_addr_slim := project(f_sic_addr_dedup, slim_addr(left));

layout_keyIndex :=
RECORD
	string10 	prim_range;
	string2   predir;
	string28	prim_name;
	string4  	addr_suffix;
	string2   postdir;
	string5  	unit_desig;
	string8  	sec_range;
	string25 	city;
	string2   state;
	string5  	zip;
	string4  	zip4;
  string4   sic_code;
	string2 	source; //Added
	string12  bdid;
	string4   addr_type;
	real 			lat;
	real 			long;
END;

layout_keyIndex getll(f_addr_slim le) := transform
	addr1 		:= Risk_Indicators.MOD_AddressClean.street_address('',le.prim_range, le.predir, le.prim_name,
																														le.addr_suffix, le.postdir, le.unit_desig, le.sec_range);				
	clean 		:= Risk_Indicators.MOD_AddressClean.clean_addr(addr1, le.city, le.state, le.zip);		
	
	zip2ll 		:= ziplib.ZipToGeo21(le.zip);
	self.lat 	:= if((real)(clean[146..155])=0,(real)(zip2ll[1..9]),(real)(clean[146..155]));
	self.long := if((real)(clean[156..166])=0,(real)(zip2ll[11..]),(real)(clean[156..166]));
  self.bdid := intformat(le.bdid,12,1);
	self 			:= le;
end;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
p := dataset([],layout_keyIndex);
#ELSE
p := project(f_addr_slim, getll(LEFT))(~(lat=0 AND long=0));
#END;

export Key_SICCode_Zip := index(p, 
																{sic_code, z5:= zip},
																{lat,long,
																 prim_range,predir,prim_name,
																 suffix := addr_suffix,postdir,
																 unit_desig,sec_range,city,state,z4:=zip4, bdid, source},
																 Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::business_header.SICCode_Zip_' + doxie.Version_SuperKey);
