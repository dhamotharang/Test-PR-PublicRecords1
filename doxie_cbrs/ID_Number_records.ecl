IMPORT doxie, doxie_cbrs;

doxie_cbrs.mac_Selection_Declare()

EXPORT ID_Number_records(DATASET(doxie_cbrs.layout_references) bdids,
                         doxie.IDataAccess mod_access
                        ) := FUNCTION


//inputs
cfr := doxie_cbrs.Corporation_Filings_records(bdids)(Include_CompanyIDnumbers_val);
bes := (doxie_cbrs.best_records_prs_others_max(bdids,mod_access) + doxie_cbrs.best_records_prs_target(bdids,mod_access))(Include_CompanyIDnumbers_val);


feinrec := RECORD
  STRING9 FEIN := '';
  STRING120 company_name;
END;

corprec := RECORD
  STRING2 corp_state_origin := '';
  STRING32 corp_orig_sos_charter_nbr := '';
  STRING350 corp_legal_name := '';
END;

idrec := RECORD, MAXLENGTH(100000)
  STRING12 BDID := '';
  DATASET(feinrec) fein_children;
  DATASET(corprec) corp_children;
  DATASET(doxie_Cbrs.layout_ID_BBB_children) BBB_children;
  DATASET(doxie_cbrs.layout_ID_DCA_children) DCA_children;
END;


// ********* Corp Filing *************

idrec tracf(cfr l) := TRANSFORM
  SELF.bdid := IF ((INTEGER)L.bdid = 0, '',(STRING12)l.bdid);
  SELF.corp_children := DATASET([{l.corp_state_origin,l.corp_orig_sos_charter_nbr, l.corp_legal_name}], corprec);
  SELF := [];
END;

cfp := PROJECT(DEDUP(cfr,corp_state_origin,corp_orig_sos_charter_nbr, corp_legal_name, bdid,ALL) , tracf(LEFT));

idrec rollem(idrec l, idrec r) := TRANSFORM
  SELF.bdid := IF(l.bdid = '', r.bdid, l.bdid);
  SELF.corp_children := IF(EXISTS(r.corp_children), l.corp_children + r.corp_children, l.corp_children);
  SELF := l;
END;

cf := ROLLUP(SORT(cfp, bdid), LEFT.bdid = RIGHT.bdid, rollem(LEFT, RIGHT));


// ********* FEIN *************

idrec trabe(idrec l,bes r) := TRANSFORM
  SELF.bdid := IF(r.bdid > 0, (STRING12)r.bdid, l.bdid);
  SELF.fein_children := DATASET([{IF ((INTEGER)r.fein = 0, '', r.fein), r.company_name}], feinrec); //1 by definition RIGHT now
  SELF := l;
END;

be := JOIN(cf, bes,
           (STRING12)LEFT.bdid = (STRING12)RIGHT.bdid,
            trabe(LEFT, RIGHT), RIGHT OUTER);


// ********* BBB *************

bbbs := doxie_cbrs.ID_Number_BBB(bdids);
idrec addbbb(be l, bbbs r) := TRANSFORM
  SELF.bbb_children := r.bbb_children;
  SELF := l;
END;

wbbb := JOIN(be, bbbs, (STRING12)LEFT.bdid = (STRING12)RIGHT.bdid,
             addbbb(LEFT, RIGHT), LEFT OUTER, lookup);


// ********* DCA *************
           
dcas := doxie_cbrs.ID_Number_dca(bdids);
idrec adddca(wbbb l, dcas r) := TRANSFORM
  SELF.dca_children := r.dca_children;
  SELF := l;
END;

wdca := JOIN(wbbb, dcas, (STRING12)LEFT.bdid = (STRING12)RIGHT.bdid,
             adddca(LEFT, RIGHT), LEFT OUTER, lookup);

RETURN wdca((INTEGER)bdid > 0);
END;
