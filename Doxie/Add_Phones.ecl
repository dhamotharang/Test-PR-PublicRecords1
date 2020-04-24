IMPORT business_header, doxie_raw, ut, risk_indicators, paw, doxie, STD, suppress;

EXPORT Add_Phones(DATASET(layout_references) in_dids,
  DATASET(doxie.layout_relative_dids) rels,
  Doxie.IDataAccess mod_access,
  integer dbd_value = 0) :=
FUNCTION


phonesplus :=
RECORD
  unsigned6 did;
  DATASET(layout_phones) WorkPhones{MAXCOUNT(50)};
  DATASET(layout_phones) RelativePhones{MAXCOUNT(50)};
END;

Layout_Employment_Out_plus := record(business_header.Layout_Employment_Out)
  unsigned4 global_sid;
  unsigned8 record_sid;
end;

Layout_Employment_Out_plus get_paw(paw.Key_Did le, paw.Key_contactID ri) :=
TRANSFORM
  SELF.did := intformat(ri.did,12,1);
  SELF.bdid := intformat(ri.bdid,12,1);
  SELF := ri;
END;

paw_did := JOIN(in_dids,paw.Key_Did,keyed(left.did=right.did),transform(right), LIMIT(ut.limits.DEFAULT, SKIP));
paw_pre := JOIN(paw_did,paw.Key_contactID,keyed(LEFT.contact_id=RIGHT.contact_id) AND
            ut.DaysApart(RIGHT.dt_last_seen, (string) STD.Date.Today()) < 365,
            get_paw(LEFT,RIGHT),
            LIMIT(ut.limits.PAW_PER_CONTACTID,SKIP)); // < 26  in index
paw := project(suppress.MAC_SuppressSource(paw_pre,mod_access),business_header.Layout_Employment_Out);

layout_phones form_paw_phones(paw le) :=
TRANSFORM
  SELF.listed := false;
  SELF.listed_name := le.company_name;
  SELF.did := (unsigned6)le.did;
  SELF.bdid := (unsigned6)le.bdid;
  SELF := [];
END;

layout_phones add_bus_phone(layout_phones le, business_header.Key_BH_Best ri) :=
TRANSFORM
  ri_phone := (STRING10)ri.phone;
  SELF.phone10 := IF(ri.phone=0,'',ri_phone);
    telcordia := if(ri_phone<>'', Risk_Indicators.Key_Telcordia_tds(
    length(trim(ri_phone,all))=10 and
    keyed(ri_phone[1..3]=npa) and
    keyed(ri_phone[4..6]=nxx))[1]);
  SELF.timezone := ut.TimeZone_Convert((unsigned1) telcordia.timezone,telcordia.state);
  SELF := le;
END;

phonesplus form_paw(paw le) :=
TRANSFORM
  SELF.did := (unsigned6)le.did;
  SELF.WorkPhones := CHOOSEN(JOIN (DATASET(PROJECT(le,form_paw_phones(LEFT))), business_header.Key_BH_Best,
                                   LEFT.bdid<>0 AND keyed(LEFT.bdid=RIGHT.bdid),
                                   add_bus_phone(LEFT,RIGHT), KEEP(1), LIMIT (0)),
                             50);
  SELF := [];
END;
paw_pres := PROJECT(paw, form_paw(LEFT));

// relatives
doxie_raw.Layout_HeaderRawBatchInput tra_for_Batch(rels l) := transform
  self.input.seq := l.person1;
  self.input.did := l.person2;
  SELF := [];
end;

best_rel := DEDUP(SORT(rels,person1,-number_cohabits),person1,KEEP(2))+
            DEDUP(SORT(rels,person1,-recent_cohabit),person1,KEEP(2));
for_batch := GROUP(DEDUP(SORT(project(best_rel, tra_for_Batch(left)),input.seq,input.did),input.seq,input.did),input.seq,input.did);
rel_header := CHOOSEN(SORT(DEDUP(SORT(doxie_Raw.Header_Raw_batch(for_batch, mod_access),did,-dt_last_seen),did,KEEP(2)),-dt_last_seen),10);
rel_appended := doxie.append_gong(PROJECT(rel_header, TRANSFORM(doxie.Layout_presentation,SELF := LEFT,SELF := [])),
  rels, mod_access, 2);

rel_appended patch_did(rel_appended le, for_batch ri) :=
TRANSFORM
  SELF.did := ri.input.seq;
  SELF := le;
END;
rel_patched := JOIN(rel_appended,for_batch,LEFT.did=RIGHT.input.did,patch_did(LEFT,RIGHT),LOOKUP,LEFT OUTER);

phonesplus form_rel(rel_patched le) :=
TRANSFORM
  SELF.did := le.did;
  SELF.RelativePhones := CHOOSEN(le.Phones,50);
  SELF.WorkPhones := [];
END;
rel_pres := PROJECT(rel_patched, form_rel(LEFT));

phonesplus rollem(phonesplus le, phonesplus ri) :=
TRANSFORM
  SELF.RelativePhones := CHOOSEN(le.RelativePhones&ri.RelativePhones,50);
  SELF.WorkPhones := CHOOSEN(le.WorkPhones&ri.WorkPhones,50);
  SELF := le;
END;
phonesplus ddp(phonesplus le) :=
TRANSFORM
  SELF.RelativePhones := CHOOSEN(DEDUP(SORT(le.RelativePhones(phone10<>'',listed),listed_name,phone10,RECORD),RECORD),10);
  SELF.WorkPhones := CHOOSEN(DEDUP(SORT(le.WorkPhones(phone10<>''),listed_name,phone10,RECORD),RECORD),10);
  SELF := le;
END;
all_pres := PROJECT(ROLLUP(SORT(IF(dbd_value>=4,paw_pres)+
                                IF(dbd_value>=5,rel_pres),did),rollem(LEFT,RIGHT),did),ddp(LEFT));

RETURN all_pres;

END;
