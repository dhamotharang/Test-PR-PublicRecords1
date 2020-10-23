IMPORT doxie_raw,doxie;

doxie.MAC_Header_Field_Declare()

EXPORT bankruptcy_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

outrec := doxie_cbrs.layouts.bankruptcy_record;

raw := Doxie_Raw.bk_raw
  (doxie_raw.ds_EmptyDIDs,
   PROJECT(bdids,doxie.Layout_ref_bdid),
     ,//STRING7 cnum = '',
     ,//STRING5 ccode = '',
     ,//UNSIGNED3 dateVal = 0,
     DPPA_Purpose,
     GLB_Purpose,
    ssn_mask_value,
    'D'
);

outrec add_decodes(Doxie.layout_bk_output l) := TRANSFORM
  SELF.SelfRepresented := l.pro_se_ind = 'Y';
  SELF.AssetsForUnsecured := l.assets_no_asset_indicator = 'Y';
  SELF := l;
END;

RETURN IF(BankruptcyVersion IN [0,1],PROJECT(raw, add_decodes(LEFT)));
END;
