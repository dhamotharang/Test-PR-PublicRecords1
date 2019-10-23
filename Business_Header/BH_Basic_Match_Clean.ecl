import gong,Gong_Neustar,mdr,address;
// Initialize match file

EXPORT BH_Basic_Match_Clean(

	 dataset(Layout_Business_Header_Temp)	pBH_Basic_Match_SALT			= BH_Basic_Match_SALT	()
	,dataset(Gong_Neustar.layout_History)	pGong_File_History				= Gong.File_History
	,string																pPersistname							= persistnames().BHBasicMatchClean													
	,boolean															pShouldRecalculatePersist	= true													
	,dataset(Layout_Business_Header_Temp)	pPersist									= persists().BHBasicMatchClean

) :=
function

f := pBH_Basic_Match_SALT;

///////////////////////////////////////////////////////////
// -- Remove gong records from the business header that changed listing type from 
// -- business or government to residential
///////////////////////////////////////////////////////////

////////////////////////////////////////////////
// -- take persist in, dedup on bdid and source
////////////////////////////////////////////////
layout_source := record
f.bdid;
f.source;
end;

bdid_source := table(f, layout_source);
bdid_source_dedup := dedup(bdid_source, all);

////////////////////////////////////////////////
// -- Filter for gong business, government
////////////////////////////////////////////////
bdid_with_gong := bdid_source_dedup(
												MDR.sourceTools.SourceIsGong_Business		(source)
										or 	MDR.sourceTools.SourceIsGong_Government	(source));

////////////////////////////////////////////////
// -- Filter for rest of records
////////////////////////////////////////////////
bdid_with_other_sources := bdid_source_dedup(
				not(		MDR.sourceTools.SourceIsGong_Business		(source)
						or 	MDR.sourceTools.SourceIsGong_Government	(source)
				 ));

////////////////////////////////////////////////
// -- Gong only BDIDs
////////////////////////////////////////////////
bdid_gong_only := join(bdid_with_other_sources,
                       bdid_with_gong,
					   left.bdid = right.bdid,
					   transform(layout_source, self := right),
					   right only,
					   hash);
				   
bdid_gong_only_dedup := dedup(bdid_gong_only, all);

//count(bdid_gong_only_dedup);

layout_phone :=
record
	layout_source;
	unsigned6	phone;
	string10	phone10;
	string120	company_name;
end;

Address.Mac_Is_Business(f,company_name,dwithnametype,dodedup := false);

// join gong only bdids back to BH gong records with phone, to get the ones
// that have a phone and look like a person 
bdid_phone := join(dwithnametype(		MDR.sourceTools.SourceIsGong_Business		(source)
										or 	MDR.sourceTools.SourceIsGong_Government	(source), phone <> 0),
                   bdid_gong_only_dedup,
			    left.bdid = right.bdid
				  and left.nameType in ['P','D']
                      and Datalib.CompanyClean(left.company_name)[41..120] = ''
					  ,
			    transform(layout_phone,
			              self.company_name := left.company_name;
			              self.phone := left.phone, self.phone10 := intformat(left.phone, 10, 1), self := right),
			    hash);
			    
bdid_phone_dedup := dedup(bdid_phone, all);

// Check Gong file for change in listing type from business to residential
// Use most recent type for phone

gf := pGong_File_History(publish_code IN ['P','U'], phone10 <> '');

layout_gong_slim := record
gf.phone10;
gf.listed_name;
gf.listing_type_bus;
gf.listing_type_res;
gf.listing_type_gov;
gf.dt_last_seen;
end;

gf_slim := table(gf, layout_gong_slim);
gf_slim_dist := distribute(gf_slim, hash(phone10));
gf_slim_sort := sort(gf_slim_dist, phone10, -dt_last_seen, -listing_type_res, local);
gf_slim_dedup := dedup(gf_slim_sort, phone10, local);

bdid_phone_remove_list := join(gf_slim_dedup(listing_type_bus = '', listing_type_res <> '', listing_type_gov = ''),
                               bdid_phone_dedup,
						 left.phone10 = right.phone10 and
						   left.listed_name = right.company_name,
						 transform(layout_phone, self := right),
						 hash);

bdid_phone_remove_list_dedup := dedup(bdid_phone_remove_list, all);


//count(bdid_phone_remove_list_dedup);

bdid_filtered_file := join(f,
                              bdid_phone_remove_list_dedup,
							left.bdid = right.bdid and
				            left.phone = right.phone and
							left.company_name = right.company_name and
							(		MDR.sourceTools.SourceIsGong_Business		(left.source)
							or 	MDR.sourceTools.SourceIsGong_Government	(left.source)) and
							left.phone <> 0,
           				transform(recordof(f), self := left),
				          hash,
						  left only);
					
///////////////////////////////////////////////////////////
// -- Remove gong records from the business header that changed listing type from 
// -- business or government to residential
///////////////////////////////////////////////////////////


BH_Basic_Match_Clean_persisted := bdid_filtered_file : 
					PERSIST(pPersistname);

returndataset := if(pShouldRecalculatePersist = true, BH_Basic_Match_Clean_persisted
																										, pPersist
									);
return returndataset;

end;