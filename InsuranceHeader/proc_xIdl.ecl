import idops, orbit, _control, InsuranceHeader_xLink,InsuranceHeader_Ingest,std, IDL_header, InsuranceHeader_Incremental;

export proc_xIdl(STRING version ) := module
		
		#workunit('name','Prod xIDL Lab Build');
					
		#stored('fileVersion',version);	
		
		EXPORT runxLink			:= InsuranceHeader_xLink.Proc_Build_All() : 
																SUCCESS(mod_email.SendSuccessEmail(,'InsuranceHeader', ,'ExternalLinking V2')), 
																 FAILURE(mod_email.SendFailureEmail(,'InsuranceHeader', failmessage, 'ExternalLinking V2', ));
		
END;

