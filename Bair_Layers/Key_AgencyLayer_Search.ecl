import data_services;

r := RECORD
		STRING4 GH4;   // Geohash for the Agency Layer,  An agency layer can have multiple GH4â€™s. 
		INTEGER4 MinX;  // MinX of the GH4 box
		INTEGER4 MinY;
		INTEGER4 MaxX;
		INTEGER4 MaxY;
		UNSIGNED4 data_provider_id;
		STRING70 AgencyName;
		UNSIGNED6 LayerGroupID; // hash of ORI + LayerGroupName
		STRING40 LayerGroupName; //  beat, district etc
		UNSIGNED6 LayerID;  // hash of ORI + LayerName
		STRING80 LayerName;
 END;
 
d:=dataset([],r);

EXPORT Key_AgencyLayer_Search(string v = 'qa', boolean isDelta = false) := 
													index(d,{GH4,Minx,MinY,MaxX,MaxY},{d},data_services.Data_location.Prefix('BAIR')+
																						'thor_data400::key::bair::agency_layers::' + if(isDelta, 'delta::', '') + v + '::search');
