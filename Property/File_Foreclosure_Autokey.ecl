IMPORT dops;
// file_in := Property.File_Foreclosure_Normalized(trim(deed_category)='U');
//FC_ids := ['058118BANKOFAMERICA', '058118ESCOBARCARLOSG', '1079290090820TRUCAPREOCORP', '1079290090820TRUCAPGRANTORTRUST2010-1'];
FC_ids(boolean isFCRA=false) := dops.SuppressID('foreclosure').GetIDsAsSet(isFCRA);
file_in := Property.File_Foreclosure_Normalized(TRIM(deed_category)IN Category_filter.Foreclosure AND TRIM(foreclosure_id, left, right) NOT IN FC_ids());

EXPORT File_Foreclosure_Autokey := DEDUP(PROJECT(file_in(site_prim_name<>'' AND site_zip<>'')
																								,TRANSFORM(Layout_Autokey, 
																								//Fields added for delta update project - DF-28049
																													SELF.record_sid				:= LEFT.record_sid;
																													SELF.global_sid				:= LEFT.global_sid;
																													SELF.dt_effective_first	:= 0;
																													SELF.dt_effective_last	:= 0;
																													SELF.delta_ind					:= 0;
																													SELF := LEFT))
																								,RECORD,ALL) : persist('~thor_data400::persist::file_foreclosure_Autokey');

