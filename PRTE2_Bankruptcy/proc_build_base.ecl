IMPORT PRTE2_Bankruptcy, BankruptcyV2, PromoteSupers, Address, PRTE2, ut, STD, PRTE2_Common, Prte2, AID, AID_Support;
#constant(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);

EXPORT proc_build_base := FUNCTION

//join status to Main
	l_status := record, maxLength(10000) 
		string8 status_date;
		string30 status_type;
	end;

	l_comments := record, maxLength(10000) 
		string8 filing_date;
		string30 description;
	end;
	
	PRTE2_Bankruptcy.Layouts.Main_BaseV3_ext join_Main(Files.Main_in L, Files.Status_in R) := TRANSFORM
	   SELF.status := row(R,l_status);
	   SELF        := L;
				SELF								:= [];
	end;

	jn_Main := JOIN(sort(distribute(PRTE2_Bankruptcy.Files.Main_in,hash(tmsid)),record,local)
								 ,sort(distribute(PRTE2_Bankruptcy.Files.Status_in,hash(tmsid)),record,local)
								 ,left.tmsid = right.tmsid
								 ,join_Main(left,right),left outer,local);
	
//Join comments							 
	PRTE2_Bankruptcy.Layouts.Main_BaseV3_ext jComment(jn_Main L, PRTE2_Bankruptcy.Files.Comments_in R) := TRANSFORM
		SELF.comments := row(R,l_comments);
		SELF := L;
END;

j_AllV3 := join(jn_Main 
								,sort(distribute(PRTE2_Bankruptcy.Files.Comments_in,hash(tmsid)),record,local)
								,left.tmsid = right.tmsid
								,jComment(left,right),left outer,local);
							
//Combine Search and Main addresses to pass through address cleaner
Search_in	:= PROJECT(PRTE2_Bankruptcy.Files.Search_in, TRANSFORM(PRTE2_Bankruptcy.Layouts.Search_Base_ext; SELF := LEFT, SELF := []));

lTempAddr	:= RECORD
	STRING90	raw_Address1;
	STRING25	raw_City;
	STRING2		raw_State;
	STRING5		raw_Zip;
	STRING4		raw_Zip4;
	STRING 		prep_address_first;
	STRING 		prep_address_last;
	UNSIGNED8 RawAID:=0;
	address.Layout_Clean182;
END;

pMainAddr	:= PROJECT(j_AllV3(trim(cust_name) != ' ' and trim(DID) = ''), 
										TRANSFORM(lTempAddr, SELF.raw_Address1 := LEFT.trusteeAddress; SELF.raw_City := LEFT.trusteeCity; SELF.raw_State := LEFT.trusteeState;
										SELF.raw_Zip := LEFT.trusteeZip; SELF.raw_Zip4 := LEFT.trusteeZip4; SELF.prep_address_first := Address.fn_addr_clean_prep(LEFT.trusteeAddress, 'first');
										SELF.prep_address_last := Address.fn_addr_clean_prep(LEFT.trusteeCity+', '+LEFT.trusteeState+' '+LEFT.trusteeZip+LEFT.trusteeZip4, 'last'); SELF := []));
										
pSearchAddr := PROJECT(Search_in(trim(cust_name) != '' and trim(DID) = '' and trim(bdid) = ''),
											TRANSFORM(lTempAddr, SELF.raw_Address1 := LEFT.orig_addr1; SELF.raw_City := LEFT.orig_city; SELF.raw_State := LEFT.orig_st;
											SELF.raw_Zip := LEFT.orig_zip5; SELF.raw_Zip4 := LEFT.orig_zip4; SELF.prep_address_first := Address.fn_addr_clean_prep(LEFT.orig_addr1, 'first');
											SELF.prep_address_last := Address.fn_addr_clean_prep(LEFT.orig_city+', '+LEFT.orig_st+' '+LEFT.orig_zip5+LEFT.orig_zip4, 'last'); SELF := []));
										
fAddrAll	:= DEDUP(pMainAddr + pSearchAddr);

unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

