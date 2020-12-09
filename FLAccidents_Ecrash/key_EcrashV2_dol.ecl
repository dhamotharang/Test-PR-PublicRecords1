/*2015-11-16T20:52:51Z (Srilatha Katukuri)
#193680 - CR 323
*/
/*2015-08-07T18:13:16Z (Srilatha Katukuri)
#186387  - Dedup field changes
*/
/*2015-07-24T21:33:22Z (Srilatha Katukuri)
#173256 Rolled back dedup fields
*/
/*2015-04-15T19:12:04Z (Srilatha Katukuri)
# 173256- Check in
*/
/*2015-02-11T00:43:45Z (Ayeesha Kayttala)
bug# 173256 - code review 
*/
Import Data_Services, doxie;

export key_ecrashV2_dol := index(mod_PrepEcrashKeys().dep_base
                                 ,{accident_date,report_code,jurisdiction_state, jurisdiction}
                                 ,{mod_PrepEcrashKeys().dep_base}
							                   ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2_dol_' + doxie.Version_SuperKey);
								