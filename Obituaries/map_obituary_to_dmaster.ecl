import	Obituaries,Header,ut,address,DID_Add, lib_ziplib, RoxieKeyBuild;
#stored('did_add_force','thor');

EXPORT map_obituary_to_dmaster(string filedate) := FUNCTION

ds_obit := dataset('~thor_data400::base::obituary_death_master',Obituaries.layouts.layout_reor_tribute,flat);

layout_obit_did := RECORD
	integer uniqueid;
	unsigned6 did:=0;
	unsigned did_score :=0;
	boolean resolved:= true;
	string first_name;
	string middle_name;
	string last_name;
	string dob;
	string dod;
	string city;
	string state;
	string spouses_fname:='';
	string zip := '';
	string prim_range:='';
	string prim_name := '';
	string sec_range := '';
	string phone := '';
	string suffix := '';
	string predir :='';
	string addr_suffix:='';
	string postdir :='';
	string unit_desig:='';
	string zip4:='';
	string ssn5:='';
	string ssn4:='';
	string src := 'TR';
	string1  state_death_flag := 'N';
	string3	death_rec_src := 'TRB';
END;

layout_obit_did obitcln(Obituaries.layouts.layout_reor_tribute l) := TRANSFORM
   tempdod := l.death_year + l.death_month + l.death_day;
   tempdob1 := l.birth_year + l.birth_month + l.birth_day;
   tempdob := IF((l.birth_year='') and (l.age<>'')
                     , ((integer)ut.getdate[1..4] - (integer)trim(l.age,left,right))+'0000'
                     , tempdob1
                 );
	STRING73 clean_name  := IF(TRIM(l.mname) = '',
														address.CleanPersonFML73(StringLib.StringToUpperCase(TRIM(TRIM(l.fname) + ' ' +
																																								 TRIM(l.mname) + ' ' +
																																								 TRIM(l.lname)))),
														address.CleanPersonLFM73(StringLib.StringToUpperCase(TRIM(TRIM(l.lname) + ', ' + 
																																								 TRIM(l.fname) + ' ' +
																																								 TRIM(l.mname))))
														);
	 self.uniqueid          := (integer)l.person_id;
   self.first_name        := clean_name[6..25];
   self.middle_name       := clean_name[26..45];
   self.last_name         := clean_name[46..65];
	 self.suffix						:= clean_name[66..70];
   self.dob               := tempdob;
   self.dod               := tempdod;
   self.city              := l.location_city;
   self.state             := l.location_state;
	 self.zip								:= ziplib.CityToZip5(l.location_state, l.location_city);
   self.spouses_fname     := l.spouses_name;
	 self	:= l;
END;

ObitClean_out := project(ds_obit,obitcln(left));

//DID_Add.mac_match_flex_ADL2(ObitClean_out,obits_with_dids);

matchset	:=	['D','G','Z'];

DID_Add.MAC_Match_Flex(ObitClean_out,matchset,
													foo,dob,
													first_name,middle_name,last_name,suffix,
													foo,foo,foo,zip,state,foo,
													did,layout_obit_did,
													true,did_score,90,
													obits_with_dids,true,src);

layout_obit_combined	:= RECORD
recordof(ds_obit);
recordof(obits_with_dids);
END;	

ds_obits_with_dids :=
           join(ds_obit
                ,obits_with_dids
                ,left.person_id=(string)right.uniqueid
                ,transform(layout_obit_combined
                           ,self.person_id := IF(right.uniqueid = 0, left.person_id, (string)right.uniqueid)
													 ,self.fname := right.first_name
													 ,self.mname	:= right.middle_name
													 ,self.lname	:= right.last_name
													 ,self.name_suffix := right.suffix
                           ,self := left
													 ,self := right
                 )
                ,LEFT OUTER);

//Map to death_masterv3 output - No longer necessary to build v1 and v2 versions as this will be done in the
//death_master build process -- slucero 10/17/13 Bug #130655
header.Layout_Did_Death_MasterV3 map_dmasterv3(ds_obits_with_dids l)	:= TRANSFORM
		self.DID	:=	intformat(l.DID,12,1);
		self.DID_SCORE := l.DID_SCORE;
		tempdod := l.death_year + l.death_month + l.death_day;
		tempdob1 := l.birth_year + l.birth_month + l.birth_day;
		tempdob := IF((l.birth_year='') and (l.age<>'')
                     , (string)(2012 - (integer)trim(l.age,left,right))+'0000'
                     , tempdob1
                 );
		self.dod8	:= tempdod;
		self.dob8	:= tempdob;
		STRING182 clean_address1 := Address.CleanAddress182('',StringLib.StringToUpperCase(TRIM(l.city,LEFT,RIGHT) + ', ' + 
																																										 TRIM(l.state,LEFT,RIGHT) )
																												);
		self.zip_lastres := clean_address1[117..121];
		self.fipscounty	:= clean_address1[143..145];
		self.state_death_id := intformat((integer)l.person_id,16,1);
		self.src := 'TR';
	  self.GLB_flag := 'N';
		self	:= l;
		self  := [];
END;
	
ds_obits_dmasterv3	:= dedup(project(ds_obits_with_dids,map_dmasterv3(left)));

RoxieKeyBuild.Mac_SF_BuildProcess(ds_obits_dmasterv3,'~thor_data400::base::did_death_masterv3_tributes','~thor_data400::base::did_death_masterv3_tributes_'+filedate, build_obit_d_mastv3,3);

return build_obit_d_mastv3;

END;
