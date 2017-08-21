import crim_common, lib_stringlib, crim, address;

comb_layout := record, maxlength(4096)
string ID;
string Name;
string FirstName;
string MiddleName;
string LastName;
string Suffix;
string DateOfBirth;
string Address1;
string City;
string State;
string Zip;
string Alias;
string Caption;
string PreliminaryCaseNumber;
string Jurisdiction;
string Attorney;
string ActionCode;
string Description;
string Degree;
string ChargeDscr;
string OffenseDate;
string ArrestDate;
string Officer;
string Complainant;
string Prosecutor;
string Judge;
string CaseNumber;
string CaseFiled;
string CaseStatus;
string CaseComments;
string PartiesName;
string PartiesType;
string DispositionStatus;
string DispositionStatusDate;
string DispositionCode;
string DispositionDate;
string DispositionActionCode;
string Charge_Number;
string Charge_PleaCode;
string Charge_PleaCodeDate;
string Charge_Decision;
string Charge_DecisionDate;
string Charge_DispositionDate;
string Charge_DispositionCode;
string Charge_TicketNumber;
string Charge_ActionCode;
string Charge_OffenseDescription;
string Charge_Description;
string Charge_DegreeOfOffense;
string Charge_IndictCharge;
string Charge_AMD_Charge;
string Charge_AMD_Charge_DGOF;
string Charge_ACNT_Change_Date;
string Charge_Counts;
string Charge_Misc_Track;
string DispositionCde;
string HazMat;
string Points;
string PriorConviction;
string VehicleYear;
string StateCode;
string LicenseCode;
string LicenseNumber;
string VehicleCode;
string PlateNumber;
string PrimaryStr;
string SecondaryStr;
string OfficerCode;
string SpeedLimit;
string Speed;
string TicketNumber;
string DegreeOfOffense;
string ChargeDescription;
end;


austintown := crim.file_oh_mahoning.austintown;
boardmand := crim.file_oh_mahoning.boardman;
canfield := crim.file_oh_mahoning.canfield;
commonpleas := crim.file_oh_mahoning.commonpleas;
sebring := crim.file_oh_mahoning.sebring;

comb_layout reformatall(crim.Layout_OH_Mahoning.austintown l) := transform
	self.address1 := l.address;
	self := l;
	self := [];
end;

comb_layout reformatall2(crim.Layout_OH_Mahoning.commonpleas l) := transform
	self.address1 := l.address;
	self := l;
	self := [];
end;

inputMain := project(crim.File_OH_Mahoning.austintown + crim.File_OH_Mahoning.canfield + crim.File_OH_Mahoning.boardman + crim.File_OH_Mahoning.sebring, reformatall(left));
inputCommon := project(crim.File_OH_Mahoning.commonpleas, reformatall2(left));

combinedD := inputMain(name <> 'Name' and PartiesType = 'DEFENDANT') + inputCommon(name <> 'Name' and PartiesType = 'DEFENDANT');

combinedD NormAlias(comb_layout L, integer c) := TRANSFORM
	SELF.alias := trim(regexreplace('AKA', l.PartiesName[stringlib.Stringfind(l.PartiesName,'AKA',c)+3..stringlib.Stringfind(l.PartiesName + 'AKA','AKA',c+1)-1], ''), left, right);
	SELF := l;
END;

combined1 := NORMALIZE(combinedD(alias = '' and regexfind('AKA', PartiesName)), stringlib.stringfindcount(left.PartiesName, 'AKA') ,NormAlias(left, counter));

combinedD reformat(comb_layout L) := TRANSFORM
	SELF.alias := '';
	SELF := l;
END;

combined2 := project(combinedD(alias <> '') + combined1, reformat(left));


Crim_Common.Layout_In_Court_Offender tOHOffend(comb_layout l) := Transform

