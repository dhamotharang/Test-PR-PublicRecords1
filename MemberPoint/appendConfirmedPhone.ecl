import progressive_phone,addrbest,STD,address;

EXPORT appendConfirmedPhone (dataset(MemberPoint.Layouts.BatchInter) MinorsOnly, MemberPoint.IParam.BatchParams BParams,boolean isMinor  = true) 
																																																			:= function
																																																			
	PhoneBatchIn := project(MinorsOnly, transform(progressive_phone.layout_progressive_batch_in,
					self.did := [],//left.did,
					self.acctno :=left.acctno,
					self.ssn := [],// left.ssn,
					self.name_first :=  [],//left.name_first,
					self.name_middle :=  [],//left.name_middle,
					self.name_last :=  [],//left.name_last,
					self.name_suffix :=  [],//left.name_suffix,
					self.dob :=  [],//left.dob,
					self.phoneno := left.primary_phone_number,
					self.prim_range := left.prim_range,
					self.predir := left.predir,
					self.prim_name := left.prim_name,
					self.suffix := left.addr_suffix,
					self.postdir := left.postdir,
					self.unit_desig := left.unit_desig,
					self.sec_range := left.sec_range,
					self.p_city_name := left.p_city_name,
					self.st := left.st,
					self.z5 := left.z5,
					self.z4 := left.zip4,
					//self.phoneno_1 := left.primary_phone_number,
					self.phoneno_1 := [],
					self.phoneno_2 := [],
					self.phoneno_3 := [],
					self.phoneno_4 := [],
					self.phoneno_5 := [],
					self.phoneno_6 := [],
					self.phoneno_7 := [],
					self.phoneno_8 := [],
					self.phoneno_9 := [],
					self.phoneno_10 := []
				));

		// phone_score_model = 'phonescore_v2' (BTW, adding the score model is what makes it V8)
			 
		PhoneParams := module(project(BParams ,progressive_phone.iParam.Batch, opt)) 
			EXPORT BOOLEAN ExcludeDeadContacts       := FALSE;
			EXPORT BOOLEAN SkipPhoneScoring          := FALSE;
			EXPORT BOOLEAN IncludeBusinessPhones     := TRUE;
			EXPORT BOOLEAN IncludeLandlordPhones     := FALSE;
			EXPORT BOOLEAN ExcludeNonCellPPData      := FALSE;
			EXPORT BOOLEAN Include7DigitPhones       := TRUE;
			EXPORT BOOLEAN IncludeRelativeCellPhones := TRUE;
			EXPORT BOOLEAN IncludeCellFirstForPP     := FALSE;
			EXPORT BOOLEAN NameMatch                 := BParams.Match_Name;
			EXPORT BOOLEAN StreetAddressMatch        := BParams.Match_Street_Address;
			EXPORT BOOLEAN CityMatch                 := BParams.Match_City;
			EXPORT BOOLEAN StateMatch                := BParams.Match_State;
			EXPORT BOOLEAN ZipMatch                  := BParams.Match_Zip;
			EXPORT BOOLEAN SSNMatch                  := BParams.Match_SSN;
			EXPORT BOOLEAN DIDMatch                  := BParams.Match_LinkID;
		end;

		dsPhones := addrbest.Progressive_phone_common( PhoneBatchIn,
      PhoneParams,     ,     ,     ,     ,     ,     ,     ,     ,
      BParams.Phones_Score_Model,     ,    ,    ,    ,    ,    ,    ,   ); 	
		
			MemberPoint.Layouts.BatchOut  
									xformMinors(MemberPoint.Layouts.BatchInter L , recordof(dsPhones) R ) := transform
							self.acctno := L.acctno;
							name :=  address.NameFromComponents(L.name_first ,L.name_middle ,L.name_last,L.name_suffix  );
							self.LN_search_name := name;		
							self.LN_search_name_type := MemberPoint.Constants.LNSearchNameType.Minor;	
							// Phones
							IsPhoneSame := l.primary_phone_number = r.subj_phone10 and l.primary_phone_number <> '';
							self.Phone1_Match_Codes := if( IsPhoneSame ,'C','');
							//string10 subj_phone1;
							self.Phone1_Number :=  if(IsPhoneSame,L.primary_phone_number,'' );
							self := [];
			end;

		BatchOutMinorsOnly :=  join( MinorsOnly,dsPhones,
																			left.acctno = right.acctno and
																			left.primary_phone_number = right.subj_phone10,
																			xformMinors(left,right),
																			left outer,
																			keep(1)
																			);

	return(BatchOutMinorsOnly);

end;