import doxie_raw,doxie;

export doxie_raw.Layout_HeaderRawBatchInput transform_SSNForHead
  (doxie.layout_inBatchMaster l, ssn_services.layout_ssn r) :=
transform

  self.input.seq := l.seq;
  self.input.did := r.did;
  self := [];
end;
