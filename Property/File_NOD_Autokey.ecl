// Suppressing 4 Foreclosure IDs as part of dispute database Bug#: 60282 and bugzilla bug#: 170863
//FC_ids := ['058118BANKOFAMERICA', '058118ESCOBARCARLOSG', '1079290090820TRUCAPREOCORP', '1079290090820TRUCAPGRANTORTRUST2010-1','14944559950000SOUTHERNBK&TRUST', '14944559950000RABIMIKE'];
file_in := Property.File_Foreclosure_Normalized(TRIM(deed_category)IN Category_filter.NOD AND TRIM(foreclosure_id, left, right) NOT IN Suppress_FID);

EXPORT File_NOD_Autokey := DEDUP(PROJECT(file_in(site_prim_name<>'' AND site_zip<>'')
																				,TRANSFORM(Layout_Autokey, 
																				//Fields added for delta update project - DF-28049
																								SELF.record_sid				:= LEFT.record_sid;
																								SELF.global_sid				:= LEFT.global_sid;
																								SELF.dt_effective_first	:= 0;
																								SELF.dt_effective_last	:= 0;
																								SELF.delta_ind					:= 0;
																								SELF := LEFT))
																				,RECORD,ALL) : persist('~thor_data400::persist::file_nod_Autokey');

