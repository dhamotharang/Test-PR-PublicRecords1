import	watchdog;
EXPORT proc_IsBestAddressAvailable(DATASET(Spokeo.Layout_temp) src) := FUNCTION
/**
 see if watchdog has a better address that can't be used because it is restricted
 **/
			spk := DISTRIBUTE(src(LexId<>0,current_address_flag='Y'), LexId);
 			dog := DISTRIBUTE(watchdog.file_best, did);

			j := JOIN(spk, dog, 
								left.LexId=right.did, 
								TRANSFORM(Spokeo.Layout_temp,
									// see if watchdog has a "better" address
									self.better_address_flag := IF(
												(right.prim_name <> '' AND right.zip<>'') AND
												(left.prim_range<>right.prim_range OR
												left.prim_name<>right.prim_name OR
												left.zip<>right.zip OR
												left.sec_range<>right.sec_range), 
												'Y','');
									
									self := left), LEFT OUTER, KEEP(1), LOCAL);

		return j + src(LexId=0 OR current_address_flag<>'Y');
END;