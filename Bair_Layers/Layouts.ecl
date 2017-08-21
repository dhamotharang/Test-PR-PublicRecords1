EXPORT Layouts := MODULE
	SHARED max_size := _Dataset().max_record_size;
	export Input := {,maxlength(max_size * 40) string line {maxlength(max_size * 40)}};

	export AgencyLayers_In := RECORD
			string 		data_provider_id ; 
			STRING40  layergroupname ;
			STRING80  layername ;
			STRING 		polygon ; 
			UNSIGNED4 sql_id ;
			STRING 		json ;
	END;
	
	export Layers_point_rec := RECORD
			AgencyLayers_In - [data_provider_id];
			UNSIGNED6 LayerID;
			UNSIGNED4 data_provider_id;
			DATASET(bair_layers.Polygons.polygon_point_rec) polygon_point_rec;
			DATASET(bair_layers.Polygons.point_rec_gh4) point_rec_gh4;			
	END;	

	export Layers_Base_w_ChildRec := RECORD
			UNSIGNED4 data_provider_id;
			STRING40 	layergroupname;
			STRING80 	layername;
			STRING 		json;
			STRING 		polygon;
			INTEGER4 	MinX;	
			INTEGER4 	MaxX;	
			INTEGER4 	MinY;	
			INTEGER4 	MaxY;	
			DATASET(bair_layers.Polygons.point_rec_gh4) point_rec_gh4;		
			UNSIGNED6 LayerGroupID;
			UNSIGNED6 LayerID;
	END;
	
	export Layers_Base := RECORD
		Layers_Base_w_ChildRec - [point_rec_gh4];
		STRING4 gh4;			
	end;

	export Layers_Search_Base := RECORD
			STRING4 	GH4;   // Geohash for the Agency Layer,  An agency layer can have multiple GH4â€™s. 
			INTEGER4 	MinX;  // MinX of the GH4 box
			INTEGER4 	MinY;
			INTEGER4 	MaxX;
			INTEGER4 	MaxY;
			UNSIGNED4 data_provider_id;
			STRING70 	AgencyName;
			UNSIGNED6 LayerGroupID; // hash of ORI + LayerGroupName
			STRING40 	LayerGroupName; //  beat, district etc
			UNSIGNED6 LayerID;  // hash of ORI + LayerName
			STRING80 	LayerName; // 
	end;
		
	export Layers_Payload_Base := record,maxlength(150032)
			UNSIGNED6 LayerID;
			UNSIGNED1 GeoType;
			UNSIGNED4 Geolen;
			STRING 		GeoText;
			UNSIGNED1 seg; 
	END;
	
END;

