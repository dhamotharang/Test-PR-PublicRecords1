//why a macro? i had two different, but similar, layouts needing to share this. and, one of those layouts was defined very locally.
//note: this code was pulled from UPS_Services.mod_Rollup
EXPORT mac_SortAddresses(addrs, srtd) := MACRO
      srtd :=
      SORT(
        addrs,
        -DateLastSeen.year,
        -DateLastSeen.month,
        -DateFirstSeen.year,
        -DateFirstSeen.month,
        State,
        Zip5,
        StreetName,
        StreetNumber,
        UnitNumber
      );
ENDMACRO;
