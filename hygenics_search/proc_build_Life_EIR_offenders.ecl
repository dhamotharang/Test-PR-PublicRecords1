import ut,corrections,didville,did_add,doxie_build,census_data,codes;

export proc_build_Life_EIR_offenders(dataset(corrections_layout_offender) infile):= function

df4 := infile;
did_method := //'local';   // flex macro
		   //'remote'; // roxie
		   //'hash';   // hash through roxiepipe.
		  'none';	// if did'ing is not needed.
//-----------[ Simplified version ]------------------//

layout_offender into_offender(df4 L) := transform
	self.st := IF(L.st='',L.orig_state,L.st);
	self := l;
end;

o1 := project(df4,into_offender(LEFT));

//-----------[ DID Process ]------------------------//
o1_did := o1((integer)did != 0);
o1_nodid := distribute(o1((integer)did = 0),random());

seqrec := record
	o1_nodid;
	unsigned4	seq := 0;
end;

o1_nodid_s := table(o1_nodid,seqrec);

ut.MAC_Sequence_Records(o1_nodid_s,seq,o1_seq)

didville.Layout_Did_InBatch into_dib(o1_seq L) := transform
	self.phone10 := '';
	self.title := '';
	self.suffix := '';
	self.z5 := L.zip5;
	self := l;
end;

did_in := project(o1_seq, into_dib(LEFT));

didoutrec := record
	did_in;
	unsigned6	did;
	unsigned1 score;
	string9	ssn_added;
end;

#if(did_method = 'remote')
did_add.mac_match_fast_roxie(did_in,outf_rox,'','BEST_SSN','ALL',true,true)

didoutrec into_didout(outf_rox L) := transform
	self.ssn_added := L.best_ssn;
	self := l;
end;

outf := project(outf_rox,into_didout(LEFT));

#end

#if (did_method = 'local')
mymatchset := ['A','D','S','4','G','Z'];
did_add.mac_match_fast(did_in,mymatchset,outf_flex,false,true)

didoutrec into_didout2(outf_flex L) := transform
	self.ssn_added := L.best_ssn;
	self.score := L.did_score;
	self := L;
end;

outf := project(outf_flex,into_didout2(LEFT));

#end
#if (did_method = 'hash')
did_add.mac_match_hash_roxie(did_in,outf_hash)

didoutrec into_didout3(outf_hash L) := transform
	self.ssn_added := '';
	self.score := -1;
	self := l;
end;

outf := project(outf_hash,into_didout3(LEFT));

#end
#if (did_method = 'none')

didoutrec nochange(did_in L) := transform
	self.ssn_added := '';
	self.did := 0;
	self.score := 0;
	self := L;
end;

outf := project(did_in,nochange(LEFT));

#end
typeof(o1_did) into_orig(outf L, o1_seq R) := transform
	self.did := if (l.score != -1 and l.score < 75,'',intformat(l.did,12,1));
	self.ssn_appended := l.ssn_added;
	self.score := if (l.score = -1,'HSH',intformat(l.score,3,1));
	self := L;
	self := R;
end;

o1wd := o1_did + join(outf,o1_seq,left.seq = right.seq,into_orig(LEFT,RIGHT),hash);

//--------------------------------------------------//

layout_offender get_state_mapping1(o1wd L, codes.File_Codes_V3_In R) := transform
	self.place_of_birth := R.long_desc;
	self := L;
end;

o1a := join(o1wd,codes.File_Codes_V3_In(file_name = 'GENERAL', field_name= 'STATE_LONG'),
	left.place_of_birth != '' and
	right.code = left.place_of_birth,
	get_state_mapping1(LEFT,RIGHT),lookup, left outer);

layout_offender get_state_mapping2(o1a L, codes.File_Codes_V3_In R) := transform
	self.orig_state := R.long_desc;
	self := L;
end;

o1a2 := join(o1a,codes.File_Codes_V3_In(file_name = 'GENERAL', field_name= 'STATE_LONG'),right.code = left.orig_state,
		get_state_mapping2(LEFT,RIGHT),left outer, lookup);


layout_offender get_county_name(o1a2 L, Census_data.File_Fips2County r) := transform
	self.county_name := R.county_name;
	self := L;
end;

o1b := join(o1a2,Census_data.File_Fips2County, left.county_name != '' and left.county_name = right.county_fips and left.st = right.state_code,
		get_county_name(LEFT,RIGHT),left outer,lookup);

string fRemoveLeadingZeros(string pStringIn) //expects numbers only--TRIM IT FIRST!
 :=
   if(length(pStringIn)>=01,if(pStringIn[01]='0','',pStringIn[01]),'')
 + if(length(pStringIn)>=02,if(pStringIn[01..02]='00','',pStringIn[02]),'')
 + if(length(pStringIn)>=03,if(pStringIn[01..03]='000','',pStringIn[03]),'')
 + if(length(pStringIn)>=04,if(pStringIn[01..04]='0000','',pStringIn[04]),'')
 + if(length(pStringIn)>=05,if(pStringIn[01..05]='00000','',pStringIn[05]),'')
 + if(length(pStringIn)>=06,if(pStringIn[01..06]='000000','',pStringIn[06]),'')
 + if(length(pStringIn)>=07,if(pStringIn[01..07]='0000000','',pStringIn[07]),'')
 + if(length(pStringIn)>=08,if(pStringIn[01..08]='00000000','',pStringIn[08]),'')
 + if(length(pStringIn)>=09,if(pStringIn[01..09]='000000000','',pStringIn[09]),'')
 + if(length(pStringIn)>=10,if(pStringIn[01..10]='0000000000','',pStringIn[10]),'')
 + if(length(pStringIn)>=11,if(pStringIn[01..11]='00000000000','',pStringIn[11]),'')
 + if(length(pStringIn)>=12,if(pStringIn[01..12]='000000000000','',pStringIn[12]),'')
 ;

