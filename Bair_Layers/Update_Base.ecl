EXPORT Update_Base (string version, boolean pUseProd = false, pDelta = false) := module
		
	shared infile:=dedup(Bair_Layers.Files(,pUseProd).input, all);
	
	shared AgencyLayers_In_w_LID := record
		Bair_Layers.layouts.AgencyLayers_In - [data_provider_id];
		UNSIGNED6 LayerID;
		UNSIGNED4 data_provider_id;
	end;
	
	AgencyLayers_In_w_LID AddLayerId(Bair_Layers.Layouts.AgencyLayers_In L, integer ctr) := transform
			dpID										:= (UNSIGNED4)regexreplace('[^0-9]', L.data_provider_id, '');
			SELF.data_provider_id 	:= dpID;
			SELF.LayerID 						:= hash(dpID + ':' + L.layername + (string)ctr);
			SELF := L;
	end;
	
	shared infile_w_LayerId := project(sort(distribute(infile, hash(data_provider_id, layername)), data_provider_id, layername, local), AddLayerId(left, counter));
	
	layouts.Layers_point_rec t_wkt_to_gh4(AgencyLayers_In_w_LID L) := transform
			SELF.data_provider_id 	:= L.data_provider_id;
			SELF.layergroupname 		:= L.layergroupname;
			SELF.layername 					:= L.layername;
			SELF.json 							:= L.json;
			SELF.polygon 						:= L.polygon;
			SELF.sql_id 						:= L.sql_id;
			SELF.polygon_point_rec	:= bair_layers.Polygons.fromWKT(L.polygon);	
			SELF.point_rec_gh4			:= bair_layers.Polygons.fromWKT_GH4(L.polygon);	
			SELF.LayerID						:= L.LayerID;
	end;
	
	sprayed_layers := project(infile_w_LayerId, t_wkt_to_gh4(left));
	
	Bair_Layers.layouts.Layers_Base_w_ChildRec t_prepped_to_base(layouts.Layers_point_rec L) := transform
				SELF.data_provider_id 	:= L.data_provider_id;
				SELF.layergroupname 		:= L.layergroupname;
				SELF.layername 					:= L.layername;
				SELF.json 							:= L.json;
				SELF.polygon 						:= L.polygon;
				SELF.MinX								:= (INTEGER8)regexreplace('\\.',(string)min(L.polygon_point_rec, p_lon),'');	
				SELF.MaxX								:= (INTEGER8)regexreplace('\\.',(string)max(L.polygon_point_rec, p_lon),'');	
				SELF.MinY								:= (INTEGER8)regexreplace('\\.',(string)min(L.polygon_point_rec, p_lat),'');	
				SELF.MaxY								:= (INTEGER8)regexreplace('\\.',(string)max(L.polygon_point_rec, p_lat),'');	
				SELF.point_rec_gh4			:= L.point_rec_gh4;	
				SELF.LayerGroupID				:= hash(L.data_provider_id + ':' + L.layergroupname );// hash of ORI + LayerGroupName
				SELF.LayerID						:= L.LayerID; // hash of ORI + LayerName
	end;
	build_prepped := project(sprayed_layers, t_prepped_to_base(left));
		
	Bair_Layers.layouts.Layers_Base T_Norm(Bair_Layers.layouts.Layers_Base_w_ChildRec L, bair_layers.Polygons.point_rec_gh4 R) := TRANSFORM
			SELF.gh4 := R.gh4;
			SELF := L;					
	END;

	export Layers := sort(NORMALIZE(build_prepped,LEFT.point_rec_gh4,T_Norm(LEFT,RIGHT)), data_provider_id, LayerGroupID, LayerID);			
		
	Agencylayers_Ext := record
		Bair_Layers.layouts.AgencyLayers_In - [data_provider_id];
		UNSIGNED6 LayerID;
		UNSIGNED4 data_provider_id;
		UNSIGNED1 numRows_json;
		UNSIGNED1 numRows_poly;
	end;
	
	mxLength:=150000;
	
	Agencylayers_Ext AddRowNum(AgencyLayers_In_w_LID L, integer ctr) := transform
			SELF.LayerID 						:= L.LayerID;
			self.numRows_json				:= length(L.json)/mxLength + 1;
			self.numRows_poly				:= length(L.polygon)/mxLength + 1;
			SELF.data_provider_id 	:= L.data_provider_id;
			SELF := L;
	end;
	
	infile_ext := project(infile_w_LayerId, AddRowNum(left, counter));
	
	Bair_Layers.layouts.Layers_Payload_Base norm_json(Agencylayers_Ext L, INTEGER C) := transform
		SELF.LayerID := L.LayerID;
		SELF.GeoType := 1;
		SELF.seg 		 := C;
		SELF.Geolen  := CHOOSE(C
														,length(trim(L.json[..mxLength]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.json[mxLength*(C-1)+1..]))
														 );
		SELF.GeoText := CHOOSE(C
														,trim(L.json[..mxLength])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..mxLength*C])
														,trim(L.json[mxLength*(C-1)+1..])
														 );
	end;
	json := NORMALIZE(infile_ext, LEFT.numRows_json, norm_json(LEFT,COUNTER));
	
	Bair_Layers.layouts.Layers_Payload_Base norm_polygon(Agencylayers_Ext L, INTEGER C) := transform
		SELF.LayerID := L.LayerID;
		SELF.GeoType := 2;
		SELF.seg 		 := C;
		SELF.Geolen  := CHOOSE(C
														,length(trim(L.polygon[..mxLength]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..mxLength*C]))
														,length(trim(L.polygon[mxLength*(C-1)+1..]))
														 );
		SELF.GeoText := CHOOSE(C
														,trim(L.polygon[..mxLength])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])														
														,trim(L.polygon[mxLength*(C-1)+1..mxLength*C])
														,trim(L.polygon[mxLength*(C-1)+1..])
														 );
	end;
	
	polygon := NORMALIZE(infile_ext, LEFT.numRows_poly, norm_polygon(LEFT,COUNTER));
	
	export Payload_Layers := dedup(json + polygon, all);
	
END;