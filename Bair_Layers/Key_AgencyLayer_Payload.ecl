import Data_Services;

EXPORT Key_AgencyLayer_Payload(string v = 'qa', boolean isDelta = false) := MODULE

	r := RECORD,maxlength(150032)
		UNSIGNED6 LayerID;
		UNSIGNED1 GeoType; //geojson,wkt
		UNSIGNED8 __filepos;
	END;
	 
	d:=dataset([],r);

	EXPORT IDX := INDEX(d,{LayerID,GeoType},{__filepos},data_services.Data_location.Prefix('BAIR')+'thor_data400::key::bair::agency_layers::' + if(isDelta, 'delta::', '') + v + '::LayerID', OPT);
	r := RECORD,maxlength(150032)
		UNSIGNED6 LayerID;
		UNSIGNED1 GeoType;
		unsigned4 geolen;
		STRING 		GeoText;
		unsigned1 seg;
	END;
	 
	EXPORT FILE := DATASET(data_services.Data_location.Prefix('BAIR')+'thor_data400::base::bair::agency_layers::' + if(isDelta, 'delta::', '')+ v, r, flat);

END;
	