import prte_csv, gong;
export Get_Gong_Base := MODULE

address := DISTRIBUTE(
	PROJECT(PRTE_CSV.Gong.dthor_data400__key__gong_history__address,
				TRANSFORM(gong.Layout_history,
					SELF := LEFT;
					SELF.bell_id := 'LSS';
					SELF.filedate := '20120224_01';
					SELF := [];)),
				SKEW(0.1));

names := DISTRIBUTE(
	PROJECT(PRTE_CSV.Gong.dthor_data400__key__gong_history__name,
				TRANSFORM(gong.Layout_history,
					SELF := LEFT;
					SELF.bell_id := 'LSS';
					SELF.filedate := '20120224_01';
					SELF := [];)),
				SKEW(0.1));
				
phones := DISTRIBUTE(
	PROJECT(PRTE_CSV.Gong.dthor_data400__key__gong_history__phone,
				TRANSFORM(gong.Layout_history,
					SELF := LEFT;
					SELF.bell_id := 'LSS';
					SELF.filedate := '20120224_01';
					SELF := [];)),
				SKEW(0.1));
	
bus := DISTRIBUTE(
	PROJECT(PRTE_CSV.Gong.dthor_data400__key__gong_history__bdid,
				TRANSFORM(gong.Layout_history,
					SELF := LEFT;
					SELF.bell_id := 'LSS';
					SELF.filedate := '20120224_01';
					SELF := [];)),
				SKEW(0.1));

	
// reconstruct raw gong data from original PRTE CSV keys	
export rawdata := DEDUP(address+names+phones+bus,
	phone10, predir, prim_range, prim_name, suffix, sec_range, 
	v_city_name, st, z5, 
	name_first, name_middle, name_last, name_suffix,
	listed_name, caption_text, dt_first_seen, dt_last_seen,
			ALL) : PERSIST('~prte::gong::reconstruct');

gong.Layout_history xweekly(gong.Layout_history le, 
														gong.Layout_history rt) := TRANSFORM
		SELF.did := IF(le.did=0,rt.did,le.did);
		SELF.hhid := IF(le.hhid=0,rt.hhid,le.hhid);
		SELF := le;
END;

export weeklydata := ROLLUP(
	SORT(DISTRIBUTE(
		PROJECT(PRTE_CSV.Gong.dthor_data400__key__gong_weekly__did,
				TRANSFORM(gong.Layout_history,
					SELF := LEFT;
					SELF := [];))
		+
		PROJECT(PRTE_CSV.Gong.dthor_data400__key__gong_weekly__hhid,
				TRANSFORM(gong.Layout_history,
					SELF := LEFT;
					SELF := [];)),			
				HASH(sequence_number,listed_name)),
				sequence_number, listed_name, did, hhid),
			LEFT.sequence_number=RIGHT.sequence_number AND LEFT.listed_name=RIGHT.listed_name,
					xweekly(LEFT, RIGHT), LOCAL)
			: PERSIST('~prte::gong::weekly');

export Santander := Project(PRTE.Get_Header_Base.Santander(phone<>'',phone<>'NOCELLPH',~cellphone),
		TRANSFORM(gong.Layout_history,
			SELF.phone10 := LEFT.phone;
			SELF.name_first := LEFT.fname;
			SELF.name_middle := LEFT.mname;
			SELF.name_last := LEFT.lname;
			SELF.name_suffix := LEFT.name_suffix;
			SELF.z5 := LEFT.zip;
			SELF.z4 := LEFT.zip4;
			SELF.listed_name := TRIM(LEFT.lname) + ' ' + TRIM(LEFT.fname);
			SELF.listing_type_res := 'R';
			SELF.current_record_flag := 'Y';
			SELF.publish_code := 'P';
			
			SELF.v_predir := LEFT.predir;
			SELF.v_prim_name := LEFT.prim_name;
			SELF.v_suffix := LEFT.suffix;
			SELF.v_postdir := LEFT.postdir;
			SELF.county_code := LEFT.county;
			
			SELF.bdid := 0;		// no need to convert since blank in Santander
			SELF.dt_first_seen := '';
			SELF.dt_last_seen := '';
			
			SELF.bell_id := 'LSS';
			SELF.filedate := '20120224_01';
			
			SELF := LEFT;
			SELF := [];
		));


END;