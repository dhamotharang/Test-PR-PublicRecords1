IMPORT doxie, business_header;

UNSIGNED2 pt := 10 : STORED ('PenaltThreshold');

business_header.doxie_MAC_Field_Declare ();

BOOLEAN IsDeepDive := ~noDeepDive;

BOOLEAN is_CompSearchL := company_name_value <> '' OR phone_value <> '' OR Business_Header.stored_bdid_value > 0;

ids := TAXPRO_services.Get_ids (FALSE, , IsDeepDive, is_CompSearchL); //this is layout [layouts.id + isDeepDive]

rec_ids := PROJECT (ids, layouts.id);

ds_recs := TAXPRO_services.raw.SEARCH_VIEW.by_id (rec_ids);
//export search_records := ids;

rdd := JOIN (ds_recs, DEDUP (SORT (ids, tmsid, IF(isDeepDive, 1, 0)), tmsid),
             LEFT.tmsid= RIGHT.tmsid,
             TRANSFORM ({ids.isDeepDive, ds_recs}, SELF.isDeepDive := RIGHT.isDeepDive, SELF := LEFT),
             LEFT OUTER);

rsrt := SORT (rdd (penalt <= pt), IF (isDeepDive, 1, 0), penalt);
doxie.MAC_Marshall_Results (rsrt, rmar);

EXPORT search_records := rmar;
