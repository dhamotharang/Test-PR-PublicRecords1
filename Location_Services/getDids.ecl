import doxie, doxie_raw, ut, suppress;

export getDids(DATASET(Doxie_Raw.Layout_address_input) addr_in, String32 apptype) :=  FUNCTION

doxie.Layout_AddressSearch getAddrSrch(Doxie_Raw.Layout_address_input L) := TRANSFORM
	SELF.seq := 0;
	SELF.prim_name := ut.StripOrdinal(L.prim_name);
	SELF.state := L.st;
	SELF := L;
END;
inputAddr := PROJECT(addr_in, getAddrSrch(LEFT));

addrDids := doxie.did_from_address(inputAddr,true);

layout_did_addr mergeInputs(addr_in L, addrDids R) := TRANSFORM
	SELF.did := R.did;
	SELF := L;
END;

addrDidsWithInputs := JOIN(addr_in, addrDids, true, mergeInputs(LEFT,RIGHT), all);
ut.PermissionTools.GLB.mac_FilterOutMinors(addrDidsWithInputs,addrDidsWithInputsNoMinors)
Suppress.MAC_Suppress(addrDidsWithInputsNoMinors,addrDidsWithInputsFilt,apptype,Suppress.Constants.LinkTypes.DID,did);

RETURN addrDidsWithInputsFilt;
END;