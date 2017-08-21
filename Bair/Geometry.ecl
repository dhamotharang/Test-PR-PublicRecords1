/*
	Geometry

	Entry facade for all GeoSpatial functionality backed by external libraries, GDAL/OGR, GEOS, and PROJ.4

	@author afarrell
	@date 2014-03-27

-------------------------------------------------------------------------------------------------------------

Change History:

2015-01-19 : Andrew Farrell :
* RM #11274,#11814 : 
    -Added RTreeMetaLayout to record max levels for each Rtree
    -refactored Rtree.SearchRTreePayloadIndex to support using prebaked max levels

2015-01-12 : Andrew Farrell :
* RM #11438 : added RTree support for payload indexes using feature attributes

2014-11-08 : Jason Moore :
* changed some types and functions allow for better index  usage

2014-11-11 : Andrew Farrell :
* RM Bug #11052 Possible bug in LoadGMLDataset

2014-11-19 : Andrew Farrell : 
* added health check Geometry.isSpatialWorkingand Geometry.failIfSpatialNotWorking
* added Geometry.UnionCollection

2014-12-02 : Andrew Farrell :
* #11206 Logic error in Spatial Filters : Geometry.ExtLibSpatial.hasSpatialRelation
* #11205 Add #option once to all inline c++ methods
* #11233 Southern Hemisphere UTM SRID Error
* Reformatted change history and changed dates to ISO format
* Reviewed by IC

2014-12-04 : Ignacio Calvo :
* #11217 Covea: met_uk gust peril value truncated : add support for real values in raster.
* #11216 Support for WGS84 rasters : add support for real input parameters.
* Reviewed by AF

2015-06-15 : Ricardo dos Santos :
* added partition id to support R-Tree dataset distribution on thor nodes.
-------------------------------------------------------------------------------------------------------------
*/


IMPORT $,Std;

EXPORT Geometry:= MODULE

  EXPORT Bundle := MODULE(Std.BundleBase)
    EXPORT Name := 'Geometry';
    EXPORT Description := 'A collection of Geo-Spatial/Computational-Geometry functions exposed by GDAL/OGR, GEOS, and PROJ.4';
    EXPORT Authors := ['Andrew Farrell'];
    EXPORT License := '';
    EXPORT Copyright := 'Copyright (C) 2014 LexisNexis Risk Solutions';
    EXPORT DependsOn := [];
    EXPORT Version := '1.0.0';
    EXPORT PlatformVersion := '5.2.0';
  END;

	EXPORT WGS84_SRID := 4326; 
	EXPORT UTMZ16N_SRID := 32616; 
	
/*
***********************************************************************
Record Layouts
***********************************************************************
*/
  
	/*
		All Record layouts that want to use this Geometry MODULE should ideally inherit this layout
	*/
	EXPORT Layout := RECORD
		//STRING GEOM {BLOB} := '';
		STRING50 GEOM := '';
	END;
  
  EXPORT GeometryLayout := Layout; // synonym just for clarity
  
  // Bounds for each Geometry
  EXPORT BBOXIndexLayout := RECORD
			INTEGER4 BBOXMinX := -1;
			INTEGER4 BBOXMinY := -1;
			INTEGER4 BBOXMaxX := -1;
			INTEGER4 BBOXMaxY := -1;			
  END;
	
  // This layout is used to represent the bounding box for each vector geometry or geo raster
  // the Min,Max X,Y are used to create an index and allows window queries. Useful to prune
  // the base search base before doing anything more intensive like a point in polygon etc...
  EXPORT BoundingBoxLayout := RECORD
			STRING150 BBOX := ''; // WKT 5 point closed polygon
      BBOXIndexLayout;			
	END;
	
	EXPORT LayoutWithBoundingBox := RECORD
		Layout;
		BoundingBoxLayout;
	END;
  
  EXPORT BBOXIndexLayout__Fpos := RECORD
			BBOXIndexLayout;
      UNSIGNED8 __Fpos;
  END;
  
  // Layouts used with Rtree Spatial index
  
  EXPORT BBOXIndexLayout__FposOfDset := RECORD
			BBOXIndexLayout;
      UNSIGNED8 dsFpos;
  END;
	
	EXPORT BBOXIndexLayout__PartFposOfDset := RECORD
			integer4 PartitionID;
			BBOXIndexLayout__FposOfDset;
  END;
	
  EXPORT RTreeIndexLayout := RECORD
    INTEGER4 nodeId;
    INTEGER4 parentNodeId;
    INTEGER4 level3ParentNodeId;
    INTEGER4 level4ParentNodeId;
    BBOXIndexLayout__FposOfDset;
    INTEGER4 level;
    INTEGER2 nodetype;		
  END;
  
  EXPORT RTreeIndexGeomLeafLayout := RECORD
    RTreeIndexLayout;
    // STRING GEOM {BLOB};
		// STRING150 GEOM;
		GeometryLayout;
  END;
  
  EXPORT ParentChildRtreeIndexLayout_Keys := RECORD
    RTreeIndexLayout.parentNodeId;
    RTreeIndexLayout.BBOXMinX;
    RTreeIndexLayout.BBOXMinY;
    RTreeIndexLayout.BBOXMaxX;
    RTreeIndexLayout.BBOXMaxY;
  END;
  
  EXPORT ParentChildRtreeIndexLayout_Payload := RECORD
    RTreeIndexLayout.nodeId;
    RTreeIndexLayout.dsFpos;
    UNSIGNED8 __fpos;
    RTreeIndexLayout.level;
    RTreeIndexLayout.nodetype;
  END;
  
  EXPORT ParentChildRtreeIndexLayout := RECORD
    ParentChildRtreeIndexLayout_Keys;
    ParentChildRtreeIndexLayout_Payload;
  END;
  
  EXPORT ParentChildRtreeIndexGeomLeafLayout := RECORD
    integer4 nodeid;
    integer4 parentnodeid;
    integer4 level3parentnodeid;
    integer4 level4parentnodeid;
    integer4 bboxminx;
    integer4 bboxminy;
    integer4 bboxmaxx;
    integer4 bboxmaxy;
    unsigned8 dsfpos;
    integer4 level;
    integer2 nodetype;
		GeometryLayout;
  END;
  
  EXPORT RTreeMetaLayout := RECORD
    INTEGER2 maxLevels;
  END;
  
/*
***********************************************************************
File Formats Module
***********************************************************************

Encapsulates details pertaining to current and future geometry formats that will be supported
*/
EXPORT FileFormat := MODULE

	EXPORT GeometryFormat := ENUM 
	(
		WKT = 0,
		GML = 1
	);
	
	
END;
  
/*
***********************************************************************
ExtLibSpatial
***********************************************************************

Inline interface to GDAL/OGR,GEOS,PROJ.4 library functions

Uses inline BEGINC++ blocks to encapsulate the C++
*/
  
EXPORT ExtLibSpatial := MODULE

 /* bbox
                   
		 Get the Minimum bounding rectangle/Bounding Box for a given geometry defined using Well Known Text
		 using the projection defined by SRID
 */
 EXPORT STRING bbox(STRING  geom, STRING srs) := 
 BEGINC++
  #option library 'geos'
  #option library 'proj'
  #option library 'gdal'
  // #option once : Indicates the function has no side effects and is evaluated at query execution time, even if the parameters are constant, allowing the optimizer to make more efficient calls to the function in some cases.
  #option once

  #include <iostream>
  #include <sstream>
  #include <string>
  #include "ogrsf_frmts.h" // GDAL
  #include "cpl_conv.h"
  #include "gdal_priv.h"
  #include <math.h>       /* ceil */
  
  using namespace std;
    
  #body

  OGRGeometry *thisGeom;
  OGREnvelope env;

  char* wktIn = (char*) geom;

  // determine the spatial reference details
	char* wktSRSIn = (char*) srs;
  OGRSpatialReference * poSRS = new OGRSpatialReference(NULL);
  poSRS->importFromWkt(&wktSRSIn);
  

  // create geometry from given WKT
  OGRErr err = OGRGeometryFactory::createFromWkt(&wktIn, poSRS, &thisGeom);

  // generate BBOX
  thisGeom->getEnvelope(&env);

  // format as wktOut Polygon
  stringstream wktOut;
  wktOut << "POLYGON (( ";
  if(poSRS->IsGeographic()){
    wktOut << env.MinX << " " << env.MaxY << ", ";
    wktOut << env.MinX << " " << env.MinY << ", ";
    wktOut << env.MaxX << " " << env.MinY << ", ";
    wktOut << env.MaxX << " " << env.MaxY << ", ";
    wktOut << env.MinX << " " << env.MaxY;
  }
  else{ 
    // for cartesian systems the bounding box should round down for minimums
    // and round up for maximums, so that the bounding box window might be
    // slighly larger than a convex hull equivalent, but should hopefully
    // avoid missing out on some points when searching windows based on slight
    // precision offsets.
    
    wktOut.setf(ios::fixed, ios::floatfield); // set fixed floating format
    wktOut.precision(0); // for fixed format, set precision
    wktOut << floor(env.MinX) << " " << ceil(env.MaxY) << ", ";
    wktOut << floor(env.MinX) << " " << floor(env.MinY) << ", ";
    wktOut << ceil(env.MaxX) << " " << floor(env.MinY) << ", ";
    wktOut << ceil(env.MaxX) << " " << ceil(env.MaxY) << ", ";
    wktOut << floor(env.MinX) << " " << ceil(env.MaxY) ;
  }
  wktOut << " ))";
  
  // free resources
  OGRSpatialReference::DestroySpatialReference(poSRS);
  OGRGeometryFactory::destroyGeometry(thisGeom);

  size32_t len = wktOut.str().length();

  // copy string into a char array
  char * out = (char *) malloc(len);
  for(unsigned i=0; i < len; i++) {
      out[i] = wktOut.str().c_str()[i];
  }

  //return result to ECL
  __result = out;

  // set length of return string
  __lenResult = len;

 ENDC++;
  
 /* convexHull
                   
		 Get the convex hull for a given geometry collection defined using Well Known Text
		 using the projection defined by SRID
 */
 export string convexHull(const string  geom1,  const STRING srs1):=
 BEGINC++
 
  #option library 'geos'
  #option library 'proj'
  #option library 'gdal'

  #include <iostream>
  #include <sstream>
  #include <string>
  #include "ogrsf_frmts.h" // GDAL
  #include "cpl_conv.h"
  #include "gdal_priv.h"
  // #option once : Indicates the function has no side effects and is evaluated at query execution time, even if the parameters are constant, allowing the optimizer to make more efficient calls to the function in some cases.
  #option once

  using namespace std;

  #body

  OGRGeometry *thisGeom;
  OGRGeometry *convexHullGeom;
  char *wktOut;
  char* wktIn = (char*) geom1;

  // determine the spatial reference details
	char* wktSRSIn = (char*) srs1;
  OGRSpatialReference * poSRS = new OGRSpatialReference(NULL);
  poSRS->importFromWkt(&wktSRSIn);
	
  // Create a geoemtry from given WKT
  OGRErr err = OGRGeometryFactory::createFromWkt(&wktIn, poSRS, &thisGeom);

  // generate convex hull
  convexHullGeom = thisGeom->ConvexHull();

  // export to WKT
  convexHullGeom->exportToWkt(&wktOut);

  // copy string into a char array
  unsigned len = strlen(wktOut);
  char * out = (char *) malloc(len);
  for(unsigned i=0; i < len; i++) {
      out[i] = wktOut[i];
  }

  // free resources
  free(wktOut);
  OGRSpatialReference::DestroySpatialReference(poSRS);
  OGRGeometryFactory::destroyGeometry(thisGeom);
  OGRGeometryFactory::destroyGeometry(convexHullGeom);

  //return result to ECL
  __result = out;

  // set length of return string
  __lenResult = len;

 ENDC++;
 
/*
buffer

@param geom1 the geometry to generate the buffer from
@param dist the distance in all directions that the buffere should pad out to...unit is depdendent on projection
@param srs1 the Spatial reference
*/
  export string buffer(const string  geom1,  REAL8 dist, const STRING srs1):=
 BEGINC++
  #option library 'geos'
  #option library 'proj'
  #option library 'gdal'
  
  // #option once : Indicates the function has no side effects and is evaluated at query execution time, even if the parameters are constant, allowing the optimizer to make more efficient calls to the function in some cases.
  #option once

  #include <iostream>
  #include <sstream>
  #include <string>
  #include "ogrsf_frmts.h" // GDAL
  #include "cpl_conv.h"
  #include "gdal_priv.h"

  using namespace std;

  #body
  
OGRGeometry *thisGeom;
    OGRGeometry *bufferGeom;
    char *wkt;
	char* wktIn = (char*) geom1;

  // determine the spatial reference details
	char* wktSRSIn = (char*) srs1;
  OGRSpatialReference * poSRS = new OGRSpatialReference(NULL);
  poSRS->importFromWkt(&wktSRSIn);
	
 
    // Create a geoemtry from given WKT
    OGRErr err = OGRGeometryFactory::createFromWkt(&wktIn, poSRS, &thisGeom);

    bufferGeom = thisGeom->Buffer(dist, 10);

    bufferGeom->exportToWkt(&wkt);

    unsigned len = strlen(wkt);

    // copy string into a char array
    char * out = (char *) malloc(len);
    for(unsigned i=0; i < len; i++) {
        out[i] = wkt[i];
    }

  //return result to ECL
  __result = out;

  // set length of return string
  __lenResult = len;

    free(wkt);
    OGRSpatialReference::DestroySpatialReference(poSRS);
    OGRGeometryFactory::destroyGeometry(thisGeom);
    OGRGeometryFactory::destroyGeometry(bufferGeom);

 ENDC++;
 
 
/* hasSpatialRelation
	 
	 Do the two given WKT geometries have at least one of the expected relations defined in relationTypeORBits [a single INT containing OR'd bits]

   @see <a href="http://en.wikipedia.org/wiki/DE-9IM">Wikipedia</a>

   usage:
   hasSpatialRelation("POINT(? ?)","POLYGON((? ?,? ?,? ?,? ?,? ?))", rel.WITHIN | rel.OVERLAPS, SRS(4326));    


   @param geom1 STRING containing a WKT geometry, left side of predicate assertion
   @param geom2 STRING containing a WKT geometry, right side of predicate assertion
   @param rel INTEGER contains one or more bits representing what spatial relations should be evaluated
   @param srs the WKT Spatial reference details as got from Operation.SRS
*/
EXPORT boolean hasSpatialRelation(const string  geom1, const string  geom2, INTEGER rel, STRING srs):=
BEGINC++
	#option library 'geos'
	#option library 'proj'
	#option library 'gdal'
  
  // #option once : Indicates the function has no side effects and is evaluated at query execution time, even if the parameters are constant, allowing the optimizer to make more efficient calls to the function in some cases.
  #option once

	#include <iostream>
	#include <sstream>
	#include <string>
	#include "ogrsf_frmts.h" // GDAL
	#include "cpl_conv.h"
	#include "gdal_priv.h"

	/**
	Enumeration of all supported relation types
	*/
	namespace RelationType {
			enum SpatialPredicate {
					INTERSECTS = 1 << 0,
					TOUCHES = 1 << 1,
					DISJOINT = 1 << 2,
					CROSSES = 1 << 3,
					WITHIN = 1 << 4,
					CONTAINS = 1 << 5,
					OVERLAPS = 1 << 6,
					EQUALS = 1 << 7
			};

			bool isBitwiseSpatialPredicate(int packedInteger, RelationType::SpatialPredicate predicate) {
					return (packedInteger & predicate) == predicate ;
			}
	}

	using namespace std;

	#body

  // determine the spatial reference details
	char* wktSRSIn = (char*) srs;
  OGRSpatialReference * poSRS = new OGRSpatialReference(NULL);
  poSRS->importFromWkt(&wktSRSIn);

	bool hasAtLeastOneValidRelation = false;

	char* wktInLeft = (char*) geom1;
	char* wktInRight = (char*) geom2;

	OGRGeometry *leftOGRGeom;
	OGRGeometry *rightOGRGeom;

	bool loadedOK = false;
	OGRErr err =  NULL;

  // parse geom 1
	err = OGRGeometryFactory::createFromWkt(&wktInLeft, poSRS, &leftOGRGeom);
	loadedOK = (err == OGRERR_NONE);

	if(loadedOK) {
      // parse geom 2
			err = OGRGeometryFactory::createFromWkt(&wktInRight, poSRS, &rightOGRGeom);
			loadedOK = (err == OGRERR_NONE);

			if(loadedOK) {
          // assert if a relation exists
					int relationTypePackedBitwise = rel;
          if( !hasAtLeastOneValidRelation && RelationType::isBitwiseSpatialPredicate(relationTypePackedBitwise , RelationType::INTERSECTS)) {
            hasAtLeastOneValidRelation = leftOGRGeom->Intersects(rightOGRGeom);
          } 

          if( !hasAtLeastOneValidRelation && RelationType::isBitwiseSpatialPredicate(relationTypePackedBitwise , RelationType::TOUCHES)) {
            hasAtLeastOneValidRelation = leftOGRGeom->Touches(rightOGRGeom);
          } 

          if( !hasAtLeastOneValidRelation && RelationType::isBitwiseSpatialPredicate(relationTypePackedBitwise , RelationType::DISJOINT)) {
            hasAtLeastOneValidRelation = leftOGRGeom->Disjoint(rightOGRGeom);
          } 

          if( !hasAtLeastOneValidRelation && RelationType::isBitwiseSpatialPredicate(relationTypePackedBitwise , RelationType::CROSSES)) {
            hasAtLeastOneValidRelation = leftOGRGeom->Crosses(rightOGRGeom);
          } 

          if( !hasAtLeastOneValidRelation && RelationType::isBitwiseSpatialPredicate(relationTypePackedBitwise , RelationType::WITHIN)) {
            hasAtLeastOneValidRelation = leftOGRGeom->Within(rightOGRGeom);
          } 

          if( !hasAtLeastOneValidRelation && RelationType::isBitwiseSpatialPredicate(relationTypePackedBitwise , RelationType::CONTAINS)) {
            hasAtLeastOneValidRelation = leftOGRGeom->Contains(rightOGRGeom);
          } 

          if( !hasAtLeastOneValidRelation && RelationType::isBitwiseSpatialPredicate(relationTypePackedBitwise , RelationType::OVERLAPS)) {
            hasAtLeastOneValidRelation = leftOGRGeom->Overlaps(rightOGRGeom);
          } 

          if( !hasAtLeastOneValidRelation && RelationType::isBitwiseSpatialPredicate(relationTypePackedBitwise , RelationType::EQUALS)) {
            hasAtLeastOneValidRelation = leftOGRGeom->Equals(rightOGRGeom);
          }
          // clean right
					OGRGeometryFactory::destroyGeometry(rightOGRGeom);
			}
      // clean left
			OGRGeometryFactory::destroyGeometry(leftOGRGeom);
	}
	// return result
	return hasAtLeastOneValidRelation;
