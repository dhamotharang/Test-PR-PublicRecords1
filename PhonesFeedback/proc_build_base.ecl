import didville, did_add, Header_Slimsort, Mdr, ut, WatchDog, AID;

export Proc_build_Base(
												String1 BuildType
											)	:= function;

//***********************************************************************************
baseLayout 	:= 	phonesFeedback.Layouts_PhonesFeedback.Layout_PhonesFeedback_base;
base				:=	PhonesFeedback.File_PhonesFeedback_Base_fcra;
BaseTemp_Lay:=	phonesFeedback.Layouts_PhonesFeedback.Layout_base_temp;

//***********************************************************************************
didTempRec := record
	baseLayout;
	temp_suffix := '';
	end;

//***********************************************************************************
inrecLayout := PhonesFeedback.Layouts_PhonesFeedback.Layout_PhonesFeedback_in;

//***********************************************************************************	
temp_inrecLayout := record
inrecLayout;
string100   prep_addr_line1			:= '';
string50		prep_addr_line_last	:= '';
unsigned8		raw_aid							:=  0;
end;	
	
//***********************************************************************************
tempLayout := record
inrecLayout;
string12 timestamp;
end;

//Sybase FCRA Data Follows (Online - Web)
tempLayout setDate(inrecLayout l) := transform
self.timestamp 	:= phonesFeedback.dateMMMDDYYYY(trim(l.date_time_added,left,right));
self 						:= l;
end;

online1 := PhonesFeedback.File_PhonesFeedback_Sprayed_in_fcra_online;

//Get rid of online entire record duplicates to minimize records passed to setDate
ded_online1 := dedup(sort(distribute(online1(trim(phone_number,left,right)!=''),hash32(phone_number)),record,local),record,local);

online2 := project(ded_online1,setDate(left));

//Get rid of duplicate phone_feedback_id's retaining the most recent date_time_added
online3 := dedup(sort(distribute(online2,hash32(phone_feedback_id)),phone_feedback_id,-timestamp,local),phone_feedback_id,local);

baseLayout trfBase(tempLayout l) := transform
	self.did	:=	(unsigned6)l.did;
	self 			:= 	l;
	self			:=	[];
end;

online		:=	PROJECT(online3,trfBase(left));

toProcess	:=	If (BuildType='F', 
										distribute(online + base,hash32(phone_number)),
										distribute(online, hash32(phone_number))
									);
									
//Create temporary records for AID processing
BaseTemp_Lay prepAID(toProcess L) := transform
	
self.prep_addr_line1 			:= StringLib.StringCleanSpaces(	
																		trim(l.street_number,left,right) + ' ' +
																		trim(l.street_pre_direction,left,right) + ' ' +
																		trim(l.street_name,left,right) + ' ' +
																		trim(l.street_suffix,left,right) + ' ' +
																		trim(l.street_post_direction,left,right) + ' ' +
																		trim(l.unit_designation,left,right) + ' ' +
																		trim(l.unit_number,left,right)
																		);
self.prep_addr_line_last	:=	StringLib.StringCleanSpaces(		
																		if (trim(l.city,left,right) !='',
																					trim(l.city,left,right) + ', ' +
																					trim(l.state,left,right) + ' ' +
																					trim(l.zip5,left,right),
																					trim(l.state,left,right) + ' ' +
																					trim(l.zip5,left,right)
																				)
																		);
self := L;
end;					

preppedAID := project(toProcess,prepAID(left));

//***********************************************************************************
//* Clean address using the AID maco
//***********************************************************************************
HasAddress				:=	trim(preppedAID.prep_addr_line1,left,right)     != '' and
											trim(preppedAID.prep_addr_line_last,left,right) != '';
								
dWith_address			:= preppedAID(HasAddress);
dWithout_address	:= preppedAID(not(HasAddress));

unsigned4	lFlags 	:= AID.Common.eReturnValues.ACECacheRecords;	

AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_line_last, Raw_AID, dwithAID, lFlags);

//***********************************************************************************
//* Populate the clean address fields from the AID cleaned address records
//***********************************************************************************
BaseTemp_Lay	popCleanAddr(dwithAID l) := transform		
	self.street_pre_direction		:= l.aidwork_acecache.predir;
	self.street_post_direction	:= l.aidwork_acecache.postdir;
	self.street_number					:= l.aidwork_acecache.prim_range;
	self.street_name						:= l.aidwork_acecache.prim_name;
	self.street_suffix			    := l.aidwork_acecache.addr_suffix;
	self.unit_number						:= l.aidwork_acecache.sec_range;
	self.unit_designation				:= l.aidwork_acecache.unit_desig;
	self.zip5										:= l.aidwork_acecache.zip5;
	self.zip4										:= l.aidwork_acecache.zip4;
	self.city			            	:= l.aidwork_acecache.p_city_name;
	self.state									:= l.aidwork_acecache.st;
	self        								:= l;		 
end;

//***********************************************************************************
//* Add back the filtered blank address records to the rest of the file
//***********************************************************************************
dAID_Cleaned_Addr := project(dwithAID, popCleanAddr(left)) + 
                     project(dWithout_address,transform(BaseTemp_Lay, self := left, self := [])) : INDEPENDENT;
//***********************************************************************************
//* Dedup cleaned records on entire record to remove records that now match.
//* For example, before cleaning, city names were FT LAUDERDALE and FORT LAUDERDALE
//***********************************************************************************
ded_cleaned := dedup(sort(distribute(dAID_Cleaned_Addr,hash32(phone_number)),record,local),record,local);

//***********************************************************************************
//* Project records to a layout that includes a name temp_suffix for ADL processing
//***********************************************************************************
didTempRec trans(ded_cleaned input) := transform
	// self.did          := (unsigned6) input.did;
	self.phone_number := stringlib.stringfilter(input.phone_number,'0123456789');
	//Added for CCPA-355
	self.global_sid   := 0;
	self.record_sid   := 0;
	self              := input;
	end;
				
allData      := project(ded_cleaned,trans(left));
	
//***********************************************************************************	
//* Get an ADL for all records, even though online data provides one, per Lisa Simmons, June 2011
//***********************************************************************************
matchset := ['A','P'];
did_Add.MAC_Match_Flex(allData,matchset,
					'','',fname,mname,lname,temp_suffix,
					street_number,street_name,unit_number,zip5,state,phone_number,
					did,
					didTempRec,
					true, did_score,
					75,
					dsWithADL)

//***********************************************************************************	
//* Get an HHID for all records
//***********************************************************************************
didville.MAC_HHID_Append_By_Address(
				dsWithADL, dsHHID, hhid, lname,
				street_number, street_name, unit_number, state, zip5);

baseOnly 			:= PROJECT(dsHHID,baseLayout);

addGlobalSID	:= mdr.macGetGlobalSID(baseOnly, 'PhoneFeedback_Virtual', '', 'global_sid');
				
return addGlobalSID;

end;