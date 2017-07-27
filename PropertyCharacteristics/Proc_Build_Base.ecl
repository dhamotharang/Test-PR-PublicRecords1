import	AID,codes,ut,PropertyCharacteristics,Scrubs_Property_Characteristics, PropertyFieldFillInByLA2,PromoteSupers;

export	Proc_Build_Base(string	pVersion, string emailList='')	:=
function	
// Combine the bluebook data along with LN public records data
	dLNMLS	:=	PropertyCharacteristics.LNProperty2Base;
	
	
	// Keep records where the address is fully populated
	dPropertyCombined	:=	dLNMLS(	prim_range	!=	''	and
																prim_name		!=	''	and
																zip					!=	''
															);
	
	// Clean AID is assigned for each unique cleaned address, however small variations in fields p_city_name aren't collapsed into one clean aid
	// As all the rollup logic is being done on clean aid, collapsing all the different varaitions of one cleaned address into one clean aid
	dPropAddrCollapseAceAID	:=	PropertyCharacteristics.Functions.fnCollapseAceAID(dPropertyCombined);

	// Recordset containing mix of Fares, Fidelity and MLS data (can be used for insuright report as supporting documentation)
	dCombinedFilter	:=	project(	dPropAddrCollapseAceAID,
																transform(	PropertyCharacteristics.Layouts.TempBase,
																						self.vendor_source	:=	'A';
																						self								:=	left;
																					)
															);

	// Rollup on property address to restrict to one record for each property address per source
	PropertyCharacteristics.Mac_Property_Rollup(dCombinedFilter,dCombinedRollup,true,true);
	

	dOKCMLSFilter	:=	project(	dLNMLS(vendor_source = 'C'),
															transform(	PropertyCharacteristics.Layouts.TempBase,
																					self.vendor_source	:=	'B';
                                        	self								:=	left;
																				)
														);
	
	// Add the Fares and Fidelity records to the rolled up MLS&Fidelity file
	dAll	:=	dCombinedRollup	+	dOKCMLSFilter	+	PropertyCharacteristics.LNProperty2Base;

	
	// Create unique id and reformat to base layout
	ut.MAC_Sequence_Records(dAll,property_rid,dPropSeqNum);
	
	// Clean fields - Remove unprintable characters
	ut.CleanFields(dPropSeqNum,dPropCleanFields);
	

//Single Family Residence Land Use Codes
set_single_family := ['SFR','AGR','VNY','HSR','RNH','RVL','RES','RRR','RWH','COO','CLH','BGW','HST', 'PPT', 'PRS','ZLL',''];	
dOKCTY_sfr  :=  dPropCleanFields(vendor_source	=	'B', land_use_code in set_single_family);
dOKCTY  		:=  dPropCleanFields(vendor_source	=	'B', land_use_code not in set_single_family);
dOthers			:=	dPropCleanFields(vendor_source != 'B');

dOKCTY_srt := sort(distribute(dOKCTY_sfr,hash(prim_range, prim_name, sec_range, zip, addr_suffix, predir, postdir, geo_blk)),
																	prim_range, prim_name, sec_range, zip, addr_suffix, predir, postdir, geo_blk,local);

PropertyCharacteristics.Populate_Default_Data.Mac_Populate_Attribute_Default_Data(dOKCTY_srt,dPropAttributeDefaultData);

// combine_base := dOthers + dOKCTY + dPropAttributeDefaultData;
dPropAttrDefaultData	:=	
														project( dOthers + dOKCTY + dPropAttributeDefaultData,
																			transform(	PropertyCharacteristics.Layouts.TempBase,
																									self.cnt_insurbase_codes	:=	count(left.insurbase_codes);
																									self											:=	left;
																								)
																		);
	
	// Distribute on property rid
	dPropAttrDefaultDataDist	:=	distribute(dPropAttrDefaultData,hash32(property_rid));
	
	// Project to the base file layout
	dBase	:=	project(dPropAttrDefaultDataDist,PropertyCharacteristics.Layouts.Base);
	
	// output base file
	PromoteSupers.Mac_SF_BuildProcess(dBase,'~thor_data400::base::propertyinfo',buildBase,,,true,pVersion);
	
	Scrubs := Scrubs_Property_Characteristics.fnRunScrubs(pversion, emailList);
	
	return	sequential(buildBase
										,Scrubs
										);

end;