IMPORT _control, ut;

EXPORT Files_Alpha := MODULE

// Copied from _Control.IPAddress in DEV because Boca PROD doesn't contain them
	export	string	adataland_dali	:=	'10.194.10.1';			// 10.173.28.12	

	export foreign_alpha_dev := '~foreign::' + adataland_dali + '::';

	EXPORT Merged_Headers_SF 		:= foreign_alpha_dev+'thor::base::customertest_cleanse::QA::Merged_IHDR_BHDR';
	EXPORT Merged_Headers_SF_DS	:= DATASET(Merged_Headers_SF, Layouts.Layout_Merged_IHDR_BHDR, THOR);

	// The above MHDR data filtered to be 1 record per person and only the required ones for BC3800
	EXPORT MHDR_Primary_Recs_DS			:= Merged_Headers_SF_DS(required_bc='Y' AND ((INTEGER)addr_ind=1) );

	EXPORT TMP_DID_ERR_MHDR_SF_DS			:= DATASET(foreign_alpha_dev+'thor::base::customertest_cleanse::DID_ERRORS_MHDR', Layouts.Layout_Merged_IHDR_BHDR, THOR);

END;


