IMPORT iesp, doxie, marriage_divorce_v2_Services;

mardiv_layout    := iesp.marriagedivorce.t_MarriageSearch2Record;
partyLayout      := iesp.marriagedivorce.t_MarriageSearch2Party ;
partyRawLayout   := marriage_divorce_v2_Services.layouts.party_combined.wide;
  
EXPORT mardiv_layout marriagedivorce_records (
  dataset (doxie.layout_references) dids,
  input.mardiv in_params = module (input.mardiv) end,
  boolean IsFCRA = false
  ) := FUNCTION
  //get marriage and divorce records for did
  mdDids := project(dids,marriage_divorce_v2_Services.layouts.l_did);
  ds_mardiv_ids := marriage_divorce_v2_Services.MDRaw.get_id_from_did (mdDids);
	ds_mardiv := marriage_divorce_v2_Services.MDRaw.wide_view.by_id(ds_mardiv_ids);
  
  partyLayout formatParty(partyRawLayout L) := transform
    self.UniqueId                     := INTFORMAT(L.did,12,1);   //left padded w/ zeros to 12 chars  
    self.PartyType                    := L.party_type_name ;
    self.PartyTypeCode                := L.party_type    ;
    self.name.full                    := L.nameasis;
    self.name        := iesp.ECL2ESP.SetNameFields(L.fname,L.mname,L.lname,'',L.name_suffix,L.title);
    self.address     := iesp.ECL2ESP.setAddressFields(L.prim_name,L.prim_range,L.predir,L.postdir,L.suffix,  
                                                      L.unit_desig,L.sec_range,L.p_city_name,'','',L.st,L.zip,  
                                                      L.zip4,L.county,L.zip);
    self.Age                           := (integer)L.age  ;
    self.TimesMarried                  := (integer)L.times_married  ;
    self.dob                           := iesp.ECL2ESP.toDatestring8(L.dob);
    self.PreviousMaritalStatus         := L.previous_marital_status  ;
    self.BirthState                    := L.birth_state  ;
    self.HowMarriageEnded              := L.how_marriage_ended  ;
    self.Race                          := L.race  ;
  end;
  

  mardiv_layout formatMarDiv (ds_mardiv L)  := transform 
    self.AlsoFound                   := false ;   // not sure what to put in here.
    self.RecordId                    := (string)L.record_id;
    self.FilingType                  := L.filing_type_name  ;
    self.FilingTypeCode              := L.filing_type  ;
    self.StateOrigin                 := L.state_origin_name  ;
    self.FilingNumber                := L.filing_number  ;
    self.FilingDate                  := iesp.ECL2ESP.toDatestring8(L.filing_dt);
    self.MarriageDate                := iesp.ECL2ESP.toDatestring8(L.marriage_dt);
    self.DivorceDate                 := iesp.ECL2ESP.toDatestring8(L.divorce_dt);
    self.CountyOrigin                := L.marriage_county  ;
    self.DivorceCounty               := L.divorce_county  ;
    self.CityOrigin                  := L.marriage_city  ;
    self.DivorceGrounds              := L.grounds_for_divorce ;
    self.NumberOfChildren            := (integer)L.number_of_children  ;
    self.Party1                      := project (L.party1, formatParty(Left));
    self.Party2                      := project (L.party2, formatParty(Left));
    self.Ceremony                    := L.type_of_ceremony  ;
    self.PlaceOfMarriage             := L.place_of_marriage ;  

  end;
 
  outRecs := project (ds_mardiv, formatMarDiv (Left));
	
	// output(mdDids,named('mdDids'));
	// output(ds_mardiv_ids,named('ds_mardiv_ids'));
	// output(ds_mardiv,named('ds_mardiv'));
  
  RETURN outRecs;
END;