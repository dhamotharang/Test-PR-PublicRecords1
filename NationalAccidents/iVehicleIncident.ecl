IMPORT Ecrash_Common;

  Layouts_NAccidentsInquiry.VEHICLE_INCIDENT tVehicleIncident(Files_NAccidentsInquiry.DS_SPRAY_VEHICLE_INCIDENT L) := TRANSFORM
    SELF.Vehicle_Incident_ID := TRIM(L.Vehicle_Incident_ID, LEFT, RIGHT);
    SELF.Order_ID            := TRIM(L.Order_ID, LEFT, RIGHT);
    SELF.Sequence_Nbr        := TRIM(L.Sequence_Nbr, LEFT, RIGHT);
    SELF.Report_Nbr          := TRIM(L.Report_Nbr, LEFT, RIGHT);
    SELF.Loss_Date           := TRIM(L.Loss_Date, LEFT, RIGHT);
    SELF.Loss_Time           := TRIM(L.Loss_Time, LEFT, RIGHT);
    SELF.Service_ID          := TRIM(L.Service_ID, LEFT, RIGHT);
    SELF.State_Abbr          := TRIM(L.State_Abbr, LEFT, RIGHT);
    SELF.Result_ID           := TRIM(L.Result_ID, LEFT, RIGHT);
    SELF.Last_Changed        := TRIM(L.Last_Changed, LEFT, RIGHT);
    SELF.UserID              := TRIM(L.UserID, LEFT, RIGHT);
    SELF                     := L;
    SELF                     := [];
  END;
  sUncleanVehicleIncident := PROJECT(Files_NAccidentsInquiry.DS_SPRAY_VEHICLE_INCIDENT, tVehicleIncident(LEFT));
  
  rmvHeaderVehicleIncident := sUncleanVehicleIncident(Vehicle_Incident_ID NOT IN Constants_NtlAccidentsInquiry.HdrVehicleIncident);

  Ecrash_Common.mac_CleanFields(rmvHeaderVehicleIncident, sVehicleIncidentClean);
  Ecrash_Common.mac_ConvertToUpperCase(sVehicleIncidentClean, sVehicleIncidentUpper);

  dVehicleIncident := DISTRIBUTE(sVehicleIncidentUpper, HASH32(Order_ID));

EXPORT iVehicleIncident := dVehicleIncident : PERSIST('~THOR::BASE::NTL_ACCIDENTS_INQUIRY::PERSIST::I_VEHICLE_INCIDENT');