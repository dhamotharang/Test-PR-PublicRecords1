import	Address,AID,PromoteSupers, std, ut;

export proc_fedex_build_base(string version_date,boolean delta) := function 

// Combine both files
dFedExIn	:=	FedEx.File_FedEx_In.Main;

recordof(FedEx.File_FedEx_In.Main) xform1(FedEx.File_FedEx_In.Main le) := transform 
  //i see evidence of a leading space in some records
 //also believe that mac_is_business assumes all data coming in is upper-case
		self.record_type						:=	Ut.CleanSpacesAndUpper(le.record_type);
		self.first_name				      :=	Ut.CleanSpacesAndUpper(le.first_name);
		self.middle_initial		      :=	Ut.CleanSpacesAndUpper(le.middle_initial);
		self.last_name					    :=	Ut.CleanSpacesAndUpper(le.last_name);
		self.full_name					    :=	Ut.CleanSpacesAndUpper(le.full_name);
		self.company_name			      :=	Ut.CleanSpacesAndUpper(le.company_name);
		self.address_line1	        :=	Ut.CleanSpacesAndUpper(le.address_line1);
		self.address_line2	        :=	Ut.CleanSpacesAndUpper(le.address_line2);
		self.city						        :=	Ut.CleanSpacesAndUpper(le.city);
		self.state					        :=	Ut.CleanSpacesAndUpper(le.state);
		self.zip						        :=	Ut.CleanSpacesAndUpper(le.zip);
		self.country				        :=	Ut.CleanSpacesAndUpper(le.country);
    self := le;
end;

p1 := project(dFedExIn,xform1(left)) : independent ;

address.Mac_Is_Business(p1,full_name,FedEx_with_isBusiness);

dFedExCombined := project (FedEx_with_isBusiness , transform({FedEx.Layout_FedEx.Clean}, 

		string	vAddressLine1	:=	if(	left.address_line2	=	'',
																	Ut.CleanSpacesAndUpper(left.address_line1),
																	Ut.CleanSpacesAndUpper(left.address_line1	+	' '	+	left.address_line2)
																);
		string	vAddressLine2 :=	regexreplace(	'[,]$',
																						Ut.CleanSpacesAndUpper(Address.Addr2FromComponents(left.city,left.state,left.zip)),
																						''
																					);

    boolean v_nametype_p        := left.nametype='P';
    string  v_append_cleanname  := Address.CleanPersonFML73(left.full_name);
		
		self.Append_CleanName				:=	if(v_nametype_p,v_append_cleanname,'');
		//with the 3 lines below we're saying that if the INPUT full_name isn't a person then blank
		//the name fields.  it looks like FedEx may have some program which assumes the full_name
		//is always a person... and parses accordingly.
		self.first_name             :=  if(v_nametype_p,left.first_name,'');	
		self.middle_initial         :=  if(v_nametype_p,left.middle_initial,'');	
		self.last_name              :=  if(v_nametype_p,left.last_name,'');	
		self.Append_PrepAddr1				:=	vAddressLine1;
		self.Append_PrepAddr2				:=	vAddressLine2;
		self.Append_RawAID					:=	0;
		self.version:=version_date;
		self := left)):INDEPENDENT; 
		
// Split out US and canadian addresses
dFedExUSAddresses	:=	dFedExCombined(country	!=	'CA');
dFedExCAAddresses	:=	dFedExCombined(country	=		'CA');
	
// Clean clean address components
unsigned4	lAIDAppendFlags	:=	AID.Common.eReturnValues.RawAID	|	AID.Common.eReturnValues.ACECacheRecords;
	
AID.MacAppendFromRaw_2Line(	dFedExUSAddresses,
														Append_PrepAddr1,
														Append_PrepAddr2,
														Append_RawAID,
														dFedExAppendAID0,
														lAIDAppendFlags
													);

dFedExAppendAID := 	dFedExAppendAID0 : 	persist('~thor_data::persist::fedex_AID');

