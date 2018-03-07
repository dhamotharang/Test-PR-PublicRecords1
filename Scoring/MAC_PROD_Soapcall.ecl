export MAC_PROD_Soapcall(indata1, product_layout, roxieIP, serviceName, outdata, Parallel_threads) := macro

#uniquename(errx)         
%errx% := record
            string errorcode := '';
            product_layout;
end;

#uniquename(err_out)
%errx% %err_out%(indata1 L) := transform
            SELF.errorcode := FAILCODE + FAILMESSAGE;
            self := L;
            self := [];
end;

#uniquename(final)

indata := distribute(indata1, random());

%final% := soapcall(indata, roxieIP ,servicename, {indata},
                    dataset(%errx%), parallel(parallel_threads) ,onfail(%err_out%(LEFT)));
outdata := %final%;

endmacro;
