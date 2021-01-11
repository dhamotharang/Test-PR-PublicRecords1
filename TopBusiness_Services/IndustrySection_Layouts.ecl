import BIPV2, iesp;

export IndustrySection_Layouts := module;

   EXPORT rec_OptionsLayout  := RECORD      
       boolean lnbranded;
       boolean internal_testing;
       string1 BusinessReportFetchLevel;
       DATASET ({STRING8 sicCode;}) BestSicCode;
       DATASET ({STRING8 NaicsCode;}) BestNaicsCode;	
    END;
     
  // A slimmed layout with info from common industry linkids key
     export rec_ids_withdata_slimmed := record
         BIPV2.IDlayouts.l_header_ids;
         TopBusiness_Services.Layouts.rec_common.source;
         TopBusiness_Services.Layouts.rec_common.source_docid;
         TopBusiness_Services.Layouts.rec_input_ids_wSrc.IdType;      
         string4  siccode;	// length s/b 4 instead of 8?, but some vendors send more than 4?
         string6  naics; // length s/b 6 instead of 8?, but some vendors send more than 6?
         string128 industry_description;  // just use string with no length???
          //    ^--- 59 for BusRegs, 100 for Calbus, 350 for Corp/Incorp,
          //         40 for EBR(0010 rec), 100 for FBN, 75?(30+', '+33+', '+8?) for Frandx?, 
          //         111 for IRS990,	unlimited on Sheila_Greco???
         string1502 business_description;  //just use string with no length???
          //    ^--- 1502 on DCAV2, 40 on DEADCO, unlimited on Sheila_Greco???, unlimited on Spoke
          //         Others: Corp??? & EBR???
      unsigned4 dt_first_seen;
      unsigned4 dt_last_seen;
      unsigned4 dt_vendor_first_reported;
      unsigned4 dt_vendor_last_reported;
      string1 record_type;                //C=current or H=historical
      unsigned4 record_date;
    end;

  export rec_IndustryChild_Source := record 
           BIPV2.IDlayouts.l_header_ids;
           TopBusiness_Services.Layouts.rec_common.source;
           TopBusiness_Services.Layouts.rec_common.source_docid; // aka IdValue
           TopBusiness_Services.Layouts.rec_input_ids_wSrc.IdType;
    end;
	
  export rec_IndustryChild_SIC := record
      BIPV2.IDlayouts.l_header_ids;
      rec_ids_withdata_slimmed.SicCode;
      string80 SICDescription; // use full length from Codes.Layout_SIC4_Codes? or just string???
  end;

  export rec_IndustryChild_NAICS := record
       BIPV2.IDlayouts.l_header_ids;
       rec_ids_withdata_slimmed.NAICS;
       string120 NAICSDescription; // use full length from Codes.Layout_NAICS_Codes? or just string???
 end;

  export rec_IndustryParent := record
      BIPV2.IDlayouts.l_header_ids;
     dataset(rec_IndustryChild_Source) SourceDocs
          {maxcount(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SRCDOC_RECORDS)}; 
     dataset(rec_IndustryChild_SIC) SICs 
          {maxcount(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SIC_RECORDS)};
     dataset(rec_IndustryChild_NAICS) NAICSs
          {maxcount(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_NAICS_RECORDS)};
          rec_ids_withdata_slimmed.industry_description;
          rec_ids_withdata_slimmed.business_description;
     end;

     export rec_ids_plus_IndustryDetail := record
           BIPV2.IDlayouts.l_header_ids;
           iesp.topbusinessReport.t_TopBusinessIndustryRecord;
     end;		
	
     export rec_ids_plus_IndustrySection := record
           TopBusiness_Services.Layouts.rec_input_ids.acctno;
           BIPV2.IDlayouts.l_header_ids;
           iesp.topbusinessReport.t_TopBusinessIndustrySection;
     end;		

     export rec_final := record
           TopBusiness_Services.Layouts.rec_input_ids.acctno;	
           iesp.topbusinessReport.t_TopBusinessIndustrySection;
      end;

end;