ENDC++;
                
 
	/* rasterBLOBLookup
		 
		 Load a GEOTiff file from a BLOB field and lookup the Raster value for X,Y for a given Band index
	*/
 EXPORT REAL8 rasterBLOBLookup(REAL8 x, REAL8 y, const data blob, INTEGER4 band = 1) := 
  BEGINC++
    #option library 'geos'
    #option library 'proj'
    #option library 'gdal'

    // #option once : Indicates the function has no side effects and is evaluated at query execution time, even if the parameters are constant, allowing the optimizer to make more efficient calls to the function in some cases.
    #option once

    #include <typeinfo>
    #include <map>
    #include <stdlib.h>
    #include <exception>
    #include <stdexcept>
    #include <iostream>
    #include <sstream>
    #include <string>
    #include "platform.h"
    #include "ogrsf_frmts.h" // GDAL
    #include "cpl_conv.h"
    #include "eclhelper.hpp"
    #include "eclrtl.hpp"
    #include "eclrtl_imp.hpp"
    #include "gdal_priv.h"
    #include "cpl_vsi.h"
    
    using namespace std;
  #body
    GDALAllRegister();
  
    bool loadFullLine = false;
    float result = -1;

    GByte *pabyInData = (GByte *) blob;
    vsi_l_offset nInDataLength = lenBlob;

    // Create a virtual file
    VSIFCloseL(VSIFileFromMemBuffer("/vsimem/raster1.dat", pabyInData,    nInDataLength, FALSE));

    // Open memory buffer for reading and use GDAL to open virtual file
    bool isRasterLoaded = false;
    GDALDataset  *poDataset;
    poDataset = (GDALDataset  *) GDALOpen("/vsimem/raster1.dat", GA_ReadOnly);

    isRasterLoaded = poDataset != NULL;

    if(isRasterLoaded) {
        result = -2;

        double east = x;
        double north = y;

        // get Raster Band
        GDALRasterBand  *poBand;
        poBand = poDataset->GetRasterBand(band);
        double  adfGeoTransform[6];

        // get raster dimensions and resolution
        int   nXSize = poBand->GetXSize();
        int   nYSize = poBand->GetYSize();

        poDataset->GetGeoTransform(adfGeoTransform) ;
        double originX = adfGeoTransform[0] ;
        double originY = adfGeoTransform[3];
        double pixelSizeMax = adfGeoTransform[1] ;

        // callulcate offset
        double eastOffset = east - originX;
        double northOffset = originY - north;

        int pxEastOffset = abs(eastOffset / pixelSizeMax);
        int pxNorthOffset = abs(northOffset / pixelSizeMax);

        int xOffset =  pxEastOffset;
        int yOffset =  pxNorthOffset;

        int maxColsToRetrieve = 1;
        int maxRowsToretrieve = 1;
				// Check if Raster data type is int or float.
				GDALDataType dataType = poBand->GetRasterDataType();
        // read the raster data... either a full line or just what we need
				if(dataType==GDT_Float32) {
					float *pafScanline;
					if(loadFullLine) {
							pafScanline = (float *) CPLMalloc(sizeof(float)*nXSize);
							poBand->RasterIO(GF_Read, 0, yOffset, nXSize, 1,  pafScanline, nXSize, 1, dataType,  0, 0);
							result = pafScanline[xOffset];
					} else {
							pafScanline = (float *) CPLMalloc(sizeof(float));
							pafScanline[0] = -909; // set dafault no data value
							poBand->RasterIO(GF_Read, xOffset, yOffset, 1, 1,  pafScanline, 1, 1, dataType,  0, 0);
							result = pafScanline[0];
					}
					// free
					CPLFree(pafScanline);
					/**
					 ** Warning : Even though we allow unsigned values as a possible data type for the raster, 
					 ** we are returning a real type one, which is signed. 
					 ** So in case that we do need to use the unsigned bit we may have to revisit this.
					 **/
				} else if(dataType==GDT_Int32 || dataType==GDT_UInt32 ||
									dataType==GDT_Int16 || dataType==GDT_UInt16){
					int *pafScanline;
					if(loadFullLine) {
            pafScanline = (int *) CPLMalloc(sizeof(int)*nXSize);
						/**
						 ** TO DO : When using rasters of type GDT_Int16, it seems that we would not get the expected 
						 ** result when using GDT_Int16 as an input for the GDALDataType parameter. So by now we will
						 ** keep GDT_Int32 as an input, regardless the type. Not tested still with unsigned values.
						 **/
            poBand->RasterIO(GF_Read, 0, yOffset, nXSize, 1,  pafScanline, nXSize, 1, GDT_Int32,  0, 0);
            result = pafScanline[xOffset];
					} else {
							pafScanline = (int *) CPLMalloc(sizeof(int));
							pafScanline[0] = -909; // set dafault no data value
							poBand->RasterIO(GF_Read, xOffset, yOffset, 1, 1,  pafScanline, 1, 1, GDT_Int32,  0, 0);
							result = pafScanline[0];
					}
					// free
					CPLFree(pafScanline);
				} else {
					// Data type not supported
					result = -911;
				}
        // handle nan
        if(isnan(result)){
          result = -910;
        }
        GDALClose((GDALDatasetH) poDataset);
    }else{
      result = -3;
    }


    VSIUnlink("/vsimem/raster1.dat");

    return result;
  ENDC++;
  
	 /* SpatialReferenceForSRID
						 
			Given a SRID return the WKT representing the Spatial Projection Details for that SRID
		*/
  export STRING SpatialReferenceForSRID(INTEGER4 srid) := 
  BEGINC++
	#option library 'geos'
  #option library 'proj'
  #option library 'gdal'
  
  // #option once : Indicates the function has no side effects and is evaluated at query execution time, even if the parameters are constant, allowing the optimizer to make more efficient calls to the function in some cases.
  #option once


  #include <iostream>
  #include <sstream>
  #include <string>
  #include "ogrsf_frmts.h" // GDAL
  #include "cpl_conv.h"
  #include "gdal_priv.h"

  using namespace std;

  #body
    char *wktOut;
    
     // determine the spatial reference details
    OGRSpatialReference * poSRS = new OGRSpatialReference(NULL);
    poSRS->importFromEPSG(srid);

    poSRS->exportToWkt(&wktOut);
  
      // copy string into a char array
    unsigned len = strlen(wktOut);
    char * out = (char *) malloc(len);
    for(unsigned i=0; i < len; i++) {
        out[i] = wktOut[i];
    }

    // free resources
    free(wktOut);
    OGRSpatialReference::DestroySpatialReference(poSRS);


    //return result to ECL
    __result = out;

    // set length of return string
    __lenResult = len;
  ENDC++;
  
 /* interiorArea
				 
		 Get the Area for a given geometry defined using Well Known Text
		 using the projection defined by SRID... the area unit returned depdents on the SRID
	*/
  EXPORT REAL8 interiorArea(const string  geom,  STRING srs) :=
  BEGINC++
    #option library 'geos'
    #option library 'proj'
    #option library 'gdal'
    
    // #option once : Indicates the function has no side effects and is evaluated at query execution time, even if the parameters are constant, allowing the optimizer to make more efficient calls to the function in some cases.
    #option once

    #include <iostream>
    #include <sstream>
    #include <string>
    #include "ogrsf_frmts.h" // GDAL
    #include "cpl_conv.h"
    #include "gdal_priv.h"

    using namespace std;

    #body

    OGRGeometry *thisGeom;
    char* wktIn = (char*) geom;

		// determine the spatial reference details
		char* wktSRSIn = (char*) srs;
		OGRSpatialReference * poSRS = new OGRSpatialReference(NULL);
		poSRS->importFromWkt(&wktSRSIn);
    
    // Create a geoemtry from given WKT
    OGRErr err = OGRGeometryFactory::createFromWkt(&wktIn, poSRS, &thisGeom);

    double area = -1;

    switch(thisGeom->getGeometryType()) {
    case wkbUnknown:
    case wkbNone:
        area = -1;
        break;
    case wkbPoint:
    case wkbPoint25D:
        area = 0;
        break;
    case wkbLineString:
    case wkbLineString25D:
        area = 0;
        break;
    case wkbPolygon:
    case wkbPolygon25D: {
        area = ((OGRSurface  *)thisGeom)->get_Area();
        break;
    }
    case wkbMultiPoint:
    case wkbMultiPoint25D:
    case wkbMultiLineString:
    case wkbMultiLineString25D:
    case wkbMultiPolygon:
    case wkbMultiPolygon25D:
    case wkbGeometryCollection:
    case wkbGeometryCollection25D: {
        area = ((OGRGeometryCollection *)thisGeom)->get_Area();
        break;
    }
    case wkbLinearRing:
        area = ((OGRLinearRing  *)thisGeom)->get_Area();
        break;
    }

    OGRGeometryFactory::destroyGeometry(thisGeom);
    OGRSpatialReference::DestroySpatialReference(poSRS);

    return area;
  ENDC++;
	
/* distanceBetween
                   
    Get the distance between the 2 given WKT geometries, the distance unit returned depdends on the SRID used
*/
EXPORT REAL8 distanceBetween(const string  geom1, const string  geom2, STRING srs):=
BEGINC++
  #option library 'geos'
	#option library 'proj'
	#option library 'gdal'
  // #option once : Indicates the function has no side effects and is evaluated at query execution time, even if the parameters are constant, allowing the optimizer to make more efficient calls to the function in some cases.
  #option once


	#include <iostream>
	#include <sstream>
	#include <string>
	#include "ogrsf_frmts.h" // GDAL
	#include "cpl_conv.h"
	#include "gdal_priv.h"

	using namespace std;

	#body

  // determine the spatial reference details
	char* wktSRSIn = (char*) srs;
  OGRSpatialReference * poSRS = new OGRSpatialReference(NULL);
  poSRS->importFromWkt(&wktSRSIn);

	bool hasAtLeastOneValidRelation = false;

	char* wktInLeft = (char*) geom1;
	char* wktInRight = (char*) geom2;

	OGRGeometry *leftOGRGeom;
	OGRGeometry *rightOGRGeom;

	bool loadedOK = false;
	OGRErr err =  NULL;

	err = OGRGeometryFactory::createFromWkt(&wktInLeft, poSRS, &leftOGRGeom);
	loadedOK = (err == OGRERR_NONE);

	err = OGRGeometryFactory::createFromWkt(&wktInRight, poSRS, &rightOGRGeom);
	loadedOK = (err == OGRERR_NONE);

	double distance = leftOGRGeom->Distance(rightOGRGeom);

	OGRGeometryFactory::destroyGeometry(leftOGRGeom);
	OGRGeometryFactory::destroyGeometry(rightOGRGeom);
	OGRSpatialReference::DestroySpatialReference(poSRS);

  return distance;
ENDC++;


/**
SplitPolygon

@param geom1 the WKT representing the large polygon to be split
@param max_poly_vertices the max vertices the smaller polygons should have
@param srs1 the Spatial Refrence System details given as WKT that should be used to load the large polygon

@return DATASET(Geometry.GeometryLayout) returns a RecordSet containing the smaller polygons given as WKT; one smaller polygon per row
*/
EXPORT LINKCOUNTED DATASET(GeometryLayout) SplitPolygon(const string  geom1,  const INTEGER1 max_poly_vertices, const STRING srs1) := BEGINC++
/*
* https://github.com/geoloqi/SplitPolygon/blob/master/SplitPolygon.cpp
*
*
* SplitPolygon.cpp -- split polygons into constituents using OGR and GEOS
*
* written by Schuyler Erle <schuyler@nocat.net>
* copyright (c) 2012 Geoloqi, Inc.
* published under the 3-clause BSD license -- see README.txt for details.
* 
*/

// import spatial libraries
#option library 'geos'
#option library 'proj'
#option library 'gdal'
// #option once : Indicates the function has no side effects and is evaluated at query execution time, even if the parameters are constant, allowing the optimizer to make more efficient calls to the function in some cases.
#option once


#include <cstdlib>
#include <iostream>
#include <vector>
#include <sstream>
#include <string>
#include "ogrsf_frmts.h" // GDAL
#include "cpl_conv.h"
#include "gdal_priv.h"

#define MAXVERTICES 250

typedef std::vector<OGRPolygon *> OGRPolyList;

static bool debug = false;

void split_polygons(OGRPolyList *pieces, OGRGeometry* geometry, int max_vertices) {
	/* split_polygons recursively splits the (multi)polygon into smaller
	* polygons until each polygon has at most max_vertices, and pushes each
	* one onto the pieces vector.
	* 
	* Multipolygons are automatically divided into their constituent polygons.
	* Empty polygons and other geometry types are ignored. Invalid polygons
	* get cleaned up to the best of our ability, but this does trigger
	* warnings from inside GEOS.
	*
	* Each polygon is split by dividing its bounding box into quadrants, and
	* then recursing on the intersection of each quadrant with the original
	* polygon, until the pieces are of the desired complexity.
	*/

	if (geometry == NULL) {
		std::cerr << "WARNING: NULL geometry passed to split_polygons!\n";
		return;
	}
	
	if (geometry->IsEmpty())
	return;
	
	
	if (geometry->getGeometryType() == wkbMultiPolygon) {
		OGRMultiPolygon *multi = (OGRMultiPolygon*) geometry;
		for (int i = 0; i < multi->getNumGeometries(); i++) {
			split_polygons(pieces, multi->getGeometryRef(i), max_vertices);
		}
		return;
	} 
	
	
	if (geometry->getGeometryType() != wkbPolygon)
	return;
	
	OGRPolygon* polygon = (OGRPolygon*) geometry;
	if (polygon->getExteriorRing()->getNumPoints() <= max_vertices) {
		pieces->push_back((OGRPolygon*) polygon->clone());
		return;
	}

	bool polygonIsPwned = false;
	if (!polygon->IsValid() || !polygon->IsSimple()) {
		polygon = (OGRPolygon*) polygon->Buffer(0); // try to tidy it up
		polygonIsPwned = true; // now we own the reference and have to free it later
	}

	OGRPoint centroid;
	polygon->Centroid(&centroid);
	double cornerX = centroid.getX(),
	cornerY = centroid.getY();

	OGREnvelope envelope;
	polygon->getEnvelope(&envelope);

	for (int quadrant = 0; quadrant < 4; quadrant++) {
		OGREnvelope bbox(envelope);
		OGRLinearRing ring;
		OGRPolygon mask;
		switch (quadrant) { // in no particular order, actually
		case 0: bbox.MaxX = cornerX; bbox.MaxY = cornerY; break;
		case 1: bbox.MaxX = cornerX; bbox.MinY = cornerY; break;
		case 2: bbox.MinX = cornerX; bbox.MaxY = cornerY; break;
		case 3: bbox.MinX = cornerX; bbox.MinY = cornerY; break;
		}
		ring.setNumPoints(5);
		ring.setPoint(0, bbox.MinX, bbox.MinY);
		ring.setPoint(1, bbox.MinX, bbox.MaxY);
		ring.setPoint(2, bbox.MaxX, bbox.MaxY);
		ring.setPoint(3, bbox.MaxX, bbox.MinY);
		ring.setPoint(4, bbox.MinX, bbox.MinY); // close the ring
		mask.addRing(&ring);
		OGRGeometry* piece = mask.Intersection(polygon);
		split_polygons(pieces, piece, max_vertices);
		delete piece;
	} 

	if (polygonIsPwned) delete polygon;
}



/*
* addRow

* create a HPCC Record Row suitable to be appended to the __Result
* 
* @param _geom this will be the WKT Geoemtry of the new smaller Polygon 
* @param _resultAllocator the ECL result allocator which manages row creation
*/
byte * addRow(const char* _geom, IEngineRowAllocator * _resultAllocator){
  // set size
	size32_t actualSize;
	unsigned geomLen = strlen(_geom);
	unsigned size =  sizeof(size32_t)+ geomLen;
  
  // allocate memory for new row and set the cursor
	byte * row = (byte *)_resultAllocator->createRow(actualSize);
	row = (byte *)_resultAllocator->resizeRow(size, row, actualSize);
	byte * cur = (byte *)row;
	
  // append length & geometry string to row
	*(size32_t *)cur = geomLen; // set the String-Length
	cur += sizeof(size32_t); // skip over String-Length (size32_t)
	memcpy(cur, _geom, geomLen);  // copy string into row
	
  // finalise, return bytes to be assocaited with new row
	return (byte *)_resultAllocator->finalizeRow(size, row, actualSize);
}


