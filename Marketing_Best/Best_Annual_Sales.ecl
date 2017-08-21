export Best_Annual_Sales(dataset (marketing_best.Layout_Common) inDataSet) := 
function

dedup_srtd_sales := dedup(sort(inDataSet, bdid, -updateDate, -salesWeight),bdid);

return dedup_srtd_sales;

end;