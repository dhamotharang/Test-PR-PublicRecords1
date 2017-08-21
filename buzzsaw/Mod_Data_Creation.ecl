export Mod_Data_Creation := MODULE
	import dolecki;
	import buzzsaw_util;
	
	SHARED GREATEST(R, A, B) := MACRO
		R := IF( A > B, A, B)
	ENDMACRO;
	
	SHARED LEAST(R, A, B) := MACRO
		R := IF( A < B, A, B)
	ENDMACRO;

	SHARED TMAX(field, L, R) := MACRO
		SELF.field := IF( L.field > R.field, L.field, R.field)
	ENDMACRO;
	
	SHARED TMIN(field, L, R) := MACRO
		SELF.field := IF( L.field < R.field, L.field, R.field)
	ENDMACRO;
	
	
	
	EXPORT C_StartForSuperFile(STRING rawFilename, STRING  SomeId ) := FUNCTION
		
		STRING cookedFilename := Mod_data.FN_DAILY_STEM + '::' + SomeId + '_trans';
		
		//                            12345678901234567890
		// The data loks like this..."MAY  1 00:00:02.695 " or
		// "APR 30 23:59:57.045 " ...no big need here for regEx
		//
/*		buzzsaw.Mod_Data.L_Firewall_Packed */
			Mod_Data.L_Firewall_Std pt_boat(
																				Mod_Data.L_Firewall_RawMeatWithYearEtc l, UNSIGNED4 SrcId) := TRANSFORM, SKIP(
					(NOT REGEXFIND(Mod_Octets.validPattern, l.srcip)) OR
					(NOT REGEXFIND(Mod_Octets.validPattern, l.destip))
				)
																			
			SELF.ms_start := buzzsaw.Mod_Y2K.ms_since_y2k(
				l.year, 
				buzzsaw.Mod_Y2k.num_month(l.date[1..3]), 
				(UNSIGNED1)TRIM(l.date[5..6], LEFT), 
				(UNSIGNED1)l.date[8..9], 
				(UNSIGNED1)l.date[11..12], 
				(UNSIGNED1)l.date[14..15], 
				(UNSIGNED2)TRIM(l.date[17..])
			);
			SELF.ms_stop := SELF.ms_start;
			SELF.records := 1;
			transport := REGEXFIND('^[0-9]{1,5}/([A-Z]{2,3})', l.protocol, 1);
			SELF.protocol := IF(transport = '', l.protocol, transport);
			SELF.firewall := l.firewall;
			SELF.srcip_u4 := Mod_Octets.F_ConvertForCleanData(l.srcip);
			SELF.destip_u4 := Mod_Octets.F_ConvertForCleanData(l.destip);
			SELF.Doc := HASH64(SELF.srcip_u4, l.srcport, SELF.destip_u4, l.destport, SELF.protocol, SELF.ms_start, SELF.ms_stop);
			SELF.Src := SrcId;
			SELF := l;
		END;

		UNSIGNED SourceId := (UNSIGNED4) WORKUNIT[2..9];
		ds_Parsed := PROJECT(
			DATASET(rawFilename,Mod_Data.L_Firewall_RawMeatWithYearEtc,THOR), 
			pt_boat(LEFT, SourceId));
			
		return SEQUENTIAL(
		
							FileServices.StartSuperFileTransaction(),
							IF(NOT FileServices.SuperFileExists(Mod_Data.FN_msFirewall), 
								FileServices.CreateSuperFile(Mod_Data.FN_msFirewall)),
							FileServices.RemoveSuperFile(Mod_Data.FN_msFirewall, cookedFilename),
							FileServices.FinishSuperFileTransaction(), 
							
							FileServices.StartSuperFileTransaction(),
							output(ds_Parsed, , cookedFilename, OVERWRITE);
							FileServices.AddSuperFile(Mod_Data.FN_msFirewall, cookedFilename),
							FileServices.FinishSuperFileTransaction()
							
						);
	END;
	
	
	
	/*
	*
	* C_StartEx added to make the C_Start process more generic.
	*
	*/
	EXPORT C_StartEx(STRING rawFilename, 
									STRING1 wallId,
									INTEGER2 year = 2006) := FUNCTION
		
		STRING cookedFilename := Mod_data.FN_DAILY_STEM + '::' + (STRING)year + '_' + wallid + '_trans';
		
		//                            12345678901234567890
		// The data loks like this..."MAY  1 00:00:02.695 " or
		// "APR 30 23:59:57.045 " ...no big need here for regEx
		//
/*		buzzsaw.Mod_Data.L_Firewall_Packed */
			Mod_Data.L_Firewall_Std pt_boat(
																			Mod_Data.L_Firewall_RawMeat l, STRING1 abbr, UNSIGNED4 SrcId) := TRANSFORM, SKIP(
					(NOT REGEXFIND(Mod_Octets.validPattern, l.srcip)) OR
					(NOT REGEXFIND(Mod_Octets.validPattern, l.destip))
				)
																			
			SELF.ms_start := buzzsaw.Mod_Y2K.ms_since_y2k(
				year, 
				buzzsaw.Mod_Y2k.num_month(l.date[1..3]), 
				(UNSIGNED1)TRIM(l.date[5..6], LEFT), 
				(UNSIGNED1)l.date[8..9], 
				(UNSIGNED1)l.date[11..12], 
				(UNSIGNED1)l.date[14..15], 
				(UNSIGNED2)TRIM(l.date[17..])
			);
			SELF.ms_stop := SELF.ms_start;
			SELF.records := 1;
			transport := REGEXFIND('^[0-9]{1,5}/([A-Z]{2,3})', l.protocol, 1);
			SELF.protocol := IF(transport = '', l.protocol, transport);
			SELF.firewall := abbr;
			SELF.srcip_u4 := Mod_Octets.F_ConvertForCleanData(l.srcip);
			SELF.destip_u4 := Mod_Octets.F_ConvertForCleanData(l.destip);
			SELF.Doc := HASH64(SELF.srcip_u4, l.srcport, SELF.destip_u4, l.destport, SELF.protocol, SELF.ms_start, SELF.ms_stop);
			SELF.Src := SrcId;
			SELF := l;
		END;

		UNSIGNED SourceId := (UNSIGNED4) WORKUNIT[2..9];
		ds_Parsed := PROJECT(
			DATASET(rawFilename,buzzsaw.Mod_Data.L_Firewall_RawMeat,CSV), 
			pt_boat(LEFT, wallId, SourceId));
			
		return SEQUENTIAL(
		
							FileServices.StartSuperFileTransaction(),
							IF(NOT FileServices.SuperFileExists(Mod_Data.FN_msFirewall), 
								FileServices.CreateSuperFile(Mod_Data.FN_msFirewall)),
							FileServices.RemoveSuperFile(Mod_Data.FN_msFirewall, cookedFilename),
							FileServices.FinishSuperFileTransaction(), 
							
							FileServices.StartSuperFileTransaction(),
							output(ds_Parsed, , cookedFilename, OVERWRITE);
							FileServices.AddSuperFile(Mod_Data.FN_msFirewall, cookedFilename),
							FileServices.FinishSuperFileTransaction()
							
						);
	END;
