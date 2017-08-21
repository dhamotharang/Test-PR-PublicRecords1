import ut, outwardmedia, lib_stringlib;
export Proc_Fix_Recs_01032011(String Version) := function

Pobox := ['P. O. BOX', 'P.O.BOX', 'P.O. BOX', 'P O BOX', 'P. O. B.', 'P.O.B', 'P.O. B', 
													'P O B', 'PO. B', 'P. O.  B', 'PO BOX', 'PO', 'P O', 'P.O.', 'P.O', 'BOX', 'PO BX'];
valid_states :=	['AE','AP','CN','GU','ON','PR','AK','AL','AR','AZ','CA','CO','CT','DC','DE','FL','GA','HI','IA','ID','IL','IN','KS','KY','LA','MA',
												 'MD','ME','MI','MN','MO','MS','MT','NC','ND','NE','NH','NJ','NM','NV','NY','OH','OK','OR','PA','RI','SC','SD','TN','TX',
												 'UT','VA','VI','VT','WA','WI','WV','WY'];

OutwardMedia.Layouts.Layout_OutwardMedia_SeqNum Xform1(OutwardMedia.Files.File_OutwardMedia_SeqNum L) := Transform
Self.email :=Regexreplace('[?]', L.email, '');
firstname_tmp1 := If(regexfind('[0-9]', L.firstname),'', L.firstname);
Self.firstname :=Regexreplace('[?]', firstname_tmp1, '');
lastname_tmp1 := If(regexfind('[0-9]', L.lastname),'', L.lastname);
Self.lastname :=Regexreplace('[?]', L.lastname, '');
Self.address1 :=Regexreplace('[?]', L.address1, '');
Self.address2 :=Regexreplace('[?]', L.address2, '');
Self.city :=Regexreplace('[?]', L.city, '');
Self.state :=Regexreplace('[?]', L.state, '');
Self.zip :=Regexreplace('[?]', L.zip, '');
Self.phone :=Regexreplace('[?]', L.phone, '');
Self.ipaddress :=Regexreplace('[?]', L.ipaddress, '');
Self.optin :=Regexreplace('[?]', L.optin, '');
Self.weburl :=Regexreplace('[?]', L.weburl, '');
Self := L;
end;
Shared AllFields := Project(OutwardMedia.Files.File_OutwardMedia_SeqNum, xform1(left));

// Names
Shared Valid_FirstName := AllFields(firstname<>'' and Regexfind('[A-Z]', firstname));
Shared Valid_LastName := Valid_FirstName(lastname<>'' and Regexfind('[A-Z]', lastname));
// Valid Email
Shared ValidEmail := Valid_LastName(Email<>'' and regexfind('[@]', email));
// Address1 and Address2                                     
Shared ValidAddress1 :=ValidEmail(Address1<>'' and regexfind('[A-Z0-9 -/]', address1));
Shared validAddress2 := validAddress1(regexfind('[A-Z0-9 -/]', address2) or address2='');
//City

Shared  CityHasStateZip :=validAddress2(city[1..2] In valid_states and city[3] = ' ' and RegexFind('[0-9]',city[4..]));
Shared CityHasAddress := validAddress2((RegexFind('[0-9]', city[1..4]) and RegexFind('[a-zA-Z ]', city[4..]) and 
																										~(city[1..2] In valid_states and 
																										city[3] = ' ' and RegexFind('[0-9]',city[4..]))) or
																										(City in pobox and RegexFind('[0-9]',city)) and ~(regexfind('[1-9]',address1)));
Shared CityHasCity := validAddress2(~(city[1..2] In valid_states and city[3] = ' ' and RegexFind('[0-9]',city[4..])) and 
																	~(RegexFind('[0-9]', city[1..4]) and RegexFind('[a-zA-Z ]', city[4..]) and 
																			~(city[1..2] In valid_states and city[3] = ' ' and 
																					RegexFind('[0-9]',city[4..]))) and
																	~(city in pobox and RegexFind('[0-9]',city)) and city not in pobox);

