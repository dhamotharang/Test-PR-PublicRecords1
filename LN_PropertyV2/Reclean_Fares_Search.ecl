ds := LN_PropertyV2.Reclean_Concat;

ds_fares_filter 	:= ds(ln_fares_id[1] = 'R'); 

LN_PropertyV2.Layout_Fares_Search_in fares_trans(ds_fares_filter l):= transform
self.dt_first_seen 				:= (string)l.dt_first_seen;
self.dt_last_seen 				:= (string)l.dt_last_seen;
self.dt_vendor_first_reported 	:= (string)l.dt_vendor_first_reported;
self.dt_vendor_last_reported 	:= (string)l.dt_vendor_last_reported;
self.fares_id					:= l.ln_fares_id;
self._company					:= l.cname;
self.vendor						:= l.vendor_source_flag;
self.lf							:= '';
self := l;
end;

ds_fares 		:= project(ds_fares_filter, fares_trans(left));

ds_fares_out 	:= output(ds_fares,,'~thor_data400::in::ln_propertyv2::search_fares_reclean', __compressed__, overwrite);

export Reclean_Fares_Search := ds_fares_out;