/*
	EXPORT C_Start := FUNCTION
		PATTERN mon := REPEAT(PATTERN('[A-Z]'), 3);
		PATTERN dd := PATTERN('[ 1-3]?[0-9]');
		PATTERN hh24 := PATTERN('[0-2][0-9]');
		PATTERN mm := PATTERN('[0-5][0-9]');
		PATTERN ss := PATTERN('[0-5][0-9]');
		PATTERN sep := PATTERN('[. ]');
		PATTERN ms := REPEAT(PATTERN('[[:alnum:]]'), 3);
		RULE firewall_date := mon ' ' dd ' ' hh24 ':' mm ':' ss sep ms;
	
		buzzsaw.Mod_Data.L_Firewall_Packed pt_boat(
				buzzsaw.Mod_Data.L_Firewall_RawMeat X, STRING1 abbr) := TRANSFORM
			SELF.ms_start := buzzsaw.Mod_Y2K.ms_since_y2k(
				2006, 
				buzzsaw.Mod_Y2k.num_month(MATCHTEXT(mon)), 
				(UNSIGNED1)MATCHTEXT(dd), 
				(UNSIGNED1)MATCHTEXT(hh24), 
				(UNSIGNED1)MATCHTEXT(mm), 
				(UNSIGNED1)MATCHTEXT(ss), 
				(UNSIGNED2)MATCHTEXT(ms)
			);
			SELF.ms_stop := SELF.ms_start;
			SELF.records := 1;
			transport := REGEXFIND('^[0-9]{1,5}/([A-Z]{2,3})', X.protocol, 1);
			SELF.protocol := IF(transport = '', X.protocol, transport);
			SELF.firewall := abbr;
			SELF := X;
		END;

		ds_3 := PARSE(
			DATASET(buzzsaw.Mod_Data.FN_F_wall3,buzzsaw.Mod_Data.L_Firewall_RawMeat,CSV), 
			trim(date),
			firewall_date,
			pt_boat(LEFT, '3'),
			WHOLE, FIRST, NOSCAN, CASE
		);

		ds_sand := PARSE(
			DATASET(buzzsaw.Mod_Data.FN_F_wallsand,buzzsaw.Mod_Data.L_Firewall_RawMeat,CSV),
			trim(date),
			firewall_date,
			pt_boat(LEFT, 's'),
			WHOLE, FIRST, NOSCAN, CASE
		);
		ds_tiger := PARSE(
			DATASET(buzzsaw.Mod_Data.FN_F_walltiger,buzzsaw.Mod_Data.L_Firewall_RawMeat,CSV),
			trim(date),
			firewall_date,
			pt_boat(LEFT, 't'),
			WHOLE, FIRST, NOSCAN, CASE	
		);
		ds_whale := PARSE(
			DATASET(buzzsaw.Mod_Data.FN_F_wallwhale,buzzsaw.Mod_Data.L_Firewall_RawMeat,CSV),
			trim(date),
			firewall_date,
			pt_boat(LEFT, 'w'), WHOLE,
			FIRST, NOSCAN, CASE
		);

		RETURN
		//dsn := CHOOSEN(ds_t, 72);
//		SEQUENTIAL(
			PARALLEL(
				output(ds_3, , buzzsaw.Mod_Data.FN_FT_wall3, OVERWRITE)
				,
				output(ds_sand, , buzzsaw.Mod_Data.FN_FT_wallsand, OVERWRITE)
				,
				output(ds_tiger, , buzzsaw.Mod_Data.FN_FT_walltiger, OVERWRITE)
				,
				output(ds_whale, , buzzsaw.Mod_Data.FN_FT_wallwhale, OVERWRITE)
//			),
			
//			FileServices.CreateSuperFile(Mod_Data.FN_msFilewall),
//			StartSuperFileTransaction(),
//			ClearSuperFile(),
//			AddSuperFile(),
//			FinishSuperFileTransaction()
		);
		
		
	END;
	*/

	/* transform that dedupes records that are close enough in time (usually 2 secs) */
	// SHARED Mod_Data.L_Firewall_Packed X_Dup(
	SHARED Mod_Data.L_Firewall_Std X_Dup(
			Mod_Data.L_Firewall_Std l, 
			Mod_Data.L_Firewall_Std r) := TRANSFORM
		self.ms_start := l.ms_start;
		self.ms_stop := r.ms_start;
		self.records := l.records + r.records;	//number of records this new record subsumes
		self.srcip := l.srcip;
		self.srcport := l.srcport; 
		self.destip := l.destip; 
		self.destport := l.destport;
		self.protocol := l.protocol; 
		self.sent_packets := if(r.sent_packets>l.sent_packets,r.sent_packets,l.sent_packets);	//most
		self.rcv_packets := if(r.rcv_packets > l.rcv_packets, r.rcv_packets, l.rcv_packets);	//most
		self.duration := if(r.duration>l.duration,r.duration,l.duration);	//longest
		self.firewall := l.firewall;
		SELF.doc := l.doc;
		SELF.src := l.src;
		SELF.srcip_u4 := l.srcip_u4;
		SELF.destip_u4 := l.destip_u4;
		// SELF.fpos := l.fpos;
	END;
	/*
	*
	* Perform the JOIN to get the CC  information so you can avoid writing the data to disk twice.
	*
	*
	*/
export C_DD := FUNCTION

		Working_Records := Mod_Data.DS_All;

		//distribute accross the nodes
		Distributed_Firewall := DISTRIBUTE(Working_Records, HASH32(srcip_u4, srcport, destip_u4, destport, protocol));
		// Distributed_Firewall := DISTRIBUTE(Working_Records, doc);

		//sort records on each node independently
		Sorted_Temp := SORT(Distributed_Firewall, srcip_u4, srcport, destip_u4, destport, protocol, ms_start, LOCAL);

		//group into common sets (requires sorted input)
		Grouped_Firewall := GROUP(Sorted_Temp, srcip_u4, srcport, destip_u4, destport, protocol, LOCAL);

		//create chains that have no more than 2sec links
		Dedup_Firewall := ROLLUP(Grouped_Firewall, right.ms_start-left.ms_stop<=2000, X_Dup(left, right));

		//RETURN output(Dedup_Firewall,, Mod_Data.FN_DD, OVERWRITE); // changed due to collapsing C_DDC.
		RETURN output(Dedup_Firewall,, Mod_Data.FN_DDC, OVERWRITE);
		
	END;
