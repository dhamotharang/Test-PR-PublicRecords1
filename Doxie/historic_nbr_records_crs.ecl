export historic_nbr_records_crs(boolean checkRNA=true) := FUNCTION
doxie.MAC_Selection_Declare();
doxie.MAC_Header_Field_Declare();
historic_nbr_records(doxie.header_records(),a,checkRNA)
ut.PermissionTools.GLB.mac_FilterOutMinors(a,afil,,,dob)
RETURN afil;
END;