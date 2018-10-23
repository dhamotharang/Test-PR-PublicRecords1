export fn_join_watchdog(dids, d_field, key, use_dist = 'false') := functionmacro

		import dx_BestRecords, ut;

		#uniquename(out_fmt);
		%out_fmt% := record(dx_BestRecords.layout_best)
			recordof(dids) _bestrec_input;
		end;

		return if(use_dist, 
			join(distribute(dids, hash64(d_field)), distribute(pull(key), hash64(did)),
				(left.d_field = right.did),							
				transform(
					%out_fmt%,
					self._bestrec_input := left,
					self.age := if ( right.dob = 0, 0, ut.age(right.dob) ),
					self := right
				), keep(1), limit(0), local),
			join(dids, key,
				keyed(left.d_field = right.did),							
				transform(
					%out_fmt%,
					self._bestrec_input := left,
					self.age := if ( right.dob = 0, 0, ut.age(right.dob) ),
					self := right
				), keep(1), limit(0)));

	endmacro;