#body


OGRGeometry *thisGeom;
OGRPolyList pieces;
char* wktIn = (char*) geom1;

// determine the spatial reference details
char* wktSRSIn = (char*) srs1;
OGRSpatialReference * poSRS = new OGRSpatialReference(NULL);
poSRS->importFromWkt(&wktSRSIn);

// Create a geoemtry from given WKT
OGRErr err = OGRGeometryFactory::createFromWkt(&wktIn, poSRS, &thisGeom);

// do the split
split_polygons(&pieces, thisGeom, max_poly_vertices);

// create the rowset : size = total number of pieces
__countResult =  pieces.size();
__result = _resultAllocator->createRowset( pieces.size());

// for each polygon piece (smaller polygon)
int i=0;
for (OGRPolyList::iterator it = pieces.begin(); it != pieces.end(); it++) {
	size32_t allocSize;
	char *wkt;
	
  // get the new smaller polygon and generate WKT for it
	OGRPolygon* piece = *it;
	piece->exportToWkt(&wkt);

	// append row to result, create row containing WKT representing Smaller polygon
	__result[i++] = addRow(wkt, _resultAllocator);
  
  // Free per row resources
	free(wkt);
}


// free resources
OGRSpatialReference::DestroySpatialReference(poSRS);
OGRGeometryFactory::destroyGeometry(thisGeom);

ENDC++;

/* union
 Produce a single geometry returned as WKT from the two given WKT geometries
*/
EXPORT string union(const string  geom1, const string  geom2, string srs):=
BEGINC++
  #option library 'geos'
	#option library 'proj'
	#option library 'gdal'
  // #option once : Indicates the function has no side effects and is evaluated at query execution time, even if the parameters are constant, allowing the optimizer to make more efficient calls to the function in some cases.
  #option once

	#include <iostream>
	#include <sstream>
	#include <string>
	#include "ogrsf_frmts.h" // GDAL
	#include "cpl_conv.h"
	#include "gdal_priv.h"

	using namespace std;

	#body
	char* wkt;
	
  // determine the spatial reference details
	char* wktSRSIn = (char*) srs;
  OGRSpatialReference * poSRS = new OGRSpatialReference(NULL);
  poSRS->importFromWkt(&wktSRSIn);

	bool hasAtLeastOneValidRelation = false;

	char* wktInLeft = (char*) geom1;
	char* wktInRight = (char*) geom2;

	OGRGeometry *leftOGRGeom;
	OGRGeometry *rightOGRGeom;
	OGRGeometry *unionGeom;

	bool loadedOK = false;
	OGRErr err =  NULL;

	err = OGRGeometryFactory::createFromWkt(&wktInLeft, poSRS, &leftOGRGeom);
	loadedOK = (err == OGRERR_NONE);

	err = OGRGeometryFactory::createFromWkt(&wktInRight, poSRS, &rightOGRGeom);
	loadedOK = (err == OGRERR_NONE);

    unionGeom = leftOGRGeom->Union(rightOGRGeom);
    unionGeom->exportToWkt(&wkt);

    unsigned len = strlen(wkt);

    // copy string into a char array
    char * out = (char *) malloc(len);
    for(unsigned i=0; i < len; i++) {
        out[i] = wkt[i];
    }

    //return result to ECL
    __result = out;

    // set length of return string
    __lenResult = len;

    free(wkt);
    OGRGeometryFactory::destroyGeometry(leftOGRGeom);
    OGRGeometryFactory::destroyGeometry(rightOGRGeom);
    OGRGeometryFactory::destroyGeometry(unionGeom);
    OGRSpatialReference::DestroySpatialReference(poSRS);
ENDC++;

/* tranformToProjection

			 Transform a geometry from one SRID projection to another
*/
EXPORT string tranformToProjection(const string  geom,  STRING srs1, STRING srs2):=
BEGINC++
  #option library 'geos'
  #option library 'proj'
  #option library 'gdal'
  // #option once : Indicates the function has no side effects and is evaluated at query execution time, even if the parameters are constant, allowing the optimizer to make more efficient calls to the function in some cases.
  #option once

  #include <iostream>
  #include <sstream>
  #include <string>
  #include "ogrsf_frmts.h" // GDAL
  #include "cpl_conv.h"
  #include "gdal_priv.h"

  using namespace std;
  
  #body

  OGRGeometry *thisGeom;
  char *wkt;
  char* wktIn = (char*) geom;


  // determine the spatial reference details
	char* wktSRSSourceIn = (char*) srs1;
  OGRSpatialReference *sourceSRS = new OGRSpatialReference(NULL);
  sourceSRS->importFromWkt(&wktSRSSourceIn);
	
	char* wktSRSTargetIn = (char*) srs2;
  OGRSpatialReference *targetSRS = new OGRSpatialReference(NULL);
  targetSRS->importFromWkt(&wktSRSTargetIn);
  

  // create geometry from given WKT
  OGRErr err = OGRGeometryFactory::createFromWkt(&wktIn, sourceSRS, &thisGeom);

    thisGeom->transformTo(targetSRS);

    thisGeom->exportToWkt(&wkt);

    unsigned len = strlen(wkt);

    // copy string into a char array
    char * out = (char *) malloc(len);
    for(unsigned i=0; i < len; i++) {
        out[i] = wkt[i];
    }

    //return result to ECL
    __result = out;

    // set length of return string
    __lenResult = len;

    free(wkt);
    OGRSpatialReference::DestroySpatialReference(sourceSRS);
    OGRSpatialReference::DestroySpatialReference(targetSRS);
    OGRGeometryFactory::destroyGeometry(thisGeom);
ENDC++;

/* UTMZoneSRIDForWGS84Point

	 For a given WKT WGS84 Point Geoemtry, return the SRID for its corresponding UTM zone
*/
EXPORT INTEGER4 UTMZoneSRIDForWGS84Point(const string  geom):=
BEGINC++
	#option library 'geos'
	#option library 'proj'
	#option library 'gdal'
  // #option once : Indicates the function has no side effects and is evaluated at query execution time, even if the parameters are constant, allowing the optimizer to make more efficient calls to the function in some cases.
  #option once

	#include <iostream>
	#include <sstream>
	#include <string>
	#include "ogrsf_frmts.h" // GDAL
	#include "cpl_conv.h"
	#include "gdal_priv.h"

	using namespace std;

	#body

	OGRGeometry *thisGeom;

	char* wktIn = (char*) geom;

	// determine the spatial reference details
	OGRSpatialReference * poSRS = new OGRSpatialReference(NULL);
	poSRS->importFromEPSG(4326);

	// create geometry from given WKT
	OGRErr err = OGRGeometryFactory::createFromWkt(&wktIn, poSRS, &thisGeom);

	OGRPoint *point = (OGRPoint *)thisGeom;

	int utmZone = ((int)(floor((point->getX() + 180)/6)) % 60) + 1;

	// Exceptions to the rule, Norway & Svalbard etc...
	// @see http://en.wikipedia.org/wiki/Universal_Transverse_Mercator_coordinate_system#Exceptions
	if(utmZone >= 31 and utmZone <= 36) {
			int x = point->getX();
			int y = point->getY();

			if(y > 55 && utmZone==31 && y < 64 && x > 2) {
					utmZone =  utmZone;
			} else if(y > 71 && utmZone==32 && x < 9) {
					utmZone =  31;
			} else if(y > 71 && utmZone==32 && x > 8) {
					utmZone =  33;
			} else if(y > 71 && utmZone==34 && x < 21) {
					utmZone =  33;
			} else if(y > 71 && utmZone==34 && x > 20) {
					utmZone =  35;
			} else if(y > 71 && utmZone==36 && x < 33) {
					utmZone =  35;
			} else if(y > 71 && utmZone==36 && x > 32) {
					utmZone =  37;
			} else utmZone =  utmZone;
	}

	OGRGeometryFactory::destroyGeometry(thisGeom);
	OGRSpatialReference::DestroySpatialReference(poSRS);

	return 32601 + utmZone + (point->getY() < 0?100:0) -1;
	
ENDC++;


export boolean isValid(const string geom, string srs) := 
BEGINC++
  #option library 'geos'
  #option library 'proj'
  #option library 'gdal'
  // #option once : Indicates the function has no side effects and is evaluated at query execution time, even if the parameters are constant, allowing the optimizer to make more efficient calls to the function in some cases.
  #option once


  #include <iostream>
  #include <sstream>
  #include <string>
  #include "ogrsf_frmts.h" // GDAL
  #include "cpl_conv.h"
  #include "gdal_priv.h"

  using namespace std;
  
  #body

  OGRGeometry *thisGeom;

	char* wktIn = (char*) geom;	

  // determine the spatial reference details
	char* wktSRSIn = (char*) srs;
  OGRSpatialReference * poSRS = new OGRSpatialReference(NULL);
  poSRS->importFromWkt(&wktSRSIn);
  
  // create geometry from given WKT
  OGRErr err = OGRGeometryFactory::createFromWkt(&wktIn, poSRS, &thisGeom);

  // validate
  bool isValidGeom = (err == OGRERR_NONE) && thisGeom->IsValid();

  // free resources
  OGRSpatialReference::DestroySpatialReference(poSRS);
  if (thisGeom != NULL) OGRGeometryFactory::destroyGeometry(thisGeom);

	return isValidGeom;
ENDC++;
		
export boolean isRing(const string geom, string srs) := 
BEGINC++
  #option library 'geos'
  #option library 'proj'
  #option library 'gdal'
  // #option once : Indicates the function has no side effects and is evaluated at query execution time, even if the parameters are constant, allowing the optimizer to make more efficient calls to the function in some cases.
  #option once

  #include <iostream>
  #include <sstream>
  #include <string>
  #include "ogrsf_frmts.h" // GDAL
  #include "cpl_conv.h"
  #include "gdal_priv.h"

  using namespace std;
  
  #body

  OGRGeometry *thisGeom;

  char* wktIn = (char*) geom;

  // determine the spatial reference details
	char* wktSRSIn = (char*) srs;
  OGRSpatialReference * poSRS = new OGRSpatialReference(NULL);
  poSRS->importFromWkt(&wktSRSIn);
  
  // create geometry from given WKT
  OGRErr err = OGRGeometryFactory::createFromWkt(&wktIn, poSRS, &thisGeom);

  // validate
  bool isRing = thisGeom->IsRing();

  // free resources
  OGRSpatialReference::DestroySpatialReference(poSRS);
  OGRGeometryFactory::destroyGeometry(thisGeom);

	return isRing;
ENDC++;

export boolean isSimple(const string geom, string srs) := 
BEGINC++
  #option library 'geos'
  #option library 'proj'
  #option library 'gdal'
  // #option once : Indicates the function has no side effects and is evaluated at query execution time, even if the parameters are constant, allowing the optimizer to make more efficient calls to the function in some cases.
  #option once

  #include <iostream>
  #include <sstream>
  #include <string>
  #include "ogrsf_frmts.h" // GDAL
  #include "cpl_conv.h"
  #include "gdal_priv.h"

  using namespace std;
  
  #body

  OGRGeometry *thisGeom;

  char* wktIn = (char*) geom;

  // determine the spatial reference details
	char* wktSRSIn = (char*) srs;
  OGRSpatialReference * poSRS = new OGRSpatialReference(NULL);
  poSRS->importFromWkt(&wktSRSIn);
  
  // create geometry from given WKT
  OGRErr err = OGRGeometryFactory::createFromWkt(&wktIn, poSRS, &thisGeom);

  // validate
  bool isSimple = thisGeom->IsSimple();

  // free resources
  OGRSpatialReference::DestroySpatialReference(poSRS);
  OGRGeometryFactory::destroyGeometry(thisGeom);

	return isSimple;
ENDC++;

export boolean isEmpty(const string geom, string srs) := 
BEGINC++
  #option library 'geos'
  #option library 'proj'
  #option library 'gdal'
  // #option once : Indicates the function has no side effects and is evaluated at query execution time, even if the parameters are constant, allowing the optimizer to make more efficient calls to the function in some cases.
  #option once

  #include <iostream>
  #include <sstream>
  #include <string>
  #include "ogrsf_frmts.h" // GDAL
  #include "cpl_conv.h"
  #include "gdal_priv.h"

  using namespace std;
  
  #body

  OGRGeometry *thisGeom;

  char* wktIn = (char*) geom;

  // determine the spatial reference details
	char* wktSRSIn = (char*) srs;
  OGRSpatialReference * poSRS = new OGRSpatialReference(NULL);
  poSRS->importFromWkt(&wktSRSIn);
  
  // create geometry from given WKT
  OGRErr err = OGRGeometryFactory::createFromWkt(&wktIn, poSRS, &thisGeom);

  // validate
  bool isSimple = thisGeom->isEmpty();

  // free resources
  OGRSpatialReference::DestroySpatialReference(poSRS);
  OGRGeometryFactory::destroyGeometry(thisGeom);

	return isEmpty;
ENDC++;

/* centroid
   For a given WKT geometry return a WKT Point Geoemtry indicating the centroid
*/
export string centroid(const string  geom,  STRING srs):=
BEGINC++

  #option library 'geos'
  #option library 'proj'
  #option library 'gdal'
  // #option once : Indicates the function has no side effects and is evaluated at query execution time, even if the parameters are constant, allowing the optimizer to make more efficient calls to the function in some cases.
  #option once

  #include <iostream>
  #include <sstream>
  #include <string>
  #include "ogrsf_frmts.h" // GDAL
  #include "cpl_conv.h"
  #include "gdal_priv.h"

  using namespace std;

  #body

  OGRGeometry *thisGeom;
  OGRPoint *centroid;
  char *wktOut;
  char* wktIn = (char*) geom;

  // determine the spatial reference details
	char* wktSRSIn = (char*) srs;
  OGRSpatialReference * poSRS = new OGRSpatialReference(NULL);
  poSRS->importFromWkt(&wktSRSIn);
	
	centroid = new OGRPoint();
	  
  // Create a geoemtry from given WKT
  OGRErr err = OGRGeometryFactory::createFromWkt(&wktIn, poSRS, &thisGeom);

  // generate centroid
  thisGeom->Centroid(centroid);

  // export to WKT
  centroid->exportToWkt(&wktOut);

  // copy string into a char array
  unsigned len = strlen(wktOut);
  char * out = (char *) malloc(len);
  for(unsigned i=0; i < len; i++) {
      out[i] = wktOut[i];
  }

  // free resources
  free(wktOut);
  OGRSpatialReference::DestroySpatialReference(poSRS);
  OGRGeometryFactory::destroyGeometry(thisGeom);
  OGRGeometryFactory::destroyGeometry(centroid);

  //return result to ECL
  __result = out;

  // set length of return string
  __lenResult = len;
ENDC++;
                
/**
rasterBandBLOBMetaData

Get all relevant metdata for all raster bands in a  raster, add it to a memory buffer and return it back to ECL as a string
**/
EXPORT  STRING rasterBandBLOBMetaData(const data blob, INTEGER4 band) :=
BEGINC++
#option library 'geos'
#option library 'proj'
#option library 'gdal'
// #option once : Indicates the function has no side effects and is evaluated at query execution time, even if the parameters are constant, allowing the optimizer to make more efficient calls to the function in some cases.
#option once

#include <typeinfo>
#include <map>
#include <stdlib.h>
#include <exception>
#include <stdexcept>
#include <iostream>
#include <sstream>
#include <string>
#include <cstring>
#include "platform.h"
#include "ogrsf_frmts.h" // GDAL
#include "cpl_conv.h"
#include "eclhelper.hpp"
#include "eclrtl.hpp"
#include "eclrtl_imp.hpp"
#include "gdal_priv.h"

  using namespace std;
  


  #body

    GDALAllRegister();

    bool loadFullLine = false;
    int result = -1;

    GByte *pabyInData = (GByte *) blob;
    vsi_l_offset nInDataLength = lenBlob;

    // Create a virtual file
    VSIFCloseL(VSIFileFromMemBuffer("/vsimem/raster.dat", pabyInData,    nInDataLength, FALSE));

    // Open memory buffer for reading and use GDAL to open virtual file
    bool isRasterLoaded = false;
    GDALDataset  *poDataset;
    // trick GDAL into believing a block of memory is a physical file
    poDataset = (GDALDataset  *) GDALOpen("/vsimem/raster.dat", GA_ReadOnly);

    isRasterLoaded = poDataset != NULL;
    
    
    stringstream wktOut;

    if(isRasterLoaded) {

            GDALRasterBand  *poBand = poDataset->GetRasterBand(band);

            // band #
             wktOut << band << "||" ;

            // Size
            wktOut << poBand->GetXSize() << "||" ;
            wktOut << poBand->GetYSize() << "||" ;
        

            // Overview
            wktOut << poBand->GetOverviewCount() << "||" ;

            // Scale
            wktOut << poBand->GetScale()  << "||" ;
            

            // No Data Value
            wktOut << poBand->GetNoDataValue()  << "||" ;
            
             // DataType
            const char * dataTypeName = GDALGetDataTypeName(poBand->GetRasterDataType());
            wktOut << dataTypeName << "||" ;
        
        
        // free
        GDALClose((GDALDatasetH) poDataset);
    }

    // free
    VSIUnlink("/vsimem/raster.dat");

  size32_t len = wktOut.str().length();

  // copy string into a char array
  char * out = (char *) malloc(len);
  for(unsigned i=0; i < len; i++) {
      out[i] = wktOut.str().c_str()[i];
  }

  //return result to ECL
  __result = out;

  // set length of return string
  __lenResult = len;

