/*--SOAP--
<message name="PickerService">
  <part name="MakeAbbreviation" type="xsd:string"/>
  <part name="ExcludeAutomobiles" type="xsd:boolean" />
  <part name="ExcludeLightTrucks" type="xsd:boolean" />
  <part name="ExcludeHeavyTrucks" type="xsd:boolean" />
  <part name="ExcludeMotorcycles" type="xsd:boolean" />
</message>
*/

EXPORT PickerService := MACRO

  UNSIGNED AUTOMOBILES := 1;
  UNSIGNED LIGHTTRUCKS := 2;
  UNSIGNED HEAVYTRUCKS := 4;
  UNSIGNED MOTORCYCLES := 8;

  BOOLEAN ExcludeAutomobiles := FALSE : STORED('ExcludeAutomobiles');
  BOOLEAN ExcludeLightTrucks := FALSE : STORED('ExcludeLightTrucks');
  BOOLEAN ExcludeHeavyTrucks := FALSE : STORED('ExcludeHeavyTrucks');
  BOOLEAN ExcludeMotorcycles := FALSE : STORED('ExcludeMotorcycles');
  
  typeBitmap :=
    IF(ExcludeAutomobiles,0,AUTOMOBILES)+
    IF(ExcludeLightTrucks,0,LIGHTTRUCKS)+
    IF(ExcludeHeavyTrucks,0,HEAVYTRUCKS)+
    IF(ExcludeMotorcycles,0,MOTORCYCLES);

  STRING4 makeAbbreviation := '' : STORED('MakeAbbreviation');
  OUTPUT(VehicleV2_Services.PickerRecords(typeBitmap,makeAbbreviation),NAMED('Results'));

ENDMACRO;
// PickerService();
