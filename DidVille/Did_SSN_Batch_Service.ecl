/*2004-09-16T09:24:49Z (Colin Maroney)
living sits added
*/
/*--SOAP--
<message name="Did_SSN_Batch_Service">
  <part name="did_ssn_in" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="ScoreThreshold" type="xsd:unsignedInt"/>
</message>
*/
/*--INFO-- This service returns dids based upon a set of personal data.*/

export Did_SSN_Batch_Service := macro
unsigned1	thresh  := 0 : stored('ScoreThreshold');

df := dataset([],didville.layout_did_inbatch) : stored('did_ssn_in');

didville.Layout_Did_OutBatch into_dob(df L) := transform
	self := L;
end;

df2 := project(df,into_dob(LEFT));

didville.mac_didappend(df2,outf,true,'Z4G',false)

outf chop_low_scores(outf L) := transform
	self.did := if (L.score < thresh,0,L.did);
	self := L;
end;

o1 := project(outf,chop_low_scores(LEFT));

didville.layout_ssn_in into(o1 L) := transform
	self.did := L.did;
	self.seq := L.seq;
	self.ssn_in := L.ssn;
end;

out2 := project(o1,into(LEFT));

didville.mac_append_ssn(out2,o_ready)

didville.layout_did_ssn_out into_out(o_ready L, outf R) := transform
	self.did := L.did;
	self.ssn_appended := L.ssn_appended;
	self.ssn_perms := L.permissions;
	self := R;
end;

o4 := join(o_ready,outf,left.seq = right.seq,into_out(LEFT,RIGHT),hash);

output(o4,named('Result'))

endmacro;
