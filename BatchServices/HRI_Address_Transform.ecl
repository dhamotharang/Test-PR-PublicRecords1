import risk_indicators, USPIS_HotList, autokey_batch;

layout_out	:= BatchServices.HRI_Address_Layout.outrecs;
layout_slim	:= BatchServices.HRI_Address_Layout.output_slim;
layout_in		:= Autokey_batch.Layouts.rec_inBatchMaster;
layout_key	:= Risk_Indicators.Key_Address_To_Sic_Full_HRI;
layout_key_biz := Risk_Indicators.Key_Address_To_Sic;
layout_key_alert := USPIS_HotList.key_addr_search_zip;

EXPORT HRI_Address_Transform := MODULE

EXPORT layout_slim get_alert_flag(layout_in L, layout_key_alert R) := TRANSFORM
	SELF :=L;
	SELF.addr_fraud_alert_flag := 'Y'; 
	SELF.addr_fraud_alert_description := R.comments; 
	SELF := [];
END;

EXPORT layout_slim xform_rollup(layout_slim L, layout_slim R) := TRANSFORM
	SELF.addr_fraud_alert_flag				 := R.addr_fraud_alert_flag; 
	SELF.addr_fraud_alert_description		:= R.addr_fraud_alert_description;
	SELF :=L;
	SELF  := R;
	SELF := [];
END;


EXPORT layout_slim get_results(layout_in L, layout_key R) := TRANSFORM
		// SELF.SEQ			:= R.SEQ;
		// SELF.ACCTNO		:= R.ACCTNO;
		SELF.sic_code := R.sic_code;        
		SELF.ranking := BatchServices.HRI_Address_Functions.get_rank(R.sic_code);
		SELF := R;
		SELF := L;
		SELF := [];
END;

EXPORT layout_slim get_results_biz(layout_in L, layout_key_biz R) := TRANSFORM
		SELF.sic_code := R.sic_code;        
		SELF.ranking := BatchServices.HRI_Address_Functions.get_rank(R.sic_code);
		SELF := R;
		SELF := L;
		SELF := [];
END;

EXPORT layout_out xform_flat_results(layout_slim L) := TRANSFORM
		SELF.sic_code := L.sic_code;        
		SELF.sic_code_desc := BatchServices.HRI_Address_Functions.getSic_Code_Desc(L.sic_code);      
		SELF := L;
		SELF := [];
END;

END;