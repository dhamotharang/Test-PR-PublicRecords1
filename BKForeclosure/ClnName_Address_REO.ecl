IMPORT BKForeclosure, ut, address, DID_Add, NID, AID, AID_Support, std, BIPV2;
#option('multiplePersistInstances',FALSE);
#CONSTANT(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);
#STORED('did_add_force','thor');

//Clean Names for REO	
EXPORT ClnName_Address_REO(DATASET(RECORDOF(Layout_BK.CleanFields_REO)) dNormFile) := FUNCTION
NID.Mac_CleanFullNames(dNormFile,FileClnName,name_full
												,includeInRepository:=false, normalizeDualNames:=true, useV2 := true);
												
//Name flags
	person_flags := ['P', 'D'];
	business_flags := ['B', 'U', 'I', 'T'];
												
ClnName_reo      := PROJECT(FileClnName,TRANSFORM(Layout_BK.CleanFields_REO,
																									BOOLEAN IsName	:=	LEFT.nametype IN person_flags OR
																																			(LEFT.nametype = 'U' AND trim(LEFT.cln_fname) != '' AND TRIM(LEFT.cln_lname) != ''); 
																									SELF.cln_title				:=	IF(IsName, LEFT.cln_title, '');
																									SELF.cln_fname				:=	IF(IsName, LEFT.cln_fname, '');
																									SELF.cln_mname				:=	IF(IsName, LEFT.cln_mname, '');
																									SELF.cln_lname				:=	IF(IsName, LEFT.cln_lname, '');
																									SELF.cln_suffix				:=	IF(IsName, LEFT.cln_suffix, '');
																									SELF.cln_title2				:=	IF(IsName, LEFT.cln_title2, '');
																									SELF.cln_fname2				:=	IF(IsName, LEFT.cln_fname2, '');
																									SELF.cln_mname2				:=	IF(IsName, LEFT.cln_mname2, '');
																									SELF.cln_lname2				:=	IF(IsName, LEFT.cln_lname2, '');
																									SELF.cln_suffix2			:=	IF(IsName, LEFT.cln_suffix2, '');
																									SELF.cname						:=  IF(LEFT.nametype IN business_flags AND trim(LEFT.cln_fname) = '',LEFT.name_full,
																																							IF(TRIM(LEFT.cln_fname) = '' AND TRIM(LEFT.cln_lname) = '',LEFT.name_full,''));
																									SELF := LEFT));

//Clean address for REO 
layout_address_reo		:= RECORD
	STRING		address1;
	STRING		address2;
	Layout_BK.CleanFields_REO;
END;

layout_address_reo t_clean_address_reo (ClnName_reo le)		:= TRANSFORM
	SELF.address1	:= Address.fn_addr_clean_prep(le.Orig_Address,'first');
	SELF.address2	:= Address.fn_addr_clean_prep(TRIM(le.Orig_city)  
																						+ IF(le.Orig_city <> '',', ','')
																						+ ' '+ le.Orig_state
																						+ ' '+ TRIM(le.Orig_zip5+le.Orig_zip4),'last');					

	SELF := le;
	SELF := [];
END;

AddrPrep	:= PROJECT(ClnName_reo,t_clean_address_reo(left));

rsAID_NoAddr		:=	AddrPrep(TRIM(address1) = '' OR TRIM(address2) = '' 
																OR LENGTH(Orig_zip5)<5 OR TRIM(Orig_state) = '');
rsAID_Addr			:=	AddrPrep(TRIM(address1) != '' AND TRIM(address2) != ''
																AND LENGTH(Orig_zip5) = 5 AND TRIM(Orig_state) != '');

aid.common.xflags laidappendflags := aid.common.eReturnValues.rawaid | aid.common.eReturnValues.ACECacheRecords;	
aid.MacAppendFromRaw_2Line(rsAID_Addr,Address1, address2, rawAid, addr_rec_out, laidappendflags);


