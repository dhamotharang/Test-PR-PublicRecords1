Import Doxie, iesp;

EXPORT ReportRecords:= MODULE
	EXPORT formatRawRecords(dataset(JailBooking_Services.Layouts.mainBooking) BookingRecords, 
												IParam.reportParams aInputData):= FUNCTION
	  rawBookingRecords    := JailBooking_Services.Functions.apply_restrictions(BookingRecords, aInputData);
	  bookings             := Functions.xform_BookingsIESP_Report(rawBookingRecords);
	  result               := CHOOSEN(SORT(bookings, -CaseFilingDate, CaseNumber), 
			                    iesp.Constants.JB.MAX_REPORT_RECORDS);
	  return result;		
  END;
	EXPORT val(IParam.reportParams aInputData) := FUNCTION
		didValue := aInputData.didValue;
		didNum := dataset([{didValue}], doxie.layout_references);
		byDidNum := if (didValue <> '', Raw.getBookingsByDID(didNum));
		bookingValue := aInputData.bookingId;
		byBookingNum := dataset([{bookingValue}], Layouts.bookingId);
		keys := DEDUP(SORT(byBookingNum + byDidNum, booking_sid), booking_sid);
		bookRec1 := Raw.getBookingsReport(keys);				
		finalBooking:= formatrawRecords(bookRec1,aInputData);
		return finalBooking;	
	END;
END;	