
import ut;

FIDO_extract_in := dataset(inquiry_acclogs.foreign_fido_prod + 'thor::red::extract::inquiry_tracking_extract', inquiry_acclogs.Layout_FIDO.extract_in, flat);

FIDO_extract_out := project(FIDO_extract_in,
transform(inquiry_acclogs.Layout_FIDO.extract_out, self.opt_out := trim((string)left.opt_out, left,right),
 self.disable_observation := trim((string)left.disable_observation,left,right), self := left, self := []));

//filter product_id and sub_product_id 

FIDO_has_valid_product_id := FIDO_extract_out(mbs_product_id in [0,1, 2, 5,13] or (mbs_product_id = 7 and mbs_sub_product_id in [70001, 70004, 70005]
or mbs_gc_id in [6542315, 20667132]));

EXPORT File_FIDO := dedup(FIDO_has_valid_product_id, all);

