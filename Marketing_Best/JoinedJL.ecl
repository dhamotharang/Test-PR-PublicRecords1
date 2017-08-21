import Liensv2,ut,Std;

Layout_In := record
	string lien_desc;
end;

export JoinedJL(

	 dataset(liensv2.Layout_liens_main_module.layout_liens_main	) pfile_liens_main				= LiensV2.file_liens_main
	,dataset(Layout_In																					) pFile_Lien_Type_Lookup	= File_Lien_Type_Lookup
	,dataset(LiensV2.Layout_liens_party_ssn_BIPV2						  	) pfile_liens_party 			= LiensV2.file_Liens_party_BIPV2

) := 
function

// Need to exclude all recs associated with a tax lien filed in error
// extract only those records that have a filed in error status.
OnlyErrors := distribute(pfile_liens_main(trim(filing_type_desc,left,right)='FILED IN ERROR-COUNTY TAX LIEN' or 
									  trim(filing_type_desc,left,right)='FILED IN ERROR-FED TAX LIEN' or 
									  trim(filing_type_desc,left,right)='FILED IN ERROR-ST TAX LIEN'),hash(tmsid));


// Extract those records that have a valid amount & are within the last three years
ds_main := distribute(pfile_liens_main(trim(amount,left,right) <>'' and 
									trim(amount,left,right) <> '0' and 
									ut.DaysApart((STRING8)Std.Date.Today(), filing_date) < 1096),hash(tmsid));


// Do a join to exclude those tmsids that are in the OnlyErrors file.									
OnlyGoodRecs := join(ds_main, OnlyErrors,
				//trim(left.filing_jurisdiction,left,right) = trim(right.filing_jurisdiction,left,right) and
				trim(left.tmsid,left,right) = trim(right.tmsid,left,right),left only,local);
				

// now that we have a list of good main records, filter out only those that are liens
ds_lien_lookup := pFile_Lien_Type_Lookup;

LiensV2.Layout_liens_main_module.layout_liens_main foundLienRecord(LiensV2.Layout_liens_main_module.layout_liens_main l, ds_lien_lookup r):= transform
	self := l;
end;

Liens_only := join(OnlyGoodRecs, ds_lien_lookup,
				trim(left.filing_type_desc,left,right) = trim(right.lien_desc,left,right),
				foundLienRecord(left,right),
				lookup);
				
				
// distribute the files for performance.
ds_main_final := dedup(sort(Liens_only,TMSID,Amount,filing_date,local),tmsid,local);

ds_party_dist := distribute(pfile_liens_party(trim(bdid,left,right) <>'000000000000' and 
														  trim(bdid,left,right) <>'' and 
														  trim(bdid,left,right) <>'0'),hash(tmsid));


// Now join the main file with the party files, extracting bdids from the party file.

Marketing_Best.Layouts.Joined_JL joinMainWithParty(ds_main_final l, ds_party_dist r) := transform
	self.bdid := r.bdid;
	self := l;
end;


JoinedFile := join(ds_main_final,ds_party_dist, left.tmsid = right.tmsid, joinMainWithParty(left,right),local);

return dedup(JoinedFile,bdid,hash);

end;
				