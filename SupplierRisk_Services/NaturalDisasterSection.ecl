IMPORT AutoStandardI, NaturalDisaster_Readiness, BIPV2, iesp, MDR, TopBusiness_Services, ut;

EXPORT NaturalDisasterSection := MODULE

  // *********** Main function to return Diversity Certification section of the report.
 EXPORT fn_FullView(
   dataset(SupplierRisk_Services.SupplierRisk_Layouts.rec_input_ids) ds_in_ids
	 ,SupplierRisk_Services.SupplierRisk_Layouts.Section_options in_options
                   ):= FUNCTION 
  	
	FETCH_LEVEL := in_options.ReportFetchLevel;
	
	natdis_split_layout := RECORD
			BIPV2.IDlayouts.l_header_ids;
			string3			Total_No_Liaisons;
			string3			Total_No_Liaisons_A;
			string3			Total_No_Liaisons_B;
			string1			Total_No_Liaisons_C;
			DATASET({STRING iso_ref}) 		iso_references;
			DATASET({STRING iso_title})		iso_titles;
			DATASET({STRING iso_type})		iso_types;
	END;
	
	natdis_work_layout := RECORD
			BIPV2.IDlayouts.l_header_ids;
			string3			Total_No_Liaisons;
			string3			Total_No_Liaisons_A;
			string3			Total_No_Liaisons_B;
			string1			Total_No_Liaisons_C;
			STRING 			iso_reference;
			STRING			iso_title;
			STRING			iso_type;
	END;
		
  // Strip off the input acctno from each record, will re-attach them later.
	ds_in_unique_ids_only := project(ds_in_ids,transform(BIPV2.IDlayouts.l_xlink_ids,
	                                                       self := left,
																							           self := []));

  //
  // *** Key fetch to get natural disaster ready linking data from BIP2 linkids key file.
  ds_natdis_recs := NaturalDisaster_Readiness.key_LinkIDs.KFetch(
	                         ds_in_unique_ids_only, // input file to join key with
													 FETCH_LEVEL); // level of ids to join with
							  					 // 3rd parm is ScoreThreshold, take default of 0

	
	natdis_recs_level := SupplierRisk_Services.Functions.setLinkidFetchLev(ds_natdis_recs,recordof(ds_natdis_recs),FETCH_LEVEL);
	
	natdis_recs_dedup := DEDUP(SORT(natdis_recs_level,#expand(BIPV2.IDmacros.mac_ListAllLinkids()),-date_lastseen,-date_updated,RECORD),#expand(BIPV2.IDmacros.mac_ListAllLinkids()));
	
	/* The reference,title and type are currently strung together delimited by a ;, we want these seperated 
					and in child records. The process will split each reference,title and type into records via the normalize
					function and then roll up the records into children via a group Rollup. */
	
	natdis_split_layout xfm_split_iso_recs(recordof(natdis_recs_dedup) l) := TRANSFORM
			SELF.iso_references := dataset(StringLib.SplitWords(l.ISO_Committee_Reference,';',false),{STRING iso_ref});
			SELF.iso_titles := dataset(StringLib.SplitWords(l.ISO_Committee_Title,';',false), {STRING iso_title});
			SELF.iso_types := dataset(StringLib.SplitWords(l.ISO_Committee_Type,';',false), {STRING iso_type});	
			SELF := l;
			SELF := [];
	END;
	
	natdis_split := PROJECT(natdis_recs_dedup,xfm_split_iso_recs(LEFT));
	
	natdis_work_layout xfm_iso_recs(natdis_split_layout l, INTEGER cnt) := TRANSFORM
			SELF.iso_reference := l.iso_references[cnt].iso_ref;
			SELF.iso_title := l.iso_titles[cnt].iso_title;
			SELF.iso_type := l.iso_types[cnt].iso_type;
			SELF := l;
			SELF := [];
	END;
	
	natdis_iso := GROUP(NORMALIZE(natdis_split,(INTEGER)LEFT.Total_No_Liaisons,xfm_iso_recs(LEFT,COUNTER)),#expand(BIPV2.IDmacros.mac_ListAllLinkids()));
	
	iesp.naturalDisaster.t_NaturalDisasterRecord roll_recs(natdis_work_layout l, DATASET(natdis_work_layout) allRows) := TRANSFORM
			
			SELF.LiaisonsTotals.Total  := (Integer) l.Total_No_Liaisons;
			SELF.LiaisonsTotals.TotalA := (Integer) l.Total_No_Liaisons_A;
			SELF.LiaisonsTotals.TotalB := (Integer) l.Total_No_Liaisons_B;
			SELF.LiaisonsTotals.TotalC := (Integer) l.Total_No_Liaisons_C;
			SELF.ISOCommittees := PROJECT(CHOOSEN(allRows,iesp.constants.NATURAL_DISASTER.MaxISOCommittees),TRANSFORM(iesp.naturalDisaster.t_NatDisISOCommittee,
																													SELF.Reference := LEFT.iso_reference,
																													SELF.Title := LEFT.iso_title,
																													SELF._Type := LEFT.iso_type));
			SELF := l;
			self := [];
	END;
	
	natdis_rolled := ROLLUP(natdis_iso,GROUP,roll_recs(LEFT,ROWS(LEFT)));
	natdis_Dedup := DEDUP(natdis_rolled,ALL);
	
	SupplierRisk_Services.SupplierRisk_layouts.natural_disaster_layout format() := TRANSFORM
				self.NaturalDisasterRecords := CHOOSEN(natdis_Dedup,iesp.constants.NATURAL_DISASTER.MaxCountSuppRiskRecords);
				self.NaturalDisasterCount := COUNT(self.NaturalDisasterRecords);
				self.TotalNaturalDisasterCount := COUNT(natdis_Dedup);
				
				iesp.topbusiness_share.t_TopBusinessSourceDocInfo xfm_sourcedoc(SupplierRisk_Layouts.rec_input_ids l) := TRANSFORM
						TopBusiness_Services.IDMacros.mac_IespTransferLinkids(false)
						self.source := MDR.sourceTools.src_NaturalDisaster_Readiness;
						self := [];
				END;
				
				sourceDoc := PROJECT(ds_in_ids[1],xfm_sourcedoc(LEFT));
				self.sourcedocs := IF(EXISTS(natdis_Dedup),sourceDoc);
				self.acctno := ds_in_ids[1].acctno;
				self := [];
	end;

	natdis_final_results := DATASET([format()]);
	return natdis_final_results;
	 
 END; // end of the fn_FullView function
	
END; //end of the module