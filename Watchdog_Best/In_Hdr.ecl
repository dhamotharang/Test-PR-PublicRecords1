import header,data_services,mdr,nid,address;
//EXPORT In_Hdr := dataset(header.Filename_Header, Watchdog_Best.Layout_Hdr, flat);
												 
												 
base := $.File_Input;
//src := header_(lname='SALVO',st='FL');
h1 := base(did < 100000000);

cleaned := $.fn_CleanNames(h1) : persist('~thor::watchdog_best::cln_names');

h2 := $.Fn_Reset_Tnt(cleaned);
	
//samp := DEDUP(SORT(DISTRIBUTE(src,did), did, local), did, local);
//hdr := DISTRIBUTE(header_,did);
//h1 := JOIN(hdr, samp, left.did=right.did, TRANSFORM(header.Layout_Header_v2, self := left;), INNER, LOCAL);
h3 := $.fn_GetGongPhone(h2);
//unclean := h3(nid=0);
//			cln := Watchdog_Best.fn_CleanNames(unclean);
			
//			h := cln + h3(nid<>0);


h4 := PROJECT(h3, TRANSFORM($.Layout_Hdr,
				self.dt_first_seen := left.dt_first_seen;
				self.dt_last_seen := left.dt_last_seen;
				self.dt_vendor_first_reported := left.dt_vendor_first_reported;
				self.dt_vendor_last_reported := left.dt_vendor_last_reported;
				self.dt_nonglb_last_seen := left.dt_nonglb_last_seen;
				self := left));
h := $.fn_get_best_address(h4) : persist('~thor::watchdog_best::in_hdr');
				
EXPORT In_Hdr := 	h;
					//DATASET('~thor::watchdog_best::in_hdr', Watchdog_Best.Layout_Hdr, thor);

