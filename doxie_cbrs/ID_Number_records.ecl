IMPORT doxie, doxie_cbrs;

doxie_cbrs.mac_Selection_Declare()

EXPORT ID_Number_records(DATASET(doxie_cbrs.layout_references) bdids,
                         doxie.IDataAccess mod_access
                        ) := FUNCTION


//inputs
cfr := doxie_cbrs.Corporation_Filings_records(bdids)(Include_CompanyIDnumbers_val);
bes := (doxie_cbrs.best_records_prs_others_max(bdids,mod_access) + doxie_cbrs.best_records_prs_target(bdids,mod_access))(Include_CompanyIDnumbers_val);


feinrec := record
	string9 	FEIN := '';
	string120 company_name;
end;

corprec := record
	string2   corp_state_origin := '';
	string32  corp_orig_sos_charter_nbr := '';
	string350 corp_legal_name := '';
end;

idrec := record, maxlength(100000)
	string12 	BDID := '';
	dataset(feinrec) fein_children;
	dataset(corprec) corp_children;
	dataset(doxie_Cbrs.layout_ID_BBB_children) BBB_children;
	dataset(doxie_cbrs.layout_ID_DCA_children) DCA_children;
end;


// ********* Corp Filing *************

idrec tracf(cfr l) := transform
	self.bdid := if ((integer)L.bdid = 0, '',(string12)l.bdid);
	self.corp_children := dataset([{l.corp_state_origin,l.corp_orig_sos_charter_nbr, l.corp_legal_name}], corprec);
	self := [];
end;

cfp := project(dedup(cfr,corp_state_origin,corp_orig_sos_charter_nbr, corp_legal_name, bdid,all) , tracf(left));

idrec rollem(idrec l, idrec r) := transform
	self.bdid := if(l.bdid = '', r.bdid, l.bdid);
	self.corp_children := if(exists(r.corp_children), l.corp_children + r.corp_children, l.corp_children);
	self := l;
end;

cf := rollup(sort(cfp, bdid), left.bdid = right.bdid, rollem(left, right));


// ********* FEIN *************

idrec trabe(idrec l,bes r) := transform
	self.bdid := if(r.bdid > 0, (string12)r.bdid, l.bdid);
	self.fein_children := dataset([{if ((integer)r.fein = 0, '', r.fein), r.company_name}], feinrec);		//1 by definition right now
	self := l;
end;

be := join(cf, bes, 
					 (string12)left.bdid = (string12)right.bdid, 
						trabe(left, right), right outer);


// ********* BBB *************

bbbs := doxie_cbrs.ID_Number_BBB(bdids);
idrec addbbb(be l, bbbs r) := transform
	self.bbb_children := r.bbb_children;
	self := l;
end;

wbbb := join(be, bbbs, (string12)left.bdid = (string12)right.bdid, 
					   addbbb(left, right), left outer, lookup);


// ********* DCA *************
					 
dcas := doxie_cbrs.ID_Number_dca(bdids);
idrec adddca(wbbb l, dcas r) := transform
	self.dca_children := r.dca_children;
	self := l;
end;

wdca := join(wbbb, dcas, (string12)left.bdid = (string12)right.bdid, 
					   adddca(left, right), left outer, lookup);

return wdca((integer)bdid > 0);
END;