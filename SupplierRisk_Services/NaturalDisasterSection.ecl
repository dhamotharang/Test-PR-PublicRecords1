IMPORT NaturalDisaster_Readiness, BIPV2, iesp, MDR, TopBusiness_Services, ut;

EXPORT NaturalDisasterSection := MODULE

  // *********** Main function to return Diversity Certification section of the report.
 EXPORT fn_FullView(
   DATASET(SupplierRisk_Services.SupplierRisk_Layouts.rec_input_ids) ds_in_ids,
   SupplierRisk_Services.SupplierRisk_Layouts.Section_options in_options
  ):= FUNCTION
    
  FETCH_LEVEL := in_options.ReportFetchLevel;
  
  natdis_split_layout := RECORD
    BIPV2.IDlayouts.l_header_ids;
    STRING3 Total_No_Liaisons;
    STRING3 Total_No_Liaisons_A;
    STRING3 Total_No_Liaisons_B;
    STRING1 Total_No_Liaisons_C;
    DATASET({STRING iso_ref}) iso_references;
    DATASET({STRING iso_title}) iso_titles;
    DATASET({STRING iso_type}) iso_types;
  END;
  
  natdis_work_layout := RECORD
    BIPV2.IDlayouts.l_header_ids;
    STRING3 Total_No_Liaisons;
    STRING3 Total_No_Liaisons_A;
    STRING3 Total_No_Liaisons_B;
    STRING1 Total_No_Liaisons_C;
    STRING iso_reference;
    STRING iso_title;
    STRING iso_type;
  END;
    
  // Strip off the input acctno from each record, will re-attach them later.
  ds_in_unique_ids_only := PROJECT(ds_in_ids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
    SELF := LEFT, SELF := []));

  // *** Key fetch to get natural disaster ready linking data from BIP2 linkids key file.
  ds_natdis_recs := NaturalDisaster_Readiness.key_LinkIDs.KFetch(ds_in_unique_ids_only, FETCH_LEVEL);

  natdis_recs_level := SupplierRisk_Services.Functions.setLinkidFetchLev(ds_natdis_recs,RECORDOF(ds_natdis_recs),FETCH_LEVEL);

  natdis_recs_dedup := DEDUP(SORT(natdis_recs_level,#expand(BIPV2.IDmacros.mac_ListAllLinkids()),-date_lastseen,-date_updated,RECORD),#expand(BIPV2.IDmacros.mac_ListAllLinkids()));
  
  /* The reference,title and type are currently strung together delimited by a ;, we want these seperated
    and in child records. The process will split each reference,title and type into records via the normalize
    function and then roll up the records into children via a group Rollup. */
  
  natdis_split_layout xfm_split_iso_recs(RECORDOF(natdis_recs_dedup) l) := TRANSFORM
    SELF.iso_references := DATASET(STRINGLib.SplitWords(l.ISO_Committee_Reference,';',FALSE),{STRING iso_ref});
    SELF.iso_titles := DATASET(STRINGLib.SplitWords(l.ISO_Committee_Title,';',FALSE), {STRING iso_title});
    SELF.iso_types := DATASET(STRINGLib.SplitWords(l.ISO_Committee_Type,';',FALSE), {STRING iso_type});
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
      
    SELF.LiaisonsTotals.Total := (INTEGER) l.Total_No_Liaisons;
    SELF.LiaisonsTotals.TotalA := (INTEGER) l.Total_No_Liaisons_A;
    SELF.LiaisonsTotals.TotalB := (INTEGER) l.Total_No_Liaisons_B;
    SELF.LiaisonsTotals.TotalC := (INTEGER) l.Total_No_Liaisons_C;
    SELF.ISOCommittees := PROJECT(CHOOSEN(allRows,iesp.constants.NATURAL_DISASTER.MaxISOCommittees),
      TRANSFORM(iesp.naturalDisaster.t_NatDisISOCommittee,
        SELF.Reference := LEFT.iso_reference;
        SELF.Title := LEFT.iso_title;
        SELF._Type := LEFT.iso_type;
      ));
    SELF := l;
    SELF := [];
  END;
  
  natdis_rolled := ROLLUP(natdis_iso,GROUP,roll_recs(LEFT,ROWS(LEFT)));
  natdis_Dedup := DEDUP(natdis_rolled,ALL);
  
  SupplierRisk_Services.SupplierRisk_layouts.natural_disaster_layout format() := TRANSFORM
    SELF.NaturalDisasterRecords := CHOOSEN(natdis_Dedup,iesp.constants.NATURAL_DISASTER.MaxCountSuppRiskRecords);
    SELF.NaturalDisasterCount := COUNT(SELF.NaturalDisasterRecords);
    SELF.TotalNaturalDisasterCount := COUNT(natdis_Dedup);
    
    iesp.topbusiness_share.t_TopBusinessSourceDocInfo xfm_sourcedoc(SupplierRisk_Layouts.rec_input_ids l) := TRANSFORM
      TopBusiness_Services.IDMacros.mac_IespTransferLinkids(FALSE)
      SELF.source := MDR.sourceTools.src_NaturalDisaster_Readiness;
      SELF := [];
    END;
    
    sourceDoc := PROJECT(ds_in_ids[1],xfm_sourcedoc(LEFT));
    SELF.sourcedocs := IF(EXISTS(natdis_Dedup),sourceDoc);
    SELF.acctno := ds_in_ids[1].acctno;
    SELF := [];
  END;

  natdis_final_results := DATASET([format()]);
  RETURN natdis_final_results;
   
 END; // END of the fn_FullView FUNCTION
  
END; //END of the MODULE
