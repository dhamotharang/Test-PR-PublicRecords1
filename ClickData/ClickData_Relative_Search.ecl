/*--SOAP--
<message name="ClickDataRelativesSearchRequest">
  <part name="RID" type="xsd:string" required="1"/>
  <part name="DID" type="xsd:string" required="1"/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
</message>
*/
import Relationship, Clickdata;

export ClickData_Relative_Search := macro

string14 rid_value := '' : stored('rid');
string14 did_value := '' : stored('did');
unsigned2 MaxResults_value := 50 : stored('MaxResults');

full_rec := record
	string14 rid;
	unsigned2	number_cohabits;
	integer3	recent_cohabit;
	Relationship.layout_GetRelationship.interfaceOutputNeutral;
end;

Relationship.Layout_GetRelationship.DIDs_layout prep_did() := transform
		self.did := (integer)did_value;
		self := [];
end;
did_rec := DATASET ([prep_did()]);

full_rec get_rel(Relationship.layout_GetRelationship.interfaceOutputNeutral r) := transform
	self.rid := rid_value;
	self.recent_cohabit := r.rel_dt_last_seen / 100;
	self.number_cohabits := MAX(r.total_score/5, 6);  // Conversion to match v2 key value.
	self := r;
end;

out_f_raw := project(Relationship.proc_GetRelationshipNeutral(did_rec,TRUE,TRUE,FALSE,FALSE,ut.limits.RELATIVES_PER_PERSON,,TRUE).result,
										get_rel(left));
		
out_f := sort(out_f_raw,-number_cohabits,-recent_cohabit,-isRelative);

clickdata.layout_slim_out slim_it(out_f r) := transform
	self.rel_did := (string14)r.did2;
	self.did := (string14)r.did1;
	self.strength := (STRING)r.number_cohabits;
	self.rid := r.rid;
end;
	
out_f_slim := project(out_f, slim_it(left));			  
output(choosen(out_f_slim,MaxResults_value), named('Result'));

endmacro;