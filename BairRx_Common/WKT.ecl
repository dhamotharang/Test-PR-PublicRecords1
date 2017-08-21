/*
	WKT

	Entry facade for Polygon search functionality.

	@author 
	@date 2015-10-30

-------------------------------------------------------------------------------------------------------------

Change History:

2015-10-30 : 
* RM #.... :
	- Initial version based on Vlad & Ken's implementation.

-------------------------------------------------------------------------------------------------------------
*/

IMPORT $,Std,ut;

EXPORT WKT := MODULE

	EXPORT Bundle := MODULE(Std.BundleBase)
    EXPORT Name := 'WKT';
    EXPORT Description := 'Set of functions to check if one or more points are within a given polygon.';
    EXPORT Authors := ['Ken Rowland'];
    EXPORT License := '';
    EXPORT Copyright := 'Copyright (C) 2015 LexisNexis Risk Solutions';
    EXPORT DependsOn := [];
    EXPORT Version := '1.0.0';
    EXPORT PlatformVersion := '5.4.0';
  END;

/*
***********************************************************************
Record Layouts
***********************************************************************
*/

	export polygon_point_rec := RECORD
    real8   lon;
    real8   lat;
	end;

	export point_rec := RECORD
    real8    lon;
    real8    lat;
		integer4 sequence := 0;
	end;	
	
	export result_rec := RECORD  (point_rec)
		boolean belongs;
	END;