AID.MacAppendFromRaw_2Line(fAddrAll, prep_address_first, prep_address_last, RawAID, addr_clean, lFlags);

//Join clean fields back to main and search file
PRTE2_Bankruptcy.Layouts.Main_BaseV3_ext MapClnAddr(j_AllV3 l, addr_clean R) := TRANSFORM
	SELF.prim_range     :=  r.AIDWork_ACECache.prim_range;
	SELF.predir         :=  r.AIDWork_ACECache.predir;
	SELF.prim_name      :=  r.AIDWork_ACECache.prim_name;;
	SELF.addr_suffix		:=  r.AIDWork_ACECache.addr_suffix;
	SELF.postdir        :=  r.AIDWork_ACECache.postdir;
	SELF.unit_desig	   	:=	r.AIDWork_AceCache.unit_desig;
	SELF.sec_range      :=  r.AIDWork_ACECache.sec_range;
	SELF.p_city_name    :=  r.AIDWork_ACECache.p_city_name;
	SELF.v_city_name    :=  r.AIDWork_ACECache.v_city_name;
	SELF.st             :=  r.AIDWork_ACECache.st;
	SELF.zip	          :=  r.aidwork_acecache.zip5;
	SELF.zip4           :=  r.aidwork_acecache.zip4;
	SELF.cart		       	:=	r.AIDWork_AceCache.cart;
	SELF.cr_sort_sz	   	:=	r.AIDWork_AceCache.cr_sort_sz;
	SELF.lot		       	:=	r.AIDWork_AceCache.lot;
	SELF.lot_order		  :=	r.AIDWork_AceCache.lot_order;
	SELF.dbpc		       	:=	r.AIDWork_AceCache.dbpc;
	SELF.chk_digit		  :=	r.AIDWork_AceCache.chk_digit;
	SELF.rec_type	      :=	r.AIDWork_AceCache.rec_type;
	SELF.county	       	:=	r.AIDWork_AceCache.county;
	SELF.geo_lat		   	:=	r.AIDWork_AceCache.geo_lat;
	SELF.geo_long		   	:=	r.AIDWork_AceCache.geo_long;
	SELF.msa			   		:=	r.AIDWork_AceCache.msa;
	SELF.geo_blk		   	:=	r.AIDWork_AceCache.geo_blk;
	SELF.geo_match		  :=	r.AIDWork_AceCache.geo_match;
	SELF.err_stat		   	:=	r.AIDWork_AceCache.err_stat;
	SELF	:= l;
END;

jMainAddr_new	:= JOIN(SORT(j_AllV3(trim(cust_name) != ' ' and trim(DID) = ''),trusteeAddress,trusteeCity,trusteeState),
											addr_clean,
											LEFT.trusteeAddress = RIGHT.raw_Address1 AND
											LEFT.trusteeCity = RIGHT.raw_City AND
											LEFT.trusteeState = RIGHT.raw_State,
											MapClnAddr(LEFT,RIGHT),LEFT OUTER);
ded_jMain			:= DEDUP(jMainAddr_new, ALL);