OutwardMedia.Layouts.Layout_OutwardMedia_SeqNum Xform2(CityHasCity L) := Transform
State_tmp1 := If ((Regexfind('[1-9]', L.state) and length(L.State)=2), '', L.State);
State_tmp2 := If (Length(L.City) =2 and L.City in Valid_States, L.City, State_tmp1);
Self.State := state_tmp2;
 
Zip_tmp1 :=  If (Regexfind('[0-9]', L.state) and length(L.State)=5 , L.State, L.Zip);
Zip_tmp2 := If (Regexfind('[A-Z]', Zip_tmp1), '', Zip_tmp1);
Self.Zip := zip_tmp2;

Phone_tmp1:= RegexReplace('[() .]', L.Phone,'');
Phone_tmp2 := If(Regexfind('[0-9]',phone_tmp1) and (Length(Phone_tmp1)>5 and length(phone_tmp1)<10) or length(phone_tmp1)>10, '', phone_tmp1);
Self.Phone := phone_tmp2;
Self := L;
End;
Shared file1:= Project(CityHasCity, xform2(left));

// output(choosen(file1,9999));
Shared badrecs1 := Join(sort(distribute(validAddress2, Hash(Seq_num)), Seq_num, local), 
																		 sort(distribute(file1, Hash(Seq_num)), Seq_num, local), 
																		 Left.Seq_num= right.seq_num, left only, local );
Shared Variation := badrecs1 + file1;

Shared variation_join := Join(sort(distribute(AllFields, Hash(Seq_num)), Seq_num, local), 
																		 sort(distribute(variation, Hash(Seq_num)), Seq_num, local), 
																		 Left.Seq_num= right.seq_num, left only, local );

Shared Complete_join := variation+variation_join;

// address1 has  .com, .net, .org  info ; zip has state ; City Has address1 and state has city
Shared Variation1 := complete_join((Regexfind('[A-Z. ]', address1) and ~(Regexfind('[1-9]', address1))) and // address1 has  .com, .net, .org  info
																										 (length(Zip)=2 and zip in Valid_States) and //zip has state
																										 (length(state)>2 and ~(regexfind('[1-9]',state)) and regexfind('[A-Z]',state)) and //state has city
																										 Regexfind('[0-9A-Z ./-]',city)); // City Has address1
Shared non_Variation1 := complete_join(~((Regexfind('[A-Z. ]', address1) and ~(Regexfind('[1-9]', address1))) and// address1 has .com, .net, .org info
																										 (length(Zip)=2 and zip in Valid_States) and //zip has state
																										 (length(state)>2 and ~(regexfind('[1-9]',state)) and regexfind('[A-Z]',state)) and //state has city
																										 Regexfind('[0-9A-Z ./-]',city))); // City Has address1
OutwardMedia.Layouts.Layout_OutwardMedia_SeqNum Xform3(Variation1 L) := Transform
Self.address1 := L.City;
Self.address2 := L.address1;
Self.City := L.State;
Self.State := L.Zip;
Self.Zip := '';
Self := L;
End;
Shared cln_Variation1 := Project(variation1, xform3(left));
Shared Complete_join1 := non_Variation1+cln_variation1;    


Shared Variation2 := Complete_join1((length(address1) > 2 and ~(regexfind('[1-9]', address1)) and regexfind('[A-Z]', address1)) and //address1 has city
																										Regexfind('[0-9A-Z ./-]',city)); //city has address1
Shared non_Variation2 := Complete_join1(~((length(address1) > 2 and ~(regexfind('[1-9]', address1)) and regexfind('[A-Z]', address1)) and //address1 has city
																										Regexfind('[0-9A-Z ./-]',city))); //city has address1

OutwardMedia.Layouts.Layout_OutwardMedia_SeqNum Xform4(Variation2 L) := Transform
Self.City := L.State;
Self.State := L.City;   
Self := L;
End;
Shared cln_Variation2 := Project(Variation2, xform4(left));
OutwardMedia.Layouts.Layout_OutwardMedia_SeqNum Xform5(non_Variation2 L) := Transform
City_tmp1 := If(Length(L.City)=8 and L.City[1..2] in valid_states and regexfind('[0-9]', L.city[4..8]), '', L.city);
City_tmp2 := If(Regexfind('[A-Z0-9 ]', city_tmp1) and L.address2 = '', '' , city_tmp1);
City_tmp3 := If(Length(L.state)>2 and Regexfind('[A-Z]', L.state) and 
																	~(regexfind('[0-9]', L.State)) and 
																	 length(L.zip)=2 and L.zip in valid_states , L.state,city_tmp2);
