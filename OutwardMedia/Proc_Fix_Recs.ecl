import ut, lib_stringlib;
export Proc_Fix_Recs(String Version) := Function
 Pobox := ['P. O. BOX', 'P.O.BOX', 'P.O. BOX', 'P O BOX', 'P. O. B.', 'P.O.B', 'P.O. B', 
													'P O B', 'PO. B', 'P. O. B', 'PO BOX', 'PO', 'P O', 'P.O.', 'P.O', 'BOX', 'PO BX'];
 valid_states					:=	[	'AE','AP','CN','GU','ON','PR',
																							'AK','AL','AR','AZ','CA','CO','CT','DC','DE','FL',
																							'GA','HI','IA','ID','IL','IN','KS','KY','LA','MA',
																							'MD','ME','MI','MN','MO','MS','MT','NC','ND','NE',
																							'NH','NJ','NM','NV','NY','OH','OK','OR','PA','RI',
																							'SC','SD','TN','TX','UT','VA','VI','VT','WA','WI',
																							'WV','WY' ];

 Base1 := OutwardMedia.Files.File_OutwardMedia_SeqNum;
 BadAddrFile := Base1(REGEXFIND('[^0-9a-zA-z .,#/]', address) OR address = '' OR REGEXFIND('[^a-zA-Z ]', city) OR state NOT IN valid_states OR REGEXFIND('^(?![0-9]{5}(-[0-9]{4})?$).*$', zip) );
 GoodAddrFile := Base1(~(REGEXFIND('[^0-9a-zA-z .,#/]', address) OR address = '' OR REGEXFIND('[^a-zA-Z ]', city) OR state NOT IN valid_states OR REGEXFIND('^(?![0-9]{5}(-[0-9]{4})?$).*$', zip)));
 GoodAddrFileSort := Sort(Distribute(GoodAddrFile, Hash(Seq_num)), Seq_num, local);	
 OutwardMedia.Layouts.Layout_OutwardMedia_SeqNum tLayout(BadAddrFile L) := Transform
		Self.address := Trim(StringLib.StringCleanSpaces(RegexReplace('[^0-9a-zA-z .,/#]', L.address,' ')), Left, Right);
    Self.City 		:= Trim(StringLib.StringCleanSpaces(RegexReplace('[^0-9a-zA-z ]', L.City,' ')), Left, Right);
		Self.state		:=	Trim(stringlib.StringCleanSpaces(RegexReplace('[^0-9a-zA-z ]', L.state,' ')), Left, Right);
		Self.email := If(L.email='WWW.GRANTSEARCHFINDER.COM' or L.email='WWW.FASTAUCTIONPROFIT.COM', L.Phone, L.email);
		Self.Phone :=  If(L.email='WWW.GRANTSEARCHFINDER.COM' or L.email='WWW.FASTAUCTIONPROFIT.COM' or L.Phone = 'N/A', '', L.Phone);
		Self	:=	L;		
End;
  Base := Project(BadAddrFile, tLayout(Left));

 BaseSort := Sort(Distribute(Base, Hash(Seq_Num)), Seq_Num, local);
 CityHasStateZip :=Base(city[1..2] In valid_states and city[3] = ' ' and RegexFind('[0-9]',city[4..]));

 CityHasAddress := Base((RegexFind('[0-9]', city[1..4]) and RegexFind('[a-zA-Z ]', city[4..]) and 
																										~(city[1..2] In valid_states and 
																										city[3] = ' ' and RegexFind('[0-9]',city[4..]))) or
																										(City in pobox and RegexFind('[0-9]',city)));

 CityHasCity := Base(~(city[1..2] In valid_states and city[3] = ' ' and RegexFind('[0-9]',city[4..])) and 
																	~(RegexFind('[0-9]', city[1..4]) and RegexFind('[a-zA-Z ]', city[4..]) and 
																			~(city[1..2] In valid_states and city[3] = ' ' and 
																					RegexFind('[0-9]',city[4..]))) and
																	~(city in pobox and RegexFind('[0-9]',city)) and city not in pobox);

 OutwardMedia.Layouts.Layout_OutwardMedia_SeqNum tCityHasStateZip(CityHasStateZip L):= Transform
