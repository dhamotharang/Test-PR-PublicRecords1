import BuildFax;

EXPORT KeyedJoins := MODULE

// Property Keyed Join
export GetPropRecs (DATASET(Layout_BuildFax.property_key_rec) addresses) := FUNCTION 
  PropertyRecs := JOIN( addresses,  BuildFax.Key_Property_Address(), 
												keyed(  left.city        = right.city       AND
												        left.st          = right.st         AND
																left.zip         = right.zip        AND
																left.prim_name   = right.prim_name  AND
																left.prim_range  = right.prim_range),
												Transform(Layout_BuildFax.Layout_Property, 
														self := IF(right.id<>'',ROW(right,BuildFax.Layout.Property_slim)),
														self := left,
														self := []));
  return PropertyRecs;
end;

// Contractor Keyed Join
export GetContractorRecs (DATASET(Layout_BuildFax.buildfax_key_rec) ids) := FUNCTION 
  ContractorRecs := JOIN( ids,  BuildFax.Key_CONTRACTOR(), 
												keyed(  left.id = right.ID),
												Transform(Layout_BuildFax.Layout_Contractor, 
														self := ROW(right,BuildFax.Layout.Contractor_slim),
														self := left, 
														self := [])); 
  return ContractorRecs;
end;

// Correction Keyed Join
export GetCorrectionRecs (DATASET(Layout_BuildFax.buildfax_key_rec) ids) := FUNCTION 
  CorrectionRecs := JOIN( ids,  BuildFax.Key_Correction(), 
												keyed(  left.id = right.ID),
												Transform(Layout_BuildFax.Layout_Correction, 
														self := ROW(right,BuildFax.Layout.Correction),
														self := left, 
														self := []));  
  return CorrectionRecs;
end;

// Inspection Keyed Join
export GetInspectionRecs (DATASET(Layout_BuildFax.buildfax_key_rec) ids) := FUNCTION 
  InspectionRecs := JOIN( ids,  BuildFax.Key_Inspection(), 
												keyed(  left.id = right.ID),
												Transform(Layout_BuildFax.Layout_Inspection, 
														self := ROW(right,BuildFax.Layout.Inspection_slim),
														self := left,
														self := []));
	return InspectionRecs;
end;

// Permit Keyed Join
export GetPermitRecs (DATASET(Layout_BuildFax.buildfax_key_rec) ids) := FUNCTION 
  PermitRecs := JOIN( ids,  BuildFax.Key_Permit(), 
												keyed(  left.id = right.ID),
												Transform(Layout_BuildFax.Layout_Permit, 
														self.Permit := ROW(right,BuildFax.Layout.Permit_slim),
														self := left,
														self := []));  
  return PermitRecs;
end;

// PermitContractor Keyed Join
export GetPermitContractorRecs (DATASET(Layout_BuildFax.buildfax_key_rec) ids) := FUNCTION 
  PermitContractorRecs := JOIN( ids,  BuildFax.Key_PermitContractor(), 
												keyed(  left.id = right.ID),
												Transform(Layout_BuildFax.Layout_PermitContractor, 
														self := ROW(right,BuildFax.Layout.PermitContractor),
														self := left,
														self := [])); 
  return PermitContractorRecs;
end;

// Street Lookup Keyed Join
export GetStreetLookupRecs (DATASET(Layout_BuildFax.streetlookup_key_rec) addresses) := FUNCTION
  StreetLookupRecs := JOIN( addresses,  BuildFax.Key_streetlookup(), 
												keyed(  left.city        = right.city       AND
												        left.state       = right.state      AND
																right.zip        = right.zip        AND
																left.street      = right.street),
												Transform(Layout_BuildFax.Layout_StreetLookup, 
														self := ROW(right,BuildFax.Layout.StreetLookup),
														self := left,
														self := [])); 
  return StreetLookupRecs;
end;

// Jurisdiction Keyed Join
export GetJurisdictionRecs (DATASET(Layout_BuildFax.jurisdiction_key_rec) jurisdictions) := FUNCTION 
  JurisdictionRecs := JOIN( jurisdictions,  BuildFax.Key_Jurisdiction(), 
												keyed(  left.jurisdiction = right.jurisdiction),
												Transform(Layout_BuildFax.Layout_Jurisdiction, 
														self := ROW(right,BuildFax.Layout.Jurisdiction),
														self := left,
														self := [])); 
  return DEDUP(JurisdictionRecs,jurisdiction);
end;
						
END;



