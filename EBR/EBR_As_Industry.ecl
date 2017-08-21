
IMPORT TopBusiness_BIPV2, MDR;

EBR_Hdr_Base := EBR.File_0010_Header_Base_AID;
EBR_Demograph := EBR.File_5600_Demographic_Data_Base ;

//Set to Filter out unsavory SIC codes (file_number|proxid|sic_code)
//5411 (Grocery Stores) is an invalid SIC for Apple Inc (file number 811862944), bug #131524
BadSICs := ['811862944|11084446|5411'];

CombineCodes (STRING FileNo, STRING Prox, STRING SIC) := FUNCTION
  RETURN TRIM(FileNo,LEFT,RIGHT) + '|' + TRIM(Prox,LEFT,RIGHT) + '|' + TRIM(SIC,LEFT,RIGHT);
END;

EBR_Hdr_Base_slim := project(EBR_Hdr_Base(sic_code<>'' or business_desc<>''),
		  transform(TopBusiness_BIPV2.Layouts.rec_industry_combined_layout,
	      self.source                    := MDR.sourceTools.src_EBR,
			  self.source_docid              := TRIM(left.file_number,LEFT,RIGHT),
			  self.source_rec_id             := left.source_rec_id,        
			  self.siccode                   := IF(CombineCodes(left.file_number, (STRING)left.proxid, left.sic_code) IN BadSICs, '', left.sic_code),
				// self.naics                     := IF(busenaic,left.pnaics,''),
				// self.industry_description      := IF(buseIndustry,left.pindustry_description,''),
				self.business_description      := '',
				self.bdid                      := (unsigned) left.bdid,
				self.dt_first_seen             := (unsigned)left.date_first_seen,
				self.dt_last_seen              := (unsigned)left.date_last_seen,
				self.dt_vendor_first_reported  :=(unsigned)left.process_date_first_seen,
				self.dt_vendor_last_reported   :=(unsigned)left.process_date_last_seen,
				self.record_type               :=left.record_type,
				self.record_date               :=(unsigned)left.process_date,
			  self                           := left, 
			  self                           := []));


TopBusiness_BIPV2.Layouts.rec_industry_combined_layout xform_ebr(EBR_Demograph L, INTEGER C) := TRANSFORM

	      self.source                    := MDR.sourceTools.src_EBR;
			  self.source_docid              := TRIM(l.file_number,LEFT,RIGHT),
			  // self.source_rec_id             := (string) l.source_rec_id,
			  temp_siccode                   := CHOOSE(c,l.sic_1_code,l.sic_2_code,l.sic_3_code,l.sic_4_code);           
        self.siccode                   := IF(CombineCodes(l.file_number, (STRING)l.proxid, temp_siccode) IN BadSICs, '', temp_siccode); 
				self.industry_description      := IF(CombineCodes(l.file_number, (STRING)l.proxid, temp_siccode) IN BadSICs, '',
                                             CHOOSE(c,l.sic_1_desc,l.sic_2_desc,l.sic_3_desc,l.sic_4_desc));
				self.business_description      := '';
				self.bdid                      := (unsigned) l.bdid;
				self.dt_first_seen             := (unsigned)l.date_first_seen;
				self.dt_last_seen              := (unsigned)l.date_last_seen;
				self.dt_vendor_first_reported  :=(unsigned)l.process_date_first_seen ;
				self.dt_vendor_last_reported   :=(unsigned)l.process_date_last_seen ;
				self.record_type               :=l.record_type;
				self.record_date               :=(unsigned)l.process_date;
			  self                           := l; 
			  self                           := [];
END;				

EBR_Demograph_slim :=normalize(EBR_Demograph,4,xform_ebr(left,COUNTER));
				
EXPORT EBR_As_Industry := EBR_Hdr_Base_slim+EBR_Demograph_slim(siccode<>'' or industry_description<>'' or business_description<>'');
