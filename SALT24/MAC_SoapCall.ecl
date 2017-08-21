export MAC_Soapcall(indata, output_layout, roxieIP, serviceName, outdata, blksiz=100) := macro
#uniquename(errx)         
%errx% := record(output_layout), maxlength(2097152)
            string errorcode := '';
			integer transaction_time{xpath('_call_latency')};
end;
#uniquename(err_out)
%errx% %err_out%(indata L) := transform
            SELF.errorcode := FAILCODE + FAILMESSAGE;
            self := L;
            self := [];
end;
#uniquename(final)
// parallel(2) is the default for a SOAPCALL
// tmeout set to 1 hour to match VIP/Radware timeout
%final% := soapcall(indata, roxieIP , servicename, {indata},
                    dataset(%errx%), onfail(%err_out%(LEFT)), parallel(2), merge(blksiz), timeout(3600));
outdata := %final%;
endmacro;
