
EXPORT RTreeUtils := MODULE
		
	/**
    DistillFile
    
    Distill a base file, parse gometries and extract bounding box details
    
    @TODO check to see if PolySplit can be introduced, it was disabled due to a preceived bottleneck, but this
    may have been caused by another issue

    @param DATASET pIn_NonDistilledDataset   		: dataset of base file
    @param STRING pOut_DistilledCSVFile         : the output distilled filename
    @param INTEGER pIn_EPSG_CODE                : the SRS cde
    @param STRING pIn_ReturnLayout              : a string containing the Return Record Layout; 
                                                  string contains the fully qualified record layout name which is expanded to ECL via macro
                                                  Layout must contain the following 1st and 2nd position fields for boilerplate 
                                                  generic code (function macros in Geometry) to work:
                                                      EXPORT Layout := RECORD
                                                        Geometry.GeometryLayout;
                                                        Geometry.BoundingBoxLayout;
                                                      END;
    
  */
	EXPORT DistillFile(pIn_NonDistilledDataset, pOut_DistilledFile, pIn_EPSG_CODE, pIn_ReturnLayout) := functionmacro

		dBaseFileGeom := PROJECT(pIn_NonDistilledDataset, TRANSFORM(pIn_ReturnLayout, 
										SELF := LEFT,
										SELF := []));

		dBaseFileBBOX := Bair.Geometry.PopulateBoundingBox(dBaseFileGeom, pIn_ReturnLayout, pIn_EPSG_CODE, geom);
		return OUTPUT(dBaseFileBBOX,,pOut_DistilledFile,COMPRESSED,OVERWRITE, THOR);
		
	endmacro;  	
	
	/**
    DistillAndIndexFile
    
    Distill a base file, then declarea and build a bounding box index for it

    @param DATASET pIn_NonDistilledCSVDataset   : dataset of base file
    @param STRING pOut_DistilledFile         		: the output distilled filename
    @param STRING pOut_DistilledFile_BBOX_IDX		: the logical filename of the index to create
    @param INTEGER pIn_EPSG_CODE                : the SRS cde
    @param STRING pIn_ReturnLayout              : a string containing the Return Record Layout; 
                                                  string contains the fully qualified record layout name which is expanded to ECL via macro
                                                  Layout must contain the following 1st and 2nd position fields for boilerplate 
                                                  generic code (function macros in Geometry) to work:
                                                      EXPORT Layout := RECORD
                                                        Geometry.GeometryLayout;
                                                        Geometry.BoundingBoxLayout;
                                                      END;
  */
	EXPORT DistillAndIndexFile(pIn_NonDistilledDataset, pOut_DistilledFile, pOut_DistilledFile_BBOX_IDX, pIn_EPSG_CODE, pIn_ReturnLayout) := functionmacro
	
		// Thor Check
    thor1         := RTreeUtils.DistillFile(pIn_NonDistilledDataset, pOut_DistilledFile, pIn_EPSG_CODE, pIn_ReturnLayout);
		
		// load the dataset, using given layout
    // ensure we are using __Fpos with the virtual(fileposition) field modifier
    distilledDset := DATASET(pOut_DistilledFile, {pIn_ReturnLayout; UNSIGNED8 __Fpos{virtual(fileposition)}}, THOR);		
		
		// declare the index and then build it
    bboxIDX       := INDEX(distilledDset,{BBOXMinX, BBOXMinY, BBOXMaxX, BBOXMaxY},{__Fpos},pOut_DistilledFile_BBOX_IDX);
    thor2         := BUILDINDEX(bboxIDX,OVERWRITE);
		
		return SEQUENTIAL(thor1,thor2);
		
	endmacro;	
	
	
	/**
    BuildRTreeFromDistilledDataset
    
    Given a bounding box index and its associated dataset, create an Rtree index using given feature attributes in the payload index
    
    Use macros to create the record layout and index structure based on the given feature attributes
    
    @param INDEX pIn_BBOXIDX                    : the bounding box index 
    @param DATASET pIn_DistilledDataset         : the dataset that contains the GEOM and Feature attributes
    @param STRING pOut_RTreeIndexFile           : the Rtree logical file to be created
		@param STRING pIn_ReturnLayout    
  */
  EXPORT BuildRTreeFromDistilledDataset(pIn_BBOXIDX, pIn_DistilledDataset, pOut_RTreeIndexFile, pIn_ReturnLayout) := FUNCTIONMACRO

     // 1. Create RTree dataset (_fpos payload in leaf nodes) from BoundingBox index , write out
     RTREE_Dataset:=Geometry.BBOXIndexToRtreeIndex(pIn_BBOXIDX);
     
     act1 := OUTPUT(RTREE_Dataset, ,pOut_RTreeIndexFile+'::TEMP::_FPosPayloadOnly', OVERWRITE);
     
     // 2. Reload, create Rtree Payload index (_fpos payload in leaf nodes)
     RTREE_Dataset_reloaded := DATASET(pOut_RTreeIndexFile+'::TEMP::_FPosPayloadOnly', {Geometry.RTreeIndexLayout ,UNSIGNED8 __fpos {virtual(fileposition)}}, THOR);
     RTREE_IDX := INDEX(RTREE_Dataset_reloaded, {parentNodeId,BBOXMinX,BBOXMinY,BBOXMaxX,BBOXMaxY},{nodeId,dsFpos,__fpos,level,nodetype},pOut_RTreeIndexFile+'::TEMP::_FPosPayloadOnly::IDX',SORTED,DISTRIBUTED);
    
     act2 := BUILDINDEX(RTREE_IDX,OVERWRITE);
     
     // generate Rtree Dataset payload record fields [using pIn_CSVAttributeStrSet]
     loadxml('<XML/>');  //open dummy XML scope just to make template language available 
		 #exportxml(PayloadRecs,pIn_ReturnLayout)

		 #declare(PayloadExt);
		 #declare(PayloadSet);
		 #set(PayloadExt,'');
		 #set(PayloadSet, '');
		 #for (PayloadRecs)
			#for (Field)
				
				#if( %'@type'% in ['string','data'] )
					#if( %@size%=-15)
						#append(PayloadExt, 'string ' + %'@name'% + ';')
					#else
						#append(PayloadExt, 'string'+ %'@size'% + ' ' + %'@name'% + ';')
					#end
				#else 
					#append(PayloadExt, %'@type'% + ' ' + %'@name'%+';\n')
				#end
				
				#IF(%'PayloadSet'% = '')	
					#append(PayloadSet, 'nodeId,dsFpos,level,nodetype,geom,'+%'@name'%)
				#else
					#append(PayloadSet, ',' + %'@name'%)
				#end
		   #end			
		 #end		 
		 
		 RtreeDatasetRec := RECORD
        Geometry.RTreeIndexGeomLeafLayout;
        %PayloadExt%
     END;

     RtreePayloadIndexRec := RECORD
         Geometry.ParentChildRtreeIndexGeomLeafLayout;
         %PayloadExt%
     END;
     
     // 3. Create Rtree Dataset (GEOM payload in leaf nodes)
     RTREE_Dataset_geom_leaf := Geometry.rtree.JoinGeomToRtree(pIn_DistilledDataset, RTREE_Dataset_reloaded, RtreeDatasetRec) ;
     
     act3 := OUTPUT(RTREE_Dataset_geom_leaf, ,pOut_RTreeIndexFile+'::TEMP::_GEOMPayloadRtreeDset',overwrite);
     
     // 4. Reload, create Rtree Payload index (geom payload in leaf nodes)
     RTREE_Dataset_geom_leaf_reloaded := DATASET(pOut_RTreeIndexFile+'::TEMP::_GEOMPayloadRtreeDset', RtreePayloadIndexRec,THOR);
     
     // Declare the rtree index using the macro for payload fields (as for from pIn_CSVAttributeStrSet)
     RTREE_GEOM_IDX := INDEX(RTREE_Dataset_geom_leaf_reloaded, {parentNodeId,BBOXMinX,BBOXMinY,BBOXMaxX,BBOXMaxY},{%PayloadSet%},pOut_RTreeIndexFile,SORTED, DISTRIBUTED);
   
     act4 := BUILDINDEX(RTREE_GEOM_IDX,overwrite);
     
     
     // Create MetaData dataset
     rtreeMetaDSet := DATASET([{MAX(RTREE_Dataset_reloaded,level)}], Geometry.RTreeMetaLayout);
     
     // write MetaData dataset
     act5 := OUTPUT(rtreeMetaDSet, ,pOut_RTreeIndexFile+'::METADATA',overwrite,THOR);
     
     // - Execute in SEQUENTIAL -
     return SEQUENTIAL(act1,act2,act3,act4,act5);
  ENDMACRO;		
	
END;