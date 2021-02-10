IMPORT Alerts,iesp;

EXPORT Alert := MODULE
  SHARED UNSIGNED1 version := 1;

  // short names
  SHARED layout_hashval := alerts.layouts.layout_hashval;
  SHARED layout_hash := alerts.layouts.layout_hash;
  
  layout_hashval calcAltNameHashes(iesp.share.t_name l) := TRANSFORM
    SELF.hashval := HASH64(l.last,l.first,l.middle,l.suffix,l.prefix);
  END;

  layout_hashval calcAltAddrHashes(iesp.sexualoffender.t_OffenderAddress l) := TRANSFORM
    SELF.hashval := HASH64(l.Address.StreetNumber,l.Address.StreetPreDirection,
                           l.Address.StreetName,l.Address.StreetPostDirection,
                           l.Address.UnitNumber,l.Address.City,l.Address.State,
                           l.Address.Zip5);
  END;

  EXPORT UNSIGNED8 calcHashval(RECORDOF(SexOffender_Services.Layouts.t_OffenderRecord_plus) l) := FUNCTION
    RETURN HASH64(l.name_orig,l.OffenderStatus,l.offender_category,l.ssn,l.reg_date_1,
                  l.registration_address_1,l.registration_address_2,l.registration_address_3,
                  l.registration_address_4,l.registration_address_5,l.registration_county) +
                  SUM(PROJECT(l.AKAs, calcAltNameHashes(LEFT)), hashval) +
                  SUM(PROJECT(l.AlternativeAddresses,calcAltAddrHashes(LEFT)), hashval);
  END;
  
  Alerts.mac_setupAlerts(SexOffender_Services.Layouts.t_OffenderRecord_plus, calcHashval, version)

END;
