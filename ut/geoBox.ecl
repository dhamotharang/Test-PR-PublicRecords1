// This code improves the efficiency of fetching rows within a certain
// distance of a given lat/lon.  Computing the distance between two
// lat/lon pairs is easy enough, but computing the distance to a known
// point for every row in an entire key is not going to perform well.
// So, what we're doing here is defining a bounding box and fetching
// rows within the bounding box using a simple index lookup.  After
// that we can do the distance computation on a much smaller subset
// of the rows, so it should go a lot faster.

// This is intended for use with rooftop lat/lon computations.  If
// we're working with zip centroid coordinates, we should really use
// some other method.

// Some of this code assumes the Earth is perfectly spherical, which is
// wrong.  Other parts assume the Earth is perfectly flat, which also
// happens to be wrong.  Two wrongs may not make a make a right, but in
// this case hopefully they'll make a "close enough", at least within the
// Continental US.  Maybe ellipsoid formulas would be a good enhancement.

export geoBox := module

	// NOTE: INDEX doesn't support keyed fields of type REAL or DECIMAL!  So, we
	//       will be scaling all lat/long values by 10^6, since we have values to
	//       six places (around a half a foot of error) in the rooftop library.
	export layout_box := record
		integer4 n_Lat;
		integer4 s_Lat;
		integer4 e_Lon;
		integer4 w_Lon;
	end;
	export scale := 1000000;
	
	// Miles per degree of latitude is effectively constant, since it depends only
	// on the polar circumference of the earth and the number of degrees in a circle.
	// However, miles per degree of longitude varies, because the circumference of
	// each circle of latitude gets smaller and smaller as one approaches the poles.
	shared real pi									:= 3.14159265;
	shared real radPerDeg						:= pi / 180.0;
	shared real miAroundEarth				:= 24859.82; // polar circumference of Earth
	shared real miPerLat						:= miAroundEarth / 360.0;
	shared real miPerLon(real lat)	:= miPerLat * cos(abs(lat) * radPerDeg);
	
	// Computes the LatLon coordinates of a box bounding a circle of a
	// certain radius in miles around a given LatLon coordinate
	export layout_box getBox(real lat, real lon, real radius) := function
	
		deltaLat := radius / miPerLat;
		deltaLon := radius / miPerLon(lat);
		
		// NOTE: This behaves badly near the international date line or poles
		n_Lat := (integer4)((lat + deltaLat) * scale);
		s_Lat := (integer4)((lat - deltaLat) * scale);
		e_Lon := (integer4)((lon + deltaLon) * scale);
		w_Lon := (integer4)((lon - deltaLon) * scale);
		
		box := row(
			{ n_Lat, s_Lat, e_Lon, w_Lon },
			layout_box
		);
		
		// output(deltaLat, named('deltaLat'), overwrite);
		// output(deltaLon, named('deltaLon'), overwrite);
		
		return box;
	end;
	
	// NOTE: This behaves badly near the international date line
	export mac_inBox(testLat, testLon, box) := macro
		(
			(testLat between box.s_Lat and box.n_Lat) and
			(testLon between box.w_Lon and box.e_Lon)
		)
	endmacro;

end;