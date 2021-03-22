import _control, AutoKeyB2,Address,autokey,AutoKeyI, MDR, ut, codes, Std,dx_common;

export proc_build_autokeys(string filedate) := function

/////////////////////////////////////////////////////////////////////////////////
// -- Prepped for Macro & Removed Child Records from file
/////////////////////////////////////////////////////////////////////////////////
pty := SANCTN.file_base_party;
inc := sort(table(SANCTN.file_base_incident
				,{BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER,incident_date_clean,AG_CODE}
				,BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER,incident_date_clean,AG_CODE,few)
				,BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER,incident_date_clean,AG_CODE);
				
pty_aka_dba	:= SANCTN.file_base_party_aka_dba;

xpnd_sanctn := RECORD
SANCTN.layout_autokeys;
  INTEGER8 zero := 0;
	blk  := '';
	//CCPA-283 Adding CCPA new fields
	UNSIGNED8 record_sid:=0;
    UNSIGNED4 global_sid:=0;
    UNSIGNED4 dt_effective_first:=0;
    UNSIGNED4 dt_effective_last:=0;
    UNSIGNED1 delta_ind := 0;

END;

xpnd_sanctn xpand_sanctn(pty L, inc R) :=  TRANSFORM

self.AG_CODE 	   := if(l.BATCH_NUMBER = r.BATCH_NUMBER and 
											 l.INCIDENT_NUMBER = r.INCIDENT_NUMBER and 
											 l.PARTY_NUMBER = r.PARTY_NUMBER
														,R.AG_CODE,'');
self.INCIDENT_DATE := if(l.BATCH_NUMBER = r.BATCH_NUMBER and 
												l.INCIDENT_NUMBER = r.INCIDENT_NUMBER and
												l.PARTY_NUMBER = r.PARTY_NUMBER
														,R.incident_date_clean,'');
self.SSNUMBER			:= stringlib.stringfilterout(l.ssnumber,'-');
//populate st field when instate exists and all other address fields are blank and address cleaner does not return a state.
self.st 					:= IF(L.st='' and length(trim(L.instate))=2 and L.incity='' and L.inzip='' and L.inaddress='' and  codes.valid_st(L.instate),
												trim(L.instate),
												L.st);
				 
self               := L; 
END;


DS_sanctn := dedup(join(pty,inc,
				  left.BATCH_NUMBER = right.BATCH_NUMBER and 
				  left.INCIDENT_NUMBER = right.INCIDENT_NUMBER  and
					left.PARTY_NUMBER = right.PARTY_NUMBER,
				  xpand_sanctn(left,right),left outer,lookup),record,all);


// Including PARTY AKA/DBA Records
sanctn_pty_aka		:= RECORD
	SANCTN.layout_SANCTN_aka_dba_out;
	STRING5  title;
	STRING20 fname;
	STRING20 mname;
	STRING20 lname;
	STRING5  name_suffix;
	STRING3  name_score;
END;


sanctn_pty_aka	xpand_sanctn_aka_cln(pty_aka_dba	 L) :=  TRANSFORM
tempPName    			:= if(L.NAME_TYPE = 'A',Address.CleanPersonFML73(L.AKA_DBA_TEXT),'');
CleanPName   			:= if(NOT((INTEGER)tempPName[71..73] < 80),trim(tempPName),'');
self.title 	 			:= if(NOT((INTEGER)tempPName[71..73] < 80) AND tempPName <> '',CleanPName[1..5],'');
self.fname 	 			:= if(NOT((INTEGER)tempPName[71..73] < 80) AND tempPName <> '',CleanPName[6..25],'');
self.mname 	 			:= if(NOT((INTEGER)tempPName[71..73] < 80) AND tempPName <> '',CleanPName[26..45],'');
self.lname 	 			:= if(NOT((INTEGER)tempPName[71..73] < 80) AND tempPName <> '',CleanPName[46..65],'');
self.name_suffix 	:= if(NOT((INTEGER)tempPName[71..73] < 80) AND tempPName <> '',CleanPName[66..70],'');
self.name_score 	:= if(NOT((INTEGER)tempPName[71..73] < 80) AND tempPName <> '',CleanPName[71..73],'');

self               := L; 
END;

ds_CleanParsedAKA	:= project(pty_aka_dba,xpand_sanctn_aka_cln(left));



xpnd_sanctn	 xpand_sanctn_aka(ds_CleanParsedAKA	 L) :=  TRANSFORM
self.cname						:= IF(L.NAME_TYPE = 'D',L.AKA_DBA_TEXT,'');
self.did							:= 0;
self.bdid							:= 0;
self 	:= L; 
self	:= [];
END;

DS_sanctn_AKA	:= project(ds_CleanParsedAKA,xpand_sanctn_aka(left));

DS_sanctn_combine	:= DS_sanctn + DS_sanctn_AKA;

addGlobalSID := MDR.macGetGlobalSid(DS_sanctn_combine, 'Sanctn', '', 'global_sid'); //DF-25379: Populate Global_SIDs

