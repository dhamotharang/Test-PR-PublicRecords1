IMPORT Accident_StateRes,ut,Accident_services, lib_stringlib;

EXPORT StateRestrictionsFunctions := MODULE

EXPORT getRestrictions (STRING in_appType,STRING in_state='') := FUNCTION

  appType := stringlib.stringtouppercase(in_appType);
  state := stringlib.stringtouppercase(in_state);

  Accident_services.Layouts.AccidentStateRestrictionReportRecord getRequiredInput
  (Accident_StateRes.Key_StResReport L, DATASET(RECORDOF(Accident_StateRes.Key_StResInput)) R) := TRANSFORM
    SELF.RequiredInputs := CHOOSEN(PROJECT(R,Accident_services.Layouts.AccidentInputRequired),Accident_services.Constants.MAX_REQUIRED_INPUTS);
    SELF := L;
  END;

  StResByAppTyp := DENORMALIZE(
    Accident_StateRes.Key_StResReport(KEYED(ApplicationType=appType)),
    Accident_StateRes.Key_StResInput(KEYED(ApplicationType=appType)),
    LEFT.AccidentState=RIGHT.AccidentState,
    GROUP,getRequiredInput(LEFT,ROWS(RIGHT)));
  
  RETURN (IF(state!='',StResByAppTyp(AccidentState=state),StResByAppTyp));
END;

// true if inputDataFields or inputDataField present in RequiredInputs
EXPORT BOOLEAN hasRequiredInput (DATASET(Accident_services.Layouts.AccidentInputRequired) RequiredInputs,
  UNSIGNED inputDataFields) := FUNCTION

  BOOLEAN isEmptyDS := ~EXISTS(RequiredInputs);
  RETURN isEmptyDS or (EXISTS(RequiredInputs(bitmap & inputDataFields = bitmap)));
END;

