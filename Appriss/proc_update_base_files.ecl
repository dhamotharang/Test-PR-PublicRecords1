import ut;

#option('skipFileFormatCrcCheck', 1);

basename:=cluster_name+'::base::Appriss_';	

bookings_base := appriss.file_bookings_base;
Layout_Base_Bookings add_load_date(file_bookings_prepa l ) := transform
  self.load_date := ut.getdate;
  self := L;
end;

bookings_updates :=  PROJECT(appriss.file_bookings_prepa,add_load_date(left));
bookings := bookings_base+ bookings_updates;

charges_base := appriss.file_charges_base;
charges_updates := PROJECT(appriss.file_charges_prepa,Layout_Base_Charges);
charges := charges_base+charges_updates;

deletes := appriss.file_agency_delete_prepa;
//as per Andy from appriss the primarykey is unique. we need to 

//bookings_d := distribute(bookings,hash(primarykey,agencykey));

//as per bob this was the logic. It has been changed to handle changes to the agency_key value for a booking
//bookings_s := SORT(bookings_d,primarykey,agencykey,(integer)maxqueuesid,local); //sort it first

bookings_d := distribute(bookings,hash(primarykey));
//as per Andy use the new booking record in prepa irrespective of the change in agency.
bookings_s := SORT(bookings_d,primarykey,load_date,(integer)maxqueuesid,local); //sort it first

//------------------------------------------------------------------------------------------------------------
//Apply the updates/deletes in the prepb files

bookings ApplyUpdates(bookings_s L,bookings_s R) := TRANSFORM
 
 self.creation_ts    := appriss.fnDateTime(stringlib.stringfindreplace(trim(R.creation_ts),'*',''));
 self.last_change_ts := appriss.fnDateTime(stringlib.stringfindreplace(trim(R.last_change_ts),'*',''));

 SELF := R; 
END;

latestBookings := ROLLUP(bookings_s,
                  LEFT.primarykey=RIGHT.primarykey, // and LEFT.agencykey = RIGHT.agencykey,
                  ApplyUpdates(LEFT,RIGHT),local);// : persist ('persist::vani::appriss_latest_booking');
									
//------------------------------------------------------------------------------------------------------------
//Apply the deletes from the agency delete file

latestBookings handledeletes (latestBookings l ,deletes r) := transform 
								
																	
 self := l;
end;

CurrentBookings := IF( fn_exist_agencyDeletes(),
                       join(latestBookings(stringlib.StringToUpperCase(action) not in ['DELETE']),deletes,
											                     left.agencykey = right.agencykey and 
                                           left.agency_ori = right.agencyori ,
																					 handledeletes(left,right),left only, lookup),
											 latestBookings(stringlib.StringToUpperCase(action) not in ['DELETE'])) : persist ('persist::appriss::appriss_current_booking');
																							 
//------------------------------------------------------------------------------------------------------------
//Get the Current charges 

charges_d := distribute(charges,hash(booking_sid));
Layout_Base_Charges ExtractLatestCharge (charges_d l ,CurrentBookings r) := transform 
 self.creation_ts    := appriss.fnDateTime(stringlib.stringfindreplace(trim(L.creation_ts),'*',''));
 self.last_change_ts := appriss.fnDateTime(stringlib.stringfindreplace(trim(L.last_change_ts),'*',''));
 self.disposition_dt := appriss.fnDateTime(stringlib.stringfindreplace(trim(L.disposition_dt),'*',''));
 self := l;
end;	

Currentcharges := join(charges_d,CurrentBookings,left.booking_sid = right.primarykey and 
                                                 left.agencykey   = right.agencykey and 
                                                 left.maxqueuesid = right.maxqueuesid,
																							   ExtractLatestCharge(left,right),local);// : persist ('persist::vani::appriss_current_booking_charges');



ds_priors    := Currentcharges(regexfind('PRIOR', StringLib.StringToUpperCase(description),0)<>'');
ds_no_priors := Currentcharges(regexfind('PRIOR', StringLib.StringToUpperCase(description),0)='');

ds_sort_noprior  := sort(ds_no_priors, record ,except charge_seq,local);
ds_dedup_noprior := dedup(ds_sort_noprior, record, except description,charge_seq ,local);

ds_sort_wprior   := sort(ds_priors,    record ,except charge_seq,local);
ds_dedup_wprior	 := dedup(ds_sort_wprior, record ,except charge_seq,local );

ds_allcharges := ds_dedup_noprior + ds_dedup_wprior;

//changes basefile name before moving to prod. 
//
//

ut.MAC_SF_BuildProcess(CurrentBookings,basename+'bookings',outbookings,3);
ut.MAC_SF_BuildProcess(ds_allcharges ,basename+'charges',outcharges,3);
//filedate := ut.GetDate; 
//Out_File_Booking_stats_Population(CurrentBookings,Currentcharges,filedate,strata_output);

export proc_update_base_files := Sequential(outbookings,
                                            outcharges//,
																						//strata_output
																						);
//---------------------------------------------------------------------------------------------------------------
																				
//old base + append updates -deletes, sequencing??? => new_base
