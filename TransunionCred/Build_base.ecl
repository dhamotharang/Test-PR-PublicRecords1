IMPORT  address, ut, header_slimsort, did_add, didville,AID,std;

export Build_base(string ver) := module

#IF (IsFullUpdate = false)
	TrnUn_credit := Files.update_in;
#ELSE
	TrnUn_credit := Files.load_in;
#END
setValidSuffix:=['JR','SR','I','II','III','IV','V','VI','VII','VIII','IX'];
string fGetSuffix(string SuffixIn)	:=		map(SuffixIn = '1' => 'I'
																							,SuffixIn in ['2','ND'] => 'II'
																							,SuffixIn in ['3','RD'] => 'III'
																							,SuffixIn = '4' => 'IV'
																							,SuffixIn = '5' => 'V'
																							,SuffixIn = '6' => 'VI'
																							,SuffixIn = '7' => 'VII'
																							,SuffixIn = '8' => 'VIII'
																							,SuffixIn = '9' => 'IX'
																							,SuffixIn in setValidSuffix => SuffixIn
																							,'');

//Normalize current name, alias, aka and former name
Layouts.base t_norm_name (TrnUn_credit L, INTEGER C):= TRANSFORM
	SELF.Prepped_rec_type         := CHOOSE(C,'A','B','C','D') + l.Record_Type[2];
	current_name                  := trim(StringLib.StringCleanSpaces(trim(L.Last_Name)
																+','+L.First_Name
																+' '+L.Middle_Name
																+' '+fGetSuffix(L.name_suffix_)));
	SELF.Prepped_Name             := CHOOSE(C,current_name,L.AKA1,L.AKA2,L.AKA3);
	SELF.Prepped_addr1            := trim(StringLib.StringCleanSpaces(L.House_Number
																+' '+L.Street_Direction
																+' '+L.Street_Name
																+' '+L.Street_Type
																+' '+L.Street_Post_Direction
																+' '+L.Unit_Type
																+' '+L.Unit_Number));
	SELF.Prepped_addr2            := trim(StringLib.StringCleanSpaces(	trim(L.Cty) + if(L.Cty <> '',',','')
																+ ' '+ L.State
																+ ' '+ L.Zip_Code
																),left,right);

	self.dt_first_seen            := CHOOSE(C,(unsigned)l.date_address_reported,0,0,0);
	self.dt_last_seen             := if(self.Prepped_rec_type='A1',(unsigned)ver,0);
	self.dt_vendor_first_reported := (unsigned)ver;
	self.dt_vendor_last_reported  := (unsigned)ver;
	valid_dob                     := if((unsigned)l.Date_of_Birth between 18000101 and (unsigned)(STRING8)Std.Date.Today()
																				,(unsigned)l.Date_of_Birth
																				,0);
	valid_ssn                     := if((unsigned)l.Ssn > 0,l.Ssn, '');
	SELF.clean_ssn                := valid_ssn;
	SELF.clean_dob                := if(l.Date_of_Birth_Estimated_Ind='E',0,valid_dob);
	self.clean_phone              := if((integer)l.phone=0,'',l.phone);
	SELF.IsCurrent                := self.Prepped_rec_type='A1';
	SELF.IsUpdating               := true;
	SELF                          := L;
	SELF                          := [];
END;

norm_names0 := NORMALIZE(TrnUn_credit, 4, t_norm_name(LEFT, COUNTER))(length(stringlib.stringfilterout(Prepped_name,' ,'))>0);

names1:=dedup(table(norm_names0,{Prepped_name ,title,fname,mname,lname,name_suffix,string3 name_score:=''}),record,all);

{names1} tCleanNames(names1 l) := transform
	cleanName        := Address.CleanPersonLFM73(l.Prepped_name);
	self.title       := cleanName[1..5];
	self.fname       := cleanName[6..25];
	self.mname       := cleanName[26..45];
	self.lname       := cleanName[46..65];
	self.name_suffix := cleanName[66..70];
	self.name_score  := cleanName[71..73];
	self:=l;
end;

names:=project(names1,tCleanNames(left)):persist('~thor_data400::persist::TransunionCred_names');
// names:=dataset('~thor_data400::persist::TransunionCred_names',{names1},flat);

norm_names1:=join(distribute(norm_names0,hash(Prepped_name))
								,distribute(names,       hash(Prepped_name))
											,left.Prepped_name=right.Prepped_name
											,transform(Layouts.base
												,self.title       :=right.title
												,self.fname       :=if(left.Prepped_name=right.Prepped_name,right.fname,'')
												,self.mname       :=if(left.Prepped_name=right.Prepped_name,right.mname,'')
												,self.lname       :=if(left.Prepped_name=right.Prepped_name,right.lname,'')
												,self.name_suffix :=if(left.Prepped_name=right.Prepped_name,right.name_suffix,'')
												,self.name_score  :=if(left.Prepped_name=right.Prepped_name,right.name_score,'')
												,self:=left)
											,left outer
											,local);