string casename(string caption, string casenumber) := regexreplace( '( [A-Z][A-Z][A-Z])$',trim(if(caption <> '' and casenumber <> '', regexreplace(casenumber, caption, ''), l.caption), left, right), '')
;
string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date		:= Crim_Common.Version_Production;
self.offender_key		:= '2O'+trim(l.CaseNumber,left,right)+fSlashedMDYtoCYMD(trim(l.CaseFiled,left,right))+l.id;
self.vendor				:= '2O';
self.state_origin		:= 'OH';
self.data_type			:= '2';
self.source_file		:= 'OH Mahoning Crim Ct';
self.case_number		:= trim(l.casenumber,left,right);
self.case_court			:= '';
self.case_name			:= if(regexfind('vs', casename(l.caption, l.casenumber)),casename(l.caption, l.casenumber),'');
self.case_type			:= '';
self.case_type_desc		:= '';
self.case_filing_dt		:= if(fSlashedMDYtoCYMD(l.CaseFiled) between '19010101' and Crim_Common.Version_Production, fSlashedMDYtoCYMD(l.CaseFiled), '');
self.pty_nm				:= trim(regexreplace('[^a-zA-Z \\-,]', if(l.alias <> '', l.alias, l.lastname + ', ' + l.firstname), ''), left, right);
self.pty_nm_fmt			:= if(l.alias <> '' and ~regexfind(',', l.alias), 'F', 'L');
self.orig_lname			:= '';
self.orig_fname			:= '';     
self.orig_mname			:= '';
self.orig_name_suffix	:= '';
self.pty_typ			:= if(l.alias <> '', '2', '0');
self.nitro_flag			:= '';
self.orig_ssn			:= '';
self.dle_num			:= '';
self.fbi_num			:= '';
self.doc_num			:= '';
self.ins_num			:= '';
self.id_num				:= l.id;
self.dl_num				:= l.LicenseNumber;
self.dl_state			:= l.statecode[1..2];
self.citizenship		:= '';
self.dob				:= if(fSlashedMDYtoCYMD(l.dateofbirth) between '19010101' and (string)((integer)Crim_Common.Version_Production - 18), fSlashedMDYtoCYMD(l.dateofbirth), '');
self.dob_alias			:= '';
self.place_of_birth		:= '';
self.street_address_1	:= trim( regexreplace('^(c.o )|^(C.O )|(dba)|(DBA)|(lna)|(LNA)|(lka)|(LKA)' , if(~regexfind('(UNKNOWN)|^(\\(ALSO\\))|^(AKA)|^(A\\K\\A)|^(DBA)|^(D\\B\\A)|(AKA )',l.address1) and length(trim(l.address1)) > 7,	trim(stringlib.stringfilterout(l.address1, '%'),left,right),''), ''), left, right);
self.street_address_2	:= '';
self.street_address_3	:= if(regexfind('(AKA)|(UNKOWN)|(UNKNOWN)|(ACCIDENT)|(ADDRESS)|([^A-Z \\.\\-])', l.city) or length(regexreplace('\\.',l.city, ' ')) < 5, '', trim(regexreplace('\\.',l.city, ' '),left,right));
self.street_address_4	:= if(l.state in ['AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL','GA','GU','HI','ID','IL','IN','IA','KS','KY','LA','ME','MH','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','MP','OH','OK','OR','PW','PA','PR','RI','SC','SD','TN','TX','UT','VT','VI','VA','WA','WV','WI','WY','AE','AA','AE','AE','AE','AP'], trim(l.state,left,right), '');
self.street_address_5	:=  if((length(trim(l.zip,left,right)) = 5 or length(trim(l.zip,left,right)) = 9) and
							 regexfind('[1-9]', l.zip), trim(l.zip,left,right),'');
self.race				:= '';
self.race_desc			:= '';
self.sex				:= '';
self.hair_color			:= '';
self.hair_color_desc	:= '';
self.eye_color			:= '';
self.eye_color_desc		:= '';
self.skin_color			:= '';
self.skin_color_desc	:= '';
self.height				:= '';
self.weight				:= '';
self.party_status		:= '';
self.party_status_desc	:= '';
self.prim_range 		:= ''; 
self.predir 			:= '';					   
self.prim_name 			:= '';
self.addr_suffix 		:= '';
self.postdir 			:= '';
self.unit_desig 		:= '';
self.sec_range 			:= '';
self.p_city_name 		:= '';
self.v_city_name 		:= '';
self.state 				:= '';
self.zip5 				:= '';
self.zip4 				:= '';
self.cart 				:= '';
self.cr_sort_sz 		:= '';
self.lot 				:= '';
self.lot_order 			:= '';
self.dpbc 				:= '';
self.chk_digit 			:= '';
self.rec_type 			:= '';
self.ace_fips_st		:= '';
self.ace_fips_county	:= '';
self.geo_lat 			:= '';
self.geo_long 			:= '';
self.msa 				:= '';
self.geo_blk 			:= '';
self.geo_match 			:= '';
self.err_stat 			:= '';
self.title 				:= '';
self.fname 				:= '';
self.mname 				:= '';
self.lname 				:= '';
self.name_suffix 		:= '';
self.cleaning_score 	:= ''; 

end;

pOHOffend := project(combinedD + combined1 + combined2, tOHOffend(left));

Crim.Crim_clean(pOHOffend,cleanOHOffend);

fOHOffend := dedup(sort(distribute(cleanOHOffend(regexfind('[a-zA-Z]', pty_nm) and ~regexfind('[0-9]|\\&', pty_nm)),hash(offender_key)),
										offender_key,case_number,case_court,pty_nm,pty_nm_fmt,pty_typ,dob,local),
										offender_key,pty_nm,pty_typ,local,left): 
										PERSIST('~thor_dell400::persist::Crim_OH_Mahoning_Offender_Clean');


export Map_OH_Mahoning_Offender := fOHOffend;