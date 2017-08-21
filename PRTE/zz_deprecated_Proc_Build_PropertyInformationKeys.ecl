/*
2014-08-19 - (BPetro) - renamed for deprecation and note added
... please use PRTE2_PropertyInfo.BWR_Build_PropertyInfo for future builds.

*/
import	_control,PRTE_CSV,PropertyCharacteristics,ut;

export	Proc_Build_PropertyInformationKeys(string	pIndexVersion)	:=
function
// Get the key layout definitions
	rKeyPropInfo__property_rid	:=
	record
		PRTE_CSV.PropertyInformation.rthor_data400__key__propertyinfo__rid;
	end;
	
	rKeyPropInfo__property_address	:=
	record
		PRTE_CSV.PropertyInformation.rthor_data400__key__propertyinfo__address;
	end;
	
		
	dPropInfo__property_rid				:= 	project(PRTE_CSV.PropertyInformation.dthor_data400__key__propertyinfo__rid,rKeyPropInfo__property_rid);
	dPropInfo__property_rid_dist	:=	distribute(dPropInfo__property_rid,hash32(property_rid));
	
	// Reformat to bring the dataset to the payload index layout
	PropertyCharacteristics.Layouts.Base	tFormat2Payload(dPropInfo__property_rid_dist	pInput)	:=
	transform
		self	:=	pInput;
		self	:=	[];
	end;
	
	dPropInfoFormat2Payload	:=	project(dPropInfo__property_rid_dist,tFormat2Payload(left));
	
	// Dedup the dataset to contain only one record per rid
	dPropInfoPayloadDedup	:=	dedup(dPropInfoFormat2Payload,property_rid,all,local);
	
	// Create a dataset containing the IB codes and the id
	rIBTemp_layout	:=
	record(PropertyCharacteristics.Layout_Codes.TradeMaterials)
		unsigned6	property_rid;
	end;
	
	rIBTemp_layout	tIBPayload(dPropInfo__property_rid_dist	pInput)	:=
	transform
		self	:=	pInput;
	end;
	
	dPropInfo__IB	:=	project(dPropInfo__property_rid_dist,tIBPayload(left));
	
	// Denormalize to create a  child dataset for all the IB codes
	PropertyCharacteristics.Layouts.Base	tDenormIBCode(dPropInfoPayloadDedup	le,dPropInfo__property_rid_dist	ri)	:=
	transform
		self.insurbase_codes	:=	if(	ri.category	!=	''	and	ri.material	!=	''	and	ri.value	!=	0,
																	le.insurbase_codes	+	row({ri.category,ri.material,ri.value,ri.quality,ri.condition,ri.age},PropertyCharacteristics.Layout_Codes.TradeMaterials),
																	le.insurbase_codes
																);
		self.stories_type			:=	if(	regexfind('^[0-9]+[.][0-9]*[0]*$',ut.fnTrim2Upper(le.stories_type)),
																	(string)((real)le.stories_type),
																	le.stories_type
																);
		self									:=	le;
	end;
	
	dKeyPropInfo__property__rid	:=	denormalize(	dPropInfoPayloadDedup,
																								dPropInfo__property_rid_dist,
																								left.property_rid	=	right.property_rid,
																								tDenormIBCode(left,right),
																								local
																							);

	
	// Reformat the csv datasets to the layouts defined above
	dKeyPropInfo__property__address			:= 	project(PRTE_CSV.PropertyInformation.dthor_data400__key__propertyinfo__address,rKeyPropInfo__property_address);
	
	// Index definitions for keys
	kKeyPropInfo__property__rid					:=	index(dKeyPropInfo__property__rid,{property_rid},{dKeyPropInfo__property__rid},'~prte::key::propertyinfo::' + pIndexVersion + '::rid');
	kKeyPropInfo__property__address			:=	index(dKeyPropInfo__property__address,{prim_name,prim_range,zip,predir,postdir,addr_suffix,sec_range},{dKeyPropInfo__property__address},'~prte::key::propertyinfo::' + pIndexVersion + '::address');
	
	
	return	sequential(
											parallel(build(kKeyPropInfo__property__rid					,update),
																build(kKeyPropInfo__property__address			,update)
																),
											PRTE.UpdateVersion(	'PropertyInformationKeys',						//	Package name
																					pIndexVersion,												//	Package version
																					_control.MyInfo.EmailAddressNormal,		//	Who to email with specifics
																					'B',																	//	B = Boca,A = Alpharetta
																					'N',																	//	N = Non-FCRA,F = FCRA
																					'N'																		//	N = Do not also include boolean,Y = Include boolean,too
																				)
										 );
end;