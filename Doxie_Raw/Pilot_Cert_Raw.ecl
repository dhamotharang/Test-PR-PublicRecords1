//============================================================================
// Attribute: Pilot_Cert_Raw.  Used by view source service and comp-report.
// Function to get pilot certificate records by did.  Based on doxie.pilot_cert_records.
// Return value: Dataset of layout doxie_crs/layout_pilot_cert_records.
//============================================================================

import doxie_crs, Doxie, fcra, FaaV2_PilotServices, FFD;

export Pilot_Cert_Raw(
    dataset(Doxie.layout_references) dids, 
    unsigned3 dateVal = 0,
    boolean IsFCRA = false,
    dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
		dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim, 
		integer8 inFFDOptionsMask = 0 
) := FUNCTION

// raw records; on FCRA side corrections are already applied.
ar := Doxie_Raw.Pilot_Raw (dids, dateVal, , , , IsFCRA, flagfile); // should we refactor to also receive uniqueids as parameter and bypass this call?

arr := record
  ar.unique_id;
end;
  
t := dedup(table(ar,arr),unique_id,all);
in_uids := project(t,transform(faav2_PilotServices.Layouts.pilotUniqueIDPlus,self:=Left,self:=[]));

certs:= FaaV2_PilotServices.Raw.getRawCert(in_uids, IsFCRA, flagfile, dateval, slim_pc_recs, inFFDOptionsMask);
cert_raw := project(certs,doxie_crs.layout_pilot_cert_records);

outFile := sort(cert_raw,case(current_flag, 'A' => 1, 'H' => 2, 3));

return outFile;
END;

