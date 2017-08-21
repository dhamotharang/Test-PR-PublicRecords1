/*
**********************************************************************************
Created by    Comments
Vani 					This attribute has all the superfiles, input and out 
							
***********************************************************************************
*/	

export SOFF_SuperFileList := MODULE
  SHARED varstring cluster_name := 'thor_200';//'thor_data50';
	
	EXPORT DIGSSOFFOffender  := '~'+cluster_name+'::in::digssoff::raw_data_offender';
	EXPORT DIGSSOFFOffense   := '~'+cluster_name+'::in::digssoff::raw_data_offense';
	EXPORT DIGSSOFFAlias     := '~'+cluster_name+'::in::digssoff::raw_data_alias';
	EXPORT DIGSSOFFAddress   := '~'+cluster_name+'::in::digssoff::raw_data_address';
	EXPORT DIGSSOFFAttribute := '~'+cluster_name+'::in::digssoff::raw_data_attribute';
	EXPORT DIGSSOFFVehicle   := '~'+cluster_name+'::in::digssoff::raw_data_vehicle';
	EXPORT DIGSSOFFMugshot   := '~'+cluster_name+'::in::digssoff::raw_data_mugshot';
	EXPORT DIGSSOFFSource    := '~'+cluster_name+'::in::digssoff::source_lookup';
	
	// Output file in OKC Layout
	EXPORT FULL_OKC_FILE     := '~'+cluster_name+'::in::digssoff::SOFF_OKC_OUTFILE';
END;
