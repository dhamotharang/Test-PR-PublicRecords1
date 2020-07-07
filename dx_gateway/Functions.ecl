import iesp, STD;
EXPORT Functions := MODULE

  EXPORT hasNameToClean(iesp.share.t_name t_name) := 
    STD.STR.CleanSpaces(t_name.Full+t_name.First+t_name.Last) <> '';

  EXPORT hasAddressToClean(iesp.share.t_Address t_addr) := 
    STD.STR.CleanSpaces(t_addr.StreetAddress1+t_addr.StreetName+t_addr.StreetNumber+t_addr.City+t_addr.State+t_addr.Zip5) <> '';

  EXPORT appendSequence(in_recs) := FUNCTIONMACRO
    LOCAL rec_sequence := RECORD
      unsigned8 seq;
    END;
    LOCAL l_seq := RECORDOF(in_recs) OR rec_sequence;
    RETURN PROJECT(in_recs, TRANSFORM(l_seq, SELF.seq := COUNTER; SELF := LEFT));
  ENDMACRO;

END;