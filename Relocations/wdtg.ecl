//
//	Where Did They Go?
//
//	Search for gong recs that appeared near a certain moment in time, near some area(s).
//

/*
	Sample calls:
	
	lname				:= 'LEONARD';
	fname				:= 'TODD';
	lat					:= '29.691933';
	lon					:= '-082.406916';
	zip					:= '32606';
	zipset			:= ['32606','45458','48105','49428'];
	did					:= 1502648379;
	targetDate	:= '20010701';
	
	output( Relocations.wdtg.get_gong(lname,fname,targetDate).near_LL(lat,lon) );
	output( Relocations.wdtg.get_gong(lname,fname,targetDate).near_zip(zip) );
	output( Relocations.wdtg.get_gong(lname,fname,targetDate).near_zipset(zipset) );
	output( Relocations.wdtg.get_gong_by_did(did,targetDate) );
	
	In real use, targetDate should be considered mandatory.  However, for testing,
	a blank/default value will return all gong data within distance limits.  Other
	optional parameters are for tuning.
	
	get_gong(lname,fname[,targetDate][,maxDaysBefore][,maxDaysAfter][,fuzzyLast][,exactFirst][,allowNonCurrent])
		.near_LL(lat,lon[,radius])
		.near_zip(zip[,radius])
		.near_zipset(zipset[,radius])
	
	get_gong_by_did(did[,targetDate][,radius][,maxDaysBefore][,maxDaysAfter][,fuzzyLast][,exactFirst][,allowNonCurrent])
*/

import Gong, ut, doxie, NID;


// STUB - are these two routines worthy of inclusion in module ut?

// find the date so many days before or after a given date
date_YYYYMMDD_delta(string8 dStr, integer2 delta) := ut.DateFrom_DaysSince1900(
	ut.DaysSince1900(dStr[1..4], dStr[5..6], dStr[7..8]) + delta );

// like ut.DaysApart, but directional
integer8 vDaysApart(string8 d1, string8 d2) := 
	ut.DaysSince1900(d1[1..4], d1[5..6], d1[7..8]) -
	ut.DaysSince1900(d2[1..4], d2[5..6], d2[7..8]);