ENDC++;

/* rasterBLOBMetaData
		 
	 Load a GEOTiff file from a BLOB field and return a relevant meta data as a single row as a string
*/
EXPORT STRING rasterBLOBMetaData(const data blob) :=
BEGINC++
#option library 'geos'
#option library 'proj'
#option library 'gdal'
// #option once : Indicates the function has no side effects and is evaluated at query execution time, even if the parameters are constant, allowing the optimizer to make more efficient calls to the function in some cases.
#option once

#include <typeinfo>
#include <map>
#include <stdlib.h>
#include <exception>
#include <stdexcept>
#include <iostream>
#include <sstream>
#include <string>
#include <cstring>
#include "platform.h"
#include "ogrsf_frmts.h" // GDAL
#include "cpl_conv.h"
#include "eclhelper.hpp"
#include "eclrtl.hpp"
#include "eclrtl_imp.hpp"
#include "gdal_priv.h"

  using namespace std;
  

  #body
  
    GDALAllRegister();

    bool loadFullLine = false;

    GByte *pabyInData = (GByte *) blob;
    vsi_l_offset nInDataLength = lenBlob;

    // Create a virtual file
    VSIFCloseL(VSIFileFromMemBuffer("/vsimem/raster.dat", pabyInData,    nInDataLength, FALSE));

    // Open memory buffer for reading and use GDAL to open virtual file
    bool isRasterLoaded = false;
    GDALDataset  *poDataset;
    // trick GDAL into believing a block of memory is a physical file
    poDataset = (GDALDataset  *) GDALOpen("/vsimem/raster.dat", GA_ReadOnly);

    isRasterLoaded = poDataset != NULL;
    
    size32_t allocSize;
    
    
  // format as wktOut Polygon
  stringstream wktOut;


    if(isRasterLoaded) {

    
        // raster meta data
        wktOut << poDataset->GetRasterXSize() << "||" ;
        wktOut << poDataset->GetRasterYSize() << "||" ;
        wktOut << poDataset->GetRasterCount() << "||" ;
    

        //transform details
        double        adfGeoTransform[6];
        poDataset->GetGeoTransform(adfGeoTransform) ;
        wktOut << adfGeoTransform[0]  << "||" ;
        wktOut << adfGeoTransform[3]  << "||" ;
        wktOut << adfGeoTransform[1]  << "||" ;
        wktOut << adfGeoTransform[5]  << "||" ;
                
        // driver
        const char * driverLongName = poDataset->GetDriver()->GetMetadataItem(GDAL_DMD_LONGNAME) ;
        wktOut << driverLongName << "||" ;
        
         //projection
        const char * projectionRef = poDataset->GetProjectionRef();
        wktOut << projectionRef << "||" ;
        
        // Upper Left
        double dfGeoMinX = adfGeoTransform[0] + adfGeoTransform[1] * 0.0
            + adfGeoTransform[2] * 0.0;
        double dfGeoMaxY = adfGeoTransform[3] + adfGeoTransform[4] * 0.0
            + adfGeoTransform[5] * 0.0;
            
         wktOut << dfGeoMinX << "||" << dfGeoMaxY << "||";
        
        // Lower Right
        double dfGeoMaxX = adfGeoTransform[0] + adfGeoTransform[1] * poDataset->GetRasterXSize()
            + adfGeoTransform[2] * poDataset->GetRasterYSize();
        double dfGeoMinY = adfGeoTransform[3] + adfGeoTransform[4] * poDataset->GetRasterXSize()
            + adfGeoTransform[5] * poDataset->GetRasterYSize();

        wktOut << dfGeoMaxX << "||" << dfGeoMinY << "||";
        
        // free
        GDALClose((GDALDatasetH) poDataset);
    }

    // free
    VSIUnlink("/vsimem/raster.dat");
    
   
  size32_t len = wktOut.str().length();

  // copy string into a char array
  char * out = (char *) malloc(len);
  for(unsigned i=0; i < len; i++) {
      out[i] = wktOut.str().c_str()[i];
  }

  //return result to ECL
  __result = out;

  // set length of return string
  __lenResult = len;

ENDC++;



		EXPORT SRS := SpatialReferenceForSRID;
END;


EXPORT SRS := ExtLibSpatial.SRS;


/*
***********************************************************************
Projection Module
***********************************************************************
*/
EXPORT Projection := MODULE	
		EXPORT INTEGER4 WGS84 :=	4326;	
		EXPORT INTEGER4 UTM_17N := 32617;
    EXPORT INTEGER4 UTM_16N := 32616;
    
    // Define Haversine distance formula
    EXPORT real toRad(real degree) := FUNCTION
        return (degree*3.14)/180;
    END;

    EXPORT real toDeg(real radian) := FUNCTION
        return radian*180/3.14;
    END;


		/* see :
       - Operation.UTMZoneSRIDForWGS84Point
       - Operation.UTMZoneSRIDForWGS84Centroid
    */
END;

/*
***********************************************************************
Spatial Filter Module
***********************************************************************

Functions used to prune results based on assertion of spatial predicates
*/
EXPORT Filter := MODULE
	
	/*
		Bitwise enumeration for all possible Spatial Relations

		Can be combined e.g.

		All WITHIN or TOUCHING OR INTERSECTING = RelationType.WITHIN | RelationType.TOUCHES | RelationType.INTERSECTS
	*/
	EXPORT RelationType := ENUM 
	(
		INTERSECTS = 1 << 0,
		TOUCHES = 1 << 1,
		DISJOINT = 1 << 2,
		CROSSES = 1 << 3,
		WITHIN = 1 << 4,
		CONTAINS = 1 << 5,
		OVERLAPS = 1 << 6,
		EQUALS = 1 << 7
	);

  /* 
     hasSpatialRelation

     Does [this] and [thatOther] have one of the bitwise RelationTypes given in [relationTypeORBits] ?
  */
	EXPORT BOOLEAN hasSpatialRelation(const string  this, const string  thatOther, INTEGER relationTypeORBits, INTEGER4 srid) := FUNCTION
		STRING srs := ExtLibSpatial.SRS(srid);
    return ExtLibSpatial.hasSpatialRelation(this,thatOther,relationTypeORBits, srs);
	END;
	
  /*
		isPointInPolygon

		A synonymn to assert if a WITHIN relation exists between [point] and [polygon]
  */
	EXPORT BOOLEAN isPointInPolygon(const string  point, const string  polygon, INTEGER4  srid) := FUNCTION
		return hasSpatialRelation(point,polygon,RelationType.WITHIN, srid);
	END;
	
	/*
		isPointNotInPolygon

		A synonymn to assert if a DISJOINT relation exists between [point] and [polygon]
  */
	EXPORT BOOLEAN isPointNotInPolygon(const string  point, const string  polygon, INTEGER4  srid) := FUNCTION
		return hasSpatialRelation(point,polygon,RelationType.DISJOINT, srid);
	END;
	
	/*
		isWithin
	*/
	EXPORT BOOLEAN isWithin(const string  thisGeom, const string  thatOtherGeom, INTEGER4  srid) := FUNCTION
		return hasSpatialRelation(thisGeom,thatOtherGeom,RelationType.WITHIN, srid);
	END;
	
	/*
		isIntersecting
	*/
	EXPORT BOOLEAN isIntersecting(const string  thisGeom, const string  thatOtherGeom, INTEGER4  srid) := FUNCTION
		return hasSpatialRelation(thisGeom,thatOtherGeom,RelationType.INTERSECTS, srid);
	END;

  /*
    isTouching
  */
	EXPORT BOOLEAN isTouching(const string  thisGeom, const string  thatOtherGeom, INTEGER4  srid) := FUNCTION
		return hasSpatialRelation(thisGeom,thatOtherGeom,RelationType.TOUCHES, srid);
	END;
	
	/*
    isCrossing
  */
  EXPORT BOOLEAN isCrossing(const string  thisGeom, const string  thatOtherGeom, INTEGER4  srid) := FUNCTION
		return hasSpatialRelation(thisGeom,thatOtherGeom,RelationType.CROSSES, srid);
	END;
	
	/*
    isContainedBy
  */
	EXPORT BOOLEAN isContainedBy(const string  thisGeom, const string  thatOtherGeom, INTEGER4  srid) := FUNCTION
		return hasSpatialRelation(thatOtherGeom,thisGeom,RelationType.CONTAINS, srid);
	END;
	
	/*
    isOverlapping
  */
	EXPORT BOOLEAN isOverlapping(const string  thisGeom, const string  thatOtherGeom, INTEGER4  srid) := FUNCTION
		return hasSpatialRelation(thisGeom,thatOtherGeom,RelationType.OVERLAPS, srid);
	END;
	
	/*
		isEqualTo
  */
	EXPORT BOOLEAN isEqualTo(const string  thisGeom, const string  thatOtherGeom, INTEGER4  srid) := FUNCTION
		return hasSpatialRelation(thisGeom,thatOtherGeom,RelationType.EQUALS, srid);
	END;
  
  /*
		hasAnyInteraction
  */
	EXPORT BOOLEAN hasAnyInteraction(const string  thisGeom, const string  thatOtherGeom, INTEGER4  srid) := FUNCTION
		return hasSpatialRelation(
      thisGeom,thatOtherGeom,
      RelationType.INTERSECTS|RelationType.TOUCHES|RelationType.CROSSES|RelationType.WITHIN|RelationType.CONTAINS|RelationType.OVERLAPS|RelationType.EQUALS,
      srid
    );
	END;
  
  /*
    isAny

    Synonym for hasAnyInteraction
  */
  EXPORT isAny := hasAnyInteraction;
	
	/*
		isDisjoint
  */
	EXPORT BOOLEAN isDisjoint(const string  thisGeom, const string  thatOtherGeom, INTEGER4  srid) := FUNCTION
		return hasSpatialRelation(thisGeom,thatOtherGeom,RelationType.DISJOINT,srid);
	END;
	
	

END;

/*
***********************************************************************
Spatial Operation Modules
***********************************************************************

Operations that can be performed on Spatial Geometries

*/
EXPORT Operation := MODULE
	
  /*
		BoundingBox

    Generate a Bounding box which envelopes the given [subjectWKT]
  */	
	EXPORT STRING boundingBox(const string  subjectWKT,  INTEGER4 srid) := function
    STRING srs := ExtLibSpatial.SRS(srid);
		return ExtLibSpatial.bbox(subjectWKT, srs);
	END;
	
	/*
		distanceBetween

		Calculate the distance between 2 points, using the projection given by srid
	*/
	EXPORT REAL8 distanceBetween(const string  point_A_WKT, const string  point_B_WKT, INTEGER4 srid) := FUNCTION
		STRING srs := ExtLibSpatial.SRS(srid);
    return ExtLibSpatial.distanceBetween(point_A_WKT,point_B_WKT,srs);
	END;
	
	/*
		interiorArea

		Calculate the area of the given geometry
	*/
	EXPORT REAL8 interiorArea(const string geometryWKT, INTEGER4 srid) := FUNCTION
		STRING srs := ExtLibSpatial.SRS(srid);
    return ExtLibSpatial.interiorArea(geometryWKT,srs);
	END;
	
	/*
		convexHull

		Calculate the convexHull..shrinkwrapped extent of the given geometry
	*/
	EXPORT STRING convexHull(const string geometryWKT, INTEGER4 srid) := FUNCTION
		STRING srs := ExtLibSpatial.SRS(srid);
    return ExtLibSpatial.convexHull(geometryWKT,srs);
	END;
  
  /*
		buffer

		Calculate the buffer giving a distance		
	*/
	EXPORT STRING buffer(const string geometryWKT, REAL8 distance, INTEGER4 srid) := FUNCTION
		// WGS84_SRID - distance 0.01 roughly a 1 mile square box
		STRING srs := ExtLibSpatial.SRS(srid);
    return ExtLibSpatial.buffer(geometryWKT,distance,srs);
	END;
	
	/*
		centroid

		Calculate the central point of the given geometry
	*/
	EXPORT STRING centroid(const string geometryWKT, INTEGER4 srid) := FUNCTION
  	STRING srs := ExtLibSpatial.SRS(srid);
		return ExtLibSpatial.centroid(geometryWKT,srs);
	END;
		
	EXPORT string union(const string  point_A_WKT, const string  point_B_WKT, INTEGER4 srid) := FUNCTION
		STRING srs := ExtLibSpatial.SRS(srid);	
    return ExtLibSpatial.union(point_A_WKT,point_B_WKT,srs);
	END;
		
  EXPORT STRING tranformToProjection(const string geometryWKT, INTEGER4 sourceSRID, INTEGER4 targetSRID) := FUNCTION
    STRING srs1 := ExtLibSpatial.SRS(sourceSRID);
    STRING srs2 := ExtLibSpatial.SRS(targetSRID);
    out_geometryWKT:= IF(sourceSRID=targetSRID OR sourceSRID=0 OR targetSRID=0, geometryWKT,
							ExtLibSpatial.tranformToProjection(geometryWKT,srs1,srs2));
		return out_geometryWKT;
	END;
  
  EXPORT STRING fromBNGToWGS84(STRING geom) := FUNCTION
    return tranformToProjection(geom, 27700, 4326);
  END;
  
  EXPORT STRING fromWGS84ToBNG(STRING geom) := FUNCTION
    return tranformToProjection(geom, 4326, 27700);
  END;
	
	EXPORT STRING fromINGToWGS84(STRING geom) := FUNCTION
    return tranformToProjection(geom, 29902, 4326);
  END;
	
	EXPORT STRING fromWGS84ToING(STRING geom) := FUNCTION
    return tranformToProjection(geom, 4326, 29902);
  END;	
	
	EXPORT INTEGER4 UTMZoneSRIDForWGS84Point(const string geometryWKT) := FUNCTION
		return ExtLibSpatial.UTMZoneSRIDForWGS84Point(geometryWKT);
	END;
  	
	EXPORT INTEGER4 UTMZoneSRIDForWGS84Polygon(STRING GEOM) := FUNCTION
		return UTMZoneSRIDForWGS84Point(
			centroid(
				GEOM, 
				Projection.WGS84
			)
		);
	END;
	
    // assumes WGS84
  EXPORT STRING pointToUTM(const string pointWKT) := FUNCTION
      return tranformToProjection(pointWKT, 4326, UTMZoneSRIDForWGS84Point(pointWKT));
  END;
  
    // assumes WGS84
  EXPORT STRING polygonToUTM(const string polygonWKT) := FUNCTION
      return tranformToProjection(polygonWKT, 4326, UTMZoneSRIDForWGS84Polygon(polygonWKT));
  END;
 
   // Parse bounding box
  EXPORT SET OF REAL4 MinXY_MaxXY_Of_BBOX(STRING BBOX) := FUNCTION 
     GeomTokens := STD.STr.SplitWords(STD.Str.FindReplace(BBOX,', ',' '),'(('); 
     BBOX_Split1:=GeomTokens[2]; 
     GeometryType := TRIM(GeomTokens[1],LEFT,RIGHT); 
     BBOXSet:=STD.STr.SplitWords(TRIM(BBOX_Split1[1..LENGTH(BBOX_Split1)-2],LEFT,RIGHT),' ');
     SET OF REAL4 xCoordSet := (SET OF REAL4)[BBOXSet[1], BBOXSet[3], BBOXSet[5],BBOXSet[7],BBOXSet[9]]; 
     SET OF REAL4 yCoordSet := (SET OF REAL4)[BBOXSet[2], BBOXSet[4], BBOXSet[6],BBOXSet[8],BBOXSet[10]]; 
     
     return [MIN(xCoordSet),MIN(yCoordSet),MAX(xCoordSet),MAX(yCoordSet)];
     
   END;
	 
	 EXPORT SET OF REAL4 XY_Of_BBOX(STRING BBOX) := FUNCTION 
     GeomTokens := STD.STr.SplitWords(STD.Str.FindReplace(BBOX,', ',' '),'(('); 
     BBOX_Split1:=GeomTokens[2]; 
     GeometryType := TRIM(GeomTokens[1],LEFT,RIGHT); 
     BBOXSet:=STD.STr.SplitWords(TRIM(BBOX_Split1[1..LENGTH(BBOX_Split1)-2],LEFT,RIGHT),' ');
		 SET OF REAL xCoordSet := (SET OF REAL)[BBOXSet[1], BBOXSet[3], BBOXSet[5],BBOXSet[7],BBOXSet[9]]; 
     SET OF REAL yCoordSet := (SET OF REAL)[BBOXSet[2], BBOXSet[4], BBOXSet[6],BBOXSet[8],BBOXSet[10]]; 
		 // TL, BL, BR, TR
		 return (SET OF REAL)[MIN(xCoordSet), MAX(yCoordSet), MIN(xCoordSet), MIN(yCoordSet), MAX(xCoordSet), MIN(yCoordSet), MAX(xCoordSet), MAX(yCoordSet)];     
		 //return (SET OF REAL)[xCoordSet[1], yCoordSet[1], xCoordSet[2], yCoordSet[2], xCoordSet[3], yCoordSet[3], xCoordSet[4], yCoordSet[4]];     		 
   END;
 
   // Parse Lng,Lat from String
   EXPORT SET OF REAL4 XY_Of_Point(STRING POINT) := FUNCTION 
     GeomTokens := STD.STr.SplitWords(STD.Str.FindReplace(POINT,', ',' '),'('); 
     POINT_Split1:=GeomTokens[2]; 
     GeometryType := TRIM(GeomTokens[1],LEFT,RIGHT); 
     POINTSet:=STD.STr.SplitWords(TRIM(POINT_Split1[1..LENGTH(POINT_Split1)-1],LEFT,RIGHT),' ');

     return (SET OF REAL4)[POINTSet[1],POINTSet[2]];
   END;
 
   // Create WKT Point  string from Lng,Lat
   EXPORT STRING Point_Of_XY(REAL4 x, REAL4 y) := FUNCTION 
		 return 'POINT('+x+' '+y+')';
   END;
   
   EXPORT STRING BBOX_OF_POINTS(REAL4 minX, REAL4 minY, REAL4 maxX, REAL4 maxY) := FUNCTION
     return  'POLYGON (( '+MinX + ' ' +MaxY + ', '+MinX +' '+ MinY +', '
    + MaxX +' ' + MinY +', ' + MaxX +' ' +MaxY +', '+  MinX +' ' + MaxY +' ))';
   END;
	 
	 // EXPORT SET OF STRING SET_OF_Xs(STRING POLYGON) := FUNCTION
		
	 // END;
  
  
  /**
  SplitPolygonDataSet

  split a large polygon into smaller polygons with no more vertices than max_poly_vertices

  @param geom     : the WKT of the large Geometry
  @param epsg_id   : the Spatial Reference System EPSG ID
  @param max_poly_vertices : the max vertices the smaller poygons should have
  @return DATASET(GeometryLayout) : the collection of smaller polygons (many WKT geom strings)

  */
   EXPORT DATASET(GeometryLayout) SplitPolygon(STRING geom, INTEGER1 max_poly_vertices, INTEGER1 epsg_id) := FUNCTION
      STRING srs := ExtLibSpatial.SRS(epsg_id);	
      return ExtLibSpatial.SplitPolygon(geom,max_poly_vertices,srs);
   END;
   
 
