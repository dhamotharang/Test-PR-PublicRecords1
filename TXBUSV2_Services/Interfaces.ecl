export Interfaces := MODULE

	export pt_param := INTERFACE
		export unsigned2 pt := 20;
	END;

	export do_search := INTERFACE
		export boolean is_Search := TRUE;
	END;

	export search_params := INTERFACE(pt_param,do_search)
		export string11 	TaxPayer_Number := '' : stored('TaxPayerNumber');
	END;
			
END;