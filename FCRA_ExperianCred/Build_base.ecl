IMPORT  address, ut, header_slimsort, did_add, didville,AID,_validate,NID;

export Build_base(string ver) := module

#IF (IsFullUpdate = true)
	Exprn_credit := Files.load_in;
#ELSE
	Exprn_credit := Files.update_in;
#END
// Prepped_rec_type[1]:
// 0=current name
// 1=former name1
// 2=former name2
// 3=former name3
// 4=spouse name
// Prepped_rec_type[2..3]:
// 00=current address
// 01=previous address1
// ...
// 24=previous address24
//Normalize current name, alias, aka and former name
Layouts.base t_prep (Layouts.load L, INTEGER C):= TRANSFORM

	SELF.Prepped_rec_type         :=CHOOSE(C,'000','001','002','003','004','005','006','007','008','009','010','011','012','013','014','015','016','017','018','019','020','021','022','023','024'
																					,'100','101','102','103','104','105','106','107','108','109','110','111','112','113','114','115','116','117','118','119','120','121','122','123','124'
																					,'200','201','202','203','204','205','206','207','208','209','210','211','212','213','214','215','216','217','218','219','220','221','222','223','224'
																					,'300','301','302','303','304','305','306','307','308','309','310','311','312','313','314','315','316','317','318','319','320','321','322','323','324'
																					,'400' //spouse gets current address only
																					);

	SELF.orig_fname                   :=CHOOSE((C+24) / 25
																					,L.FIRSTNAME
																					,L.ADD_FIRSTNAME_1
																					,L.ADD_FIRSTNAME_2
																					,L.ADD_FIRSTNAME_3
																					,L.SPOUSE_FIRSTNAME
																					);

	SELF.orig_mname                   :=CHOOSE((C+24) / 25
																					,L.MIDDLE_NAME
																					,L.ADD_MIDDLE_NAME_1
																					,L.ADD_MIDDLE_NAME_2
																					,L.ADD_MIDDLE_NAME_3
																					,''
																					);

	SELF.orig_lname                   :=CHOOSE((C+24) / 25
																					,trim(StringLib.StringCleanSpaces(trim(L.LASTNAME) + if(L.SECOND_LASTNAME <> '','-','') + L.SECOND_LASTNAME),left,right)
																					,trim(StringLib.StringCleanSpaces(trim(L.ADD_LASTNAME_1) + if(L.SECOND_LASTNAME <> '','-','') + L.SECOND_LASTNAME),left,right)
																					,trim(StringLib.StringCleanSpaces(trim(L.ADD_LASTNAME_2) + if(L.SECOND_LASTNAME <> '','-','') + L.SECOND_LASTNAME),left,right)
																					,trim(StringLib.StringCleanSpaces(trim(L.ADD_LASTNAME_3) + if(L.SECOND_LASTNAME <> '','-','') + L.SECOND_LASTNAME),left,right)
																					,L.LASTNAME
																					);

	SELF.orig_name_suffix            :=CHOOSE((C+24) / 25
																					,case(L.GENERATION_CODE,      'S' => 'SR','J' => 'JR','1' => 'I','2' => 'II','3' => 'III','4' => 'IV','')
																					,case(L.ADD_GENERATION_CODE_1,'S' => 'SR','J' => 'JR','1' => 'I','2' => 'II','3' => 'III','4' => 'IV','')
																					,case(L.ADD_GENERATION_CODE_2,'S' => 'SR','J' => 'JR','1' => 'I','2' => 'II','3' => 'III','4' => 'IV','')
																					,case(L.ADD_GENERATION_CODE_3,'S' => 'SR','J' => 'JR','1' => 'I','2' => 'II','3' => 'III','4' => 'IV','')
																					,''
																					);

	SELF.orig_prim_range             :=CHOOSE(if(C % 25=0,25,C % 25)
																					,L.STREET_ID      ,L.PA_STREET_ID_1 ,L.PA_STREET_ID_2 ,L.PA_STREET_ID_3 ,L.PA_STREET_ID_4
																					,L.PA_STREET_ID_5 ,L.PA_STREET_ID_6 ,L.PA_STREET_ID_7 ,L.PA_STREET_ID_8 ,L.PA_STREET_ID_9
																					,L.PA_STREET_ID_10,L.PA_STREET_ID_11,L.PA_STREET_ID_12,L.PA_STREET_ID_13,L.PA_STREET_ID_14
																					,L.PA_STREET_ID_15,L.PA_STREET_ID_16,L.PA_STREET_ID_17,L.PA_STREET_ID_18,L.PA_STREET_ID_19
																					,L.PA_STREET_ID_20,L.PA_STREET_ID_21,L.PA_STREET_ID_22,L.PA_STREET_ID_23,L.PA_STREET_ID_24
																					);

	SELF.orig_predir                 :=CHOOSE(if(C % 25=0,25,C % 25)
																					,L.PRE_DIR      ,L.PA_PRE_DIR_1 ,L.PA_PRE_DIR_2 ,L.PA_PRE_DIR_3 ,L.PA_PRE_DIR_4
																					,L.PA_PRE_DIR_5 ,L.PA_PRE_DIR_6 ,L.PA_PRE_DIR_7 ,L.PA_PRE_DIR_8 ,L.PA_PRE_DIR_9
																					,L.PA_PRE_DIR_10,L.PA_PRE_DIR_11,L.PA_PRE_DIR_12,L.PA_PRE_DIR_13,L.PA_PRE_DIR_14
																					,L.PA_PRE_DIR_15,L.PA_PRE_DIR_16,L.PA_PRE_DIR_17,L.PA_PRE_DIR_18,L.PA_PRE_DIR_19
																					,L.PA_PRE_DIR_20,L.PA_PRE_DIR_21,L.PA_PRE_DIR_22,L.PA_PRE_DIR_23,L.PA_PRE_DIR_24
																					);

	SELF.orig_prim_name              :=CHOOSE(if(C % 25=0,25,C % 25)
																					,L.STREET_NAME      ,L.PA_STREET_NAME_1 ,L.PA_STREET_NAME_2 ,L.PA_STREET_NAME_3 ,L.PA_STREET_NAME_4
																					,L.PA_STREET_NAME_5 ,L.PA_STREET_NAME_6 ,L.PA_STREET_NAME_7 ,L.PA_STREET_NAME_8 ,L.PA_STREET_NAME_9
																					,L.PA_STREET_NAME_10,L.PA_STREET_NAME_11,L.PA_STREET_NAME_12,L.PA_STREET_NAME_13,L.PA_STREET_NAME_14
																					,L.PA_STREET_NAME_15,L.PA_STREET_NAME_16,L.PA_STREET_NAME_17,L.PA_STREET_NAME_18,L.PA_STREET_NAME_19
																					,L.PA_STREET_NAME_20,L.PA_STREET_NAME_21,L.PA_STREET_NAME_22,L.PA_STREET_NAME_23,L.PA_STREET_NAME_24
																					);

	SELF.orig_addr_suffix            :=CHOOSE(if(C % 25=0,25,C % 25)
																					,L.STREET_SUFFIX      ,L.PA_STREET_SUFFIX_1 ,L.PA_STREET_SUFFIX_2 ,L.PA_STREET_SUFFIX_3 ,L.PA_STREET_SUFFIX_4
																					,L.PA_STREET_SUFFIX_5 ,L.PA_STREET_SUFFIX_6 ,L.PA_STREET_SUFFIX_7 ,L.PA_STREET_SUFFIX_8 ,L.PA_STREET_SUFFIX_9
																					,L.PA_STREET_SUFFIX_10,L.PA_STREET_SUFFIX_11,L.PA_STREET_SUFFIX_12,L.PA_STREET_SUFFIX_13,L.PA_STREET_SUFFIX_14
																					,L.PA_STREET_SUFFIX_15,L.PA_STREET_SUFFIX_16,L.PA_STREET_SUFFIX_17,L.PA_STREET_SUFFIX_18,L.PA_STREET_SUFFIX_19
																					,L.PA_STREET_SUFFIX_20,L.PA_STREET_SUFFIX_21,L.PA_STREET_SUFFIX_22,L.PA_STREET_SUFFIX_23,L.PA_STREET_SUFFIX_24
																					);

	SELF.orig_postdir                :=CHOOSE(if(C % 25=0,25,C % 25)
																					,L.POST_DIR      ,L.PA_POST_DIR_1 ,L.PA_POST_DIR_2 ,L.PA_POST_DIR_3 ,L.PA_POST_DIR_4
																					,L.PA_POST_DIR_5 ,L.PA_POST_DIR_6 ,L.PA_POST_DIR_7 ,L.PA_POST_DIR_8 ,L.PA_POST_DIR_9
																					,L.PA_POST_DIR_10,L.PA_POST_DIR_11,L.PA_POST_DIR_12,L.PA_POST_DIR_13,L.PA_POST_DIR_14
																					,L.PA_POST_DIR_15,L.PA_POST_DIR_16,L.PA_POST_DIR_17,L.PA_POST_DIR_18,L.PA_POST_DIR_19
																					,L.PA_POST_DIR_20,L.PA_POST_DIR_21,L.PA_POST_DIR_22,L.PA_POST_DIR_23,L.PA_POST_DIR_24
																					);

	SELF.orig_unit_desig                :=CHOOSE(if(C % 25=0,25,C % 25)
																					,L.UNIT_TYPE      ,L.PA_UNIT_TYPE_1 ,L.PA_UNIT_TYPE_2 ,L.PA_UNIT_TYPE_3 ,L.PA_UNIT_TYPE_4
																					,L.PA_UNIT_TYPE_5 ,L.PA_UNIT_TYPE_6 ,L.PA_UNIT_TYPE_7 ,L.PA_UNIT_TYPE_8 ,L.PA_UNIT_TYPE_9
																					,L.PA_UNIT_TYPE_10,L.PA_UNIT_TYPE_11,L.PA_UNIT_TYPE_12,L.PA_UNIT_TYPE_13,L.PA_UNIT_TYPE_14
																					,L.PA_UNIT_TYPE_15,L.PA_UNIT_TYPE_16,L.PA_UNIT_TYPE_17,L.PA_UNIT_TYPE_18,L.PA_UNIT_TYPE_19
																					,L.PA_UNIT_TYPE_20,L.PA_UNIT_TYPE_21,L.PA_UNIT_TYPE_22,L.PA_UNIT_TYPE_23,L.PA_UNIT_TYPE_24
																					);

	SELF.orig_sec_range              :=CHOOSE(if(C % 25=0,25,C % 25)
																					,L.UNIT_ID      ,L.PA_UNIT_ID_1 ,L.PA_UNIT_ID_2 ,L.PA_UNIT_ID_3 ,L.PA_UNIT_ID_4
																					,L.PA_UNIT_ID_5 ,L.PA_UNIT_ID_6 ,L.PA_UNIT_ID_7 ,L.PA_UNIT_ID_8 ,L.PA_UNIT_ID_9
																					,L.PA_UNIT_ID_10,L.PA_UNIT_ID_11,L.PA_UNIT_ID_12,L.PA_UNIT_ID_13,L.PA_UNIT_ID_14
																					,L.PA_UNIT_ID_15,L.PA_UNIT_ID_16,L.PA_UNIT_ID_17,L.PA_UNIT_ID_18,L.PA_UNIT_ID_19
																					,L.PA_UNIT_ID_20,L.PA_UNIT_ID_21,L.PA_UNIT_ID_22,L.PA_UNIT_ID_23,L.PA_UNIT_ID_24
																					);

	SELF.orig_city                   :=CHOOSE(if(C % 25=0,25,C % 25)
																					,L.CITY_NAME      ,L.PA_CITY_NAME_1 ,L.PA_CITY_NAME_2 ,L.PA_CITY_NAME_3 ,L.PA_CITY_NAME_4
																					,L.PA_CITY_NAME_5 ,L.PA_CITY_NAME_6 ,L.PA_CITY_NAME_7 ,L.PA_CITY_NAME_8 ,L.PA_CITY_NAME_9
																					,L.PA_CITY_NAME_10,L.PA_CITY_NAME_11,L.PA_CITY_NAME_12,L.PA_CITY_NAME_13,L.PA_CITY_NAME_14
																					,L.PA_CITY_NAME_15,L.PA_CITY_NAME_16,L.PA_CITY_NAME_17,L.PA_CITY_NAME_18,L.PA_CITY_NAME_19
																					,L.PA_CITY_NAME_20,L.PA_CITY_NAME_21,L.PA_CITY_NAME_22,L.PA_CITY_NAME_23,L.PA_CITY_NAME_24
																					);

	SELF.orig_st                     :=CHOOSE(if(C % 25=0,25,C % 25)
																					,L.STATE      ,L.PA_STATE_1 ,L.PA_STATE_2 ,L.PA_STATE_3 ,L.PA_STATE_4
																					,L.PA_STATE_5 ,L.PA_STATE_6 ,L.PA_STATE_7 ,L.PA_STATE_8 ,L.PA_STATE_9
																					,L.PA_STATE_10,L.PA_STATE_11,L.PA_STATE_12,L.PA_STATE_13,L.PA_STATE_14
																					,L.PA_STATE_15,L.PA_STATE_16,L.PA_STATE_17,L.PA_STATE_18,L.PA_STATE_19
																					,L.PA_STATE_20,L.PA_STATE_21,L.PA_STATE_22,L.PA_STATE_23,L.PA_STATE_24
																					);

	SELF.orig_zip                    :=CHOOSE(if(C % 25=0,25,C % 25)
																					,L.ZIP_CODE     ,L.PA_ZIPCODE_1 ,L.PA_ZIPCODE_2 ,L.PA_ZIPCODE_3 ,L.PA_ZIPCODE_4
																					,L.PA_ZIPCODE_5 ,L.PA_ZIPCODE_6 ,L.PA_ZIPCODE_7 ,L.PA_ZIPCODE_8 ,L.PA_ZIPCODE_9
																					,L.PA_ZIPCODE_10,L.PA_ZIPCODE_11,L.PA_ZIPCODE_12,L.PA_ZIPCODE_13,L.PA_ZIPCODE_14
																					,L.PA_ZIPCODE_15,L.PA_ZIPCODE_16,L.PA_ZIPCODE_17,L.PA_ZIPCODE_18,L.PA_ZIPCODE_19
																					,L.PA_ZIPCODE_20,L.PA_ZIPCODE_21,L.PA_ZIPCODE_22,L.PA_ZIPCODE_23,L.PA_ZIPCODE_24
																					);

	SELF.orig_zip4                    :=CHOOSE(if(C % 25=0,25,C % 25)
																					,L.ZIP_PLUS_FOUR,L.PA_ZIP4_1 ,L.PA_ZIP4_2 ,L.PA_ZIP4_3 ,L.PA_ZIP4_4
																					,L.PA_ZIP4_5    ,L.PA_ZIP4_6 ,L.PA_ZIP4_7 ,L.PA_ZIP4_8 ,L.PA_ZIP4_9
																					,L.PA_ZIP4_10   ,L.PA_ZIP4_11,L.PA_ZIP4_12,L.PA_ZIP4_13,L.PA_ZIP4_14
																					,L.PA_ZIP4_15   ,L.PA_ZIP4_16,L.PA_ZIP4_17,L.PA_ZIP4_18,L.PA_ZIP4_19
																					,L.PA_ZIP4_20   ,L.PA_ZIP4_21,L.PA_ZIP4_22,L.PA_ZIP4_23,L.PA_ZIP4_24
																					);

	SELF.Prepped_addr1            :=CHOOSE(if(C % 25=0,25,C % 25)
																					,trim(StringLib.StringCleanSpaces(
																					self.orig_prim_range
																					+' '+self.orig_predir
																					+' '+self.orig_prim_name
																					+' '+self.orig_addr_suffix
																					+' '+self.orig_postdir
																					+' '+self.orig_unit_desig
																					+' '+self.orig_sec_range))
																					);

	SELF.Prepped_addr2            :=CHOOSE(if(C % 25=0,25,C % 25)
																					,trim(StringLib.StringCleanSpaces(
																					trim(self.orig_city)
																					+ if(self.orig_city <> '',',','')
																					+ ' '+ self.orig_st
																					+ ' '+ self.orig_zip),left,right)
																					);

	SELF.orig_ssn                := if(SELF.Prepped_rec_type<>'400',l.SSN, '');
	SELF.orig_dob                := if(SELF.Prepped_rec_type<>'400',l.DOB_CCYYMMDD,'');
	self.orig_phone              := l.PHONE_NUMBER;
	self.orig_gender             := l.gender;

	self.orig_crdt_ccyymmdd      :=CHOOSE(if(C % 25=0,25,C % 25)
																					,l.ADDR_CRDT_CCYYMMDD ,l.PA_CRDT_CCYYMMDD_1 ,l.PA_CRDT_CCYYMMDD_2 ,l.PA_CRDT_CCYYMMDD_3 ,l.PA_CRDT_CCYYMMDD_4
																					,l.PA_CRDT_CCYYMMDD_5 ,l.PA_CRDT_CCYYMMDD_6 ,l.PA_CRDT_CCYYMMDD_7 ,l.PA_CRDT_CCYYMMDD_8 ,l.PA_CRDT_CCYYMMDD_9
																					,l.PA_CRDT_CCYYMMDD_10,l.PA_CRDT_CCYYMMDD_12,l.PA_CRDT_CCYYMMDD_13,l.PA_CRDT_CCYYMMDD_14,l.PA_CRDT_CCYYMMDD_15
																					,l.PA_CRDT_CCYYMMDD_16,l.PA_CRDT_CCYYMMDD_17,l.PA_CRDT_CCYYMMDD_18,l.PA_CRDT_CCYYMMDD_19,l.PA_CRDT_CCYYMMDD_20
																					,l.PA_CRDT_CCYYMMDD_21,l.PA_CRDT_CCYYMMDD_22,l.PA_CRDT_CCYYMMDD_23,l.PA_CRDT_CCYYMMDD_24
																					);

	self.orig_updt_ccyymmdd      :=CHOOSE(if(C % 25=0,25,C % 25)
																					,l.ADDR_UPDT_CCYYMMDD ,l.PA_UPDT_CCYYMMDD_1 ,l.PA_UPDT_CCYYMMDD_2 ,l.PA_UPDT_CCYYMMDD_3 ,l.PA_UPDT_CCYYMMDD_4
																					,l.PA_UPDT_CCYYMMDD_5 ,l.PA_UPDT_CCYYMMDD_6 ,l.PA_UPDT_CCYYMMDD_7 ,l.PA_UPDT_CCYYMMDD_8 ,l.PA_UPDT_CCYYMMDD_9
																					,l.PA_UPDT_CCYYMMDD_10,l.PA_UPDT_CCYYMMDD_12,l.PA_UPDT_CCYYMMDD_13,l.PA_UPDT_CCYYMMDD_14,l.PA_UPDT_CCYYMMDD_15
																					,l.PA_UPDT_CCYYMMDD_16,l.PA_UPDT_CCYYMMDD_17,l.PA_UPDT_CCYYMMDD_18,l.PA_UPDT_CCYYMMDD_19,l.PA_UPDT_CCYYMMDD_20
																					,l.PA_UPDT_CCYYMMDD_21,l.PA_UPDT_CCYYMMDD_22,l.PA_UPDT_CCYYMMDD_23,l.PA_UPDT_CCYYMMDD_24
																					);

	self.dt_first_seen            := (unsigned)_validate.date.fCorrectedDateString(self.orig_crdt_ccyymmdd,false);
	self.dt_last_seen             := (unsigned)_validate.date.fCorrectedDateString(self.orig_updt_ccyymmdd,false);
	self.dt_vendor_first_reported := (unsigned)ver;
	self.dt_vendor_last_reported  := (unsigned)ver;

	SELF.fname                    := self.orig_fname;
	SELF.mname                    := self.orig_mname;
	SELF.lname                    := self.orig_lname;
	SELF.name_suffix              := self.orig_name_suffix;
	SELF.ssn                      := if((unsigned)self.orig_ssn > 0,self.orig_ssn, '');
	SELF.dob                      := (unsigned)_validate.date.fCorrectedDateString((string)self.orig_dob,false);
	self.phone                    := if((integer)self.orig_phone=0,'',self.orig_phone);
	SELF.IsCurrent                := self.Prepped_rec_type='000';
	SELF.IsUpdating               := true;
	SELF.src                      := 'EN';
	SELF                          := L;
	SELF                          := [];
