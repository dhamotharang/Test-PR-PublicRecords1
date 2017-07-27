import doxie_raw,doxie;

doxie.MAC_Header_Field_Declare()

export bankruptcy_records(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

raw := Doxie_Raw.bk_raw
	(doxie_raw.ds_EmptyDIDs, 
	 project(bdids,doxie.Layout_ref_bdid),
     ,//string7 cnum = '',
     ,//string5  ccode = '',
     ,//unsigned3 dateVal = 0,
     DPPA_Purpose,
     GLB_Purpose,
    ssn_mask_value,
		'D'
);

outrec := record (Doxie.layout_bk_output)
	boolean    SelfRepresented;		//to match accurint
	boolean    AssetsForUnsecured;
end;

outrec add_decodes(Doxie.layout_bk_output l) := transform
	self.SelfRepresented := l.pro_se_ind = 'Y';
	self.AssetsForUnsecured := l.assets_no_asset_indicator = 'Y';
	self := l;
end;

return if(BankruptcyVersion in [0,1],project(raw, add_decodes(left)));
END;
