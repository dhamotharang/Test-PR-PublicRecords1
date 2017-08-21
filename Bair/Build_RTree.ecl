import Bair;

EXPORT Build_RTree := MODULE
		
	EXPORT CreateGeom(real x, real y) := function
		_geom := IF (x<>0 and y<>0 and x>=-180 and x<=180 and y>=-90 and y<=90, Bair.Geometry.Point_Of_XY(x, y), '');
		_sizeOk := LENGTH(_geom)<50; // <- this needs to be done properly...
		RETURN IF(_sizeOk and Bair.Geometry.isValid(_geom, Bair.Geometry.WGS84_SRID), _geom, '');
	end;

	EXPORT BakeLprFile(bfile) := FUNCTIONMACRO
		baked := PROJECT(bfile, TRANSFORM(Bair.Layouts.BBOXBaseFileLayout,		
										_geom := Bair.Build_RTree.CreateGeom((real)LEFT.x_coordinate, (real)LEFT.y_coordinate);
										SELF.longitude := (string) LEFT.x_coordinate,
										SELF.latitude := (string) LEFT.y_coordinate,
										SELF.geom	:= IF(_geom<>'', _geom, SKIP); // WKT format
										v_date := (string)LEFT.clean_CaptureDateTime;
										SELF.date := v_date[1..4]+v_date[5..6]+v_date[7..8], 
										SELF.ucr_group := '',												
										SELF.ori := (string)LEFT.ori,
										self.etype := 4;
										SELf.eid := LEFT.eid,
										SELF := LEFT));		
		return baked;												
	ENDMACRO;	

	EXPORT BakeVhFile(bfile) := FUNCTIONMACRO
		baked := PROJECT(bfile, TRANSFORM(Bair.Layouts.BBOXBaseFileLayout,		
										_geom := Bair.Build_RTree.CreateGeom(LEFT.vehicle_x_coordinate, LEFT.vehicle_y_coordinate);
										SELF.longitude := (string) LEFT.vehicle_x_coordinate,
										SELF.latitude := (string) LEFT.vehicle_y_coordinate,
										SELF.geom	:= IF(_geom<>'', _geom, SKIP); // WKT format																							
										SELF.date := '';
										SELF.ucr_group := (string)LEFT.group_id,													
										SELF.ori := (string)LEFT.ori,
										self.etype := 1;
										SELf.eid := LEFT.eid,
										SELF := LEFT));		
		return baked;												
	ENDMACRO;	

	EXPORT BakePersFile(bfile) := FUNCTIONMACRO
		baked := PROJECT(bfile, TRANSFORM(Bair.Layouts.BBOXBaseFileLayout,		
										_geom := Bair.Build_RTree.CreateGeom(LEFT.persons_x_coordinate, LEFT.persons_y_coordinate);
										SELF.longitude := (string) LEFT.persons_x_coordinate,
										SELF.latitude := (string) LEFT.persons_y_coordinate,
										SELF.geom	:= IF(_geom<>'', _geom, SKIP); // WKT format																																	
										SELF.date := '';
										SELF.ucr_group := (string)LEFT.group_id,													
										SELF.ori := (string)LEFT.ori,
										self.etype := 1;
										SELf.eid := LEFT.eid,
										SELF := LEFT));		
		return baked;												
	ENDMACRO;	

	EXPORT BakeMoFile(bfile) := FUNCTIONMACRO
		baked := PROJECT(bfile, TRANSFORM(Bair.Layouts.BBOXBaseFileLayout,		
										_geom := Bair.Build_RTree.CreateGeom(LEFT.x_coordinate, LEFT.y_coordinate);
										SELF.longitude := (string) LEFT.x_coordinate,
										SELF.latitude := (string) LEFT.y_coordinate,
										SELF.geom	:= IF(_geom<>'', _geom, SKIP); // WKT format
										v_date := (string)LEFT.clean_First_Date_Time;
										SELF.date := v_date[1..4]+v_date[5..6]+v_date[7..8],
										SELF.ucr_group := (string)LEFT.ucr_group,													
										SELF.ori := (string)LEFT.ori,
										self.etype := 1;
										SELf.eid := LEFT.eid,
										SELF := LEFT));		
		return baked;												
	ENDMACRO;	
	
	EXPORT BakeCfsFile(bfile) := FUNCTIONMACRO
		baked := PROJECT(bfile, TRANSFORM(Bair.Layouts.BBOXBaseFileLayout,		
										_geom := Bair.Build_RTree.CreateGeom(LEFT.x_coordinate, LEFT.y_coordinate);
										SELF.longitude := (string) LEFT.x_coordinate,
										SELF.latitude := (string) LEFT.y_coordinate,
										SELF.geom	:= IF(_geom<>'', _geom, SKIP); // WKT format
										v_date := (string)LEFT.clean_date_time_received;
										SELF.date := v_date[1..4]+v_date[5..6]+v_date[7..8],
										SELF.ucr_group := (string)LEFT.initial_ucr_group,													
										SELF.ori := (string)LEFT.ori,
										self.etype := 2;
										SELf.eid := LEFT.eid,
										SELF := LEFT));		
		return baked;												
	ENDMACRO;	
	
	EXPORT BakeOffenderFile(bfile) := FUNCTIONMACRO
		baked := PROJECT(bfile, TRANSFORM(Bair.Layouts.BBOXBaseFileLayout,
										_geom := Bair.Build_RTree.CreateGeom(LEFT.x_coordinate, LEFT.y_coordinate);
										SELF.longitude := (string) LEFT.x_coordinate,
										SELF.latitude := (string) LEFT.y_coordinate,
										SELF.geom	:= IF(_geom<>'', _geom, SKIP); // WKT format
										v_date := (string)LEFT.clean_classification_date;
										SELF.date := v_date[1..4]+v_date[5..6]+v_date[7..8],
										SELF.ucr_group := LEFT.classification_code,													
										SELF.ori := (string)LEFT.data_provider_id,
										self.etype := 7;
										SELf.eid := LEFT.eid,
										SELF := LEFT));		
		return baked;												
	ENDMACRO;
	
	EXPORT BakeIntelFile(bfile) := FUNCTIONMACRO
		baked := PROJECT(bfile, TRANSFORM(Bair.Layouts.BBOXBaseFileLayout,
										_geom := Bair.Build_RTree.CreateGeom((REAL4) LEFT.x, (REAL4) LEFT.y);
										SELF.longitude := (string) LEFT.x,
										SELF.latitude := (string) LEFT.y,
										SELF.geom	:= IF(_geom<>'', _geom, SKIP); // WKT format
										v_date := (string)LEFT.clean_incident_date;
										SELF.date := v_date[1..4]+v_date[5..6]+v_date[7..8],
										SELF.ucr_group := '', //??											
										SELF.ori := (string)LEFT.dataProviderId,
										self.etype := 5;
										SELf.eid := LEFT.eid,
										SELF := LEFT));		
		return baked;												
	ENDMACRO;
	
	EXPORT BakeCrashFile(bfile) := FUNCTIONMACRO
		baked := PROJECT(bfile, TRANSFORM(Bair.Layouts.BBOXBaseFileLayout,
										_geom := Bair.Build_RTree.CreateGeom(left.x, left.y);
										SELF.geom	:= IF(_geom<>'', _geom, SKIP); // WKT format
										SELF.longitude := (string) LEFT.x,
										SELF.latitude := (string) LEFT.y,
										v_date := (string)LEFT.clean_reportdate;
										SELF.date := v_date[1..4]+v_date[5..6]+v_date[7..8],
										SELF.ucr_group := '', //??												
										SELF.ori := (string)LEFT.dataproviderid,
										self.etype := 3;
										SELf.eid := LEFT.eid,
										SELF := LEFT));		
		return baked;												
	ENDMACRO;
	
	EXPORT BakeShotSpotterFile(bfile) := FUNCTIONMACRO
		baked := PROJECT(bfile, TRANSFORM(Bair.Layouts.BBOXBaseFileLayout,
										_geom := Bair.Build_RTree.CreateGeom(LEFT.x_coordinate, LEFT.y_coordinate);
										SELF.geom	:= IF(_geom<>'', _geom, SKIP); // WKT format
										SELF.longitude := (string) LEFT.x_coordinate,
										SELF.latitude := (string) LEFT.y_coordinate,
										v_date := (string)LEFT.clean_shot_datetime;
										SELF.date := v_date[1..4]+v_date[5..6]+v_date[7..8],
										SELF.ucr_group := (string)LEFT.shot_incident_type,	// 01, 02, 19: single, multiple, possible												 
										SELF.ori := (string)LEFT.data_provider_id,
										self.etype := 6;
										SELf.eid := LEFT.eid,
										SELF := LEFT));		
		return baked;												
	ENDMACRO;
		
	
	EXPORT BuildAll(boolean pUseProd = false, DATASET(Layouts.BBOXBaseFileLayout) inFile, string pversion = '') := FUNCTION	
		
		vMod := IF(pversion<>'','::' + pversion,'');
		
		BBoxIndexName 		:= Bair._Dataset(pUseProd).thor_cluster_files + 'key::' + Bair._Dataset(pUseProd).Name + '::rtree::bbox'+vMod;
		RTreeBaseFileName := Bair._Dataset(pUseProd).thor_cluster_files + 'base::' + Bair._Dataset(pUseProd).Name + '::rtree'+vMod;
		RTreeIdxFileName 	:= Bair._Dataset(pUseProd).thor_cluster_files + 'key::' + Bair._Dataset(pUseProd).Name + '::rtree'+vMod; // <-- main key

		// start the process by building a bbox index
		_buildbbox 		:= Bair.RTreeUtils.DistillAndIndexFile(inFile, RTreeBaseFileName, BBoxIndexName, Geometry.WGS84_SRID, Layouts.BBOXBaseFileLayout);	
		
		distilledDset := DATASET(RTreeBaseFileName, {Layouts.BBOXBaseFileLayout; UNSIGNED8 __Fpos{virtual(fileposition)}}, THOR);
		bboxIdx 			:= INDEX(distilledDset,{BBOXMinX, BBOXMinY, BBOXMaxX, BBOXMaxY},{__Fpos},BBoxIndexName);
			
		// this will use the bbox index to create the final R-Tree index
		_buildrtreeindex := Bair.RTreeUtils.BuildRTreeFromDistilledDataset(bboxIdx, distilledDset, RTreeIdxFileName, Layouts.RTreeExtLayout);	
			
		_buildall := sequential(
			_buildbbox,
			_buildrtreeindex,
			);
		
		RETURN _buildall;
		
	END;
	
END;