END;

/*
***********************************************************************
Factory Module
***********************************************************************

	Encapsulates functions which create geometries
*/
EXPORT Factory := MODULE
  EXPORT CreateWKTPointFromXY := Operation.Point_Of_XY;
  EXPORT CreateSetOfXYFromWKTPoint := Operation.XY_Of_Point;
  EXPORT CreateBBOXPoly := Operation.BBOX_OF_POINTS;
END;


/*
***********************************************************************
Ordering Module
***********************************************************************

	Encapsulates algorithms and datastructures that will be used for to determine keys for
  sorting based on geo-spatial coordinates... once sorted items can be grouped and rolledup
  depdending on the problem trying to be solved.
*/

EXPORT Ordering := MODULE

/*
	  Morton key, used as part of a Z-Ordering strategy, this is a quick way to give a GEO Spatial
    entity a cluster id which we can then  ROLLUP/DEDUP by

    this procedure calculates the Morton number of a cell
    at the given row and col[umn]  

    Written:  D.M. Mark, Jan 1984;
    Converted to Vax/VMS: July 1985
    Added to ECL by Andrew Farrell: March 2014
*/
EXPORT UNSIGNED4 MortonKey(UNSIGNED4 col, UNSIGNED4 row) :=BEGINC++

   unsigned key;
   int level, left_bit, right_bit, quadrant;

   key = 0;
   level = 0;
   while ((row>0) || (col>0))
   {
/*   split off the row (left_bit) and column (right_bit) bits and
     then combine them to form a bit-pair representing the
     quadrant                                                  */

     left_bit  = row % 2;
     right_bit = col % 2;
     quadrant = right_bit + 2*left_bit;

     key += quadrant<<(2*level);

/*   row, column, and level are then modified before the loop
     continues                                                */

     row /= 2;
     col /= 2;
     level++;
   }
	
	return key;
ENDC++;

END;

/*
***********************************************************************
Validation Module
***********************************************************************

Contains functions to validation assertions made on geometries
*/
EXPORT Validation := MODULE
	EXPORT boolean isValid(const string geometryWKT, INTEGER4 srid) := FUNCTION
		STRING srs := ExtLibSpatial.SRS(srid);
    return ExtLibSpatial.isValid(geometryWKT, srs);
	END;
	
	EXPORT boolean isRing(const string geometryWKT, INTEGER4 srid) := FUNCTION
    STRING srs := ExtLibSpatial.SRS(srid);
		return ExtLibSpatial.isRing(geometryWKT, srs);
	END;
	
	EXPORT boolean isSimple(const string geometryWKT, INTEGER4 srid) := FUNCTION
    STRING srs := ExtLibSpatial.SRS(srid);
		return ExtLibSpatial.isSimple(geometryWKT, srs);
	END;
	
	EXPORT boolean isEmpty(const string geometryWKT, INTEGER4 srid) := FUNCTION
		STRING srs := ExtLibSpatial.SRS(srid);
    return ExtLibSpatial.isEmpty(geometryWKT, srs);
	END;
	
END;


/*
***********************************************************************
Internal mappings of Geometry.<function/field name> 
to <Module>.<function/field name>
***********************************************************************
*/

	/*
  Geometry Format
  */
	EXPORT GeometryFormat := FileFormat.GeometryFormat;
	
	/*
		'Is' <this geometry in WKT> in a valid relation <relType> with <otherWKT geometry in WKT>
	*/
	EXPORT BOOLEAN Is(String thisWKT, Filter.RelationType relType, String otherWKT, UNSIGNED4 srid) := FUNCTION
    BOOLEAN result := Filter.hasSpatialRelation(thisWKT,otherWKT,relType,srid);
		return result;
	END;
	
	/*
		Apply a spatial filter to a given dataset, keep matching records

		FilterIf <needleGEOM geometry in WKT> is in a valid relation <relType> with <haystackDSet.GEOM in WKT>
	*/
	EXPORT FilterIf(needleGEOM,relType,haystackDSet,srid,GEOMETRY_FIELD='GEOM') := FUNCTIONMACRO
		return haystackDSet(Geometry.Is(needleGEOM,relType, haystackDSet.GEOMETRY_FIELD, srid));
	ENDMACRO;
	
	/*
  FILTERS
	*/
	EXPORT RelationType := Filter.RelationType; // ENUM

	EXPORT isPointInPolygon := Filter.isPointInPolygon;	
	EXPORT isPointNotInPolygon := Filter.isPointNotInPolygon;
	EXPORT isWithin := Filter.isWithin;
	EXPORT isIntersecting := Filter.isIntersecting;
	EXPORT isTouching := Filter.isTouching;
	EXPORT isCrossing := Filter.isCrossing;
	EXPORT isContainedBy := Filter.isContainedBy;
	EXPORT isOverlapping := Filter.isOverlapping;
	EXPORT isEqualTo := Filter.isEqualTo;
	EXPORT isDisjoint := Filter.isDisjoint;
	EXPORT hasAnyInteraction := Filter.hasAnyInteraction;
  EXPORT isAny := Filter.isAny;
  
	/*
	OPERATIONS
  */
	EXPORT BoundingBox := Operation.BoundingBox;
	EXPORT distanceBetween := Operation.distanceBetween;
	EXPORT interiorArea := Operation.interiorArea;
	EXPORT UTMZoneSRIDForWGS84Point := Operation.UTMZoneSRIDForWGS84Point;
	EXPORT UTMZoneSRIDForWGS84Polygon := Operation.UTMZoneSRIDForWGS84Polygon;
	EXPORT convexHull := Operation.convexHull;
  EXPORT buffer := Operation.buffer;
	EXPORT centroid := Operation.centroid;
	EXPORT union := Operation.union;
  EXPORT tranformToProjection := Operation.tranformToProjection;
  EXPORT toSRID := Operation.tranformToProjection;
  EXPORT pointToUTM := Operation.pointToUTM;
  EXPORT polygonToUTM := Operation.polygonToUTM;
  EXPORT fromBNGToWGS84 := Operation.fromBNGToWGS84;
  EXPORT fromWGS84ToBNG := Operation.fromWGS84ToBNG;
  EXPORT BNGToWGS84 := Operation.fromBNGToWGS84;
	EXPORT INGToWGS84 := Operation.fromINGToWGS84;
  EXPORT WGS84ToBNG := Operation.fromWGS84ToBNG;
	EXPORT WGS84ToING := Operation.fromWGS84ToING;
	EXPORT MinXY_MaxXY_Of_BBOX := Operation.MinXY_MaxXY_Of_BBOX;
	EXPORT XY_Of_BBOX := Operation.XY_Of_BBOX;
	EXPORT XY_Of_Point := Operation.XY_Of_Point;
  EXPORT toXY := Operation.XY_Of_Point;
	EXPORT Point_Of_XY := Operation.Point_Of_XY;
	EXPORT BBOX_OF_POINTS := Operation.BBOX_OF_POINTS;
  EXPORT GetSRS(INTEGER2 epsg_id) := ExtLibSpatial.SRS(epsg_id);
  EXPORT SplitPolygon := Operation.SplitPolygon;


  /*
  VALIDATION
  */
	EXPORT isValid :=  Validation.isValid;
	EXPORT isRing :=  Validation.isRing;
	EXPORT isSimple :=  Validation.isSimple;
	EXPORT isEmpty :=  Validation.isEmpty;
	

	
	/* 
  ORDERING
  */
	EXPORT MortonKey := Ordering.MortonKey;
  

	
	
	
/* 
***********************************************************************
 Spatial Index functions
***********************************************************************
*/

/**
  ToIndexReadyInteger

  INDEX does not support REAL... so we convert it to INTEGER and pad it with zeros
  
  @param number : the number to process, STRING to ensure original number is not reformatted
*/
 EXPORT INTEGER ToIndexReadyInteger(STRING number) := FUNCTION
  // truncates a number that has a precision value
  TruncateGridOrGeodeticAndPadBase10(STRING number) := FUNCTION
    SET OF STRING ScalePrecisionPair := STD.Str.SplitWords(number, '.',1);
    INTEGER ScaleLength := LENGTH(ScalePrecisionPair[1]);
    INTEGER PrecisionLength := LENGTH(ScalePrecisionPair[2]);
    INTEGER AdjustedPrecision := IF(ScaleLength <=3, 6, 3);
    
    // if the scale (left of decimal point) is less than 3 (e.g. like WGS 84) then we pad with 6 zeros, otherwise 3
    // we truncate the precision as appropriate
    REAL AdjustedNumber := (REAL)(ScalePrecisionPair[1]+'.'+ScalePrecisionPair[2][1..AdjustedPrecision]);

    // multiply by 10 pow AdjustedPrecision
    return (INTEGER)(AdjustedNumber*POWER(10,AdjustedPrecision));
  END;
  
  // just pads number with 3 zeros.... for numbers without precision (i.e. 0 decimal places)
  PadBase10Pow3(STRING number) := FUNCTION
    INTEGER adjustedNumber := ((INTEGER)number)*POWER(10,3);
    return adjustedNumber;
  END;
  
  // if there is a decimal point, apply special precision rules, else just pad with 3 zeros
  return IF(STD.Str.Find(number, '.') > 0,TruncateGridOrGeodeticAndPadBase10(number),PadBase10Pow3(number));
END;

  /*
    PopulateBoundingBox

     Assuming that the given dataset has all required BBOX fields, establish the Bounding box
     of the geometry field and then parse the individual points MIN/MAX of each axis.

     The BBOX values are then added via a TRANSFORM
  */
	
	EXPORT PopulateBoundingBox(dSetIn,dsetOut,srid,GEOMETRY_FIELD='GEOM'):= FUNCTIONMACRO
      
      // Transform adding the BBOX details, INDEX does not support REAL data types, that why we use ToIndexReadyInteger
			dsetOut BBOXTransform(dSetIn L) := TRANSFORM
					SELF.BBOX := Geometry.BoundingBox(L.GEOMETRY_FIELD,srid); // create a BBOX from the larger WKT Polygon
					SET OF REAL4 BBOX_SET := Geometry.MinXY_MaxXY_Of_BBOX(SELF.BBOX);
					SELF.BBOXMinX := Geometry.ToIndexReadyInteger((STRING)BBOX_SET[1]);
					SELF.BBOXMinY := Geometry.ToIndexReadyInteger((STRING)BBOX_SET[2]);
					SELF.BBOXMaxX := Geometry.ToIndexReadyInteger((STRING)BBOX_SET[3]);
					SELF.BBOXMaxY := Geometry.ToIndexReadyInteger((STRING)BBOX_SET[4]);
					// SELF.GEOMETRY_FIELD := SELF.BBOX;
					SELF := L;
			END;		
			
			return PROJECT(dSetIn,BBOXTransform(LEFT));
  ENDMACRO;

  /*
    CreateBBOXIndex

    Assuming that the given dataset has all required populated BBOX fields, create an index
  */
	EXPORT CreateBBOXIndex(dSet, idx_file) := FUNCTIONMACRO
		RETURN INDEX(dSet, {BBOXMinX, BBOXMinY, BBOXMaxX, BBOXMaxY},{ __fpos}, idx_file, SORTED);
	ENDMACRO;
	
	/*
    SearchBBOXIndex

    For a given dataset and index find all Bounding Boxes that contain the given Geometry
  */
	EXPORT SearchBBOXIndex(dSet, IDX, GEOM) := FUNCTIONMACRO
	  
		TYPEOF(dSet) copy(dSet l) := TRANSFORM
		 SELF := l;
		END;
		
		SET OF REAL4 XY_SET := Geometry.XY_Of_Point(GEOM);
		INTEGER4 X := Geometry.ToIndexReadyInteger((STRING)XY_SET[1]);
		INTEGER4 Y := Geometry.ToIndexReadyInteger((STRING)XY_SET[2]);

		return FETCH(dSet,
      IDX(
			  BBOXMinX < X,
        BBOXMinY < Y,
				BBOXMaxX > X,
        BBOXMaxY > Y
				),
      RIGHT.__fpos,
      copy(LEFT));
		
	ENDMACRO;
  
  /**
    IsWithinBBOX
    
    Asserts if a point is within the given records' boundingbox window
    
    @param GEOM a wkt point string
    @param rec a record that used layout BoundingBoxLayout
  */
  EXPORT IsWithinBBOX(GEOM,rec) := FUNCTIONMACRO
  	
		SET OF REAL4 XY_SET := Geometry.XY_Of_Point(GEOM);
		INTEGER4 X := Geometry.ToIndexReadyInteger((STRING)XY_SET[1]);
		INTEGER4 Y := Geometry.ToIndexReadyInteger((STRING)XY_SET[2]);
    
    return  rec.BBOXMinX < X AND rec.BBOXMinY < Y AND rec.BBOXMaxX > X AND rec.BBOXMaxY > Y;
  ENDMACRO;
  
  /**
    IsWithinBBOXandPOLYGON
    
    Asserts if a point is within the given records' boundingbox window,
    then if it is, performs a point in polygon assertion
    
    @param GEOM a wkt point string
    @param rec a record that used layout BoundingBoxLayout
    @para SRID spatial reference system identifier
  */
  EXPORT IsWithinBBOXandPOLYGON(point,rec, SRID) := FUNCTIONMACRO
  	BOOLEAN inBBOX := Geometry.IsWithinBBOX(point,rec);
    return IF(inBBOX,Geometry.IsWithin(point,rec.GEOM,SRID), FALSE); 
  ENDMACRO;
	

  /*
    findPointInBBOXandGeometryUsingINDEX

    For a given dataset and BBOX Index find the geometry containing a point using the BBOX index first
    then each geometry in the result
  */
  EXPORT findPointInBBOXandGeometryUsingINDEX(DSet, BBOX_IDX, ThePoint, SRID) := FUNCTIONMACRO;
		BBOXFoundRset := Geometry.SearchBBOXIndex(DSet, BBOX_IDX, thePoint);
    return BBOXFoundRset(Geometry.Contains(thePoint, SRID));
	ENDMACRO;
  
  /*
    INDEXContains

    For Modules that have a File and BBOX_IDX execute findPointInBBOXandGeometryUsingINDEX for a given POINT
  */
	EXPORT INDEXContains(TheFile, ThePoint, SRID) := FUNCTIONMACRO;
		return Geometry.findPointInBBOXandGeometryUsingINDEX(TheFile.File, TheFile.BBOX_IDX, thePoint, SRID);
	ENDMACRO;
  
  