Self.City := '';
Self.State := L.City[1..2];
Self.Zip := L.City[4..8];
Self := L;
End;
 CityStateZip_formatted := Project(CityHasStateZip, tCityHasStateZip(Left));

/* City is along with Address in these recs*/
 OutwardMedia.Layouts.Layout_OutwardMedia_SeqNum tCityHasAddress(CityHasAddress L) := Transform
Self.Address := L.City;
Self.City := L.Address;
Self := L;
End;
 CityHasAddress_formatted := Project(CityHasAddress, tCityHasAddress(Left));
 FormattedCity := CityStateZip_formatted+CityHasAddress_formatted;
 City_Formatted := FormattedCity+CityHasCity;
 CityHasCity_Final := City_Formatted(~(city[1..2] In valid_states and city[3] = ' ' and
																																						RegexFind('[0-9]',city[4..])) and 
																	                                 ~(RegexFind('[0-9]', city[1..4]) and RegexFind('[a-zA-Z ]', city[4..]) and 
																																	 ~(city[1..2] In valid_states and city[3] = ' ' and
																																						RegexFind('[0-9]',city[4..]))) and 
																																	 ~(RegexFind('[0-9]',city)) and city not in pobox);

 CityHasCity_FinalSort := Sort(Distribute(CityHasCity_Final, Hash(Seq_Num)), Seq_Num, Local);
 omCity := CityHasCity_FinalSort;
 PhoneEmail := omCity(RegexFind('[@]', Phone));
 NotPhoneEmail := omCity(~(RegexFind('[@]', Phone)));

 omCitySort := Sort(Distribute(omCity, Hash(Seq_num)), Seq_num, local);	
 OutwardMedia.Layouts.Layout_OutwardMedia_SeqNum tEmailPhone(PhoneEmail L):= Transform
Self.Phone := If(RegexFind('[@]', L.Phone),'', L.Phone);
self.State := If(RegexFind('[@]', L.Phone),L.Zip, L.State);
Self.Zip := If(RegexFind('[@]', L.Phone),L.email, L.Zip);
Self.Email := If(RegexFind('[@]', L.Phone),L.Phone, L.Email); 
Self := L;
End;
 pEmailPhone := Project(PhoneEmail, tEmailPhone(Left));
 OmCityPhone := pEmailPhone+NotPhoneEmail;

// ADDRESS
 AddressIsCorrect := OmCityPhone((RegexFind('[0-9A-Z,/ -]', Address) and Address Not In valid_states) 
																						 or (Address in pobox and RegexFind('[0-9]',Address)) or address = '');
 AddressIsNotCorrect := OmCityPhone(~((RegexFind('[0-9A-Z,/ -]', Address) and Address Not In valid_states) 
																						 or (Address in pobox and RegexFind('[0-9]',Address)) or address=''));

// STATE
 CityNoState := AddressIsCorrect(~(State in valid_states or state = ''));
 CityAndState := AddressIsCorrect(State in valid_states or state = '');
 StateHasStateZip :=CityNoState(State[1..2] In valid_states and State[3] = ' ' and 
																									RegexFind('[0-9]',State[4..]));
 OutwardMedia.Layouts.Layout_OutwardMedia_SeqNum tStateHasStateZip(StateHasStateZip L):= Transform
Self.State := L.State[1..2];
Self.Zip := L.State[4..8];
Self := L;
End;
 State_StateZip_formatted := Project(StateHasStateZip, tStateHasStateZip(Left));
 State_Formatted :=CityAndState + State_StateZip_formatted;

 CityAndState1 := State_Formatted(State in valid_states or state = '');//8,131,891 Recs in CityAndState1

 Not_StateHasStateZip := CityNoState(~(State[1..2] In valid_states and State[3] = ' ' and RegexFind('[0-9]',State[4..])));

 CityHasState2 := Not_StateHasStateZip(City in valid_states and State Not In  valid_states);

