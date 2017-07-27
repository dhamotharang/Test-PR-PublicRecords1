/*--SOAP--
<message name="DIDAddressHash" wuTimeout="300000">
  <part name="DID" type="xsd:string"/>
 </message>
*/
/*--INFO-- This service returns all addresses for a given DID along with it's hash value.*/


export DID_Address_Hash := MACRO 
string14 did_value := '' : stored('did');

all_recs := sort(doxie.Key_Header(s_did=(unsigned6)did_value),prim_range,prim_name,sec_range,zip,st,city_name,predir,suffix,postdir);

rm_dups := dedup(all_recs,prim_range,prim_name,sec_range,zip,st,city_name,predir,suffix,postdir);

final_out_layout := record
 unsigned6    did := 0;
 string10    prim_range;
 string2      predir;
 string28    prim_name;
 string4     suffix;
 string2      postdir;
 string10    unit_desig;
 string8     sec_range;
 string25    city_name;
 string2      st;
 string5     zip;
 string4     zip4;
 data16		    hash_value;
end;

final_out_layout getHash(rm_dups L) := transform
 self.hash_value := hashmd5(intformat(l.did,12,1),(string2)l.st,(string5)l.zip,
						(string25)l.city_name,(string28)l.prim_name,(string10)l.prim_range,
						(string2)l.predir,(string4)l.suffix,(string2)l.postdir,
						(string8)l.sec_range);
 self := l;
end;

with_hash := project(rm_dups,gethash(left));

IF((unsigned6)did_value=0 or stringlib.stringfilter(did_value,'0123456789')!=did_value, 
								FAIL(11,'Input DID is not valid'), output(with_hash,named('Results')));

endmacro;