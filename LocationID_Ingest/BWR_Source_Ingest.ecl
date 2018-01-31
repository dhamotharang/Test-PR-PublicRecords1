import AID, LocationId_Ingest;

addressData := AID.Files.ACECacheProd;

ingestInput := project(addressData, 
                       transform(LocationId_Ingest.Layouts.Linking_Interface,
											           self                  := left,
																 self.rid              := 0,
																 self.LocId            := 0,
																 self.source           := 'CA',
																 self.dt_first_seen    := (unsigned8) left.dateseenfirst,
																 self.dt_last_seen     := (unsigned8) left.dateseenlast,
																 self.zip              := left.zip5,
																 self.source_record_id := left.aid));

output(ingestInput,,'~kdw::LocationId::AS_Header',overwrite,compressed);