/*--SOAP--
<message name="ClickData_Relative_Batch">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="MaxResults" type="xsd:unsignedInt"/>
</message>
*/
/*--INFO-- Take DIDs and record IDs, get relatives' DID*/

import Relationship, Clickdata;

export ClickData_Relative_Batch := macro

unsigned2 MaxResults_value := 50 : stored('MaxResults');
in_f := dataset([],clickdata.layout_slim_in) : stored('batch_in',few);

full_rec := record
	string14 rid;
	unsigned2	number_cohabits;
	integer3	recent_cohabit;
	Relationship.layout_GetRelationship.interfaceOutputNeutral;
end;

rdid_ds := project(in_f,transform(Relationship.Layout_GetRelationship.DIDs_layout,self.did:=(integer)left.did,self := []));
rel_recs := Relationship.proc_GetRelationshipNeutral(rdid_ds,TRUE,TRUE,FALSE,FALSE,ut.limits.RELATIVES_PER_PERSON,,TRUE).result;

full_rec get_rel(in_f l, Relationship.layout_GetRelationship.interfaceOutputNeutral r) := transform
	self.recent_cohabit := r.rel_dt_last_seen / 100;
	self.number_cohabits := MAX(r.total_score / 5,6);  // Conversion rule to match v2 key value
	self := r;
	self := l;
end;

out_f := join(in_f, rel_recs, 
              (unsigned5)left.did = right.did1,
							get_rel(left, right), left outer);
				
out_f_srt := sort(out_f,did1,-number_cohabits,-recent_cohabit,-isRelative);		    
out_f_dep := dedup(out_f_srt,did1,keep MaxResults_value);

clickdata.layout_slim_out slim_it(out_f_dep r) := transform
	self.rel_did := (string14)r.did2;
	self.did := (string14)r.did1;
	self.strength := (STRING)r.number_cohabits;
	self.rid := r.rid;
end;
	
out_f_slim := project(out_f_dep, slim_it(left));			  

output(out_f_slim,named('Results'))

endmacro;