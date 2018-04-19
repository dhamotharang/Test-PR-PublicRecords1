EXPORT MOD_LL := MODULE
IMPORT SALT310;
/*
  NOTE - THIS MODULE IS IN BRAINSTORM STATE. Core capability works but a number of edge conditions have NOT been tested.
  In particular I would NOT trust is crossing the equator or greenwich or at the poles
  ALSO - I am using ECL/Datasets for CORE CAPABILITY that NEEDS to be in C++
  Conside the C++ port as VITAL to a production push
*/
  SHARED EarthRadius := 3963.3453; // In synch with SALT310.utLL_Dist
	SHARED PI := 3.14159;
	EXPORT Distance(REAL8 Lat1,REAL8 Long1, REAL8 Lat2, REAL8 Long2 ) := SALT310.utLL_Dist(lat1,long1,lat2,long2);
// Each degree of latitude is approximately 69 miles (111 kilometers) apart. The range varies (due to the earth's slightly ellipsoid shape) from 68.703 miles (110.567 km) at the equator to 69.407 (111.699 km) at the poles. This is convenient because each minute (1/60th of a degree) is approximately one mile.
  SHARED LatAtEquator := EarthRadius * 2 * PI / 360;
	EXPORT LatToDistance(REAL8 degrees) := degrees * LatAtEquator;
	EXPORT LongToDistance(REAL8 degrees, REAL8 LatitudeAt) := LatAtEquator * COS(PI*LatitudeAt/180) * degrees;
/*
	EXPORT CommonLead(STRING12 l, STRING12 r) := // MORE - THIS IS HORRIBLE - SLIP INTO C++
		WHICH ( r[1] <> l[1], r[2]<>l[2], r[3]<>l[3], r[4]<>l[4], r[5]<>l[5], r[6]<>l[6], r[7]<>l[7], r[8]<>l[8],
	        r[9]<>l[9], r[10]<>l[10], r[11]<>l[11], r[12]<>l[12], true )-1;
*/
  EXPORT UNSIGNED CommonLead(STRING12 l,STRING12 r,UNSIGNED1 prec=12) := BEGINC++
  #option pure
	unsigned lenL = 12;
	unsigned lenR = 12;
  while ( lenL && l[lenL-1]==' ' ) lenL--;
	while ( lenR && r[lenR-1]==' ' ) lenR--; // Trim incoming strings
	unsigned minL = lenL<lenR?lenL:lenR;
	unsigned dist = prec<minL?prec:minL;
	for (unsigned i=0; i<dist; i++)
		if (l[i] != r[i])
			return i;
	return dist;		
 ENDC++;									
