export MAC_LocalRemoteCombo(SoapRequest, LocalService, RemoteService, ipSet, outLayout, blanktest,
						errors_out, results_out, maxLengthIn = '4096') :=
						
MACRO
import doxie;

#if(doxie.RepositoryIsDist)
	// Get the local Records
	#uniquename(FetchedLocal)
	%FetchedLocal% := LocalService;
	
	
	// Get the Remote Records
	#uniquename(neighbor_service_ip)
	doxie.MakeIPList(ipSet, %neighbor_service_ip%);
	
	#uniquename(blankOut)
	%blankOut% := DATASET([], outLayout);
	
	#uniquename(xLayout)
	%xLayout% :=
	RECORD, maxLength((INTEGER)maxLengthIn)
		outLayout;
		doxie.Layout_Exceptions;
	END;
	
	#uniquename(failt)
	%xLayout% %failt%(%blankOut% L) :=
	TRANSFORM
		SELF.Message		:= IF(FAILCODE != 0, FAILMESSAGE, doxie.ErrorCodes(100));
		SELF.Code			:= IF(FAILCODE != 0, FAILCODE, 100);
		SELF.Location		:= FAILMESSAGE('url')[8..StringLib.StringFind(FAILMESSAGE('url'), '.', 1)-1];
		SELF.ErrorSource	:= 'ROXIE';
		SELF := L;
	END;
	
	#uniquename(FetchedRemote)
	%FetchedRemote% := soapcall(%neighbor_service_ip%,RemoteService,SoapRequest, 
							dataset(%xLayout%),PARALLEL(10), ONFAIL(%failt%(%blankOut%))) : global;
	
	#uniquename(FetchedErrors)
	#uniquename(FetchedResults)
	#uniquename(outputErrors)
	%FetchedResults% := %FetchedRemote%(Code = 0, blanktest);
	%FetchedErrors% := %FetchedRemote%(Code != 0);
	
	#uniquename(formatErrors)
	doxie.Layout_Exceptions %formatErrors%(%FetchedErrors% L) :=
	TRANSFORM
		SELF := L;
	END;
	
	#uniquename(errorsout)
	%errorsout% := PROJECT(%FetchedErrors%, %formatErrors%(LEFT));
	%outputErrors% := output(%errorsout%, NAMED('Exception'), EXTEND);
	
	#uniquename(formatResults)
	outLayout %formatResults%(%FetchedResults% L) :=
	TRANSFORM
		SELF := L;
	END;
	#uniquename(remoteResults)
	%remoteResults% := PROJECT(%FetchedResults%, %formatResults%(LEFT));
	
	// combine vehicles
	#uniquename(Fetched_all)
	%Fetched_all% := MAP(is_a_neighbor OR length(TRIM(%neighbor_service_ip%)) = 0 		=> %FetchedLocal%,
				    ~is_a_neighbor AND length(TRIM(%neighbor_service_ip%)) > 0 		=> %remoteResults%,
																		%FetchedLocal%(false));
	
	
	results_out := %Fetched_all% : SUCCESS(%outputErrors%);
#else
	results_out := LocalService;
#end

ENDMACRO;