//
	/*
	*
	* Re-write this one.
	*/
	/*
	export C_U4 := FUNCTION
		ds := Mod_Data.DS_DDC;
		loc := Mod_Data.DS_Unique_Ips_Location;

		{Mod_Data.L_Firewall_U4, QSTRING destip} convert_src(RECORDOF(ds) P, RECORDOF(loc) L) := TRANSFORM

			SELF.srcip_u4 := Mod_Octets.F_Convert(TRIM(P.srcip));
			SELF.destip_u4 := Mod_Octets.F_Convert(TRIM(P.destip));
			SELF.src_cc := L.country_code;
			SELF.dest_cc := '';
			SELF := P;
		END;
		
		loc_s := SORT(loc, ip);
		
		j := JOIN(ds, loc_s, LEFT.srcip=RIGHT.ip, 
				convert_src(LEFT, RIGHT), UNORDERED, NOSORT(RIGHT), SKEW(0.35));

		Mod_Data.L_Firewall_U4 convert_dest(RECORDOF(j) U, RECORDOF(loc) L) := TRANSFORM
			SELF.dest_cc := L.country_code;
			SELF := U;
		END;
		
		u4_ds := JOIN(j, loc_s, LEFT.destip=RIGHT.ip, 
				convert_dest(LEFT, RIGHT), UNORDERED, NOSORT(RIGHT), SKEW(0.35));
		
		RETURN output(u4_ds, , Mod_Data.FN_U4, OVERWRITE);
	END;
	/*
	*
	* Replaces C_U4.
	*
	*
	*/
	export C_U4_Ex := FUNCTION
	
		ds := Mod_Data.DS_DDC;
		loc := TABLE(Mod_Data.DS_Unique_Ips_Location,{IP_U4, COuntry_code});
				
		Mod_Data.L_Firewall_U4 convert_src(ds P,loc L) := TRANSFORM

			SELF.src_cc := L.country_code;
			SELF.dest_cc := '';
			SELF := P;
		END;
		
		
		j := JOIN( ds, loc, 
							LEFT.srcip_u4=RIGHT.ip_u4, convert_src(LEFT,RIGHT),LEFT OUTER,LOOKUP);
													
		Mod_Data.L_Firewall_U4 convert_dest(j P,loc L) := TRANSFORM
			SELF.dest_cc := l.country_code;
			SELF := p;
		END;
		
		u4_ds := JOIN(J, loc, 
							LEFT.destip_u4=RIGHT.ip_u4, convert_dest(LEFT,RIGHT),LEFT OUTER,LOOKUP);
		
		// Note, this new files replaces Mod_Data.DS_DDC from here on out.
		SubFileName := Mod_Data.FN_DAILY_STEM + '_u4';
		//RETURN output(u4_ds, , Mod_Data.FN_U4, OVERWRITE);
		
		return SEQUENTIAL(
		
							FileServices.StartSuperFileTransaction(),
							IF(NOT FileServices.SuperFileExists(Mod_Data.FN_U4), 
								FileServices.CreateSuperFile(Mod_Data.FN_U4)),
							FileServices.RemoveSuperFile(Mod_Data.FN_U4, SubFileName),
							FileServices.FinishSuperFileTransaction(), 
							
							FileServices.StartSuperFileTransaction(),
							output(u4_ds, , SubFileName, OVERWRITE);
							FileServices.AddSuperFile(Mod_Data.FN_U4, SubFileName),
							FileServices.FinishSuperFileTransaction()
							
						);
		
	END;
	/*
	*
	* I think this is retired since it writes to the same file
	*
	*/
	/*
	export C_StdDev := FUNCTION
	
		dcdataset :=  Mod_Data.DS_u4;
			
		L_Start_Stats := Mod_Data.L_Firewall_Stats;

		L_Start_Stats start_stats(Mod_Data.L_Firewall_U4 X) := TRANSFORM
			SELF := X;
			SELF.min_date := X.ms_start;
			SELF.max_date := X.ms_start;
			SELF.min_destport := X.destport;
			SELF.max_destport := X.destport;
			SELF.min_out_packets := X.sent_packets;
			SELF.max_out_packets := X.sent_packets;
			SELF.min_in_packets := X.rcv_packets;
			SELF.max_in_packets := X.rcv_packets;
			SELF := [];
		END;

		started_ds := PROJECT(dcdataset, start_stats(LEFT));

		distributed_ds := DISTRIBUTE(started_ds, HASH32(srcip_u4, destip_u4));

		sorted_ds := SORT(distributed_ds, srcip_u4, destip_u4, min_date, LOCAL);

		x_ds := ROLLUP(sorted_ds, TRANSFORM(L_Start_Stats,
				SELF.periods := LEFT.periods+1;
				delta_time := RIGHT.min_date-LEFT.max_date;
				delta_mean := delta_time - LEFT.mean;
				SELF.mean := LEFT.mean + delta_mean / SELF.periods;
				SELF.stdev := LEFT.stdev + delta_mean * (delta_time-SELF.mean);
				min_date := LEFT.min_date;
				max_date := RIGHT.max_date;
				TMIN(min_destport, LEFT, RIGHT);
				TMAX(max_destport, LEFT, RIGHT);
				TMIN(min_out_packets, LEFT, RIGHT);
				TMAX(max_out_packets, LEFT, RIGHT);
				TMIN(min_in_packets, LEFT, RIGHT);
				TMAX(max_in_packets, LEFT, RIGHT);
				SELF := RIGHT
			), srcip_u4, destip_u4, LOCAL);

		//output(x_ds);

		Mod_Data.L_Firewall_Stats finalize(L_Start_Stats X) := TRANSFORM
				, SKIP(X.periods < 2)
			SELF.mean := X.mean;
			SELF.log_mean := log(SELF.mean);
			SELF.stdev := sqrt(X.stdev / (X.periods-1));
			SELF.log_stdev := log(SELF.stdev);
			SELF := X;
		END;

		p_ds := PROJECT(x_ds, finalize(LEFT));

		RETURN output(p_ds,, Mod_Data.FN_StDev, OVERWRITE);
	END;
*/
	/*
	*
	* This is the one I was directed to use.
	*/
	export C_StdDev_IPIPDP := FUNCTION
		dcdataset :=  Mod_Data.DS_u4;
		L_Start_Stats := Mod_Data.L_Firewall_Stats;

		L_Start_Stats start_stats(Mod_Data.L_Firewall_U4 X) := TRANSFORM
			SELF := X;
			SELF.min_date := X.ms_start;
			SELF.max_date := X.ms_start;
			SELF.min_destport := X.destport;
			SELF.max_destport := X.destport;
			SELF.min_out_packets := X.sent_packets;
			SELF.max_out_packets := X.sent_packets;
			SELF.min_in_packets := X.rcv_packets;
			SELF.max_in_packets := X.rcv_packets;
			SELF := [];
		END;

		started_ds := PROJECT(dcdataset, start_stats(LEFT));
		
		//rollup locally to avoid skew...
		x_ds_1 := ROLLUP(started_ds, TRANSFORM(L_Start_Stats,
				SELF.periods := LEFT.periods+1;
				delta_time := RIGHT.min_date-LEFT.max_date;
				delta_mean := delta_time - LEFT.mean;
				SELF.mean := LEFT.mean + delta_mean / SELF.periods;
				SELF.stdev := LEFT.stdev + delta_mean * (delta_time-SELF.mean);
				min_date := LEFT.min_date;
				max_date := RIGHT.max_date;
				TMIN(min_destport, LEFT, RIGHT);
				TMAX(max_destport, LEFT, RIGHT);
				TMIN(min_out_packets, LEFT, RIGHT);
				TMAX(max_out_packets, LEFT, RIGHT);
				TMIN(min_in_packets, LEFT, RIGHT);
				TMAX(max_in_packets, LEFT, RIGHT);
				SELF := RIGHT
			), srcip_u4, destip_u4, min_destport, LOCAL);


		distributed_ds := DISTRIBUTE(x_ds_1, HASH32(srcip_u4, destip_u4, min_destport));

		sorted_ds := SORT(distributed_ds, srcip_u4, destip_u4, min_destport, min_date, LOCAL);

		x_ds := ROLLUP(sorted_ds, TRANSFORM(L_Start_Stats,
				SELF.periods := LEFT.periods+1;
				delta_time := RIGHT.min_date-LEFT.max_date;
				delta_mean := delta_time - LEFT.mean;
				SELF.mean := LEFT.mean + delta_mean / SELF.periods;
				SELF.stdev := LEFT.stdev + delta_mean * (delta_time-SELF.mean);
				min_date := LEFT.min_date;
				max_date := RIGHT.max_date;
				TMIN(min_destport, LEFT, RIGHT);
				TMAX(max_destport, LEFT, RIGHT);
				TMIN(min_out_packets, LEFT, RIGHT);
				TMAX(max_out_packets, LEFT, RIGHT);
				TMIN(min_in_packets, LEFT, RIGHT);
				TMAX(max_in_packets, LEFT, RIGHT);
				SELF := RIGHT
			), srcip_u4, destip_u4, min_destport, LOCAL);

		//output(x_ds);

		Mod_Data.L_Firewall_Stats finalize(L_Start_Stats X) := TRANSFORM
				, SKIP(X.periods < 2)
			SELF.mean := X.mean;
			SELF.log_mean := log(SELF.mean);
			SELF.stdev := sqrt(X.stdev / (X.periods-1));
			SELF.log_stdev := log(SELF.stdev);
			SELF := X;
		END;

		p_ds := PROJECT(x_ds, finalize(LEFT));

		RETURN output(p_ds,, Mod_Data.FN_StDev, OVERWRITE);
	END;
	
	/*
	*
	* This will replace the two separate since there was no deduping done on both merged together.
	*
	*
	*/
	export C_All_Unique_Ips := FUNCTION
		t1 := TABLE(buzzsaw.Mod_Data.DS_DDC,{UNSIGNED4 ip_u4 := srcip_u4, QSTRING15 ip := srcip});
		t2 := TABLE(buzzsaw.Mod_Data.DS_DDC,{UNSIGNED4 ip_u4 := destip_u4, QSTRING15 ip := destip});

    //deduping locally to avoid skew later.		
		locally_unique := dedup(sort(t1+t2,whole record,local), whole record, local ); 

		go_global := distribute(locally_unique,hash(ip_u4));
    totally_unique := dedup(sort(go_global, whole record, local), whole record, local );

		//
		// These are distributed by IP and sorted already. The distribution and uniqueness was verified using...
		//	dsDist := DISTRIBUTED(Buzzsaw.Mod_Data.DS_All_Unique_Ips, ip_u4);
		//	t1 := TABLE(dsDist, {ip_u4, INTEGER cnt := COUNT(GROUP)}, ip_u4, many,local);
		//	OUTPUT(SORT(t1,-cnt));
		//
		// You will also need the following logic to handle additions to the superfile since you'll still need to do this...
		//
		// SEQUENTIAL(
							// FileServices.StartSuperFileTransaction(),
							// IF(NOT FileServices.SuperFileExists(Mod_Data.FN_All_Unique_Ips), 
								// FileServices.CreateSuperFile(Mod_Data.FN_All_Unique_Ips)),
							// FileServices.RemoveSuperFile(Mod_Data.FN_All_Unique_Ips, buzzsaw.Mod_Data.FN_Unique_Srcips),
							// FileServices.FinishSuperFileTransaction(), 
							
							// FileServices.StartSuperFileTransaction(),
							// output(ds_Ips_dedup,{UNSIGNED4 ip_u4 := srcip_u4, QSTRING ip := srcip},buzzsaw.Mod_Data.FN_Unique_Srcips, OVERWRITE);
							// FileServices.AddSuperFile(Mod_Data.FN_All_Unique_Ips, buzzsaw.Mod_Data.FN_Unique_Srcips),
							// FileServices.FinishSuperFileTransaction()
							
						// );
						
		return output(totally_unique,,buzzsaw.Mod_Data.FN_All_Unique_Ips, OVERWRITE);
	end;
		
	SHARED grouped_locs(groupy_name, L_out) := MACRO
		groupy_name := PROJECT(
			buzzsaw.Mod_Data.DS_IP_Location_Std,
			TRANSFORM(L_out,
				SELF.groupid := TRUNCATE(COUNTER/1000),
				SELF := LEFT
			));
	ENDMACRO;

	/*
	 * Append the group information to the original Ip Location dataset.  Make sure to
	 * keep the same modulus as the one used in 'C_Ip_Location_Distribution_Groups'.  In
	 * this case 1000 records per group has been choosen
	 */
	export C_Ip_Location_With_Group_Info := FUNCTION
	/*
		buzzsaw.Mod_Data.L_Ip_Location_With_Group_Info add_group_info(
				buzzsaw.Mod_Data.L_Ip_Location l, INTEGER c) := TRANSFORM
			SELF.groupid := TRUNCATE(c/1000);
			SELF := l;
		END;

		ds := PROJECT(buzzsaw.Mod_Data.DS_IP_Location_Std, add_group_info(LEFT,COUNTER));
	*/
		grouped_locs(group_info, buzzsaw.Mod_Data.L_Ip_Location_With_Group_Info);
		ds := group_info;

		return output(ds,,buzzsaw.Mod_Data.FN_Ip_Location_With_Group_Info,OVERWRITE);
	END;
	
	/*
	 * Break up the Ip Location data into 1k groups and then rollup of the groups to
	 * define the ip ranges they represent.  This will be used to join against the
	 * unique ip list
	 */
	export C_Ip_Location_Distribution_Groups := FUNCTION
	/*
		buzzsaw.Mod_Data.L_Ip_Location_Distribution_Groups add_group_info(
				buzzsaw.Mod_Data.L_Ip_Location l, INTEGER c) := TRANSFORM
			SELF.groupid := TRUNCATE(c/1000);
			SELF := l;
		END;

		ds := PROJECT(buzzsaw.Mod_Data.DS_IP_Location_Std, add_group_info(LEFT,COUNTER));
*/
		grouped_locs(dist_groups, buzzsaw.Mod_Data.L_Ip_Location_Distribution_Groups);
		ds := dist_groups;
		
		buzzsaw.Mod_Data.L_Ip_Location_Distribution_Groups rollup_groups(
				buzzsaw.Mod_Data.L_Ip_Location_Distribution_Groups l, 
				buzzsaw.Mod_Data.L_Ip_Location_Distribution_Groups r) := TRANSFORM
			SELF.ip_to := r.ip_to;
			SELF := l;
		END;

		ds_rollup := ROLLUP(ds,LEFT.groupid = RIGHT.groupid,rollup_groups(LEFT,RIGHT));

		return output(ds_rollup,,buzzsaw.Mod_Data.FN_Ip_Location_Distribution_Groups,OVERWRITE);
	END;
	

	/*
	 * Join the Ip Location group distribution information with the Unique Ip list as
	 * an ALL to allow use of using a condition that uses on inequalities (ie <'s and >'s).
	 * This is how the group corresponding to the range is found.
	 * Once the group id has been associated with the unique ip join with the Ip Location 
	 * dataset containing the groupid
	 */
	export C_All_Unique_Ips_Location := FUNCTION
		ds := buzzsaw.Mod_Data.DS_All_Unique_Ips;

		L_Unique_Ips_Temp := RECORD
			INTEGER groupid;
			Mod_Data.L_Unique_IPs;
		END;

		// remove any duplicate ips that the src and dest share
		ds_dist  := DISTRIBUTE(ds, HASH32(ip_u4));
		ds_sort  := SORT(ds_dist, ip_u4, LOCAL);
		ds_dedup := DEDUP(ds_sort, ip_u4);

		// convert ip to a number
