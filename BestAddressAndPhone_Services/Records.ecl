import AddrBest, progressive_phone, Doxie;

export Records (dataset(AddrBest.Layout_BestAddr.Batch_in_both) f_in_raw,
  Doxie.IDataAccess mod_access) := function

f_in_best_addr := project(f_in_raw,AddrBest.Layout_BestAddr.Batch_in);

bestaddrs := AddrBest.BestAddr_common(f_in_best_addr, mod_access);

f_in_progressive_phone := project(f_in_raw,transform(progressive_phone.layout_progressive_batch_in,self.did := 0,self := left));

vIncludeAllPhonesPlusData := FALSE : STORED('IncludeAllPhonesPlusData');

tmpMod :=
MODULE(progressive_phone.waterfall_phones_options)
  EXPORT BOOLEAN SkipPhoneScoring := TRUE;
  EXPORT BOOLEAN DedupOutputPhones := IF(~SkipPhoneScoring,FALSE,NOT KeepAllPhones); // We need to keep all phones from all WF levels in order to run the model
  EXPORT BOOLEAN ExcludeNonCellPPData := ~vIncludeAllPhonesplusData;
END;

ProgressivePhones := AddrBest.Progressive_phone_common(f_in_progressive_phone,tmpMod);

pre_out_rec := AddrBest.Layout_BestAddr.batch_out_both;

pre_out_rec pre_out_format(bestaddrs l,integer C):=transform
self.cnt := C;
self.ind := 'A';
self := l;
self := [];
end;

pre_out_rec pre_out_format2(progressivePhones l,integer C):=transform
self.cnt := C;
self.ind := 'P';
self := l;
self := [];
end;

both := project(bestaddrs, pre_out_format(left,counter)) + project(ProgressivePhones, pre_out_format2(left,counter));

out_recs := project(sort(both,acctno,ind,cnt),AddrBest.Layout_BestAddr.batch_out_both);
recs_fmt:= BestAddressAndPhone_Services.Functions.fnSearchVal(out_recs);
return recs_fmt;
end;


