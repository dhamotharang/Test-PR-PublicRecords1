IMPORT InsuranceHeader_Address,SALT27,idl_header;

EXPORT addr_linking (dataset(layout_address_link) input) := MODULE

EXPORT iter := Proc_Iterate(workunit,input).DoAll; 
EXPORT samp := Proc_Iterate(workunit,input).OutputExtraSamples;

EXPORT go := sequential(iter, samp);

end;
