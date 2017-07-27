IMPORT Business_Header;

bhf := Business_Header.File_Business_Header_Previous;

Layout_RCID := RECORD
bhf.rcid;
END;

tbl :=TABLE(bhf, Layout_RCID);

EXPORT Max_RCID := MAX(tbl, rcid) : STORED('HiBusHdrRCID'); //94687183