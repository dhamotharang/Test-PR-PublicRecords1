/*--SOAP--
<message name="Did_Zip_Batch_Service">
  <part name="did_zip_batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="SeisintAdlService" type="xsd:string" required="1"/>
  </message>
*/

/*--INFO-- This service returns dids based upon a set of names and zips.*/

import ut,fair_isaac;

export DID_ZIP_Batch_Service := macro

in_format := DidVille.Layout_Did_Zip_In;

sif := dataset([],in_format) : stored('did_zip_batch_in',few);

maxseq := max(sif,seq) : global;

//some values need defaults.
in_format into(sif L,integer C) := transform
	self.innerradius := if(L.innerradius = '','5',L.innerradius);
	self.outerradius := if(L.outerradius = '','50',L.outerradius);
	self.seq := if (L.seq = 0, maxseq + C, L.seq);
	self.maxdidcount := if(L.maxdidcount = 0,1,L.maxdidcount);
	self := L;
end;

sif2 := project(sif,into(LEFT,COUNTER));

string100 adl_service_ip := '' : stored('SeisintAdlService');

didville.Layout_DID_Zip_Out failt(in_format L) := transform
	self.did := 0;
	self.confidence := 0;
	self.seq := L.seq;
	self.fname := L.firstname;
	self.lname := L.lastname;
	self.cnt := 0;
	self.distance := 0;
	self.dt_last_seen := 0;
	self.best_addr1 := FAILMESSAGE;
end;


outf := soapcall(sif2,adl_service_ip,'didville.did_zip_service',{sif2.firstname, sif2.lastname, sif2.zip, sif2.innerradius,sif2.outerradius,sif2.maxdidcount,sif2.seq,sif2.appendbests} ,dataset(didville.Layout_did_zip_out),PARALLEL(10),ONFAIL(failt(left)));

output(choosen(outf,ALL),named('Result'))

ENDMACRO;