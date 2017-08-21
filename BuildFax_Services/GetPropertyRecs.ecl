import BuildFax;

EXPORT GetPropertyRecs(DATASET(Layout_BuildFax.seq_input_rec) input) := FUNCTION

// Send input addresses through address cleaner
cleanaddr := CleanAddress(input);

// Format address for input into key read
addrinput := PROJECT(cleanaddr,
                     TRANSFORM(Layout_Buildfax.property_key_rec,
					                     self := left.address,
										           self.sequence := left.input.internal_seq));

// Keyed join to obtain Property records
candidates 	    := KeyedJoins.GetPropRecs(addrinput);
dedupCandidates := DEDUP(SORT(candidates,sequence,id),sequence,id);
														
// Further filter by postdir and address suffix
properties 	:= JOIN( cleanaddr,  dedupcandidates, 
												          left.input.internal_seq  = right.sequence AND
																  left.address.addr_suffix = right.addr_suffix,
												Transform(Layout_BuildFax.output_rec, 
														self.rectype      := IF(right.id<>'',constants.RecordTypes.Properties,constants.RecordTypes.NotFound),
														self.errorcode    := IF(right.id ='' AND left.errorcode='',constants.NotFound,left.errorcode);
                            self.address      := IF(right.id<>'',right),
														self.input        := left.input,
														self.property     := IF(right.id<>'',right),
														self              := left,
														self := []),LEFT OUTER);

RETURN properties;
END;



