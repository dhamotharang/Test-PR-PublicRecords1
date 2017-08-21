IMPORT LN_PropertyV2_Services, Text_Search, Codes, MDR;

EXPORT Property_DMPosting(dataset(Layout_Property_DM_Extract) n_ds,
													Types.SourceList sources=[2],//property,
													Types.StateList st_list=ALL) := MODULE
	
	//preprocessing some fields
	Layout_Property_DM_Extract preProcRecs(n_ds l) := transform
		self.buyer1 :=if (l.buyer_or_borrower_ind = 'O',l.name1,''), //buyer
		self.buyer2 :=if (l.buyer_or_borrower_ind = 'O',l.name2,''), //buyer
		self.borrower1 :=if (l.buyer_or_borrower_ind = 'B',l.name1,''), //borrower
		self.borrower2 :=if (l.buyer_or_borrower_ind = 'B',l.name2,''), //borrower
		
		self.buyer_mailing_full_street_address :=if (l.buyer_or_borrower_ind = 'O',l.mailing_street, '');
		self.buyer_mailing_address_unit_number :=if (l.buyer_or_borrower_ind = 'O',l.mailing_unit_number, '');
	  self.buyer_mailing_address_citystatezip :=if (l.buyer_or_borrower_ind = 'O',l.mailing_csz, '');
		 
		self.borrower_mailing_full_street_address :=if (l.buyer_or_borrower_ind = 'B',l.mailing_street, '');
		self.borrower_mailing_unit_number :=if (l.buyer_or_borrower_ind = 'B',l.mailing_unit_number, '');
	  self.borrower_mailing_citystatezip :=if (l.buyer_or_borrower_ind = 'B',l.mailing_csz, '');
	
		self.legal_lot_desc := if(l.legal_lot_desc <> '','LOT DESC:' + l.legal_lot_desc,'');		
		self.legal_lot_number := if (l.legal_lot_number <> '','; LOT NUMBER:' + l.legal_lot_number,'');
		self.legal_land_lot := if (l.legal_land_lot <> '','; LAND LOT:' + l.legal_land_lot,'');
		self.legal_block := if (l.legal_block <> '','; BLOCK:' + l.legal_block,'');
		self.legal_section := if (l.legal_section <> '','; SECTION:' + l.legal_section,'');
		self.legal_district := if (l.legal_district <> '','; DISTRICT:' + l.legal_district,'');
		self.legal_unit := if (l.legal_unit <> '','; UNIT:' + l.legal_unit,'');
		self.legal_subdivision_name := if (l.legal_subdivision_name <> '','; SUBDIVISION:' + l.legal_subdivision_name,'');
		self.legal_phase_number := if (l.legal_phase_number <> '','; PHASE:' + l.legal_phase_number,'');
		self.legal_tract_number := if (l.legal_tract_number <> '','; TRACT:' + l.legal_tract_number,'');
		self.hawaii_tct := if (l.hawaii_tct <> '','; HAWAII TRACT:' + l.hawaii_tct,'');
	
		self.adjustable_rate_rider := if (l.adjustable_rate_rider <> '','ADJUSTABLE_RATE_RIDER:' + l.adjustable_rate_rider,'');
		self.graduated_payment_rider := if (l.graduated_payment_rider <> '','GRADUATED_PAYMENT_RIDER:' + l.graduated_payment_rider,'');
		self.balloon_rider := if (l.balloon_rider <> '','BALLOON_RIDER:' + l.balloon_rider,'');
		self.fixed_step_rate_rider := if (l.fixed_step_rate_rider <> '','FIRST_STEP_RATE_RIDER:' + l.fixed_step_rate_rider,'');
		
		self.condominium_rider := if (l.condominium_rider <> '','CONDOMINIUM_RIDER:' + l.condominium_rider,'');
		self.planned_unit_development_rider := if (l.planned_unit_development_rider <> '','PLANNED_UNIT_DEVELOPMENT_RIDER:' + l.planned_unit_development_rider,'');
		self.rate_improvement_rider := if (l.rate_improvement_rider <> '','RATE_IMPROVEMENT_RIDER:' + l.rate_improvement_rider,'');
		self.assumability_rider := if (l.assumability_rider <> '','ASSUMABILITY_RIDER:' + l.assumability_rider,'');
		
		self.prepayment_rider := if (l.prepayment_rider <> '','PREPAYMENT_RIDER:' + l.prepayment_rider,'');
		self.one_four_family_rider := if (l.one_four_family_rider <> '','1-4_FAMILY_RIDER:' + l.one_four_family_rider,'');
		self.biweekly_payment_rider := if (l.biweekly_payment_rider <> '','BIWEEKLY_PAYMENT_RIDER:' + l.biweekly_payment_rider,'');
		self.second_home_rider := if (l.second_home_rider <> '','SECOND_HOME_RIDER:' + l.second_home_rider,'');
	
		self.loan_term_months := if(l.loan_term_months <>  '','MONTHS: ' + l.loan_term_months,'');
		self.loan_term_years := if(l.loan_term_years <>  '','YEARS: ' + l.loan_term_years,'');
		self.separator := '/';
		/* fields from assessor */
		self.date_from_assesor := '';
    self.field_from_assesor := '';
    self.transfer_date := '';
    self.sale_date := '';
		self := l;
	end;
	preDs := Project(n_ds, preProcRecs(left));
	
	EXPORT Prop_DM_File := Property_DM_UniqDocId(preDs):INDEPENDENT;	
	//calling salt
	SHARED Prop_DM_mod := Property_DMBooleanSearch(Prop_DM_File);	
	EXPORT rawPostings := Prop_DM_mod.Postings_Doc:INDEPENDENT;
				
	s0 := Prop_DM_mod.SegmentDefinitions;
	EXPORT SegmentDefinitions := Text_Search.Mod_SegDef(s0);
	shared extkey :=dataset([{'EXTERNALKEY',Text_search.Types.SegmentType.ExternalKey,[255]}],Text_Search.Layout_Segment_Definition); 
	EXPORT SegmentMetaData := extkey+SegmentDefinitions.SegmentDef;
				
	EXPORT postings := SegmentDefinitions.SetSegs(RawPostings);
	
	//Generate External key
  Text_search.Layout_DocSeg MakeKeySegs( Prop_DM_File l) := TRANSFORM
    self.docref.doc := l.sid;
    self.docref.src := TRANSFER(l.source, unsigned2);
		self.segment := 255;
    self.content := l.ln_fares_id;
    self.sect := 1;
   END;
	EXPORT ExternalKeys := PROJECT(Prop_DM_File,MakeKeySegs(LEFT)):INDEPENDENT;	

	EXPORT DATASET(Text_Search.Layout_Segment_ComposeDef) rawSegmentDefinitions
						:= Prop_DM_mod.SegmentDefinitions;
	
END;