/* 
***********************************************************************
 Geometry editing functions
***********************************************************************
*/
  
  /**
  SplitPolygonDataSet

  Given a dataset of geometries, find polygons vertices with > _max_vertices and then split
  them into small polygons
  
  Note, the ancestry of _geomDset must include at least the following:
    EXPORT Layout := RECORD
      Geometry.GeometryLayout;
      Geometry.BoundingBoxLayout;
      UNSIGNED8 __fpos{virtual(fileposition)};
    END;

  @param _geomDset     : the Dataset Containing the larger polygons to be split
  @param epsg_id       : the Spatial Reference System EPSG ID
  @param _max_vertices : the max vertices the smaller poygons should have, <= 100 is a good MAX
  @return DATASET(RECORDOF(_geomDset)) : the orignal dataset + small polygons - large polygons

  */
  EXPORT SplitPolygonDataSet(_geomDset,epsg_id,_max_vertices=100) := functionmacro
    // the max vertices smaller polygons should have
    MAX_VERTICES := _max_vertices;
    
  //  O1 := OUTPUT(COUNT(_geomDset), NAMED('TOTAL_BEFORE_SPLIT'));
    
    // prune selection, only need to split polygons with vertices > MAX_VERTICES
    filteredHavingMoreThanMaxVx := _geomDset(STD.STr.CountWords(GEOM,',')+1 > MAX_VERTICES);
    filteredHavingMoreThanMaxVxFposSet := SET(filteredHavingMoreThanMaxVx,__FPos);
    
    // we will place the generated pieces into a child dataset
    // we remove __Fpos, reading a file that written to including __Fpos causes problems
    SmallerPolygonRec :=  RECORD
      // child dataset
      DATASET({RECORDOF(_geomDset) and not __fpos}) smallPolygonsChildDset;
    END;
    
    // FOR EACH record of filteredHavingMoreThanMaxVx BEGIN
    //   take note of the record
    //   split the GEOMETRY into pieces with <= MAX_VERTICES
    // 
    //   FOR EACH small polygon piece BEGIN
    //     copy relevant columns from original to small polygon piece record
    //     caclulate bounds of piece
    //   END
    //
    //   set child dataset = collection of small polygon pieces
    // END
    //
    // Run PROJECT LOCALLY to encourage PARALLEL execution
    //
    smallPolygonResultRset := 
      PROJECT(filteredHavingMoreThanMaxVx, // OUTER PROJECT
        TRANSFORM(SmallerPolygonRec, // OUTER TRANSFORM
          _perilRec := LEFT; // take note of orignal record with Large Polygon
          
          // set the child dataset = collection of small polygons
          SELF.smallPolygonsChildDset:=
            PROJECT(Geometry.SplitPolygon(_perilRec.geom,MAX_VERTICES,epsg_id), // INNER PROJECT
              // we remove __Fpos, reading a file that written to including __Fpos causes problems
              TRANSFORM({RECORDOF(_geomDset) and not __fpos}, // INNER TRANSFORM
                _smallPolygonRec := LEFT;  // small polygon RECORD got from split function
                SELF.GEOM := _smallPolygonRec.GEOM; // small polygon got from split function
                
                // get the bounds, and copy them to the small polygon piece record
                SELF.BBOX := Geometry.BoundingBox(SELF.GEOM,epsg_id);            
                SET OF REAL4 BBOX_SET := Geometry.MinXY_MaxXY_Of_BBOX(SELF.BBOX);
                SELF.BBOXMinX := Geometry.ToIndexReadyInteger((STRING)BBOX_SET[1]);
                SELF.BBOXMinY := Geometry.ToIndexReadyInteger((STRING)BBOX_SET[2]);
                SELF.BBOXMaxX := Geometry.ToIndexReadyInteger((STRING)BBOX_SET[3]);
                SELF.BBOXMaxY := Geometry.ToIndexReadyInteger((STRING)BBOX_SET[4]);
                
                SELF := _perilRec; // copy all relevent original columns to piece record
             ) // END INNER TRANSFORM
            ); // END INNER PROJECT
        ) // END OUTER TRANSFORM
      , 
        LOCAL    // << encourage parallel execution using 'LOCAL'
      ); // END OUTER PROJECT
    
    // Get an aggregate Recordset of all child datasets
    smallPolygonResultRsetFinal := smallPolygonResultRset.smallPolygonsChildDset;

    // Write pieces to file
    // The small polygon result is written out to file so that
    // when it is read back-in there will exist valid __Fpos values : which the layout needs
    OUTPUT(smallPolygonResultRsetFinal, , '~mapview::polysplit::TEMP', OVERWRITE);

    // Load again, and combine
    smallPolyUpdatedDset := DATASET('~mapview::polysplit::TEMP',RECORDOF(_geomDset), THOR);
    combinedFinal := _geomDset(__Fpos not in filteredHavingMoreThanMaxVxFposSet) +  smallPolyUpdatedDset;

    //O3 := OUTPUT(COUNT(combinedFinal), NAMED('TOTAL_AFTER_SPLIT'));
    
   // SEQUENTIAL(O1,O2,O3); // lets make sure the TEMP Small polygon file gets written first
    
    // Strip __Fpos away again before returning result
    return PROJECT(combinedFinal,TRANSFORM({RECORDOF(_geomDset) and not __fpos}, SELF:=LEFT));
  endmacro;
  
/* 
***********************************************************************
 Geometry utility functions
***********************************************************************
*/
  
  /*
    GeometryCollection

    Aggregation of Geometries in a Rset into a single WKT GEOMETRYCOLLECTION String
  */
  EXPORT GeometryCollection(Rset, GEOMETRY_FIELD='GEOM') := FUNCTIONMACRO
		GeomSlice := RECORD
			TYPEOF(Rset.GEOMETRY_FIELD) GEOMETRY_FIELD := Rset.GEOMETRY_FIELD;
		END;

		GeomOnlyRset := TABLE(Rset,GeomSlice);

		  // Concatenate each Geometry string
		GeomSlice ConcatGeometry(GeomSlice prev, GeomSlice cur) := TRANSFORM 
			SELF.GEOMETRY_FIELD := IF(prev.GEOMETRY_FIELD='', cur.GEOMETRY_FIELD, 
							  IF(cur.GEOMETRY_FIELD='', prev.GEOMETRY_FIELD, prev.GEOMETRY_FIELD+','+cur.GEOMETRY_FIELD)
					);
		END;

		GeomSlice MergeGeometry(GeomSlice prev, GeomSlice cur) := TRANSFORM 
			SELF:=cur;
		END;

		collection := AGGREGATE(GeomOnlyRset, GeomSlice,  ConcatGeometry(LEFT,RIGHT), MergeGeometry(LEFT,RIGHT));

		return 'GEOMETRYCOLLECTION(' +collection[1].GEOMETRY_FIELD+')';
  ENDMACRO;
  
   /*
    UnionCollection

    Aggregation of Geometries in a Rset a union is performed for every geometry, more often than not
    creating a large multi-polygon
  */
  EXPORT UnionCollection(Rset, srid, GEOMETRY_FIELD='GEOM') := FUNCTIONMACRO
		GeomSlice := RECORD
			TYPEOF(Rset.GEOMETRY_FIELD) GEOMETRY_FIELD := Rset.GEOMETRY_FIELD;
		END;

		GeomOnlyRset := TABLE(Rset,GeomSlice);

		  // Union each Geometry string
		GeomSlice ConcatGeometry(GeomSlice prev, GeomSlice cur) := TRANSFORM 
			SELF.GEOMETRY_FIELD := IF(prev.GEOMETRY_FIELD='', cur.GEOMETRY_FIELD, 
							  IF(cur.GEOMETRY_FIELD='', prev.GEOMETRY_FIELD, MapViewRestricted.Geometry.union(prev.GEOMETRY_FIELD,cur.GEOMETRY_FIELD,srid))
					);
		END;

		GeomSlice MergeGeometry(GeomSlice prev, GeomSlice cur) := TRANSFORM 
			SELF:=cur;
		END;

		collection := AGGREGATE(GeomOnlyRset, GeomSlice,  ConcatGeometry(LEFT,RIGHT), MergeGeometry(LEFT,RIGHT));

		return collection[1].GEOMETRY_FIELD;
  ENDMACRO;
  
  
/* 
***********************************************************************
 Geometry Format Conversion
***********************************************************************
*/
  /*
    GML

    http://en.wikipedia.org/wiki/Geography_Markup_Language
  */
	EXPORT GMLHandler := MODULE
  
    // A simple layout.. used to store a single gml:featureMember xml record
    EXPORT LineLayout := RECORD
      STRING line;
             UNSIGNED8 __fpos{virtual(fileposition)};
    END;
    
    // A simple layout which stores the GEOM as WKT and the original line
    EXPORT GeomLineLayout := RECORD
      ^.GeometryLayout;
      LineLayout;

    END;
    
    // Move around the delimiters in the GML coordinate string so the coordinates can be used in WKT
    EXPORT CleanCoordinates(STRING input) := FUNCTION
      STRING step1 := STD.Str.FindReplace(input,' ','|'); 
      STRING step2 := STD.Str.FindReplace(step1,',',' ');
      STRING step3 := STD.Str.FindReplace(step2,'|',',');
      return step3;
    END;
    
    
    // this module encapsulates a ECL model correlating to a GML structure
    EXPORT GmlXmlModel := MODULE 
      // A simple temporary string record
      SHARED StrRec := RECORD
        STRING str;
      END;
      
      // postfix non-empty string with comma
      SHARED delim(STRING str) := IF(str='','',str+',');
      
      // GmlXmlModel.GmlLayout ... represets the XML structure as ECL REcord Layouts
      EXPORT GmlLayout := MODULE
      
        // gml:LinearRing
        EXPORT GMLLinearRingRec := RECORD
          STRING coordinates;
        END;

        // gml:Polygon
        EXPORT GMLPolygonRec := RECORD
          RECORDOF(GMLLinearRingRec) outerBoundaryIs;
          DATASET(GMLLinearRingRec) innerBoundaryIs ;
        END;

        // gml:PolygonMember
        EXPORT GMLPolygonMemberRec := RECORD
          DATASET(GMLPolygonRec) polygon;
        END;

        // gml:MultiPolygon
        EXPORT GMLMultiPolygonRec := RECORD
          DATASET(GMLPolygonMemberRec) polygonMember;
        END;

        // gml:Point
        EXPORT GMLPointRec := RECORD
          STRING point;
        END;

        // gml:LineString
        EXPORT GMLLineStringRec := RECORD
          STRING lineString;
        END;

        // gml:GeometryProperty
        EXPORT GMLGeometryPropertyRec := RECORD
          DATASET(GMLMultiPolygonRec) multiPolygon;
          DATASET(GMLPolygonRec) polygon;
          DATASET(GMLPointRec) point;
          DATASET(GMLLineStringRec) lineString;
        END;
        
        // Layout for combining original XML line with model
        EXPORT GMLModelAndLine := RECORD
          GMLGeometryPropertyRec;
          LineLayout;
        END;
      END; // end GmlXmlModel.GmlLayout
      
      // GmlXmlModel.GmlParsing ... encapasulates the GML xpath parsing for each gml element
      EXPORT GmlParsing := MODULE
        // parse children of gml:LinearRing
        SHARED GmlLayout.GMLLinearRingRec LinearRingTRANSFORM := TRANSFORM
          SELF.coordinates := XMLTEXT('gml:LinearRing/gml:coordinates');
        END;
        
        // parse children of gml:Polygon
        SHARED GmlLayout.GMLPolygonRec PolygonTRANSFORM := TRANSFORM
         SELF.innerBoundaryIs := XMLPROJECT('gml:innerBoundaryIs', LinearRingTRANSFORM); 
         SELF.outerBoundaryIs := XMLPROJECT('gml:outerBoundaryIs', LinearRingTRANSFORM)[1];
        END;

        // parse children of gml:PolygonMember
        SHARED GmlLayout.GMLPolygonMemberRec PolygonMemberTRANSFORM := TRANSFORM
          SELF.polygon := XMLPROJECT('gml:Polygon', PolygonTRANSFORM);
        END;

        // parse children of gml:MultiPolygon
        SHARED GmlLayout.GMLMultiPolygonRec MultiPolygonTRANSFORM := TRANSFORM
          SELF.polygonMember := XMLPROJECT('gml:polygonMember', PolygonMemberTRANSFORM);
        END;
        
        // parse children of gml:Point
        SHARED GmlLayout.GMLPointRec PointTRANSFORM := TRANSFORM
          SELF.point := XMLTEXT('gml:coordinates');
        END;

         // parse children of gml:LineString
        SHARED GmlLayout.GMLLineStringRec LineStringTRANSFORM := TRANSFORM
          SELF.lineString := XMLTEXT('gml:coordinates');
        END;

         // parse children of gml:GeometryProperty
        SHARED GmlLayout.GMLGeometryPropertyRec GeometryPropertyTRANSFORM := TRANSFORM
          SELF.multiPolygon := XMLPROJECT('gml:MultiPolygon', MultiPolygonTRANSFORM);
          SELF.polygon := XMLPROJECT('gml:Polygon', PolygonTRANSFORM);
          SELF.point := XMLPROJECT('gml:Point', PointTRANSFORM);
          SELF.lineString := XMLPROJECT('gml:LineString', LineStringTRANSFORM);
        END;
        
        // parse children of feature, root from current context
        SHARED GmlLayout.GMLModelAndLine GMLModelAndLineTRANSFORM(LineLayout L) := TRANSFORM
          SELF := XMLPROJECT('ogr:geometryProperty', GeometryPropertyTRANSFORM)[1];
          SELF := L;
        END;
        
        // Perform the parse of GML Elements
        EXPORT ParseGmlXml(DATASET(LineLayout) gmlXmlDset) := FUNCTION 
          gmlModelDset := PARSE(gmlXmlDset, line, GMLModelAndLineTRANSFORM(LEFT), XML('/*')) : independent; 
          return gmlModelDset;
        END;
      END; // end GmlXmlModel.GmlParsing
      
      // GmlXmlModel.GmlToWkt ... encapasulates the conversion of the GML XML ECL Record Model to WKT
      EXPORT GmlToWkt := MODULE
        
        // aggregate all LinearRing coordinates into a single string
        SHARED AggregateInnerBoundsChildren(DATASET(GmlLayout.GMLLinearRingRec) innerBoundaryIsDset) := FUNCTION
          return AGGREGATE(
                        innerBoundaryIsDset, StrRec, 
                        TRANSFORM(StrRec, 
                          SELF.str := delim(RIGHT.str) + '('+CleanCoordinates(LEFT.coordinates)+')';//'ZZZ('+CleanCoordinates(LEFT.coordinates)+')';
                        ),
                        TRANSFORM(StrRec, SELF.str := '('+RIGHT1.str + ',' + RIGHT2.str+')')
                  )[1].str;
        END;

         // aggregate all Polygon inner/outer coordinates into a single string
        SHARED AggregatePolygonChildren(DATASET(GmlLayout.GMLPolygonRec) polygonDset) := FUNCTION
          return AGGREGATE(
                        polygonDset, StrRec, 
                        TRANSFORM(StrRec, 
                          STRING innerBounds := AggregateInnerBoundsChildren(LEFT.innerBoundaryIs);

                          SELF.str := delim(RIGHT.str) + '('+ CleanCoordinates(LEFT.outerBoundaryIs.coordinates)+')'+IF(innerBounds='','',','+innerBounds+'');
                        ),
                        TRANSFORM(StrRec, SELF.str := '('+RIGHT1.str + ',' + RIGHT2.str+')')
                  )[1].str;
        END;

        // aggregate all multipolygon polygons into a single string
        SHARED AggregatePolygonMemberChildren(DATASET(GmlLayout.GMLPolygonMemberRec) polygonMemberDset) := FUNCTION
          return  AGGREGATE(
             polygonMemberDset, StrRec, 
              TRANSFORM(StrRec, 
                SELF.str := delim(RIGHT.str) + '('+AggregatePolygonChildren(LEFT.polygon)+')';
              ),
              TRANSFORM(StrRec, SELF.str := '('+RIGHT1.str + ',' + RIGHT2.str + ')')
            )[1].str;
        END;

        // aggregate all multipolygons into a single string
        SHARED AggregateMultiPolygonChildren(DATASET(GmlLayout.GMLMultiPolygonRec) multiPolygonDset) := FUNCTION
          return AggregatePolygonMemberChildren(multiPolygonDset[1].polygonMember);
        END;

        // aggregate all points into a single string
        SHARED AggregatePointChildren(DATASET(GmlLayout.GMLPointRec) pointDset) := FUNCTION
          return CleanCoordinates(pointDset[1].point);
        END;

        // aggregate all line strings into a single string
        SHARED AggregateLineStringChildren(DATASET(GmlLayout.GMLLineStringRec) lineStringDset) := FUNCTION
          return CleanCoordinates(lineStringDset[1].lineString);
        END;

        // transform the first populated element in the ECL Record GML model into WKT
        EXPORT GeomLineLayout geometryToWKT_TRANSFORM(GmlLayout.GMLModelAndLine L) := TRANSFORM
          
          SELF.GEOM := MAP(
                EXISTS(L.multiPolygon) => 'MULTIPOLYGON(' + AggregateMultiPolygonChildren(L.multiPolygon) + ')',
                EXISTS(L.polygon) => 'POLYGON(' + AggregatePolygonChildren(L.polygon) + ')',
                EXISTS(L.point) => 'POINT(' + AggregatePointChildren(L.point) + ')',
                EXISTS(L.lineString) => 'LINESTRING(' + AggregateLineStringChildren(L.lineString) + ')',
                'NO_GML_GEOM_TYPE_DETECTED'
              ) ;
              
         SELF:=L;
        END;
        
      END; // end GmlXmlModel.GmlToWkt
      
      // Parse, Create an ECL Model of the GML, then aggregate into WKT
      EXPORT ParseWKT(DATASET(LineLayout) xml_Dset) := FUNCTION
        gmlParsedDset  := GmlParsing.ParseGmlXml(xml_Dset);
        return PROJECT(gmlParsedDset, GmlToWkt.geometryToWKT_TRANSFORM(LEFT));
      END;
    END; // end GmlXmlModel

   
    // Use a user supplied transform to parse an entire record.. with the coordinates converted to WKT
    EXPORT ToWKT(xml_Dset,transformToUse,memberPropTag) := FUNCTIONMACRO
        GeomLine_Rset :=  Geometry.GMLHandler.GmlXmlModel.ParseWKT(xml_Dset);
        
        return PARSE(GeomLine_Rset,line,transformToUse(LEFT),XML('/*/'));
    ENDMACRO;
    
    // assuming a file has been sprayed using a delimited spray... load the file and convert the coordinates to WKT
    EXPORT LoadGMLDataset(ns, filename, transformToUse, featureCollectionXMLTag, rowXMLTag, memberPropTag) := FUNCTIONMACRO
        gmlDataSet := DATASET(
          filename,
          Geometry.GMLHandler.LineLayout,
          CSV(
            HEADING(1),
            SEPARATOR([])
            ,           TERMINATOR(['<'+ns+':boundedBy>','</'+ns+':boundedBy>','<'+featureCollectionXMLTag+'>','</'+featureCollectionXMLTag+'>','<'+rowXMLTag+'>','</'+rowXMLTag+'>'])
          )
        );
        
        // only use non-blank lines
        gmlDataSetNotBlank := gmlDataSet(line!='');
        
        return Geometry.GMLHandler.ToWKT(gmlDataSetNotBlank, transformToUse, memberPropTag) ;
    ENDMACRO;
    
    EXPORT getFeatureTag(logicalFile) := FUNCTIONMACRO
      featureCollectionXMLTag := 'ogr:FeatureCollection';
      rowXMLTag := 'gml:featureMember';
      
      gmlDataSet := choosen(DATASET(
            logicalFile,
             MapViewRestricted.Geometry.GMLHandler.LineLayout,
            CSV(
              HEADING(1),
              SEPARATOR([])
              ,           TERMINATOR(['<ogr:boundedBy>','</ogr:boundedBy>','<'+featureCollectionXMLTag+'>','</'+featureCollectionXMLTag+'>','<ogr:'])
            )
          ),10);
        
        
      return TRIM('ogr:'+STD.STr.SplitWords(gmlDataSet(STD.STr.CountWords(line,'fid=') > 1 )[1].line,' ')[1],LEFT,RIGHT);
   ENDMACRO;
      // assuming a file has been sprayed using a delimited spray... load the file and convert the coordinates to WKT
    EXPORT LoadGMLLogicalFile(filename, transformToUse) := FUNCTIONMACRO
        
        STRING memberPropTag := MapViewRestricted.Geometry.GMLHandler.getFeatureTag(filename);
        
        gmlDataSet := DATASET(
          filename,
          Geometry.GMLHandler.LineLayout,
          CSV(
            HEADING(1),
            SEPARATOR([])
            ,           TERMINATOR(['<ogr:boundedBy>','</ogr:boundedBy>','<ogr:FeatureCollection>','</ogr:FeatureCollection>','<gml:featureMember>','</gml:featureMember>'])
          )
        );
        
        // only use non-blank lines
        gmlDataSetNotBlank := gmlDataSet(line!='');
        
        return MapViewRestricted.Geometry.GMLHandler.ToWKT(gmlDataSetNotBlank, transformToUse, memberPropTag) ;
    ENDMACRO;
      
  END;
  
  /**
    LoadGMLDataset
    
    Exposed at Geometry level as issues experienced when calling functionmacro Geometry.GMLHandler.LoadGMLDataset
    from outside Geometry.
  */
  EXPORT LoadGMLDataset(ns, filename, transformToUse, featureCollectionXMLTag, rowXMLTag, memberPropTag)  := FUNCTIONMACRO
    return Geometry.GMLHandler.LoadGMLDataset(ns, filename, transformToUse, featureCollectionXMLTag, rowXMLTag, memberPropTag);
  ENDMACRO;
  
    /**
    LoadGMLLogicalFile
    
    Same as LoadGMLDataset but auto detects the currect GML XML tags to use
    
    Exposed at Geometry level as issues experienced when calling functionmacro Geometry.GMLHandler.LoadGMLDataset
    from outside Geometry.
  */
  EXPORT LoadGMLLogicalFile(filename, transformToUse)  := FUNCTIONMACRO
    return Geometry.GMLHandler.LoadGMLLogicalFile(filename, transformToUse);
  ENDMACRO;
  
  
