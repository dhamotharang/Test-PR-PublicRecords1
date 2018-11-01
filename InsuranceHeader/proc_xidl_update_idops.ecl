import InsuranceHeader_Salt_xIDL, idops;

export proc_xidl_update_idops(string timestamp) := module

		shared buildDate 		:= timestamp; // YYYYMMDD format.
		shared packageId 		:= 'IHeaderKeys';
		shared emailList 		:= mod_email.Emaillist;
		
		dops_update 		:= idops.UpdateBuildVersion(packageId,builddate,emailList,,'N');
		
		export run		 	:= sequential(dops_update) : SUCCESS(mod_email.SendSuccessEmail(,'InsuranceHeader ExternalLinking')), 
																					FAILURE(mod_email.SendFailureEmail(,'InsuranceHeader ExternalLinking', failmessage));
end;
