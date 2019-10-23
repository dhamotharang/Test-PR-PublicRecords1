EXPORT FixFirstSeen(Dataset(Cortera.Layout_Header_Out) hdr1) := FUNCTION

	root := Cortera.Constants.sfHeaderIn;
					//'~thor::cortera::hdr_in';


		layout := RECORD
			cortera.Layout_Header;
			unsigned4 first_seen;
		END;
	
	// we don't change the input layout in order to avoid a key layout change
		h := DISTRIBUTE(dataset(root, layout
																		, CSV(
																								SEPARATOR('|')
																							, TERMINATOR(['\n', '\r\n'])
																							, QUOTE('')
																							, HEADING(1)
																							, MAXLENGTH(1024)
																							)
																				), link_id);

		hdr := DISTRIBUTE(hdr1, link_id);


		t := DISTRIBUTE(table(hdr, {hdr.link_id, earlier := MIN(GROUP,hdr.dt_first_seen), n := COUNT(GROUP)}, link_id, local), link_id);

		layout2 := RECORD
		 cortera.Layout_Header_Out;
		 unsigned4 earliest_seen;
		END;

		j1 := JOIN(hdr, t, left.link_id=right.link_id,
							TRANSFORM(layout2, self.earliest_seen := right.earlier; self := left;), LEFT OUTER, LOCAL);

		Earlier(unsigned4 date1, unsigned4 date2) := 
					MAP(
						date1=0 => date2,
						date2=0 => date1,
						min(date1, date2)
					);

		j := JOIN(j1, h, left.link_id=right.link_id, TRANSFORM(cortera.Layout_Header_Out,
								self.dt_first_seen := IF(left.dt_first_seen=left.earliest_seen, Earlier(left.dt_first_seen, right.first_seen), left.dt_first_seen);
								self := left), LEFT OUTER, LOCAL);

		return j;
		
END;