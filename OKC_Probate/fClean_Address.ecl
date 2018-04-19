#OPTION('multiplePersistInstances',FALSE);
IMPORT ut, aid;

EXPORT fClean_Address(DATASET(RECORDOF(Layout.CleanName)) dinFile) := FUNCTION
layout_address		:= RECORD
	unsigned  rawaidin;
	STRING		address1;
	STRING		address2;
	Layout.CleanName;
END;

layout_address t_clean_address (dinFile le)		:= TRANSFORM
	SELF.address1	:= StringLib.StringCleanSpaces(stringlib.stringfilterout(TRIM(le.DebtorAddress1) + ' ' + TRIM(le.DebtorAddress2),'+.#'));
	SELF.address2	:= stringlib.StringToUpperCase(TRIM(StringLib.StringCleanSpaces(TRIM(le.DebtorAddressCity)  + IF(le.DebtorAddressCity <> '',',','')
																			+ ' '+ le.DebtorAddressState
																			+ ' '+ le.DebtorAddressZipCode
														),LEFT,RIGHT
							));
	SELF.rawaidin	:= 0;						

	SELF := le;
END;

proj_addr_rec_in	:= PROJECT(dinFile,t_clean_address(left));

aid.common.xflags laidappendflags := aid.common.eReturnValues.rawaid | aid.common.eReturnValues.ACECacheRecords;	
aid.MacAppendFromRaw_2Line(proj_addr_rec_in,Address1, address2, rawAIDin, proj_addr_rec_out, laidappendflags);

//map to raw_v2 output
Layout.CleanAddress tCleanAddr(RECORDOF(proj_addr_rec_out) le):= TRANSFORM
 SELF.rawAIDin 		:=le.aidwork_rawaid;
 SELF.cleanaid 		:=le.aidwork_acecache.cleanaid;
 SELF.addresstype	:=le.aidwork_acecache.addresstype;
 SELF.prim_range	:=le.aidwork_acecache.prim_range;
 SELF.predir		   :=le.aidwork_acecache.predir;
 SELF.prim_name		:=le.aidwork_acecache.prim_name;
 SELF.addr_suffix	:=le.aidwork_acecache.addr_suffix;
 SELF.postdir	  	:=le.aidwork_acecache.postdir;
 SELF.unit_desig	:=le.aidwork_acecache.unit_desig;
 SELF.sec_range		:=le.aidwork_acecache.sec_range;
 SELF.p_city_name	:=le.aidwork_acecache.p_city_name;
 SELF.v_city_name	:=le.aidwork_acecache.v_city_name;
 SELF.st       	:=le.aidwork_acecache.st;
 SELF.zip			    :=le.aidwork_acecache.zip5;
 SELF.zip4		   	:=le.aidwork_acecache.zip4;
 SELF.cart		   	:=le.aidwork_acecache.cart;
 SELF.cr_sort_sz	:=le.aidwork_acecache.cr_sort_sz;
 SELF.lot			     :=le.aidwork_acecache.lot;
 SELF.lot_order		:=le.aidwork_acecache.lot_order;
 SELF.dbpc		    	:=le.aidwork_acecache.dbpc;
 SELF.chk_digit		:=le.aidwork_acecache.chk_digit;
 SELF.rec_type	 	:=le.aidwork_acecache.rec_type;
	SELF.fips_state		:=	le.aidwork_acecache.county[1..2];
	SELF.fips_county	:=	le.aidwork_acecache.county[3..];
 SELF.geo_lat		  :=le.aidwork_acecache.geo_lat;
 SELF.geo_long	 	:=le.aidwork_acecache.geo_long;
 SELF.msa			     :=le.aidwork_acecache.msa;
 SELF.geo_blk		  :=le.aidwork_acecache.geo_blk;
 SELF.geo_match		:=le.aidwork_acecache.geo_match;
 SELF.err_stat	 	:=le.aidwork_acecache.err_stat;
 SELF			    	    :=le;
END;

 Cln_Addr := PROJECT(proj_addr_rec_out, tCleanAddr(LEFT)):PERSIST(PersistNames.OKCProbateCleanAddress);

 RETURN Cln_Addr;
 
 END;
