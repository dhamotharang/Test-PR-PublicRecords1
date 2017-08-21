/*--SOAP--
<message name = 'MerchantVesselBDIDService'>
	<part name = 'BDID' type = 'xsd:string'/>
</message>
*/
/*--INFO-- This service searches the Merchant Vessels file by BDID. */

export Merchant_Vessel_BDID_Service() := macro

string14	bd_val := '' : stored('BDID');
unsigned6	bd := (integer)bd_val;

typeof(merchant_vessels.Key_Merchant_Vessel_BDID) get_by_bdid(merchant_vessels.Key_Merchant_Vessel_BDID L) := transform
	self := L;
end;

vids := dedup(sort(project(merchant_vessels.Key_Merchant_Vessel_BDID(bdid = bd), get_by_bdid(LEFT)),whole record), whole record);

merchant_vessels.Layout_DID_MV get_fullrecs(vids L, merchant_vessels.Key_Merch_Vessel_ViD R) := transform
	self := R;
end;

outf := join(vids, merchant_Vessels.Key_Merch_Vessel_ViD, left.vessel_id = right.vessel_id,
			get_fullrecs(LEFT,RIGHT));

output(choosen(outf(bdid = bd),all),named('RESULTS'));

endmacro;