FedEx.Layout_FedEx.Base	tReformatAID2Base(dFedExAppendAID	pInput)	:=
transform
	self.Append_RawAID	:=	pInput.AIDWork_RawAID;
	self.prim_range			:=	pInput.AIDWork_AceCache.prim_range;
	self.predir					:=	pInput.AIDWork_AceCache.predir;
	self.prim_name			:=	pInput.AIDWork_AceCache.prim_name;
	self.addr_suffix		:=	pInput.AIDWork_AceCache.addr_suffix;
	self.postdir				:=	pInput.AIDWork_AceCache.postdir;
	self.unit_desig			:=	pInput.AIDWork_AceCache.unit_desig;
	self.sec_range			:=	pInput.AIDWork_AceCache.sec_range;
	self.p_city_name		:=	pInput.AIDWork_AceCache.p_city_name;
	self.v_city_name		:=	pInput.AIDWork_AceCache.v_city_name;
	self.st							:=	pInput.AIDWork_AceCache.st;
	self.zip5						:=	pInput.AIDWork_AceCache.zip5;
	self.zip6						:=	pInput.AIDWork_AceCache.zip5;
	self.zip4						:=	pInput.AIDWork_AceCache.zip4;
	self.cart						:=	pInput.AIDWork_AceCache.cart;
	self.cr_sort_sz			:=	pInput.AIDWork_AceCache.cr_sort_sz;
	self.lot						:=	pInput.AIDWork_AceCache.lot;
	self.lot_order			:=	pInput.AIDWork_AceCache.lot_order;
	self.dbpc						:=	pInput.AIDWork_AceCache.dbpc;
	self.chk_digit			:=	pInput.AIDWork_AceCache.chk_digit;
	self.rec_type				:=	pInput.AIDWork_AceCache.rec_type;
	self.county					:=	pInput.AIDWork_AceCache.county;
	self.geo_lat				:=	pInput.AIDWork_AceCache.geo_lat;
	self.geo_long				:=	pInput.AIDWork_AceCache.geo_long;
	self.msa						:=	pInput.AIDWork_AceCache.msa;
	self.geo_blk				:=	pInput.AIDWork_AceCache.geo_blk;
	self.geo_match			:=	pInput.AIDWork_AceCache.geo_match;
	self.err_stat				:=	pInput.AIDWork_AceCache.err_stat;
	self 								:=	pInput;
end;

dFedExAID	:=	project(dFedExAppendAID,tReformatAID2Base(left));

// Clean canadian addresses
FedEx.Layout_FedEx.Base tReformat2Base(dFedExCAAddresses	pInput)	:=
transform
	cleanAddress	:=	Address.GetCleanAddress(pInput.Append_PrepAddr1,pInput.Append_PrepAddr2,1).Results;
	
	boolean	vFullNameOnlyExists	:=	Ut.CleanSpacesAndUpper(pInput.first_name	+	pInput.last_name)	=	''	and	pInput.full_name	<>	'' and pInput.nametype='P';
	
	self.last_name			:=	if(vFullNameOnlyExists,Ut.CleanSpacesAndUpper(pInput.Append_CleanName[46..65]),pInput.last_name);
	self.first_name			:=	if(vFullNameOnlyExists,Ut.CleanSpacesAndUpper(pInput.Append_CleanName[6..25]),pInput.first_name);
	self.middle_initial	:=	if(vFullNameOnlyExists,Ut.CleanSpacesAndUpper(pInput.Append_CleanName[26..45]),pInput.middle_initial);
	
	self.prim_range			:=	cleanAddress.prim_range;
	self.predir					:=	cleanAddress.predir;
	self.prim_name			:=	cleanAddress.prim_name;
	self.addr_suffix		:=	cleanAddress.suffix;
	self.unit_desig			:=	cleanAddress.unit_desig;
	self.sec_range			:=	cleanAddress.sec_range;
	self.p_city_name		:=	cleanAddress.p_city;
	self.st							:=	cleanAddress.state;
	self.zip6						:=	cleanAddress.zip;
	self.err_stat				:=	cleanAddress.error_msg;
	self								:=	pInput;
	self								:=	[];
end;

dFedExCleanCAAddr	:=	project(dFedExCAAddresses,tReformat2Base(left));

