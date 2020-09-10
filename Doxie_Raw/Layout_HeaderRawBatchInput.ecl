import doxie;

ri := record
  unsigned8 seq;
  doxie.layout_references;
end;

export Layout_HeaderRawBatchInput := record
  ri input;
  doxie_raw.Layout_HeaderRawOutput;
end;
