layout_prep_charges_rec normCharges(layout_in_charges_raw_xml R , String ts1, String ts2,string maxq, String agencykey, String agency_ori ):= TRANSFORM
self.creation_ts := fnDateTime(ts1);
self.last_change_ts := fnDateTime(ts2);
self.maxqueuesid := maxq;
self.agencykey:= agencykey;
self.agencyori := agency_ori;
self.doctype  :='booking';
self.charge_dt := fnDateTime(R.charge_dt);
self.court_dt := fnDateTime(R.court_dt);
self.disposition_dt := fnDateTime(R.disposition_dt);
// The rest of the charges fields
self:=R;
END;
ds_bookings:=file_in_bookings_raw_xml;
export prep_norm_charges_from_raw := NORMALIZE(ds_bookings,LEFT.charge_detail,normCharges(RIGHT, LEFT.creation_ts, LEFT.last_change_ts, LEFT.maxqueuesid, LEFT.agencykey, LEFT.agency_ori));
