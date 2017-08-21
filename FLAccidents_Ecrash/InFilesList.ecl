export InFilesList := function

IncidentfileList           := FileServices.RemoteDirectory( Constants.LandingZone,  Constants.ProcessPathForIncident, Constants.IncidentFileMask):INDEPENDENT;
PersonfileList           := FileServices.RemoteDirectory( Constants.LandingZone,  Constants.ProcessPathForPerson, Constants.PersonFileMask):INDEPENDENT;
VehiclefileList           := FileServices.RemoteDirectory( Constants.LandingZone,  Constants.ProcessPathForVehicle, Constants.VehicleFileMask):INDEPENDENT;
CommercialfileList           := FileServices.RemoteDirectory( Constants.LandingZone,  Constants.ProcessPathForCommercial, Constants.CommercialFileMask):INDEPENDENT;
CitationfileList           := FileServices.RemoteDirectory( Constants.LandingZone,  Constants.ProcessPathForCitation, Constants.CitationFileMask):INDEPENDENT;

InListSpy := output(IncidentfileList,named('Incident_File_List'));
PerListSpy := output(PersonfileList,named('Person_File_List'));
VehListSpy := output(VehiclefileList,named('Vehicle_File_List'));
CommListSpy := output(CommercialfileList,named('Commercial_File_List'));
CitListSpy := output(CitationfileList,named('Citation_File_List'));

return sequential(InListSpy,PerListSpy,VehListSpy,CommListSpy,CitListSpy);
end;