Self.City := City_tmp3;

address2_tmp1 := If(Regexfind('[A-Z0-9 ]', City_tmp1) and L.address2 = '', City_tmp1 , L.address2);
Self.address2 := address2_tmp1;

State_tmp1 := If(length(L.City)=8 and L.City[1..2] in valid_states and regexfind('[0-9]', L.city[4..8]), L.City[1..2], L.state);//City has State and Zip
State_tmp2 := If(length(L.state)>2 and Regexfind('[A-Z]', L.state) and
													~(regexfind('[0-9]', L.State)) and 
													length(L.zip)=2 and L.zip in valid_states ,L.zip,state_tmp1); // Zip has State
Self.State := State_tmp2;

zip_tmp1 := If(length(L.City)=8 and L.City[1..2] in valid_states and regexfind('[0-9]', L.city[4..8]), L.Zip[4..8], L.Zip);
zip_tmp2 := If(length(L.state)>2 and Regexfind('[A-Z]', L.state) and
													~(regexfind('[0-9]', L.State)) and 
													length(L.zip)=2 and L.zip in valid_states ,'',zip_tmp1);
self.zip := Zip_tmp2;
Self := L;
End;
Shared cln_nonVariation2 := Project(non_Variation2, xform5(left));

Shared Complete_join2 := cln_nonVariation2 + cln_variation2;    

OutwardMedia.Layouts.Layout_OutwardMedia_SeqNum Xform6(Complete_join2 L) := Transform
Self.email :=Regexreplace('[^A-Z0-9 ._@]', L.email, '');
firstname_tmp1 := If(Regexfind('[0-9]', L.Firstname) and ~regexfind('[A-Z]', L.firstname),'',L.Firstname);
firstname_tmp2 :=Regexreplace('[^A-Z ]',firstname_tmp1, '');
Self.FirstName := firstname_tmp2;
lastname_tmp1 := If(Regexfind('[0-9]', L.Lastname) and ~regexfind('[A-Z]', L.lastname),'',L.Lastname);
lastname_tmp2:=Regexreplace('[^A-Z ]', lastname_tmp1, '');
Self.LastName := lastname_tmp2;
address1_tmp1 := If((~Regexfind('[0-9]', L.address1) and Regexfind('[A-Z]', L.address1) and // Address1 has City
																L.address2='' and // Address2 is Empty
																length(L.city)=2 and L.city in Valid_states and // City has State
																Regexfind('[0-9A-Z .-/]', L.state)),L.State,L.address1); //State Has Address1 
Address1_tmp2 := If((StringLib.StringFind(address1_tmp1,'WWW.',1)>0 or StringLib.StringFind(address1_tmp1,'.COM',1)>0 or 
															 (StringLib.StringFind(address1_tmp1,'.NET',1)>0) or StringLib.StringFind(address1_tmp1,'.ORG',1)>0) or
															 StringLib.StringFind(address1_tmp1,'HTTP://',1)>0  and 
															 Regexfind('[0-9A-Z .#/]', L.address2), L.address2, address1_tmp1);
Address1_tmp3 := If(regexfind('[0-9]', address1_tmp2) and ~regexfind('[A-Z]', address1_tmp2) and 
															regexfind('[0-9]', L.address2) and ~regexfind('[A-Z]', L.address2),'', address1_tmp2);
Address1_tmp4 := If(address1_tmp3 in pobox and ~(regexfind('[0-9]', address1_tmp3)) and regexfind('[0-9]', L.address2),'PO BOX', address1_tmp3);
Address1_tmp5 := If(Address1_tmp4 in pobox and ~regexfind('[0-9]', address1_tmp4) and (~regexfind('[0-9]', L.address2) or L.address2=''),'',address1_tmp4);
Address1_tmp6:= If(regexfind('[0-9]', Address1_tmp5) and StringLib.StringFind(Address1_tmp5,' TH ',1)>0,
														Regexreplace(' TH ',Address1_tmp5, 'TH '), Address1_tmp5);														
