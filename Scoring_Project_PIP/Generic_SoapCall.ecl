
EXPORT Generic_SoapCall(	ds_soap_in, roxieIP, servicename, layout_soap_output, threads) := functionmacro
		
		layout_soap_output myFail(ds_soap_in le) := TRANSFORM
			SELF.errorcode := 'FAILCODE: ' + FAILCODE + ' FAILMESSAGE: ' + FAILMESSAGE;
			SELF := le;
			SELF := [];
		END;
		
		Soap_call:= SOAPCALL(ds_soap_in, roxieIP,
						servicename, {ds_soap_in}, 
						DATASET(layout_soap_output),
						PARALLEL(threads), onFail(myFail(LEFT)));
		
		return 	Soap_call;

endmacro;