PRTE2_Bankruptcy.Layouts.Search_Base_ext MapClnAddr2(Search_in l, addr_clean r) := TRANSFORM
	SELF.prim_range     :=  r.AIDWork_ACECache.prim_range;
	SELF.predir         :=  r.AIDWork_ACECache.predir;
	SELF.prim_name      :=  r.AIDWork_ACECache.prim_name;;
	SELF.addr_suffix		:=  r.AIDWork_ACECache.addr_suffix;
	SELF.postdir        :=  r.AIDWork_ACECache.postdir;
	SELF.unit_desig	   	:=	r.AIDWork_AceCache.unit_desig;
	SELF.sec_range      :=  r.AIDWork_ACECache.sec_range;
	SELF.p_city_name    :=  r.AIDWork_ACECache.p_city_name;
	SELF.v_city_name    :=  r.AIDWork_ACECache.v_city_name;
	SELF.st             :=  r.AIDWork_ACECache.st;
	SELF.zip	          :=  r.aidwork_acecache.zip5;
	SELF.zip4           :=  r.aidwork_acecache.zip4;
	SELF.cart		       	:=	r.AIDWork_AceCache.cart;
	SELF.cr_sort_sz	   	:=	r.AIDWork_AceCache.cr_sort_sz;
	SELF.lot		       	:=	r.AIDWork_AceCache.lot;
	SELF.lot_order		  :=	r.AIDWork_AceCache.lot_order;
	SELF.dbpc		       	:=	r.AIDWork_AceCache.dbpc;
	SELF.chk_digit		  :=	r.AIDWork_AceCache.chk_digit;
	SELF.rec_type	      :=	r.AIDWork_AceCache.rec_type;
	SELF.county	       	:=	r.AIDWork_AceCache.county;
	SELF.geo_lat		   	:=	r.AIDWork_AceCache.geo_lat;
	SELF.geo_long		   	:=	r.AIDWork_AceCache.geo_long;
	SELF.msa			   		:=	r.AIDWork_AceCache.msa;
	SELF.geo_blk		   	:=	r.AIDWork_AceCache.geo_blk;
	SELF.geo_match		  :=	r.AIDWork_AceCache.geo_match;
	SELF.err_stat		   	:=	r.AIDWork_AceCache.err_stat;
	SELF	:= l;
END;

jSearchAddr_new	:= JOIN(SORT(Search_in(trim(cust_name) != '' and trim(DID) = '' and trim(bdid) = ''),orig_addr1,orig_city,orig_st),
										addr_clean,
										LEFT.orig_addr1 = RIGHT.raw_Address1 AND
										LEFT.orig_city = RIGHT.raw_City AND
										LEFT.orig_st = RIGHT.raw_State,
										MapClnAddr2(LEFT,RIGHT),LEFT OUTER);
ded_jSearch		:= DEDUP(jSearchAddr_new, ALL);
									
//DID & Name/Address Cleaning Main
PRTE2_Bankruptcy.Layouts.Main_BaseV3_ext tClnMain(Layouts.Main_BaseV3_ext L) := TRANSFORM
	//Name cleaning - if the clean names are passed in, use them.  Otherwise use results of the cleaner
	tempTName					:= Address.CleanPersonFML73_fields(L.trusteename);
	SELF.title				:= IF(TRIM(L.title)<>'', L.title, tempTName.title);
	SELF.fname				:= IF(TRIM(L.fname)<>'', L.fname, tempTName.fname);
	SELF.mname				:= IF(TRIM(L.mname)<>'', L.mname, tempTName.mname);
	SELF.lname				:= IF(TRIM(L.lname)<>'', L.lname, tempTName.lname);
	SELF.name_suffix	:= IF(TRIM(L.name_suffix)<>'', L.name_suffix, tempTName.name_suffix);
	SELF.name_score		:= IF(TRIM(L.name_score)<>'', L.name_score, tempTName.name_score);
	
//Link_SSN can not be used to populate app_ssn field if vendor did not provide SSNbut Link_SSN field should be used for DID'g
	temp_ssn :=  IF(L.app_ssn = '' and L.link_ssn <> '', l.link_ssn, l.app_ssn);

//Only valid for internal test records	
self.app_ssn := if(L.cust_name <> '' and L.app_ssn = '' and L.link_ssn <> '', L.link_ssn, L.app_ssn);
	
//Linking ID
	SELF.did					:= IF(trim(L.DID) != '',L.DID,
													(string12)prte2.fn_AppendFakeID.did(SELF.fname, SELF.lname, temp_ssn, L.link_dob, L.cust_name));
	SELF 	:= L;
	SELF	:= [];
END;

pCleanMain	:= PROJECT(ded_jMain, tClnMain(LEFT));

//Append new records to previous records
fMainAll	:= j_AllV3(trim(cust_name) = '' or (trim(cust_name) != '' and trim(DID) != '')) + pCleanMain;
dedMain		:= DEDUP(SORT(fMainAll,TMSID),record, ALL);

PromoteSupers.Mac_SF_BuildProcess(dedMain, Constants.BASE_PREFIX +'main', build_main_base);


