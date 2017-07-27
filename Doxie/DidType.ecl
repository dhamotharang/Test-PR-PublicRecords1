IMPORT doxie, header;

// Checking if LexID header record can be returned; 

// "DidTypeMask" query input parameter defines allowed types (default is "11111111" -- all are allowed),
// it is compared with a value stored in lookup field in the header file.
EXPORT DidType := MODULE

  // defines "real" (i.e. powers of 2) bitwise type
  shared unsigned DEAD     := 1 << doxie.lookup_bit (header.Constants.DidType.DEAD);
  shared unsigned NOISE    := 1 << doxie.lookup_bit (header.Constants.DidType.NOISE);
  shared unsigned H_MERGE  := 1 << doxie.lookup_bit (header.Constants.DidType.H_MERGE);
  shared unsigned C_MERGE  := 1 << doxie.lookup_bit (header.Constants.DidType.C_MERGE);
  shared unsigned INACTIVE :=	1 << doxie.lookup_bit (header.Constants.DidType.INACTIVE);
  shared unsigned AMBIG    := 1 << doxie.lookup_bit (header.Constants.DidType.AMBIG);
  shared unsigned NO_SSN   := 1 << doxie.lookup_bit (header.Constants.DidType.NO_SSN);
  shared unsigned CORE     := 1 << doxie.lookup_bit (header.Constants.DidType.CORE);

  // Needed when, for example, checking if utility eader record is allowed.
  EXPORT unsigned ALL_TYPES := DEAD + NOISE + H_MERGE + C_MERGE + INACTIVE + AMBIG + NO_SSN + CORE;

  // calculates "real" integral bit-mask   
  EXPORT unsigned GetBitType (string8 did_type_mask) := 0 +
    IF (did_type_mask [1] not in ['','0'], CORE, 0) |
    IF (did_type_mask [2] not in ['','0'], DEAD, 0) | 
    IF (did_type_mask [3] not in ['','0'], NOISE, 0) |
    IF (did_type_mask [4] not in ['','0'], H_MERGE, 0) |
    IF (did_type_mask [5] not in ['','0'], C_MERGE, 0) |
    IF (did_type_mask [6] not in ['','0'], INACTIVE, 0) |
    IF (did_type_mask [7] not in ['','0'], AMBIG, 0) |
    IF (did_type_mask [8] not in ['','0'], NO_SSN, 0);

  // checks if there's at least one bit in lookup field in the data is set as "allowed"
  EXPORT boolean Test (unsigned4 lookup_did, unsigned int_bit_mask) := 
    (int_bit_mask = ALL_TYPES) OR (lookup_did & int_bit_mask >0);
END;
