#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Watchdog_best.BWR_Best');

qlfn := '~thor400_36::persist::qh_did_into_watchdog';
q := dataset(qlfn, header.Layout_Header, thor);


base1 := Header.File_Headers;
			header_  := project(base1, //(src != mdr.sourcetools.src_TU_CreditHeader),
			                   transform(header.layout_header, 
												 self.dt_vendor_first_reported := if(left.src = 'SL', 0,left.dt_vendor_first_reported),
		                     self.dt_vendor_last_reported  := if(left.src = 'SL', 0,left.dt_vendor_last_reported),
												 self := left));
h := base1 + q : Persist('~thor::watchdog_best::header_aid_reclean');

h2 := Watchdog_Best.proc_prep_input(h) : Persist('~thor::watchdog_best::prepped');

best := Watchdog_Best.proc_build_best(h2);

OUTPUT(best,,'~thor::watchdog_best::best_child', compressed, overwrite, named('bestby_child')); // Uses child datasets
