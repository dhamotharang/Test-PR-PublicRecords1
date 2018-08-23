IMPORT IDLExternalLinking;
EXPORT fn_RemoteLinking_Soapcall_Batch(DATASET(InsuranceHeader_RemoteLinking.Layouts.ServiceInputLayout_Batch)In_Data, STRING50 Roxie_IP=InsuranceHeader_RemoteLinking.Constants.HEADER_SERVICE_ROXIE_IP,soapcall_timeout=30,soapcall_retry=3) := FUNCTION
  In_data_fin := DATASET([{In_Data}],InsuranceHeader_RemoteLinking.Layouts.Soapcall_Layout);
  out_layout := InsuranceHeader_RemoteLinking.Layouts.ServiceOutputLayout_Batch;
  IDLExternalLinking.MAC_Soapcall(In_data_fin,out_layout, Roxie_IP, 
        InsuranceHeader_RemoteLinking.Constants.HEADER_SERVICE_NAME, OutFile, ,soapcall_timeout, soapcall_retry);
  RETURN OutFile;
END;

