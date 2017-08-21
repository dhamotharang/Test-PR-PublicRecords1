import business_header, doxie;

business_header.doxie_MAC_Field_Declare();

dids := doxie.Get_Dids();
bdids := if (comp_name_value != '', business_header.doxie_get_bdids(true), dataset([],{unsigned6	bdid})) +
			dataset([{(integer)bdid_value}],{unsigned6 bdid})(bdid != 0);


string30 Hull_Num := ''  : stored('HullId');
string50 VName    := '' 	: stored('VesselName');

vidrec := record
	string10 vessel_id;
end;


vidrec bydid(dids L, merchant_vessels.Key_Merch_Vessel_Did_to_ViD R) := transform
	self := R;
end;

vidrec bybdid(bdids L, merchant_vessels.Key_Merchant_Vessel_BDid R) := transform
	self := R;
end;

vidrec byHull(merchant_vessels.Key_Merch_Vessel_HullId R) := transform
	self := R;
end;

vidrec byvname(merchant_vessels.Key_Merch_Vessel_VName R) := transform
	self := R;
end;

vid1 := join(dids,merchant_vessels.Key_Merch_Vessel_Did_to_ViD, left.did = right.did, 
			bydid(LEFT,RIGHT));

vid2 := join(bdids,merchant_vessels.Key_Merchant_Vessel_BDID, left.bdid = right.bdid,
		bybdid(LEFT,RIGHT));

vid3 := project(merchant_vessels.Key_Merch_Vessel_HullId(hull_number = hull_num), byHull(LEFT));

vid4 := project(merchant_vessels.Key_Merch_Vessel_Vname(name_of_vessel = vname), byVName(LEFT));

allvids := dedup(sort(vid1 + vid2 + vid3 + vid4,vessel_id),vessel_id);

merchant_vessels.Layout_DID_MV get_fullrecs(allvids L, merchant_vessels.Key_Merch_Vessel_ViD R) := transform
	self := R;
end;

outf := join(allvids, merchant_vessels.Key_Merch_Vessel_ViD, left.vessel_id = right.vessel_id,
			get_fullrecs(LEFT,RIGHT));

			
export Merchant_Vessel_Records := outf(hull_num 	= '' or hull_number = hull_num,
							    vname 	= '' or name_of_vessel = vname,
							    bdid_value = 0  or bdid = bdid_value,
							    did_value  = ''  or did  = (integer)did_value,
							    lname_value = '' or lname = lname_value);
