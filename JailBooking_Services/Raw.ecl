import Appriss, doxie, AutoStandardI;

#warning('Attribute deprecated as of 09/26/2012.')
export Raw := MODULE

	EXPORT getBookingsByDID(DATASET(doxie.layout_references) aDids) := FUNCTION
		key := Appriss.Key_did;
		vks := JOIN(DEDUP(SORT(aDids,did),did),key,
						KEYED(LEFT.did = RIGHT.did),
						TRANSFORM(Layouts.bookingId, self.booking_sid := RIGHT.booking_sid),
						LIMIT(Constant.BOOKINGS_PER_DID, fail(203, doxie.ErrorCodes(203))));									
		
		return vks;
	END;
	
	EXPORT getBookingsByDL(DATASET(Layouts.DLNumber) aDls) := FUNCTION
		key := Appriss.Key_DL;
		
		vks := JOIN(DEDUP(SORT(aDls,dlnumber),dlnumber),key,
		        KEYED(LEFT.dlnumber = RIGHT.dlnumber),						
						TRANSFORM(Layouts.bookingId, self.booking_sid := RIGHT.booking_sid),
						LIMIT(Constant.BOOKINGS_PER_DL_NUMBER,fail(203, doxie.ErrorCodes(203))));
		
		RETURN vks;
	END;
	
	EXPORT getBookingsByStateID(DATASET(Layouts.stateID) aStateIds) := FUNCTION
		key := Appriss.Key_state_id;
		
		vks := JOIN(DEDUP(SORT(aStateIds,STATE_ID),STATE_ID),key,
		        KEYED(LEFT.STATE_ID = RIGHT.STATE_ID),						
						TRANSFORM(Layouts.bookingId, self.booking_sid := RIGHT.booking_sid),
						LIMIT(Constant.BOOKINGS_PER_STATE_ID,fail(203, doxie.ErrorCodes(203))));
		RETURN vks;
	END;
	
	EXPORT getBookingsByFBINumber(DATASET(Layouts.FBINumber) aFBINumbers) := FUNCTION
		Key:= Appriss.Key_FBI;
		vks := JOIN(DEDUP(SORT(aFBINumbers,FBI_NBR),FBI_NBR),key,
		        KEYED(LEFT.FBI_NBR = RIGHT.FBI_NBR),						
						TRANSFORM(Layouts.bookingId, self.booking_sid := RIGHT.booking_sid),
						LIMIT(Constant.BOOKINGS_PER_FBI_NBR,fail(203, doxie.ErrorCodes(203))));
		RETURN vks;
	END;
	
	EXPORT getBookingsByGangName(String aGangName) := FUNCTION
		key := Appriss.Key_Gang;
			res := LIMIT(Appriss.Key_Gang (gang = aGangName), 
												 Constant.BOOKINGS_PER_GANG, 												 
												 fail(203, doxie.ErrorCodes(203)), 
													KEYED);
										
		ids := project(res, TRANSFORM(Layouts.bookingId, self.booking_sid := left.booking_sid));
		RETURN ids;
	END;
	
	EXPORT getBookingsByAgency(DATASET(Layouts.Agency) aAgency) := FUNCTION
			key := Appriss.Key_AgencyOri_StateCd;
			res := JOIN(aAgency, Appriss.Key_AgencyOri_StateCd, 
				KEYED(RIGHT.agency_ori = LEFT.agency_ori) and 
				KEYED(RIGHT.state_cd = LEFT.state_cd), 
					TRANSFORM(Layouts.bookingId, self.booking_sid := RIGHT.booking_sid), 
					LIMIT(Constant.BOOKINGS_PER_AGENCY, fail(203, doxie.ErrorCodes(203))));
					
			return res;
	END;
	
	EXPORT getBookingsByPhysicalAttr(DATASET(Layouts.attributes) aAttributes) := FUNCTION
		unsigned8 today := (unsigned8)Stringlib.getDateYYYYMMDD();	
		unsigned8 yearLow := aAttributes[1].yearLow;
		unsigned8 yearHigh := aAttributes[1].yearHigh;
	   		 
		unsigned8 dobLow := (yearLow * 10000) + (today % 10000);
		unsigned8 dobHigh := (yearHigh * 10000) + (today % 10000);
		
		res := JOIN(aAttributes, Appriss.Key_demographic, 
				KEYED(RIGHT.Key_gender = LEFT.key_gender) and
				KEYED(RIGHT.key_race = LEFT.KEY_race) and 
				KEYED(RIGHT.date_of_birth between dobLow and dobHigh) and 
				KEYED(RIGHT.key_hgt between LEFT.heightLow and LEFT.heightHigh ) and 
				keyed(RIGHT.key_wgt between LEFT.weightLow and LEFT.weightHigh) ,
				TRANSFORM(Layouts.bookingId, self.booking_sid := RIGHT.booking_sid), 
				LIMIT(Constant.BOOKINGS_PER_DEMOGRAPHICS, fail(203, doxie.ErrorCodes(203))));		
	  RETURN res;
	END;
	
	EXPORT getBookings(DATASET(Layouts.bookingId) aBookingIds):= FUNCTION	

    logRec0 := JOIN(aBookingIds, Appriss.Key_Booking,
                         KEYED(LEFT.booking_sid = RIGHT.booking_sid),                          
                         TRANSFORM(Layouts.mainBooking,													
													SELF.record_penalty := 0, 
													SELF.isDeepDive := LEFT.isDeepDive,
													SELF := RIGHT,
													self.charges := []),
												KEEP(1),
                        LIMIT(0));

		RETURN logRec0;
	END;	
	
	EXPORT getCharges(DATASET(Layouts.bookingId) aBookingIds) := FUNCTION
		charges := JOIN(aBookingIds, Appriss.key_charges,
				Keyed(LEFT.booking_sid = RIGHT.booking_sid), 
				TRANSFORM(Layouts.bookingCharges,
						SELF := RIGHT	),
					KEEP(Constant.MAX_CHARGES_KEEP), LIMIT(0));
		RETURN charges;
	END;
	
	EXPORT getBookingsReport(DATASET(Layouts.bookingId) aBookingIds):= FUNCTION	
		bookings := getBookings(aBookingIds);
		charges := getCharges(aBookingIds);
				
		sortedBookings := SORT(bookings, booking_sid);
		sortedCharges := SORT(charges, booking_sid, -charge_dt, charge_seq);
		
		// merge charges
		Layouts.mainBooking assingBookingCharges(Layouts.mainBooking L, dataset(Layouts.bookingCharges) R) := TRANSFORM			
		
		SELF.charges := SORT(choosen(R, Constant.MAX_CHARGES_PER_BOOKING), -charge_dt, charge_seq);
			SELF := L;			
		END;
		
		bookRec01 := DENORMALIZE(sortedBookings, sortedCharges, 
					LEFT.booking_sid = RIGHT.booking_sid and 
					LEFT.agencykey = RIGHT.agencykey, 
					group, 
					assingBookingCharges(LEFT, ROWS(RIGHT)));
								
		RETURN bookRec01;		
	END;
	
END;