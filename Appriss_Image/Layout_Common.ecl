export Layout_Common := RECORD
	unsigned6 did := 0;
	string2   state;
	string2   rtype;
	string15  Booking_sid; 
	string15  agencyKey;
	string30  maxQueueSid;	
	unsigned2 seq;
	string8   date;
	unsigned2 num;
	string25 image_link;
	UNSIGNED4 imgLength;
	JPEG(SELF.imgLength) photo {maxlength (MaxLength_FullImage)};
END;