/*
***********************************************************************
Polygon
***********************************************************************

Uses inline BEGINC++ blocks to encapsulate the C++
*/

	
	//
	// cpp_testPoints
	//
	// Input:
	//   dataset(polygon_point_rec) polygon - a recordset of polygon points representing the polygon
	//   dataset(point_rec) pts             - a recordst of points to test for inclusion in the polygon
	//   integer            algorithm       - indicator of which algorithm to use. The following are defined:
	//                                        0 - default (crossing)
	//                                        1 - crossing
	//                                        2 - winding
	//
	// Output:
	//   dataset(result_rec) - a record set of results 
	//
	// Description:
	//   Tests each point in the input to see if it is in the input polygon or not.
	//
  shared dataset (result_rec) cpp_testPoints (DATASET(polygon_point_rec) polygon, DATASET(point_rec) pts, integer4 algorithm) := BEGINC++ 
		
		#include <stdlib.h> 
		#include <math.h>
		#include <vector>
		
		#pragma pack(push, 1)
		
		#ifndef WKT_POLYPOINT_STRUCT
		#define WKT_POLYPOINT_STRUCT
		const float c_ZeroTolerance = 0.00000001f;
		inline bool isEqual(double a, double b) { return(fabs(a - b) < c_ZeroTolerance); }
		
		struct polygon_point_rec  
		{
			polygon_point_rec(double _lon, double _lat) : lon(_lon), lat(_lat) { }
			bool operator!=(const polygon_point_rec &rt) { return(!(isEqual(lon, rt.lon) && isEqual(lat, rt.lat))); }
			bool operator==(const polygon_point_rec &rt) { return(isEqual(lon, rt.lon) && isEqual(lat, rt.lat)); }
			double lon;
			double lat;
		};
		#endif
		
		struct point_rec {
			// 
			// compareToSegment
			//
			// Input:
			//   polygon_point_rc p0, p1   two polygon points representing a segment of a polygon
			//
			// Output:
			//   >0 if this point is left of the segment p0,p1
			//   =0 if point is on the segment p0,p1
			//   <0 if point is right of the segment p0,p1
			//
			// Calculate the z value of the cross product of the vector from p0 to this point crosses with the
			// vector from p0 to p1. Since these are 2D points, z is 0, thus the calculation is simplified. Using the
			// relation ship between the three points, the cross product direction will determine the location of this point
			// relative to p0 and p1. In case coincendence is required, the z value is returned.
			inline double compareToSegment(const polygon_point_rec &p0, const polygon_point_rec &p1) const
			{
				return ((p1.lon - p0.lon) * (lat - p0.lat) - (lon - p0.lon) * (p1.lat - p0.lat));
			}
			bool operator==(const polygon_point_rec &rt) { return(isEqual(lon, rt.lon) && isEqual(lat, rt.lat)); }
			double lon; 
			double lat;
			int    sequence;
		};
    	
		//
		// Result structure used to build the returned result record set. Note the use of bool which is a single byte
		// type in ECL. This is why we use a pack pragma with a value of 1 to ensure the returned record set only uses a single
		// byte and is not padded to align C data types.
		struct result_rec
		{
			point_rec input;
			bool      belongs;
		};

		#pragma pack(pop)


		//
		// isPointInsideWinding
		//
		// Input:
		//   point_rec         &pt           - reference to the point to test 
		//   polygon_point_rec *pPolygon     - pointer to the polygon (closed)
		//   unsigned          numPolyPoints - number of polygon points in pPolygon
		//
		// Description:
		//   Tests the input point pt to see if it is inside the input polygon. This test is done using
		//   a winding point algorithm. Points on an edge or coincident with a vertex are NOT considered
		//   inside the polygon. Polygon point order is not important.
		//
		bool isPointInsideWinding(const point_rec &pt, const polygon_point_rec *pPolygon, unsigned numPolyPoints)
		{
			int    wn = 0;    // the  winding number counter
			
			//
			// Make sure we have at least 4 points, the min required for a closed polygon, and that it is in fact closed
			if (numPolyPoints < 4)
			{
				return(false);
			}

			// loop through all edges of the polygon
			for (unsigned i=0; i < numPolyPoints-1; ++i)    // edge from V[i] to  V[i+1]
			{
				// In case we need to count point on vertex as inside, do the test right away
				//if (P == polygon[i])
				//	return(true);

				if (pPolygon[i].lat <= pt.lat)           // start lat <= P.lat
				{
					if (pPolygon[i+1].lat > pt.lat)      // an upward crossing
					{
						if (pt.compareToSegment(pPolygon[i], pPolygon[i+1]) > 0)  // pt left of  edge
							++wn;            // have  a valid up intersect 
					}
				}
				else                         // start lat > P.lat (no test needed)
				{
					if (pPolygon[i+1].lat <= pt.lat)     // a downward crossing
					{
						if (pt.compareToSegment(pPolygon[i], pPolygon[i+1]) < 0)  // pt right of  edge
							--wn;            // have  a valid down intersect
					}
				}
			}
			return(wn!=0);
		}
		
		//
		// isPointInsideCrossing
		//
		// Input:
		//   point_rec         &pt           - reference to the point to test 
		//   polygon_point_rec *pPolygon     - pointer to the polygon (closed)
		//   unsigned          numPolyPoints - number of polygon points in pPolygon
		//
		// Description:
		//   Tests the input point pt to see if it is inside the input polygon. This test is done using
		//   a crossing point algorithm. In addition, if a point is on and edge or coincident with a
		//   polygon vertex, it is currently considered inside. 
		//
		bool isPointInsideCrossing(point_rec &pt, const polygon_point_rec *pPolygon, unsigned numPolyPoints)
		{
			bool inside = false;								

			//
			// Make sure we have at least 4 points, the min required for a closed polygon, and that it is in fact closed
			if (numPolyPoints < 4)
			{
				return(false);
			}

			// loop through all edges of the polygon
			for (unsigned i = 0; i < numPolyPoints - 1; ++i)
			{
				//
				// Is pt on this vertex
				if (pt == pPolygon[i])
					return(true);

				if (pPolygon[i].lat <= pt.lat && pPolygon[i + 1].lat >  pt.lat ||  // upward crossing
					  pPolygon[i].lat >  pt.lat && pPolygon[i + 1].lat <= pt.lat)    // downward crossing
				{
					double vt = (pt.lat - pPolygon[i].lat) / (pPolygon[i + 1].lat - pPolygon[i].lat);
					double plon = pPolygon[i].lon + vt * (pPolygon[i + 1].lon - pPolygon[i].lon);

					// on an edge ?
					if (isEqual(plon, pt.lon))
						return(true);

					// is pt to the left, then there is a cross, toggle the inside flag
					if (pt.lon < plon)
						inside = !inside;
				}
			}
			return(inside);
		}

		#body
		
		//
		// Pointer to the polygon and number of points
		struct polygon_point_rec *pPolygon = static_cast<struct polygon_point_rec *>(polygon);
		unsigned polygonSize = lenPolygon / sizeof(polygon_point_rec);
		
		//
		// Input points to test
		struct point_rec *pPts = static_cast<struct point_rec *>(pts);
		unsigned numTestPoints = lenPts / sizeof(point_rec);
		
		//
		// Results
		__lenResult = numTestPoints * sizeof(result_rec);
		__result = rtlMalloc(__lenResult);
		struct result_rec *pResults = (struct result_rec *)__result;

		//
		// Based on the algorithm selected, loop through the points, testing each one
		if (algorithm==0 || algorithm==1)
		{
			for (unsigned n=0; n<numTestPoints; ++n)
			{
				pResults[n].input = pPts[n];
				pResults[n].belongs = isPointInsideCrossing(pPts[n], pPolygon, polygonSize);
			}
		}
		else
		{
			for (unsigned n=0; n<numTestPoints; ++n)
			{
				pResults[n].input = pPts[n];
				pResults[n].belongs = isPointInsideWinding(pPts[n], pPolygon, polygonSize);
			}
		}


  ENDC++;


  // Checks which of the input points belong to a polygon
  EXPORT dataset(result_rec) TestPoints(dataset(polygon_point_rec) polygon, dataset(point_rec) pts, integer4 algorithm=0) := FUNCTION
    RETURN cpp_testPoints(polygon, pts, algorithm);
  END;
	
  // Checks a single point as to whether it is inside the input polygon or not
  EXPORT boolean TestPoint(dataset(polygon_point_rec) polygon, real8 longitude, real8 latitude, algorithm=0) := FUNCTION
	  testpt := dataset([{longitude, latitude, 0}], point_rec);
		results := TestPoints(polygon, testpt, algorithm);
    RETURN results[1].belongs;
  END;

