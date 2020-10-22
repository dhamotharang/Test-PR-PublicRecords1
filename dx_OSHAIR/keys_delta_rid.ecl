IMPORT doxie, data_services;

EXPORT keys_delta_rid := MODULE

SHARED inFile := Layouts.Layout_Delta_Rid;

EXPORT Accident            := INDEX({inFile.record_sid}, {inFile}, names().delta_rid_accident);
EXPORT Autokey_Payload     := INDEX({inFile.record_sid}, {inFile}, names().delta_rid_autokey_payload);
EXPORT Hazardous_Substance := INDEX({inFile.record_sid}, {inFile}, names().delta_rid_hazardous_substance);
EXPORT Inspection          := INDEX({inFile.record_sid}, {inFile}, names().delta_rid_inspection);
EXPORT Program             := INDEX({inFile.record_sid}, {inFile}, names().delta_rid_program);
EXPORT Violations          := INDEX({inFile.record_sid}, {inFile}, names().delta_rid_violations);

END;
