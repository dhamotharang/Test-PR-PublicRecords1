export gong_append_utils := MODULE
	
	export MAC_lookupAptCount(infile, outfile, lookupApt = true) := MACRO
    import dx_header;

		#uniquename(key_apt_buildings)
    %key_apt_buildings% := dx_header.Key_AptBuildings();

		#uniquename(outLayout)
		%outLayout% := RECORD(infile),
			INTEGER apt_cnt := 0;
		END;
	
		// Join to header.Key_AptBuildings to pick up apt_count.
		#uniquename(xfm_join_apt_counts)
		%outLayout% %xfm_join_apt_counts%(infile l, %key_apt_buildings% r) := TRANSFORM
			SELF.apt_cnt := r.apt_cnt;
			SELF         := l;
		END;
	
		#uniquename(withApt)
		%withApt% := JOIN(infile, %key_apt_buildings%,
										KEYED(RIGHT.prim_range = LEFT.prim_range AND
													RIGHT.prim_name  = LEFT.prim_name  AND
													RIGHT.zip        = LEFT.zip        AND
													RIGHT.suffix     = LEFT.suffix     AND
													RIGHT.predir     = LEFT.predir),
										%xfm_join_apt_counts%(LEFT,RIGHT), LEFT OUTER, KEEP(1));
		
		#uniquename(noApt)
		%noApt% := PROJECT(infile, %outLayout%);
		
		outfile := IF(lookupApt, %withApt%, %noApt%);
		
	ENDMACRO;
	
  // NOTE: this MACRO is called as a join condition; the caller must provide necessary imports
	export MAC_sec_range(strict) := MACRO

	#IF(strict)
		((LEFT.apt_cnt <= 5) OR								
     (LEFT.sec_range != '' AND RIGHT.sec_range != '' AND 
		  address.sec_range_eq(LEFT.sec_range, RIGHT.sec_range) <= 4) OR
     ((LEFT.sec_range = '' OR RIGHT.sec_range = '') AND 
       lib_datalib.DataLib.NameMatchNew(NID.PreferredFirstNew(LEFT.fname, true),'',LEFT.lname,
			                                  NID.PreferredFirstNew(RIGHT.fname, true),'',RIGHT.lname,
																				true,false) <= 3)
		)
	#ELSE
		ut.NNEQ(left.sec_range,right.sec_range)
	#END
	ENDMACRO;
END;
