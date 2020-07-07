IMPORT VINA;

EXPORT PickerRecords(UNSIGNED TypeBitmap=15,STRING4 makeAbbreviation='') := FUNCTION;

  UNSIGNED AUTOMOBILES := 1;
  UNSIGNED LIGHTTRUCKS := 2;
  UNSIGNED HEAVYTRUCKS := 4;
  UNSIGNED MOTORCYCLES := 8;

  allVinaRecs := IF(makeAbbreviation='',
    VINA.Derived.Models(VINA.key_vin),
    VINA.Derived.Models(VINA.key_vin(make_abbreviation=makeAbbreviation)));

  truckRollup := ROLLUP(allVinaRecs(vehicle_type='T'),
    LEFT.make_abbreviation=RIGHT.make_abbreviation AND
    LEFT.series_abbreviation=RIGHT.series_abbreviation AND
    LEFT.body_type=RIGHT.body_type,
    TRANSFORM(RECORDOF(allVinaRecs),
      SELF.gvw := MIN(LEFT.gvw,RIGHT.gvw),
      SELF := LEFT));
  // allTruckRecs := allVinaRecs(vehicle_type='T');
  allTruckRecs := PROJECT(truckRollup,
    TRANSFORM(RECORDOF(allVinaRecs),
      SELF.vehicle_type := IF(LEFT.gvw<'3' OR
        LEFT.make_abbreviation='HUMM','L',LEFT.vehicle_type),
      SELF := LEFT));

  automobileRecs := allVinaRecs(vehicle_type='P');
  lightTruckRecs := allTruckRecs(vehicle_type='L');
  heavyTruckRecs := allTruckRecs(vehicle_type='T');
  motorcycleRecs := allVinaRecs(vehicle_type='M');

  vinaRecs :=
    IF(TypeBitmap&AUTOMOBILES!=0,automobileRecs)+
    IF(TypeBitmap&LIGHTTRUCKS!=0,lightTruckRecs)+
    IF(TypeBitmap&HEAVYTRUCKS!=0,heavyTruckRecs)+
    IF(TypeBitmap&MOTORCYCLES!=0,motorcycleRecs);

  makRec := RECORD
    vinaRecs.make_abbreviation;
    vinaRecs.make_name;
    UNSIGNED8 total := COUNT(GROUP);
  END;
  
  makTypModBodRec := RECORD
    vinaRecs.make_abbreviation;
    vinaRecs.make_name;
    vinaRecs.vehicle_type;
    vinaRecs.derived_model_code;
    vinaRecs.derived_model;
    vinaRecs.body_type;
    vinaRecs.full_body_style_name;
    UNSIGNED8 total := COUNT(GROUP);
  END;

  typRec := RECORD
    vinaRecs.vehicle_type;
  END;
  
  typModBodRec := RECORD(typRec)
    vinaRecs.derived_model_code;
    vinaRecs.derived_model;
    vinaRecs.body_type;
    vinaRecs.full_body_style_name;
  END;

  modRec := RECORD
    vinaRecs.derived_model_code;
    vinaRecs.derived_model;
  END;
  
  modBodRec := RECORD(modRec)
    vinaRecs.body_type;
    vinaRecs.full_body_style_name;
  END;

  bodyRec := RECORD
    STRING2 code {XPATH('Code')}; // VINA.key_vin.body_type
    STRING20 body {XPATH('Body')}; // VINA.key_vin.full_body_style_name
  END;

  modelBodyRec := RECORD
    STRING6 code {XPATH('Code')}; // VINA.Derived.Model.derived_model_code
    STRING25 model {XPATH('Model')}; // VINA.Derived.Model.derived_model
    DATASET(bodyRec) bodys {XPATH('Bodys/Body'), MAXCOUNT(999)};
  END;

  typeModelRec := RECORD
    STRING1 code {XPATH('Code')}; // VINA.key_vin.vehicle_type
    STRING12 Type {XPATH('Type')}; // P=passenger,T=truck,M=motorcycle
    DATASET(modelBodyRec) models {XPATH('Model/Models'), MAXCOUNT(999)};
  END;

  makeTypeRec := RECORD
    STRING4 code {XPATH('Code')}; // VINA.key_vin.make_abbreviation
    STRING35 make {XPATH('Make')}; // VINA.key_vin.make_name
    DATASET(typeModelRec) types {XPATH('Type/Types'), MAXCOUNT(999)};
  END;

  modelBodyRec denormModelBody(modRec L,DATASET(modBodRec) R) := TRANSFORM
    SELF.code := L.derived_model_code;
    SELF.model := L.derived_model;
    SELF.bodys := SORT(PROJECT(R,TRANSFORM(bodyRec,SELF.code:=LEFT.body_type,SELF.body:=LEFT.full_body_style_name)),body);
  END;

  typeModelRec denormTypeModel(typRec L,DATASET(typModBodRec) R) := TRANSFORM
    SELF.code := L.vehicle_type;
    SELF.type := MAP(L.vehicle_type='P'=>'PASSENGER',L.vehicle_type='L'=>'LIGHT TRUCK',L.vehicle_type='M'=>'MOTORCYCLE',L.vehicle_type='T'=>'HEAVY TRUCK','');
    SELF.models := DENORMALIZE(DEDUP(SORT(PROJECT(R,modRec),RECORD),RECORD),
      PROJECT(R,modBodRec),LEFT.derived_model=RIGHT.derived_model,GROUP,denormModelBody(LEFT,ROWS(RIGHT)));
  END;

  makeTypeRec denormMakeTypes(makRec L,DATASET(makTypModBodRec) R) := TRANSFORM
    SELF.code := L.make_abbreviation;
    SELF.make := L.make_name;
    SELF.types := DENORMALIZE(DEDUP(SORT(PROJECT(R,typRec),RECORD),RECORD),
      PROJECT(R,typModBodRec),LEFT.vehicle_type=RIGHT.vehicle_type,GROUP,denormTypeModel(LEFT,ROWS(RIGHT)));
  END;

  makRecs := TABLE(vinaRecs,makRec,make_abbreviation,make_name,FEW);
  makTypModBodRecs := TABLE(vinaRecs,makTypModBodRec,make_abbreviation,make_name,vehicle_type,derived_model,derived_model_code,body_type,full_body_style_name,FEW);

  results := DENORMALIZE(makRecs,makTypModBodRecs,LEFT.make_abbreviation=RIGHT.make_abbreviation,GROUP,denormMakeTypes(LEFT,ROWS(RIGHT)));

  RETURN results;
END;
