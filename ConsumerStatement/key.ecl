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
				deduped := dedup(consumerstatement.ReadData.nonfcra,record,all);
				return	map(
												indextype = 'phone' => sort(deduped(phone <> ''), phone),
												indextype = 'address' => sort(deduped(st <> ''), st, p_city_name, v_city_name, zip, prim_range, prim_name, sec_range),
												indextype = 'statement_id' => sort(deduped(statement_id <> 0), statement_id)
												
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