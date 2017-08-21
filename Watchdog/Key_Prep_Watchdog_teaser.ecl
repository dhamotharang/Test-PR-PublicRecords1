import header, ut, doxie, data_services, PRTE2_Header,PRTE2_Watchdog,PRTE2_Watchdog;

EXPORT Key_Prep_Watchdog_teaser (boolean exclude_EQ = true ) := FUNCTION

			wdog := if ( exclude_EQ	
															, pull(Watchdog.key_watchdog_nonglb_nonblank_V2)
															, pull(Watchdog.key_watchdog_nonglb_nonblank)
									);

			// should only contain alphas and allowable name punctuation, and optionally be tested for non-blank
			isValidStr(string str, boolean emptyOK = false) := (emptyOK or length(trim(str)) > 0) 
																											and str = stringlib.stringfilter(str, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ -');

			// need to allow for empty state values that come from death records,
			// but require populated name fields 
			wdog_clean := wdog(isValidStr(st, true) and isValidStr(lname) and isValidStr(fname));

			// pull all of the DIDs/SSNs that cannot be returned to the customer
			wdog_pull_ssn := join(wdog_clean(ssn<>''), doxie.File_pullSSN,  
														(string60)left.ssn = right.ssn, 
														transform(left), left only, lookup);

			wdog_pull_ssn_all := wdog_pull_ssn + wdog_clean(ssn='');

			wdog_pull_did := join(wdog_pull_ssn_all, doxie.File_pullSSN,  
														intformat((unsigned6)left.did,12,1) = right.ssn, 
														transform(left), left only, lookup);
															 
			wdog_dist := distribute(wdog_pull_did, hash(did));

			// need to filter out any ambiguous DIDs that get filtered from the header search keys
			hdr := distribute(dataset(data_services.Data_Location.Watchdog_Best +
																'thor400_84::out::watchdog_filtered_header_nonglb',header.layout_header,flat),hash(did));
			hdr_ambig := hdr(jflag2 in ['A','B','D','E']);

			newrec := RECORD
				wdog;
				string20 pfname := '';
			END;


			newrec xform(wdog_dist l, hdr_ambig r) := TRANSFORM
				// remove minors
				self.did := IF(l.dob = 0 or ut.GetAgeI(l.dob) >= 18, l.did, SKIP);
				self.pfname := datalib.preferredFirstNew(l.fname, true);
				self := l;
			END;
            #IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
            string_rec := record
					watchdog.Layout_Best;
					string1 		glb_name := 'Y';
					string1 		glb_address := 'Y';
					string1 		glb_dob := 'Y';
					string1 		glb_ssn := 'Y';
					string1 		glb_phone := 'Y';
					unsigned8 filepos := 0;
				end;
            wdog_filt0 := project(PRTE2_Watchdog.Files.file_best,{{PRTE2_Watchdog.files.file_best} OR string_rec});
            wdog_filt := project(wdog_filt0,{newrec});
            #ELSE
			wdog_filt := join(wdog_dist, hdr_ambig, left.did = right.did,
												xform(left, right), left only, local);
			#END
			non_eq := if(exclude_EQ,'_noneq','');
			return index(wdog_filt, {lname, st, pfname, fname, zip}, {wdog_filt},
																					'~thor_data400::key::watchdog_nonglb'+non_eq+'.teaser_'+ doxie.Version_SuperKey);
																					
end;