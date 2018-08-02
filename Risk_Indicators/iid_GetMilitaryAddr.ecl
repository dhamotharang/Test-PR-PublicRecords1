Import _Control, Risk_indicators, Header, RiskWise, AID_Build;
onThor := _Control.Environment.OnThor;

EXPORT iid_GetMilitaryAddr(grouped Dataset(Risk_indicators.iid_constants.layout_outx) HeaderIn) := FUNCTION;

AddrLayout := RECORD
	risk_indicators.Layout_Input; 
	header.layout_header_v2 hdr;
	Boolean militaryAddr;
	Boolean militaryZip;
	Boolean militaryAddrEver;
END;	

AddrLayout GetAddrLayout(HeaderIn le)  := TRANSFORM
  	 self.hdr := le.h;
		 SELF := le;
		 self := [];
END;
	
HeaderInSD := dedup(sort(HeaderIn, seq,did,h.predir,h.prim_range, h.prim_name, h.suffix ,h.postdir,h.unit_desig, h.sec_range, h.zip),
												seq,did,h.predir,h.prim_range, h.prim_name, h.suffix ,h.postdir,h.unit_desig, h.sec_range, h.zip);
																								
JustAddr := Project(HeaderInSD, GetAddrLayout(left));	

KeyCSZ := RiskWise.Key_CityStZip;

AddrLayout GetMilitaryZIP(JustAddr le, KeyCSZ ri)  := TRANSFORM
	
	// check the zipclass on the zipcode to determine if any of those zipcodes are military
  militaryZip   :=  If(ri.zipClass = 'M', True, False);
  self.militaryZip   :=  militaryZip;
	self.militaryAddrEver := if(militaryZip, True, False);
	
  self := le;
	self := [];
END;

MilitaryEverZip_roxie := join(JustAddr, KeyCSZ,
                    Keyed(left.hdr.zip = right.zip5) and
										right.zipclass = 'M',
										GetMilitaryZIP(left, right),
										atmost(riskwise.max_atmost), keep(1), left outer);

MilitaryEverZip_ungrouped_thor := join(distribute(JustAddr, hash64(hdr.zip)), 
														 distribute(pull(KeyCSZ(zipclass='M')), hash64(zip5)),
                    (left.hdr.zip = right.zip5),
										GetMilitaryZIP(left, right),
										atmost(riskwise.max_atmost), keep(1), left outer, LOCAL);
										
MilitaryEverZip_thor := GROUP(SORT(distribute(MilitaryEverZip_ungrouped_thor, hash64(seq, did)), seq, did, LOCAL), seq, did, LOCAL);					
										
#IF(onThor)
	MilitaryEverZip := MilitaryEverZip_thor;
#ELSE
	MilitaryEverZip := MilitaryEverZip_roxie;
#END

//  for latency concerns in instantid, just use the zip lookup for now 
// and come back to add the address lookup when the AID key is ready in August release
MilitaryEver := MilitaryEverZip;  

/*
//  TODO:  waiting on Danny to let us know how the FCRA version of this key will look.
aid_key := AID_Build.Key_AID_Base;
	
AddrLayout check_addr_type_for_military(AddrLayout le, aid_key rt) := transform
	// if the zipclass was already found to be military or the header address has addr_type='M', set the militaryAddrEver to true
	self.militaryAddrEver := le.militaryAddrEver or rt.rec_type='M';
	self := le;
end;

MilitaryEver := join(MilitaryEverZip, 
														aid_key,
														keyed(right.rawaid=left.hdr.rawaid),
														check_addr_type_for_military(left,right), left outer, 
														atmost(riskwise.max_atmost), keep(1));
															
*/
															
DIDMilitaryEver := dedup(sort(MilitaryEver, seq,did,-militaryAddrEver), seq, did);

Risk_Indicators.iid_constants.Layout_outx AddMilityflag(HeaderIn le, AddrLayout ri)  := TRANSFORM
	self.addrsMilitaryEver := ri.militaryAddrEver;
  self := le;

END;

MilitaryOut_roxie := group(join(HeaderIn, DIDMilitaryEver, 
										left.seq = right.seq and
										left.did = right.did 
										// and
										// left.h.prim_range = right.hdr.prim_range and
										// left.h.prim_name = right.hdr.prim_name and
										// left.h.zip = right.hdr.zip
										,
										AddMilityflag(left,right)), seq, did);

MilitaryOut_thor := group(join(distribute(HeaderIn, hash64(seq, did)), DIDMilitaryEver, 
										left.seq = right.seq and
										left.did = right.did 
										// and
										// left.h.prim_range = right.hdr.prim_range and
										// left.h.prim_name = right.hdr.prim_name and
										// left.h.zip = right.hdr.zip
										,
										AddMilityflag(left,right), LOCAL), seq, did, LOCAL);

#IF(onThor)
	MilitaryOut := MilitaryOut_thor;
#ELSE
	MilitaryOut := MilitaryOut_roxie;
#END

// output(HeaderIn, named('HeaderIn'));
// output(JustAddr, named('JustAddr'));
// output(IsMilitaryAddr, named('IsMilitaryAddr'));
// output(MilitaryZip, named('MilitaryZip'));
// output(MilitaryOut, named('MilitaryOut'), all);

RETURN MilitaryOut;
	
END;