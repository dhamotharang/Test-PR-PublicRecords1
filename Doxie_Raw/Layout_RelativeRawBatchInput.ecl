IMPORT doxie_raw;

ri := record
  unsigned8 seq;
  unsigned6 DID;
end;

export Layout_RelativeRawBatchInput:= record
  ri input;
  doxie_raw.Layout_RelativeRawOutput;
end;
