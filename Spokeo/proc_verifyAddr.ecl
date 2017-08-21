import ut, std;
/**
If any Spokeo address matches infutor_watchdog then set confirmed_flag=Y. 
 If no Spokeo address matches watchdog then yes use last_seen to determine what's current.
**/

CurrentMonth := Std.Date.AdjustCalendar(Std.Date.Today(),0,-1,0) div 100;	// include previous month


EXPORT proc_verifyAddr(dataset(Spokeo.Layout_temp) basein) := FUNCTION

			spk := DISTRIBUTE(basein(LexId<>0), LexId);

			hdr := DISTRIBUTE(Spokeo.File_Infutor_Hdr, did);
			bst := DISTRIBUTE(Spokeo.File_Infutor_Best, did);

/*
	get address dates first/last seen from infutor header
*/
			j := JOIN(spk, hdr, 
								left.LexId=right.did AND
								left.prim_range=right.prim_range AND
								left.prim_name=right.prim_name AND
								left.zip=right.zip AND
								ut.NNEQ(left.sec_range, right.sec_range),
								TRANSFORM(Spokeo.Layout_temp,
									self.dt_first_seen := right.dt_first_seen;
									self.dt_last_seen := right.dt_last_seen;
									self.address_source := 'S';
									self := left), LEFT OUTER, KEEP(1), LOCAL);

/*
	use infutor watchdog to confirm address
  If spokeo matches infutor_watchdog then it is current and confirmed
*/
			j2 := JOIN(j, bst, 
								left.LexId=right.did AND
								left.prim_range=right.prim_range AND
								left.prim_name=right.prim_name AND
								left.zip=right.zip AND
								ut.NNEQ(left.sec_range, right.sec_range),
								TRANSFORM(Spokeo.Layout_temp,
									//self.dt_first_seen := right.addr_dt_first_seen;
									//self.dt_last_seen := right.addr_dt_last_seen;
									//self.current_address_flag := IF(right.addr_dt_last_seen>=CurrentMonth,'Y','');
									self.current_address_flag := IF(right.addr_dt_last_seen<>0,'Y','');
									self.confirmed_address_flag := IF(right.addr_dt_last_seen<>0,'Y','');
									self := left), LEFT OUTER,  KEEP(1), LOCAL);

			result := j2 + basein(LexId=0);

			return result;

END;