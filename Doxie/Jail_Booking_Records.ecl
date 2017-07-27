import JailBooking_Services, Appriss, suppress;

export Jail_Booking_Records (Dataset(doxie.layout_references) dids) := function
		key := Appriss.Key_did;
		bookingsIds := JOIN(DEDUP(SORT(dids,did),did),key,
						KEYED(LEFT.did = RIGHT.did),
						TRANSFORM(JailBooking_Services.Layouts.bookingId, self.booking_sid := RIGHT.booking_sid),
						LIMIT(JailBooking_Services.Constant.BOOKINGS_PER_DID, SKIP));					
						
		bookings := JailBooking_Services.Raw.getBookings(bookingsIds);
		      
		doxie.MAC_Header_Field_Declare();			
    suppress.mac_mask(bookings, bookingsMasked, ssn, dlNumber, true, true);  
		
		finalBookings := JailBooking_Services.Functions.xform_BaseBookingsIESP(bookingsMasked);		
		
		return SORT(finalBookings, 	-CaseFilingDate, CaseNumber);	
end;