Layout_BK.CleanFields_REO tNormAidAppends(addr_rec_out le):= TRANSFORM
 SELF.rawAid 			:=le.aidwork_rawaid;
 SELF.prim_range	:=le.aidwork_acecache.prim_range;
 SELF.predir		  :=le.aidwork_acecache.predir;
 SELF.prim_name		:=le.aidwork_acecache.prim_name;
 SELF.addr_suffix	:=le.aidwork_acecache.addr_suffix;
 SELF.postdir	  	:=le.aidwork_acecache.postdir;
 SELF.unit_desig	:=le.aidwork_acecache.unit_desig;
 SELF.sec_range		:=le.aidwork_acecache.sec_range;
 SELF.p_city_name	:=le.aidwork_acecache.p_city_name;
 SELF.v_city_name	:=le.aidwork_acecache.v_city_name;
 SELF.st		    	:=le.aidwork_acecache.st;
 SELF.zip			    :=le.aidwork_acecache.zip5;
 SELF.zip4		   	:=le.aidwork_acecache.zip4;
 SELF.cart		  	:=le.aidwork_acecache.cart;
 SELF.cr_sort_sz	:=le.aidwork_acecache.cr_sort_sz;
 SELF.lot			    :=le.aidwork_acecache.lot;
 SELF.lot_order		:=le.aidwork_acecache.lot_order;
 SELF.dbpc		  	:=le.aidwork_acecache.dbpc;
 SELF.chk_digit		:=le.aidwork_acecache.chk_digit;
 SELF.rec_type		:=le.aidwork_acecache.rec_type;
 SELF.county		  :=le.aidwork_acecache.county;
 SELF.geo_lat		  :=le.aidwork_acecache.geo_lat;
 SELF.geo_long		:=le.aidwork_acecache.geo_long;
 SELF.msa			    :=le.aidwork_acecache.msa;
 SELF.geo_blk		  :=le.aidwork_acecache.geo_blk;
 SELF.geo_match		:=le.aidwork_acecache.geo_match;
 SELF.err_stat		:=le.aidwork_acecache.err_stat;
 SELF			    	  :=le;
END;

 Cln_GoodAddr := PROJECT(addr_rec_out, tNormAidAppends(LEFT)): PERSIST('~thor_data400::in::BKForeclosure::Cln_Addr_Reo');
 
Layout_BK.CleanFields_REO tNoAddrClean(rsAID_NoAddr le):= TRANSFORM
 cl_addr			:= Address.CleanAddress182(le.address1, TRIM(le.Orig_city) + ' ' + TRIM(le.Orig_state) + ' ' + TRIM(le.Orig_zip5));
 SELF.rawAid	 		:= le.rawaid;
 SELF.prim_range	:= cl_addr[1..10];
 SELF.predir	  	:= cl_addr[11..12];
 SELF.prim_name		:= cl_addr[13..40];
 SELF.addr_suffix	:= cl_addr[41..44];
 SELF.postdir		  := cl_addr[45..46];
 SELF.unit_desig	:= cl_addr[47..56];
 SELF.sec_range		:= cl_addr[57..64];
 SELF.p_city_name	:= cl_addr[65..89];
 SELF.v_city_name	:= cl_addr[90..114];
 SELF.st		     	:= cl_addr[115..116];
 SELF.zip			    := cl_addr[117..121];
 SELF.zip4			  := cl_addr[122..125];
 SELF.cart			  := cl_addr[126..129];
 SELF.cr_sort_sz	:= cl_addr[130];
 SELF.lot		    	:= cl_addr[131..134];
 SELF.lot_order		:= cl_addr[135];
 SELF.dbpc			  := cl_addr[136..137];
 SELF.chk_digit		:= cl_addr[138];
 SELF.rec_type		:= cl_addr[139..140];
 SELF.county	  	:= cl_addr[141..145];
 SELF.geo_lat	  	:= cl_addr[146..155];
 SELF.geo_long		:= cl_addr[156..166];
 SELF.msa			    := cl_addr[167..170];
 SELF.geo_blk	  	:= cl_addr[171..177];
 SELF.geo_match		:= cl_addr[178];
 SELF.err_stat		:= cl_addr[179..182];;
 SELF				      :=le;
END;

 Cln_NoAddr := PROJECT(rsAID_NoAddr, tNoAddrClean(LEFT));
 
 rsCleanAIDGood := Cln_GoodAddr + Cln_NoAddr;

 RETURN rsCleanAIDGood;
 END;