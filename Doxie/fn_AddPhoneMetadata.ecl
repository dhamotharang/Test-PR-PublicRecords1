Import doxie_crs, doxie, Std, PhonesFeedback_Services;

EXPORT fn_AddPhoneMetadata (DATASET(doxie.Layout_AddPhoneMetadata) ds_ph_recs,
													 string15 in_phone = ''
													 ):= FUNCTION

  //For accurint, adding phone related fields
telcordia_phones := Doxie.phone_metadata(ds_ph_recs, in_phone);
	             		
phone_cons := record
  string1     type_Flag;
  unsigned4   cell_type; 
  boolean 	  confirmed_flag;
	recordof(telcordia_phones);
end;
           	
phone_cons add_con(telcordia_phones L) := transform
	 self.cell_type 		 := 1;
	 self.confirmed_flag := false;
	 self.type_flag      := map(L.tnt = Phones.Constants.TNT.History => Phones.Constants.TypeFlag.DirectoryAssistance_Disconnected, 
  												    L.tnt != Phones.Constants.TNT.History => Phones.Constants.TypeFlag.DirectoryAssistance,
  												    '');
   self                := L;
end;

telcordia_cons := project(telcordia_phones,add_con(left));	
             		
phone_cons add_type(telcordia_cons L) := transform
  cell_test1		  := l.coctype = Phones.Constants.COCType.EndofOfficeCode and 
         											   (l.ssc		= Phones.Constants.SSC.Cellular or 
         											    l.ssc 		= Phones.Constants.SSC.Radio);
           								
  cell_test2   	  := (l.coctype != Phones.Constants.COCType.EndofOfficeCode)and 
          								       (l.ssc = Phones.Constants.SSC.Cellular or
           									      l.ssc = Phones.Constants.SSC.Radio or
           									      l.ssc = Phones.Constants.SSC.MiscServices);
             								 
  cell_test3   	  :=  l.ssc = Phones.Constants.SSC.Cellular;  
            			
  self.cell_type  :=	if(cell_test1 or cell_test2 or cell_test3, L.cell_type*5, L.cell_type);
             			
  
  self.new_type   := map(l.type_flag = Phones.Constants.TypeFlag.DirectoryAssistance 			 =>  Phones.Constants.NewType.Current
												 , ~(self.cell_type%3=0 or self.cell_type%5=0) and ~l.confirmed_flag =>  Phones.Constants.NewType.Possible											   
												 , '');
  self					  :=     L;
end;
         	
telcordia_type := project(telcordia_cons, add_type(left));
	
todaydate := (STRING8)Std.Date.Today();
	
doxie_crs.layout_phone_records add_carrier(telcordia_type L) := transform
	self.PhoneType := map(L.listing_type = 1 => Phones.Constants.PhoneType.Residential,
	                      L.listing_type = 2 => Phones.Constants.PhoneType.Business,
												L.listing_type = 4 => Phones.Constants.PhoneType.Government,
												'');  
	self.carrier   := L.ocn;
  self.carrier_city  := L.city;
  self.carrier_state := L.st;
	self.dt_first_seen := L.dt_first_seen;
	self.dt_last_seen  := todaydate;
  self := L;
  
end;		
phone_all_recs := project(telcordia_type, add_carrier(left));

Return phone_all_recs;
	
END;