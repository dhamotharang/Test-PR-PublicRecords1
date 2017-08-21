IMPORT Data_Services,doxie,ut,LN_PropertyV2_Fast,LN_PropertyV2,std;

EXPORT key_deed_zip_avg_sales_price(boolean isFast) := FUNCTION
keyPrefix := LN_PropertyV2_Fast.FileNames.fullKeyBuildPrefix;

// INPUTS

dDeedsI := 	if(isFast,LN_PropertyV2_Fast.CleanDeed(LN_PropertyV2.File_Deed,false) +
						LN_PropertyV2_Fast.CleanDeed(LN_PropertyV2_Fast.Files.base.deed_mortg,true),
								      LN_PropertyV2_Fast.CleanDeed(LN_PropertyV2.File_Deed,false));

dSearchI := if(isFast,LN_PropertyV2_Fast.CleanSearch(false) + LN_PropertyV2_Fast.CleanSearch(true),
							        LN_PropertyV2_Fast.CleanSearch(false));

Fares_NoOnwershipChangeDocTypes := ['T','N','U','L','R','X','J','F','S','D','CD','C','M','I','JH','M','T=','TR',''];
OKC_NoOnwershipChangeDocTypes   := ['VL','CR','RR','FC','AF','RA','CN','RL','SA','AA',''];

// Filter deed records which only represent an ownership change
dDeeds := dDeedsI(    (vendor_source_flag IN ['F','S'] and ut.CleanSpacesAndUpper(document_type_code) NOT IN Fares_NoOnwershipChangeDocTypes)
																						or (vendor_source_flag NOT IN ['F','S'] and ut.CleanSpacesAndUpper(document_type_code) NOT IN OKC_NoOnwershipChangeDocTypes));

dDeedsDist  := DISTRIBUTE(dDeeds,HASH32(ln_fares_id));
dSearchDist := DISTRIBUTE(dSearchI(ln_fares_id[2] = 'D' and source_code[2]	=	'P' and (INTEGER)zip != 0),
													HASH32(ln_fares_id));

rDeedSlim_Layout :=
RECORD
	dDeedsDist.ln_fares_id;
	dDeedsDist.sales_price;
	STRING8 best_date;
END;

dDeedSlim := PROJECT(dDeedsDist,
											TRANSFORM(rDeedSlim_Layout,
																SELF.best_date := IF((INTEGER)LEFT.recording_date != 0,LEFT.recording_date,LEFT.contract_date),
																SELF := LEFT));

rSearchSlim_Layout :=
RECORD
	dSearchDist.ln_fares_id;
	dSearchDist.source_code;
	dSearchDist.zip;
	dSearchDist.zip4;
END;

dSearchSlim := PROJECT(dSearchDist,rSearchSlim_Layout);

// Get cleaned zip code from the search file
rCleanZip_Layout :=
RECORD(rSearchSlim_Layout)
	rDeedSlim_Layout.sales_price;
	INTEGER year;
	INTEGER month;
END;

rCleanZip_Layout tAppendCleanZip(rDeedSlim_Layout le,rSearchSlim_Layout ri)	:=
TRANSFORM,SKIP((INTEGER)le.best_date = 0 or ((INTEGER)le.best_date[1..4] + 20 < (INTEGER)((STRING8)Std.Date.Today())[1..4])) //skip records with blank date or date less than 20 years
	SELF.year  := (INTEGER)le.best_date[1..4];
	SELF.month := (INTEGER)le.best_date[5..6];
	SELF       := le;
	SELF       := ri;
END;

dDeedAppendCleanZip := JOIN(dDeedSlim,
														dSearchSlim,
														LEFT.ln_fares_id = RIGHT.ln_fares_id,
														tAppendCleanZip(LEFT,RIGHT),
														KEEP(1),LOCAL);

// Filter out records which don't have either zip or sales price populated
dDeedAppendCleanZipFilter := dDeedAppendCleanZip(zip !=	'' and (INTEGER)sales_price != 0);

// Calculate average sales price by zip
rAvgSalesPriceByZip_Layout :=
RECORD
	dDeedAppendCleanZipFilter.zip;
	dDeedAppendCleanZipFilter.year;
	dDeedAppendCleanZipFilter.month;
	REAL avg_sales_price := ROUND(AVE(GROUP,(REAL)dDeedAppendCleanZipFilter.sales_price));
END;

dAvgSalesPriceByZip := TABLE(dDeedAppendCleanZipFilter,rAvgSalesPriceByZip_Layout,zip,year,month);

// Calculate average sales price by zip + zip4
rAvgSalesPriceByZip4_Layout :=
RECORD
	dDeedAppendCleanZipFilter.zip;
	dDeedAppendCleanZipFilter.zip4;
	dDeedAppendCleanZipFilter.year;
	dDeedAppendCleanZipFilter.month;
	REAL avg_sales_price := ROUND(AVE(GROUP,(REAL)dDeedAppendCleanZipFilter.sales_price));
END;

dAvgSalesPriceByZip4 := TABLE(dDeedAppendCleanZipFilter(zip4 != ''),rAvgSalesPriceByZip4_Layout,zip,zip4,year,month);

dAvgSalesPrice := dAvgSalesPriceByZip4 +
									PROJECT(dAvgSalesPriceByZip,TRANSFORM(rAvgSalesPriceByZip4_Layout,SELF.zip4 := '',SELF := LEFT));

dAvgSalesPriceSort := DEDUP(SORT(dAvgSalesPrice,zip,zip4,year,month),zip,zip4,year,month);

RETURN
INDEX(dAvgSalesPriceSort,
																					{STRING5 z5 := zip,STRING4 z4 := zip4},
																					{year,month,avg_sales_price},
																					Constants.keyServerPointer+'thor_Data400::key::'+keyPrefix+'::' + doxie.Version_SuperKey + '::deed::zip_avg_sales_price');
END;