//		ds_temp := PROJECT(ds_dedup, append_ipnum(LEFT));
//		ds_temp := PROJECT(ds_dedup, TRANSFORM(L_Unique_IPs_Temp, SELF := LEFT, SELF.groupid := 0));

		// join the unique ips with the associated group id from the ip location group distribution dataset
		L_Unique_Ips_Temp join_ip_with_group_info(
				RECORDOF(ds_dedup) l, buzzsaw.Mod_Data.L_Ip_Location_Distribution_Groups r) := TRANSFORM
			SELF.groupid := r.groupid;
			SELF.ip      := l.ip;
			SELF.ip_u4   := l.ip_u4;
		END;

		// join with the Ip Location group distribution as all so that a join with only inequality can be used
		// thereby alleviated the "JOIN too complex" error
		ds_unique_ips_with_groupid := JOIN(
			ds_dedup,
			buzzsaw.Mod_Data.DS_Ip_Location_Distribution_Groups,
			LEFT.ip_u4 >= RIGHT.ip_from AND LEFT.ip_u4 <= RIGHT.ip_to,
			join_ip_with_group_info(LEFT,RIGHT),
			ALL
		);

		buzzsaw.Mod_Data.L_Unique_Ips_Location join_ip_with_location_info(
				L_Unique_Ips_Temp l, buzzsaw.Mod_Data.L_Ip_Location_With_Group_Info r) := TRANSFORM
				SELF.ip := l.ip;
				SELF.latitude := (REAL4)r.latitude;
				SELF.longitude := (REAL4)r.longitude;
				SELF := r;
		END;

		// join the unique ips that contain the group id with the Ip Location dataset containing the group ids
		ds_Unique_Ips_Joined := JOIN(
			ds_unique_ips_with_groupid,
			buzzsaw.Mod_Data.DS_Ip_Location_With_Group_Info,
			LEFT.groupid = RIGHT.groupid AND LEFT.ip_u4 >= RIGHT.ip_from AND LEFT.ip_u4 <= RIGHT.ip_to,
			join_ip_with_location_info(LEFT,RIGHT)
		);

		RETURN output(ds_Unique_Ips_Joined,,buzzsaw.Mod_Data.FN_Unique_Ips_Location,OVERWRITE);
	END;
	
	/*
	*
	* This will replace C_All_Unique_Ips_Location.
	*
	*/
	export C_All_Unique_Ips_LocationEx := FUNCTION
		ds := buzzsaw.Mod_Data.DS_All_Unique_Ips;				// This will grow daily

		L_Unique_Ips_Temp := RECORD
			INTEGER groupid;
			Mod_Data.L_Unique_IPs;
		END;

		// join the unique ips with the associated group id from the ip location group distribution dataset
		L_Unique_Ips_Temp join_ip_with_group_info(
				RECORDOF(ds) l, buzzsaw.Mod_Data.L_Ip_Location_Distribution_Groups r) := TRANSFORM
			SELF.groupid := r.groupid;
			SELF.ip      := l.ip;
			SELF.ip_u4   := l.ip_u4;
		END;

		// join with the Ip Location group distribution as all so that a join with only inequality can be used
		// thereby alleviated the "JOIN too complex" error
		ds_unique_ips_with_groupid := JOIN(
			ds,
			buzzsaw.Mod_Data.DS_Ip_Location_Distribution_Groups,
			LEFT.ip_u4 >= RIGHT.ip_from AND LEFT.ip_u4 <= RIGHT.ip_to,
			join_ip_with_group_info(LEFT,RIGHT),ALL);

		buzzsaw.Mod_Data.L_Unique_Ips_Location join_ip_with_location_info(
				L_Unique_Ips_Temp l, buzzsaw.Mod_Data.L_Ip_Location_With_Group_Info r) := TRANSFORM
				SELF.ip := l.ip;
				SELF.ip_u4 := l.ip_u4;
				SELF.latitude := (REAL4)r.latitude;
				SELF.longitude := (REAL4)r.longitude;
				SELF := r;
		END;

		// join the unique ips that contain the group id with the Ip Location dataset containing the group ids
		ds_Unique_Ips_Joined := JOIN(
			ds_unique_ips_with_groupid,
			buzzsaw.Mod_Data.DS_Ip_Location_With_Group_Info,
			LEFT.groupid = RIGHT.groupid AND LEFT.ip_u4 >= RIGHT.ip_from AND LEFT.ip_u4 <= RIGHT.ip_to,
			join_ip_with_location_info(LEFT,RIGHT),lookup);

		// RETURN SEQUENTIAL(
											// output(ds_Unique_Ips_Joined,,buzzsaw.Mod_Data.FN_Unique_Ips_Location,OVERWRITE),
											// BUILDINDEX(Mod_Data_Indexes.IDX_Unique_Ips_Location, OVERWRITE)
											// );
											
		RETURN output(ds_Unique_Ips_Joined,,buzzsaw.Mod_Data.FN_Unique_Ips_Location,OVERWRITE);

	END;
	
	EXPORT C_Remote_Threats() := FUNCTION
		ds1 := DATASET(
				[	{'2007-11-01','REMOTE','216.115.208.0/20'}, 
					{'2007-11-01','REMOTE','216.219.112.0/20'},
					{'2007-11-01','REMOTE','66.151.158.0/24'},
					{'2007-11-01','REMOTE','66.151.150.160/27'},
					{'2007-11-01','REMOTE','66.151.115.128/26'},
					{'2007-11-01','REMOTE','64.74.80.0/24'},
					{'2007-11-01','REMOTE','202.173.24.0/21'},
					{'2007-11-01','REMOTE','67.217.64.0/19'},
					{'2007-11-01','REMOTE','78.108.112.0/20'}
				],
				buzzsaw.Mod_Data.L_Threat_Raw);
		RETURN output(ds1,, buzzsaw.Mod_Data.FN_Threat_Remote_Raw, OVERWRITE);
	END;
	
	
	EXPORT C_Threats() := FUNCTION
		/* set up how we will push threats through to normalize out CIDR notation and convert dates*/
		L_Threat := buzzsaw.Mod_Data.L_Threat;
		L_Threat_Temp := RECORD
			UNSIGNED6 date;
			QSTRING threat;
			QSTRING ip;
		END;
		L_Threat_Raw := buzzsaw.Mod_Data.L_Threat_Raw;

		/* set up parsing rules for first conversion (date) */
		PATTERN yyyy := PATTERN('[0-9]{4}');
		PATTERN mm := PATTERN('[0-9]{1,2}');
		PATTERN dd := PATTERN('[0-9]{1,2}');
		RULE yyyy_mm_dd := yyyy'-'mm'-'dd;
		/* this conversion converts dates in milliseconds since Y2K */
		L_Threat_Temp convert1(L_Threat_Raw R) := TRANSFORM
			SELF.date := Mod_Y2K.ms_since_y2k(
					(INTEGER)MATCHTEXT(yyyy), 
					(INTEGER)MATCHTEXT(mm), 
					(INTEGER)MATCHTEXT(dd), 
					0, 
					0, 
					0, 
					0);
			SELF := R;
		END;
		/* set up parsing rules for second conversion (ip) */
		PATTERN p_octet := PATTERN('[1-2]?[0-9]{1,2}');
		PATTERN octet1 := p_octet;
		PATTERN octet2 := p_octet;
		PATTERN octet3 := p_octet;
		PATTERN octet4 := p_octet;
		PATTERN sider := PATTERN('[1-3]?[0-9]');
		RULE ip_rule := octet1 '.' octet2 '.' octet3 '.' octet4 OPT(' ') OPT('/' sider) OPT(' ');
		/* this conversion converts ips into 4-byte unsigned integers and finds CIDR values */
		{L_Threat, UNSIGNED1 sider} convert2(L_Threat_Temp T) := TRANSFORM
			sider_u1 := (UNSIGNED1)MATCHTEXT(sider);
			SELF.sider := IF(sider_u1 between 1 and 32, sider_u1, 32);
			ip_u4 := (((UNSIGNED1)MATCHTEXT(octet1) * 256 +
					(UNSIGNED1)MATCHTEXT(octet2)) * 256 +
					(UNSIGNED1)MATCHTEXT(octet3)) * 256 +
					(UNSIGNED1)MATCHTEXT(octet4);
			SELF.ip_u4 := IF(SELF.sider between 1 and 31, 
				ip_u4, 
				ip_u4 & Mod_Octets.get_sider_value(SELF.sider));
			SELF := T;
		END;
		/* this conversion adds an ip for all records within a range from ips with a CIDR value */
		{L_Threat, UNSIGNED1 sider} convert3({L_Threat, UNSIGNED1 sider} S, INTEGER n) := TRANSFORM
				SELF.ip_u4 := S.ip_u4+n-1;
				SELF := S;
		END;
		/* "Compromised" IPs (BleedingThreats) */
		ds_c := buzzsaw.Mod_Data.DS_Threat_Compromised_Raw;
		ds_p1 := PARSE(ds_c, date, yyyy_mm_dd, convert1(LEFT), WHOLE, FIRST, NOSCAN);
		ds_p2 := PARSE(ds_p1, ip, ip_rule, convert2(LEFT), WHOLE, FIRST, NOSCAN);
		ds_d := DISTRIBUTE(ds_p2, ip_u4);
		ds_s := SORT(ds_d, ip_u4, LOCAL);
		/* "Remote" Control IPs (Citrix) */
		rds_c := buzzsaw.Mod_Data.DS_Threat_Remote_Raw;
		rds_p1 := PARSE(rds_c, date, yyyy_mm_dd, convert1(LEFT), WHOLE, FIRST, NOSCAN);
		rds_p2 := PARSE(rds_p1, ip, ip_rule, convert2(LEFT), WHOLE, FIRST, NOSCAN);
		rds_d := DISTRIBUTE(rds_p2, ip_u4);
		rds_s := SORT(rds_d, ip_u4, LOCAL);
		/* "BotNet" IPs (BleedingThreats)*/
		bds := buzzsaw.Mod_Data.DS_Threat_BotNets_Raw;
		bds_p1 := PARSE(bds, date, yyyy_mm_dd, convert1(LEFT), WHOLE, FIRST, NOSCAN);
		bds_p2 := PARSE(bds_p1, ip, ip_rule, convert2(LEFT), WHOLE, FIRST, NOSCAN);
		bds_d := DISTRIBUTE(bds_p2, ip_u4);
		bds_s := SORT(bds_d, ip_u4, LOCAL);
		/* Merge all three datasets into one and normalize out CIDRs */
		mds1 := MERGE(ds_s, bds_s, rds_s, LOCAL);
		ds_n := NORMALIZE(mds1, power(2, 32-LEFT.sider), convert3(LEFT, COUNTER));
		/* Join with IPs that are found in the actual data */
		u_t := JOIN(ds_n, Mod_Data_Indexes.IDX_UIP_Location_IP, LEFT.ip_u4 = RIGHT.ip_u4, 
			TRANSFORM(L_Threat, SELF := LEFT));
		
		mds := u_t;
		
		RETURN output(mds,, buzzsaw.Mod_Data.FN_Threat_Thor, OVERWRITE);
	END;
	
	EXPORT C_Find_Threats() := FUNCTION
		L_Threat := buzzsaw.Mod_Data.L_Threat;

		mds := buzzsaw.Mod_Data.DS_Threats;
		L_Firewall_Threats := buzzsaw.Mod_Data.L_Firewall_Threats;

		f_idx_ips := buzzsaw.Mod_Data_Indexes.IDX_U4_ips;
		f_idx_dest := buzzsaw.Mod_Data_Indexes.IDX_U4_destip_u4;
		
		// f_idx_ips := buzzsaw.Mod_Data_Indexes.IDX_U4_ips_Test;
		// f_idx_dest := buzzsaw.Mod_Data_Indexes.IDX_U4_destip_u4_test;


		L_Firewall_Threats join_src(L_Threat T, f_idx_ips F) := TRANSFORM
				SELF := F;
				SELF.src_threat := T.threat;
				SELF.src_threat_date := T.date;
				SELF.dest_threat := '';
				SELF.dest_threat_date := 0;
		END;

		L_Firewall_Threats join_dest(L_Threat T, f_idx_dest F) := TRANSFORM
				SELF.src_threat := '';
				SELF.src_threat_date := T.date;
				SELF.dest_threat := T.threat;
				SELF.dest_threat_date := T.date;
				SELF := F;
		END;

		L_Firewall_Threats join_src_dest(L_Firewall_Threats S, L_Firewall_Threats D) := TRANSFORM
				SELF.src_threat := S.src_threat;
				SELF.src_threat_date := S.src_threat_date;
				SELF.dest_threat := D.dest_threat;
				SELF.dest_threat_date := D.dest_threat_date;
				use_dest := S.protocol = '';
				SELF := IF(S.protocol = '', D, S);
		/*		IF( S.protocol <> '',
					SELF := S,
					SELF := D);*/
		END;

		jds0 := join(mds, f_idx_ips, LEFT.ip_u4=RIGHT.srcip_u4, join_src(LEFT, RIGHT));
		jds1 := join(mds, f_idx_dest, LEFT.ip_u4=RIGHT.destip_u4, join_dest(LEFT, RIGHT), LIMIT(0));
		jds2 := join(jds0, jds1, 
				LEFT.srcip_u4=RIGHT.srcip_u4 AND LEFT.destip_u4=RIGHT.destip_u4, 
				join_src_dest(LEFT, RIGHT), 
				FULL OUTER);
				
		RETURN output(jds2,, buzzsaw.Mod_Data.FN_Threats_Found, OVERWRITE);
	END;
	
	
	/* --- WARNING --- Cluster code is large */
		
	EXPORT C_Clusters(UNSIGNED2 grid_mean=256, UNSIGNED2 grid_stdev=128) := FUNCTION
		L_Stats := buzzsaw.Mod_Data.L_Firewall_Stats;
		L_MoreStats := buzzsaw.Mod_Data.L_Firewall_MoreStats;
		L_Clusters := buzzsaw.Mod_Data.L_Firewall_Cluster;

		log_one_half := log(0.5);

		//don't deal with standard deviations less than 1ms
		//only look at data points that will have a valid standard deviation and interesting period
		//checking stdev cannot be done in log space since log(0)=0 in ECL
		L_MoreStats within_range(L_Stats S) := TRANSFORM
			SELF.orig_stdev := S.stdev;
			SELF.log_mean := IF(S.mean < 1, 0, S.log_mean);
			SELF.log_stdev := IF(S.stdev < 0.5, log_one_half, S.log_stdev); 
			SELF := S;
			SELF := [];
		END;

		r_ds := PROJECT(buzzsaw.Mod_Data.DS_StdDev_Clusterable, within_range(LEFT));

		min_stdev := min(r_ds, log_stdev);
		max_stdev := max(r_ds, log_stdev);
		min_mean := min(r_ds, log_mean);
		max_mean := max(r_ds, log_mean);

		//to keep max within clusters we will decrease the size of the max cluster by 1/10**12 total
		fudge := power(2,-48);

		// grid squares for mean
		mean_unit := grid_mean*(1-fudge) / (max_mean-min_mean);
		// grid squares for stdev
		stdev_unit := grid_stdev*(1-fudge) / (max_stdev-min_stdev);

		L_MoreStats compute_clusters(L_MoreStats L) := TRANSFORM
			SELF.cl_mean := TRUNCATE((L.log_mean-min_mean)*mean_unit);
			SELF.cl_stdev := TRUNCATE((L.log_stdev-min_stdev)*stdev_unit);
		//	SELF.cl_rand := TRUNCATE((LN(L.randomness)-ln_min_randomness)*randomness_unit);
			SELF.cluster := truncate((L.log_mean-min_mean)*mean_unit)*grid_stdev
					+truncate((L.log_stdev-min_stdev)*stdev_unit);
			SELF := L;
		END;


		c_ds := PROJECT(r_ds, compute_clusters(LEFT));
		
		output(c_ds, , '~g2::unrolledupclusters_log', OVERWRITE);

		ct_ds := PROJECT(c_ds, 
			TRANSFORM(L_Clusters, 
				mean := LEFT.mean;
				stdev := LEFT.stdev;
				SELF.mean := mean;
				SELF.stdev := stdev;
				SELF.pairs := 1,
				SELF.clusters_mean := 1,
				SELF.clusters_stdev := 1,
				SELF.min_mean := mean,
				SELF.orig_mean := mean, 
				SELF.max_mean := mean,
				SELF.min_stdev := stdev,
				SELF.orig_stdev := stdev,
				SELF.max_stdev := stdev,
				SELF.min_src_ip := LEFT.srcip_u4,
				SELF.max_src_ip := LEFT.srcip_u4,
				SELF.min_dest_ip := LEFT.destip_u4,
				SELF.max_dest_ip := LEFT.destip_u4,
				SELF.min_destport := LEFT.min_destport,
				SELF.max_destport := LEFT.max_destport,
				SELF.min_events := LEFT.periods+1,
				SELF.max_events := LEFT.periods+1,
				SELF.min_src_cc := LEFT.src_cc;
				SELF.max_src_cc := LEFT.src_cc;
				SELF.min_srcip_cc := LEFT.src_cc;
				SELF.max_srcip_cc := LEFT.src_cc;
				SELF.min_dest_cc := LEFT.dest_cc;
				SELF.max_dest_cc := LEFT.dest_cc;
				SELF.min_destip_cc := LEFT.dest_cc;
				SELF.max_destip_cc := LEFT.dest_cc;
				SELF.min_date := LEFT.min_date;
				SELF.max_date := LEFT.max_date;
				SELF.min_out_packets := LEFT.min_out_packets;
				SELF.max_out_packets := LEFT.max_out_packets;
				SELF.min_in_packets := LEFT.min_in_packets;
				SELF.max_in_packets := LEFT.max_in_packets;
				SELF := LEFT,
			)
		);

		

		L_Clusters roll_into_clusters(L_Clusters L, L_Clusters R) := TRANSFORM
			l_stdev := IF(L.stdev < 0.5, 0.5, L.stdev);
			r_stdev := IF(R.stdev < 0.5, 0.5, R.stdev);
			l_mean := IF(L.mean < 1, 1, L.mean);
			r_mean := IF(R.mean < 1, 1, R.mean);
			SELF.pairs := L.pairs + 1;
			SELF.min_mean := IF(L.min_mean < R.min_mean, L.min_mean, R.min_mean);
			SELF.mean := L_mean + (R_mean - L_mean) / SELF.pairs;
			SELF.max_mean := IF(L.max_mean > R.max_mean, L.max_mean, R.max_mean);
			SELF.min_stdev := IF(L.min_stdev < R.min_stdev, L.min_stdev, R.min_stdev);
			SELF.stdev := L_stdev + (R_stdev - L_stdev) / SELF.pairs;
			SELF.max_stdev := IF(L.max_stdev > R.max_stdev, L.max_stdev, R.max_stdev);
			SELF.min_src_ip := IF(L.min_src_ip < R.min_src_ip, L.min_src_ip, R.min_src_ip);
			SELF.min_srcip_cc := IF(L.min_src_ip < R.min_src_ip, L.min_srcip_cc, R.min_srcip_cc);
			SELF.max_src_ip := IF(L.min_src_ip > R.min_src_ip, L.min_src_ip, R.min_src_ip);
			SELF.max_srcip_cc := IF(L.min_src_ip > R.min_src_ip, L.min_srcip_cc, R.min_srcip_cc);
			SELF.min_dest_ip := IF(L.min_dest_ip < R.min_dest_ip, L.min_dest_ip, R.min_dest_ip);
			SELF.min_destip_cc := IF(L.min_dest_ip < R.min_dest_ip, L.min_destip_cc, R.min_destip_cc);
			SELF.max_dest_ip := IF(L.max_dest_ip > R.max_dest_ip, L.max_dest_ip, R.max_dest_ip);
			SELF.max_destip_cc := IF(L.max_dest_ip > R.max_dest_ip, L.max_destip_cc, R.max_destip_cc);
			SELF.min_destport := IF(L.min_destport < R.min_destport, L.min_destport, R.min_destport);
			SELF.max_destport := IF(L.max_destport > R.max_destport, L.max_destport, R.max_destport);
			SELF.min_events := IF(L.min_events < R.min_events, L.min_events, R.min_events);
			SELF.max_events := IF(L.max_events > R.max_events, L.max_events, R.max_events);
			SELF.orig_mean := L.orig_mean;
			SELF.orig_stdev := L.orig_stdev;
			SELF.min_src_cc := IF(L.min_src_cc < R.min_src_cc, L.min_src_cc, R.min_src_cc);
			SELF.max_src_cc := IF(L.max_src_cc > R.max_src_cc, L.max_src_cc, R.max_src_cc);
			SELF.min_dest_cc := IF(L.min_dest_cc < R.min_dest_cc, L.min_dest_cc, R.min_dest_cc);
			SELF.max_dest_cc := IF(L.max_dest_cc > R.max_dest_cc, L.max_dest_cc, R.max_dest_cc);
			SELF.min_date := IF(L.min_date < R.min_date, L.min_date, R.min_date);
			SELF.max_date := IF(L.max_date > R.max_date, L.max_date, R.max_date);
			LEAST(SELF.min_out_packets, L.min_out_packets, R.min_out_packets);
			GREATEST(SELF.max_out_packets, L.max_out_packets, R.max_out_packets);
			TMIN(min_in_packets, L, R);
			TMAX(max_in_packets, L, R);
			SELF := L;
		END;
			
