c := UCCD.File_WithExpCollateral_Patched;
nopatch := c(~(file_state in uccd.set_UseExpCollateralStates and ~isdirect));
uccd.mac_filterStateOverlap(nopatch, stateclean)
export File_WithExpCollateral := stateclean;