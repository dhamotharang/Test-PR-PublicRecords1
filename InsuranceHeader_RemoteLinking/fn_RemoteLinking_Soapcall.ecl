IMPORT IDLExternalLinking;
EXPORT fn_RemoteLinking_Soapcall(DATASET(InsuranceHeader_RemoteLinking.Layouts.ServiceInputLayout)In_Data,soapcall_timeout=30,soapcall_retry=3) := FUNCTION
  out_layout := InsuranceHeader_RemoteLinking.Layouts.ServiceOutputLayout;
  IDLExternalLinking.MAC_Soapcall(In_Data,out_layout, InsuranceHeader_RemoteLinking.Constants.HEADER_SERVICE_ROXIE_IP, 
        InsuranceHeader_RemoteLinking.Constants.HEADER_SERVICE_NAME, OutFile, ,soapcall_timeout, soapcall_retry);
  RETURN OutFile;
END;

