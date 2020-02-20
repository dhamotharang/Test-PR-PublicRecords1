// ===========================================================================================
// ====== RETURNS CORPORATE AFFILIATION RECORDS FOR A GIVEN PERSON IN ESP-COMPLIANT WAY ======
// ===========================================================================================

IMPORT $, iesp, doxie, doxie_crs, doxie_raw;

out_rec := iesp.bpsreport.t_BpsCorpAffiliation;

EXPORT out_rec CorpAffiliation_records (
  dataset (doxie.layout_references) dids,
  $.IParam.corpaffil in_params = module ($.IParam.corpaffil) end, //currently, a placeholder
  boolean IsFCRA = false
) := FUNCTION

//TODO: use (modified and cleaned) code from doxie.corp_affiliations_records instead.
  ds_affil := Doxie_Raw.CorpAffil_Raw(dids);

  out_rec toOut (doxie_crs.layout_corp_affiliations_records L) := transform 
    Self.Name := iesp.ECL2ESP.SetName (L.fname, L.mname, L.lname, L.name_suffix, L.title, L.contact_name);
    Self.Gender := iesp.ECL2ESP.GetGender (L.title);
    Self.Title := L.affiliation; //str35
    Self.CompanyName := L.corporation_name; //str120
    Self.State := L.state_origin; //str2
    Self.CorporationNumber := L.charter_number; //str32
    Self.Status := ''; // encoded value is missing
    Self.StatusDescription := L.corporation_status;  //str60
    Self.Address := iesp.ECL2ESP.SetAddressWithType (
      l.prim_name, l.prim_range, L.predir, L.postdir, L.suffix, L.unit_desig, L.sec_range, 
      l.city_name, l.st, l.zip, l.zip4, '', _type := L.address_type);
    Self.FilingDate := iesp.ECL2ESP.toDatestring8 (L.filing_date); 
    Self.RecordDate := iesp.ECL2ESP.toDatestring8 (L.record_date);
    Self.RecordType := L.record_type;
    Self.BusinessId := (string12) L.bdid;
		self.BusinessIDs.proxid := l.proxid;
		self.businessIDs.ultid := l.ultid;
		self.businessIDs.orgid := l.orgid;
		self.businessIDs.seleid := l.seleid;
		self.businessIDs.dotid := l.dotid;
		self.BusinessIDs.empid := l.empid;
		self.BusinessIDs.powid := l.powid;
		self.idValue := '';
    Self.ForProfit := L.corp_for_profit_ind; //str1 ? OR str25 corp_for_profit_ind_decoded;

    ds_phones := project (L.phones, transform (iesp.share.t_StringArrayItem, Self.value := Left.phone;));
    Self.Phones := choosen (ds_phones, iesp.Constants.BR.CorpAffiliation_Phones);

    ds_phones_ext := project (L.phones, transform (iesp.share.t_PhoneTimeZone,
                                                   Self.Phone10 := Left.phone; Self.TimeZone := Left.timezone;));    
    Self.PhonesEx := choosen (ds_phones_ext, iesp.Constants.BR.CorpAffiliation_Phones);
  end;

  RETURN project (ds_affil, toOut (Left));
END;
