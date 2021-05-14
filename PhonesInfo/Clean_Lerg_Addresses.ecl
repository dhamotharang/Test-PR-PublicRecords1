#OPTION('multiplePersistInstances',FALSE);
IMPORT aid, aid_support, std, ut;

	////////////////////////////////////////////////////////////////////////////////
	//Clean Lerg Input Files////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////
		
		//Lerg Input Files	
		lergComb						:= PhonesInfo.File_Lerg.Lerg1Prep;									//Prepped Lerg1 & Lerg1Con Files (Use for Monthly Update)

		//Standard AID Address Cleaner
		unsigned4 lAIDAppendFlags			:= AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords | AID.Common.eReturnValues.NoNewCacheFiles;		
		AID.MacAppendFromRaw_2Line(lergComb, address1, address2, append_Rawaid, addrComb, lAIDAppendFlags);
		
		Layout_Lerg.lergPrep clnTr(addrComb l):= transform	
			self.ocn										:= PhonesInfo._functions.fn_standardName(l.ocn);
			self.prim_range 						:= if(l.AIDWork_ACECache.prim_range ='0','',l.AIDWork_ACECache.prim_range);
			self.predir 								:= l.AIDWork_ACECache.predir;
			self.prim_name 							:= l.AIDWork_ACECache.prim_name;
			self.addr_suffix 						:= l.AIDWork_ACECache.addr_suffix;
			self.postdir 								:= l.AIDWork_ACECache.postdir;
			self.unit_desig 						:= l.AIDWork_ACECache.unit_desig;
			self.sec_range 							:= l.AIDWork_ACECache.sec_range;
			self.p_city_name 						:= l.AIDWork_ACECache.p_city_name;
			self.v_city_name 						:= l.AIDWork_ACECache.v_city_name;
			self.st 										:= l.AIDWork_ACECache.st;
			self.z5 										:= l.AIDWork_ACECache.zip5;
			self.zip4 									:= l.AIDWork_ACECache.zip4;
			self.cart 									:= l.AIDWork_ACECache.cart;
			self.cr_sort_sz 						:= l.AIDWork_ACECache.cr_sort_sz;
			self.lot 										:= l.AIDWork_ACECache.lot;
			self.lot_order 							:= l.AIDWork_ACECache.lot_order;
			self.dpbc 									:= l.AIDWork_ACECache.dbpc;
			self.chk_digit 							:= l.AIDWork_ACECache.chk_digit;
			self.rec_type 							:= l.AIDWork_ACECache.rec_type;
			self.ace_fips_st   					:= l.AIDWork_ACECache.county[1..2];
			self.fips_county 						:= l.AIDWork_ACECache.county[3..];
			self.geo_lat 								:= l.AIDWork_ACECache.geo_lat;
			self.geo_long 							:= l.AIDWork_ACECache.geo_long;
			self.msa 										:= l.AIDWork_ACECache.msa;
			self.geo_blk 								:= l.AIDWork_ACECache.geo_blk;
			self.geo_match 							:= l.AIDWork_ACECache.geo_match;
			self.err_stat 							:= l.AIDWork_ACECache.err_stat;	
			self.address_type						:= '';
			self.privacy_indicator 			:= '';
			self.opname									:= '';
			self.is_new									:= '';
			self.rec_update							:= '';
			self 												:= l;
		end;	
			
		cleanAdd  				:= project(addrComb, clnTr(left)):persist('~thor400_data::persist::lerg_address_aid');		
	
EXPORT Clean_Lerg_Addresses := cleanAdd;
