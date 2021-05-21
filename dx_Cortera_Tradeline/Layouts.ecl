IMPORT address, BIPV2, dx_common, MDR;

EXPORT Layouts := MODULE

  ////////////////////////////////////////////////////////////////////////
  // -- Input Tradeline Layout
  ////////////////////////////////////////////////////////////////////////
  EXPORT Layout_Tradeline := RECORD
    UNSIGNED4 LINK_ID;         // Number 9   - Cortera unique identifier for a location
    STRING32  ACCOUNT_KEY;     // Varchar 32 - Unique key for a tradeline
    STRING2   SEGMENT_ID;      // Number 2   - Cortera unique Industry code describing the industry of the provider of the data
    STRING8   AR_DATE;         // Number 8   - Date of the trade record.  Format is YYYYMMDD
    STRING20  TOTAL_AR;        // Number 20  - Total accounts receivables due
    STRING20  CURRENT_AR;      // Number 20  - Current accounts receivables due
    STRING20  AGING_1TO30;     // Number 20  - Amount of accounts receivables that is 1-30 days past due
    STRING20  AGING_31TO60;    // Number 20  - Amount of accounts receivables that is 31-60 days past due
    STRING20  AGING_61TO90;    // Number 20  - Amount of accounts receivables that is 61-90 days past due
    STRING20  AGING_91PLUS;    // Number 20  - Amount of accounts receivables that is more than 91 days past due
    STRING20  CREDIT_LIMIT;    // Number 20  - Credit Limit reported by the provider.  Sparsely populated.
    STRING8   FIRST_SALE_DATE; // Number 8   - Date of first sale reported by the provider. Sparsely populated.
    STRING8   LAST_SALE_DATE;  // Number 8   - Date of last sale reported by the provider.
  END;

  ////////////////////////////////////////////////////////////////////////
  // -- Base Layout
  ////////////////////////////////////////////////////////////////////////
  EXPORT Layout_Tradeline_Base := RECORD
    Layout_Tradeline;
    STRING2   source := MDR.sourceTools.src_Cortera_Tradeline;
    STRING1   status := '';    // blank=current, D=Deleted by vendor, R=Replaced by newer version
    UNSIGNED4 filedate;        // file date from vendor
    UNSIGNED4 process_date;    // build date
    UNSIGNED4 dt_first_seen;
    UNSIGNED4 dt_last_seen;
    UNSIGNED4 dt_vendor_first_reported;
    UNSIGNED4 dt_vendor_last_reported;
    UNSIGNED4 deletion_date;   // date the record was deleted

    UNSIGNED6 bdid := 0;
    UNSIGNED1 bdid_score := 0;
    BIPV2.IDlayouts.l_xlink_ids;
		dx_common.layout_metadata; // Added for Delta build process. CCPA fields are also part of this.
  END;


  ////////////////////////////////////////////////////////////////////////
  // -- Key Layout
  ////////////////////////////////////////////////////////////////////////

	////////////////////////////////////////////////////////////////////////
  // -- Layout Key LinkIds
  ////////////////////////////////////////////////////////////////////////
  EXPORT Layout_Tradeline_Key := RECORD
    BIPV2.IDlayouts.l_key_ids;
    Layout_Tradeline_Base - BIPV2.IDlayouts.l_xlink_ids;
    integer1 fp := 0; //for platform?
  END;

END;
