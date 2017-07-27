/*--SOAP--
<message name="AVM Batch">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/
/*--INFO-- This service accepts a batch input of addresses and returns AVM valuations */
import risk_indicators, avm_v2;

export AVM_Batch := macro;

f := dataset([],avm_v2.layouts.layout_AVM_batchin) : stored('batch_in',few);

avm_v2.layouts.layout_AVM_batchin into(f l, integer c) := transform
	self.seq := c;
	self.acctno := l.acctno;
	
	street_address := risk_indicators.MOD_AddressClean.street_address(l.street_addr, l.prim_range, l.predir, l.prim_name, l.suffix, l.postdir, l.unit_desig, l.sec_range);
	clean_a2 := risk_indicators.MOD_AddressClean.clean_addr( street_address, l.p_City_name, l.St, l.Z5 ) ;	
				
	self.prim_range := clean_a2[1..10];
	self.predir := clean_a2[11..12];
	self.prim_name := clean_a2[13..40];
	self.suffix := clean_a2[41..44];
	self.postdir := clean_a2[45..46];
	self.unit_desig := clean_a2[47..56];
	self.sec_range := clean_a2[57..65];
	self.p_city_name := clean_a2[90..114];
	self.st := clean_a2[115..116];
	self.z5 := clean_a2[117..121];
	self.zip4 := clean_a2[122..125];
	self.lat := clean_a2[146..155];
	self.long := clean_a2[156..166];
	self.addr_type := clean_a2[139];
	self.addr_status := clean_a2[179..182];
	self.county := clean_a2[143..145];
	self.geo_blk := clean_a2[171..177];
	
	self := [];
end;

indata := PROJECT(f,into(LEFT, counter));

addrkey := join(inData, avm_v2.Key_AVM_Address,
					left.prim_name!='' and
					keyed(left.prim_name = right.prim_name) and
					keyed(left.st = right.st) and
					keyed(left.z5 = right.zip) and
					keyed(left.prim_range = right.prim_range) and
					keyed(left.sec_range = right.sec_range) and
					left.predir=right.predir and 
					left.postdir=right.postdir and
					right.automated_valuation<>0,  // make sure the avm record has a current valuation, not just history
				  transform(avm_v2.layouts.layout_AVM_batchout, self.seq := Left.seq, self.acctno := left.acctno, self := right), atmost(500), left outer);
	
// when choosing which AVM to output if the addr or apn return more than 1 result, 
// always pick the record with the most information populated, and the most recent record as secondary qualifier
all_avms := group(sort(addrkey, seq, -prim_name, -unformatted_apn, -recording_date), seq);

j_f := rollup(all_avms, true, transform(avm_v2.layouts.layout_AVM_batchout, self := left));											
output(j_f, named('Results'));

endmacro;