//		output(sort(ct_ds, mean, stdev), , '~g2::unrolledupclusters', OVERWRITE);

		cr_ds := ROLLUP(SORT(DISTRIBUTE(ct_ds, cluster), cluster, LOCAL), roll_into_clusters(LEFT, RIGHT), cluster, LOCAL);
		
		

		L_Clusters group_clusters(L_Clusters L, L_Clusters R) := TRANSFORM
			SELF.pairs := L.pairs + R.pairs;
			SELF.clusters_mean := IF(L.cl_mean=R.cl_mean, L.clusters_mean, L.clusters_mean+R.clusters_mean);
			SELF.clusters_stdev := IF(L.cl_stdev=R.cl_stdev, L.clusters_stdev, L.clusters_stdev+R.clusters_stdev);
			SELF.min_mean := IF(L.min_mean < R.min_mean, L.min_mean, R.min_mean);
			SELF.mean := (L.mean * L.pairs + R.mean * R.pairs) / SELF.pairs;
			SELF.max_mean := IF(L.max_mean > R.max_mean, L.max_mean, R.max_mean);
			SELF.min_stdev := IF(L.min_stdev < R.min_stdev, L.min_stdev, R.min_stdev);
			SELF.stdev := (L.stdev * L.pairs + R.stdev * R.pairs) / SELF.pairs;
			SELF.max_stdev := IF(L.max_stdev > R.max_stdev, L.max_stdev, R.max_stdev);
			SELF.min_src_ip := IF(L.min_src_ip < R.min_src_ip, L.min_src_ip, R.min_src_ip);
			SELF.min_srcip_cc := IF(L.min_src_ip < R.min_src_ip, L.min_srcip_cc, R.min_srcip_cc);
			SELF.max_src_ip := IF(L.min_src_ip > R.min_src_ip, L.min_src_ip, R.min_src_ip);
			SELF.max_srcip_cc := IF(L.min_src_ip > R.min_src_ip, L.min_srcip_cc, R.min_srcip_cc);
			SELF.min_dest_ip := IF(L.min_dest_ip < R.min_dest_ip, L.min_dest_ip, R.min_dest_ip);
			SELF.min_destip_cc := IF(L.min_dest_ip < R.min_dest_ip, L.min_destip_cc, R.min_destip_cc);
			SELF.max_dest_ip := IF(L.max_dest_ip > R.max_dest_ip, L.max_dest_ip, R.max_dest_ip);
			SELF.max_destip_cc := IF(L.max_dest_ip > R.max_dest_ip, L.max_destip_cc, R.max_destip_cc);
			SELF.min_destport := IF(L.min_destport < R.min_destport, L.min_destport, R.min_destport);
			SELF.max_destport := IF(L.max_destport > R.max_destport, L.max_destport, R.max_destport);
			SELF.min_src_cc := IF(L.min_src_cc < R.min_src_cc, L.min_src_cc, R.min_src_cc);
			SELF.max_src_cc := IF(L.max_src_cc > R.max_src_cc, L.max_src_cc, R.max_src_cc);
			SELF.min_dest_cc := IF(L.min_dest_cc < R.min_dest_cc, L.min_dest_cc, R.min_dest_cc);
			SELF.max_dest_cc := IF(L.max_dest_cc > R.max_dest_cc, L.max_dest_cc, R.max_dest_cc);
			TMIN(min_date, L, R);
			TMAX(max_date, L, R);
			TMIN(min_out_packets, L, R);
			TMAX(max_out_packets, L, R);
			TMIN(min_in_packets, L, R);
			TMAX(max_in_packets, L, R);
			SELF.orig_mean := L.orig_mean;
			SELF.orig_stdev := L.orig_stdev;
			SELF := L;
		END;

		BOOLEAN similar_size(L_Clusters L, L_Clusters R) :=
				(L.clusters_mean = R.clusters_mean)
				AND (L.clusters_stdev = R.clusters_stdev)
				AND IF( L.pairs > R.pairs, L.pairs < 10 * R.pairs, R.pairs < 10 * L.pairs);
				
		BOOLEAN adjacent(L_Clusters L, L_Clusters R, BOOLEAN odd, BOOLEAN mean) :=
				similar_size(L, R)
				AND IF(
					mean, L.cl_mean = R.cl_mean	//rolling up by means
							AND (L.cl_stdev & 1) = IF(odd,1,0)	//don't get too crazy in one direction
							AND L.clusters_mean >= L.clusters_stdev
							AND L.cl_stdev + L.clusters_stdev = R.cl_stdev
						,	L.cl_stdev = R.cl_stdev	//rolling up by stdev
							AND (L.cl_mean & 1) = IF(odd,1,0)	//don't get too crazy in one direction
							AND L.clusters_stdev >= L.clusters_mean
							AND L.cl_mean + L.clusters_mean = R.cl_mean)
		;
		adjacent_means(L_Clusters L, L_Clusters R, BOOLEAN odd) := 
			adjacent(L, R, odd, TRUE);
		adjacent_stdev(L_Clusters L, L_Clusters R, BOOLEAN odd) := 
			adjacent(L, R, odd, FALSE);
			
