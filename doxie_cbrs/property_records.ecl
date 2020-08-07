IMPORT doxie, doxie_crs, doxie_ln, Suppress, STD;

STRING26 alphabet := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
doxie_cbrs.mac_Selection_Declare()

EXPORT property_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

br := doxie_cbrs.best_records_bdids(bdids)(Include_Properties_val AND
               ((ln_branded_value AND bdid IN SET(bdids,bdid))
                OR (NOT ln_branded_value AND bdid = doxie_cbrs.subject_BDID)
                OR use_SupergroupPropertyAddress_val));

//get the fares IDs by address
doxie.layout_propertySearch tra(br l) := TRANSFORM
  SELF.zip := (STRING5)l.zip;
  SELF.suffix := l.addr_suffix;
  SELF.address_seq_no := 0;
  SELF := l;
END;

brt := DEDUP(PROJECT(br, tra(LEFT)), ALL);

idsADDR := doxie_ln.get_PriorProperty_ids(brt);

//get the fares IDs by BDID
bdids_use := bdids(Include_Properties_val);
idsBDID := doxie_cbrs.getPropertyIDsByBDID(bdids_use);

//get all my IDs organized
IDrec := doxie_ln.layout_property_ids;


IDrec addrtra(idsADDR l) := TRANSFORM
  SELF.bdid := 0;
  SELF.current := TRUE;
  SELF := l;
END;

IDrec bdidtra(idsBDID l) := TRANSFORM
  SELF.address_seq_no := 0;
  SELF.did := 0;
  SELF.current := TRUE;
  SELF := l;
END;

ia := PROJECT(idsADDR, addrtra(LEFT));
ib := PROJECT(idsBDID, bdidtra(LEFT));
           
id_dups := (ia + ib)(source_code[1] = 'O');
           
ids := DEDUP(id_dups, fid, ALL);

//use mac to get deeds and assesors

dr := doxie_ln.deed_records (ids);
ar := doxie_ln.asses_records (ids);

both0 := doxie_ln.make_property_records(ar, dr, TRUE);
both := IF(doxie.DataRestriction.Fares,both0(ln_fares_id[1] <>'R'),both0);

//take a shot at reverse engineering the logic
owns := both(source_code='O');

grp := GROUP(owns,
             STD.Str.Filter (property_address_citystatezip, alphabet),
             TRIM(property_full_street_address, ALL),
             TRIM(property_address_unit_number, ALL), ALL);
         
srt := SORT(grp,
         name_owner_1[1..5], -doxie_ln.get_LNFirst(ln_fares_id));
         
//dedup owned property records by property address, owner-seller-code
ddpd := DEDUP(srt,
          name_owner_1[1..5]);
          
//mark the most recent at each address as current
srt2 := SORT(ddpd, -compare_date);

outrec := doxie_cbrs.layout_property_records;

srt2 iter(srt2 l, srt2 r) := TRANSFORM
  SELF.current := IF(l.ln_fares_id = '', TRUE, FALSE);
  SELF := r;
END;

itd := GROUP(ITERATE(srt2, iter(LEFT, RIGHT)));

//mark those that came from address (for split down the road)
outrec mrkema(itd l,IDrec r) := TRANSFORM
  SELF.bdid := 0;
  SELF.byBDID := FALSE;
  SELF.byAddress := r.fid <> '';
  SELF := l;
END;

mrkda := JOIN(itd, DEDUP(SORT(ia, fid, did, bdid, address_seq_no, source_code, current), fid),
              LEFT.ln_fares_id = RIGHT.fid, mrkema(LEFT, RIGHT), LEFT OUTER);

//mark those that came from bdid
outrec mrkemb(mrkda l, IDrec r) := TRANSFORM
  SELF.bdid := r.bdid;
  SELF.byBDID := r.bdid > 0;
  SELF.title_company_name := ''; //CKB - hack for now, for bugzilla 14975
  SELF := l;
END;

mrkdb := JOIN(mrkda, DEDUP(SORT(ib, fid, did, bdid, address_seq_no, source_code, current), fid, ALL),
              LEFT.ln_fares_id = RIGHT.fid, mrkemb(LEFT, RIGHT), LEFT OUTER);

mrkdb_accountforfares := IF(doxie.DataRestriction.Fares,mrkdb(ln_fares_id[1]<>'R'),mrkdb);

app_type := IF (isPeopleWise, Suppress.Constants.ApplicationTypes.PeopleWise, application_type_value);

Suppress.MAC_Suppress(mrkdb_accountforfares,suppress_fares_id,App_type,'','',Suppress.Constants.DocTypes.FaresID,ln_fares_id);
Suppress.MAC_Suppress(suppress_fares_id,suppress_bdid,App_type,Suppress.Constants.LinkTypes.BDID,bdid);

RETURN IF(PropertyVersion IN [0,1],SORT(suppress_bdid, RECORD));
END;
