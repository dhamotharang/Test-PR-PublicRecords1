EXPORT Mac_transform_license (pInputfile		// Input File
						,pOutputFile	// Output file with feedback dataset
					  ,psource
						,pbdid
						,plicense_state
						,blicense_board=false
						,plicense_board='license_board'   // the license issuing board or agency name
						,plicense_number  // the license number issued
						,plicense_type    // the type of license (pharmacy, pharmacist, etc.)
						,pissue_date      // the date the license was issued
						,pexpiration_date // the date the license expires
					  ,psource_docid = 'source_docid'
					  ,psource_rec_id = 'source_rec_id'
						,pdt_first_seen = 'dt_first_seen'
						,pdt_last_seen='dt_last_seen'
					  ,pdt_vendor_first_reported='dt_vendor_first_reported'
						,pdt_vendor_last_reported='dt_vendor_last_reported'
						,brecord_type=false
						,precord_type='record_type'
						,brecord_date=false
						,precord_date='record_date'
					  ):= MACRO

		#uniquename(sBlank);
		%sBlank%:='';

		#uniquename(sLicenseBoard)
		%sLicenseBoard%:=IF(psource = MDR.sourceTools.src_FCC_Radio_Licenses,'FCC',%sBlank%);

		pOutputFile := project(pInputfile,
		  transform(TopBusiness_BIPV2.Layouts.rec_license_combined_layout,
	      self.source        := psource,
			  self.source_docid  := (string) left.psource_docid,
			  self.source_rec_id := (string) left.psource_rec_id,

				self.license_state := (string) left.plicense_state,
				self.license_board := IF(blicense_board,(string) left.plicense_board, %sLicenseBoard%),
				self.license_number := (string) left.plicense_number,
				self.license_type   := (string) left.plicense_type,
				self.issue_date     := (string) left.pissue_date,
				self.expiration_date := (string) left.pexpiration_date,

				self.bdid := (unsigned) left.pbdid,
				self.dt_first_seen:= (unsigned)left.pdt_first_seen;
				self.dt_last_seen:= (unsigned)left.pdt_last_seen;
				self.dt_vendor_first_reported:=(unsigned)left.pdt_vendor_first_reported;
				self.dt_vendor_last_reported:=(unsigned)left.pdt_vendor_last_reported;
				self.record_type:=IF (brecord_type,left.precord_type,'');
				self.record_date:=IF (brecord_date,(unsigned)left.precord_date,(unsigned) %sBlank%);
			  self := left, 
			  self := [] ,
			));

				 
endmacro;
