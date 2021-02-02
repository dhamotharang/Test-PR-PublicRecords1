IMPORT AutoStandardI, BIPV2, Doxie, MDR, STD, TopBusiness_Services, VehicleV2, Doxie;

EXPORT getMotorVehicles(DATASET(Business_Risk_BIP.Layouts.Shell) Shell, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet,
											 doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION
 
  // Look at GLBA and DPPA values in Options, and define an attribute that determines
  // whether the GLBA/DPPA values indicate absolutely no permissions to view Vehicles
  // data. This will be used to convert no-hits ('0') to "vehicles turned off" (-2).
  dppa_ok  := AutoStandardI.PermissionI_Tools.val(linkingOptions).DPPA.ok(Options.DPPA_Purpose);
  glba_ok  := AutoStandardI.PermissionI_Tools.val(linkingOptions).GLB.ok(Options.GLBA_Purpose);
  
  vehicles_are_turned_off := NOT(dppa_ok AND glba_ok);
  
  // --------------- Vehicles Data - Using Business IDs ----------------
  VehiclesRaw := VehicleV2.Key_Vehicle_Linkids.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell), mod_access,
                             Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
                             0, /*ScoreThreshold --> 0 = Give me everything*/
                             linkingOptions,
                             Business_Risk_BIP.Constants.Limit_Default,
														 Options.KeepLargeBusinesses);

  // Filter to ONLY include recs where the reported on company (set of input linkids) is 
  // either a Registrant(type=4) or Lessee(type=5) of the vehicle, but not any others 
  // like Owner(type=1), Lessor(type=2) or Lienholder(type=7). Then project linkids key 
  // data being used into a slimmed layout.
  //
  /*
     // INFO: Vehicle "party" key orig_name_type values
     VEH_OWNER		 		 := '1'; 
     VEH_LESSOR			  := '2';
     VEH_REGISTRANT := '4'; *
     VEH_LESSEE			  := '5'; *
     VEH_LIENHOLDER := '7';
  */
  VehiclesRaw_filt := 
    PROJECT(
      VehiclesRaw( orig_name_type IN [ /*TopBusiness_Services.Constants.VEH_OWNER,*/ // We don't want Title info.
                                       TopBusiness_Services.Constants.VEH_REGISTRANT,
                                       TopBusiness_Services.Constants.VEH_LESSEE ] ),
      TRANSFORM( RECORDOF(VehiclesRaw),
        SELF.source_code := MDR.sourceTools.fVehicles(LEFT.state_origin,LEFT.source_code),
        SELF := LEFT
      )
     );

  // Add back our Seq numbers
  Business_Risk_BIP.Common.AppendSeq(VehiclesRaw_filt, Shell, VehiclesSeq, Options.LinkSearchLevel );

  // Figure out if the kFetch was successful
  // kFetchErrorCodes := Business_Risk_BIP.Common.GrabFetchErrorCode(VehiclesSeq);

  // Filter out records after our history date
  Vehicles := Business_Risk_BIP.Common.FilterRecords(VehiclesSeq, date_first_seen, date_vendor_first_reported, source_code, AllowedSourcesSet);

  Vehicles_srtd := SORT( Vehicles, seq, vehicle_key, iteration_key, -sequence_key );

  // Slim the Vehicles data to what's useful for debugging, analysis,etc.
  tbl_Vehicles_srtd :=
    TABLE(
      Vehicles_srtd,
      { seq,
        historydate,
        ultid,
        orgid,
        seleid,
        proxid,
        powid,
        vehicle_key,
        iteration_key,
        sequence_key,
        source_code,
        state_origin,
        date_first_seen,
        date_last_seen,
        date_vendor_first_reported,
        date_vendor_last_reported,
        orig_party_type,
        orig_name_type,
        orig_name,
        orig_address,
        orig_city,
        orig_state,
        orig_zip,
        reg_first_date,
        reg_earliest_effective_date,
        reg_latest_effective_date,
        reg_latest_expiration_date,
        reg_rollup_count,
        reg_true_license_plate,
        reg_license_plate,
        reg_license_state,
        reg_license_plate_type_code,
        reg_license_plate_type_desc
      }
    );

  layout_Vehicles_slim := RECORD
    RECORDOF(tbl_Vehicles_srtd);
    UNSIGNED3 isAsset;
    UNSIGNED3 isPrivate;
    UNSIGNED3 isCommercial;
    UNSIGNED3 isUnknown;
    UNSIGNED6 vehicleValue;
    STRING orig_vin;
    STRING vina_price;
    STRING orig_year;
    STRING orig_make_code;
    STRING orig_make_desc;
    STRING orig_series_code;
    STRING orig_series_desc;
    STRING orig_model_code;
    STRING orig_model_desc;
    UNSIGNED4 minDate;
    UNSIGNED4 maxDate;
    UNSIGNED4 historyDateYYYYMMDD;
  END;

  set_private_vehicle_codes :=
    [
      'ANQ', // 'Antique'
      'DAV', // 'Disabled Veteran'
      'HCP', // 'Handicapped',
      'MH',  // 'Military Honor'
      'PRV'  // 'Private'
    ];

  set_commercial_vehicle_codes :=
    [
      'AG',  // 'Agriculture',               
      'AR',  // 'Amateur Radio'
      'CLG', // 'Clergy',
      'CML', // 'Commercial'
      'DE',  // 'Driver Education',
      'DLR', // 'Dealer',
      'EA',  // 'Educational Affiliation',
      'EMR', // 'Emergency',
      'ENV', // 'Environmental'
      'FGV', // 'Federal Government',
      'FNL', // 'Funeral',
      'FOR', // 'Forestry',
      'LGV', // 'Local Government',
      'LIV', // 'Livery',
      'MFG', // 'Manufacturer'
      'MIL', // 'Military'
      'MUB', // 'Municipal Bus',
      'OFF', // 'Official Representative'
      'POL', // 'Police'
      'SCB', // 'School Bus',
      'SGV', // 'State Government',
      'TAX'  // 'Taxi'
    ];

  set_unknownType_vehicle_codes := // NOTE: Not used below; for documentation only.
    [
      'BOT', // 'Boat'
      'EXT', // 'Exempt'
      'MOT', // 'Motorcycle'
      'OTH', // 'Other'
      'TRL', // 'Trailer',
      'UNK', // '', 
      'VAN', // 'Vanity'
      'XSR'  // NOTE: Reduced-fee registration and license plate; often used by non-profits in FL.
    ];
    
  VehiclesWithDetail := 
    JOIN(
      tbl_Vehicles_srtd, VehicleV2.Key_Vehicle_Main_Key,
      keyed(left.vehicle_key = right.vehicle_key AND
      LEFT.iteration_key = RIGHT.iteration_key),
      TRANSFORM( layout_Vehicles_slim,
        SELF.isPrivate    := (INTEGER)(LEFT.reg_license_plate_type_code IN set_private_vehicle_codes);
        SELF.isCommercial := (INTEGER)(LEFT.reg_license_plate_type_code IN set_commercial_vehicle_codes);
        SELF.isUnknown    := 0;
        SELF := RIGHT,
        SELF := LEFT,
        SELF := []
      ),
      INNER
    );

  VehiclesWithDetail_srtd := SORT( VehiclesWithDetail, seq, vehicle_key, -reg_latest_expiration_date );
  
  VehiclesWithDetail_rolled_pre :=
    ROLLUP(
      VehiclesWithDetail_srtd,
      TRANSFORM( layout_Vehicles_slim,
        SELF.reg_first_date              := (STRING) IF( (INTEGER)LEFT.reg_first_date != 0 AND (INTEGER)LEFT.reg_first_date < (INTEGER)RIGHT.reg_first_date, (INTEGER)LEFT.reg_first_date, (INTEGER)RIGHT.reg_first_date ),
        SELF.reg_earliest_effective_date := (STRING) IF( (INTEGER)LEFT.reg_earliest_effective_date != 0 AND (INTEGER)LEFT.reg_earliest_effective_date < (INTEGER)RIGHT.reg_earliest_effective_date, (INTEGER)LEFT.reg_earliest_effective_date, (INTEGER)RIGHT.reg_earliest_effective_date ),
        SELF.reg_latest_effective_date   := (STRING)MAX( (INTEGER)LEFT.reg_latest_effective_date, (INTEGER)RIGHT.reg_latest_effective_date ),
        SELF.reg_latest_expiration_date  := (STRING)MAX( (INTEGER)LEFT.reg_latest_expiration_date, (INTEGER)RIGHT.reg_latest_expiration_date ),
        SELF.vina_price                  := (STRING)MAX( (INTEGER)LEFT.vina_price, (INTEGER)RIGHT.vina_price ),
        // The first '1' wins for judging the type of vehicle. Evaluate all three types in each row 
        // by adding them together; they'll add up to 0 or 1. If they add up to 1, keep the row.
        SELF.isPrivate    := IF(LEFT.isPrivate + LEFT.isCommercial + LEFT.isUnknown = 1, LEFT.isPrivate, RIGHT.isPrivate),
        SELF.isCommercial := IF(LEFT.isPrivate + LEFT.isCommercial + LEFT.isUnknown = 1, LEFT.isCommercial, RIGHT.isCommercial),
        SELF.isUnknown    := IF(LEFT.isPrivate + LEFT.isCommercial + LEFT.isUnknown = 1, LEFT.isUnknown, RIGHT.isUnknown),
        SELF.vehicleValue := 0,
        SELF.minDate      := 0,
        SELF.maxDate      := 0,
        SELF := LEFT
      ),
      seq, vehicle_key
    );

  // If we were unable to identify the vehicle type as Private or Commercial in the rollup above, 
  // set it to isUnknown. Set also the registration minDate and maxDate so we can check for 
  // the vehicle as being an asset to the business at the time of the archive date.
  VehiclesWithDetail_rolled :=
    PROJECT(
      VehiclesWithDetail_rolled_pre,
      TRANSFORM( layout_Vehicles_slim,
        SELF.historyDateYYYYMMDD := 
          MAP( 
            LEFT.historyDate IN [0,999999,99999999,999999999999] => (UNSIGNED4)(((STRING)STD.Date.Today())[1..8]),
            LENGTH( (STRING)LEFT.historyDate ) >= 8 => (UNSIGNED4)(((STRING)(LEFT.historyDate))[1..8]),
            LENGTH( (STRING)LEFT.historyDate )  = 6 => (UNSIGNED4)((STRING)(LEFT.historyDate) + '01'),
            (UNSIGNED4)(((STRING)(LEFT.historyDate))[1..8])
          ),
        SELF.isAsset      := 1,
        SELF.isUnknown    := (INTEGER)(LEFT.isPrivate + LEFT.isCommercial = 0),
        SELF.vehiclevalue := (UNSIGNED6)LEFT.vina_price,
        SELF.minDate      := (UNSIGNED4)IF( (INTEGER)LEFT.reg_first_date != 0 AND (INTEGER)LEFT.reg_first_date < (INTEGER)LEFT.reg_earliest_effective_date, (INTEGER)LEFT.reg_first_date, (INTEGER)LEFT.reg_earliest_effective_date ),
        SELF.maxDate      := (UNSIGNED4)MAX( (INTEGER)LEFT.reg_latest_effective_date, (INTEGER)LEFT.reg_latest_expiration_date ),
        SELF := LEFT
      )
    );

  VehiclesWithDetail_filt := 
    VehiclesWithDetail_rolled( (historyDateYYYYMMDD BETWEEN minDate AND maxDate) );

  VehiclesWithDetail_rolled2 :=
    ROLLUP(
      VehiclesWithDetail_filt,
      TRANSFORM( layout_Vehicles_slim,
        SELF.isAsset      := LEFT.isAsset + RIGHT.isAsset,
        SELF.isPrivate    := LEFT.isPrivate + RIGHT.isPrivate,
        SELF.isCommercial := LEFT.isCommercial + RIGHT.isCommercial,
        SELF.isUnknown    := LEFT.isUnknown + RIGHT.isUnknown,
        SELF.vehiclevalue := LEFT.vehiclevalue + RIGHT.vehiclevalue,
        SELF := LEFT
      ),
      seq
    );
  
  layout_asset_vehicles_temp := RECORD
    UNSIGNED4 seq;
    STRING7 asset_vehicle_count;      // Number of vehicles currently registered to the business.
    STRING7 asset_vehicle_count_pers; // Number of personal vehicles currently registered to the business.
    STRING7 asset_vehicle_count_comm; // Number of commercial vehicles currently registered to the business.
    STRING7 asset_vehicle_count_oth;  // Number of other/unknown vehicles currently registered to the business.
    STRING9 asset_vehicle_value;      // Total value of vehicles currently registered to the business.
  END; 

  Vehicles_unrestricted :=
    JOIN(
      Shell, VehiclesWithDetail_rolled2,
      LEFT.seq = RIGHT.seq,
      TRANSFORM( layout_asset_vehicles_temp,
        SELF.seq := LEFT.seq;
        SELF.asset_vehicle_count      := IF( LEFT.seq = RIGHT.seq, (STRING)RIGHT.isAsset, '0' );          
        SELF.asset_vehicle_count_pers := IF( LEFT.seq = RIGHT.seq, (STRING)RIGHT.isPrivate, '0' );     
        SELF.asset_vehicle_count_comm := IF( LEFT.seq = RIGHT.seq, (STRING)RIGHT.isCommercial, '0' );     
        SELF.asset_vehicle_count_oth  := IF( LEFT.seq = RIGHT.seq, (STRING)RIGHT.isUnknown, '0' );      
        SELF.asset_vehicle_value      := IF( LEFT.seq = RIGHT.seq, (STRING)RIGHT.vehiclevalue, '0' );      
      ),
      LEFT OUTER, KEEP(1)
    );
    
  // According to Legal, we must set a value of '-2' if Vehicles are "turned off", presumably 
  // via DPPA value. 
  Vehicles_restricted :=
    JOIN(
      Shell, VehiclesWithDetail_rolled2,
      LEFT.seq = RIGHT.seq,
      TRANSFORM( layout_asset_vehicles_temp,
        SELF.seq := LEFT.seq;
        SELF.asset_vehicle_count      := '-2';          
        SELF.asset_vehicle_count_pers := '-2';     
        SELF.asset_vehicle_count_comm := '-2';     
        SELF.asset_vehicle_count_oth  := '-2';      
        SELF.asset_vehicle_value      := '-2';      
      ),
      LEFT OUTER, KEEP(1)
    );

  Vehicles_results :=
    IF( vehicles_are_turned_off, Vehicles_restricted, Vehicles_unrestricted );
  
  withVehicles := 
    JOIN(
      Shell, Vehicles_results, 
      LEFT.seq = RIGHT.seq,
      TRANSFORM( Business_Risk_BIP.Layouts.Shell,
        SELF.Asset_Information.AssetVehicleCount           := RIGHT.asset_vehicle_count,
        SELF.Asset_Information.AssetPersonalVehicleCount   := RIGHT.asset_vehicle_count_pers,
        SELF.Asset_Information.AssetCommercialVehicleCount := RIGHT.asset_vehicle_count_comm,
        SELF.Asset_Information.AssetOtherVehicleCount      := RIGHT.asset_vehicle_count_oth,
        SELF.Asset_Information.AssetTotalVehicleValue      := RIGHT.asset_vehicle_value,
        SELF := LEFT,
        SELF := []
      ),
      LEFT OUTER, KEEP(1)
    );
  
  // RETURN DATASET( [], Business_Risk_BIP.Layouts.Shell );
  // OUTPUT( VehiclesRaw, NAMED('VehiclesRaw') );
  // OUTPUT( VehiclesRaw_filt, NAMED('VehiclesRaw_filt') );
  // OUTPUT( VehiclesSeq, NAMED('VehiclesSeq') );
  // OUTPUT( Vehicles, NAMED('Vehicles') );
  // OUTPUT( Vehicles_srtd, NAMED('Vehicles_srtd') );
  // OUTPUT( tbl_Vehicles_srtd, NAMED('tbl_Vehicles_srtd') );
  // OUTPUT( VehiclesWithDetail_srtd, NAMED('VehiclesWithDetail_srtd') );
  // OUTPUT( VehiclesWithDetail_rolled_pre, NAMED('VehiclesWithDetail_rolled_pre') );
  // OUTPUT( VehiclesWithDetail_rolled, NAMED('VehiclesWithDetail_rolled') );
  // OUTPUT( VehiclesWithDetail_filt, NAMED('VehiclesWithDetail_filt') );
  // OUTPUT( VehiclesWithDetail_rolled2, NAMED('VehiclesWithDetail_rolled2') );
  // OUTPUT( Vehicles_unrestricted, NAMED('Vehicles_unrestricted') );
  // OUTPUT( Vehicles_results, NAMED('Vehicles_results') );
  
  RETURN withVehicles;
END;


// ------------[ JUNK, SPARE PARTS ]-------------

