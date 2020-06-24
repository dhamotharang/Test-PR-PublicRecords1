import FLAccidents_eCrash,codes,ut,AutoStandardI,iesp,Census_Data,suppress,Accident_services,lib_stringlib;

EXPORT Report_Records := MODULE

  // CLAIMS DISCOVERY AND MOBILETRAC REPORT
  export vertical(Accident_services.IParam.searchrecords in_mod) := function

    boolean isClaims := stringlib.StringToUpperCase(in_mod.ReportType)='CLAIMS';
    ntlAccRpt := iesp.national_accident.t_NationalAccidentReportAccident;

    UNSIGNED boundary := POWER(10,10);
    rptDesc(STRING code) := MAP(
      code = 'A' => 'Auto Accident',
      code = 'B' => 'Auto Theft',
      code = 'C' => 'Auto Theft Recovery',
      code = 'F' => 'Fire Car',
      code = 'FA' => 'Auto Accident',
      code = 'IA' => 'Auto Accident',
      code = 'EA' => 'Auto Accident',
      code = 'TF' => 'Auto Accident',
      '');

    ntlAccRpt crash4_xform(Accident_services.Layouts.raw_rec l,FLAccidents_eCrash.Key_eCrash4 r) := transform
        UNSIGNED accidentID := IF((integer)l.l_accnbr>boundary,(integer)l.l_accnbr-boundary,(integer)l.l_accnbr);
        self.ReportDescription := rptDesc(l.report_code);
        self.AccidentID := if(isClaims,(string)accidentID,'');
        self.AccidentDate := iesp.ECL2ESP.toDatestring8 ((String8) TRIM(l.accident_date,LEFT,RIGHT));
        self.Location.city := r.vehicle_incident_city;
        self.Location.state := r.vehicle_incident_st;
        string30 DamageLocation := if(isClaims,r.point_of_impact,'');
        self.Vehicles := dataset([{(integer)r.vehicle_year,r.make_description,r.model_description,r.vehicle_id_nbr,
            DamageLocation,r.carrier_name}],iesp.national_accident.t_NationalAccidentReportVehicle);
        self := [];
    end;

    ntlAccRpt crash2_xform(Accident_services.Layouts.raw_rec l,FLAccidents_eCrash.Key_eCrash2v r) := transform
        UNSIGNED accidentID := IF((integer)l.l_accnbr>boundary,(integer)l.l_accnbr-boundary,(integer)l.l_accnbr);
        self.ReportDescription := rptDesc(l.report_code);
        self.AccidentID := if(isClaims,(string)accidentID,'');
        self.AccidentDate := iesp.ECL2ESP.toDatestring8 ((String8) TRIM(l.accident_date,LEFT,RIGHT));
        self.Location.city := r.vehicle_incident_city;
        self.Location.state := r.vehicle_incident_st;
        string30 DamageLocation := if(isClaims,if(ut.isNumeric(r.point_of_impact),codes.KeyCodes('FLCRASH2_VEHICLE','POINT_OF_IMPACT','',r.point_of_impact),r.point_of_impact),'');
        self.Vehicles := dataset([{(integer)r.vehicle_year,r.make_description,r.model_description,r.vehicle_id_nbr,
            DamageLocation,r.carrier_name}],iesp.national_accident.t_NationalAccidentReportVehicle);
        self := [];
    end;

    recs := Accident_services.Functions.search_except_vin(in_mod) + Accident_services.Functions.search_vin(in_mod);
    accidentRecsWithState := project(recs,Layouts.raw_rec);

    // Apply state restrictions
    accRecsRestricted := Accident_services.StateRestrictionsFunctions.applyRestrictions(in_mod,accidentRecsWithState);
    rptCodeSet := if(in_mod.EnableExtraAccidents,Accident_services.constants.rptCodeSet+Accident_services.constants.eCrashAccident_source,Accident_services.constants.rptCodeSet);

    drivers := join(accRecsRestricted,FLAccidents_eCrash.Key_eCrash4,
        keyed(left.l_accnbr=right.l_acc_nbr) and left.vin=right.vehicle_id_nbr and right.report_code in rptCodeSet,
        crash4_xform(left,right),limit(Accident_services.Constants.MAX_RECS_ON_JOIN,skip));

    owners := join(accRecsRestricted,FLAccidents_eCrash.Key_eCrash2v,
        keyed(left.l_accnbr=right.l_acc_nbr) and left.vin=right.vehicle_id_nbr and right.report_code in rptCodeSet,
        crash2_xform(left,right),limit(Accident_services.Constants.MAX_RECS_ON_JOIN,skip));

    srtDedup := dedup(sort(drivers + owners,-AccidentDate,AccidentID,-Location.city,-Location.state,-Vehicles[1].DamageLocation),
      ReportDescription, AccidentDate.year, AccidentDate.month, AccidentDate.day, Location.city, Location.state, Vehicles[1].make, Vehicles[1].model, Vehicles[1].vin);

    return srtDedup;
     
  end;

  // ACCIDENT NUMBER REPORT
  EXPORT accidentNmbr(Accident_services.IParam.searchrecords in_mod) := FUNCTION

    accNbr0 := DATASET([],Accident_services.Layouts.report);
    accNbr1 := DATASET([{in_mod.Accident_Number,'',''}],Accident_services.Layouts.report);

    // get report code and vehicle incident state
    accNbr2 := JOIN(accNbr1,FLAccidents_eCrash.Key_eCrashV2_accnbrV1,
            KEYED(LEFT.accident_nbr=RIGHT.l_accnbr),
            TRANSFORM(Accident_services.Layouts.report,
              SELF.report_code:=RIGHT.report_code,
              SELF.vehicle_incident_st:=RIGHT.vehicle_incident_st,
              SELF:=LEFT),
            LEFT OUTER,KEEP(1),LIMIT(0));

    // Filter records where states require a DPPA permissible purpose
    accNbr3 := IF(in_mod.EnableNationalAccidents AND ~Accident_services.Functions.allowDPPA(),
      accNbr2(vehicle_incident_st NOT IN Accident_services.Constants.DPPA_States),accNbr2);

    ApplicationType := TRIM(stringlib.StringToUpperCase(in_mod.ApplicationType));
    allowableStates := SET(Accident_Services.StateRestrictionsFunctions.getRestrictions(ApplicationType),accidentState);

    // validate accident number
    nationalAccNbrs := IF(in_mod.EnableNationalAccidents AND in_mod.ApplicationType!='',
      accNbr3(report_code IN Constants.NtlAccident_source AND vehicle_incident_st IN allowableStates));
    eCrashAccNbrs := IF(in_mod.EnableExtraAccidents,accNbr3(report_code IN Constants.eCrashAccident_source));
    accNbrs := accNbr3(report_code IN Constants.FLAccident_source)+nationalAccNbrs+eCrashAccNbrs;

    // Key_eCrash2v (Vehicle/Owner)
    veh0 := JOIN(accNbrs,FLAccidents_eCrash.Key_eCrash2v,
            KEYED(LEFT.accident_nbr=RIGHT.l_acc_nbr),
            Accident_services.Transforms.vehicleOwner(LEFT,RIGHT,in_mod.mask_DL),LEFT OUTER,
            LIMIT(Accident_services.Constants.MAX_RECS_ON_JOIN,SKIP));

    // Key_eCrash3v (Towed Trailer)
    veh1 := JOIN(veh0,FLAccidents_eCrash.Key_eCrash3v,
            KEYED(LEFT.accident_nbr=RIGHT.l_acc_nbr) AND LEFT.vehicle=RIGHT.section_nbr,
            Accident_services.Transforms.addTowedTrailerInfo(LEFT,RIGHT),LEFT OUTER,
            LIMIT(Accident_services.Constants.MAX_RECS_ON_JOIN,SKIP));

    // Key_eCrash4 (Driver)
    veh2 := JOIN(veh1,FLAccidents_eCrash.Key_eCrash4,
            KEYED(LEFT.accident_nbr=RIGHT.l_acc_nbr) AND LEFT.vehicle=RIGHT.section_nbr,
            Accident_services.Transforms.addDriverInfo(LEFT,RIGHT,in_mod.mask_DL),LEFT OUTER,
            LIMIT(Accident_services.Constants.MAX_RECS_ON_JOIN,SKIP));

    // Key_eCrash5 (Passengers)
    pass := PROJECT(JOIN(veh2,FLAccidents_eCrash.Key_eCrash5,
            KEYED(LEFT.accident_nbr=RIGHT.l_acc_nbr) AND LEFT.vehicle=RIGHT.section_nbr,
            LIMIT(Accident_services.Constants.MAX_RECS_ON_JOIN,SKIP)),
            TRANSFORM(RECORDOF(FLAccidents_eCrash.Key_eCrash5),
            SELF.accident_nbr:=(STRING)LEFT.accident_nbr,SELF:=LEFT));

    // add passengers to vehicle record
    veh3 := DENORMALIZE(veh2,pass,LEFT.accident_nbr=RIGHT.l_acc_nbr AND LEFT.vehicle=RIGHT.section_nbr,GROUP,
            Accident_services.Transforms.addPassengerChildren(LEFT,ROWS(RIGHT)));

    // Key_eCrash0 (Location/DOT Info)
    rpt0 := JOIN(accNbrs,FLAccidents_eCrash.Key_eCrash0,
            KEYED(LEFT.accident_nbr=RIGHT.l_acc_nbr),
            Accident_services.Transforms.reportRecord(LEFT,RIGHT),LEFT OUTER,
            LIMIT(Accident_services.Constants.MAX_RECS_ON_JOIN,SKIP));

    // Key_eCrash1 (Time/Conditions/Investigation/Statistics)
    rpt1 := JOIN(rpt0,FLAccidents_eCrash.Key_eCrash1,
            KEYED(LEFT.accident_nbr=RIGHT.l_acc_nbr),
            Accident_services.Transforms.addTimeCondInvestStats(LEFT,RIGHT),LEFT OUTER,
            LIMIT(Accident_services.Constants.MAX_RECS_ON_JOIN,SKIP));

    // add vehicles to report record
    rpt2 := DENORMALIZE(rpt1,veh3,LEFT.accident_nbr=RIGHT.accident_nbr,GROUP,
            Accident_services.Transforms.addVehicleChildren(LEFT,ROWS(RIGHT)));

    // Key_eCrash6 (Pedestrians)
    peds := PROJECT(JOIN(accNbrs,FLAccidents_eCrash.Key_eCrash6,
            KEYED(LEFT.accident_nbr=RIGHT.l_acc_nbr),
            LIMIT(Accident_services.Constants.MAX_RECS_ON_JOIN,SKIP)),
            TRANSFORM(RECORDOF(FLAccidents_eCrash.Key_eCrash6),
            SELF.accident_nbr:=(STRING)LEFT.accident_nbr,SELF:=LEFT));

    // add pedestrians to report record
    rpt3 := DENORMALIZE(rpt2,peds,LEFT.accident_nbr=RIGHT.l_acc_nbr,GROUP,
            Accident_services.Transforms.addPedestrianChildren(LEFT,ROWS(RIGHT),in_mod.mask_DL));

    // Key_eCrash7 (Property Damage)
    prop := PROJECT(JOIN(accNbrs,FLAccidents_eCrash.Key_eCrash7,
            KEYED(LEFT.accident_nbr=RIGHT.l_acc_nbr),
            LIMIT(Accident_services.Constants.MAX_RECS_ON_JOIN,SKIP)),
            TRANSFORM(RECORDOF(FLAccidents_eCrash.Key_eCrash7),
            SELF.accident_nbr:=(STRING)LEFT.accident_nbr,SELF:=LEFT));

    // add property damage to report record
    rpt4 := PROJECT(DENORMALIZE(rpt3,prop,LEFT.accident_nbr=RIGHT.l_acc_nbr,GROUP,
            Accident_services.Transforms.addPropertyDamageChildren(LEFT,ROWS(RIGHT))),
            iesp.accident.t_AccidentReportRecord);

    RETURN rpt4;
  END;

END;
