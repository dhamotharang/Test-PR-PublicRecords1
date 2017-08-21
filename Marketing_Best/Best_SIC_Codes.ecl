export Best_SIC_Codes(

	 dataset(marketing_Best.Layout_Common	) pDataset
	,dataset(Layouts.SIC_Code_Lookup			) pSicLookup = File_SIC_Code_Lookup

) :=
function

srt_sic_lookup := sort(pSicLookup,sic_code);

Layout_Common findBestSic(Layout_common l, pSicLookup r):= transform
	self := l;
end;

out_ds := join(pDataset, pSicLookup,
			 trim(left.sic,left,right) = trim(right.sic_code,left,right),
			 findBestSic(left,right),
			 lookup);

// dis_out_ds := distribute(out_ds, hash32(bdid));
srt_out_ds := dedup(sort(out_ds, bdid, -updateDate,-sicWeight),bdid);

return srt_out_ds;
end;