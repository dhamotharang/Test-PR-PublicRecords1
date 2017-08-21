EXPORT proc_flagCurrentRecords(DATASET(Spokeo.Layout_temp) src) := FUNCTION


/*
  If spokeo does not match infutor then SORT DESCEND our LN last_seen to flag current, confirmed would be blank
*/
			gr1 := SORT(DISTRIBUTE(src(LexId<>0), LexId), LexId, -current_address_flag, -dt_last_seen, LOCAL);
			gr := GROUP(gr1, LexId, LOCAL);
			
						// the most recent record is considered to be current
			Spokeo.Layout_Temp xii(Spokeo.Layout_Temp L, Spokeo.Layout_Temp R, integer n) := TRANSFORM
							self.current_address_flag := MAP(
											n=1 and R.dt_last_seen<>0 => 'Y',
											n>1 and L.dt_last_seen=R.dt_last_seen and L.Prepped_addr1=R.Prepped_addr1 and L.Prepped_addr2=R.Prepped_addr2
																=> L.current_address_flag,
											R.current_address_flag);
							self := R;
			END;					
			current := ITERATE(gr, xii(LEFT, RIGHT, COUNTER));
			result := UNGROUP(current) + src(LexId=0);



			return result;

END;
/*
			Spokeo.Layout_Temp xi(Spokeo.Layout_Temp L, integer n) := TRANSFORM
							self.current_address_flag := IF(n=1 and L.dt_last_seen<>0, 'Y', L.current_address_flag);
							self := L;
			END;					

			makecurrent := PROJECT(gr, xi(LEFT,COUNTER)); 

			result := UNGROUP(makecurrent) + src(LexId=0);
*/
