
layout_prep_agency_deletes_rec prep_agency_deletes(layout_in_agency_deletes_raw_xml L):= TRANSFORM
// The rest of the fields
self:=L;
END;

export prep_agency_deletes_from_raw :=PROJECT(file_in_agency_deletes_raw_xml,prep_agency_deletes(LEFT));