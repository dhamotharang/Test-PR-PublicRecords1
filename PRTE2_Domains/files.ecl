import address,ut,Prte2;

EXPORT Files := module

  EXPORT file_in := DATASET(constants.IN_Domains, Layouts.layout_in, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );

  EXPORT file_base := DATASET(constants.Base_Domains, layouts.layout_base, THOR);

  EXPORT file_key_bdid := PROJECT(file_base(bdid!=0), Layouts.layout_key_bdid);
  
  EXPORT file_key_did :=  PROJECT(file_base(did!=0), TRANSFORM(Layouts.layout_key_did, SELF:=LEFT; SELF:=[]));

  EXPORT file_key_domain  :=  PROJECT(file_base(domain_name!=''), TRANSFORM(Layouts.layout_key_domain, SELF:=LEFT; SELF:=[]));
  
  EXPORT file_key_linkids  :=  PROJECT(file_base, TRANSFORM(Layouts.Layout_Searchfile, SELF:=LEFT; SELF:=[]));
  
  EXPORT file_key_id  := PROJECT(file_base, TRANSFORM(Layouts.layout_key_id, SELF:=LEFT; SELF:=[]));
  
  EXPORT file_whois_base := PROJECT(file_base, TRANSFORM(Layouts.layout_domains_base, SELF:=LEFT, self := []));
  
  EXPORT file_key_whois_domain := PROJECT(file_base, TRANSFORM(Layouts.layout_key_whois_domain, SELF.dn:=LEFT.domain_name; SELF:=LEFT, self := []));

  EXPORT file_key_whois_bdid  := PROJECT(file_base(bdid!=0), TRANSFORM(Layouts.layout_domains_base, SELF:=LEFT, self := [])); 
  
  EXPORT file_key_whois_did   := PROJECT(file_base(did!=0), TRANSFORM(Layouts.layout_key_whois_did,  SELF.d := LEFT.did; SELF:=LEFT, self := []));
	
	EXPORT file_key_linkids_whois  :=  PROJECT(file_base, TRANSFORM(Layouts.Layout_Whois_Base_BIP, SELF:=LEFT; SELF:=[], self := []));
  
  Layouts.layout_key_autokey xform(file_base L, UNSIGNED1 C) := TRANSFORM
    SELF.fname        := CHOOSE(C, L.admin_fname, L.tech_fname, L.registrant_fname), 
    SELF.mname        := CHOOSE(C, L.admin_mname, L.tech_mname, L.registrant_mname),
    SELF.lname        := CHOOSE(C, L.admin_lname, L.tech_lname, L.registrant_lname),
    SELF.prim_name    := CHOOSE(C, L.admin_prim_name, L.tech_prim_name, L.registrant_prim_name),
    SELF.prim_range   := CHOOSE(C, L.admin_prim_range, L.tech_prim_range, L.registrant_prim_range),
    SELF.predir       := CHOOSE(C, L.admin_predir, L.tech_predir, L.registrant_predir),
    SELF.postdir      := CHOOSE(C, L.admin_postdir, L.tech_postdir, L.registrant_postdir),
    SELF.unit_desig   := CHOOSE(C, L.admin_unit_desig, L.tech_unit_desig, L.registrant_unit_desig),
    SELF.sec_range    := CHOOSE(C, L.admin_sec_range, L.tech_sec_range, L.registrant_sec_range),
    SELF.suffix       := CHOOSE(C, L.admin_suffix, L.tech_suffix, L.registrant_suffix),
    SELF.state        := CHOOSE(C, L.admin_state, L.tech_state, L.registrant_state),
    SELF.v_city_name  := CHOOSE(C, L.admin_v_city_name, L.tech_v_city_name, L.registrant_v_city_name),
    SELF.Zip          := CHOOSE(C, L.admin_zip, L.tech_zip, L.registrant_zip),

    SELF.Compname             := L.registrant_name,
    SELF.internetservices_id  := L.internetservices_id;

    SELF := L;
		self := [];
   END;

  EXPORT file_whois_autokey  := NORMALIZE(file_base, 3, xform(LEFT, COUNTER));
  
END;
 