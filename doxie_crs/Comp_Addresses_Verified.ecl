import doxie;

export Comp_Addresses_Verified(boolean Legacy_Verified_Value, boolean showRestricted = false) := function
  legacy_addr := Doxie.fn_addLVV(doxie.Comp_Addresses);
  return if (Legacy_Verified_Value,
             if (showRestricted, legacy_addr.records_wListedPhone, legacy_addr.records),
             doxie.Comp_Addresses);
end;