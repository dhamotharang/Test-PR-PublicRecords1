Layout_Input  := BuildFax_Services.Layout_BuildFax.Input_rec_online;
Layout_Output := BuildFax_Services.Layout_BuildFax.output_rec_flat_final;

export ServiceSoapcall(Layout_input input) := function

serviceName   := BuildFax_Services.Constants.serviceName;
// ip_addr       := 'http://10.194.10.77:9876';
ip_addr       := 'http://10.194.3.15:9876'; //DEV NonFCRA VIP
							
soapCallLayout := RECORD 
			DATASET(Layout_Input) Request {XPATH('BuildFaxRequest/Row'), MAXCOUNT(1)};
END;

soapCallLayout xform(Layout_Input L) := TRANSFORM
			SELF.Request := DATASET(L);
END;

Result  := SOAPCALL(DATASET(input),
									  ip_addr,
										serviceName,
										soapCallLayout,
										xform(left),
										DATASET(Layout_Output),
										PARALLEL(1),
										ONFAIL(SKIP),retry(0));
										
RETURN Result;
end;