EXPORT applyRestrictions(Accident_Services.IParam.searchRecords in_mod,
  DATASET(Accident_Services.Layouts.raw_rec) accRecs) := FUNCTION

  applicationType := stringlib.StringToUpperCase(in_mod.applicationType);
  restrictionsRpt := getRestrictions(applicationType)(Allowed IN ['Y','R']);
  allowableStates := SET(restrictionsRpt,accidentState);

  // set input bitmap
  UNSIGNED bDOL := IF(in_mod.AccidentDate!=0,Constants.DOL,0);
  UNSIGNED bNAME := IF((in_mod.FirstName!='' AND in_mod.LastName!='') OR in_mod.unparsedFullName!='' OR in_mod.companyname!='',Constants.NAME,0);
  BOOLEAN hasAddr := (in_mod.prim_range!='' AND in_mod.prim_name!='') OR in_mod.addr!='';
  BOOLEAN isPoBox := stringlib.StringToUpperCase(in_mod.prim_name[1..7]) = 'PO BOX ';
  BOOLEAN isRRTyp := stringlib.StringToUpperCase(in_mod.prim_name[1..3]) IN ['RR ','HC '];
  BOOLEAN hasCSZ := (in_mod.city!='' AND in_mod.state!='') OR in_mod.zip!='';
  UNSIGNED bADDR := IF((hasAddr AND hasCSZ) OR (isRRTyp AND hasCSZ) OR (isPoBox AND hasCSZ),Constants.ADDR,0);
  UNSIGNED bVIN := IF(in_mod.VIN!='',Constants.VIN,0);
  UNSIGNED bDLNBR := IF(in_mod.DriverLicenseNumber!='',Constants.DLNBR,0);
  UNSIGNED bTAG := IF(in_mod.Tag_Number!='',Constants.TAG,0);
  UNSIGNED bINPUT := bDOL + bNAME + bADDR + bVIN + bDLNBR + bTAG;

  // filter allowable states
  accRecs1 := accRecs(vehicle_incident_st IN allowableStates);

  // filter required input states
  Accident_Services.Layouts.raw_rec filterByRequiredInput(Accident_Services.Layouts.raw_rec L) := TRANSFORM
    RequiredInputs := restrictionsRpt(accidentState=L.vehicle_incident_st).RequiredInputs;
    SELF.report_code := IF(hasRequiredInput(RequiredInputs,bINPUT),L.report_code,SKIP);
    SELF := L;
  END;

  accRecs2 := PROJECT(accRecs1,filterByRequiredInput(LEFT));

  // filter date of loss in range
  Accident_Services.Layouts.raw_rec filterByDOLinRange(Accident_Services.Layouts.raw_rec L) := TRANSFORM
    UNSIGNED4 minAccidentDate := (UNSIGNED4)ut.date_math((STRING)in_mod.AccidentDate,-accident_services.Constants.DOLRNG);
    UNSIGNED4 maxAccidentDate := (UNSIGNED4)ut.date_math((STRING)in_mod.AccidentDate,accident_services.Constants.DOLRNG);
    RequiredInputs := restrictionsRpt(accidentState=L.vehicle_incident_st).RequiredInputs;
    BOOLEAN dolReq := (bDOL != 0) and hasRequiredInput(RequiredInputs,bINPUT);
    BOOLEAN dolInRange := (UNSIGNED4)L.accident_date BETWEEN minAccidentDate AND maxAccidentDate;
    SELF.report_code := IF(dolReq AND ~dolInRange,SKIP,L.report_code);
    SELF := L;
  END;

  accRecs3 := PROJECT(accRecs2,filterByDOLinRange(LEFT));

  // restrict outputs
  Accident_Services.Layouts.raw_rec restrictOutputs(Accident_Services.Layouts.raw_rec L) := TRANSFORM
    RestrictedOutput := restrictionsRpt(accidentState=L.vehicle_incident_st)[1].RestrictedOutputBitmap;
    BOOLEAN restrictDOL := Constants.DOL & RestrictedOutput = Constants.DOL;
    BOOLEAN restrictNAME := Constants.NAME & RestrictedOutput = Constants.NAME;
    BOOLEAN restrictADDR := Constants.ADDR & RestrictedOutput = Constants.ADDR;
    BOOLEAN restrictVIN := Constants.VIN & RestrictedOutput = Constants.VIN;
    BOOLEAN restrictDLNBR := Constants.DLNBR & RestrictedOutput = Constants.DLNBR;
    BOOLEAN restrictTAG := Constants.TAG & RestrictedOutput = Constants.TAG;
    SELF.accident_date := IF(restrictDOL,'',L.accident_date);
    SELF.title := IF(restrictNAME,'',L.title);
    SELF.fname := IF(restrictNAME,'',L.fname);
    SELF.mname := IF(restrictNAME,'',L.mname);
    SELF.lname := IF(restrictNAME,'',L.lname);
    SELF.name_suffix := IF(restrictNAME,'',L.name_suffix);
    SELF.cname := IF(restrictNAME,'',L.cname);
    SELF.prim_range := IF(restrictADDR,'',L.prim_range);
    SELF.predir := IF(restrictADDR,'',L.predir);
    SELF.prim_name := IF(restrictADDR,'',L.prim_name);
    SELF.addr_suffix := IF(restrictADDR,'',L.addr_suffix);
    SELF.postdir := IF(restrictADDR,'',L.postdir);
    SELF.unit_desig := IF(restrictADDR,'',L.unit_desig);
    SELF.sec_range := IF(restrictADDR,'',L.sec_range);
    SELF.v_city_name := IF(restrictADDR,'',L.v_city_name);
    SELF.st := IF(restrictADDR,'',L.st);
    SELF.zip := IF(restrictADDR,'',L.zip);
    SELF.zip4 := IF(restrictADDR,'',L.zip4);
    SELF.vin := IF(restrictVIN,'',L.vin);
    SELF.driver_license_nbr := IF(restrictDLNBR,'',L.driver_license_nbr);
    SELF.dlnbr_st := IF(restrictDLNBR,'',L.dlnbr_st);
    SELF.tag_nbr := IF(restrictTAG,'',L.tag_nbr);
    SELF.tagnbr_st := IF(restrictTAG,'',L.tagnbr_st);
    SELF := L;
  END;

  RETURN(PROJECT(accRecs3,restrictOutputs(LEFT)));
END;

END;
