import aid, address, Std;

rAddress := RECORD
		string70			prepped_addr1;
		string40			prepped_addr2;
		Cortera.Layout_Header_Out;
END;

IsSpecified(string addr) := IF(addr='(UNSPECIFIED)', '', addr);

EXPORT proc_cleanAddresses(dataset(Cortera.Layout_Header_Out) basein) := FUNCTION

	basein_us_addr_recs 		:= basein(country='US');
	basein_non_us_addr_recs := basein(country<>'US');
	
	ds := PROJECT(basein_us_addr_recs, TRANSFORM(rAddress,
																								self.prepped_addr1 := std.Str.CleanSpaces(IsSpecified(Std.Str.ToUpperCase(left.ADDRESS)) + ' ' + Std.Str.ToUpperCase(left.ADDRESS2));
																								self.prepped_addr2 := std.Str.CleanSpaces(STD.Str.CleanSpaces(
																																			trim(Std.Str.ToUpperCase(left.city)) + if(left.city <> '',',','')
																																				+ ' '+ Std.Str.ToUpperCase(left.State)
																																				+ ' '+ left.POSTALCODE[1..5]));		// note: do not pass zip4 to AID
																								self 							 := left;
																							 )
							 );

	ok := ds(prepped_addr2<>'');
	aid.common.xflags laidappendflags := aid.common.eReturnValues.rawaid | aid.common.eReturnValues.ACECacheRecords;
	aid.MacAppendFromRaw_2Line(ok, prepped_addr1, prepped_addr2, rawaid , precln, laidappendflags);

	clean := PROJECT(precln, TRANSFORM(Cortera.Layout_Header_Out,
								self.rawaid := left.aidwork_rawaid;
								self.prim_range		:=	left.AIDWork_AceCache.prim_range;
								self.predir				:=	left.AIDWork_AceCache.predir;
								self.prim_name		:=	left.AIDWork_AceCache.prim_name;
								self.addr_suffix	:=	left.AIDWork_AceCache.addr_suffix;
								self.postdir			:=	left.AIDWork_AceCache.postdir;
								self.unit_desig		:=	left.AIDWork_AceCache.unit_desig;
								self.sec_range		:=	left.AIDWork_AceCache.sec_range;
								self.p_city_name	:=	left.AIDWork_AceCache.p_city_name;
								self.v_city_name	:=	left.AIDWork_AceCache.v_city_name;
								self.st						:=	left.AIDWork_AceCache.st;
								self.zip					:=	left.AIDWork_AceCache.zip5;
								self.zip4					:=	left.AIDWork_AceCache.zip4;
								self.cart					:=	left.AIDWork_AceCache.cart;
								self.cr_sort_sz		:=	left.AIDWork_AceCache.cr_sort_sz;
								self.lot					:=	left.AIDWork_AceCache.lot;
								self.lot_order		:=	left.AIDWork_AceCache.lot_order;
								self.dbpc					:=	left.AIDWork_AceCache.dbpc;
								self.chk_digit		:=	left.AIDWork_AceCache.chk_digit;
								self.rec_type			:=	left.AIDWork_AceCache.rec_type;
								self.county				:=	left.AIDWork_AceCache.county;
								self.geo_lat			:=	left.AIDWork_AceCache.geo_lat;
								self.geo_long			:=	left.AIDWork_AceCache.geo_long;
								self.msa					:=	left.AIDWork_AceCache.msa;
								self.geo_blk			:=	left.AIDWork_AceCache.geo_blk;
								self.geo_match		:=	left.AIDWork_AceCache.geo_match;
								self.err_stat			:=	left.AIDWork_AceCache.err_stat;
								
	
								self := left;
				));	
	
		result := clean + PROJECT(ds(prepped_addr2 = ''),Cortera.Layout_Header_Out) + basein_non_us_addr_recs; 


	return result;

END;