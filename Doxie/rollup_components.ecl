IMPORT doxie, ut, mdr, advo, header;

EXPORT rollup_components(GROUPED DATASET(doxie.Layout_HeaderFileSearch) indata,boolean allow_wildcard = false) :=
MODULE

	shared srchedAddrThold := 4;
	shared high_tnt := 100; // default high value; lowest is best
	shared high_valid_ssn := 100; // default high value; lowest is best

	yearDOB(integer4 dob) := dob div 10000;
	yearMonthDOB(integer4 dob) := dob div 100;
	monthDOB(integer4 dob) := (dob % 10000) div 100;
	dayDOB(integer4 dob) := dob % 100;
	shared EquivDates(integer4 le, integer4 ri) := MAP (le = ri => TRUE,
		yearMonthDOB(le) = yearMonthDOB(ri) AND
					(dayDOB(le) = 0 OR dayDOB(ri) = 0) => TRUE,
		yearDOB(le) = yearDOB(ri) AND
					(monthDOB(le) = 0 OR monthDOB(ri) = 0) => TRUE,
		FALSE);

	EXPORT name :=
	FUNCTION
		// sort by everything, so its stable (in all of these functions below)
		namesrtd := sort(indata,lname,fname,mname,name_suffix,-penalt);
		doxie.Layout_Rollup.NameRecDid extendNames(namesrtd l) := TRANSFORM
			SELF.did := l.did;
			SELF.penalt := l.penalt;
			SELF.num_compares := 0;
			SELF.n.fname := l.fname;
			SELF.n.mname := l.mname;
			SELF.n.lname := l.lname;
			SELF.n.title := l.title;
			SELF.n.name_suffix := l.name_suffix;
		END;
		nametbl := PROJECT(namesrtd, extendNames(LEFT));

		doxie.Layout_Rollup.NameRecDid rollNames(doxie.Layout_Rollup.NameRecDid le, doxie.Layout_Rollup.NameRecDid ri) := TRANSFORM
			//SELF.title := le.title;
			SELF.did := le.did;
			SELF.penalt := MIN(le.penalt, ri.penalt);
			SELF.num_compares := 0;
			SELF.n := le.n;
		END;
		names := ROLLUP(nametbl, rollNames(LEFT,RIGHT), n.lname, n.fname, n.mname, n.name_suffix);

		// keep names limit per did group (and generally, for all sections below, other than address)
		RETURN DEDUP(names,true,KEEP(rollup_limits.names));
		END;


	EXPORT addresses(STRING pname_value='', STRING city_value='', STRING2 state_value='',
		STRING10 phone_value='', SET OF INTEGER4 zip_value=[], boolean include_cds=false) :=
	FUNCTION

		validAddrs := indata(zip <> '' or city_name <> '' or st <> '' or prim_name <> '' or
			prim_range <> '');

		addrsrtd := sort(validAddrs,zip,prim_name,prim_range,suffix,sec_range,city_name,st,predir,postdir,
			zip4,county_name,county,geo_blk,-penalt);

	  srchedAddrMatch(Layout_HeaderFileSearch l) :=
		IF(pname_value = '' and city_value = '' and state_value = '' and zip_value = [], false,
				doxie.FN_Tra_Penalty_Addr(l.predir,l.prim_range,l.prim_name,l.suffix,l.postdir,l.sec_range,
					l.city_name,l.st,l.zip, allow_wildcard) < srchedAddrThold);


		srchedPhoneMatch(addrsrtd l) := phone_value <> '' and
            (l.listed_phone=phone_value or l.listed_phone[4..10]=phone_value);

		doxie.Layout_Rollup.AddrRecDid extendAddrs(addrsrtd l) := TRANSFORM
			SELF.did := l.did;
			SELF.penalt := l.penalt;
			SELF.num_compares := 0;
			SELF.bestSrchedAddrTntScore := IF(srchedAddrMatch(l) or srchedPhoneMatch(l), tnt_score(l.tnt), high_tnt);
			SELF.bestSrchedAddrDate := IF(srchedAddrMatch(l) or srchedPhoneMatch(l), MAX(l.first_seen, l.last_seen),0);
			SELF.bestTntScore := tnt_score(l.tnt);
			SELF.fromGong := l.src='PH';
			SELF.a.tnt := l.tnt;
			SELF.a.first_seen := l.first_seen;
			SELF.a.last_seen := l.last_seen;
			SELF.a.predir := l.predir;
			SELF.a.prim_range := l.prim_range;
			SELF.a.prim_name := l.prim_name;
			SELF.a.suffix := l.suffix;
			SELF.a.postdir := l.postdir;
			SELF.a.unit_desig := l.unit_desig;
			SELF.a.sec_range := l.sec_range;
			SELF.a.city_name := l.city_name;
			SELF.a.st := l.st;
			SELF.a.zip := IF((INTEGER)l.zip = 0, '', l.zip);
			SELF.a.zip4 := IF((INTEGER)l.zip4 = 0, '', l.zip4);
			SELF.a.county_name := l.county_name;
			SELF.a.county := l.county;
			SELF.a.geo_blk := l.geo_blk;
			SELF.a.phoneRecs := PROJECT(l.phones,TRANSFORM(doxie.Layout_Rollup.PhoneRec,SELF := LEFT,
			SELF.phone := LEFT.phone10,
			SELF.hri_phone := []))(phone<>'' OR listed_name<>'');
			SELF.a.hri_address := l.hri_address;
			SELF.a.address_cds := []; // not defined yet
			SELF.a.dt_vendor_last_reported := l.dt_vendor_last_reported;
			SELF.a.dt_vendor_first_reported := l.dt_vendor_first_reported;
			SELF.a.IsCurrent := l.tnt in doxie.rollup_limits.TNT_CURRENT_SET;
			END;

		addrtbl := PROJECT(addrsrtd, extendAddrs(LEFT));

		// Returns the "weight" of an address depending on its completeness.
		// (TODO: just prim_range, prim_name might probably be enough).
		real weight_address (doxie.Layout_Rollup.AddrRec addr) := function
			real absolute_score :=
				if (addr.prim_range != '',  2.0, 0.0) +
				if (addr.prim_name  != '',  2.0, 0.0) +
				// if (addr.sec_range  != '',  1.0, 0.0) +
				if (addr.predir     != '', 0.25, 0.0) +
				if (addr.postdir    != '', 0.25, 0.0) +
				if (addr.suffix     != '', 0.25, 0.0);
			// Addresses with the score higher than certain threshold will get same "good enough" score.
			return min (absolute_score, 4.0);
		end;

		// tri-state: left is better, right is better, or equal.
		integer CompareAddresses (doxie.Layout_Rollup.AddrRec l_addr, doxie.Layout_Rollup.AddrRec r_addr) := function
			cnt_left := weight_address (l_addr);
			cnt_right := weight_address (r_addr);
			return map (cnt_left > cnt_right => -1,
				cnt_left < cnt_right => 1, 0);
    end;

		doxie.Layout_Rollup.AddrRecDid rollAddrs(doxie.Layout_Rollup.AddrRecDid le, doxie.Layout_Rollup.AddrRecDid ri) := TRANSFORM
			SELF.did := le.did;
			SELF.penalt := MIN(le.penalt, ri.penalt);
			SELF.num_compares := 0;
			SELF.bestSrchedAddrTntScore := IF(le.bestSrchedAddrTntScore < ri.bestSrchedAddrTntScore, le.bestSrchedAddrTntScore, ri.bestSrchedAddrTntScore);
			SELF.bestSrchedAddrDate := MAX(le.bestSrchedAddrDate, ri.bestSrchedAddrDate);
			SELF.fromGong := le.fromGong and ri.fromGong;

			// Some values should be assigned from the "better" address.
			// Note, that SORT above and ROLLUP condition (this transform is defined for) are "loose" enough
			// for the two addresses with any of the address-components missing to be considered "the same" here.
			// Here's an attempt to choose the best address; to limit the number of possibilities I will assume
			// that both location are the same at least down to city level.
			ca := CompareAddresses (le.a, ri.a);

			SELF.bestTntScore := CASE (ca, -1 => le.bestTntScore, 1 => ri.bestTntScore, min (le.bestTntScore, ri.bestTntScore));
			tmp_tnt := CASE (ca, -1 => le.a.tnt, 1 => ri.a.tnt, if (tnt_score(le.a.tnt) < tnt_score(ri.a.tnt), le.a.tnt, ri.a.tnt));
			SELF.a.tnt := tmp_tnt;
			SELF.a.IsCurrent := tmp_tnt in doxie.rollup_limits.TNT_CURRENT_SET;

			min_first := if (ri.a.first_seen = 0 or (le.a.first_seen >0 and le.a.first_seen < ri.a.first_seen),
				le.a.first_seen,
				ri.a.first_seen);
			SELF.a.first_seen := CASE (ca, -1 => le.a.first_seen, 1 => ri.a.first_seen, min_first);
			SELF.a.last_seen := CASE (ca, -1 => le.a.last_seen, 1 => ri.a.last_seen, MAX (le.a.last_seen, ri.a.last_seen));

			SELF.a.dt_vendor_last_reported := IF( le.a.dt_vendor_last_reported > ri.a.dt_vendor_last_reported,
				le.a.dt_vendor_last_reported,
					ri.a.dt_vendor_last_reported);
			SELF.a.dt_vendor_first_reported := IF( le.a.dt_vendor_first_reported > 0
				and le.a.dt_vendor_first_reported < ri.a.dt_vendor_first_reported,
				le.a.dt_vendor_first_reported, ri.a.dt_vendor_first_reported );
			SELF.a.predir := IF (le.a.predir <> '', le.a.predir, ri.a.predir);
			SELF.a.prim_range := IF (le.a.prim_range <> '', le.a.prim_range, ri.a.prim_range);
			SELF.a.prim_name := IF (le.a.prim_name <> '', le.a.prim_name, ri.a.prim_name);
			SELF.a.suffix := IF (le.a.suffix <> '', le.a.suffix, ri.a.suffix);
			SELF.a.postdir := IF (le.a.postdir <> '', le.a.postdir, ri.a.postdir);
			SELF.a.unit_desig := IF (LENGTH(le.a.unit_desig) > LENGTH(ri.a.unit_desig), le.a.unit_desig, ri.a.unit_desig);
			SELF.a.sec_range := IF (le.a.sec_range <> '', le.a.sec_range, ri.a.sec_range);
			SELF.a.city_name := IF (le.a.city_name <> '', le.a.city_name, ri.a.city_name);
			SELF.a.st := IF (le.a.st <> '', le.a.st, ri.a.st);
			SELF.a.zip := IF (le.a.zip <> '', le.a.zip, ri.a.zip);
			SELF.a.zip4 := IF (le.a.zip4 <> '', le.a.zip4, ri.a.zip4);
			// prefer a populated geo_block from a successfully cleaned address (zip4)
			SELF.a.geo_blk := IF (le.a.zip4 <> '' and le.a.geo_blk <> '', le.a.geo_blk, ri.a.geo_blk);
			SELF.a.county_name := IF (le.a.county_name <> '', le.a.county_name, ri.a.county_name);
			// make certain that listed=true phones get preferred over listed=false
			gongRecs := if (~le.fromGong, le.a.phoneRecs) + if (~ri.fromGong, ri.a.phoneRecs);
			SELF.a.phoneRecs := CHOOSEN(DEDUP(SORT(gongRecs,phone,listed_name,-listed),phone,listed_name),doxie.rollup_limits.phones);
			// SELF.a.hri_address := le.a.hri_address + ri.a.hri_address;
			SELF.a := le.a;
		END;

		addrs := ROLLUP(addrtbl, rollAddrs(LEFT,RIGHT),
					 ut.nneq(LEFT.a.zip, RIGHT.a.zip),
					 ut.nneq(LEFT.a.city_name, RIGHT.a.city_name),
					 ut.nneq(LEFT.a.st, RIGHT.a.st),
					 ut.nneq(LEFT.a.prim_name, RIGHT.a.prim_name),
					 ut.nneq(LEFT.a.prim_range, RIGHT.a.prim_range),
					 ut.nneq(LEFT.a.suffix, RIGHT.a.suffix),
					 ut.nneq(LEFT.a.predir, RIGHT.a.predir),
					 ut.nneq(LEFT.a.postdir, RIGHT.a.postdir),
					 ut.nneq(LEFT.a.sec_range, RIGHT.a.sec_range));

		//this gets the trailing 7 digits of the phone (or all of it if less than 7 chars)
		normedPhone(string10 p) := p[MAX(1, LENGTH(TRIM(p))-6)..];

		doxie.Layout_Rollup.PhoneRec rollPhones(doxie.Layout_Rollup.PhoneRec le, doxie.Layout_Rollup.PhoneRec ri) := TRANSFORM
			SELF.phone := IF (LENGTH(TRIM(le.phone)) = 10, le.phone, ri.phone);
			SELF.timezone := IF (LENGTH(TRIM(le.phone)) = 10, le.timezone, ri.timezone);
			SELF.listed := le.listed OR ri.listed;
			SELF.listing_type_res := IF(le.listing_type_res <> '', le.listing_type_res,ri.listing_type_res);
			SELF.listing_type_bus := IF(le.listing_type_bus <> '', le.listing_type_bus,ri.listing_type_bus);
			SELF.listing_type_gov := IF(le.listing_type_gov <> '', le.listing_type_gov,ri.listing_type_gov);
			SELF.listing_type_cell := IF(le.listing_type_cell <> '', le.listing_type_cell,ri.listing_type_cell);
			SELF.new_type := IF(le.new_type <> '', le.new_type,ri.new_type);
			SELF.carrier := IF(le.carrier <> '', le.carrier,ri.carrier);
	        SELF.carrier_city := IF(le.carrier_city <> '', le.carrier_city,ri.carrier_city);
         	SELF.carrier_state := IF(le.carrier_state <> '', le.carrier_state,ri.carrier_state);
	        SELF.PhoneType := IF(le.PhoneType <> '', le.PhoneType,ri.PhoneType);
	        SELF.phone_first_seen := IF(le.phone_first_seen < ri.phone_first_seen, le.phone_first_seen,ri.phone_first_seen);
	        SELF.phone_last_seen := IF(le.phone_last_seen > ri.phone_last_seen, le.phone_last_seen,ri.phone_last_seen);
			SELF.listed_name := IF(le.listed_name <> '', le.listed_name,ri.listed_name);
			SELF.caption_text := IF(le.caption_text <> '', le.caption_text,ri.caption_text);
			SELF.match_type := ut.min2(le.match_type,ri.match_type);
			SELF.bdid := IF(le.bdid <> 0, le.bdid, ri.bdid);
			SELF.did := IF(le.did<>0,le.did,ri.did);
			SELF.gong_score := // take listed over not listed
												 IF(le.listed AND ~ri.listed, le.gong_score,
														// otherwise, take min
														MIN(le.gong_score,ri.gong_score));
			SELF.hri_phone := []; // we don't until much later
		END;
		doxie.Layout_Rollup.AddrRecDid rollAddrPhones(doxie.Layout_Rollup.AddrRecDid le) := TRANSFORM
			// sort first on the last 7 chars of the phone, then on the entire phone
			srtdPhones := SORT(le.a.phoneRecs, normedPhone(phone),phone,IF(listed,0,1),-listed_name,-caption_text,match_type);
			SELF.a.phoneRecs := CHOOSEN(ROLLUP(srtdPhones, rollPhones(LEFT,RIGHT),
																					LEFT.phone = RIGHT.phone OR normedPhone(LEFT.phone) = RIGHT.phone OR
																						LEFT.phone = normedPhone(RIGHT.phone)),
																	doxie.rollup_limits.phones);
			self := le;
		END;

		addrPhonesDeduped := PROJECT(addrs, rollAddrPhones(LEFT));

		doxie.Layout_Rollup.AddrRecDid cdskey1Transform(doxie.Layout_Rollup.AddrRecDid inRec, advo.key_addr1 cds) := TRANSFORM
     		SELF.a.address_cds.Record_Type_Code := if(inRec.a.address_cds.Lookedup=false,cds.Record_Type_Code,inRec.a.address_cds.Record_Type_Code);
     		SELF.a.address_cds.Record_Type_Description := if(inRec.a.address_cds.Lookedup=false,advo.Lookup_Descriptions.Record_Type_Description_lookup(cds.Record_Type_Code),inRec.a.address_cds.Record_Type_Description);
     		SELF.a.address_cds.Route_Num := if(inRec.a.address_cds.Lookedup=false,cds.Route_Num,inRec.a.address_cds.Route_Num);
     		SELF.a.address_cds.Route_Description := if(inRec.a.address_cds.Lookedup=false,advo.Lookup_Descriptions.Route_Description_lookup(cds.Route_Num),inRec.a.address_cds.Route_Description);
     		SELF.a.address_cds.WALK_Sequence := if(inRec.a.address_cds.Lookedup=false,cds.WALK_Sequence,inRec.a.address_cds.WALK_Sequence);
     		SELF.a.address_cds.Address_Vacancy_Indicator := if(inRec.a.address_cds.Lookedup=false,cds.Address_Vacancy_Indicator,inRec.a.address_cds.Address_Vacancy_Indicator);
     		SELF.a.address_cds.Address_Vacancy_Description := if(inRec.a.address_cds.Lookedup=false,advo.Lookup_Descriptions.Address_Vacancy_Description_lookup(cds.Address_Vacancy_Indicator),inRec.a.address_cds.Address_Vacancy_Description);
     		SELF.a.address_cds.Throw_Back_Indicator := if(inRec.a.address_cds.Lookedup=false,cds.Throw_Back_Indicator,inRec.a.address_cds.Throw_Back_Indicator);
     		SELF.a.address_cds.Seasonal_Delivery_Indicator := if(inRec.a.address_cds.Lookedup=false,cds.Seasonal_Delivery_Indicator,inRec.a.address_cds.Seasonal_Delivery_Indicator);
     		SELF.a.address_cds.Seasonal_Delivery_Description := if(inRec.a.address_cds.Lookedup=false,advo.Lookup_Descriptions.Seasonal_Delivery_Description_lookup(cds.Seasonal_Delivery_Indicator),inRec.a.address_cds.Seasonal_Delivery_Description);
     		SELF.a.address_cds.Seasonal_Start_Suppression_Date := if(inRec.a.address_cds.Lookedup=false,cds.Seasonal_Start_Suppression_Date,inRec.a.address_cds.Seasonal_Start_Suppression_Date);
     		SELF.a.address_cds.Seasonal_End_Suppression_Date := if(inRec.a.address_cds.Lookedup=false,cds.Seasonal_End_Suppression_Date,inRec.a.address_cds.Seasonal_End_Suppression_Date);
     		SELF.a.address_cds.DND_Indicator := if(Length(cds.zip)>0,cds.DND_Indicator,inRec.a.address_cds.DND_Indicator);
     		SELF.a.address_cds.College_Indicator := if(inRec.a.address_cds.Lookedup=false,cds.College_Indicator,inRec.a.address_cds.College_Indicator);
     		SELF.a.address_cds.College_Start_Suppression_Date := if(inRec.a.address_cds.Lookedup=false,cds.College_Start_Suppression_Date,inRec.a.address_cds.College_Start_Suppression_Date);
     		SELF.a.address_cds.College_End_Suppression_Date := if(inRec.a.address_cds.Lookedup=false,cds.College_End_Suppression_Date,inRec.a.address_cds.College_End_Suppression_Date);
     		SELF.a.address_cds.Address_Style_Flag := if(inRec.a.address_cds.Lookedup=false,cds.Address_Style_Flag,inRec.a.address_cds.Address_Style_Flag);
     		SELF.a.address_cds.Drop_Indicator := if(inRec.a.address_cds.Lookedup=false,cds.Drop_Indicator,inRec.a.address_cds.Drop_Indicator);
     		SELF.a.address_cds.Residential_or_Business_Ind := if(inRec.a.address_cds.Lookedup=false,cds.Residential_or_Business_Ind,inRec.a.address_cds.Residential_or_Business_Ind);
     		SELF.a.address_cds.Delivery_Type_Description := if(inRec.a.address_cds.Lookedup=false,advo.Lookup_Descriptions.Delivery_Type_Description_lookup(cds.Residential_or_Business_Ind),inRec.a.address_cds.Delivery_Type_Description);
     		SELF.a.address_cds.County_Num := if(inRec.a.address_cds.Lookedup=false,cds.County_Num,inRec.a.address_cds.County_Num);
     		SELF.a.address_cds.County_Name := if(inRec.a.address_cds.Lookedup=false,cds.County_Name,inRec.a.address_cds.County_Name);
     		SELF.a.address_cds.City_Name := if(inRec.a.address_cds.Lookedup=false,cds.City_Name,inRec.a.address_cds.City_Name);
     		SELF.a.address_cds.State_Code := if(inRec.a.address_cds.Lookedup=false,cds.State_Code,inRec.a.address_cds.State_Code);
     		SELF.a.address_cds.State_Num := if(inRec.a.address_cds.Lookedup=false,cds.State_Num,inRec.a.address_cds.State_Num);
     		SELF.a.address_cds.Congressional_District_Number := if(inRec.a.address_cds.Lookedup=false,cds.Congressional_District_Number,inRec.a.address_cds.Congressional_District_Number);
     		SELF.a.address_cds.Address_Type := if(inRec.a.address_cds.Lookedup=false,cds.Address_Type,inRec.a.address_cds.Address_Type);
     		SELF.a.address_cds.Mixed_Address_Usage := if(inRec.a.address_cds.Lookedup=false,cds.Mixed_Address_Usage,inRec.a.address_cds.Mixed_Address_Usage);
			SELF.a.address_cds.Lookedup := if(inRec.a.address_cds.Lookedup=false,if(Length(Trim(cds.Record_Type_Code,LEFT,RIGHT))>=1,true,false),inRec.a.address_cds.Lookedup);
			SELF := inRec;
		END;

		doxie.Layout_Rollup.AddrRecDid cdskey2Transform(doxie.Layout_Rollup.AddrRecDid inRec, advo.key_addr2 cds) := TRANSFORM
     		SELF.a.address_cds.Record_Type_Code := if(inRec.a.address_cds.Lookedup=false,cds.Record_Type_Code,inRec.a.address_cds.Record_Type_Code);
     		SELF.a.address_cds.Record_Type_Description := if(inRec.a.address_cds.Lookedup=false,advo.Lookup_Descriptions.Record_Type_Description_lookup(cds.Record_Type_Code),inRec.a.address_cds.Record_Type_Description);
     		SELF.a.address_cds.Route_Num := if(inRec.a.address_cds.Lookedup=false,cds.Route_Num,inRec.a.address_cds.Route_Num);
     		SELF.a.address_cds.Route_Description := if(inRec.a.address_cds.Lookedup=false,advo.Lookup_Descriptions.Route_Description_lookup(cds.Route_Num),inRec.a.address_cds.Route_Description);
     		SELF.a.address_cds.WALK_Sequence := if(inRec.a.address_cds.Lookedup=false,cds.WALK_Sequence,inRec.a.address_cds.WALK_Sequence);
     		SELF.a.address_cds.Address_Vacancy_Indicator := if(inRec.a.address_cds.Lookedup=false,cds.Address_Vacancy_Indicator,inRec.a.address_cds.Address_Vacancy_Indicator);
     		SELF.a.address_cds.Address_Vacancy_Description := if(inRec.a.address_cds.Lookedup=false,advo.Lookup_Descriptions.Address_Vacancy_Description_lookup(cds.Address_Vacancy_Indicator),inRec.a.address_cds.Address_Vacancy_Description);
     		SELF.a.address_cds.Throw_Back_Indicator := if(inRec.a.address_cds.Lookedup=false,cds.Throw_Back_Indicator,inRec.a.address_cds.Throw_Back_Indicator);
     		SELF.a.address_cds.Seasonal_Delivery_Indicator := if(inRec.a.address_cds.Lookedup=false,cds.Seasonal_Delivery_Indicator,inRec.a.address_cds.Seasonal_Delivery_Indicator);
     		SELF.a.address_cds.Seasonal_Delivery_Description := if(inRec.a.address_cds.Lookedup=false,advo.Lookup_Descriptions.Seasonal_Delivery_Description_lookup(cds.Seasonal_Delivery_Indicator),inRec.a.address_cds.Seasonal_Delivery_Description);
     		SELF.a.address_cds.Seasonal_Start_Suppression_Date := if(inRec.a.address_cds.Lookedup=false,cds.Seasonal_Start_Suppression_Date,inRec.a.address_cds.Seasonal_Start_Suppression_Date);
     		SELF.a.address_cds.Seasonal_End_Suppression_Date := if(inRec.a.address_cds.Lookedup=false,cds.Seasonal_End_Suppression_Date,inRec.a.address_cds.Seasonal_End_Suppression_Date);
     		SELF.a.address_cds.DND_Indicator := if(Length(cds.zip)>0,cds.DND_Indicator,inRec.a.address_cds.DND_Indicator);
     		SELF.a.address_cds.College_Indicator := if(inRec.a.address_cds.Lookedup=false,cds.College_Indicator,inRec.a.address_cds.College_Indicator);
     		SELF.a.address_cds.College_Start_Suppression_Date := if(inRec.a.address_cds.Lookedup=false,cds.College_Start_Suppression_Date,inRec.a.address_cds.College_Start_Suppression_Date);
     		SELF.a.address_cds.College_End_Suppression_Date := if(inRec.a.address_cds.Lookedup=false,cds.College_End_Suppression_Date,inRec.a.address_cds.College_End_Suppression_Date);
     		SELF.a.address_cds.Address_Style_Flag := if(inRec.a.address_cds.Lookedup=false,cds.Address_Style_Flag,inRec.a.address_cds.Address_Style_Flag);
     		SELF.a.address_cds.Drop_Indicator := if(inRec.a.address_cds.Lookedup=false,cds.Drop_Indicator,inRec.a.address_cds.Drop_Indicator);
     		SELF.a.address_cds.Residential_or_Business_Ind := if(inRec.a.address_cds.Lookedup=false,cds.Residential_or_Business_Ind,inRec.a.address_cds.Residential_or_Business_Ind);
     		SELF.a.address_cds.Delivery_Type_Description := if(inRec.a.address_cds.Lookedup=false,advo.Lookup_Descriptions.Delivery_Type_Description_lookup(cds.Residential_or_Business_Ind),inRec.a.address_cds.Delivery_Type_Description);
     		SELF.a.address_cds.County_Num := if(inRec.a.address_cds.Lookedup=false,cds.County_Num,inRec.a.address_cds.County_Num);
     		SELF.a.address_cds.County_Name := if(inRec.a.address_cds.Lookedup=false,cds.County_Name,inRec.a.address_cds.County_Name);
     		SELF.a.address_cds.City_Name := if(inRec.a.address_cds.Lookedup=false,cds.City_Name,inRec.a.address_cds.City_Name);
     		SELF.a.address_cds.State_Code := if(inRec.a.address_cds.Lookedup=false,cds.State_Code,inRec.a.address_cds.State_Code);
     		SELF.a.address_cds.State_Num := if(inRec.a.address_cds.Lookedup=false,cds.State_Num,inRec.a.address_cds.State_Num);
     		SELF.a.address_cds.Congressional_District_Number := if(inRec.a.address_cds.Lookedup=false,cds.Congressional_District_Number,inRec.a.address_cds.Congressional_District_Number);
     		SELF.a.address_cds.Address_Type := if(inRec.a.address_cds.Lookedup=false,cds.Address_Type,inRec.a.address_cds.Address_Type);
     		SELF.a.address_cds.Mixed_Address_Usage := if(inRec.a.address_cds.Lookedup=false,cds.Mixed_Address_Usage,inRec.a.address_cds.Mixed_Address_Usage);
			SELF.a.address_cds.Lookedup := if(inRec.a.address_cds.Lookedup=false,if(Length(Trim(cds.Record_Type_Code,LEFT,RIGHT))>=1,true,false),inRec.a.address_cds.Lookedup);
			SELF := inRec;
		END;

		doxie.Layout_Rollup.AddrRecDid cdsRecombineTransform(doxie.Layout_Rollup.AddrRecDid l, doxie.Layout_Rollup.AddrRecDid r) := TRANSFORM
			SELF.a.address_cds := if(r.a.address_cds.Lookedup=true,r.a.address_cds,l.a.address_cds);
			SELF := l;
		END;

		cdsJ1 := join(addrPhonesDeduped,advo.key_addr1,
			keyed(left.a.zip=right.zip) and keyed(left.a.prim_range=right.prim_range) and
			keyed(left.a.prim_name=right.prim_name) and keyed(left.a.suffix=right.addr_suffix) and
			keyed(left.a.predir=right.predir) and keyed(left.a.postdir=right.postdir) and
			keyed(left.a.sec_range=right.sec_range) and left.a.address_cds.Lookedup=false,
			cdskey1Transform(left,right),left outer, limit (0), Keep(1));
		cdsJ2 := join(cdsJ1,advo.key_addr2,
			keyed(left.a.st=right.st) and keyed(left.a.city_name=right.v_city_name) and
			keyed(left.a.prim_range=right.prim_range) and keyed(left.a.prim_name=right.prim_name) and
			keyed(left.a.sec_range=right.sec_range) and
			left.a.address_cds.Lookedup=false,
			cdskey2Transform(left,right),Left Outer, limit (0), Keep(1));
		addrPhonesDeduped_with_cds := if(include_cds, cdsJ2, addrPhonesDeduped);

		addrNotCnsmrOrdered := sort(addrPhonesDeduped_with_cds,bestTntScore,-MAX(a.first_seen,a.last_seen));
		addrCnsmrOrdered := sort(addrPhonesDeduped_with_cds,bestTntScore, -a.last_seen, -a.dt_vendor_last_reported);
		addrOrdered := IF(ut.IndustryClass.is_knowx, addrCnsmrOrdered, addrNotCnsmrOrdered);
		RETURN addrOrdered;
	END;

	EXPORT dob :=
	FUNCTION
		doxie.Layout_Rollup.DobRecDid extendDobs(indata l) := TRANSFORM
			SELF.did := l.did;
			SELF.penalt := l.penalt;
			SELF.num_compares := 0;
			SELF.d.dob := l.dob;
			SELF.d.age := l.age;
		END;

		dobtbl := PROJECT(indata(dob <> 0), extendDobs(LEFT));
		dobsrtd := SORT(dobtbl,d.dob,-penalt);

		doxie.Layout_Rollup.DobRecDid rollDobs(doxie.Layout_Rollup.DobRecDid le, doxie.Layout_Rollup.DobRecDid ri) := TRANSFORM
			SELF.did := le.did;
			SELF.penalt := MIN(le.penalt, ri.penalt);
			SELF.num_compares := 0;
			SELF.d := ri.d;  // list is sorted, so most complete variation is on the right
		END;

		dobs := ROLLUP(dobsrtd, EquivDates(LEFT.d.dob,RIGHT.d.dob), rollDobs(LEFT,RIGHT));
		RETURN DEDUP(dobs,true,KEEP(rollup_limits.dobs));
	END;


	EXPORT dod :=
	FUNCTION
		doxie.Layout_Rollup.DodRecDid extendDods(indata l) := TRANSFORM
			SELF.did := l.did;
			SELF.penalt := l.penalt;
			SELF.num_compares := 0;
			// establish whether the DOD came from a death source; used to pick the best dead_age when rolling up
			SELF.fromDeathSrc := mdr.SourceTools.SourceIsDeath(l.src);
			SELF.d.dod := l.dod;
			SELF.d.dead_age := l.dead_age;
			SELF.d.deceased := l.deceased;
		END;

		dodtbl := PROJECT(indata(deceased = 'Y'), extendDods(LEFT));
		dodsrtd := SORT(dodtbl,d.dod,fromDeathSrc,-d.dead_age,-penalt);

		doxie.Layout_Rollup.DodRecDid rollDods(doxie.Layout_Rollup.DodRecDid le, doxie.Layout_Rollup.DodRecDid ri) := TRANSFORM
			SELF.did := le.did;
			SELF.penalt := MIN(le.penalt, ri.penalt);
			SELF.num_compares := 0;
			// list is sorted, so most complete dod variation is on the right
			SELF.d.dod := ri.d.dod;
			SELF.d.dead_age := IF(ri.d.dead_age <> 0, ri.d.dead_age, le.d.dead_age);
			SELF.d.deceased := map(le.d.deceased = 'Y' or ri.d.deceased = 'Y' => 'Y',
				le.d.deceased = 'N' or ri.d.deceased = 'N' => 'N',
				'U');
		END;

		dods := ROLLUP(dodsrtd, EquivDates(LEFT.d.dod,RIGHT.d.dod), rollDods(LEFT,RIGHT));
		RETURN DEDUP(dods,true,KEEP(rollup_limits.dods));
	END;

	EXPORT ssn(STRING9 ssn_value) :=
	FUNCTION

		// sort SSNs first by last 4 first to allow for rolling up leading-zero-padded partials
		ssnsrtd := sort(indata (ssn <> ''),ssn[6..9],ssn[1..5]);
		doxie.Layout_Rollup.SsnRecDid extendSsns(ssnsrtd l) := TRANSFORM
			SELF.did := l.did;
			SELF.penalt := l.penalt;
			SELF.num_compares := 0;
			SELF.s.ssn := l.ssn;
			SELF.s.ssn_issue_early := l.ssn_issue_early;
			SELF.s.ssn_issue_last := l.ssn_issue_last;
			SELF.s.ssn_issue_place := l.ssn_issue_place;
			SELF.s.hri_ssn := l.hri_ssn;
			SELF.s.valid_ssn := l.valid_ssn;

			srchedSSNMatch := IF(ssn_value<> '' and ssn_value = l.ssn, true, false);
			SELF.bestSrchedValidSSNScore := IF(srchedSSNMatch, doxie.valid_ssn_score(l.valid_ssn), high_valid_ssn);
		END;
		ssntbl := PROJECT(ssnsrtd, extendSsns(LEFT));

		doxie.Layout_Rollup.SsnRecDid rollSsns(doxie.Layout_Rollup.SsnRecDid le, doxie.Layout_Rollup.SsnRecDid ri) := TRANSFORM
			SELF.did := le.did;
			SELF.penalt := MIN(le.penalt, ri.penalt);
			SELF.num_compares := 0;
			// HRI's not assigned until later
			// SELF.s.hri_ssn := le.s.hri_ssn + ri.s.hri_ssn;
			SELF.s.valid_ssn := IF(le.s.valid_ssn='G' OR ri.s.valid_ssn='G','G',
				IF(doxie.valid_ssn_score(le.s.valid_ssn) <= doxie.valid_ssn_score(ri.s.valid_ssn), le.s.valid_ssn, ri.s.valid_ssn));
			SELF.bestSrchedValidSSNScore := IF(le.bestSrchedValidSSNScore < ri.bestSrchedValidSSNScore, le.bestSrchedValidSSNScore, ri.bestSrchedValidSSNScore);
			keep_left := header.ssn_length(le.s.ssn) >= header.ssn_length(ri.s.ssn);
			SELF.s := if(keep_left, le.s, ri.s);
		END;
		ssns := ROLLUP(ssntbl, ut.NNEQ_SSN(left.s.ssn, right.s.ssn), rollSsns(LEFT,RIGHT));

		RETURN DEDUP(ssns,true,KEEP(rollup_limits.ssns));
	END;

END;