Address1_tmp7:= 	 If(regexfind('[0-9]', Address1_tmp6) and StringLib.StringFind(Address1_tmp6,' TH.',1)>0,
														Regexreplace(' TH.',Address1_tmp6, 'TH '), Address1_tmp6);				
Address1_tmp8:= 	 If(regexfind('[0-9]', Address1_tmp7) and 
														StringLib.StringFind(Address1_tmp7,' TH ',1)>0,
														Regexreplace(' TH ',Address1_tmp7, 'TH '), Address1_tmp7);
Address1_tmp9 := If(address1_tmp8 ='NULL', '' , address1_tmp8);
address1_tmp10 :=  Regexreplace('NULL', address1_tmp9, '');
Address1_tmp11 :=  Regexreplace('[^A-Z0-9 ./#-]', address1_tmp10, '');
Self.Address1 := Address1_tmp11;
Address2_tmp1 := If(StringLib.StringFind(address1_tmp1,'WWW.',1)>0 or StringLib.StringFind(address1_tmp1,'.COM',1)>0 or 
															 (StringLib.StringFind(address1_tmp1,'.NET',1)>0) or StringLib.StringFind(address1_tmp1,'.ORG',1)>0 or 
															  StringLib.StringFind(address1_tmp1,'HTTP://',1)>0  and Regexfind('[0-9A-Z .#/]', L.address2), '', L.address2);
Address2_tmp2 := If(regexfind('[0-9]', address1_tmp3) and ~regexfind('[A-Z]', address1_tmp3) and 
															regexfind('[0-9]', Address2_tmp1) and ~regexfind('[A-Z]', Address2_tmp1),'', Address2_tmp1);
Address2_tmp3 := If(StringLib.StringFind(address2_tmp2,'WWW.',1)>0 or StringLib.StringFind(address2_tmp2,'.COM',1)>0 or 
															 StringLib.StringFind(address2_tmp2,'.NET',1)>0 or StringLib.StringFind(address2_tmp2,'.ORG',1)>0 or 
															 StringLib.StringFind(address1_tmp1,'HTTP://',1)>0, '', Address2_tmp2);
Address2_tmp4 := If( regexfind('[A-Z]', Address2_tmp3) and ~regexfind('[0-9]', Address2_tmp3) and L.City ='', '', Address2_tmp3);
Address2_tmp5 := If(address2_tmp4  in pobox and ~(regexfind('[0-9]', address2_tmp4 )) and regexfind('[0-9]', L.Address1),'PO BOX', address2_tmp4);
Address2_tmp6 := If(Address2_tmp5 in pobox and ~regexfind('[0-9]', address2_tmp5) and (~regexfind('[0-9]', L.Address1) or L.address1=''),'',address2_tmp5);
Address2_tmp7:= If(regexfind('[0-9]',Address2_tmp6) and StringLib.StringFind(Address2_tmp6,' TH ',1)>0,
														Regexreplace(' TH ',Address2_tmp6, 'TH '), Address2_tmp6);														
Address2_tmp8:= 	 If(regexfind('[0-9]', Address2_tmp7) and StringLib.StringFind(Address2_tmp7,' TH.',1)>0,
														Regexreplace(' TH.',Address2_tmp7, 'TH '), Address2_tmp7);				
Address2_tmp9:= 	 If(regexfind('[0-9]', Address2_tmp8) and StringLib.StringFind(Address2_tmp8,' TH ',1)>0,
														Regexreplace(' TH ',Address2_tmp8, 'TH '), Address2_tmp8);
address2_tmp10 := If(address2_tmp9='NULL','',address2_tmp9);
address2_tmp11 := Regexreplace('NULL', Address2_tmp10, '');
Address2_tmp12 := Regexreplace('[^A-Z0-9 ./#-]', Address2_tmp11, '');
Self.Address2  := Address2_tmp12;
City_tmp1 := If((~Regexfind('[0-9]', L.address1) and Regexfind('[A-Z]', L.address1) and // Address1 has City ;
																L.address2='' and  // Address2 is Empty
																length(L.city)=2 and L.city in Valid_states and // City has State
																Regexfind('[0-9A-Z .-/]', L.state)),L.address1,L.City); // State Has Address1 