// ZIP
 ZipTry1 := CityHasState2(City in valid_states and length(State) =5 and length(zip)=5 and regexfind('[0-9]', state) and regexfind('[0-9]', zip));

 OutwardMedia.Layouts.Layout_OutwardMedia_SeqNum tZipTry1(ZipTry1 L):= Transform
Self.State := L.City;
Self.Zip := L.State;
Self.City := '';
Self := L;
End;
 pZipTry1 := Project (ZipTry1, tZipTry1(left));

 Zip_Formatted := State_Formatted + pZipTry1;

 CityAndState3 :=Zip_Formatted(State in valid_states or state = '');
 Zip10 := CityAndState3(Zip[5]='-');

 OutwardMedia.Layouts.Layout_OutwardMedia_SeqNum tZip1(CityAndState3 L):= Transform
ASet := [' ', '-', '\'', '`'];
Self.FirstName := If (regexFind('[@]', L.firstname) and regexFind('[^@]', L.email), L.Email, L.FirstName);
Self.Email := If ((regexFind('[@]', L.firstname) and regexFind('[^@]', L.email)), L.FirstName, L.Email);

zip_tmp1 := If ((L.Zip[5]='-' or length(L.Zip)<5) or 
											(regexfind('[@$&!%*#~.;]',L.Zip)) or 
											(regexfind('[A-Z]', L.Zip)) or 
											(length(L.Zip) >10) or 
											(length(L.Zip) >5 and Length(L.Zip)< 10) or
											(Length(L.Zip)=10 and (L.Zip[5] in ASet or L.Zip[7] in ASet)), '', L.Zip);
zip_tmp2:= If (Length(zip_tmp1)=6 and zip_tmp1[6] in ASet and regexfind('[0-9]', zip_tmp1[1..5]), zip_tmp1[1..5], zip_tmp1);
zip_tmp3 := If ((Length(zip_tmp2)=10 and regexfind('[0-9]', zip_tmp2[1..5]) and regexfind('[0-9]', zip_tmp2[7..10])), zip_tmp2[1..5]+'-'+zip_tmp2[7..10], zip_tmp2);
zip_tmp4 :=  If((Length(zip_tmp3) = 9 and RegexFind('[0-9]',zip_tmp3)), zip_tmp3[1..5]+'-'+zip_tmp3[6..9],  zip_tmp3);
Zip_tmp5 := If(Length(zip_tmp4) =5 and regexfind('[ -]', zip_tmp4), '', zip_tmp4);
Self.Zip:=zip_tmp5;
Self := L;
End;
 ZipCode:= Project(CityAndState3, tZip1(left));


// EMAIL
 FnamehasEmail := ZipCode(regexFind('[@]', firstname));
 LnamehasEmail := ZipCode(regexFind('[@]', lastname));
 EmailHasEmail := ZipCode(regexFind('[@]', email));

//PHONE
 PhoneisOK := ZipCode(RegexFind('[^A-Z]', phone) or Phone = '');
 PhoneHasJunk := ZipCode(~(RegexFind('[^A-Z]', phone) or phone=''));

 OutwardMedia.Layouts.Layout_OutwardMedia_SeqNum tPhoneJunk(PhoneHasJunk L):= Transform
