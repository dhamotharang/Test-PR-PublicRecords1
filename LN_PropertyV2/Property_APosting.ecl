IMPORT LN_PropertyV2_Services, Text_Search, Codes, MDR;

EXPORT Property_APosting(dataset(Layout_Property_A_Extract) n_ds,
													Types.SourceList sources=[2],//property,
													Types.StateList st_list=ALL
													) := MODULE
	
	//preprocess some fields
	Layout_Property_A_Extract preProcRecs(n_ds l) := transform
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
		self.homestead_homeowner_exemption :=if (l.homestead_homeowner_exemption <> '',
										'HOMESTEAD HOMEOWNER EXEMPTION:' + l.homestead_homeowner_exemption,'');	
		self.year_built := if(l.year_built <>  '','; YEAR BUILT:' + l.year_built,'');
		self.effective_year_built := if(l.effective_year_built <> '','; EFFECTIVE YEAR BUILT:' + l.effective_year_built,'');
		self.condo_project_name := if(l.condo_project_or_building_name <> '','; CONDO PROJECT NAME:' + l.condo_project_or_building_name,'');
		self.building_name := if(l.condo_project_or_building_name <> '','; BUILDING NAME:' + l.condo_project_or_building_name,'');	
		self.separator := '/';
		self.date_from_deed :='';
    self.field_from_deeds :='';
		self := l;
	end;
	preDs := Project(n_ds, preProcRecs(left));
	
	//generate unique sid by ln_fare_id
	EXPORT Prop_A_File := Property_A_UniqDocId(preDs,st_list):INDEPENDENT;	
	
	//calling salt
	SHARED Prop_A_Mod := Property_ABooleanSearch(Prop_A_File);	
	EXPORT rawPostings := Prop_A_Mod.Postings_Doc:INDEPENDENT;
																		
	s0 := Prop_A_Mod.SegmentDefinitions;
	EXPORT SegmentDefinitions := Text_Search.Mod_SegDef(s0);
	shared extkey :=dataset([{'EXTERNALKEY',Text_search.Types.SegmentType.ExternalKey,[255]}],Text_Search.Layout_Segment_Definition); 
	EXPORT SegmentMetaData := extkey+SegmentDefinitions.SegmentDef;
	EXPORT postings  := SegmentDefinitions.SetSegs(RawPostings);
	
	//Generate External key
  Text_search.Layout_DocSeg MakeKeySegs( Prop_A_File l) := TRANSFORM
    self.docref.doc := l.sid;
    self.docref.src := TRANSFER(l.source, unsigned2);
		self.segment := 255;
    self.content := l.ln_fares_id;
    self.sect := 1;
   END;
	EXPORT ExternalKeys := PROJECT(Prop_A_File,MakeKeySegs(LEFT)):INDEPENDENT;	
	
	EXPORT DATASET(Text_Search.Layout_Segment_ComposeDef) rawSegmentDefinitions
						:= Prop_A_Mod.SegmentDefinitions;
END;