import Appriss;

DApprissFiles := distribute(Appriss.file_bookings_base,hash(trim(booking_sid)));
slim_rec :=record 
  string2 rtype := 'JB';
  DApprissFiles.BOOKING_SID; 
	DApprissFiles.agencyKey;
	DApprissFiles.maxQueueSid;	
	DApprissFiles.state_cd; 
//  string30  filename := trim(DApprissFiles.BOOKING_SID,all)+'.jpg'; 
	DApprissFiles.did;
end;

d_File_Image_link := table(DApprissFiles, slim_rec,local) : persist('~Appriss_images::Persist::appriss_Image_link');

export File_Image_link := d_File_Image_link;