// Combine US & CA addresses
dFedExCleanCombined			:=	dFedExAID	+	dFedExCleanCAAddr;
/*dFedExCleanCombinedDist	:=	distribute(dFedExCleanCombined,hash32(record_id));

// Split out the correction records
dFedExCleanMain					:=	dFedExCleanCombinedDist(record_type	    in ['','A']);
dFedExCleanCorrections	:=	dFedExCleanCombinedDist(record_type	not in ['','A']);

// Dedup the corrections file on record id and keep the latest correction record
dFedExCleanCorrectionsDedup	:=	dedup(sort(dFedExCleanCorrections,record_id,-file_date,local),record_id,local);

// Delete records
dFedExCorrectionDeletes	:=	dFedExCleanCorrectionsDedup(record_type	=	'D');

// Delete records
dFedExMainRemoveDeletes	:=	join(	dFedExCleanMain,
																	dFedExCorrectionDeletes,
																	left.record_id	=	right.record_id,
																	transform(FedEx.Layout_FedEx.Base,self	:=	left),
																	left only,
																	local
																);

// Change or update 
dFedExCorrectionUpdates	:=	dFedExCleanCorrectionsDedup(record_type	='U');

FedEx.Layout_FedEx.Base	tFedExCorrectionUpdates(dFedExMainRemoveDeletes	le,dFedExCorrectionUpdates	ri)	:=
transform

	fn_replace(string left_val, string right_val) := function
	 string ret_val := if(le.record_id=ri.record_id,left_val,right_val);
	 return ret_val;
	end;

	self.record_id					:=	le.record_id;
	self.record_type				:=	ri.record_type;

  //self.file_date					:=	if(le.record_id	=	ri.record_id,ri.file_date,le.file_date);
	//each field originally looked like the above
	self.file_date					:=	fn_replace(ri.file_date,le.file_date);
	self.first_name					:=	fn_replace(ri.first_name,le.first_name);
	self.middle_initial			:=	fn_replace(ri.middle_initial,le.middle_initial);
	self.last_name					:=	fn_replace(ri.last_name,le.last_name);
	self.full_name					:=	fn_replace(ri.full_name,le.full_name);
	self.company_name				:=	fn_replace(ri.company_name,le.company_name);
	self.address_line1			:=	fn_replace(ri.address_line1,le.address_line1);
	self.address_line2			:=	fn_replace(ri.address_line2,le.address_line2);
	self.city								:=	fn_replace(ri.city,le.city);
	self.state							:=	fn_replace(ri.state,le.state);
	self.zip								:=	fn_replace(ri.zip,le.zip);
	self.country						:=	fn_replace(ri.country,le.country);
	self.phone							:=	fn_replace(ri.phone,le.phone);
	self.Append_PrepAddr1		:=	fn_replace(ri.Append_PrepAddr1,le.Append_PrepAddr1);		
	self.Append_PrepAddr2		:=	fn_replace(ri.Append_PrepAddr2,le.Append_PrepAddr2);		
	self.Append_RawAID			:=	(unsigned8)fn_replace((string)ri.Append_RawAID,(string)le.Append_RawAID);		
	self.business_indicator	:=	fn_replace(ri.business_indicator,le.business_indicator);
	self.prim_range					:=	fn_replace(ri.prim_range,le.prim_range);
	self.predir							:=	fn_replace(ri.predir,le.predir);
	self.prim_name					:=	fn_replace(ri.prim_name,le.prim_name);
	self.addr_suffix				:=	fn_replace(ri.addr_suffix,le.addr_suffix);
	self.postdir						:=	fn_replace(ri.postdir,le.postdir);
	self.unit_desig					:=	fn_replace(ri.unit_desig,le.unit_desig);
	self.sec_range					:=	fn_replace(ri.sec_range,le.sec_range);
	self.p_city_name				:=	fn_replace(ri.p_city_name,le.p_city_name);
	self.v_city_name				:=	fn_replace(ri.v_city_name,le.v_city_name);
	self.st									:=	fn_replace(ri.st,le.st);
	self.zip5								:=	fn_replace(ri.zip5,le.zip5);
	self.zip6								:=	fn_replace(ri.zip6,le.zip6);
	self.zip4								:=	fn_replace(ri.zip4,le.zip4);
	self.cart								:=	fn_replace(ri.cart,le.cart);
	self.cr_sort_sz					:=	fn_replace(ri.cr_sort_sz,le.cr_sort_sz);
	self.lot								:=	fn_replace(ri.lot,le.lot);
	self.lot_order					:=	fn_replace(ri.lot_order,le.lot_order);
	self.dbpc								:=	fn_replace(ri.dbpc,le.dbpc);
	self.chk_digit					:=	fn_replace(ri.chk_digit,le.chk_digit);
	self.rec_type						:=	fn_replace(ri.rec_type,le.rec_type);
	self.county							:=	fn_replace(ri.county,le.county);
	self.geo_lat						:=	fn_replace(ri.geo_lat,le.geo_lat);
	self.geo_long						:=	fn_replace(ri.geo_long,le.geo_long);
	self.msa								:=	fn_replace(ri.msa,le.msa);
	self.geo_blk						:=	fn_replace(ri.geo_blk,le.geo_blk);
	self.geo_match					:=	fn_replace(ri.geo_match,le.geo_match);
	self.err_stat						:=	fn_replace(ri.err_stat,le.err_stat);
	self.nametype						:=	fn_replace(ri.nametype,le.nametype);
	
end;

dFedExMainCorrections	:=	join(	dFedExMainRemoveDeletes,
																dFedExCorrectionUpdates,
																left.record_id	=	right.record_id,
																tFedExCorrectionUpdates(left,right),
																left outer,
																local
															);

dFedExMainCorrectionsAdds := dFedExMainCorrections;
*/
dFedExMainFull:=dFedExCleanCombined+fedex.file_fedex_base;