//DID & Name/Address cleaning Search
PRTE2_Bankruptcy.Layouts.Search_Base_ext tCleanNAddr(ded_jSearch L) := TRANSFORM
	//Name cleaning - if the clean names are passed in, use them.  Otherwise use results of the cleaner
	tempName	:= Address.CleanPersonFML73_fields(ut.CleanSpacesAndUpper(trim(L.orig_fname)+' '+trim(L.orig_mname)+' '+trim(L.orig_lname)+' '+trim(L.orig_name_suffix)));
	SELF.title				:= IF(TRIM(L.title)<>'', L.title, tempName.title);
	SELF.fname				:= IF(TRIM(L.fname)<>'', L.fname, tempName.fname);
	SELF.mname				:= IF(TRIM(L.mname)<>'', L.mname, tempName.mname);
	SELF.lname				:= IF(TRIM(L.lname)<>'', L.lname, tempName.lname);
	SELF.name_suffix	:= IF(TRIM(L.name_suffix)<>'', L.name_suffix, tempName.name_suffix);
	SELF.name_score		:= IF(TRIM(L.name_score)<>'', L.name_score, tempName.name_score);
 SELF.cname    := if(L.orig_company <> '', ut.CleanSpacesAndUpper(L.orig_company), ut.CleanSpacesAndUpper(L.orig_name));  

//Link_SSN can not be used to populate fields if vendor did not provide SSN	but Link_SSN field should be used for DID'g	
	temp_ssn := IF(L.app_ssn = '' and L.ssn <> '', L.ssn, 
									IF(L.app_ssn = '' and L.link_ssn <> '', L.link_ssn, L.app_ssn));

//Only valid for internal test records										

SELF.app_ssn := if(L.cust_name <> '' and  L.app_ssn = '' and L.ssn <> '', L.ssn,
                                                                   if(L.cust_name <> '' and  L.app_ssn = '' and L.link_ssn <> '', L.link_ssn,
                                                                        L.app_ssn));
															
SELF.app_tax_id := if(L.cust_name <> '' and  L.app_tax_id = '' and L.tax_id <> '', L.tax_id,
                                                                                if(L.cust_name <> '' and  L.app_tax_id = '' and L.link_fein <> '', L.link_fein,
                                                                                                L.app_tax_id));
//
	//Linking ID's
	SELF.DID  				:= IF(trim(L.DID) != '',L.DID,
													(string12)prte2.fn_AppendFakeID.did(SELF.fname, SELF.lname, temp_ssn, L.link_dob, L.cust_name)); 
	SELF.BDID 				:= IF(trim(L.BDID) != '', L.BDID,
													(string12)prte2.fn_AppendFakeID.bdid(SELF.cname, L.prim_range, L.prim_name, L.v_city_name, L.st, L.zip, L.cust_name));
	
	vLinkingIds     := Prte2.fn_AppendFakeID.LinkIds(SELF.cname, L.link_fein, L.link_inc_date, L.prim_range, L.prim_name, L.sec_range, L.v_city_name, L.st, L.zip, L.cust_name);
	
	SELF.powid				:= vLinkingIds.powid;
	SELF.proxid				:= vLinkingIds.proxid;
	SELF.seleid				:= vLinkingIds.seleid;
	SELF.orgid				:= vLinkingIds.orgid;
	SELF.ultid				:= vLinkingIds.ultid;
	SELF	:= L;
	SELF	:= [];
END;

pCleanSearch	:= PROJECT(ded_jSearch, tCleanNAddr(LEFT));

//Append new records to previous records
fSearchAll	:= Search_in(trim(cust_name) = '' or (trim(cust_name) != '' and (trim(DID) != '' or trim(bdid) != ''))) + pCleanSearch;
dedSearch		:= DEDUP(SORT(fSearchAll,TMSID,orig_lname,orig_company),record, ALL);

PromoteSupers.Mac_SF_BuildProcess(dedSearch, Constants.BASE_PREFIX +'search', build_search_base);

RETURN SEQUENTIAL(build_main_base, build_search_base);

END;