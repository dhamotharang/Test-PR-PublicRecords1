export Best_Tax_Lien(dataset (Marketing_Best.Layout_Common) inDataSet) :=
function

dedup_srtd_liens := dedup(sort(inDataSet, bdid, -updateDate),bdid);

return dedup_srtd_liens;

end;