Self.Phone := If(Length(L.Phone) =2 and L.Phone in valid_states and L.Phone = L.State, '', '');
Self.State := If(Length(L.Phone) =2 and L.Phone in valid_states and L.State = '', L.Phone, L.State);
Self := L;
End;
 Cleaned_JunkPhones := Project(PhoneHasJunk , tPhoneJunk(Left));

 Cln_PhoneNum := Cleaned_JunkPhones + PhoneisOK;
 Cln_PhoneNumSort := Sort(Distribute(Cln_PhoneNum, Hash(Seq_num)), Seq_num, Local);
 PhoneEmail1 := ZipCode(RegexFind('[@]', Phone));

 BadAddrFile1 := Cln_PhoneNum(REGEXFIND('[^0-9a-zA-Z .,#/]', address) OR REGEXFIND('[^a-zA-Z ]', city) OR 
																								state NOT IN valid_states OR REGEXFIND('^(?![0-9]{5}(-[0-9]{4})?$).*$', zip) );
 GoodAddrFile1 := Cln_PhoneNum(~(REGEXFIND('[^0-9a-zA-Z .,#/]', address) OR 
																			REGEXFIND('[^a-zA-Z ]', city) OR state NOT IN valid_states OR
																			REGEXFIND('^(?![0-9]{5}(-[0-9]{4})?$).*$', zip))
																			or address = ''  or city = '' or zip = '' or email ='' or state = '' or 
																			Regexfind('[^0-9@]', firstname) or Regexfind('[^0-9@]', lastname));
 GoodAddrFileSort1 := Sort(Distribute(GoodAddrFile1, Hash(Seq_num)), Seq_num, local);			
 jBadFile := Join(omCitySort, GoodAddrFileSort1, Left.Seq_Num = Right.Seq_num, Left Only, local);
 CompleteFile := jBadFile&Cln_PhoneNumSort;
 CompleteFileSort := Sort(Distribute(CompleteFile, Hash(Seq_num)), Seq_num, Local);
 jbase := Join(basesort,CompleteFileSort, Left.Seq_num= right.seq_num, Left Only, local);

 jcompleteBigFile := GoodAddrFileSort & jbase;
 OutwardMedia.Layouts.Layout_OutwardMedia_SeqNum tPhone(jcompleteBigFile L):= Transform
Phone1 := Trim(StringLib.StringCleanSpaces(RegexReplace('[A-Z() .-]', L.Phone,'')), Left, Right);
Phone2 := If(length(Phone1) < 10 or length(Phone1) >11, '', phone1);
Phone3 := If((Length(Phone2) = 10 or Length(Phone2) = 11) and (Phone2[1] = '1' or Phone2[1] = '0'), Phone2[2..], phone2);
Phone4 := If(length(Phone3)<10 or length(Phone3)>10, '', Phone3);
Self.Phone := Phone4;
Self := L;
End;
 pPhone := Project(jcompleteBigFile, tPhone(Left));

 OutwardMedia.Layouts.Layout_OutwardMedia_SeqNum tZip2(pPhone L):= Transform
ASet := [' ', '-', '\'', '`'];
FirstName_tmp1 := If(regexFind('[@]', L.firstname) and ~(regexFind('[@]', L.email)), L.Email, L.FirstName);
FirstName_tmp2 := If((FirstName_tmp1 in pobox or 
																	(StringLib.StringFind(FirstName_tmp1,'WWW.', 1)> 0) or
																	~(regexfind('[A-Z]', FirstName_tmp1)) or 
																	regexFind('[@]', FirstName_tmp1)),'',FirstName_tmp1) ;
Self.Firstname:= FirstName_tmp2;
Self.Email := If ((regexFind('[@]', L.firstname) and regexFind('[^@]', L.email)), L.FirstName, L.Email);

zip_tmp1 := If ((L.Zip[5]='-' or length(L.Zip)<5) or 
											(regexfind('[@$&!%*#~.;]',L.Zip)) or 
											(regexfind('[A-Z]', L.Zip)) or 
											(length(L.Zip) >10) or 
											(length(L.Zip) >5 and Length(L.Zip)< 10) or
											(Length(L.Zip)=10 and (L.Zip[5] in ASet or L.Zip[7] in ASet)), '', L.Zip);
zip_tmp2:= If (Length(zip_tmp1)=6 and zip_tmp1[6] in ASet and regexfind('[0-9]', zip_tmp1[1..5]), zip_tmp1[1..5], zip_tmp1);
zip_tmp3 := If ((Length(zip_tmp2)=10 and 
												regexfind('[0-9]', zip_tmp2[1..5]) and 
												regexfind('[0-9]', zip_tmp2[7..10])), zip_tmp2[1..5]+'-'+zip_tmp2[7..10], zip_tmp2);
