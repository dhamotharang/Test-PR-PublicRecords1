import Census_Data, faav2_pilotservices, iesp, Codes, lib_stringlib;

  export Functions := module

  shared CreateDate (string4 year, string2 month, string2 day = '') :=
  row ({(integer2) year, (integer2) month, (integer2) day}, iesp.share.t_Date);

  shared decode_region(String regionInStr):= function
	  result:= map(regionInStr='AL'=>'ALASKAN',
							 regionInStr='CE'=>'CENTRAL',
							 regionInStr='NE'=>'NEW ENGLAND',
							 regionInStr='NM'=>'NORTHWEST MOUNTAIN',
							 regionInStr='EA'=>'EASTERN',
							 regionInStr='EU'=>'EUROPEAN',
							 regionInStr='SO'=>'SOUTHERN',
							 regionInStr='GL'=>'GREAT LAKES',
							 regionInStr='WP'=>'WESTERN-PACIFIC',
							 regionInStr='SW'=>'SOUTHWEST',
							 'UNKNOWN');
	  return result;
  end;											 
  export String getMedicalClassLabel(String1 inMedClass):=function
	
	  result :=  map(inMedClass='1'=>'FIRST CLASS',
									inMedClass='2'=>'SECOND CLASS',
									inMedClass='3'=>'THIRD CLASS',
									'UNKNOWN');
	  return result;						
  end;

  export fnFaaPilotSearchVal(dataset(Faav2_Pilotservices.Layouts.Pilotrawrec) in_recs) := function
	
	  faav2_PilotServices.Layouts.t_PilotRecordWithPenalty xform(Faav2_PilotServices.Layouts.Pilotrawrec l, 
																	Census_Data.Key_Fips2County r) := TRANSFORM		
		
			    self.letterCode := l.letter_code;
			    self.RecordType := l.record_type;
	        self.FAAPilotRecordId := l.unique_id;
          self.currentFlag :=  l.current_flag,														
			    self.Region := decode_region(l.Region);
			    self.Country  := l.Country;
					self.Name := iesp.ECL2ESP.setName(l.fname, l.mname, l.lname, l.name_suffix, l.title, l.fname + ' ' + l.mname + ' ' + l.lname);
			   
          // note different names for suffix and zip4 than above.					
          Self.Address := iesp.ECL2ESP.setAddress(l.prim_name, l.prim_range, l.predir, l.postdir, l.suffix,
			                              l.unit_desig, l.sec_range, l.v_city_name,
																		l.st, l.zip, l.zip4, r.county_name);					
					
			    self.MedicalCertification.class := getMedicalClassLabel(l.med_class);
			    self.MedicalCertification.CertificationDate := CreateDate (l.med_date[3..6], l.med_date[1..2]);
			    self.MedicalCertification.ExpirationDate    := CreateDate (l.med_exp_date[3..6], l.med_exp_date[1..2]);
			    self.unique_id  := l.unique_id;
		      self._penalty := l.penalt;
					self.airmen_id := l.airmen_id;
					self.AlsoFound := l.isDeepDive;
					self.uniqueid := l.did_out;
					self.airmenid := l.airmen_id;
					self.statementids := l.statementids,
					self.isDisputed   := l.isDisputed
	  END;
			    
	  temp_filter_search := join (in_recs, Census_Data.Key_Fips2County,
                            keyed(left.state = right.state_code) and
                            keyed(left.county = right.county_fips),
														     xform(LEFT,RIGHT), LEFT OUTER, limit(1, skip));
								
	  // sort and dedup on temp_filter.
	  filter := dedup(sort(temp_filter_search,record), record);
    return(filter);         
	end;

  // There are two flavors of pilot certificates layouts, which seems to be wrong: 
  //     iesp.faapilot.t_PilotReportCertificate and iesp.bpsreport.t_BpsFAACertification

  // They are not consistent with each other, and both have some major defects:
  // redundancy (t_PilotReportCertificate is attached to every pilot record, while being the same),
  // different fields' semantics (t_PilotReportRecord._Type vs. t_FAACertificate.TypeDesc), 
  // incompleteness (missing DIDs in the input or output), etc.

  // Thus, unfortunately we need to provide an output structures for both

  // define wide layouts covering both cases
  shared cert_rec_ext := record 
    iesp.faapilot_fcra.t_FcrapilotReportCertificate and not [_type, Level];
    string1 _type;
    string1 level;
    string20 TypeDesc; //as defined in faa@layout_airmen_certificate_out
    string45 LevelDesc; // ...
	end;
	
	shared decode_ratings(STRING ratingStr) := Function
		ratingStr2 := REGEXREPLACE('\\w/', ratingStr, ',$0', NOCASE);
		l_code := {string15 code};
		num := length(StringLib.StringFilter(ratingStr2,','));
	  ds := NORMALIZE(dataset([{''}],l_code), num, transform(l_code, self.code:=StringLib.StringExtract(ratingStr2, counter+1)));
		 
	  iesp.faapilot.t_PilotRatings xform(recordof(ds) l,recordof(Codes.Key_Codes_V3) r) := TRANSFORM
		  SELF.RatingDescription := r.long_desc;
	  END;
		
	  ds_join := join(ds, Codes.Key_Codes_V3,	
										keyed(right.file_name = faav2_pilotServices.constants.codesv3_file_name) and 
										keyed(right.field_name = faav2_pilotServices.constants.codesv3_field_name) and	left.code = right.code, xform(left,right), lookup);
		
	  return ds_join;
  end;

  shared pilot_rec_ext := record
    iesp.faapilot_fcra.t_FcraPilotReportRecord and not [Certificates];
    dataset (cert_rec_ext) Certificates;
	end;

  // widest common part, which later can be slimmed down, if needed.
  shared GetCommonReportData (dataset (faav2_pilotServices.Layouts.PilotReportrawrec) cert_recs_in,
                              dataset (faav2_pilotServices.layouts.pilotRawRec) pilot_address_recs_in) 
                                              := function
    cert_rec_ext xform(faav2_pilotServices.Layouts.PilotReportrawrec l) := TRANSFORM
      self.letter := l.letter;
      self.FAAPilotRecordId := l.unique_id;
      self.RecordType       := l.rec_type;
      self._type            := l.cer_type;  
      self.TypeDesc         := l.cer_type_mapped;
      self.level            := l.cer_level;
      self.LevelDesc        := l.cer_level_mapped;
      self.Ratings          := l.ratings;
      self.ExpirationDate   := CreateDate (l.cer_exp_date[5..8], l.cer_exp_date[1..2], l.cer_exp_date[3..4]);
			self.Rating 					:= decode_ratings(l.ratings);
			self.statementids 		:= l.statementids,
			self.isDisputed   		:= l.isDisputed
    END;
    pilot_cert_recs := project(choosen (cert_recs_in, iesp.Constants.MAX_COUNT_PILOT_CERTIFICATES), xform(left));
      
    pilot_rec_ext xform_info(faav2_pilotServices.layouts.pilotRawRec l) := TRANSFORM
      self.Name := iesp.ECL2ESP.setName(l.fname, l.mname, l.lname, l.name_suffix, l.title);
      //note different names for suffix and zip4 than above.
       Self.Address := iesp.ECL2ESP.SetAddress (l.prim_name, l.prim_range, l.predir, l.postdir, l.suffix,
                             l.unit_desig, l.sec_range, if (l.v_city_name <> '', l.v_city_name, l.city), l.st, 
                             l.zip, l.zip4, l.county_name, '', l.street1, l.street2);
       self.RecordType                  := l.current_flag;
			 self.RecordTypeDescription	      := l.record_type;
       self.Class                       := getMedicalClassLabel(l.med_class); //this should be l.med_class but leaving it for backward compatiblity
       self.ClassDesc                   := getMedicalClassLabel(l.med_class);
			 self.Region											:= decode_Region(l.region);
       self.DateCertifiedMedical := CreateDate (l.med_date[3..6], l.med_date[1..2]);
       self.DateExpiresMedical   := CreateDate (l.med_exp_date[3..6], l.med_exp_date[1..2]);
       self.Certificates := sort (pilot_cert_recs, recordType);
			 self.UniqueId := l.did_out;
			 self.Airmenid := l.airmen_id;
			 self.StatementIds := l.StatementIds,
			self.isDisputed    := l.isDisputed
    end;
      
    pilot_final_record := project(pilot_address_recs_in, xform_info(left));    
    return pilot_final_record;
  end; // function

	// used by report  and raw.
  export iesp.faapilot_Fcra.t_FcraPilotReportRecord setReportStructure(
  dataset (faav2_pilotServices.Layouts.PilotReportrawrec) cert_recs_in,
  dataset (faav2_pilotServices.layouts.pilotRawRec) pilot_address_recs_in) := function

    // Generally, slims down extended version and switches code/description
    iesp.faapilot_Fcra.t_FcraPilotReportCertificate xform (cert_rec_ext l) := TRANSFORM
      self._type := l.TypeDesc,  
      self.Level := l.LevelDesc, 
      self := l;
    end;
    iesp.faapilot_Fcra.t_FcraPilotReportRecord xform_info(pilot_rec_ext l) := TRANSFORM
      self.Certificates := project (l.certificates, xform (Left)),
			self.StatementIds := l.StatementIds,
			self.isDisputed   := l.isDisputed,
			self := l; 
    end;
    ds_rep := GetCommonReportData (cert_recs_in, pilot_address_recs_in);
		
    pilot_final_record := project(ds_rep, xform_info(left));    
    return pilot_final_record;
      
  end; // function

  // used by bps-report
  export iesp.bpsreport_fcra.t_FcraBpsFAACertification GetBpsReportView (
    dataset (faav2_pilotServices.Layouts.PilotReportrawrec) cert_recs_in,
    dataset (faav2_pilotServices.layouts.pilotRawRec) pilot_address_recs_in) := function

    // Generally, slims down extended version and switches code/description
    iesp.bpsreport_fcra.t_FcraFAACertificate xform (cert_rec_ext l) := TRANSFORM
      Self.DateExpires := L.ExpirationDate;
      Self := L;
    end;
    iesp.bpsreport_fcra.t_FcraBpsFAACertification xform_info (pilot_rec_ext L) := TRANSFORM
      Self.Certificates := project (l.certificates, xform (Left));
			CapitalPrefix := stringlib.stringToUpperCase(L.name.prefix);
      Self.Gender := map(CapitalPrefix = 'MR' => 'Male',
			                   CapitalPrefix = 'MS' => 'Female',
												 '');
      Self := L;
    end;
    ds_rep := GetCommonReportData (cert_recs_in, pilot_address_recs_in);
    pilot_final_record := project(ds_rep, xform_info(left));    
      
    return pilot_final_record;
      
  end; // function

END;