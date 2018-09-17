IMPORT Phones, STD, UT, iesp;

EXPORT PhoneMetaDataRecords(DATASET(Phones.Layouts.PhoneAttributes.BatchIn)   dBatchPhonesIn,
	                                   Phones.IParam.PhoneAttributes.ReportParams in_mod) 
:= FUNCTION 

    batch_mod := MODULE(PROJECT(in_mod, Phones.IParam.PhoneAttributes.BatchParams, opt))
    END;
 
    dRecs := Phones.PhoneAttributes_BatchRecords(dBatchPhonesIn, batch_mod);
      
     iesp.phonemetadatasearch.t_PhoneMetaDataSearchRecord tFormat2PhoneMetadata(Phones.Layouts.PhoneAttributes.BatchOut l) :=		TRANSFORM
      SELF.PhoneNumber := l.phoneno;
   	  SELF.isCurrent := l.is_current; 
   		 SELF.CarrierInfo.id := l.carrier_id;
   		 SELF.CarrierInfo.Name := l.carrier_name;
   		 SELF.CarrierInfo.Category := l.carrier_category;
   		 SELF.CarrierInfo.City := l.carrier_city;
   		 SELF.CarrierInfo.State := l.carrier_state;
   		 SELF.EventInfo.Date := iesp.ECL2ESP.toDate(l.event_date); 
     //Some rare cases where we have the same phoneno and event_date, but event_type is C in one and CL in the other
	    //I doubt we would have any other event_type cases with the same phoneno and event_date
   		 SELF.EventInfo._Type := l.event_type; 
   		 SELF.Operator.id := l.operator_id;
   		 SELF.Operator.Name := l.operator_name;
   		 SELF.PhoneLineType  := l.phone_line_type;
   		 SELF.PhoneLineDescription  := l.phone_line_type_desc ;
   		 SELF.PhoneServiceType   := l.phone_serv_type;
   		 SELF.PhoneServiceDescription    := l.phone_serv_type_desc;
      SELF.DisconnectDate := iesp.ECL2ESP.toDate(l.disconnect_date);
      SELF.PortedDate := iesp.ECL2ESP.toDate(l.ported_date);
      SELF.SuspendedDate := iesp.ECL2ESP.toDate(l.suspended_date);
      SELF.ReactivatedDate := iesp.ECL2ESP.toDate(l.reactivated_date);
      SELF.SwappedPhoneNumberDate := iesp.ECL2ESP.toDate(l.swapped_phone_number_date);
      SELF.LineTypeLastSeen := iesp.ECL2ESP.toDate(l.line_type_last_seen);
      SELF.NewPhoneNumberfromSwap := l.new_phone_number_from_swap;
      SELF.Prepaid := l.prepaid;
      SELF.Source := l.source;
      SELF.Dialable := l.dialable;
     END;
                  		
     dPhonesOut := PROJECT(CHOOSEN(dRecs, iesp.Constants.PhoneMetadata.MaxPhoneMetadataRecords), tFormat2PhoneMetadata(LEFT));
 
  return dPhonesOut;

END;