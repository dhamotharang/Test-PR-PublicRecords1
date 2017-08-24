import Data_Services;

EXPORT Key_Images(string v = 'qa', boolean isDelta = false) := MODULE

	r := RECORD,maxlength(150000)
		string23 eid;
		unsigned1 image_type;
		unsigned4 imagelen;
		unsigned8 __filepos;
	END;
	 
	d:=dataset([],r);

	EXPORT IDX := INDEX(d,{eid},{image_type,imagelen,__filepos},data_services.Data_location.Prefix('BAIR')+'thor_data400::key::bair::images::' + if(isDelta, 'delta::', '') + v + '::eid', OPT);
	
	r := RECORD,maxlength(150000)
		string23 eid;
		unsigned1 image_type;
		unsigned4 imagelen;
		string photo;
	END;
	 
	EXPORT FILE := DATASET(data_services.Data_location.Prefix('BAIR')+'thor_data400::base::bair::images::' + if(isDelta, 'delta::', '')+ v, r, flat);

END;
	