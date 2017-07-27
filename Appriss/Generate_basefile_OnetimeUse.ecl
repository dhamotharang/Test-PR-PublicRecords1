import ut;

#option('skipFileFormatCrcCheck', 1);

basename:=cluster_name+'::base::Appriss_';	

file_bookings_base_old := DATASET(cluster_name+'::base::appriss_bookings',layout_prep_booking_rec,flat);
bookings_updates       := appriss.file_bookings_prepb;
bookings               := PROJECT(file_bookings_base_old+ bookings_updates,Layout_Base_Bookings);

charges_base_old  := DATASET(cluster_name+'::base::appriss_charges',layout_prep_charges_rec,flat);
charges_updates   := appriss.file_charges_prepb;
charges           := charges_base_old+charges_updates;

deletes    := appriss.file_agency_delete_prepb;

bookings_d := distribute(bookings,hash(primarykey,agencykey));
bookings_s := SORT(bookings_d,primarykey,agencykey,(integer)maxqueuesid,local); //sort it first

//------------------------------------------------------------------------------------------------------------
//Apply the updates/deletes in the prepb files

bookings ApplyUpdates(bookings_s L,bookings_s R) := TRANSFORM

 self.creation_ts    := appriss.fnDateTime(stringlib.stringfindreplace(trim(R.creation_ts),'*',''));
 self.last_change_ts := appriss.fnDateTime(stringlib.stringfindreplace(trim(R.last_change_ts),'*',''));
 SELF := R; 
END;

latestBookings := ROLLUP(bookings_s,
                  LEFT.primarykey=RIGHT.primarykey and LEFT.agencykey = RIGHT.agencykey,
                  ApplyUpdates(LEFT,RIGHT),local);// : persist ('persist::vani::appriss_latest_booking');
									
//------------------------------------------------------------------------------------------------------------
//Apply the deletes from the agency delete file

latestBookings handledeletes (latestBookings l ,deletes r) := transform 
 self := l;
end;

CurrentBookings := join(latestBookings(stringlib.StringToUpperCase(action) not in ['DELETE']),deletes,left.agencykey = right.agencykey and 
                                               left.agency_ori = right.agencyori ,
																							 handledeletes(left,right),left only, lookup)  : persist ('persist::appriss::appriss_current_booking');
																							 
//------------------------------------------------------------------------------------------------------------
//Get the Current charges 

charges_d := distribute(charges,hash(booking_sid,agencykey));
Layout_Base_Charges ExtractLatestCharge (charges_d l ,CurrentBookings r) := transform 

 self.creation_ts    := appriss.fnDateTime(stringlib.stringfindreplace(trim(L.creation_ts),'*',''));
 self.last_change_ts := appriss.fnDateTime(stringlib.stringfindreplace(trim(L.last_change_ts),'*',''));
 self.disposition_dt := appriss.fnDateTime(stringlib.stringfindreplace(trim(L.disposition_dt),'*',''));

 self := l;
end;	

Currentcharges := join(charges_d,CurrentBookings,left.booking_sid = right.primarykey and 
                                                 left.agencykey   = right.agencykey and 
                                                 left.maxqueuesid = right.maxqueuesid,
																							   ExtractLatestCharge(left,right),local) ;//: persist ('persist::vani::appriss_current_booking_charges');
//changes basefile name before moving to prod. 

ut.MAC_SF_BuildProcess(CurrentBookings,basename+'bookings',outbookings,3);
ut.MAC_SF_BuildProcess(Currentcharges ,basename+'charges',outcharges,3);

export Generate_basefile_OnetimeUse := Sequential(outbookings, outcharges
                                                  );
//---------------------------------------------------------------------------------------------------------------																				
//old base + append updates -deletes, sequencing??? => new_base
