import ingenix_natlprof, did_add, ut, header_slimsort, didville,watchdog;

file_in := Ingenix_NatlProf.File_in_Clean_Provider;

Pre_DID_Rec
 :=
  record
	ingenix_natlprof.Layout_In_Clean_Provider;
	string	temp_DOB 		:= '';
	integer8	temp_DID		:= 0;
	integer8	temp_DID_SCORE	:= 0;
	
  end
 ;

Pre_DID_Rec taddDID(file_in L)
 :=
  transform
	self.temp_DOB	:=	L.birthdate;
	self			:=	L;
  end
 ;

PreDID	:= project(file_in,taddDID(left));

matchset :=['A','D','P'];

did_Add.MAC_Match_Flex(PreDID, matchset,
	 '', temp_DOB, Prov_Clean_fname, Prov_Clean_mname,Prov_Clean_lname, Prov_Clean_name_suffix, 
	 Prov_Clean_prim_range, Prov_Clean_prim_name, Prov_Clean_sec_range, Prov_Clean_zip, Prov_Clean_st,phonenumber,
	 temp_did,   			
	 Pre_DID_Rec, 
	 true, temp_did_score,	
	 75,	
	 postDID)

PostDIDpersist0	:=	PostDID;

w:=watchdog.file_best;
PostDIDpersist:=join(distribute(PostDIDpersist0,hash((unsigned6)temp_did)),w
				,(unsigned6)left.temp_did=right.did
				,transform(Pre_DID_Rec
					,self.temp_did:=if(
													(integer)left.birthdate>0
											and right.dob>0
											and left.birthdate[1..4]<>((string)right.dob)[1..4]
												,0,left.temp_did
												);
					,self.temp_did_score:=if(self.temp_did=0,0,left.temp_did_score)
					,self:=left
					)
				,left outer
				,local);

DID_rec := record

string12 DID;
string3   DID_SCORE;
ingenix_natlprof.Layout_In_Clean_Provider;

end;

ingenix_natlprof.Layout_provider_base_rid tdid(PostDIDpersist L)
 :=
  transform
	self.DID		:=	intformat(L.temp_DID,12,1);
	self.DID_SCORE	:=	(string3)L.temp_DID_SCORE;
	self.source_rec_id := hash64 (L.providerid,L.firstname,L.lastname,L.filetyp,L.middlename,L.addressid,L.suffix,L.gender,L.providernamecompanycount,L.providernametierid,L.address,L.address2,L.city,L.state,L.county,L.zip,L.extzip,L.highrisk,L.provideraddresscompanycount,L.provideraddresstiertypeid,L.provideraddresstypecode,L.provideraddressverificationstatuscode,L.provideraddressverificationdate,L.birthdate,L.birthdatecompanycount,L.birthdatetiertypeid,L.taxid,L.taxidcompanycount,L.taxidtiertypeid,L.phonenumber,L.phonetype,L.phonenumbercompanycount,L.phonenumbertiertypeid,L.optoutsitedescription,L.affidavitreceiveddate,L.optouteffectivedate,L.dateoptoutterminationdate,L.optoutstatus,L.deceasedindicator,L.deceaseddate);	
	self            := L;
	
	end;
	
export provider_DID := project(PostDIDpersist, tdid(left)):persist('~thor_data400::persist::ingenix_provider_did');