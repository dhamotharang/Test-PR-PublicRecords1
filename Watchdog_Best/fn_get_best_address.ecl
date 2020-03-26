IMPORT header;

residential(string prim_name, string st) := 
						NOT REGEXFIND('^(PO BOX|RR|HC)\\b', prim_name) AND st<>'AP';
EXPORT fn_get_best_address(dataset(recordof(Watchdog_Best.Layout_Hdr)) file_in, string1 level = '1') := function

		k := DISTRIBUTE(Header.Key_Addr_Unique_Expanded()(addr_ind=level,best_addr_rank='1',residential(prim_name,st)), did);
		f := DISTRIBUTE(file_in, did);

		result := JOIN(f, k, left.did=right.did AND 
										left.prim_range           = right.prim_range AND
										left.prim_name            = right.prim_name  AND
									  left.sec_range					  = right.sec_range  AND
									  left.st                   = right.st AND
										left.zip									= right.zip,
		
				TRANSFORM(Watchdog_Best.Layout_Hdr,
					self.tnt := IF(right.best_addr_ind='B', level, left.tnt);
					self := left;),
				LEFT OUTER, KEEP(1), LOCAL);
				
		return result;

END;