zip_tmp4 :=  If((Length(zip_tmp3) = 9 and RegexFind('[0-9]',zip_tmp3)), zip_tmp3[1..5]+'-'+zip_tmp3[6..9],  zip_tmp3);
Zip_tmp5 := If(Length(zip_tmp4) =5 and regexfind('[ -]', zip_tmp4), '', zip_tmp4);
Self.Zip:=zip_tmp5;
Self := L;
End;
 CleanedFile:= Project(pPhone, tZip2(left));

 OutwardMedia.Layouts.Layout_OutwardMedia_SeqNum tCityStateZip(cleanedfile L):= Transform
//NAMES
Self.FirstName := If(~(Regexfind('[A-Z]', L.Firstname)),'',L.FirstName);
Self.Lastname := If(~(Regexfind('[A-Z]', L.Lastname)),'',L.LastName);
//ADDRESS
Address_tmp := If((L.Address = L.Phone), '', L.address);
Address_tmp1 := If((Address_tmp in Pobox and ~(regexfind('[0-9]', Address_tmp))),'', Address_tmp);
Address_tmp2 := If((regexfind('[0-9]', Address_tmp1) and ~(regexfind('[A-Z]', Address_tmp1))), '', Address_tmp1);
Self.Address := If(~((REGEXFIND('[0-9A-Z .,#/-]', address_tmp2)) or address_tmp2 =''),'',Address_tmp2);
//CITY
City_tmp :=If(((length(L.city)=11 or length(L.city)= 16) and
														(L.City[10..11] = 'US' or L.City[15..16] = 'US') and 
														(Regexfind('[0-9]', L.city[4..8]) or Regexfind('[0-9 ]', L.city[4..13])) and 
														(L.City[1..2] in Valid_States and L.state='' and L.zip='')) or
														(length(L.City)=8 and 
																L.City[1..2] in Valid_States and 
																Regexfind('[0-9]', L.City[4..8]) and 
																L.city[1..2]=L.state and 
																L.city[4..8] = L.Zip) ,
												'',L.City);
City_tmp1 := If(City_tmp in pobox, '', City_tmp);
Self.City := If((City_tmp1<>'' and regexfind('[0-9]',city_tmp1)),'',city_tmp1);
// STATE
State_tmp := If(((length(L.city)=11 or length(L.city)= 16) and
														(L.City[9..11] = ' US' or L.City[14..16] = ' US') and 
														(Regexfind('[0-9]', L.city[4..8]) or Regexfind('[0-9 ]', L.city[4..13])) and 
														(L.City[1..2] in Valid_States and L.state='' and L.zip='')) or
														(length(L.City)=8 and 
																L.City[1..2] in Valid_States and 
																Regexfind('[0-9]', L.City[4..8]) and 
																L.city[1..2]=L.state and 
																L.city[4..8] = L.Zip),				
												L.City[1..2],L.State);
State_tmp1 := If(((length(state_tmp)=11 or length(state_tmp)= 16) and
														(state_tmp[9..11] = ' US' or state_tmp[14..16] = ' US') and 
														(Regexfind('[0-9]', state_tmp[4..8]) or Regexfind('[0-9 ]', state_tmp[4..13])) and 
														(state_tmp[1..2] in Valid_States and L.Zip='')) or
														(length(state_tmp)=8 and 
																state_tmp[1..2] in Valid_States and 
																Regexfind('[0-9]', state_tmp[4..8]) and 
																state_tmp[1..2]=L.state and 
																state_tmp[4..8] = L.Zip),				
												state_tmp[1..2],State_tmp);												
State_tmp2:= If (length(L.city) =2 and L.city in Valid_States and 
													~(State_tmp1 in valid_States or state_tmp1 = ''), L.city, state_tmp1);
