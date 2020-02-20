IMPORT BatchShare;

EXPORT Email_BatchService_Interfaces := MODULE

	export BatchParams := interface(BatchShare.IParam.BatchParams)
		export boolean useDMEmailSourcesOnly;
		export unsigned8 MAX_EMAIL_PER_ACCTNO;
	end;

	export getBatchParams() := function
		
		base_params := BatchShare.IParam.getBatchParams();

		email_batch_params := MODULE(project(base_params, BatchParams, opt))
			EXPORT unsigned8 MAX_EMAIL_PER_ACCTNO := 10; // implicitly defined by flat output layout.
			EXPORT boolean useDMEmailSourcesOnly := false	: stored('UseDMEmailSourcesOnly');
		END;		

		return email_batch_params;
	end;		

END;
