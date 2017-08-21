export Best_Employee_Count(dataset (Marketing_best.Layout_Common) inDataSet) := 
function
									 
dis_ds_in_srt := dedup(sort(inDataSet, bdid, -updatedate, -emplcntweight),bdid);

return dis_ds_in_srt;

end;