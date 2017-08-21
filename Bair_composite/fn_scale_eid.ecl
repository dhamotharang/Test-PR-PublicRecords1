EXPORT fn_scale_eid (string23 eid) := function
		unsigned6 max_eid := 281474976710655;  //max unsigned6
		new_eid
			:=
				(unsigned6)
					((unsigned8)( hash64(hashmd5(eid)) ) % max_eid)
				;
		return new_eid;
	end;