City_tmp2 := If( regexfind('[A-Z]', L.Address2) and ~regexfind('[0-9]', L.address2) and city_tmp1 ='', L.address2, city_tmp1);
City_tmp3 := If(~(Regexfind('[A-Z]', city_tmp2)),'',City_tmp2);
City_tmp4 := If(length(City_tmp3)=2 and city_tmp3 in Valid_states and length(L.State)=2 and L.State<>'' and L.State in valid_States and City_tmp3=L.State, '', City_tmp3);
City_tmp5 := Regexreplace('[^A-Z ]', City_tmp4, '');
Self.City:= City_tmp5;
State_tmp1 := If((~Regexfind('[0-9]', L.address1) and Regexfind('[A-Z]', L.address1) and //Address1 has City ;
																L.address2='' and  // Address2 is Empty
																length(L.city)=2 and L.city in Valid_states and //City has State
																Regexfind('[0-9A-Z .-/]', L.state)),L.City,L.State);// State Has Address1 
State_tmp2 := If(Length(State_tmp1) <> 2 or (length(state_tmp1)=2 and State_tmp1 not in Valid_states),'',State_tmp1); 
State_tmp3 := If(length(city_tmp2)=2 and state_tmp2='' and city_tmp2 in valid_states, city_tmp2, state_tmp2);
State_tmp4 := Regexreplace('[^A-Z]', State_tmp3, '');
Self.State := State_tmp4;
Zip_tmp1 := If(Length(L.Zip)=6 and regexfind('[0-9]', L.zip[1..5]) and regexfind('[-]', L.zip[6]), L.Zip[1..5], L.Zip);
Zip_tmp2 := If(Length(Zip_tmp1)<5 or (Length(Zip_tmp1)>5 and Length(Zip_tmp1)<10) or Length(Zip_tmp1)>10 or regexfind('[A-Z ./[]?]',Zip_tmp1),'',Zip_tmp1);
Zip_tmp3 := If(regexfind('[A-Z]', Zip_tmp2), '', Zip_tmp2);
Zip_tmp4 := If(length(Zip_tmp3)=5 and Zip_tmp3[5]='-','', Zip_tmp3);
Zip_tmp5 := Regexreplace('[^0-9 -]', Zip_tmp4, ''); 
Self.Zip  := Zip_tmp5; 
Phone_tmp1:= RegexReplace('[() .]', L.Phone,'');
Phone_tmp2 := If(Regexfind('[0-9]',phone_tmp1) and (Length(Phone_tmp1)>5 and length(phone_tmp1)<10) or length(phone_tmp1)>10, '', phone_tmp1);
Phone_tmp3  := Regexreplace('[^0-9]', phone_tmp2, '');
Self.Phone :=  Phone_tmp3;
Self.ipaddress :=Regexreplace('[^0-9.]', L.ipaddress, '');
Self.optin :=Regexreplace('[^0-9 :-]', L.optin, '');
Self.weburl :=Regexreplace('[^A-Z0-9 ._]', L.weburl, '');
Self := L;
End;
Shared Final_File:= Project(Complete_join2, xform6(left));
Shared Final_FileSort := sort(distribute(Final_File, Hash(Seq_num)),Seq_num, local);
Shared WithoutNames := Final_File(Firstname='' or lastname ='' or (Firstname='' and lastname =''));
Shared WithNames :=Final_File(~(Firstname='' or lastname ='' or (Firstname='' and lastname =''))); 
Shared OutFile :=	WithNames((address1='' and address2='' and city='' and state = '' and zip='' and email = '') or 
																								(address1<>'' and address2<>'' and city='' and state = '' and zip='' and email = ''));
Shared RejectFile := WithoutNames + outFile;
Shared RejectFileDedup := Dedup(sort(distribute(RejectFile, Hash(Seq_num)),Seq_num, local), Seq_num, local);
Shared AcceptFile := Join(Final_FileSort, RejectFileDedup, Left.Seq_num=right.Seq_num,left only, local);
Return AcceptFile;
End; //Function