import Address, Ut, lib_stringlib, _Control, business_header,_Validate, mdr,IDA,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID,std,VersionControl;

export _FN_Did_Reappend (string pversion='', boolean pUseProd=false, boolean pdaily=false) := module

shared version:=if(pversion='',(string8)std.date.today(),pversion):INDEPENDENT;

shared fullbase := IDA.Files(pversion,pUseProd).base.built;

matchset := ['A','Z','D','P'];
	 did_add.MAC_Match_Flex
	 (fullbase, matchset,					
	 ssn, clean_dob, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st, clean_phone, 
	 DID,IDA.Layouts.base, false, DID_Score_field, 
	 75, d_did)
	 
//Append ADL_ind
Watchdog.Mac_append_ADL_ind(d_did, Updated_Base);

shared reapendedbase:= Updated_Base;

j := JOIN(fullbase, reapendedbase,
          LEFT.did=RIGHT.did AND LEFT.clientassigneduniquerecordid=RIGHT.clientassigneduniquerecordid,
					TRANSFORM(IDA.Layouts.Base,
					SELF:=LEFT;
	      ),RIGHT ONLY);
				
shared basechanges:=		j;				

	VersionControl.macBuildNewLogicalFile( 
																				 IDA.Filenames(version,pUseProd).BaseChange.new	
																				,basechanges
																				,Build_Base_Change_File
																			 );
																						
				
	VersionControl.macBuildNewLogicalFile( 
																				 IDA.Filenames(version + 'R',pUseProd).base.new	
																				,reapendedbase
																				,Build_Did_Reappended_Base_File
																			 );
																			 
export Build_Base_Change :=
		sequential(Build_Base_Change_File
							,IDA.Promote(version,pUseProd,pDaily).BuildBaseChangefiles.New2Built
							,IDA.Promote(version,pUseProd,pDaily).BuildBaseChangefiles.Built2QA
);
																						 
export Build_Reappended_Base :=
		sequential(Build_Did_Reappended_Base_File
							,IDA.Promote(version + 'R',pUseProd,pDaily).BuildAccumulativefiles.New2Built
							,IDA.Promote(version + 'R',pUseProd,pDaily).BuildAccumulativefiles.Built2QA
);

seq:=SEQUENTIAL(Build_Base_Change,Build_Reappended_Base);

export All :=
		if(VersionControl.IsValidVersion(version)
			,seq
			,output('No Valid version parameter passed, skipping build')
		);

end;
