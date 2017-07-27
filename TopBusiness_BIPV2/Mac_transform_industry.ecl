
EXPORT Mac_transform_industry (pInputfile		// Input File
						,pOutputFile	// Output file with feedback dataset
					  ,psource
						,busesic=true
					  ,psiccode = 'siccode'
						,busenaic=true
					  ,pnaics = 'naics'
						,buseIndustry=true
					  ,pindustry_description
						,busebusiness=true
					  ,pbusiness_description = 'business_description'
					  ,psource_docid = 'source_rec_id'
					  ,psource_rec_id = 'source_rec_id'
						,pdt_first_seen = 'dt_first_seen'
						,pdt_last_seen='dt_last_seen'
					  ,pdt_vendor_first_reported='dt_vendor_first_reported'
						,pdt_vendor_last_reported='dt_vendor_last_reported'
						,brecord_type=true
						,precord_type='record_type'
						,brecord_date=true
						,precord_date='record_date'
					  ):= MACRO


#uniquename(sBlank)
%sBlank%:='';
		pOutputFile := project(pInputfile,
		  transform(TopBusiness_BIPV2.Layouts.rec_industry_combined_layout,
	      self.source        := psource,
			  self.source_docid  := (string) left.psource_docid,
			  self.source_rec_id := (string) left.psource_rec_id,
			  self.siccode       := IF(busesic,left.psiccode,''),
				self.naics         := IF(busenaic,left.pnaics,''),
				self.industry_description := IF(buseIndustry,left.pindustry_description,''),
				self.business_description := IF(busebusiness,left.pbusiness_description,''),
				self.bdid := (unsigned) left.bdid,
				self.dt_first_seen:= (unsigned)left.pdt_first_seen;
				self.dt_last_seen:= (unsigned)left.pdt_last_seen;
				self.dt_vendor_first_reported:=(unsigned)left.pdt_vendor_first_reported ;
				self.dt_vendor_last_reported:=(unsigned)left.pdt_vendor_last_reported ;
				self.record_type:=IF (brecord_type,left.precord_type,''),
				self.record_date:=IF (brecord_date,(unsigned)left.precord_date,(unsigned) %sBlank%) ;
			  self := left, 
			  self := [] ,
			));
			
				 
endmacro;
