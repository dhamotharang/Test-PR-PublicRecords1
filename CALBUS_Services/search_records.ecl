import doxie, business_header;

unsigned2 pt := 10 : stored ('PenaltThreshold');

business_header.doxie_MAC_Field_Declare ();

boolean IsDeepDive := ~noDeepDive;

boolean is_CompSearchL := company_name_value <> '' or phone_value <> '' or Business_Header.stored_bdid_value > 0;

ids := CALBUS_services.Get_ids (false, , IsDeepDive, is_CompSearchL); //this is layout [layouts.id + isDeepDive]

rec_ids := project (ids, layouts.id);

ds_recs := CALBUS_services.raw.SEARCH_VIEW.by_id (rec_ids);
//export search_records := ids;

rdd := join (ds_recs, dedup (sort (ids, account_number, if(isDeepDive, 1, 0)), account_number), 
             left.account_number= right.account_number,
             transform ({ids.isDeepDive, ds_recs}, self.isDeepDive := right.isDeepDive, self := left),
             left outer);

rsrt := sort (rdd (penalt <= pt), if (isDeepDive, 1, 0), penalt, OWNER_NAME);

// doxie.MAC_Marshall_Results (rsrt, rmar);

// export search_records := rmar;

EXPORT search_records := rsrt;