// preprocess:=temp(norm_names1); //used for testing sample ecords

unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;		
AID.MacAppendFromRaw_2Line(norm_names1,Prepped_addr1,Prepped_addr2,RawAID,norm_names, lFlags);

Layouts.base tr_addr(norm_names le) := TRANSFORM
	self.RawAID     := le.aidwork_rawaid;
	self.prim_range := stringlib.stringfilterout(le.aidwork_acecache.prim_range,'.');
	self.prim_name  := stringlib.stringfilterout(le.aidwork_acecache.prim_name,'.^!$+<>@=%?*\'');
	self.sec_range  := stringlib.stringfilterout(le.aidwork_acecache.sec_range,'.>$!%*@=?&\'');
	self.v_city_name:= if(length(stringlib.stringfilterout(stringlib.stringtouppercase(le.aidwork_acecache.v_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,le.aidwork_acecache.v_city_name,'');
	self.p_city_name:= if(length(stringlib.stringfilterout(stringlib.stringtouppercase(le.aidwork_acecache.p_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,le.aidwork_acecache.p_city_name,'');
	self.zip        := le.aidwork_acecache.zip5;
	self.county     := le.aidwork_acecache.county[3..5];
	self.msa        := if(le.aidwork_acecache.msa='','',le.aidwork_acecache.msa+'0');
	self            := le.aidwork_acecache;
	self            := le;
END;

preprocess := project(norm_names,tr_addr(left)):persist('~thor_data400::persist::TransunionCred_clean');
// preprocess := dataset('~thor_data400::persist::TransunionCred_clean',Layouts.base,flat);

cur_base_d := distribute(project(Files.Base, transform(recordof(Files.Base), self.did := 0, self := left)), hash(Party_ID));

#IF (IsFullUpdate = false)
	cur_update_d := dedup(distribute(preprocess, hash(Party_ID)),Party_ID,all,local);

	apply_updates := join(cur_base_d, cur_update_d
									,left.Party_ID = right.Party_ID
							,transform(Layouts.base
								,self.IsCurrent	:= if(left.Party_ID=right.Party_ID and left.Prepped_rec_type='A1',false,left.IsCurrent)
								,self           := left)
							,left outer
							,local);

	base_and_update := if(nothor(FileServices.GetSuperFileSubCount(Superfile_List.Base)) = 0
												,preprocess
												,preprocess + apply_updates);

#ELSE
	reset_cur_base := project(cur_base_d, transform(Layouts.base
											,self.IsCurrent  := false
											,self.IsUpdating := false
											,self := left));

	base_and_update := if(nothor(FileServices.GetSuperFileSubCount(Superfile_List.Base)) = 0
											 ,preprocess
											 ,preprocess + reset_cur_base);
#END

TN_ready := base_and_update;
//-----------------------------------------------------------------
//Rollup to eliminate duplications
//-----------------------------------------------------------------
build_TN_base_d := distribute(TN_ready, hash(Party_ID));  
build_TN_base_s := sort(build_TN_base_d
																	,Party_ID
																	,Prepped_rec_type
																	,title
																	,fname
																	,mname
																	,lname
																	,name_suffix
																	,prim_range
																	,predir
																	,prim_name
																	,addr_suffix
																	,postdir
																	,unit_desig
																	,sec_range
																	,v_city_name
																	,st
																	,zip
																	,clean_phone
																	,clean_ssn
																	,clean_dob
																	,-dt_vendor_last_reported
																	,local);

Layouts.base t_rollup (build_TN_base_s  le, build_TN_base_s ri) := transform
 self.dt_first_seen            := ut.min2(le.dt_first_seen, ri.dt_first_seen);
 self.dt_last_seen             :=     max(le.dt_last_seen, ri.dt_last_seen);
 self.dt_vendor_first_reported := ut.min2(le.dt_vendor_first_reported, ri.dt_vendor_first_reported);
 self.dt_vendor_last_reported  :=     max(le.dt_vendor_last_reported, ri.dt_vendor_last_reported);
 self.IsCurrent                := if(le.IsCurrent=true,le.IsCurrent,ri.IsCurrent);
 self.IsUpdating               := if(le.IsUpdating=true,le.IsUpdating,ri.IsUpdating);

 self.Record_Type              := if(le.IsUpdating=true,le.Record_Type,ri.Record_Type);
 self.Name_Prefix              := if(le.IsUpdating=true,le.Name_Prefix,ri.Name_Prefix);
 self.Perm_ID                  := if(le.IsUpdating=true,le.Perm_ID,ri.Perm_ID);
 self.SSN                      := if(le.IsUpdating=true,le.SSN,ri.SSN);
 self.New_Subject_Flag         := if(le.IsUpdating=true,le.New_Subject_Flag,ri.New_Subject_Flag);
 self.Name_Change_Flag         := if(le.IsUpdating=true,le.Name_Change_Flag ,ri.Name_Change_Flag );
 self.Address_Change_Flag      := if(le.IsUpdating=true,le.Address_Change_Flag,ri.Address_Change_Flag);
 self.SSN_Change_Flag          := if(le.IsUpdating=true,le.SSN_Change_Flag,ri.SSN_Change_Flag);
 self.File_Since_Date_Change_Flag := if(le.IsUpdating=true,le.File_Since_Date_Change_Flag,ri.File_Since_Date_Change_Flag);
 self.Deceased_Indicator_Flag  := if(le.IsUpdating=true,le.Deceased_Indicator_Flag,ri.Deceased_Indicator_Flag);
 self.DOB_Change_Flag          := if(le.IsUpdating=true,le.DOB_Change_Flag,ri.DOB_Change_Flag);
 self.Phone_Change_Flag        := if(le.IsUpdating=true,le.Phone_Change_Flag ,ri.Phone_Change_Flag );
 self.Filler2                  := if(le.IsUpdating=true,le.Filler2,ri.Filler2);
 self.File_Since_Date          := if(le.IsUpdating=true,le.File_Since_Date,ri.File_Since_Date);
 self.Address_Standardization_Indicator := if(le.IsUpdating=true,le.Address_Standardization_Indicator,ri.Address_Standardization_Indicator);
 self.Date_Address_Reported    := if(le.IsUpdating=true,le.Date_Address_Reported,ri.Date_Address_Reported);
 self.Deceased_Indicator       := if(le.IsUpdating=true,le.Deceased_Indicator,ri.Deceased_Indicator);
 self.Date_of_Birth_Estimated_Ind := if(le.IsUpdating=true,le.Date_of_Birth_Estimated_Ind,ri.Date_of_Birth_Estimated_Ind);


 self := le;
end;

TransunionCred_base := rollup(build_TN_base_s
																	,   left.Party_ID=right.Party_ID
																	and left.Prepped_rec_type=right.Prepped_rec_type
																	and left.title=right.title
																	and left.fname=right.fname
																	and left.mname=right.mname
																	and left.lname=right.lname
																	and left.name_suffix=right.name_suffix
																	and left.prim_range=right.prim_range
																	and left.predir=right.predir
																	and left.prim_name=right.prim_name
																	and left.addr_suffix=right.addr_suffix
																	and left.postdir=right.postdir
																	and left.unit_desig=right.unit_desig
																	and left.sec_range=right.sec_range
																	and left.v_city_name=right.v_city_name
																	and left.st=right.st
																	and left.zip=right.zip
																	and left.clean_phone=right.clean_phone
																	and left.clean_ssn=right.clean_ssn
																	and left.clean_dob=right.clean_dob
																	,t_rollup(left, right)
																	,local);
																																
//-----------------------------------------------------------------
//APPEND DID
//-----------------------------------------------------------------
matchset := ['A','Z','D','S'];

did_add.MAC_Match_Flex
	(TransunionCred_base , matchset,					
	 clean_ssn,clean_dob, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st,'', 
	 DID, Layouts.base, true, did_score,
	 75, d_did);

//-----------------------------------------------------------------
//APPEND DELETE FLAG
//-----------------------------------------------------------------																	
TrnUn_delete := Files.Delete_In;
TrnUn_delete_dist := distribute(TrnUn_delete, hash(party_id));
TrnUn_delete_dedup := dedup(sort(TrnUn_delete_dist,party_id,local),party_id,local);

transunioncred.layouts.base tIsDelete(d_did Le, TrnUn_delete_dedup Ri) := transform

self.IsDelete := if(le.party_id = ri.party_id,true,le.isdelete);
self := le;
end;

d_append_delete := join(d_did, TrnUn_delete_dedup, left.party_id = right.party_id, tIsDelete(left, right), left outer, lookup);

base_and_delete := if(nothor(FileServices.GetSuperFileSubCount(Superfile_List.deletes)) = 0
												,d_did
												,d_append_delete);
//-----------------------------------------------------------------
//INCREMENT DT_LAST_SEEN: IF IsDelete=false and IsUpdating=true and Deceased_Indicator_Flag <> 'Y' and IsCurrent=true
//-----------------------------------------------------------------
candidates		:=base_and_delete(IsDelete=false and IsUpdating=true and Deceased_Indicator_Flag <> 'Y' and IsCurrent=true);
not_candidates:=base_and_delete(IsDelete=true  or  IsUpdating=false or Deceased_Indicator_Flag =  'Y' or  IsCurrent=false);
TransunionCred_out:=project(candidates
															,transform(layouts.base
																	,self.dt_last_seen:=if((unsigned)ver > left.dt_first_seen, (unsigned)ver, left.dt_last_seen)
																	,self:=left
																	))
																	+ not_candidates;

export All := TransunionCred_out;

end;