IMPORT Autokey_batch, risk_indicators;
EXPORT HRI_Address_Layout := MODULE 

	EXPORT ds_sics := RECORD
		string8 sic_code;
	END;
	
	EXPORT output_slim := RECORD
		Autokey_batch.Layouts.rec_inBatchMaster.seq;
		Autokey_batch.Layouts.rec_inBatchMaster.acctno;
		Autokey_batch.Layouts.rec_inBatchMaster.prim_range;
		Autokey_batch.Layouts.rec_inBatchMaster.predir;
		Autokey_batch.Layouts.rec_inBatchMaster.prim_name;
		Autokey_batch.Layouts.rec_inBatchMaster.addr_suffix;
		Autokey_batch.Layouts.rec_inBatchMaster.postdir;
		Autokey_batch.Layouts.rec_inBatchMaster.unit_desig;
		Autokey_batch.Layouts.rec_inBatchMaster.sec_range;
		Autokey_batch.Layouts.rec_inBatchMaster.p_city_name;
		Autokey_batch.Layouts.rec_inBatchMaster.st;
		Autokey_batch.Layouts.rec_inBatchMaster.z5;
		Autokey_batch.Layouts.rec_inBatchMaster.zip4;
		string1 addr_fraud_alert_flag := '';      
		string80 addr_fraud_alert_description := '';
		string8 sic_code;
		unsigned2 ranking;
	END;
	
	EXPORT outrecs:= RECORD
		Autokey_batch.Layouts.rec_inBatchMaster.seq;
		Autokey_batch.Layouts.rec_inBatchMaster.acctno;
		Autokey_batch.Layouts.rec_inBatchMaster.prim_range;
		Autokey_batch.Layouts.rec_inBatchMaster.predir;
		Autokey_batch.Layouts.rec_inBatchMaster.prim_name;
		Autokey_batch.Layouts.rec_inBatchMaster.addr_suffix;
		Autokey_batch.Layouts.rec_inBatchMaster.postdir;
		Autokey_batch.Layouts.rec_inBatchMaster.unit_desig;
		Autokey_batch.Layouts.rec_inBatchMaster.sec_range;
		Autokey_batch.Layouts.rec_inBatchMaster.p_city_name;
		Autokey_batch.Layouts.rec_inBatchMaster.st;
		Autokey_batch.Layouts.rec_inBatchMaster.z5;
		Autokey_batch.Layouts.rec_inBatchMaster.zip4;
		string8 sic_code := '';        
		string80 sic_code_desc := '';           
		string1 addr_fraud_alert_flag := '';      
		string80 addr_fraud_alert_description := '';
	END;
	

END;