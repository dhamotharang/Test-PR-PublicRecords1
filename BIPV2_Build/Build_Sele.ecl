IMPORT BIPV2, BIPV2_Files;

l_base			:= BIPV2.CommonBase.Layout;
in_default	:= PROJECT(BIPV2_Files.files_empid.DS_BASE, l_base);
out_default	:= BIPV2_Files.files_sele.FILE_BUILDING + '::' + BIPV2.KeySuffix;

EXPORT Build_Sele(DATASET(l_base) input=in_default, STRING outfile=out_default) := MODULE
	
	// Output Files (logical)
	EXPORT f_out := outfile;
	
	
	// Descendant Counts
	SHARED cnt_X_per_Y(ds,X,Y,fld) := FUNCTIONMACRO
		LOCAL ds_dist	:= DISTRIBUTE(ds,HASH32(Y));
		LOCAL tab_cnt	:= TABLE(TABLE(ds_dist, {Y, X}, Y, X, LOCAL), {Y, UNSIGNED fld:=count(GROUP)}, Y, LOCAL);
		LOCAL ds_cnt	:= JOIN(ds_dist, tab_cnt, LEFT.Y=RIGHT.Y, TRANSFORM(l_base, SELF:=RIGHT, SELF:=LEFT), KEEP(1), LOCAL);
		RETURN ds_cnt;
	ENDMACRO;
	SHARED lgid3_counts(DATASET(l_base) ds_in)	:= cnt_X_per_Y(ds_in,proxid,lgid3,cnt_prox_per_lgid3);
	SHARED powid_counts(DATASET(l_base) ds_in)	:= cnt_X_per_Y(ds_in,proxid,powid,cnt_prox_per_powid);
	SHARED empid_counts(DATASET(l_base) ds_in)	:= cnt_X_per_Y(ds_in,dotid,empid,cnt_dot_per_empid);
	SHARED proxid_counts(DATASET(l_base) ds_in)	:= cnt_X_per_Y(ds_in,dotid,proxid,cnt_dot_per_proxid);
	SHARED dotid_counts(DATASET(l_base) ds_in)	:= cnt_X_per_Y(ds_in,rcid,dotid,cnt_rcid_per_dotid);
	EXPORT descendant_counts(DATASET(l_base) ds_in) := dotid_counts(proxid_counts(empid_counts(powid_counts(lgid3_counts(ds_in)))));
	
	
	// Take action
	ds := descendant_counts(input);
	out := OUTPUT(ds,,f_out,OVERWRITE,COMPRESSED);
	supr := SEQUENTIAL(BIPV2_Files.files_sele.updateBuilding(f_out), BIPV2.CommonBase.updateSuperfiles(f_out));
	dbg1 := OUTPUT(COUNT(TABLE(input,{seleid},seleid,MERGE)), NAMED('cnt_sele_in'));
	dbg2 := OUTPUT(COUNT(TABLE(ds,{seleid},seleid,MERGE)), NAMED('cnt_sele_out'));
	EXPORT run := PARALLEL(SEQUENTIAL(out, supr), dbg1, dbg2);
	
END;