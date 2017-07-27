
layout_payload_booking tRec(file_bookings_base L):= TRANSFORM
//self.booking_sid_fixed:= TRIM(L.booking_sid); // make it fixed length
self.booking_sid := TRIM(L.booking_sid);
self.HOME_PHONE  := IF((integer)regexfind('[0-9]*',stringlib.stringfilterout(l.home_phone,'()- '),0) =0,'',
                       regexfind('[0-9]*',stringlib.stringfilterout(l.home_phone,'()- '),0));
//If(length(stringlib.stringfilterout(l.home_phone,'()+- ')) < 10 ,'',stringlib.stringfilterout(l.home_phone,'()- '));
self.WORK_PHONE  := IF((integer)regexfind('[0-9]*',stringlib.stringfilterout(l.work_phone,'()- '),0) =0,'',
                       regexfind('[0-9]*',stringlib.stringfilterout(l.work_phone,'()- '),0));
//If(length(stringlib.stringfilterout(l.work_phone,'()+- ')) < 10 ,'',stringlib.stringfilterout(l.work_phone,'()- '));

self:=L; 
END;
ds_payload:=PROJECT(file_bookings_base(booking_sid <> '0'), tRec(LEFT));


export proc_generate_bookings_payload := 
OUTPUT(ds_payload,,'~thor_data400::temp::Appriss::bookings_payloadformat',OVERWRITE);