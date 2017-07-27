
IMPORT AddrBest, Autokey_batch, CriminalRecords_BatchService, DidVille, Doxie, progressive_phone, LN_PropertyV2_Services;

EXPORT Transforms := MODULE

	EXPORT LN_PropertyV2_Services.layouts.batch_in xfm_to_inBatchMaster(BatchDatasets.Layouts.batch_in le) :=
		TRANSFORM
			SELF := le, 
			SELF := []
		END;

	EXPORT DidVille.Layout_Did_OutBatch xfm_to_BestADL_batchIn( BatchDatasets.Layouts.batch_in le, INTEGER c ) :=
			TRANSFORM
				SELF.seq   := c;
				SELF.fname := le.name_first;
				SELF.mname := le.name_middle;
				SELF.lname := le.name_last;
				SELF       := le;
				SELF       := [];
			END;
			
	EXPORT AddrBest.Layout_BestAddr.Batch_in xfm_to_BestAddr_batchIn(BatchDatasets.Layouts.batch_in le) :=
		TRANSFORM
			SELF.zip4 := '',
			SELF      := le,
			SELF      := []
		END;

	EXPORT CriminalRecords_BatchService.Layouts.batch_in xfm_to_Criminal_batchIn(doxie.layout_references_acctno le) :=
		TRANSFORM
			SELF := le, 
			SELF := []
		END;
		
	EXPORT progressive_phone.layout_progressive_batch_in xfm_to_phones_batchIn(BatchDatasets.Layouts.batch_in le) :=
		TRANSFORM
			SELF.acctno := le.acctno,
			SELF.ssn    := '',
			SELF.suffix := le.addr_suffix,
			SELF        := le,
			SELF        := []
		END;
END;