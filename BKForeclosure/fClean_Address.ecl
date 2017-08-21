IMPORT ut, aid;

EXPORT fClean_Address    := MODULE
//Clean address for REO 
EXPORT Cln_REO(DATASET(RECORDOF(layout_BK.ClnName_REO)) dinFile) := FUNCTION
layout_address_reo		:= RECORD
	unsigned  rawaidin;
	STRING		address1;
	STRING		address2;
	Layout_BK.ClnName_REO;
END;

layout_address_reo t_clean_address_reo (dinFile le)		:= TRANSFORM
	SELF.address1	:= stringlib.StringToUpperCase(StringLib.StringCleanSpaces(stringlib.stringfilterout(le.Orig_Address,'+.#')));
	SELF.address2	:= stringlib.StringToUpperCase(TRIM(StringLib.StringCleanSpaces(TRIM(le.Orig_city)  + IF(le.Orig_city <> '',',','')
																			+ ' '+ le.Orig_state
																			+ ' '+ le.Orig_zip5
														),LEFT,RIGHT
							));
	SELF.rawaidin	:= 0;						

	SELF := le;
END;

proj_addr_rec_in	:= PROJECT(dinFile,t_clean_address_reo(left));

aid.common.xflags laidappendflags := aid.common.eReturnValues.rawaid | aid.common.eReturnValues.ACECacheRecords;	
aid.MacAppendFromRaw_2Line(proj_addr_rec_in,Address1, address2, rawAIDin, proj_addr_rec_out, laidappendflags);

cleaned_reo		:= proj_addr_rec_out;

Layout_BK.ClnAddr_Reo tNormAidAppends_reo(RECORDOF(cleaned_reo) le):= TRANSFORM
 SELF.rawAIDin 		:=le.aidwork_rawaid;
 SELF.cleanaid 		:=le.aidwork_acecache.cleanaid;
 SELF.addresstype	:=le.aidwork_acecache.addresstype;
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

 Cln_Addr_Reo := PROJECT(cleaned_reo, tNormAidAppends_reo(LEFT)): PERSIST('~thor_data400::in::BKForeclosure::Cln_Addr_Reo');

 RETURN Cln_Addr_Reo;
 END;


//Clean address for Nod
EXPORT Cln_Nod(DATASET(RECORDOF(layout_BK.ClnName_NOD)) dinFile) := FUNCTION
layout_address_nod		:= RECORD
	UNSIGNED  rawaidin;
	STRING		address1;
	STRING		address2;
	Layout_BK.ClnName_NOD;
END;

layout_address_nod t_clean_address_nod (dinFile le)		:= TRANSFORM
	SELF.address1	:= stringlib.StringToUpperCase(StringLib.StringCleanSpaces(stringlib.stringfilterout(le.Orig_Address,'+.#')));
	SELF.address2	:= stringlib.StringToUpperCase(TRIM(StringLib.StringCleanSpaces(TRIM(le.Orig_city)  + IF(le.Orig_city <> '',',','')
																			+ ' '+ le.Orig_state
																			+ ' '+ le.Orig_zip5
														),LEFT,RIGHT
							));
	SELF.rawaidin	:= 0;						

	SELF := le;
END;

proj_addr_rec_in	:= project(dinFile,t_clean_address_nod(left));

aid.common.xflags laidappendflags := aid.common.eReturnValues.rawaid | aid.common.eReturnValues.ACECacheRecords;	
aid.MacAppendFromRaw_2Line(proj_addr_rec_in,Address1, address2, rawAIDin, proj_addr_rec_out, laidappendflags);

cleaned_nod		:= proj_addr_rec_out;

Layout_BK.ClnAddr_Nod tNormAidAppends_nod(recordof(cleaned_nod) le):= TRANSFORM
 SELF.rawAIDin 		:=le.aidwork_rawaid;
 SELF.cleanaid 		:=le.aidwork_acecache.cleanaid;
 SELF.addresstype	:=le.aidwork_acecache.addresstype;
 SELF.prim_range	:=le.aidwork_acecache.prim_range;
 SELF.predir	  	:=le.aidwork_acecache.predir;
 SELF.prim_name		:=le.aidwork_acecache.prim_name;
 SELF.addr_suffix	:=le.aidwork_acecache.addr_suffix;
 SELF.postdir		  :=le.aidwork_acecache.postdir;
 SELF.unit_desig	:=le.aidwork_acecache.unit_desig;
 SELF.sec_range		:=le.aidwork_acecache.sec_range;
 SELF.p_city_name	:=le.aidwork_acecache.p_city_name;
 SELF.v_city_name	:=le.aidwork_acecache.v_city_name;
 SELF.st		     	:=le.aidwork_acecache.st;
 SELF.zip			    :=le.aidwork_acecache.zip5;
 SELF.zip4			  :=le.aidwork_acecache.zip4;
 SELF.cart			  :=le.aidwork_acecache.cart;
 SELF.cr_sort_sz	:=le.aidwork_acecache.cr_sort_sz;
 SELF.lot		    	:=le.aidwork_acecache.lot;
 SELF.lot_order		:=le.aidwork_acecache.lot_order;
 SELF.dbpc			  :=le.aidwork_acecache.dbpc;
 SELF.chk_digit		:=le.aidwork_acecache.chk_digit;
 SELF.rec_type		:=le.aidwork_acecache.rec_type;
 SELF.county	  	:=le.aidwork_acecache.county;
 SELF.geo_lat	  	:=le.aidwork_acecache.geo_lat;
 SELF.geo_long		:=le.aidwork_acecache.geo_long;
 SELF.msa			    :=le.aidwork_acecache.msa;
 SELF.geo_blk	  	:=le.aidwork_acecache.geo_blk;
 SELF.geo_match		:=le.aidwork_acecache.geo_match;
 SELF.err_stat		:=le.aidwork_acecache.err_stat;
 SELF				      :=le;
END;

 Cln_Addr_Nod := PROJECT(cleaned_nod, tNormAidAppends_nod(LEFT)): PERSIST('~thor_data400::in::BKForeclosure::Cln_Addr_Nod');	   

 RETURN Cln_Addr_Nod;
 END;

END;