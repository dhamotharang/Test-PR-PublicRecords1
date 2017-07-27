import text_test,text;

newf := DATASET('~thor_data400::maltemp::base::patriot_'+version_file, {Patriot.Layout_Patriot, 
											UNSIGNED INTEGER8 __filepos {virtual(fileposition)}}, flat);

layout :=
RECORD
	STRING75 line;
	UNSIGNED fieldPos := 0;
	UNSIGNED INTEGER8 __filepos;
END;

layout makeNormal(newf L, INTEGER C) :=
TRANSFORM
	SELF.line := CHOOSE(C,  L.pty_key,
							L.source,
							L.orig_pty_name,
							L.orig_vessel_name,
							L.addr_1,
							L.addr_2,
							L.addr_3,
							L.addr_4,
							L.addr_5,
							L.addr_6,
							L.addr_7,
							L.addr_8,
							L.addr_9,
							L.addr_10,
							L.remarks_1,
							L.remarks_2,
							L.remarks_3,
							L.remarks_4,
							L.remarks_5,
							L.remarks_6,
							L.remarks_7,
							L.remarks_8,
							L.remarks_9,
							L.remarks_10,
							L.remarks_11,
							L.remarks_12,
							L.remarks_13,
							L.remarks_14,
							L.remarks_15,
							L.remarks_16,
							L.remarks_17,
							L.remarks_18,
							L.remarks_19,
							L.remarks_20,
							L.remarks_21,
							L.remarks_22,
							L.remarks_23,
							L.remarks_24,
							L.remarks_25,
							L.remarks_26,
							L.remarks_27,
							L.remarks_28,
							L.remarks_29,
							L.remarks_30,
							L.cname,
							L.fname,
							L.mname,
							L.lname,
							L.suffix,
							L.prim_range, 
							L.predir, 
							L.prim_name, 
							L.addr_suffix, 
							L.postdir, 
							L.unit_desig, 
							L.sec_range, 
							L.p_city_name, 
							L.v_city_name, 
							L.st, 
							L.zip, 
							L.zip4);
	SELF := L;
END;


n := NORMALIZE(newf, 61, makeNormal(LEFT, COUNTER));

Text_Test.MAC_MakeWordIndex(n, layout, line, __filepos, fieldPos, true, i)

export key_prep_wordkey := INDEX(i, {i, INTEGER domain := 0}, '~thor_data400::maltemp::key::patriot_'+thorlib.wuid());