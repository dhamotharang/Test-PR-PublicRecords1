EXPORT Files := MODULE

	EXPORT 	BASE_PREFIX_NAME			:= '~prct::alpharetta::base::ct';
	EXPORT	EIR_SUFFIX						:= 'EIR_DID_XREF';
	
	EXPORT	EIR_XREF_BASE_FILE		:= BASE_PREFIX_NAME + '::qa::' + EIR_SUFFIX;
	EXPORT	EIR_XREF_BASE_DS			:= DATASET(EIR_XREF_BASE_FILE, Layouts.Layout_XREF_MHDR, THOR);
	EXPORT	EIR_XREF_BASE_PARTIAL		:= BASE_PREFIX_NAME + '_' + EIR_SUFFIX+'_PARTIAL';
  EXPORT  Experian_SSN_Cross_Reference := DATASET('~prct::sprayed::ct::header::experian_ssn_cross_reference::w20150827-130516', Layouts.Layout_Experian_SSNs
                                           ,CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"'), MAXLENGTH(8192)) );
	
END;