END;

prepped1:= NORMALIZE(Exprn_credit, 101, t_prep(LEFT, COUNTER))(orig_fname<>'',orig_prim_name<>'');
prepped2:= distribute(prepped1,hash(EXPERIAN_ENCRYPTED_PIN));
prepped := dedup(prepped2,record,except prepped_rec_type,all,local) :independent;

NID.Mac_CleanParsedNames(prepped, cleanNames0
													, firstname:=orig_fname,middlename:=orig_mname,lastname:=orig_lname,namesuffix:=orig_name_suffix
													, includeInRepository:=true, normalizeDualNames:=true
												);
cleanNames := cleanNames0(nametype='P');

unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;		
AID.MacAppendFromRaw_2Line(cleanNames,Prepped_addr1,Prepped_addr2,RawAID,cleanAddr, lFlags);

Layouts.base tr(cleanAddr l) := TRANSFORM
	self.title := l.cln_title;
	self.fname := l.cln_fname;
	self.mname := l.cln_mname;
	self.lname := l.cln_lname;
	self.name_suffix := l.cln_suffix;

	self.RawAID     := l.aidwork_rawaid;
	self.prim_range := stringlib.stringfilterout(l.aidwork_acecache.prim_range,'.');
	self.prim_name  := stringlib.stringfilterout(l.aidwork_acecache.prim_name,'.^!$+<>@=%?*\'');
	self.sec_range  := stringlib.stringfilterout(l.aidwork_acecache.sec_range,'.>$!%*@=?&\'');
	self.v_city_name:= if(length(stringlib.stringfilterout(stringlib.stringtouppercase(l.aidwork_acecache.v_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,l.aidwork_acecache.v_city_name,'');
	self.p_city_name:= if(length(stringlib.stringfilterout(stringlib.stringtouppercase(l.aidwork_acecache.p_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,l.aidwork_acecache.p_city_name,'');
	self.zip        := l.aidwork_acecache.zip5;
	self.fips_st    := l.aidwork_acecache.county[1..2];
	self.fips_county:= l.aidwork_acecache.county[3..5];
	self.msa        := if(l.aidwork_acecache.msa='','',l.aidwork_acecache.msa+'0');
	self            := l.aidwork_acecache;
	self            := l;
END;

preprocess1 := project(cleanAddr,tr(left))(fname<>'',lname<>'',prim_name<>'');
preprocess2 := distribute(preprocess1,hash(EXPERIAN_ENCRYPTED_PIN));
preprocess  := dedup(preprocess2,record,except prepped_rec_type,all,local):persist('~thor_data400::persist::FCRA_ExperianCred_clean');


#IF (IsFullUpdate = true)

	base_and_update := preprocess;

#ELSE

	cur_base_d   := distribute(project(Files.Base, transform(Layouts.base, self.did := 0, self := left)), hash(EXPERIAN_ENCRYPTED_PIN));
	cur_update_d := dedup(distribute(preprocess, hash(EXPERIAN_ENCRYPTED_PIN)),record,all,local);
	cur_deletes_d := dedup(distribute(Files.Deletes_in, hash(EXPERIAN_ENCRYPTED_PIN)),EXPERIAN_ENCRYPTED_PIN,all,local);
	cur_deceased_d := dedup(distribute(Files.Deceased_in, hash(EXPERIAN_ENCRYPTED_PIN)),EXPERIAN_ENCRYPTED_PIN,all,local);

	apply_updates := join(cur_base_d, dedup(cur_update_d,EXPERIAN_ENCRYPTED_PIN,all,local)
										,left.EXPERIAN_ENCRYPTED_PIN = right.EXPERIAN_ENCRYPTED_PIN
										,left only
										,local)
										+
										cur_update_d
										;

	apply_deletes := join(distribute(apply_updates,hash(EXPERIAN_ENCRYPTED_PIN)), cur_deletes_d
									,left.EXPERIAN_ENCRYPTED_PIN = right.EXPERIAN_ENCRYPTED_PIN
							,transform(Layouts.base
								,self.IsDelete := if(left.EXPERIAN_ENCRYPTED_PIN=right.EXPERIAN_ENCRYPTED_PIN,true,left.IsDelete)
								,self:= left)
							,left outer
							,local);

	apply_deceased := join(apply_deletes, cur_deceased_d
									,left.EXPERIAN_ENCRYPTED_PIN = right.EXPERIAN_ENCRYPTED_PIN
							,transform(Layouts.base
								,self.IsDeceased := if(left.EXPERIAN_ENCRYPTED_PIN=right.EXPERIAN_ENCRYPTED_PIN and left.Prepped_rec_type<>'400',true,left.IsDeceased)
								,self:= left)
							,left outer
							,local);

	base_and_update := apply_deceased;

#END

EN_ready := base_and_update;
//-----------------------------------------------------------------
//Eliminate duplications
//-----------------------------------------------------------------
build_EN_base_d := distribute(EN_ready, hash(EXPERIAN_ENCRYPTED_PIN));  
build_EN_base_s := sort(build_EN_base_d
																	,EXPERIAN_ENCRYPTED_PIN
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
																	,phone
																	,ssn
																	,dob
																	,-dt_vendor_last_reported
																	,local);

Layouts.base t_rollup (build_EN_base_s  le, build_EN_base_s ri) := transform
 self.dt_first_seen            := ut.min2(le.dt_first_seen, ri.dt_first_seen);
 self.dt_last_seen             := ut.max2(le.dt_last_seen, ri.dt_last_seen);
 self.dt_vendor_first_reported := ut.min2(le.dt_vendor_first_reported, ri.dt_vendor_first_reported);
 self.dt_vendor_last_reported  := ut.max2(le.dt_vendor_last_reported, ri.dt_vendor_last_reported);
 self.IsCurrent                := if(le.IsCurrent=true,le.IsCurrent,ri.IsCurrent);
 self.IsUpdating               := if(le.IsUpdating=true,le.IsUpdating,ri.IsUpdating);

 self.SSN                      := if(le.IsUpdating=true,le.SSN,ri.SSN);
 self.dob                      := if(le.IsUpdating=true,le.dob,ri.dob);
 self.phone                    := if(le.IsUpdating=true,le.phone,ri.phone);

 self := le;
end;

FCRA_ExperianCred_base := rollup(build_EN_base_s
																	,   left.EXPERIAN_ENCRYPTED_PIN=right.EXPERIAN_ENCRYPTED_PIN
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
																	and left.phone=right.phone
																	and left.ssn=right.ssn
																	and left.dob=right.dob
																	,t_rollup(left, right)
																	,local);

//-----------------------------------------------------------------
//APPEND DID
//-----------------------------------------------------------------

matchset := ['A','Z','D','S','P'];

did_add.MAC_Match_Flex
	(FCRA_ExperianCred_base, matchset,					
	 ssn,dob, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st,phone, 
	 DID, Layouts.base, true, did_score,
	 75, d_did_0,true,src);

//-----------------------------------------------------------------
//INCREMENT DT_LAST_SEEN: IF IsDelete=false and IsUpdating=true and IsDeceased=false and IsCurrent=true
//-----------------------------------------------------------------
candidates		:=d_did_0(IsDelete=false and IsUpdating=true and IsDeceased=false and IsCurrent=true);
not_candidates:=d_did_0(IsDelete=true  or  IsUpdating=false or IsDeceased=true  or  IsCurrent=false);
d_did:=project(candidates
									,transform(layouts.base
											,self.dt_last_seen:=if((unsigned)ver > left.dt_first_seen, (unsigned)ver, left.dt_last_seen)
											,self:=left
											))
											+ not_candidates;

export ALL := d_did;

END;