export wdtg := module

	// constants
	export default_maxResults	:= 25;
	export default_radius			:= 30;
	export default_daysBefore	:= 60;
	export default_daysAfter	:= 180;
	
	shared max_rawHits				:= 500;
	
	shared time_max_great			:= 30;
	shared time_max_good			:= 60;
	shared time_penalt_great	:= 0;
	shared time_penalt_good		:= 2;
	shared time_penalt_bad		:= 4;
	
	shared dist_max_great			:= 10;
	shared dist_max_good			:= 20;
	shared dist_penalt_great	:= 0;
	shared dist_penalt_good		:= 2;
	shared dist_penalt_bad		:= 4;
	
	shared name_penalt_minor	:= 1;
	shared name_penalt_major	:= 5;

	shared gong_key						:= Gong.key_history_zip_name;
	shared gong_key_date			:= Relocations.key_wdtgGong;

	shared layout_narrow			:= Relocations.layout_wdtg.narrow;
	shared layout_final				:= Relocations.layout_wdtg.final;
	
	// internal (infernal?) layouts
	shared layout_target := record
		string8		tDate;
		string8		tDateBef;
		string8		tDateAft;
		string20	tFirst;
		string20	tMiddle;
		string20	tLast;
		string5		tZip;
		set of integer4 areaZips;
		string10	reason;
	end;
	shared layout_raw := record
		string5		targetZip := '';
		string10	targetLat := '';
		string11	targetLon := '';
		string8		targetDate := '';
		string20	targetLname := '';
		string20	targetFname := '';
		
		layout_final;
		
		typeof(gong_key.dt_first_seen) hitDate;
		unsigned2	fuzziness;
		integer2	dTime;
		real8			dSpace; // NOTE: Below, we count on this being the last column
	end;
	shared layout_zip := record
		string5		zip,
		string10	reason
	end;
	

	export dataset(layout_final) get_gong_by_did(
		unsigned6 targetDID,		//HIDDEN ASSUMPTION THAT THIS > 0 AND HAS HEADER RECORDS
		string8		targetDate_in		= '',
		real8			radius					= default_radius,
		unsigned2	maxDaysBefore 	= default_daysBefore,
		unsigned2	maxDaysAfter		= default_daysAfter,
		boolean		noNickname			= false,
		boolean		allowNonCurrent	= false,
		boolean		useLatestLName	= false,
		boolean		useRelatives		= false
	) := function
		
		// get the header records for the target subject, and reduce to just zips
		dids := dataset( [ targetDID ], doxie.layout_references );

    mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule ());
		headerRecs := 
      doxie.Comp_Subject_Addresses(dids,mod_access := mod_access).addresses;
		headerSort	:= sort(headerRecs,-dt_last_seen);
		headerRecs_z := project(headerRecs, transform(layout_zip, self.zip:=left.zip, self.reason:='header'));
		// output(headerSort, named('headerSort')); // DEBUG
		
		// get target names from the best record
		br := doxie.best_records (dids, modAccess := mod_access);
		targetFirst := br[1].fname;
		targetMiddle := br[1].mname;
		
		// get target date from the most recent header record, or override
		targetDate := map(
			targetDate_in=''	=> (string8)(headerSort[1].dt_last_seen * 100),
			targetDate_in='0'	=> '',
			targetDate_in
		);
		
		// get zips from relatives (optionally)
		relRecs		:= doxie.Relative_Records(false);
		relRecs_d	:= dedup( sort(relRecs, did, -dt_last_seen), did );
		relRecs_z	:= if(
			useRelatives,
			project(relRecs_d, transform(layout_zip, self.zip:=left.zip, self.reason:='relative')),
			dataset([], layout_zip)
		);
		
		// get unique zips from header and relative records
		zip_s := sort(
			headerRecs_z + relRecs_z,
			zip, reason
		);
		zip_ds := sort(
			dedup(zip_s, zip),
			reason, record
		);
		// output(zip_s, named('zip_s'));		// DEBUG
		// output(zip_ds, named('zip_ds'));	// DEBUG
		
		// get unique lnames from all header records
		headerRecs_lnames := if(useLatestLName, choosen(headerSort,1), headerRecs);
		lname_ds := dedup( sort( project(headerRecs_lnames, {string20 lname}), record ), record );
		
		// generate target combinations
		zip_ds2		:= project( zip_ds, 	transform({string1 foo; zip_ds;}, 	self.foo := 'X', self:=left) );
		lname_ds2	:= project( lname_ds, transform({string1 foo; lname_ds;}, self.foo := 'X', self:=left) );
		targets := join(
			lname_ds2, zip_ds2,
			left.foo=right.foo, // we want all zip/lname combinations
			transform(
				layout_target,
				self.tDate		:= targetDate;
				self.tDateBef	:= if(targetDate<>'', date_YYYYMMDD_delta(targetDate, -maxDaysBefore), '');
				self.tDateAft	:= if(targetDate<>'', date_YYYYMMDD_delta(targetDate, maxDaysAfter), '');
				self.tFirst		:= targetFirst;
				self.tMiddle	:= targetMiddle;
				self.tLast		:= left.lname;
				self.tZip			:= right.zip;
				self.areaZips	:= ZipLib.ZipsWithinRadius(right.zip, radius);
				self.reason		:= right.reason;
			)
		);
		// output(targets, named('targets')); // DEBUG
		targets_s := sort(targets, reason, tzip, tlast);
		// output(targets_s, named('targets_s')); // DEBUG
		
		// get preferred first name
		
		// compute all value-add columns in gong join
		mac_toOut(L,R) := macro
			tLat := trim(ut.getLL(L.tZip)[1..9]);
			tLon := trim(ut.getLL(L.tZip)[11..21]);
			self.targetZip		:= L.tZip;
			self.targetLat		:= tLat;
			self.targetLon		:= tLon;
			self.targetDate		:= L.tDate;
			self.targetLname	:= L.tLast;
			self.targetFname	:= L.tFirst;
			self.hitDate			:= R.dt_first_seen;
			self.fuzziness		:=
				if(R.name_last<>L.tLast, name_penalt_minor, 0) + 
				if(R.name_first<>L.tFirst, name_penalt_minor, 0) + 
				if(~NID.mod_PFirstTools.RinPFL(L.tFirst,R.p_name_first),name_penalt_major, 0);
			self.dTime				:= if(L.tDate<>'', vDaysApart(R.dt_first_seen, L.tDate), 0);
			self.dSpace				:= ut.LL_Dist(
				(real)(tLat), (real)(tLon), 
				(real)(R.geo_lat), (real)(R.geo_long)
			);
			self := R;
		endmacro;
		layout_raw toOut(targets L, gong_key R) := transform
			mac_toOut(L,R)
		end;
		layout_raw toOut_date(targets L, gong_key_date R) := transform
			mac_toOut(L,R)
		end;
		
		mnames_ok(string l, string r) := 
					 l = '' or
					 r = '' or
					 l = r or 
					 (l[1] = r[1] and (length(trim(l)) = 1 or length(trim(r)) = 1));
		
		// retrieve first pass of gong records
		gong_raw_nodate := join(
			targets, gong_key,
			keyed(right.zip5 in left.areaZips)
				and keyed(right.dph_name_last=metaphonelib.DMetaPhone1(left.tLast))
				and keyed(NID.mod_PFirstTools.RinPFL(left.tFirst,right.p_name_first))
				and mnames_ok(targetMiddle, right.name_middle) 
				and (right.name_last = left.tLast)
				and (right.name_first = left.tFirst or not noNickname), // STUB - optionally allow first mismatch
			toOut(left,right), limit(max_rawHits,skip)
		);
		gong_raw_date := join(
			targets, gong_key_date,
			keyed(right.dph_name_last=metaphonelib.DMetaPhone1(left.tLast))
				and keyed(right.dt_first_seen between left.tDateBef and left.tDateAft)
				and keyed(right.zip5 in left.areaZips)
				and keyed(NID.mod_PFirstTools.RinPFL(left.tFirst,right.p_name_first))
				and keyed(right.name_last = left.tLast)
				and keyed(right.name_first = left.tFirst or not noNickname)
				and mnames_ok(targetMiddle, right.name_middle) , // STUB - optionally allow first mismatch
			toOut_date(left,right), limit(max_rawHits,skip)
		);
		gong_raw := if(targetDate<>'', gong_raw_date, gong_raw_nodate);
		
		// rollup dates on each targetZip/addr/phone triple (not needed if we use the custom key)
		gong_raw toRoll(gong_raw L, gong_raw R) := transform
			self.dt_first_seen := (string8)ut.min2((integer)L.dt_first_seen, (integer)R.dt_first_seen);
			hitLeft 			:= abs(L.dTime) < abs(R.dTime);
			self.dTime		:= if(hitLeft, L.dTime, R.dTime);
			self.hitDate	:= if(hitLeft, L.hitDate, R.hitDate);
			self := L;
		end;
		gong_rolled_nodate := rollup(
			sort(gong_raw, targetZip,z5,prim_name,prim_range,phone10, -dt_last_seen),
			toRoll(left, right),
			targetZip,z5,prim_name,prim_range,phone10
		);
		gong_rolled := if(targetDate<>'', gong_raw, gong_rolled_nodate);
		// output(gong_raw, named('gong_raw')); // DEBUG
		// output(gong_rolled, named('gong_rolled')); // DEBUG
	
		// throw away records that don't match closely in time, or aren't current (if required)
		gong_dated := gong_rolled(
			(dTime between -maxDaysBefore and maxDaysAfter),
			(current_record_flag='Y' or allowNonCurrent)
		);
		// output(gong_dated, named('gong_dated')); // DEBUG
		
		// dedup identical locations
		gong_dedup := dedup(
			sort(gong_dated, record, except targetZip, except targetLat, except targetLon), // NOTE: takes advantage of dSpace being the last column
			record, except targetZip, except targetLat, except targetLon, except dSpace
		);
		// STUB - the dedup shouldn't be dependant on column order.
			
		// assign penalties
		layout_raw toPenalt(layout_raw L) := transform
			self.penalt := 
				L.fuzziness + 
				map(
					abs(L.dTime)<=time_max_great	=> time_penalt_great,
					abs(L.dTime)<=time_max_good		=> time_penalt_good,
					time_penalt_bad
				) +
				map(
					abs(L.dSpace)<=dist_max_great	=> dist_penalt_great,
					abs(L.dSpace)<=dist_max_good	=> dist_penalt_good,
					dist_penalt_bad
				);
			self := L;
		end;
		gong_penalt := project(gong_dedup, toPenalt(left));
		
		// sort by quality and recency
		gong_sort := sort(gong_penalt, -(current_record_flag='Y'), penalt, -dt_last_seen);
		
		// project to final format
		results := project(gong_sort, layout_final);
		
		return results;
		
	end; // get_gong_by_did

end; // wdtg