/*
***********************************************************************
Polygon
***********************************************************************
*/
EXPORT Polygon := MODULE

	EXPORT BOOLEAN isPointWithin(dataset(polygon_point_rec) polygon, REAL8 latitude, REAL8 longitude, integer4 algorithm = 0) := 
		TestPoint(polygon, longitude, latitude, algorithm);
	
	EXPORT DATASET(result_rec) checkPoints(dataset(polygon_point_rec) polygon, dataset(point_rec) pts, integer4 algorithm = 0) := 
		TestPoints(polygon, pts, algorithm);

	// This will parse and validate the input polygon based on WKT format: POLYGON (( x0 y0, x1 y1, ... , xn yn ))
	EXPORT DATASET(polygon_point_rec) fromWKT(string polygonString) := FUNCTION
		PClean 	:= REGEXREPLACE('^POLYGON(\\s)?\\((\\s)?\\(|\\)(\\s)?\\)$',TRIM(STD.Str.touppercase(polygonString), LEFT,RIGHT),'');
		PPoints := STD.Str.SplitWords(STD.Str.FindReplace(PClean,',',' '),' '); 
		dCoordS := SORT(PROJECT(DATASET(PPoints, {string coord;}), TRANSFORM(point_rec, SELF.lon := (REAL8) LEFT.coord, SELF.lat := 0, SELF.sequence := COUNTER + COUNTER%2)), sequence);
		dCoordR := ROLLUP(dCoordS, LEFT.sequence = RIGHT.sequence, TRANSFORM(point_rec, SELF.lon := LEFT.lon, SELF.lat := RIGHT.lon, SELF.sequence := LEFT.sequence));
		RETURN PROJECT(dCoordR, TRANSFORM(polygon_point_rec, SELF := LEFT));
	END;
		
	EXPORT IsValidWKT(string p) := FUNCTION 
		PP := fromWKT(p);
		N := COUNT(PP);
		validCoordinates := N>0 AND ~EXISTS(PP(lat=0 OR lon=0)); // any coord with lat or lon 0 will be considered invalid
		hasMinCoordinates := N>=4; // need at least 4 points to define a closed polygon	
		isClosedPolygon := PP[1].lat = PP[N].lat AND PP[1].lon = PP[N].lon; // 1st coordinate must be the same as the last one, so it is a closed polygon
		RETURN (LENGTH(TRIM(p, LEFT, RIGHT))>0 AND validCoordinates AND hasMinCoordinates AND isClosedPolygon);
	END;
	
	EXPORT SET OF REAL8 MinXY_MaxXY(dataset(polygon_point_rec) polygon) := [MIN(polygon, lon), MIN(polygon, lat), MAX(polygon, lon), MAX(polygon, lat)];

	EXPORT SET OF REAL8 Centroid(STRING polygonString) := FUNCTION
		box := MinXY_MaxXY(fromWKT(polygonString));
		minX := box[1];
		minY := box[2];		
		maxX := box[3];
		maxY := box[4];		
		RETURN [minX + (maxX - minX)/2, minY + (maxY - minY)/2];
	END;
	
