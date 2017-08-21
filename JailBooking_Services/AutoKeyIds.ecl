IMPORT AutoKeyI, AutoKeyB2, Appriss, doxie;

EXPORT AutoKeyIds(IParam.searchParams input) := FUNCTION

			// SEARCH THE AUTOKEYS
		str_autokeyname := Appriss.ak_qa_keyname;		
		typestr := Appriss.ak_typeStr;
		ds := dataset([],Layouts.Payload);
					
		tempmod := module(project(input,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
			export string autokey_keyname_root := str_autokeyname;
			export string typestr := ^.typestr;
			export set of string1 get_skip_set := Appriss.ak_skipSet;
			export boolean useAllLookups := true;
			export boolean workHard := true;
		end;
	
		ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;

		// fetch payload to get booking_sid
		AutokeyB2.mac_get_payload(ids,str_autokeyname,ds,outPLfat, did, did);
						
		hasdid	:= outPLfat((unsigned6) did > 0 and ~AutokeyB2.ISFakeID((unsigned6) did, typestr));
				
		newdids	:= join(
			hasdid, ids(isdid),
			left.id = right.id,
			transform(doxie.layout_references, 
									self.did := left.did),
									limit(JailBooking_Services.Constant.MAX_RECS_ON_JOIN,skip));
		
		temp_ids := Raw.getBookingsByDID(newdids);
		
		 // project here into layout search setting deep dive to true
		ID_ids := project(temp_ids, 
					transform(Layouts.bookingId,
										self.isDeepDive := true, 
										self:=left));
		
		// return booking records based on booking_sids
		recIds := PROJECT(outPLfat, TRANSFORM (Layouts.bookingId, 					
						self.booking_sid := left.booking_sid))	;	
		
		dups := recIds + if(input.isDeepDive, id_ids);
		results := dedup(sort(dups, booking_sid), booking_sid);
	RETURN results;
	
END;