EXPORT MAC_Soapcall(indata, output_layout, roxieIP, serviceName, outdata, blksiz=100, use_ms = FALSE, Soapcall_Timeout = 3600,Soapcall_Time_Limit = 0,Soapcall_Retry = 0,Soapcall_Parallel = 2) := MACRO
#uniquename(str_xpath)         
%str_xpath% := IF(use_ms, '_call_latency_ms', '_call_latency');
#uniquename(errx)         
%errx% := RECORD(output_layout), MAXLENGTH(2097152)
            STRING errorcode := '';
						INTEGER transaction_time{XPATH(%str_xpath%)};
end;
#uniquename(err_out)
%errx% %err_out%(indata L) := TRANSFORM
            SELF.errorcode := FAILCODE + FAILMESSAGE;
            SELF := L;
            SELF := [];
END;
#uniquename(final)
// parallel(2) is the default for a SOAPCALL
// tmeout set to 1 hour to match VIP/Radware timeout
%final% := SOAPCALL(indata, roxieIP , servicename, {indata},
                    DATASET(%errx%), ONFAIL(%err_out%(LEFT)), PARALLEL(Soapcall_Parallel), MERGE(blksiz), TIMEOUT(Soapcall_Timeout), TIMELIMIT(Soapcall_Time_Limit), RETRY(Soapcall_Retry));
outdata := %final%;
ENDMACRO;
