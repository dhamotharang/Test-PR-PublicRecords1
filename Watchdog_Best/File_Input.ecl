import utilfile, header, gong_neustar;
u :=utilfile.DID_into_header(did>0) : Persist('~thor::watchdog_best::util');
qlfn := '~thor400_36::persist::qh_did_into_watchdog';
q := dataset(qlfn, header.Layout_Header, thor);
//u := dataset('~thor::watchdog_best::util', header.layout_header_v2, thor);


lfn := 'thor_data400::base::header_AID_reclean';
base1 := Dataset('~' + lfn, header.Layout_Header_v2, flat);
			header_  := project(base1, //(src != mdr.sourcetools.src_TU_CreditHeader),
			                   transform(header.layout_header, 
												 self.dt_vendor_first_reported := if(left.src = 'SL', 0,left.dt_vendor_first_reported),
		                     self.dt_vendor_last_reported  := if(left.src = 'SL', 0,left.dt_vendor_last_reported),
												 self := left));
h := base1 + u + q : Persist('~thor::watchdog_best::header_aid_reclean');

//h2 := watchdog_best.Fn_Reset_Tnt(h1);
	
//h := GetGongPhone(h2) : Persist('~thor::watchdog_best::addgongphones');

EXPORT File_Input := h;