/*
***********************************************************************
Rtree Spatial Index Module
***********************************************************************

Encapsulates functions for the creation and searching of Rtree data
structures

@author afarrell September 2014
*/

EXPORT Rtree := MODULE



/*
CreateRtreeIndex

Create an Rtree hierachy from the given BBOX dataset, generate interval bounding rectangles
*/
EXPORT LINKCOUNTED DATASET(RTreeIndexLayout) CreateRtreeIndex(DATASET(BBOXIndexLayout__FposOfDset) bboxInx,INTEGER4 pidoffset,INTEGER4 minX=2147483647,INTEGER4 minY=2147483647, INTEGER4 maxX=2147483647, INTEGER4 maxY=2147483647):= BEGINC++
#option library 'geos'
// #option once : Indicates the function has no side effects and is evaluated at query execution time, even if the parameters are constant, allowing the optimizer to make more efficient calls to the function in some cases.
#option once


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdarg.h>
#include <limits.h>


// records

typedef struct inRec {
	int bboxminx;
	int bboxminy;
	int bboxmaxx;
	int bboxmaxy;
	unsigned __int64 fpos;
} inRec_t;  

typedef struct outRec {
	int nodeId;
	int parentNodeId;
	int level3ParentNodeId;
	int level4ParentNodeId;
	int bboxminx;
	int bboxminy;
	int bboxmaxx;
	int bboxmaxy;
	unsigned __int64 fpos;
	int level;
	int nodetype;	
} outRec_t;   


//////////////////////////////////////////////////////////////
// START HPCCSTRtree.h
//////////////////////////////////////////////////////////////

/**********************************************************************
*
* GEOS - Geometry Engine Open Source
* http://geos.osgeo.org
*
* Copyright (C) 2006 Refractions Research Inc.
*
* This is free software; you can redistribute and/or modify it under
* the terms of the GNU Lesser General Public Licence as published
* by the Free Software Foundation. 
* See the COPYING file for more information.
*
**********************************************************************
*
* Last port: index/strtree/HPCCSTRtree.java rev. 1.11
*
**********************************************************************/

#ifndef GEOS_INDEX_HPCCSTRTREE_HPCCSTRTREE_H
#define GEOS_INDEX_HPCCSTRTREE_HPCCSTRTREE_H

#include <geos/export.h>
#include <geos/index/strtree/AbstractSTRtree.h> // for inheritance
#include <geos/index/SpatialIndex.h> // for inheritance
#include <geos/geom/Envelope.h> // for inlines

#include <vector>

#ifdef _MSC_VER
#pragma warning(push)
#pragma warning(disable: 4251) // warning C4251: needs to have dll-interface to be used by clients of class
#endif

// Forward declarations
namespace geos {
	namespace index { 
		namespace strtree { 
			class Boundable;
		}
	}
}

namespace geos {
	namespace index { // geos::index
		namespace strtree { // geos::index::strtree

			/**
* \brief
* A query-only R-tree created using the Sort-Tile-Recursive (STR) algorithm. 
* For two-dimensional spatial data. 
*
* The STR packed R-tree is simple to implement and maximizes space
* utilization; that is, as many leaves as possible are filled to capacity.
* Overlap between nodes is far less than in a basic R-tree. However, once the
* tree has been built (explicitly or on the first call to #query), items may
* not be added or removed. 
* 
* Described in: P. Rigaux, Michel Scholl and Agnes Voisard. Spatial
* Databases With Application To GIS. Morgan Kaufmann, San Francisco, 2002. 
*
*/
			class GEOS_DLL HPCCSTRtree: public AbstractSTRtree, public SpatialIndex
			{
				using AbstractSTRtree::insert;
				using AbstractSTRtree::query;

			private:
				class GEOS_DLL STRIntersectsOp: public AbstractSTRtree::IntersectsOp {
				public:
					bool intersects(const void* aBounds, const void* bBounds);
				};

				/**
	* Creates the parent level for the given child level. First, orders the items
	* by the x-values of the midpoints, and groups them into vertical slices.
	* For each slice, orders the items by the y-values of the midpoints, and
	* group them into runs of size M (the node capacity). For each run, creates
	* a new (parent) node.
	*/
				std::auto_ptr<BoundableList> createParentBoundables(BoundableList* childBoundables, int newLevel);

				std::auto_ptr<BoundableList> createParentBoundablesFromVerticalSlices(std::vector<BoundableList*>* verticalSlices, int newLevel);

				STRIntersectsOp intersectsOp;

				std::auto_ptr<BoundableList> sortBoundables(const BoundableList* input);

				std::auto_ptr<BoundableList> createParentBoundablesFromVerticalSlice(
				BoundableList* childBoundables,
				int newLevel);

				/**
	* @param childBoundables Must be sorted by the x-value of
	*        the envelope midpoints
	* @return
	*/
				std::vector<BoundableList*>* verticalSlices(
				BoundableList* childBoundables,
				size_t sliceCount);


			protected:

				AbstractNode* createNode(int level);
				
				IntersectsOp* getIntersectsOp() {
					return &intersectsOp;
				}

			public:

				~HPCCSTRtree();

				/**
	* Constructs an HPCCSTRtree with the given maximum number of child nodes that
	* a node may have
	*/
				HPCCSTRtree(std::size_t nodeCapacity=10);

				void insert(const geom::Envelope *itemEnv,void* item);

				//static double centreX(const geom::Envelope *e);

				static double avg(double a, double b) {
					return (a + b) / 2.0;
				}

				static double centreY(const geom::Envelope *e) {
					return HPCCSTRtree::avg(e->getMinY(), e->getMaxY());
				}

				void query(const geom::Envelope *searchEnv, std::vector<void*>& matches, bool run) {
					AbstractSTRtree::query(searchEnv, matches);
				}
				
				
				void query(const geom::Envelope *searchEnv, std::vector<void*>& matches) {
					AbstractSTRtree::query(searchEnv, matches);
				}


				void query(const geom::Envelope *searchEnv, ItemVisitor& visitor) {
					return AbstractSTRtree::query(searchEnv, visitor);
				}

				bool remove(const geom::Envelope *itemEnv, void* item) {
					return AbstractSTRtree::remove(itemEnv, item);
				}
			};

		} // namespace geos::index::strtree
	} // namespace geos::index
} // namespace geos


#ifdef _MSC_VER
#pragma warning(pop)
#endif

#endif // GEOS_INDEX_HPCCSTRTREE_HPCCSTRTREE_H

//////////////////////////////////////////////////////////////
// END HPCCSTRtree.h
//////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////
// START HPCCSTRtree.cpp
//////////////////////////////////////////////////////////////

/**********************************************************************
*
* GEOS - Geometry Engine Open Source
* http://geos.osgeo.org
*
* Copyright (C) 2006 Refractions Research Inc.
* Copyright (C) 2001-2002 Vivid Solutions Inc.
*
* This is free software; you can redistribute and/or modify it under
* the terms of the GNU Lesser General Public Licence as published
* by the Free Software Foundation. 
* See the COPYING file for more information.
*
**********************************************************************
*
* Last port: index/strtree/HPCCSTRtree.java rev. 1.11
*
**********************************************************************/

//#include "HPCCSTRtree.h" >>>>>>>>>>>>included above
#include <geos/geom/Envelope.h>

#include <vector>
#include <cassert>
#include <cmath>
#include <algorithm> // std::sort
#include <iostream> // for debugging
#include <limits>

using namespace std;
using namespace geos::geom;

namespace geos {
	namespace index { // geos.index
		namespace strtree { // geos.index.strtree


			static bool yComparator(Boundable *a, Boundable *b)
			{
				assert(a);
				assert(b);
				const void* aBounds = a->getBounds();
				const void* bBounds = b->getBounds();
				assert(aBounds);
				assert(bBounds);
				const Envelope* aEnv = static_cast<const Envelope*>(aBounds);
				const Envelope* bEnv = static_cast<const Envelope*>(bBounds);

				// NOTE - mloskot:
				// The problem of instability is directly related to mathematical definition of
				// "strict weak ordering" as a fundamental requirement for binary predicate:
				// 
				// if a is less than b then b is not less than a,
				// if a is less than b and b is less than c
				// then a is less than c,
				// and so on.
				//
				// For some very low values, this predicate does not fulfill this requiremnet,

				// NOTE - strk:
				// It seems that the '<' comparison here gives unstable results.
				// In particular, when inlines are on (for Envelope::getMinY and getMaxY)
				// things are fine, but when they are off we can even get a memory corruption !!
				//return HPCCSTRtree::centreY(aEnv) < HPCCSTRtree::centreY(bEnv);
				
				// NOTE - mloskot:
				// This comparison does not answer if a is "lower" than b
				// what is required for sorting. This comparison only answeres
				// if a and b are "almost the same" or different
				
				/*NOTE - cfis
	In debug mode VC++ checks the predicate in both directions.  
	
	If !_Pred(_Left, _Right)
	Then an exception is thrown if _Pred(_Right, _Left).
	See xutility around line 320:
	
		bool __CLRCALL_OR_CDECL _Debug_lt_pred(_Pr _Pred, _Ty1& _Left, _Ty2& _Right,
		const wchar_t *_Where, unsigned int _Line)*/

				//return std::fabs( HPCCSTRtree::centreY(aEnv) - HPCCSTRtree::centreY(bEnv) ) < 1e-30

				// NOTE - strk:
				// See http://trac.osgeo.org/geos/ticket/293
				// as for why simple comparison (<) isn't used here
				return AbstractSTRtree::compareDoubles(HPCCSTRtree::centreY(aEnv),
				HPCCSTRtree::centreY(bEnv));
			}

			/*public*/
			HPCCSTRtree::HPCCSTRtree(size_t nodeCapacity): AbstractSTRtree(nodeCapacity)
			{ 
			}

			/*public*/
			HPCCSTRtree::~HPCCSTRtree()
			{ 
			}

			bool
			HPCCSTRtree::STRIntersectsOp::intersects(const void* aBounds, const void* bBounds)
			{
				return ((Envelope*)aBounds)->intersects((Envelope*)bBounds);
			}

			/*private*/
			std::auto_ptr<BoundableList>
			HPCCSTRtree::createParentBoundables(BoundableList* childBoundables, int newLevel)
			{
				assert(!childBoundables->empty());
				int minLeafCount=(int) ceil((double)childBoundables->size()/(double)getNodeCapacity());

				std::auto_ptr<BoundableList> sortedChildBoundables ( sortBoundables(childBoundables) );

				std::auto_ptr< vector<BoundableList*> > verticalSlicesV (
				verticalSlices(sortedChildBoundables.get(), (int)ceil(sqrt((double)minLeafCount)))
				);

				std::auto_ptr<BoundableList> ret (
				createParentBoundablesFromVerticalSlices(verticalSlicesV.get(), newLevel)
				);
				for (size_t i=0, vssize=verticalSlicesV->size(); i<vssize; ++i)
				{
					BoundableList* inner = (*verticalSlicesV)[i];
					delete inner;
				}

				return ret;
			}

			/*private*/
			std::auto_ptr<BoundableList>
			HPCCSTRtree::createParentBoundablesFromVerticalSlices(std::vector<BoundableList*>* verticalSlices, int newLevel)
			{
				assert(!verticalSlices->empty());
				std::auto_ptr<BoundableList> parentBoundables( new BoundableList() );

				for (size_t i=0, vssize=verticalSlices->size(); i<vssize; ++i)
				{
					std::auto_ptr<BoundableList> toAdd (
					createParentBoundablesFromVerticalSlice(
					(*verticalSlices)[i], newLevel)
					);
					assert(!toAdd->empty());

					parentBoundables->insert(
					parentBoundables->end(),
					toAdd->begin(),
					toAdd->end());
				}
				return parentBoundables;
			}

			/*protected*/
			std::auto_ptr<BoundableList>
			HPCCSTRtree::createParentBoundablesFromVerticalSlice(BoundableList* childBoundables, int newLevel)
			{
				return AbstractSTRtree::createParentBoundables(childBoundables, newLevel);
			}

			/*private*/
			std::vector<BoundableList*>*
			HPCCSTRtree::verticalSlices(BoundableList* childBoundables, size_t sliceCount)
			{
				size_t sliceCapacity = (size_t) ceil((double)childBoundables->size() / (double) sliceCount);
				vector<BoundableList*>* slices = new vector<BoundableList*>(sliceCount);

				size_t i=0, nchilds=childBoundables->size();

				for (size_t j=0; j<sliceCount; j++)
				{
					(*slices)[j]=new BoundableList(); 
					(*slices)[j]->reserve(sliceCapacity); 
					size_t boundablesAddedToSlice = 0;
					while (i<nchilds && boundablesAddedToSlice<sliceCapacity)
					{
						Boundable *childBoundable=(*childBoundables)[i];
						++i;
						(*slices)[j]->push_back(childBoundable);
						++boundablesAddedToSlice;
					}
				}
				return slices;
			}

			class STRAbstractNode: public AbstractNode{
			public:

				STRAbstractNode(int level, int capacity)
				:
				AbstractNode(level, capacity)
				{}

				~STRAbstractNode()
				{
					delete (Envelope *)bounds;
				}

			protected:

