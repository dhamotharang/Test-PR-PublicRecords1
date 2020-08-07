IMPORT codes, dnb, doxie, doxie_cbrs, ut;
doxie_cbrs.mac_Selection_Declare()

EXPORT DNB_records(DATASET(doxie_cbrs.layout_references) in_bdids, doxie.IDataAccess mod_access) := FUNCTION

//**** keep the group bdids but the target info for comparison
outrec := RECORD
  UNSIGNED1 level := 0;
  doxie_cbrs.Layout_BH_Best_String;
END;

temprecs := fn_best_records(PROJECT(in_bdids,TRANSFORM(doxie_cbrs.layout_supergroup,SELF.group_id := 0,SELF := LEFT)),FALSE);

bes := PROJECT(temprecs,outrec);

ut.MAC_Slim_Back(bes, doxie_cbrs.layout_best_records_prs, wla)

//indicators
wcur := doxie_cbrs.mark_ABCurrent(wla,in_bdids,mod_access);
doxie_cbrs.mac_hasBBB(wcur, wbbb, in_bdids)

bdids0 := wbbb(Include_DunBradstreetRecords_val);
bestinfo := CHOOSEN(doxie_cbrs.fn_best_information(in_bdids,FALSE),1);
      
bdids0 carry(bdids0 l, bdids0 r) := TRANSFORM
  SELF.bdid := r.bdid;
  SELF := IF(EXISTS(bestinfo),PROJECT(bestinfo[1],TRANSFORM(RECORDOF(bdids0),SELF.bdid:=(UNSIGNED)LEFT.bdid,SELF:=LEFT)),IF(l.bdid = 0,r,l));
END;

bdids := ITERATE(bdids0, carry(LEFT, RIGHT));

//***** get the dnb stuff
dnk :=
RECORD
  dnb.key_DNB_BDID;
  doxie_cbrs.layout_best_records_prs.Company_name;
  doxie_cbrs.layout_best_records_prs.zip;
  doxie_cbrs.layout_best_records_prs.prim_range;
  doxie_cbrs.layout_best_records_prs.prim_name;
END;

dnk keepr(bdids l, dnb.key_DNB_BDID r) := TRANSFORM
  SELF := r;
  SELF := l;
END;
dnos := JOIN(bdids, dnb.key_DNB_BDID, KEYED(LEFT.bdid = RIGHT.bd) AND mod_access.use_DNB(), keepr(LEFT,RIGHT));

k := dnb.key_DNB_DunsNum;

layout_dnb :=
RECORD
  DNB.Layout_DNB_Base -[global_sid, record_sid]; //RR-15382 Suppressing CCPA fields IN Doxie_cbrs.Business_Report_Service_Raw OUTPUT
  // unsigned1 zipMatch;
  // unsigned1 addrMatch;
  // unsigned1 coMatch;
END;

layout_dnb keepk(dnos l, k r) := TRANSFORM
  // SELF.zipMatch := (unsigned)(l.zip=r.zip);
  // SELF.addrMatch := (UNSIGNED)(l.prim_range=stringlib.stringtouppercase(r.prim_range)) + (UNSIGNED)(l.prim_name=stringlib.stringtouppercase(r.prim_name));
  // SELF.coMatch := ut.CompanySimilar100(l.company_name, stringlib.stringtouppercase(r.business_name));
  SELF := r;
END;

//**** pick the best ONE

alldnb := JOIN(DEDUP(dnos, ALL), k, KEYED(LEFT.duns_number = RIGHT.duns) AND mod_access.use_DNB(), keepk(LEFT, RIGHT));
srtdnb := SORT(alldnb, IF(bdid IN SET(in_bdids,bdid),0,1),
                       // coMatch,
                       // -zipMatch,
                       // -addrMatch,
                       -date_last_seen,
                       RECORD);
ddpdnb := DEDUP(srtdnb,TRUE); //should leave only ONE RECORD for royalty purposes


//**** decodes

with_decodes := RECORD
  RECORDOF(ddpdnb);
  STRING15 structure_type_decoded;
  STRING30 type_of_establishment_decoded;
  STRING5 owns_rents_decoded;
END;

with_decodes into_out(ddpdnb L) := TRANSFORM
  SELF.structure_type_decoded := codes.keyCodes('DNB_COMPANIES','structure_type',,l.structure_type);
  SELF.type_of_establishment_decoded := codes.keyCodes('DNB_COMPANIES','type_of_establishment',,L.type_of_establishment);
  SELF.owns_rents_decoded := codes.keyCodes('DNB_COMPANIES','owns_rents',,L.owns_rents);
  SELF := L;
END;

RETURN PROJECT(ddpdnb, into_out(LEFT));
END;
