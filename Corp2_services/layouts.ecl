
IMPORT Autokey_batch, AutokeyB2_batch, BIPV2;

EXPORT layouts := MODULE

	EXPORT layout_AK_payload := RECORD
		AutokeyB2_batch.Layouts.rec_output_IDs_batch;
		Corp2_services.assorted_layouts.layout_common;
	END;
	
	EXPORT layout_batch_in := RECORD
		Autokey_batch.Layouts.rec_inBatchMaster;
		UNSIGNED6 DotID := 0;
		UNSIGNED6 EmpID := 0;
		UNSIGNED6 POWID := 0;
		UNSIGNED6 ProxID := 0;
		UNSIGNED6 SELEID := 0; 
		UNSIGNED6 OrgID := 0;
		UNSIGNED6 UltID := 0;
	END;

  EXPORT layout_linkid_payload := RECORD
		Autokey_batch.Layouts.rec_inBatchMaster.acctno;
		BIPV2.IDlayouts.l_key_ids_bare;
		Corp2_services.layout_corpkey;
	END;
	
	EXPORT layout_corpkey_with_penalty := RECORD
		Autokey_batch.Layouts.rec_inBatchMaster.acctno;
		Corp2_services.layout_corpkey;
		Corp2_services.Layout_Corp2_search_rollup_Penalty.penalt;
	END;
		
	EXPORT layout_batch_out := RECORD
		Autokey_batch.Layouts.rec_inBatchMaster.acctno;
		Corp2_services.Layout_Corp2_search_rollup_Penalty.penalt;
		Corp2_services.assorted_layouts.corp2_batch_layout;
	END;
	
END;