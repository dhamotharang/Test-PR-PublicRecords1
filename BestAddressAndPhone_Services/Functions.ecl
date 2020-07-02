
import ut, Census_Data, AddrBest,BestAddressAndPhone_Services, address,iesp;
export Functions := module

  export fnSearchAddrVal(dataset(AddrBest.Layout_BestAddr.batch_out_both) in_recs) := function
    
    iesp.bestaddressandphone.t_BestAPAddressRecord xform(in_recs l) := TRANSFORM
      self.ListingName :=l.name_dual,
      self.Phone10 := l.phone10,
      self.Name := iesp.ecl2esp.setNameFields(l.name_first, l.name_middle, l.name_last,'',l.name_suffix,''),
      self.ssn := l.ssn,
      self.dob := iesp.ECL2ESP.toDatestring8(l.dob),
      self.NameScore := (unsigned) l.name_score,
      self.SSNScore := (unsigned) l.ssn_score,
      self.RecordDeduped := if(l.dup_flag<>'',true,false),
      self.DateFirstSeen := iesp.ECL2ESP.toDatestring8(l.addr_dt_first_seen),
      self.DateLastSeen := iesp.ECL2ESP.toDatestring8(l.addr_dt_last_seen),
      self.StreetName := l.prim_name,
      self.StreetNumber := l.prim_range,
      self.StreetPreDirection := l.predir,
      self.StreetPostDirection := l.postdir,
      self.StreetSuffix := l.suffix,
      self.UnitDesignation := l.unit_desig,
      self.UnitNumber := l.sec_range,
      self.StreetAddress1 := '';//streetAddress1Value(l.prim_name, l.prim_range, l.predir, l.suffix, l.postdir),
      self.StreetAddress2 := '';//streetAddress2Value(l.p_city_name, '', '', l.st, l.z5),
      self.State := l.st,
      self.City := l.p_city_name,
      self.Zip5 := l.z5,
      self.Zip4 := l.zip4,
      self.County := l.county_name;
      self.PostalCode := '',
      self.StateCityZip := '';//stateCityZipValue(l.p_city_name, '', '', l.st, l.z5),
    END;

    in_recs add_county(in_recs le, census_data.Key_Fips2County ri) :=

    TRANSFORM
      SELF.County_name := ri.county_name;
      SELF := le;
    END;

    in_recs_withCounty := join(in_recs, Census_Data.Key_Fips2County,
      LEFT.st<>'' AND LEFT.fips_county<>'' AND
      KEYED(LEFT.st = right.state_code) and
      KEYED(LEFT.fips_county = RIGHT.county_fips),
      add_county(LEFT,RIGHT),
      LEFT OUTER,KEEP(1));
                    
    temp_filter_search := project(in_recs_withCounty,xform(LEFT));
    filter := choosen(dedup(sort(temp_filter_search,record), record),iesp.Constants.BAP_MAX_COUNT_SEARCH_ADDRESS_RESPONSE_RECORDS);
    return filter;
  end;
  
  
export fnSearchPhoneVal(dataset(AddrBest.Layout_BestAddr.batch_out_both) in_recs) := function
    
    iesp.bestaddressandphone.t_BestAPPhoneRecord xform(in_recs l) := TRANSFORM
      self.ListingName :=l.subj_name_dual;
      self.Phone10 :=l.subj_phone10;
      self.Name := iesp.ecl2esp.setNameFields(l.subj_first, l.subj_middle, l.subj_last,'',l.subj_suffix,'');
      self.PhoneType :=l.phpl_phones_plus_type;
      self.Carrier :=l.phpl_phone_carrier ;
      self.CarrierCity :=l.phpl_carrier_city ;
      self.CarrierState :=l.phpl_carrier_state ;
      self.TypeNew :=l.subj_phone_type_new ;
      self.SwitchType := l.switch_type;
      self.SortOrder :=l.sort_order;
      self.SortOrderInternal := l.sort_order_internal;
      self.DateFirstSeen := iesp.ECL2ESP.toDatestring8(l.subj_date_first);
      self.DateLastSeen := iesp.ECL2ESP.toDatestring8(l.subj_date_last);
    END;
    
    temp_filter_search := project(in_recs,xform(LEFT));
    filter := choosen(dedup(sort(temp_filter_search,record), record),iesp.Constants.BAP_MAX_COUNT_SEARCH_PHONE_RESPONSE_RECORDS);
    return filter;
  end;
export fnSearchVal(dataset(AddrBest.Layout_BestAddr.batch_out_both) in_recs) := function
    
    iesp.bestaddressandphone.t_BestAddressAndPhoneRecords xform(in_recs l) := TRANSFORM
      self.Addresses := fnSearchAddrVal(in_recs(ind='A'));
      self.Phones:= fnSearchPhoneVal(in_recs(ind='P'));
      self.AddressCount := count(fnSearchAddrVal(in_recs(ind='A')));
      self.PhoneCount := count(fnSearchPhoneVal(in_recs(ind='P')));
    END;
    
    temp_filter_search := project(in_recs,xform(LEFT));
    filter := dedup(sort(temp_filter_search,record), record);
    filter_row := row(filter[1],iesp.bestaddressandphone.t_BestAddressAndPhoneRecords);
    return filter_row;
  end;
end;
