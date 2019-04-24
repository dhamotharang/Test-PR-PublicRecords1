IMPORT dx_header;

// FnSetCurrAddrBit sets bit 32 in lookups field if the address is "best".  Bit is set here b/c
// setting it in header.Prepped_For_Keys exposes a different value in lookups
// used in other keys which do not include an address and do not exclude 
// the lookups field in dedup leaving duplicates in the key,
// one with the curr_addr bit set and one w/o.

EXPORT Key_Header_Wild_Address := dx_header.key_wild_address();
