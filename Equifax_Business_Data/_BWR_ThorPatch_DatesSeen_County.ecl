IMPORT Equifax_Business_Data, data_services;

dBase := DATASET(data_services.foreign_prod +'thor_data400::base::equifax_business_data::qa::data', Equifax_Business_Data.Layouts.Base, THOR);

datesSeenAndCounty := Equifax_Business_Data.ThorPatch_DatesSeen_County.fAll(dBase);

OUTPUT(datesSeenAndCounty,,'~thor_data400::base::equifax_business_data::20181129::data_patched_two',overwrite,__compressed__,named('datesSeenAndCounty'));
// OUTPUT(datesSeenAndCounty,,'~thor_data400::base::equifax_business_data::20181129::test',overwrite,__compressed__,named('datesSeenAndCounty'));

// OUTPUT(datesSeenAndCounty,,named('datesSeenAndCounty'));

OUTPUT(DEDUP(SORT(datesSeenAndCounty(EFX_COUNTYNM = 'INVALID' OR EFX_COUNTY = 'INVALID')
       ,EFX_STATE,EFX_COUNTYNM,EFX_COUNTY)
			 ,EFX_STATE,EFX_COUNTYNM,EFX_COUNTY),,named('invalidReallyCountyNames'));
			 
OUTPUT(DEDUP(SORT(datesSeenAndCounty(STD.STR.FilterOut(EFX_COUNTYNM, '0123456789') = '' AND EFX_COUNTYNM != '')
       ,EFX_STATE,EFX_COUNTYNM,EFX_COUNTY)
			 ,EFX_STATE,EFX_COUNTYNM,EFX_COUNTY),,named('invalidCountyNames'));
			 
OUTPUT(CHOOSEN(DEDUP(SORT(datesSeenAndCounty(EFX_COUNTY = '')
       ,EFX_STATE,EFX_COUNTYNM,EFX_COUNTY)
			 ,EFX_STATE,EFX_COUNTYNM,EFX_COUNTY),1000),,named('nullCountyNumber'));
			 
OUTPUT(CHOOSEN(DEDUP(SORT(datesSeenAndCounty(STD.STR.FilterOut(EFX_COUNTY, '0123456789') != '')
       ,EFX_STATE,EFX_COUNTYNM,EFX_COUNTY)
			 ,EFX_STATE,EFX_COUNTYNM,EFX_COUNTY),1000),,named('invalidCountyNumbers'));		
			 
OUTPUT(CHOOSEN(DEDUP(SORT(datesSeenAndCounty(EFX_COUNTYNM = '')
       ,EFX_STATE,EFX_COUNTYNM,EFX_COUNTY)
			 ,EFX_STATE,EFX_COUNTYNM,EFX_COUNTY),1000),,named('invalidCountyName'));