				void* computeBounds() const
				{
					Envelope* bounds=NULL;
					const BoundableList& b = *getChildBoundables();

					if ( b.empty() ) return NULL;

					BoundableList::const_iterator i=b.begin();
					BoundableList::const_iterator e=b.end();

					bounds=new Envelope(* static_cast<const Envelope*>((*i)->getBounds()) );
					for(; i!=e; ++i)
					{
						const Boundable* childBoundable=*i;
						bounds->expandToInclude((Envelope*)childBoundable->getBounds());
					}
					return bounds;
				}

			};

			/*protected*/
			AbstractNode*
			HPCCSTRtree::createNode(int level)
			{
				AbstractNode *an = new STRAbstractNode(level, static_cast<int>(nodeCapacity));
				nodes->push_back(an);
				return an;
			}

			/*public*/
			void
			HPCCSTRtree::insert(const Envelope *itemEnv, void* item)
			{
				if (itemEnv->isNull()) { return; }
				AbstractSTRtree::insert(itemEnv, item);
			}

			/*private*/
			std::auto_ptr<BoundableList>
			HPCCSTRtree::sortBoundables(const BoundableList* input)
			{
				assert(input);
				std::auto_ptr<BoundableList> output ( new BoundableList(*input) );
				assert(output->size() == input->size());

				sort(output->begin(), output->end(), yComparator);
				return output;
			}

		} // namespace geos.index.strtree
	} // namespace geos.index
} // namespace geos

//////////////////////////////////////////////////////////////
// END HPCCSTRtree.cpp
//////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////
// START RTREE Creation and traversal
//////////////////////////////////////////////////////////////

#include <iostream>
#include <sstream>
#include <fstream>      // std::ifstream
#include <string>
#include <cstring>
#include "ogrsf_frmts.h" // GDAL
#include "cpl_conv.h"
#include "gdal_priv.h"
//#include "HPCCSTRtree.h" >>>>>> included above
#include <typeinfo>
#include <iomanip>


using namespace std;


// function prototypes
void csvline_populate(vector<string> &record, const string& line, char delimiter);
bool populate_rtree_from_csv(geos::index::strtree::HPCCSTRtree* tree, const string filename);
void searchRTree(geos::index::strtree::HPCCSTRtree* tree,const geos::geom::Envelope *searchEnvelope);
void traverseTreeList(std::stack<outRec_t *> & outRecStack,geos::index::strtree::ItemsList* itemsTree, int level, int parentId, int & childId, int level3ParentNodeId, int level4ParentNodeId, void *parentRec);

// Node in Rtree
class  HPCCItem
{
public:

	HPCCItem(int _id, unsigned __int64 _fpos,  int _bboxminx, int _bboxminy, int _bboxmaxx, int _bboxmaxy) ;
	virtual ~HPCCItem();

	int getId();
	unsigned __int64 getFpos();
	int get_bboxminx();
	int get_bboxminy();
	int get_bboxmaxx();
	int get_bboxmaxy();

private:

	int id;
	unsigned __int64 fpos;
	int bboxminx;
	int bboxminy;
	int bboxmaxx;
	int bboxmaxy;
};

HPCCItem::HPCCItem(int _id, unsigned __int64 _fpos,  int _bboxminx, int _bboxminy, int _bboxmaxx, int _bboxmaxy) {
	id = _id;
	fpos = _fpos;
	bboxminx = _bboxminx;
	bboxminy = _bboxminy;
	bboxmaxx = _bboxmaxx;
	bboxmaxy = _bboxmaxy;
}

HPCCItem::~HPCCItem()
{
}

int HPCCItem::getId()  {
	return id;
}

int HPCCItem::get_bboxminx()  {
	return bboxminx;
}

int HPCCItem::get_bboxminy()  {
	return bboxminy;
}

int HPCCItem::get_bboxmaxy()  {
	return bboxmaxy;
}

int HPCCItem::get_bboxmaxx()  {
	return bboxmaxx;
}

unsigned __int64 HPCCItem::getFpos()  {
	return fpos;
}

/**
traverseTreeList

Traverse the built STR RTree pushing each discovered node onto a stack
*/
void traverseTreeList(std::stack<outRec_t *> & outRecStack,geos::index::strtree::ItemsList* itemsTree, int level, int parentId, int & childId, int level3ParentNodeId, int level4ParentNodeId, void *parentRec){
	bool indent = true;
	
	// for each node in the RTree, discover children : recursively traverse, add current node to stack
	for (std::vector<geos::index::strtree::ItemsListItem>::iterator it = itemsTree->begin() ; it != itemsTree->end(); ++it)
	{
		int curNodeId = ++childId;
		int _level3ParentNodeId = level3ParentNodeId;
		int _level4ParentNodeId = level4ParentNodeId;
    bool rollupBoundsToParent = true;
    
		void *row =  (outRec_t *) rtlMalloc(sizeof(outRec_t)); // allocate memory for row
		
		// set defaults and node ids
		outRec_t *rec = (outRec_t *) row;
		rec->nodeId = curNodeId;
		rec->parentNodeId = parentId;
		rec->bboxminx = -1;
		rec->bboxmaxx = -1;
		rec->bboxminy = -1;
		rec->bboxmaxy = -1;
		rec->level = level;
		rec->nodetype = it->get_type();
		rec->level3ParentNodeId=_level3ParentNodeId;
		rec->level4ParentNodeId=_level4ParentNodeId;
		
		// children store the level3 and 4 id, usefull for subtree seperation
		if(level==3){
			_level3ParentNodeId=curNodeId;
		}
		else if(level==4){
			_level4ParentNodeId=curNodeId;
		}
		
		// if node is a leaf node
		if(it->get_type()==0){
			HPCCItem* item = static_cast<HPCCItem*>(it->get_geometry());
			rec->fpos = item->getFpos();
			rec->bboxminx = item->get_bboxminx();
			rec->bboxmaxx = item->get_bboxmaxx();
			rec->bboxminy = item->get_bboxminy();
			rec->bboxmaxy = item->get_bboxmaxy();
			outRecStack.push(rec);
		}
		else{ // else if not leaf node
			rec->fpos = INT_MAX;
			geos::index::strtree::ItemsList* childList = it->get_itemslist();
			
			// if the node has children
			if(childList->size() > 0){ 
				outRecStack.push(rec);
				
				// recursivly traverse childList
				traverseTreeList(outRecStack,childList, level+1, curNodeId, childId, _level3ParentNodeId, _level4ParentNodeId, rec);
			}
			else {
				// no point in having a childless leaf node
        rollupBoundsToParent = false;
			}
		}
    
    if(level > 1 && rollupBoundsToParent){
				outRec_t *_parentRec = (outRec_t *) parentRec;
				if(_parentRec->bboxminx==-1 || rec->bboxminx < _parentRec->bboxminx){
					_parentRec->bboxminx =  rec->bboxminx;
				}
				
				if(_parentRec->bboxminy==-1 || rec->bboxminy < _parentRec->bboxminy){
					_parentRec->bboxminy =  rec->bboxminy;
				}
				
				if(_parentRec->bboxmaxy==-1 || rec->bboxmaxy > _parentRec->bboxmaxy){
					_parentRec->bboxmaxy =  rec->bboxmaxy;
				}
				
				if(_parentRec->bboxmaxx==-1 || rec->bboxmaxx > _parentRec->bboxmaxx){
					_parentRec->bboxmaxx =  rec->bboxmaxx;
				}
			}
		
	}
}


//////////////////////////////////////////////////////////////
// END RTREE Creation and traversal
//////////////////////////////////////////////////////////////


/**
createOutputRtreeDataset

Create Dataset from RTree

*/
void createOutputRtreeDataset(geos::index::strtree::HPCCSTRtree* tree, size32_t & __countResult,byte * * & __result, IEngineRowAllocator * _resultAllocator, int _partitionIDOffset){

	std::stack<outRec_t *> outRecStack;

  // root defaults
	int level = 1;
	int parentId = -1;
	// int childId = -1;
	int childId = _partitionIDOffset;
	int level3ParentNodeId = -1;
	int level4ParentNodeId = -1;
  
  // root rec {disregarded}
	void *nullRow =  (outRec_t *) rtlMalloc(sizeof(outRec_t)); 
	
  // traverse root and children of the assembled Rtree
	traverseTreeList(outRecStack, tree->itemsTree(),level,parentId, childId, level3ParentNodeId, level4ParentNodeId, nullRow);

  // set overall totals
	unsigned count = outRecStack.size();
	__countResult = count;
	__result = _resultAllocator->createRowset(count);

  
  // append each row to result
	int i = 0;
	while(!outRecStack.empty()){
		// create row
		size32_t allocSize;
		
		// resize row
		size32_t updatedSize;
		size32_t rowSize = sizeof(outRec_t);
		void *row = outRecStack.top();

		// append row to result
		__result[i++] = (byte *)_resultAllocator->finalizeRow(rowSize, row, updatedSize);
		outRecStack.pop();
	}
  
  free(nullRow); // we used a dummy row for the first traversal iteration, free this now
 
}

#body
{
	//-----------------------------------------------------------------------
	// START MAIN BODY 
	//-----------------------------------------------------------------------


	// : INGEST Dataset into Rtree
	//-----------------------------------------------------------------------

  // create an in-memory STR-RTree with 10 children per node
	geos::index::strtree::HPCCSTRtree* tree = new geos::index::strtree::HPCCSTRtree(10);

	// size
	size32_t sizeOfBBOXInx = lenBboxinx;
	int numRows = sizeOfBBOXInx / sizeof(inRec_t);
	
	// cursor for given input dataset
	byte *start = (byte *)bboxinx;
	byte *cur = start;
	inRec_t *curRow;
	
	// for each row in the input dataset
	int id=0;
	// int id=rootNodeOffset;
	// int id=numRows-1;
	do{
		curRow = (inRec_t *)cur; // cursor for current row
		
		// create a Envelope rectangle for the given row
		geos::geom::Envelope* env = new geos::geom::Envelope(curRow->bboxminx,curRow->bboxmaxx,curRow->bboxminy,curRow->bboxmaxy);
		unsigned __int64 fpos = curRow->fpos;

		// insert into Rtree
		tree->insert(env,new HPCCItem(id++,fpos, curRow->bboxminx,curRow->bboxminy,curRow->bboxmaxx,curRow->bboxmaxy));
		
		// jump cursor to next row...
		cur += sizeof(inRec_t);
	}
	while( (cur - start) < sizeOfBBOXInx ); // while jumping does not exceeed the size of the input dataset


	// : BUILD Rtree
	//-----------------------------------------------------------------------

	tree->build(); // compact populated in-memory RTree

	// : Traverse Rtree and create output Dataset
	//-----------------------------------------------------------------------

	createOutputRtreeDataset(tree,__countResult,__result,_resultAllocator, pidoffset);


	//-----------------------------------------------------------------------
	// END MAIN BODY 
	//-----------------------------------------------------------------------
}
ENDC++;




SHARED BBOXIndexLayout__FposOfDset transformCopyDSetFPos(BBOXIndexLayout__Fpos L) := TRANSFORM
    self.dsFpos := L.__fpos;
    SELF:=L;
END;


SHARED BBOXIndexLayout__PartFposOfDset transformCopyDSetPartFPos(BBOXIndexLayout__Fpos L) := TRANSFORM
		self.PartitionID := thorlib.node()+1;    
    self.dsFpos := L.__fpos;
    SELF:=L;
END;

// SHARED BBOXIndexLayout__FposOfDset transformRTreeIndexLayout_BBOXIndexLayout__FposOfDset(RTreeIndexLayout L) := TRANSFORM
    // SELF:=L;
// END;

	
SHARED PartitionDSLayout := RECORD
	integer4 PartitionID;
	DATASET(BBOXIndexLayout__PartFposOfDset) BBOXChildDS;
	DATASET(RTreeIndexLayout) RTreeDS;
END;

/**
BBOXIndexToRtreeIndex

Create a Master Rtree index from a given BBOX index
*/
EXPORT LINKCOUNTED DATASET(RTreeIndexLayout) BBOXIndexToRtreeIndex(DATASET(BBOXIndexLayout__Fpos) bboxInx) := FUNCTION

	// Distribute dataset to assign partition IDs
	bboxInxWithDSFPosPart := PROJECT(bboxInx,transformCopyDSetPartFPos(LEFT));		
	
	PartitionDSLayout transformPartitionDS(BBOXIndexLayout__PartFposOfDset L, DATASET(BBOXIndexLayout__PartFposOfDset) LChildDS) := TRANSFORM
		SELF.PartitionID := L.PartitionID,
		SELF.BBOXChildDS := LChildDS,
		SELF.RTreeDS := [];
	END;

	// Group rollup to prep each partition dataset
	bboxInxWithDSFPosGroupPart := GROUP(SORT(bboxInxWithDSFPosPart, PartitionID), PartitionID);
	bboxInPartitioned := ROLLUP(bboxInxWithDSFPosGroupPart, GROUP, transformPartitionDS(LEFT, ROWS(LEFT)));

	// Nodes will be assigned IDs based on partition offset. 
	partitionBaseOffset := COUNT(bboxInxWithDSFPosPart);
	
	rteeInxDsetDenorm := PROJECT(bboxInPartitioned, 
		TRANSFORM(PartitionDSLayout,
			SELF.RTreeDS := SORT(CreateRtreeIndex(PROJECT(LEFT.BBOXChildDS, TRANSFORM(BBOXIndexLayout__FposOfDset, SELF := LEFT)), (LEFT.PartitionID-1)*partitionBaseOffset),nodeid,parentnodeid,LOCAL),
			SELF := LEFT
			));
	
	RTreeIndexLayout NormalizePartitionDS(RTreeIndexLayout R) := TRANSFORM
		SELF := R
	END;
	
	rteeInxDset := NORMALIZE(rteeInxDsetDenorm, LEFT.RTreeDS, NormalizePartitionDS(RIGHT), LOCAL);
	
	RETURN rteeInxDset;
	
END;

EXPORT JoinGeomToRtree(geomDS,rtreeIndexRset,geomLeafLayout) := FUNCTIONMACRO
  rtreeIndexGeomLeafRset := JOIN(rtreeIndexRset,geomDS, 
    RIGHT.__FPos = LEFT.dsfpos
    ,
    TRANSFORM(geomLeafLayout, SELF:=LEFT; SELF := RIGHT)
    ,
    LEFT OUTER
  );
  
  rtreeIndexGeomLeafRsetSorted := SORT(rtreeIndexGeomLeafRset,nodeid,parentnodeid);;
  
  return rtreeIndexGeomLeafRsetSorted;
ENDMACRO;

END;

  
  /*
  RTree
  */
  EXPORT CreateRtreeIndex := Rtree.CreateRtreeIndex;
  EXPORT BBOXIndexToRtreeIndex := Rtree.BBOXIndexToRtreeIndex;


/*
***********************************************************************
System Module
***********************************************************************

Encapsulates functions for health checking e.g. to make sure the spatial libraries are installed correctly and are working

@see Geometry.isSpatialWorking
@see Geoemtry.failIfSpatialNotWorking

*/

EXPORT System := MODULE
  EXPORT BOOLEAN isGEOSInstalledInGDAL():= BEGINC++
     #option library 'geos'
     #option library 'proj'
     #option library 'gdal'
     // #option once : Indicates the function has no side effects and is evaluated at query execution time, even if the parameters are constant, allowing the optimizer to make more efficient calls to the function in some cases.
     #option once

     #include <iostream>
     #include <sstream>
     #include <string>
     #include "ogrsf_frmts.h" // GDAL
     #include "cpl_conv.h"
     #include "gdal_priv.h"


     #body

     return OGRGeometryFactory::haveGEOS();
  ENDC++;

  // sanity check for point in polygon
  EXPORT BOOLEAN isPointInPolygonWorking() := FUNCTION
    STRING Dublin_CityCentre_Small_Polygon := 'POLYGON((-6.26781219295515 53.344432254551705,-6.262385489122019 53.34250496319345,-6.252416751827768 53.34524984168658,-6.253480877711498 53.3505768760828,-6.263098876756025 53.3492325728823,-6.26781219295515 53.344432254551705))';
    STRING LN_Dublin_OCBH_Point := 'POINT(-6.258328014746814 53.3468564495097)';
    INTEGER WGS84_SRID := 4326;

    BOOLEAN isPointInPolygon := isWithin(LN_Dublin_OCBH_Point, Dublin_CityCentre_Small_Polygon, WGS84_SRID);

    return isPointInPolygon; // should be TRUE if working
  END;
  
  EXPORT isSpatialWorking() := FUNCTION
    isOK := isGEOSInstalledinGDAL() AND isPointInPolygonWorking();
    return isOK;
  END;
  
  
  /*
    failIfSpatialNotWorking

    @return return an action, fail if GEOS is not installed correctly and a point in polygon does not work
  */
  EXPORT failIfSpatialNotWorking() := FUNCTION
    isGEOSOK := IF(isGEOSInstalledinGDAL(),'TRUE','FALSE');
    isPIPOK := IF(isPointInPolygonWorking(),'TRUE','FALSE');
    return IF( NOT isSpatialWorking(), FAIL('Spatial libraries are not working!!!, isGEOSInstalledInGDAL()=='+isGEOSOK+' AND isPointInPolygonWorking()=='+isPIPOK));
  END;
END;

EXPORT isSpatialWorking := System.isSpatialWorking;
EXPORT failIfSpatialNotWorking := System.failIfSpatialNotWorking;

END;