Import ut, tools; 

EXPORT Build_Base_SuspectIP(
                             string pversion
                             ,dataset(Layouts.Base.SuspectIP) inBaseSuspectIP = Files().Base.SuspectIP.QA
                             ,dataset(Layouts.Input.SuspectIP) inSuspectIPUpdate = Files().Input.SuspectIP.Sprayed, 
                             boolean UpdateSuspectIP = FraudDefenseNetwork._Flags.Update.SuspectIP
                           ) := module

     FraudDefenseNetwork.Functions.CleanFields(inSuspectIPUpdate, inSuspectIPUpdateUpper);

     FraudDefenseNetwork.Layouts.Base.SuspectIP tPrep(Layouts.Input.SuspectIP pInput) :=
             transform
                self.process_date := (unsigned) pversion,
                self.Unique_Id := 0;
                self.global_sid := 0;
                self.record_sid := 0;
                self.Source := 'SUSPECTIPADDRESS';
                reported_date_yyyy := pInput.orig_date[1..4];
                reported_date_mm := pInput.orig_date[6..7];
                reported_date_dd := pInput.orig_date[9..10];
                reported_date := reported_date_yyyy + reported_date_mm + reported_date_dd;
                self.reported_date := reported_date;
                self.reported_time := pInput.orig_date[12..];
                self.dt_first_seen := (unsigned)reported_date;
                self.dt_last_seen := (unsigned)reported_date;
                self.dt_vendor_last_reported := (unsigned) pversion; 
                self.dt_vendor_first_reported := (unsigned) pversion;
                self.current := 'C';
                self := pInput;
                self := [];
             end;

     SuspectIPValidate := dedup(inSuspectIPUpdateUpper(orig_ip <>'' and (length(trim(orig_ip, left, right)) between 7 and 15)), all);
     SuspectIPUpdate := project(SuspectIPValidate, tPrep(left));

     pDataset_Dist := distribute(SuspectIPUpdate, hash32(orig_ip));
     pBase_Dist := distribute(inBaseSuspectIP, hash32(orig_ip));

     FraudDefenseNetwork.Layouts.Base.SuspectIP getSrcRid (pDataset_Dist l, pBase_dist r) := 
             transform
                self.dt_first_seen := ut.EarliestDate(l.dt_first_seen, r.dt_first_seen);
                self.dt_last_seen := max(l.dt_last_seen, r.dt_last_seen);
                SELF.dt_vendor_last_reported := max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
                SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
                SELF.source_rec_id := r.source_rec_id;
                self.current := if(l.current = 'C' or r.current = 'C', 'C', 'H');
                self := l;
             end;

   //*** this join assigns the Src_rids for the older records.
     dBase_with_rids := join(
                              pDataset_Dist, pBase_dist,
                              left.orig_date = right.orig_date and
                              left.orig_ip = right.orig_ip and
                              left.orig_country = right.orig_country and
                              left.orig_state = right.orig_state and
                              left.orig_city = right.orig_city and
                              left.orig_isp = right.orig_isp,
                              getSrcRid (left, right),
                              left outer,
                              keep(1),
                       local);
				
     ut.MAC_Append_Rcid (dBase_with_rids, source_rec_id, pDataset_rollup);
     
     dBase_RecordID := Project(pDataset_rollup, transform(recordof(pDataset_rollup),
                                                          RecordID := Constants().SuspectIPRecIDSeries + left.source_rec_id;
                                                          self.record_sid := RecordID;
                                                          self := left;
                                                          )); 
     
     tools.mac_WriteFile(Filenames(pversion).Base.SuspectIP.New, dBase_RecordID, Build_Base_File);
 
   //Return
     export full_build := sequential (
                                       Build_Base_File, Promote(pversion).buildfiles.New2Built
                                     );

     export All := if (
                        tools.fun_IsValidVersion(pversion), full_build ,output('No Valid version parameter passed, skipping Build_Base_SuspectIP atribute')
                      );

end;



