IMPORT $,Std,ut, salt32;

EXPORT Polygons := MODULE

/*
***********************************************************************
Record Layouts
***********************************************************************
*/
	export polygon_point_rec := RECORD
    real8   p_lon;
    real8   p_lat;		
	end;
	export point_rec := record
		real8    p_lon;
		real8    p_lat;
		integer4 p_sequence := 0;		
	end;

	export point_rec_gh4 := record
		string4  gh4;
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
	
		EXPORT DATASET(result_rec) checkPoints(dataset(polygon_point_rec) polygon, dataset(point_rec) pts, integer4 algorithm = 0) := 
	TestPoints(polygon, pts, algorithm);
		
	// EXPORT DATASET(polygon_point_rec) fromWKT(string polygonString) := FUNCTION

		// PClean 	:= REGEXREPLACE('^POLYGON|MULTIPOLYGON(\\s)?\\((\\s)?\\(|\\)(\\s)?\\)$',TRIM(STD.Str.touppercase(polygonString), LEFT,RIGHT),'');
		// PPoints := STD.Str.SplitWords(STD.Str.FindReplace(PClean,',',' '),' '); 
		// dCoordS := SORT(PROJECT(DATASET(PPoints, {string coord;}), TRANSFORM(point_rec, SELF.p_lon := (REAL8) LEFT.coord, SELF.p_lat := 0, SELF.p_sequence := COUNTER + COUNTER%2)), p_sequence);
		// dCoordR := ROLLUP(dCoordS, LEFT.p_sequence = RIGHT.p_sequence, TRANSFORM(point_rec, SELF.p_lon := LEFT.p_lon, SELF.p_lat := RIGHT.p_lon, SELF.p_sequence := LEFT.p_sequence));
		// RETURN PROJECT(dCoordR, TRANSFORM(polygon_point_rec, SELF := LEFT));
	// END;

	// This will parse and validate the input polygon based on WKT format: POLYGON (( x0 y0, x1 y1, ... , xn yn ))
	EXPORT DATASET(polygon_point_rec) fromWKT(string polygonString) := FUNCTION
		PClean 	:= REGEXREPLACE('^POLYGON(\\s)?\\((\\s)?\\(|^MULTIPOLYGON(\\s)?\\(\\((\\s)?\\(|\\((\\s)?|\\)(\\s)?|\\)(\\s)?\\)\\)$',TRIM(STD.Str.touppercase(polygonString), LEFT,RIGHT),'');
		PPoints := STD.Str.SplitWords(STD.Str.FindReplace(PClean,',',' '),' '); 
		dCoordS := SORT(PROJECT(DATASET(PPoints, {string coord;}), TRANSFORM(point_rec, SELF.p_lon := (REAL8) LEFT.coord, SELF.p_lat := 0, SELF.p_sequence := COUNTER + COUNTER%2)), p_sequence);
		dCoordR := ROLLUP(dCoordS, LEFT.p_sequence = RIGHT.p_sequence, TRANSFORM(point_rec, SELF.p_lon := LEFT.p_lon, SELF.p_lat := RIGHT.p_lon, SELF.p_sequence := LEFT.p_sequence));
		RETURN PROJECT(dCoordR, TRANSFORM(polygon_point_rec, SELF := LEFT));
	END;

	// This will parse and validate the input polygon based on WKT format: POLYGON (( x0 y0, x1 y1, ... , xn yn ))
	EXPORT DATASET(point_rec_gh4) fromWKT_GH4(string polygonString) := FUNCTION
		
		point_rec_gh4 t_gh4(polygon_point_rec L) := transform
			SELF.GH4 := SALT32.Fn_LatLongEncode(L.p_lat,L.p_lon,4);
		end;
		
		RETURN dedup(sort(project(fromWKT(polygonString),t_gh4(left)),gh4),gh4);
	END;
	
	EXPORT Polygons_String (Pts) := FUNCTIONMACRO
	
		import ut;
		Pts T(Pts L, Pts R) := TRANSFORM
			SELF.polygon := IF(L.polygon!='',regexreplace('POLYGON|MULTIPOLYGON',L.polygon,''),'')  + regexreplace('POLYGON|MULTIPOLYGON',R.polygon,'');
			SELF := R;
		END;

		Ite_Polygons := ITERATE(Pts,T(LEFT,RIGHT));
		last_rec := count(Ite_Polygons);
		polygonString := ut.CleanSpacesAndUpper(Ite_Polygons[last_rec].polygon);
		RETURN polygonString;
	ENDMACRO;
	
	
END;