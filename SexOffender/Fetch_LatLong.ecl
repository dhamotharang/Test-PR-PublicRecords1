import doxie, AutoKey, ut, AutoKeyI;

// We're looking for records within a certain distance of a central point.
// In other words, we want to identify all points within a circle of a
// specified radius.  The brute-force approach to that is very inefficient,
// so we have two tricks to make this fetch run faster:
//
// First, we define a bounding box around the circle.  All points in the
// circle must be in that bounding box, and we can test for that very
// efficiently (it's keyed).  That quickly narrows down to a list of
// candidate points requiring further testing.
//
// Second, we define an inscribed square within the circle.  Testing
// whether candidate points are in the inscribed square can be done
// very efficiently and short-circuit the more expensive distance test.

export Fetch_LatLong(string t, boolean workHard, boolean noFail = true) := function

	doxie.MAC_Header_Field_Declare()
	targetLat			:= location_value.latitude;
	targetLong		:= location_value.longitude;
	targetRadius	:= zipradius_value;
	outerBox			:= ut.geoBox.getBox(targetLat, targetLong, targetRadius);
	innerBox			:= ut.geoBox.getBox(targetLat, targetLong, (targetRadius / sqrt(2.0)));

	ds	:= dataset([], SexOffender.layout_LatLong);
	idx	:= index(ds, {ds}, t + 'LatLong_'+doxie.Version_SuperKey);
	
	castFname := trim(ut.cast2keyfield(idx.fname,fname_value));
	
	// this is a little expensive (and un-keyable), so we want to call it as infrequently as possible
	// distance(real recLat, real recLong) := ut.LL_Dist(targetLat, targetLong, recLat/ut.geoBox.scale, recLong/ut.geoBox.scale);
	boolean withinCircle(real recLat, real recLong) := 
		(ut.LL_Dist(targetLat, targetLong, recLat/ut.geoBox.scale, recLong/ut.geoBox.scale) <= targetRadius);
	
	f_raw := idx(
		// should we bother?
		SearchAroundAddress_value AND targetLat<>0 AND targetLong<>0 AND targetRadius<>0,
		
		// bounding box test (keyed), then either inscribed box or circle test (unkeyed)
		keyed(ut.geoBox.mac_inBox(lat, long, outerBox)),
		ut.geoBox.mac_inBox(lat, long, innerBox) OR withinCircle(lat,long),
		// NOTE: I've grouped the bounding box and circle tests here for clarity, but keep in mind
		//       that at run-time the other keyed filters (below) will execute before the unkeyed
		//       circle test.  This is a good thing, of course, because we want to reduce the
		//       candidate records as much as possible before having to use ut.LL_Dist repeatedly.
		
		// match other fields ala AutoKeyI.FetchI_Indv_Zip
		keyed(dph_lname=metaphonelib.DMetaPhone1(lname_value)[1..6] OR (lname_value='' and workHard)),
		keyed((lname in lname_set_value_20 OR ((phonetics OR lname_value='') and workHard))),
		keyed(AutoKeyI.Functions.PrefFirstMatch(pfname,fname_value) OR (LENGTH(TRIM(fname_value))<2) and workHard),
		keyed(fname[1..length(castFname)]=castFname OR nicknames), 
		keyed(yob>=(unsigned2)find_year_low AND 
				yob<=IF((unsigned2)find_year_high != 0, (unsigned2)find_year_high, (unsigned2)0xFFFF)),
		find_month=0	or ((dob div 100) % 100) in [0, 1, find_month],
		find_day=0		or (dob % 100) in [0, 1, find_day],
		prev_state_val1='' or ut.bit_test(states,ut.St2Code(prev_state_val1)),
		prev_state_val2='' or ut.bit_test(states,ut.St2Code(prev_state_val2)),
		other_lname_value1[1]='' or ut.bit_test(lname1,ut.Chr2Code(other_lname_value1[1])),
		other_lname_value1[2]='' or ut.bit_test(lname2,ut.Chr2Code(other_lname_value1[2])),
		other_lname_value1[3]='' or ut.bit_test(lname3,ut.Chr2Code(other_lname_value1[3])),
		other_city_value[1]='' or ut.bit_test(city1,ut.Chr2Code(other_city_value[1])),
		other_city_value[2]='' or ut.bit_test(city2,ut.Chr2Code(other_city_value[2])),
		other_city_value[3]='' or ut.bit_test(city3,ut.Chr2Code(other_city_value[3])),
		rel_fname_value1[1]='' or ut.bit_test(rel_fname1,ut.Chr2Code(rel_fname_value1[1])),
		rel_fname_value1[2]='' or ut.bit_test(rel_fname2,ut.Chr2Code(rel_fname_value1[2])),
		rel_fname_value1[3]='' or ut.bit_test(rel_fname3,ut.Chr2Code(rel_fname_value1[3])),
		rel_fname_value2[1]='' or ut.bit_test(rel_fname1,ut.Chr2Code(rel_fname_value2[1])),
		rel_fname_value2[2]='' or ut.bit_test(rel_fname2,ut.Chr2Code(rel_fname_value2[2])),
		rel_fname_value2[3]='' or ut.bit_test(rel_fname3,ut.Chr2Code(rel_fname_value2[3])),
		ut.bit_test(lookups, lookup_value)
		// NOTE: Not all of the secondary filters (e.g. other_lname, other_city) are needed
		//       in the initial roll-out of sex offender search.  However, this code is being
		//       written with the intent to use it more generally, and as such we'll probably
		//       be moving it into some central location in the near future.
	);

	f := project(f_raw, transform(AutoKey.layout_fetch,self:=left));
	
	AutoKey.mac_Limits(f,f_ret);
	
	// DEBUG
	// output(targetLat,			named('targetLat'));
	// output(targetLong,		named('targetLong'));
	// output(targetRadius,	named('targetRadius'));
	// output(targetBox,			named('targetBox'));
	// output(f_raw,					named('f_raw'));
	
	return f_ret;

end;