// Geohash
	EXPORT Encode(REAL8 lat,REAL8 long,INTEGER1 Prec=12) := GeohashEncode(lat,long,Prec);
	EXPORT Decode(STRING inc) := GeohashDecode(inc);
	EXPORT Neighbor(STRING12 inc, STRING2 dir) := FUNCTION
	  INTEGER1 Dir0 := MAP ( dir IN ['N ','NE','NW'] => 1, dir IN ['S ','SW','SE'] => -1, 0 );
		INTEGER1 Dir1 := MAP ( dir IN ['E ','NE','SE'] => 1, dir IN ['W ','SW','NW'] => -1, 0 );
		RETURN GeohashNeighbor(TRIM(inc),Dir0,Dir1);
	END;
	EXPORT DistanceE(STRING12 e1, STRING12 e2) := FUNCTION
	  D1 := Decode(e1);
		D2 := Decode(e2);
		RETURN Distance(D1[1].latitude,D1[1].longitude,D2[1].latitude,D2[1].longitude);
	END;
	EXPORT LayoutGeoList := { STRING Box, INTEGER1 Overlap := 0 };
	SHARED EGL := RECORD
	  LayoutGeoList;
		REAL tl_latitude;
		REAL tl_longitude;
		REAL br_latitude;
		REAL br_longitude;
	END;
  SHARED MakeBox(string gh, real tl_lat, real tl_lon, real br_lat, real br_lon) := DATASET([ {gh, 0, tl_lat, tl_lon, br_lat, br_lon}	], EGL);
  // Computes left R right - so inside ==> left is smaller
  SHARED OverlapRelation(EGL l, EGL r) := MAP( 
			// disjoint
			l.br_longitude < r.tl_longitude or l.tl_longitude > r.br_longitude or l.br_latitude > r.tl_latitude or l.tl_latitude < r.br_latitude => 2,
			// inside
			l.tl_longitude > r.tl_longitude and l.br_longitude < r.br_longitude and l.tl_latitude < r.tl_latitude and l.br_latitude > r.br_latitude => 1,
			// borderline
			0);						
			
  SHARED AppendBox(DATASET(LayoutGeoList) da) := FUNCTION
		EGL to(da le) := TRANSFORM
		  D := Decode(le.box);
	    SELF.tl_latitude := (REAL) (D[1].latitude+D[1].latitude_err);
	    SELF.tl_longitude := (REAL) (D[1].longitude-D[1].longitude_err);
	    SELF.br_latitude := (REAL) (D[1].latitude-D[1].latitude_err);
	    SELF.br_longitude := (REAL) (D[1].longitude+D[1].longitude_err);
			SELF := le;
		END;
	  RETURN PROJECT(da,to(LEFT));
  END;
	SHARED Base32Codes := '0123456789bcdefghjkmnpqrstuvwxyz';
	// Increase dataset size by 'blowing out' every valid character onto existing geohash
	SHARED LevelNP1(DATASET(LayoutGeoList) d) := FUNCTION
		LayoutGeoList TR(d le,UNSIGNED c) := TRANSFORM
		  SELF.Box := TRIM(le.box)+Base32Codes[c];
		END;
		RETURN NORMALIZE(d,32,TR(LEFT,COUNTER));
	END;
	  SHARED Rect0(STRING12 tl, STRING12 tr, STRING12 bl, STRING12 br, STRING12 mid) := FUNCTION
		trm := CommonLead(tr,mid);
		tre := tr[1..trm];
		blm := CommonLead(bl,mid);
		ble := bl[1..blm];
		tlm := CommonLead(tl,mid);
		tle := tl[1..tlm];
		brm := CommonLead(br,mid);
		bre := br[1..brm];
		best := MAX(trm,blm,tlm,brm);
	  // Vals := DATASET( MAP ( trm = best AND brm = best => [ tre ], <-- missing valid neighbors in some cases, hence change in line below.
		Vals := DATASET( MAP ( trm = best AND brm = best => [ tre, Neighbor(tre,'W'), Neighbor(tre,'SW'), Neighbor(tre,'S') ],  // tre's neighbors appear to be the same as bre's neighbors (?)
		             trm = best => [ tre, Neighbor(tre,'W'), Neighbor(tre,'SW'), Neighbor(tre,'S') ],
		             tlm = best => [ tle, Neighbor(tle,'E'), Neighbor(tle,'SE'), Neighbor(tle,'S') ],
								 brm = best => [ bre, Neighbor(bre,'W'), Neighbor(bre,'NW'), Neighbor(bre,'N') ],
		             [ ble, Neighbor(ble,'E'), Neighbor(ble,'NE'), Neighbor(ble,'N') ] ), {STRING Box} );
		RETURN PROJECT(Vals,LayoutGeoList);						 
	END;
	SHARED SetOverlap( DATASET(EGL) d ) := FUNCTION RETURN d; END;
  SHARED Rect(STRING12 tl, STRING12 tr, STRING12 bl, STRING12 br, STRING12 mid, SetOverlap ov) := FUNCTION
		RETURN ov ( AppendBox( LevelNP1( Rect0(tl,tr,bl,br,mid) )))(Overlap<2);						 
	END;
	EXPORT Rectangle(STRING tl, STRING tr, STRING bl, STRING br) := FUNCTION
	  D1 := Decode(tl);
		D2 := Decode(br);
		e := Encode( (D1[1].latitude+D2[1].latitude)/2, (D1[1].longitude+D2[1].longitude)/2, MIN( LENGTH(TRIM(tl)), LENGTH(TRIM(br))) );
		BBox := MakeBox(e,D1[1].latitude,D1[1].longitude,D2[1].latitude,D2[1].longitude);
    IRect( DATASET(EGL) p ) := FUNCTION
		   RETURN PROJECT( P, TRANSFORM( EGL, SELF.Overlap := OverlapRelation(LEFT,BBox[1]), SELF := LEFT ) );
		END;
		Possibles := Rect(tl,tr,bl,br,e,IRect);
		RETURN Possibles;
	END;
	
	EXPORT PointRadius(STRING12 fr,REAL8 radius, BOOLEAN fast=FALSE) := FUNCTION
	  D := Decode(fr);
		lat_delta := radius / LatToDistance(1); // Degrees to delta
		long_delta := radius / LongToDistance(1,D[1].latitude);
		tla := D[1].latitude+lat_delta;
		tlo := D[1].longitude-long_delta;
		bra := D[1].latitude-lat_delta;
		bro := D[1].longitude+long_delta;
		// Compute function to grade whether or not a box is inside by requirements
		BBox := MakeBox(fr,tla,tlo,bra,bro)[1];
    IRect( DATASET(EGL) p ) := FUNCTION
		   EGL TR( p le ) := TRANSFORM
			   SELF.Overlap := MAP ( OverlapRelation(le,BBox) = 2 => 2,
		// box is inside if all four corners are inside
				                    Distance(D[1].latitude,D[1].longitude,le.tl_latitude,le.tl_longitude) > radius => 0,
			                      Distance(D[1].latitude,D[1].longitude,le.br_latitude,le.br_longitude) > radius => 0,
			                      Distance(D[1].latitude,D[1].longitude,le.tl_latitude,le.br_longitude) > radius => 0,
			                      Distance(D[1].latitude,D[1].longitude,le.br_latitude,le.tl_longitude) > radius => 0, 1 );
			   SELF := le;
			 END;
		   RETURN PROJECT( P, TR(LEFT) );
		END;
		tl := Encode(tla,tlo);
		tr := Encode(tla,bro);
		br := Encode(bra,bro);
		bl := Encode(bra,tlo);
		RETURN IF(fast,AppendBox(Rect0(tl,tr,bl,br,fr)),Rect(tl,tr,bl,br,fr,IRect));
	END;
	
  END;
