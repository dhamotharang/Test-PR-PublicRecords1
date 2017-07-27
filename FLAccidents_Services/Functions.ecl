import iesp,ut;

export Functions := module

	export params := interface
	end;

	//export fnSearchVal(dataset(FLAccidents_Services.Layouts.raw_rec) in_recs, params in_mod) := function
  export fnSearchVal(dataset(FLAccidents_Services.Layouts.raw_rec) in_recs) := function
						 
	Layouts.t_AccidentSearchRecordWithPenalty 
	        xform(FLAccidents_Services.Layouts.raw_rec l)	:= TRANSFORM		
			self.Name.Full   := '',
		  self.Name.First  := l.fname,
		  self.Name.Middle := l.mname,
		  self.Name.Last   := l.lname,
		  self.Name.Suffix := l.name_suffix,
		  self.Name.Prefix := l.title,
			
			self.Address.StreetNumber        := l.prim_range,
		  self.Address.StreetPreDirection  := l.predir,
		  self.Address.StreetName          := l.prim_name,
			self.Address.StreetSuffix        := l.addr_suffix,
		  self.Address.StreetPostDirection := l.postdir,
		  self.Address.UnitDesignation     := l.unit_desig,
		  self.Address.UnitNumber          := l.sec_range,
		  self.Address.StreetAddress1      := '',
			self.Address.StreetAddress2      := '',
			self.Address.State               := l.st,
			self.Address.City                := l.v_city_name,
			self.Address.Zip5                := l.zip,
		  self.Address.Zip4                := l.zip4,
		  self.Address.County              := '',
		  self.Address.PostalCode          := '',
			self.Address.StateCityZip        := '',
			
      self.CompanyName         := l.cname,
			self.RecordType          := l.record_type,
      self.DriverLicenseNumber := l.driver_license_nbr,
			self.DriverLicenseState  := l.dlnbr_st;
	    self.VIN                 := l.vin,
	    self.TagNumber           := l.tag_nbr,
			self.TagState            := l.tagnbr_st;
			self.AccidentNumber      := intformat(l.l_accnbr,9,1);
			self.AccidentDate        := iesp.ECL2ESP.toDate ((integer4) l.accident_date),
			self.AccidentState       := '',
			self.GenerateReport      := FALSE;
			self._penalty            := l.penalt;
	    self.AlsoFound           := l.isDeepDive;
	    self.pdfImageHash        := L.pdf_image_hash;
	    self.tifImageHash        := L.tif_image_hash;
			self.HasCoverSheet 			 := false;
	  END;
		
	
	  temp_filter := project(in_recs, xform(LEFT));
	
		// sort and dedup temp_filter on entire record
		filter := dedup(sort(temp_filter,record), record);
		
	  return(filter);         	
		
	end;
		
end;