//		output(sort(cr_ds, mean, stdev), , '~g2::rolledupclusters', OVERWRITE);
		
		DATASET(L_Clusters) quad_rollup(DATASET(L_Clusters) ds) := 
			ROLLUP(ROLLUP(SORT(DISTRIBUTE(ROLLUP(ROLLUP(SORT(DISTRIBUTE(
				ds, cl_stdev), cl_stdev, cl_mean, LOCAL),
				adjacent_stdev(LEFT, RIGHT, TRUE), group_clusters(LEFT, RIGHT), LOCAL),
				adjacent_stdev(LEFT, RIGHT, FALSE), group_clusters(LEFT, RIGHT), LOCAL),
				cl_mean), cl_mean, cl_stdev, LOCAL), 
				adjacent_means(LEFT, RIGHT, TRUE), group_clusters(LEFT, RIGHT), LOCAL), 
				adjacent_means(LEFT, RIGHT, FALSE), group_clusters(LEFT, RIGHT), LOCAL);
				
		super_clusters := quad_rollup(
			quad_rollup(
				quad_rollup(
					quad_rollup(cr_ds))));
/*
		idx := buzzsaw.Mod_Data_Indexes.IDX_Cluster_Plot;
		sequential(
			output(super_clusters, , buzzsaw.Mod_Data.FN_Clusters, OVERWRITE),
			buildindex(idx, OVERWRITE)
		);
*/		
		RETURN output(super_clusters, , buzzsaw.Mod_Data.FN_Clusters, OVERWRITE);
	END;
	
END;
	