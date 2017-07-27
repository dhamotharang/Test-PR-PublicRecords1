export MAC_Updt_AddrDtFirstSeen(infile,id_field,outfile,data_restriction_mask='') := MACRO

	import doxie,ut,Header,mdr;
	
	#UNIQUENAME(k)
	%k% := doxie.Key_Header;

	#UNIQUENAME(updtFlag)
	infile %updtFlag%(infile le,%k% ri) := TRANSFORM
		SELF.dt_first_seen := ri.dt_first_seen;
		SELF := le;
	END;
	
	#UNIQUENAME(updt)
	%updt% := JOIN(infile,%k%,
								 KEYED(LEFT.did = RIGHT.s_did) AND
								 LEFT.prim_range = RIGHT.prim_range AND
								 LEFT.prim_name = RIGHT.prim_name AND
								 LEFT.zip = RIGHT.zip AND
								 RIGHT.dt_first_seen <> 0 AND
								 ~Doxie.DataRestriction.isHeaderSourceRestricted(right.src, data_restriction_mask),
								 %updtFlag%(LEFT,RIGHT),LEFT OUTER,ATMOST(KEYED(LEFT.did = RIGHT.s_did),7500),KEEP(1)
								); 
	
	#UNIQUENAME(srtUpdt)
	%srtUpdt% := SORT(%updt%,id_field,did,dt_first_seen);
	
	
	outfile := DEDUP(%srtUpdt%,id_field,did);
	
ENDMACRO;