/*--SOAP--
<message name = 'OfficialRecsBDIDService'>
	<part name = 'BDID' type = 'xsd:string'/>
</message>
*/
/*--INFO-- This service searches the Official Records Party File by BDID. */

export Official_Records_BDID_Service() := macro

string14	bd_val := '' : stored('BDID');
unsigned6	bd := (integer)bd_val;

typeof(official_records.key_officialrecs_party_bdid) get_by_bdid(official_records.key_officialrecs_party_bdid L) := transform
	self := L;
end;

orks := project(official_records.key_officialrecs_party_bdid(bdid = bd), get_by_bdid(LEFT));

typeof(official_records.Key_Official_records_ORKey) get_fullrecs(orks L, official_records.Key_Official_Records_ORKey R) := transform
	self := R;
end;

outf := join(orks,official_records.Key_Official_records_ORKey, left.official_record_key = right.ork,
		get_fullrecs(LEFT,RIGHT));

output(choosen(sort(outf(bdid = bd),official_record_key,entity_sequence),all),named('RESULTS'));

endmacro;
