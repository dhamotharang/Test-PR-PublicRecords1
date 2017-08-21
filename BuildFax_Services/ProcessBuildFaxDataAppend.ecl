import BuildFax,ut;

EXPORT ProcessBuildFaxDataAppend(DATASET(Layout_BuildFax.input_rec) input) := FUNCTION

currdate := stringlib.GetDateYYYYMMDD();

//-----------------------------------------------------------------------------------------------------------
// Add internal sequence to input file to later append results
//-----------------------------------------------------------------------------------------------------------
sequenced  := PROJECT(input,
                      TRANSFORM(Layout_BuildFax.seq_input_rec,
											          SELF.internal_seq := (string) COUNTER,
																SELF := LEFT));

//-----------------------------------------------------------------------------------------------------------
// Get BuildFax records
//-----------------------------------------------------------------------------------------------------------
// Property - Keyed by address
properties := GetPropertyRecs(sequenced);
validProps := properties(rectype = constants.RecordTypes.Properties);
														
// Project out the ids to read other keys
ids := PROJECT(validProps,
                      TRANSFORM(Layout_BuildFax.buildfax_key_rec,
											          self.sequence := left.input.internal_seq,
                                self.id := left.property.id,																
																self := left));
																
// Project out the addresses to get the jurisdiction
addresses := PROJECT(validProps,
                      TRANSFORM(Layout_BuildFax.streetlookup_key_rec,
											          self.sequence := left.input.internal_seq,
                                self.STREET   := IF(left.address.PREDIR=     '','',TRIM(left.address.PREDIR) + ' ') +
																                 IF(left.address.PRIM_NAME=  '','',TRIM(left.address.PRIM_NAME) + ' ') +
																                 IF(left.address.ADDR_SUFFIX='','',TRIM(left.address.ADDR_SUFFIX) + ' ') +
																                 TRIM(left.address.POSTDIR),
	                              self.state    := left.address.st,
																self          := left.address));

// Jurisdiction - street lookup file keyed by address; jurisdiction file keyed by jurisdiction 
jurisdictionsds      := GetJurisdictions(addresses);
dedupjurisdictionsds := DEDUP(SORT(jurisdictionsds,sequence,jurisdiction),sequence,jurisdiction);
jurisdictions        := JOIN( validProps, dedupjurisdictionsds, 
												left.input.internal_seq = right.sequence,
												Transform(Layout_BuildFax.output_rec, 
														self.Jurisdiction := right,
														self.rectype      := constants.RecordTypes.Jurisdictions,
														self 							:= left, 
														self := [])); 
dedupjurisdictions   := DEDUP(SORT(jurisdictions,input.internal_seq,Jurisdiction.Jurisdiction),input.internal_seq,Jurisdiction.Jurisdiction);
lastjurisdictions    := DEDUP(SORT(jurisdictions,input.internal_seq,-jurisdiction.exclusionmindate),input.internal_seq);

// Contractor - keyed by id
contractors 	:= JOIN( validProps,  KeyedJoins.GetContractorRecs(ids), 
												left.input.internal_seq = right.sequence AND
												left.property.id = right.id,
												Transform(Layout_BuildFax.output_rec, 
														self.Contractor   := right,
														self.rectype      := constants.RecordTypes.Contractors,
														self 							:= left, 
														self := [])); 

// Correction - keyed by id
corrections 	:= JOIN( validProps,  KeyedJoins.GetCorrectionRecs(ids), 
												left.input.internal_seq = right.sequence AND
												left.property.id = right.id,
												Transform(Layout_BuildFax.output_rec, 
														self.Correction   := right,
														self.rectype      := constants.RecordTypes.Corrections,
														self 							:= left, 
														self := [])); 

// Inspection - keyed by id
inspections 	:= JOIN( validProps,  KeyedJoins.GetInspectionRecs(ids), 
												left.input.internal_seq = right.sequence AND
												left.property.id = right.id,
												Transform(Layout_BuildFax.output_rec, 
														self.Inspection   := right,
														self.rectype      := constants.RecordTypes.Inspections,
														self 							:= left,
														self := [])); 

// Permit - keyed by id
permitDS      := KeyedJoins.GetPermitRecs(ids);
permits 	    := JOIN( validProps,  permitDS, 
												left.input.internal_seq = right.sequence AND
												left.property.id = right.Permit.id,
												Transform(Layout_BuildFax.output_rec, 
														self.Permit       := right.Permit,
														self.rectype      := constants.RecordTypes.Permits,
														self 							:= left,
														self := []));

// PermitContractor - keyed by id
permitcontractors 	:= JOIN( validProps,  KeyedJoins.GetPermitContractorRecs(ids), 
												left.input.internal_seq = right.sequence AND
												left.property.id = right.id,
												Transform(Layout_BuildFax.output_rec, 
														self.PermitContractor := right,
														self.rectype      := constants.RecordTypes.PermitContractors,
														self 							:= left,
														self := []));
														
//-----------------------------------------------------------------------------------------------------------
// Build Calculation Records
//-----------------------------------------------------------------------------------------------------------
Ages := CalcAges(sequenced,permitDS,dedupjurisdictionsds);
calculations := JOIN(validProps, Ages,
                       left.input.internal_seq = right.sequence AND
											 left.property.id = right.id,
                       transform(Layout_BuildFax.output_rec,
											      self.Calculation  := ROW(right,Layout_BuildFax.layout_calcages),
														self.rectype      := constants.RecordTypes.Calculations,
														self 							:= left,
														self := [])); 		

//-----------------------------------------------------------------------------------------------------------
// sort outputs from prior steps
//-----------------------------------------------------------------------------------------------------------
allResults           := contractors  + corrections + inspections + permits + permitContractors + properties + calculations + dedupjurisdictions;
resultswJurisdiction := JOIN(allResults,lastjurisdictions,
                            left.input.internal_seq = right.input.internal_seq,
														TRANSFORM(recordof(left),
														mindate := right.Jurisdiction.ExclusionMinDate[1..4] + 
														           right.Jurisdiction.ExclusionMinDate[6..7] +
																			 right.Jurisdiction.ExclusionMinDate[9..10];
														self.injurisdiction := 
														     IF(currdate >= mindate AND mindate <> '','Y','N');
														self := left),LEFT OUTER);
dropCalcWoJur := resultswJurisdiction(NOT(rectype=7 AND injurisdiction = 'N'));
flatResults   := flattenfile(dropCalcWoJur);
											
//-----------------------------------------------------------------------------------------------------------
// group the records so we can add a counter by record type and drop any unnecessary columns for the final output
//-----------------------------------------------------------------------------------------------------------
sortedResults  := sort(flatResults,internal_seq,rectype);
groupedResults := group(sortedResults,internal_seq,rectype);

seqResults     := PROJECT(groupedResults,
                         transform(layout_buildfax.output_rec_flat_final,
                         self.record_sequence := (string) COUNTER,
												 self := left));
												 
finalResults   := sort(seqResults,acctno,external_seq,
                       predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,addr_city,addr_st,addr_zip,zip4,
											 rectype,record_sequence);

RETURN seqResults;
END;



