export Best_Org_Type(dataset (Marketing_Best.Layout_Common) inDataSet) :=
function

dedup_srtd_orgType := dedup(sort(inDataSet, bdid, -updateDate, -orgTypeWeight),bdid);

return dedup_srtd_orgType;

end;