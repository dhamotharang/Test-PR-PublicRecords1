import ut, aid;

layout_address		:= RECORD
	Unsigned Seq_Rec_Id;
	String68		address1;
	String52		address2;
					Layouts.Layout_Orig;
END;

cln_name		:= Clean_Names;

layout_address t_clean_address (cln_name le)		:= TRANSFORM
	SELF.address1	:= stringlib.StringToUpperCase(StringLib.StringCleanSpaces(stringlib.stringfilterout(le.address,'+.#')));
	SELF.address2	:= stringlib.StringToUpperCase(trim(StringLib.StringCleanSpaces(trim(le.city)  + if(le.city <> '',',','')
																			+ ' '+ le.state
																			+ ' '+ le.zip5[1..5]
														),left,right
							));
	SELF.rawaidin	:= 0;
	self.Orig_fname := le.firstname;
	self.Orig_lname := le.lastname;
	self.Orig_address := le.address;
	self.Orig_city := le.city;
	self.Orig_state := le.state;
	self.Orig_zip5 := le.zip5;
	self.Orig_zip4 := le.zip4;
	self.Orig_phone := le.phone;
	self.Orig_date := le.date;
	self := le;
END;

proj_addr_rec_in	:= project(cln_name,t_clean_address(left));

aid.common.xflags laidappendflags := aid.common.eReturnValues.rawaid | aid.common.eReturnValues.ACECacheRecords;	
aid.MacAppendFromRaw_2Line(proj_addr_rec_in,Address1, address2, rawAIDin, proj_addr_rec_out, laidappendflags);

cleaned		:= proj_addr_rec_out;
// cleaned		:= dataset('~thor400_88_staging::persist::infutorcid::clean',recordof(historical_out), thor);

DenormedRecOut		:= RECORD
   Unsigned 	Seq_Rec_Id;
   Layouts.Layout_Orig;
/* AID fields */
   Unsigned8	cleanaid;
   String1		addresstype;
   String10		prim_range;
   String2		predir;
   String28		prim_name;
   String4		addr_suffix;
   String2		postdir;
   String10		unit_desig;
   String8		sec_range;
   String25		p_city_name;
   String25		v_city_name;
   String2		st;
   String5		zip;
   String4		zip4;
   String4		cart;
   String1		cr_sort_sz;
   String4		lot;
   String1		lot_order;
   String2		dbpc;
   String1		chk_digit;
   String2		rec_type;
   String5		county;
   String10		geo_lat;
   String11		geo_long;
   String4		msa;
   String7		geo_blk;
   String1		geo_match;
   String4		err_stat;
END;

DenormedRecOut tNormAidAppends(recordof(cleaned) le):= TRANSFORM
 SELF.rawAIDin 		:=le.aidwork_rawaid;
 SELF.cleanaid 		:=le.aidwork_acecache.cleanaid;
 SELF.addresstype	:=le.aidwork_acecache.addresstype;
 SELF.prim_range	:=le.aidwork_acecache.prim_range;
 SELF.predir		:=le.aidwork_acecache.predir;
 SELF.prim_name		:=le.aidwork_acecache.prim_name;
 SELF.addr_suffix	:=le.aidwork_acecache.addr_suffix;
 SELF.postdir		:=le.aidwork_acecache.postdir;
 SELF.unit_desig	:=le.aidwork_acecache.unit_desig;
 SELF.sec_range		:=le.aidwork_acecache.sec_range;
 SELF.p_city_name	:=le.aidwork_acecache.p_city_name;
 SELF.v_city_name	:=le.aidwork_acecache.v_city_name;
 SELF.st			:=le.aidwork_acecache.st;
 SELF.zip			:=le.aidwork_acecache.zip5;
 SELF.zip4			:=le.aidwork_acecache.zip4;
 SELF.cart			:=le.aidwork_acecache.cart;
 SELF.cr_sort_sz	:=le.aidwork_acecache.cr_sort_sz;
 SELF.lot			:=le.aidwork_acecache.lot;
 SELF.lot_order		:=le.aidwork_acecache.lot_order;
 SELF.dbpc			:=le.aidwork_acecache.dbpc;
 SELF.chk_digit		:=le.aidwork_acecache.chk_digit;
 SELF.rec_type		:=le.aidwork_acecache.rec_type;
 SELF.county		:=le.aidwork_acecache.county;
 SELF.geo_lat		:=le.aidwork_acecache.geo_lat;
 SELF.geo_long		:=le.aidwork_acecache.geo_long;
 SELF.msa			:=le.aidwork_acecache.msa;
 SELF.geo_blk		:=le.aidwork_acecache.geo_blk;
 SELF.geo_match		:=le.aidwork_acecache.geo_match;
 SELF.err_stat		:=le.aidwork_acecache.err_stat;
 SELF				:=le;
END;

aid_append := PROJECT(cleaned, tNormAidAppends(LEFT));
		   
export Clean_Addresses :=aid_append:persist('~thor_data400::persist::optincellphones_clean_addresses');