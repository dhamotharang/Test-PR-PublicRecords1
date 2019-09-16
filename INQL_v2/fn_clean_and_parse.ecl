import ut, address, aid, lib_stringlib, nid, did_add, Business_Header_SS, lib_word;
import standard, header_slimsort, didville, business_header,watchdog, mdr, header;

export fn_clean_and_parse(dataset(INQL_v2.Layouts.Common_layout) longfile = dataset([], INQL_v2.Layouts.Common_layout)) := function

	repflag(string function_description, string orig_lname, string orig_full_name)
		:=  map(function_description = 'BUSINESS INSTANT ID' and (orig_lname <> '' or orig_full_name <> '') => 'Y', '');

	fraudback(string function_description, string orig_ip_address)
		:= map(stringlib.stringfind(function_description, 'CHARGEBACK',1) > 0
		or stringlib.stringfind(function_description, 'FRAUDPOINT',1) > 0 => ORIG_IP_ADDRESS, ''); // for PERSON_ORIG_IP_ADDRESS1

	longfilehashed := distribute(project(longfile, transform({recordof(longfile), integer hashkey := 0}, 
													self.hashkey := hash64(left.ORIG_FULL_NAME1 + left.ORIG_COMPANY_NAME1);
													self := left)), hashkey);

	trimInfile1 := table(longfilehashed, {NAMETYPE, CNAMETYPE, string ORIG_NAME := ORIG_FULL_NAME1, ORIG_FULL_NAME1, ORIG_COMPANY_NAME1, NM := 'P', hashkey}, hashkey, local);													
	trimInfile2 := table(longfilehashed, {NAMETYPE, CNAMETYPE, string ORIG_NAME := ORIG_COMPANY_NAME1, ORIG_FULL_NAME1, ORIG_COMPANY_NAME1, NM := 'B', hashkey}, hashkey, local);

	trimInfile := trimInfile1 + trimInfile2;													

	outfile1A := trimInfile;

	outfile2A := join(outfile1A(NM = 'P'), outfile1A(NM = 'B'), left.hashkey = right.hashkey,
											transform(recordof(left),
																	self.cnametype := right.nametype,
																	self := left), local);

	infile_typed := join(longfilehashed, outfile2A(nametype + cnametype <> ''), left.hashkey = right.hashkey, 
											transform({recordof(longfilehashed)},
																	self.nametype := right.nametype,
																	self.cnametype := right.cnametype,
																	self := left),
											left outer, local);

	remapOutFile := project(infile_typed/*(nameType = 'B' or cNameType = 'P')*/, transform(INQL_v2.Layouts.Common_layout,																						
					self.ORIG_FULL_NAME1 := map(left.cNameTYpe = 'P'  and left.orig_full_name1 = '' => 
																				left.orig_company_name1, 
																				left.NameType = 'B'=> '',
																				left.ORIG_FULL_NAME1);
					self.ORIG_FULL_NAME2 := map(left.nameType <> 'B' and left.cNameType <> 'P' => left.ORIG_FULL_NAME2, '');
					self.ORIG_FNAME := map(left.nameType <> 'B' and left.cNameType <> 'P' => left.ORIG_FNAME, '');
					self.ORIG_MNAME := map(left.nameType <> 'B' and left.cNameType <> 'P' => left.ORIG_MNAME, '');
					self.ORIG_LNAME := map(left.nameType <> 'B' and left.cNameType <> 'P' => left.ORIG_LNAME, '');
					self.ORIG_NAMESUFFIX := map(left.nameType <> 'B' and left.cNameType <> 'P' => left.ORIG_NAMESUFFIX, '');
					self.CLEAN_NAME := map(left.nameType <> 'B' and left.cNameType <> 'P' => left.CLEAN_NAME, '');
					
					self.ORIG_COMPANY_NAME1 :=  map(left.NameTYpe = 'B'  and left.orig_company_name1 = '' => 
																						left.orig_full_name1, 
																					left.cNameType = 'P' => '',
																						left.orig_company_name1);
					self.CLEAN_CNAME1 := trim(ut.CleanCompany(self.ORIG_COMPANY_NAME1), left,right);
																																																
					self := left)); 

	ToBeCleaned := remapOutFile;
		
	INQL_v2.macNameCleaner(ToBeCleaned, CommonNameClean, ORIG_FULL_NAME1, 'F', ORIG_FULL_NAME2, 'F');
	INQL_v2.macAddressCleaner(CommonNameClean, CommonNameAddrClean_1, CLEAN_ADDR1, Clean_ADDR, orig_addr1, orig_lastline1);
	INQL_v2.macAddressCleaner(CommonNameAddrClean_1(ORIG_ADDR2 <> ''), CommonNameAddrClean_2, CLEAN_ADDR2, Clean_ADDR, orig_addr2, orig_lastline2);

	CommonNameAddrClean := CommonNameAddrClean_1(ORIG_ADDR2 = '') + CommonNameAddrClean_2;

	return project(CommonNameAddrClean, TRANSFORM(INQL_v2.Layouts.Common_layout,
					self.REPFLAG	:= RepFlag(left.FUNCTION_DESCRIPTION,left.orig_full_name1,left.fname+left.lname+left.orig_fname+left.orig_lname);
					
					cleanname := left.clean_name;
														
					self.title := stringlib.stringfilter(cleanName[1..5], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ-\' ');
					self.fname := stringlib.stringfilter(cleanName[6..25], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ-\' ');
					self.mname := stringlib.stringfilter(cleanName[26..45], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ-\' ');
					self.lname := stringlib.stringfilter(cleanName[46..65], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ-\' ');
					self.name_suffix := stringlib.stringfilter(cleanName[66..70], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ-\' ');

					cleanaddr := left.CLEAN_ADDR1;
					self.prim_range := address.CleanAddressFieldsFips(cleanaddr).prim_range;//[1..10];
					self.predir := address.CleanAddressFieldsFips(cleanaddr).predir;
					self.prim_name := address.CleanAddressFieldsFips(cleanaddr).prim_name;
					self.addr_suffix := address.CleanAddressFieldsFips(cleanaddr).addr_suffix;
					self.postdir := address.CleanAddressFieldsFips(cleanaddr).postdir;
					self.unit_desig := address.CleanAddressFieldsFips(cleanaddr).unit_desig;
					self.sec_range := address.CleanAddressFieldsFips(cleanaddr).sec_range;
					self.v_city_name := stringlib.stringfindreplace(address.CleanAddressFieldsFips(cleanaddr).v_city_name, 'XXXXX YY', '');
					self.st := address.CleanAddressFieldsFips(cleanaddr).st;
					self.zip5 :=if( cleanaddr[117..121] <> '99999',  cleanaddr[117..121], '');
					self.zip4 := address.CleanAddressFieldsFips(cleanaddr).zip4;
					self.addr_rec_type := address.CleanAddressFieldsFips(cleanaddr).rec_type;
					self.fips_state := address.CleanAddressFieldsFips(cleanaddr).fips_state;
					self.fips_county := address.CleanAddressFieldsFips(cleanaddr).fips_county;
					self.geo_lat := address.CleanAddressFieldsFips(cleanaddr).geo_lat;
					self.geo_long := address.CleanAddressFieldsFips(cleanaddr).geo_long;
					self.cbsa := '';
					self.geo_blk := address.CleanAddressFieldsFips(cleanaddr).geo_blk;
					self.geo_match := address.CleanAddressFieldsFips(cleanaddr).geo_match;
					self.err_stat := address.CleanAddressFieldsFips(cleanaddr).err_stat;
					
					self := left));
end;
