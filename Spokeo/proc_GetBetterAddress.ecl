import aid, AID_Build, std;

FixupAddress(DATASET(Spokeo.Layout_temp) src) := FUNCTION
	spk := PROJECT(src, TRANSFORM(Spokeo.Layout_temp,
				SELF.prepped_addr1     := STD.Str.CleanSpaces(left.prim_range + ' ' + left.predir + ' ' + left.prim_name + ' ' + left.addr_suffix
																		+ ' '	+ left.postdir + ' ' + left.unit_desig + ' ' + left.sec_range);
				SELF.prepped_addr2     := STD.Str.CleanSpaces(
																	trim(left.p_city_name) + if(left.p_city_name <> '',',','')
																		+ ' ' + left.st + ' ' + left.zip);
				self := left;));

	spkaid := spk(prepped_addr1<>'',prepped_addr2<>'');
	aid.common.xflags laidappendflags := aid.common.eReturnValues.rawaid | aid.common.eReturnValues.ACECacheRecords;
	aid.MacAppendFromRaw_2Line(spkaid, prepped_addr1, prepped_addr2, rawaid , spkcln, laidappendflags);
	
	spkcln2 := PROJECT(spkcln, TRANSFORM(Spokeo.Layout_Temp,
								self.rawaid := left.aidwork_rawaid;
								self.rec_type			:=	left.AIDWork_AceCache.rec_type;
								self.geo_lat			:=	left.AIDWork_AceCache.geo_lat;
								self.geo_long			:=	left.AIDWork_AceCache.geo_long;
								self.err_stat			:=	left.AIDWork_AceCache.err_stat;
								
								self := left;
							));	
	return spkcln2(err_stat[1]='S');
END;


EXPORT proc_GetBetterAddress(DATASET(Spokeo.Layout_temp) src) := FUNCTION
/**
Look for a better address in restricted Infutor
Insert a new record if infutor_watchdog has a more recent address than what Spokeo has provided.
  Flag the record as being sourced from Lexis and the Spokeo input fields will be blank.
  We're only adding a record if we have something more recent as the best address, 
	 Spokeo isn't interested in an additional historical record.

**/
			spk1 := DISTRIBUTE(src(LexId<>0), LexId);
		/* 
				find the most recent spk address. Either current or most recent
		*/
			spk := DEDUP(SORT(spk1,LexId,-current_address_flag,-dt_last_seen,LOCAL), 
														LexId,LOCAL);

			bst := DISTRIBUTE(Spokeo.File_Infutor_Best, did);

			j := JOIN(bst, spk, 
								left.did=right.LexId AND
								left.addr_dt_last_seen > right.dt_last_seen AND
								(left.prim_range<>right.prim_range OR
								left.prim_name<>right.prim_name OR
								left.zip<>right.zip), 
								//ut.NNEQ(left.sec_range, right.sec_range),
								TRANSFORM(Spokeo.Layout_temp,
									self.SpokeoID := right.SpokeoID;	// keep the id for late
									self.Prepped_name := right.Prepped_name;	// for debugging
									self.name := right.name;	// for debugging
									self.LexId := right.LexId;
									self.dob := '';			// don't populate dob from best
									self.phone := '';			// don't populate phone from best
									self.dt_first_seen := left.addr_dt_first_seen;
									self.dt_last_seen := left.addr_dt_last_seen;
									//self.confirmed_address_flag := IF(right.dt_last_seen=0,'','Y');
									self.address_source := 'L';					// source is LexisNexis
									self.current_address_flag := 'Y';
									self.confirmed_address_flag := '';
									self.better_address_flag := '';

									self.addr_suffix := left.suffix;
									self.p_city_name := left.city_name;
									self := left;
									self.address_id := HASH64(self.Prim_range, self.predir, self.prim_name, 
																					self.addr_suffix, self.postdir, self.sec_range, self.p_city_name, self.st, self.zip);									
									
									self := []), INNER, LOCAL);


/**
	Fill in missing fields from AID
**/																		
			k_aid := AID_Build.Key_AID_Base;

			lnsrc := DISTRIBUTE(j(rawaid<>0),rawaid);
			ln3 := FixupAddress(j(rawaid=0));

			ln2 := JOIN(lnsrc, DISTRIBUTE(PULL(k_aid), rawaid), 
									left.rawaid=right.rawaid, 
									TRANSFORM(Spokeo.Layout_Temp,
										self.geo_lat := right.geo_lat;
										self.geo_long := right.geo_long;
										self.rec_type := right.rec_type;
										self.err_stat := right.err_stat;
										self := left;),
									left outer, KEEP(1), LOCAL);

			k1a := src + ln2(err_stat[1]='S') + ln3;
			
			k1 := Spokeo.Fn_Append_HHId(k1a);
			
			k2 := SORT(k1, spokeoid, -address_source);
			
			return k2;

END;
/*
			ln2 := JOIN(lnsrc, k_aid, left.rawaid=right.rawaid, 
									TRANSFORM(Spokeo.Layout_Temp,
										self.geo_lat := right.geo_lat;
										self.geo_long := right.geo_long;
										self.rec_type := right.rec_type;
										self.err_stat := right.err_stat;
										self := left;),
									KEYED, left outer, KEEP(1));
*/

