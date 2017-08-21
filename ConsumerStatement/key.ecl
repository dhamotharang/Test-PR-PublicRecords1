/*2013-11-12T00:37:32Z (Todd Steil)

*/
EXPORT key := module
	
		shared getIndexdataset := module
			export fcra(string indextype) := function
				deduped := dedup(consumerstatement.ReadData.fcra,record,all);
				return	map(
											indextype = 'lexid' => sort(deduped, lexid),
											indextype = 'ssn' => sort(deduped, ssn)
								 );
			end;
			
			export nonfcra(string indextype) := function
				ds := consumerstatement.ReadData.nonfcra;
				return	map(
												/*indextype = 'phone' => dedup(sort(distribute(ds(phone <> ''),hash(phone)), phone,-date_submitted,-date_created),record,local) (override_flag <> 3),
												indextype = 'address' => dedup(sort(distribute(ds(st <> ''),hash(st,  v_city_name, zip, prim_range, prim_name, sec_range)), st, v_city_name, zip, prim_range, prim_name, sec_range, -date_submitted,-date_created, local), record, local),
												indextype = 'statement_id' => dedup(sort(distribute(ds(statement_id <> 0),hash(statement_id)), statement_id,-date_submitted,-date_created,local), record, local)*/
												
				
												indextype = 'phone' =>  dedup(sort(distribute(ds(phone <> ''),hash(phone)), phone,-date_submitted,-date_created,local),record, local)(override_flag <> 3),
												indextype = 'address' => dedup(sort(distribute(ds(st <> ''),hash(st,  p_city_name, v_city_name, zip, prim_range, prim_name, sec_range)), st, p_city_name, v_city_name, zip, prim_range, prim_name, sec_range, -date_submitted,-date_created, local), record, local)(override_flag <> 3),
												indextype = 'statement_id' => dedup(sort(distribute(ds(statement_id <> 0),hash(statement_id)), statement_id,-date_submitted,-date_created,local), record, local)(override_flag <> 3)
												
										);
			end;
			
		end;
		
		export nonfcra := module
			phonesorted := getIndexdataset.nonfcra('phone');
			export phone := index (phonesorted, {phone}, {phonesorted}, filenames('nonfcra').readkeys.keyname('phone'), OPT);
	
			addresssorted := getIndexdataset.nonfcra('address');
			export address := index (addresssorted, {st, p_city_name, v_city_name, zip, prim_range, prim_name, sec_range}, {addresssorted}, filenames('nonfcra').readkeys.keyname('address'), OPT);
			
			sidsorted := getIndexdataset.nonfcra('statement_id');
			export statement_id := index (sidsorted, {statement_id}, {sidsorted}, filenames('nonfcra').readkeys.keyname('statement_id'), OPT);

		end;
		
		export fcra := module
			lexidsorted := getIndexdataset.fcra('lexid');
			export lexid := index (lexidsorted, {lexid}, {lexidsorted}, filenames('fcra').readkeys.keyname('lexid'), OPT);
	
			ssnsorted := getIndexdataset.fcra('ssn');
			export ssn := index (ssnsorted, {ssn}, {ssnsorted}, filenames('fcra').readkeys.keyname('ssn'), OPT);

		end;

end;