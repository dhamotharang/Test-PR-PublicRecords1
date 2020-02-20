IMPORT phonesplus_batch, Gateway, BatchShare;

	ppc:= phonesplus_batch.constants;
	EXPORT options := MODULE
	
		EXPORT IOptions:= INTERFACE(BatchShare.IParam.BatchParams)
			EXPORT BOOLEAN ExcludeCurrentGong:= ppc.ExcludeCurrentGong;
			EXPORT BOOLEAN IncludeTargus:= ppc.IncludeTargus;
			EXPORT BOOLEAN IncludeQsent:= ppc.IncludeQsent;
			EXPORT BOOLEAN IncludeTargusWireless:= ppc.IncludeTargusWireless;
		END;

		EXPORT getOptions():= FUNCTION
			baseOptions:= BatchShare.IParam.getBatchParams();
			optionsModule := MODULE(PROJECT(baseOptions, IOptions, OPT))
				EXPORT BOOLEAN ExcludeCurrentGong:= ppc.ExcludeCurrentGong : STORED('ExcludeCurrentGong');
				EXPORT BOOLEAN IncludeTargus:= ppc.IncludeTargus : STORED('IncludeTargus');
				EXPORT BOOLEAN IncludeQsent:= ppc.IncludeQsent : STORED('IncludeQsent');
				EXPORT BOOLEAN IncludeTargusWireless:= ppc.IncludeTargusWireless : STORED('IncludeTargusWireless');
				EXPORT DATASET (Gateway.Layouts.Config) Gateways := ppc.Gateways : STORED('Gateways');
			END;
			RETURN optionsModule;
		END;
		
	END;