END;

/*
***********************************************************************
Convenience functions
***********************************************************************
*/
EXPORT BoxAsPolygon(REAL MinLat, REAL MinLon, REAL MaxLat, REAL MaxLon) := 'POLYGON (('+minLon+' '+maxLat+','+minLon+' '+minLat+','+maxLon+' '+minLat+','+maxLon+' '+maxLat+','+minLon+' '+maxLat+'))'; 
EXPORT BoundingBoxPolygon(STRING polygonString) := FUNCTION
	box := Polygon.MinXY_MaxXY(Polygon.fromWKT(polygonString));
	RETURN BoxAsPolygon(box[2], box[1], box[4], box[3]);
END;	
EXPORT BoundingBoxCircle(REAL lat, REAL lon, REAL radius) := FUNCTION
	box := ut.geoBox.getBox(lat, lon, radius);
	// Note: getbox() scales the coordinates to integer4 and here we want to preserve real values.
	maxY := box.n_lat/ut.geoBox.scale;
	minY := box.s_lat/ut.geoBox.scale;
	minX := box.e_lon/ut.geoBox.scale;
	maxX := box.w_lon/ut.geoBox.scale;
	RETURN BoxAsPolygon(minY, minX, maxY, maxX);
END;
EXPORT Point(REAL lat, REAL lon) := 'POINT ('+lat+' '+lon+')';
EXPORT PointAsPolygon(REAL lat, REAL lon) := 'POLYGON (('+lon+' '+lat+','+lon+' '+lat+','+lon+' '+lat+','+lon+' '+lat+','+lon+' '+lat+'))';	
EXPORT PointBoxAsMultiPolygon(REAL lat, REAL lon, REAL MinLat, REAL MinLon, REAL MaxLat, REAL MaxLon) := 'MULTIPOLYGON ('+
	'(('+minLon+' '+maxLat+','+minLon+' '+minLat+','+maxLon+' '+minLat+','+maxLon+' '+maxLat+','+minLon+' '+maxLat+'))'+
	IF(lat<>0 AND lon<>0,',(('+lon+' '+lat+','+lon+' '+lat+','+lon+' '+lat+','+lon+' '+lat+','+lon+' '+lat+'))', '')+
	')';	
EXPORT PointBoxesAsMultiPolygon(REAL lat, REAL lon, REAL MinLat1, REAL MinLon1, REAL MaxLat1, REAL MaxLon1, REAL MinLat2, REAL MinLon2, REAL MaxLat2, REAL MaxLon2) := 
	'MULTIPOLYGON ('
	+IF(lat<>0 AND lon<>0,'(('+lon+' '+lat+','+lon+' '+lat+','+lon+' '+lat+','+lon+' '+lat+','+lon+' '+lat+')),', '')
	+'(('+minLon1+' '+maxLat1+','+minLon1+' '+minLat1+','+maxLon1+' '+minLat1+','+maxLon1+' '+maxLat1+','+minLon1+' '+maxLat1+')),'
	+'(('+minLon2+' '+maxLat2+','+minLon2+' '+minLat2+','+maxLon2+' '+minLat2+','+maxLon2+' '+maxLat2+','+minLon2+' '+maxLat2+'))'
	+')';	
END;