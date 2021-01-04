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
export key_ecrashV2_dol := index(mod_PrepEcrashKeys().dep_base
                                 ,{accident_date,report_code,jurisdiction_state, jurisdiction}
                                 ,{mod_PrepEcrashKeys().dep_base}
							                   ,Files_eCrash.FILE_KEY_DOL_SF);
								