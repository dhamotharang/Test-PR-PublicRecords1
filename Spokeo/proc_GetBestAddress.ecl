/*
get best address for a group of records associated with a LexId

*/

EXPORT proc_GetBestAddress(Dataset(spokeo.Layout_Out) src) := FUNCTION
		lnsrc := DISTRIBUTE(src(address_source='L'), LexId);			// LN Sourced records
		
		spsrc := DISTRIBUTE(src(address_source='S'), Lexid);
		
		// with no LexId, this is as good as it gets ... NO best address
		nobest := PROJECT(src(address_source=''), TRANSFORM(spokeo.Layout_Best,
/*											self.BestAddressStreet 				:= left.cln_addr1;
											self.BestAddressCityStateZip	:= left.cln_addr2;
											self.BestAddressLatitude			:= left.latitude;
											self.BestAddressLongitude			:= left.longitude;
											self.BestAddressAddressType		:= left.address_type;
											self.best_first_seen					:= left.dt_first_seen;
											self.best_last_seen						:= left.dt_last_seen;
											self.BestAddressId						:= left.address_id;*/
											self := left;
											self := [];));
		
		// if there is an LN sourced address, use that as the best
		pass1 := JOIN(spsrc, lnsrc, left.LexId=right.LexId, TRANSFORM(spokeo.Layout_Best,
											self.BestAddressStreet 				:= right.cln_addr1;
											self.BestAddressCityStateZip	:= right.cln_addr2;
											self.BestAddressLatitude			:= right.latitude;
											self.BestAddressLongitude			:= right.longitude;
											self.BestAddressAddressType		:= right.address_type;
											self.best_first_seen					:= right.dt_first_seen;
											self.best_last_seen						:= right.dt_last_seen;
											self.BestAddressId						:= right.address_id;
											self := left;), LEFT OUTER, KEEP(1), LOCAL);
		
		// Look for a confirmed address
		miss1 := pass1(BestAddressId=0);			// no LN sourced address
		confirmed := miss1(confirmed_address_flag='Y');
		pass2	:= JOIN(miss1, confirmed, left.LexId=right.LexId, TRANSFORM(spokeo.Layout_Best,
											self.BestAddressStreet 				:= right.cln_addr1;
											self.BestAddressCityStateZip	:= right.cln_addr2;
											self.BestAddressLatitude			:= right.latitude;
											self.BestAddressLongitude			:= right.longitude;
											self.BestAddressAddressType		:= right.address_type;
											self.best_first_seen					:= right.dt_first_seen;
											self.best_last_seen						:= right.dt_last_seen;
											self.BestAddressId						:= right.address_id;
											self := left;), LEFT OUTER, KEEP(1), LOCAL);
		
		// now choose the most recent address
		miss2 := pass2(BestAddressId=0);
		recent := DEDUP(SORT(DISTRIBUTE(miss2, LexId), Lexid, -dt_last_seen, LOCAL), LexId, LOCAL);
		pass3	:= JOIN(miss2, recent, left.LexId=right.LexId, TRANSFORM(spokeo.Layout_Best,
											self.BestAddressStreet 				:= right.cln_addr1;
											self.BestAddressCityStateZip	:= right.cln_addr2;
											self.BestAddressLatitude			:= right.latitude;
											self.BestAddressLongitude			:= right.longitude;
											self.BestAddressAddressType		:= right.address_type;
											self.best_first_seen					:= right.dt_first_seen;
											self.best_last_seen						:= right.dt_last_seen;
											self.BestAddressId						:= right.address_id;
											self := left;), LEFT OUTER, KEEP(1), LOCAL);
		
											
		result := pass1(BestAddressId<>0) + pass2(BestAddressId<>0) + pass3 + nobest;
		
		return result;

END;