// Address.MAC_Multi_City(DS_sanctn,p_city_name,zip5,multiCitysanctn);
// dist_DSsanctn := distribute(multiCitysanctn,random());

/////////////////////////////////////////////////////////////////////////////////
// -- Initialize AutoKey Macro
/////////////////////////////////////////////////////////////////////////////////

c		:= SANCTN.constants;
ak_dataset := addGlobalSID;
ak_keyname := c.ak_keyname;
ak_logical := c.ak_logical(filedate);
ak_setSkip	:= c.skipSet;
ak_typeStr	:= c.type_str; 

// ak_keyname := '~thor_data400::key::sanctn::@version@::autokey::';
// ak_logical := '~thor_data400::key::sanctn::' + filedate + '::autokey::';
// set_skip := ['P','Q','S','F'];//keys to omit building
		//P in this set to skip personal phones
		//Q in this set to skip business phones
		//S in this set to skip SSN
		//F in this set to skip FEIN
		//C in this set to skip ALL personal (Contact) data
		//B in this set to skip ALL Business data


autokey.mac_useFakeIDs(ak_dataset
												,ds_withFakeID_AKB
												,proc_build_payload_key_AKB
												,ak_keyname
												,ak_logical
												,did
												,zero
												) 
	 
ds_forLayoutMaster_AKB := ds_withFakeID_AKB; 

zero := 0;
string_zero := '0';
	 
ds_inLayoutMaster_AKB :=  
	project( 
		ds_forLayoutMaster_AKB, 
		transform( 
			autokey.layouts.master, 
			self.inp.fname := left.fname; 
			self.inp.mname := left.mname; 
			self.inp.lname := left.lname; 
			self.inp.ssn := if(left.ssnumber != '',left.ssnumber,left.ssn_appended); 
			self.inp.dob := zero; 
			self.inp.phone := string_zero; 
			self.inp.prim_name := left.prim_name; 
			self.inp.prim_range := left.prim_range; 
			self.inp.st := left.st; 
			self.inp.city_name := left.v_city_name; 
			self.inp.zip := (string6)left.zip5; 
			self.inp.sec_range := left.sec_range; 
			self.inp.states := zero; 
			self.inp.lname1 := zero; 
			self.inp.lname2 := zero; 
			self.inp.lname3 := zero; 
			self.inp.city1 := zero; 
			self.inp.city2 := zero; 
			self.inp.city3 := zero; 
			self.inp.rel_fname1 := zero; 
			self.inp.rel_fname2 := zero; 
			self.inp.rel_fname3 := zero; 
			self.inp.lookups := zero; 
			self.inp.DID := (unsigned6)left.did; 
			self.inp.bname := left.cname; 
			self.inp.fein := if((integer)left.blk=0,'',(string9)left.blk); 
			self.inp.bphone := string_zero; 
			self.inp.bprim_name := left.prim_name; 
			self.inp.bprim_range := left.prim_range; 
			self.inp.bst := left.st; 
			self.inp.bcity_name := left.v_city_name; 
			self.inp.bzip := (string5)left.zip5; 
			self.inp.bsec_range := left.sec_range; 
			self.inp.BDID := (unsigned6)left.bdid; 
			self.FakeID := left.FakeID; 
			self.p := []; 
			self.b := []; 
		) 
	); 
	  
	 
mod_AKB := module(AutokeyB2.Fn_Build.params) 
	export dataset(autokey.layouts.master) L_indata := ds_inLayoutMaster_AKB; 
	export string L_inkeyname := ak_keyname; 
	export string L_inlogical := ak_logical; 
	export boolean L_diffing := false; 
	export boolean L_Biz_useAllLookups := true; 
	export boolean L_Indv_useAllLookups := true; 
	export boolean L_by_lookup := true; 
	export boolean L_skipaddrnorm := false; 
	export boolean L_skipB2behavior := false; 
	export boolean L_useOnlyRecordIDs := true; 
	export boolean L_useFakeIDs := true; 
	export boolean L_AddCities := true; 
	export integer L_Biz_favor_lookup := 0; 
	export integer L_Indv_favor_lookup := 0; 
	export integer L_Rep_addr := 4; 
	export set of string1 L_build_skip_set  := ak_setSkip; 
end; 
	 
bld_sanctn_auto :=  
	parallel(proc_build_payload_key_AKB 
					,AutokeyB2.Fn_Build.Do(mod_AKB,AutoKeyI.BuildI_Indv.DoBuild
					,AutoKeyI.BuildI_Biz.DoBuild) 
					); 
	 
	


/////////////////////////////////////////////////////////////////////////////////
// -- Move AutoKeys to QA
/////////////////////////////////////////////////////////////////////////////////

// AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, move2qa,,ak_setSkip)
	AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname,move2qa);

retval := sequential(bld_sanctn_auto,move2qa);

 
return retval;

end;