identify_dupes := fedex.fn_IdentifyDuplicates(dFedExMainFull);

fedex_dupes   := identify_dupes(record_id>parent_record_id);
fedex_uniques := identify_dupes(record_id=parent_record_id);
//carry thru the max_last_seen since it's used to set date_last_seen in the query
fedex_uniques_keep_max_date := project(fedex_uniques,transform({recordof(fedex_uniques)},self.file_date:=left.max_file_date,self.phone := stringlib.stringfilter(left.phone,'0123456789'),self:=left));

today       := (string)std.date.today();
day_of_week := ut.weekday((integer)today);
//for monday's the idea is to also pick up records over the weekend
//actually include friday as well because the day we assign in the build (aka the version date)
//is likely for records being entered the day before.
//Ex: if we're starting the build at 8am tuesday, tuesday's entries are being assigned the following days date
new_records := if(day_of_week='MONDAY',dFedExMainFull(file_date between ut.getdateoffset(-3,today) and today),
                                       dFedExMainFull(file_date between ut.getdateoffset(-1,today) and today)
								 );
new_dupes :=   if(day_of_week='MONDAY',fedex_dupes(file_date between ut.getdateoffset(-3,today) and today),
                                       fedex_dupes(file_date between ut.getdateoffset(-1,today) and today)
						      );
new_uniques := if(day_of_week='MONDAY',fedex_uniques(file_date between ut.getdateoffset(-3,today) and today),
                                       fedex_uniques(file_date between ut.getdateoffset(-1,today) and today)
								  );
RemoveBaseRecords:=		fedex_uniques_keep_max_date(version=version_date);							
dCompContNamePopulated	:=	RemoveBaseRecords(	Ut.CleanSpacesAndUpper(first_name	+	last_name)	<>	''	and	company_name	<>	'');
dOthers									:=	RemoveBaseRecords(~(Ut.CleanSpacesAndUpper(first_name	+	last_name)	<>	''	and	company_name	<>	''));

FedEx.Layout_FedEx.Base	tNormalizeNames(dCompContNamePopulated	pInput,integer	cnt)	:=
transform
	self.last_name					:=	choose(cnt,pInput.last_name,pInput.company_name);
	self.first_name					:=	choose(cnt,pInput.first_name,'');
	self.middle_initial			:=	choose(cnt,pInput.middle_initial,'');
	self.business_indicator	:=	choose(cnt,'','Y');
	self										:=	pInput;
end;

dNormalizeNames	:=	normalize(dCompContNamePopulated,2,tNormalizeNames(left,counter));

FedEx.Layout_FedEx.Base	tCompNameInLName(dOthers	pInput)	:=
transform
	self.last_name 					:=	if(pInput.company_name	!=	'',pInput.company_name,pInput.last_name);
	self.business_indicator	:=	if(pInput.company_name	!=	'','Y','');
	self										:=	pInput;
end;

dCompNameinLName	:=	project(dOthers,tCompNameInLName(left));

dCombined	:=	dNormalizeNames	+	dCompNameinLName;

// Blank out phone number 8145162145 associated with Jessica Anna in FedEx
apply_ln_filters := dCombined(record_id not in fedex.Filters.by_record_id);
VersionControl.macBuildNewLogicalFile(fedex.Filenames(version_date).Base.fedex.new			,apply_ln_filters			,buildBase			,TRUE);
//PromoteSupers.MAC_SF_BuildProcess(apply_ln_filters(version=version_date),'~thor_200::base::fedex::nohits',buildBase,,,true);

output1 := output(project(fedex_dupes,fedex.layout_fedex.returnfiles),,'~thor200::out::fedex::dupes_v1',__compressed__,overwrite,csv(separator(','),terminator('\r\n'),QUOTE('"')),named('fedex_dupes_all'));
output2 := output(project(new_dupes,fedex.layout_fedex.returnfiles)  ,,'~thor200::out::fedex::new_dupes_v1',__compressed__,overwrite,csv(separator(','),terminator('\r\n'),QUOTE('"')),named('fedex_dupes_new'));
output3 := output(project(new_uniques,fedex.layout_fedex.returnfiles),,'~thor200::out::fedex::new_uniques_v1',__compressed__,overwrite,csv(separator(','),terminator('\r\n'),QUOTE('"')),named('fedex_new_recs'));

// build keys before file generation as dup files take long time to build. 

build_keys := fedex.proc_fedex_build_keys2(version_date,delta);

//sample_recs	:=	fedex.fedex_qa_samples(version_date);

return sequential(buildBase,build_keys/*,sample_recs, output1,output2,output3*/);

end; 