Self.State := If(~(State_tmp2 in valid_States or state_tmp2 = ''),'',State_tmp2);
//ZIP CODE
Zip_tmp := If(((length(L.city)=11 or length(L.city)= 16 or length(L.city)=8) and
														(L.City[10..11] = 'US' or L.City[15..16] = 'US') and 
														(Regexfind('[0-9]', L.city[4..8]) or Regexfind('[0-9 ]', L.city[4..13])) and 
														(L.City[1..2] in Valid_States and L.state='' and L.zip='')) or
														(length(L.City)=8 and 
																	L.City[1..2] in Valid_States and 
																	Regexfind('[0-9]', L.City[4..8]) and 
																	L.city[1..2]=L.state and 
																	L.city[4..8] = L.Zip),
												L.City[4..8]+'-'+L.City[10..13], L.Zip);
Zip_tmp1 :=  If(((length(L.state)=11 or length(L.State)= 16) and
														(L.State[9..11] = ' US' or L.State[14..16] = ' US') and 
														(Regexfind('[0-9]', L.State[4..8]) or Regexfind('[0-9 ]', L.State[4..13])) and 
														(L.State[1..2] in Valid_States and L.Zip='')) or
														(length(L.State)=8 and 
																L.State[1..2] in Valid_States and 
																Regexfind('[0-9]', L.State[4..8]) and 
																L.State[1..2]=L.state and 
																L.State[4..8] = L.Zip),				
												L.State[4..8]+'-'+L.State[10..13] , Zip_tmp);		
Zip_tmp2 := If((length(Zip_tmp1)=8 and StringLib.StringFind(Zip_tmp1[6..8], '-US', 1)> 0), zip_tmp1[1..5], Zip_tmp1);
Zip_tmp3 := If(regexfind('[A-Z]', Zip_tmp2), '', Zip_tmp2);
Self.Zip := If(~(length(Zip_tmp3) = 5 or length(Zip_tmp3) =10 and regexfind('[0-9-]',Zip_tmp3)), '', Zip_tmp3);
//EMAIL
email_tmp := If(~(Regexfind('[0-9A_Z@._]',L.email)), '', L.email);
email_tmp1 := If((length(L.city)=11 or length(L.city)= 16 or length(L.city)=8) and
														(L.City[10..11] = 'US' or L.City[15..16] = 'US') and 
														(Regexfind('[0-9]', L.city[4..8]) or Regexfind('[0-9 ]', L.city[4..13])) and 
														(L.City[1..2] in Valid_States and L.state='' and L.zip='') and
														L.email = L.city[4..8], '', L.email);
Self.Email := If(~(Regexfind('[@]', email_tmp1)), '', email_tmp1);
//PHONE
Self.Phone := If(~(Length(L.Phone)=10 and regexfind('[0-9]', L.phone)), '', L.phone);
Self := L;
End;
 CleanedOmFile := Project(cleanedfile, tCityStateZip(Left));
 CleanedOmFile_Sort := Sort(Distribute(CleanedOmFile,Hash(Seq_num)), Seq_Num, local);
 WithNames := CleanedOmFile_Sort(firstname<>'' and lastname<>'');
 OutFile :=	WithNames((address='' and city='' and state = '' and zip='' and email = '') or (address<>'' and city='' and state = '' and zip='' and email = ''));
RejectFile := CleanedOmFile_Sort(firstname='' and lastname='' or firstname='' or lastname ='' ) & OutFile;
RejectFileDedup := Dedup(sort(distribute(RejectFile, Hash(Seq_num)),Seq_num, local), Seq_num, local);
UniqueInfile := Join(CleanedOmFile_Sort,RejectFileDedup, Left.Seq_num=right.Seq_num,left only, local);
UniqueInfileSort := Sort(Distribute(UniqueInFile, hash(Seq_num)), seq_num, local);
output(RejectFileDedup,,'~thor400::RejectFile::OutwardMedia_'+version, CLUSTER('thor400_88'), OVERWRITE);
Return UniqueInfileSort;
End;//Function