layout_offender tPostDIDPatch(layout_offender pInput)
 :=
  transform
	//self.Case_Type_Desc := if(pInput.Vendor = '01','Statewide Court',pInput.Case_Type_Desc);
	self.DID			:= if(pInput.Pty_Typ= '2' or pInput.DID = '000000000000','',pInput.DID);
	self.FBI_Num		:= if(stringlib.stringfilterout(pInput.FBI_Num,'0') = ''
						   or stringlib.stringfilterout(pInput.FBI_Num,'X') = ''
						   or stringlib.stringfilterout(pInput.FBI_Num,'x') = '',
							  '',
							  fRemoveLeadingZeros(trim(pInput.FBI_Num))
							 );
	self.DLE_Num		:= if(stringlib.stringfilterout(pInput.DLE_Num,'0') = ''
						   or stringlib.stringfilterout(pInput.DLE_Num,'X') = ''
						   or stringlib.stringfilterout(pInput.DLE_Num,'x') = '',
							  '',
							  pInput.DLE_Num
							 );
	self.ID_Num			:= if(stringlib.stringfilterout(pInput.ID_Num,'0') = ''
						   or stringlib.stringfilterout(pInput.ID_Num,'X') = ''
						   or stringlib.stringfilterout(pInput.ID_Num,'x') = '',
							  '',
							  pInput.ID_Num
							 );
	self.SSN			:= if(stringlib.stringfilterout(pInput.SSN,'0') = ''
						   or stringlib.stringfilterout(pInput.SSN,'X') = ''
						   or stringlib.stringfilterout(pInput.SSN,'x') = '',
							  '',
							  pInput.SSN)
							 ;
	self.fname			:= if(pInput.fname = '' and pInput.mname = '' and pInput.lname='',
							  pInput.Pty_Nm,
							  pInput.fname
							 );
	self.Pty_Typ		:= if(pInput.Pty_Typ = '2','2','0');
	self				:= pInput;
  end
 ;

dPostDIDPatched 			:= project(o1b,tPostDIDPatch(left));
/*
dPostDIDPatchedDistributed 	:= sort(distribute(dPostDIDPatched,hash(Offender_Key)),offender_key,local);
dGroupedPostDIDReady 		:= group(dPostDIDPatchedDistributed,Offender_Key,local);

Corrections.Macro_Fill_Blank_Offender_Traits(dGroupedPostDIDReady,FBI_Num,dGroupedPostDID_FBINum_Filled)
Corrections.Macro_Fill_Blank_Offender_Traits(dGroupedPostDID_FBINum_Filled,ID_Num,dGroupedPostDID_IDNum_Filled)
Corrections.Macro_Fill_Blank_Offender_Traits(dGroupedPostDID_IDNum_Filled,DLE_Num,dGroupedPostDID_DLENum_Filled)
Corrections.Macro_Fill_Blank_Offender_Traits(dGroupedPostDID_DLENum_Filled,Sex,dGroupedPostDID_Sex_Filled)
Corrections.Macro_Fill_Blank_Offender_Traits(dGroupedPostDID_Sex_Filled,Race_Desc,dGroupedPostDID_Race_Desc_Filled)
Corrections.Macro_Fill_Blank_Offender_Traits(dGroupedPostDID_Race_Desc_Filled,Hair_Color_Desc,dGroupedPostDID_Hair_Color_Desc_Filled)
Corrections.Macro_Fill_Blank_Offender_Traits(dGroupedPostDID_Hair_Color_Desc_Filled,Eye_Color_Desc,dGroupedPostDID_Eye_Color_Desc_Filled)
Corrections.Macro_Fill_Blank_Offender_Traits(dGroupedPostDID_Eye_Color_Desc_Filled,Skin_Color_Desc,dGroupedPostDID_Skin_Color_Desc_Filled)
Corrections.Macro_Fill_Blank_Offender_Traits(dGroupedPostDID_Skin_Color_Desc_Filled,Place_Of_Birth,dGroupedPostDID_Place_Of_Birth_Filled)

dMoxieFile := group(dGroupedPostDID_Place_Of_Birth_Filled);
*/

dpost1 := dpostDidPatched;

dpost1 get_CO_origin(dpost1 L, codes.File_Codes_V3_In R) := transform
	self.county_of_origin := R.long_desc;
	self := L;
end;

dpost2 := join(dpost1,codes.File_Codes_V3_In(file_name= 'CRIM_OFFENDER2'), right.field_name = 'VENDOR' and
					left.vendor = right.code,
					get_CO_origin(LEFT,RIGHT),left outer,lookup);


dpost2 get_datasource(dpost2 L, codes.File_Codes_V3_In R) := transform
	self.datasource := r.long_desc;
	self := L;
end;

dpostfinal := join(dpost2,codes.File_Codes_V3_In(file_name = 'CRIM_OFFENDER2'),
				right.field_name = 'DATA_TYPE' and left.data_type = right.code,
				get_datasource(LEFT,RIGHT),left outer, lookup);

//ut.MAC_SF_BuildProcess(dpostfinal,'~thor_Data400::base::corrections_offenders_' + doxie_build.buildstate,a,2)

return dpostfinal;
end;
