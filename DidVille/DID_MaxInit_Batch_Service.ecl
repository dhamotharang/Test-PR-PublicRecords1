/*--SOAP--
<message name="DID_MaxInit_Batch_Service">
  <part name="Batch_In" type="tns:XmlDataSet" cols="70" rows="25"/>  
  <part name="GetUpdate" type="xsd:boolean"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="AllowNickNames" type="xsd:boolean"/> 
</message>
*/
/*--INFO-- This service is to retieve all Possible DIDs of the input subject,
           and should be post filtered depends on accuracy required */

import didville, doxie, monitoring;

export DID_MaxInit_Batch_Service := macro

//use seqeunce number, classify inputs for different match 
f_in_raw := dataset([],monitoring.Layout_Best_Addr_In) : stored('Batch_In',few);
f_in := project(f_in_raw, didville.Layout_BestInfo_BatchIn);
get_update_value := false : stored('GetUpdate');

doxie.MAC_Header_Field_Declare()

//first level: based on ssn, address, phone informaiton
dids_ssn_recs := didville.Did_From_SSN_Batch(f_in,true,score_threshold_value,false);							
dids_addr_recs := didville.Did_From_Address_Batch(f_in,true,phonetics,1); 
dids_phone_recs := didville.Did_From_Phone_Batch(f_in,true);

dids_all_ready_st := dids_ssn_recs + dids_addr_recs /*+ dids_phone_recs*/;

//combine together all and dedup
dids_all_ready := dids_all_ready_st;
dids_all_dep := dedup(sort(dids_all_ready(did<>0), record), record);

monitoring.layout_acctno_did get_addr_number(dids_all_dep l, f_in_raw r) := transform
	self.best_address_number := r.best_address_number;
	self := l;
end;

f_out := join(dids_all_dep, f_in_raw,
              left.acctno = right.acctno,
		    get_addr_number(left, right), keep(1));

output(f_out, named('Results'));

endmacro;