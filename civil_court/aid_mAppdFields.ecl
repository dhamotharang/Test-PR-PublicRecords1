////////////////////////////////////////////////////////////////////////////////////////
//Macro: Append Prep Address Fields
////////////////////////////////////////////////////////////////////////////////////////
export aid_mAppdFields(infile,inaddr1,inaddr2,inaddr,inaddr4,outfile) := macro
#uniquename(tlayout)
#uniquename(tPreClean)
#uniquename(prep_addrLast)
#uniquename(prep_addr1)
#uniquename(set_st)

%set_st% :=[
'AL',
'AK',
'AR',
'AS',
'AZ',
'CA',
'CO',
'CT',
'DC',
'DE',
'FL',
'GA',
'GU',
'HI',
'IA',
'ID',
'IL',
'IN',
'KS',
'KY',
'LA',
'MA',
'MD',
'ME',
'MI',
'MN',
'MO',
'MS',
'MT',
'NC',
'ND',
'NE',
'NH',
'NJ',
'NM',
'NV',
'NY',
'OH',
'OK',
'OR',
'PA',
'PR',
'RI',
'SC',
'SD',
'TN',
'TX',
'UT',
'VA',
'VI',
'VT',
'WA',
'WI',
'WV',
'WY'];

%tlayout% := record
string Append_Prep_Address1;
string Append_Prep_AddressLast;
infile;
end;

%tlayout% %tPreClean%(infile L) := transform
/*
string60 L.entity_1_address_1
string60 L.entity_1_address_2
string60 L.entity_1_address_3
string60 L.entity_1_address_4

the following combinations are possible
-----------------
null
null
null
City,St,Zip
-----------------
Addr1
City,St,Zip
null
null
-----------------
Addr1
Addr2
City,St,Zip
null
-----------------
null
Addr1
City,St,Zip
null
-----------------
Addr1
City,St
Zip
null
-----------------
Addr1
null
null
City,St,Zip
-----------------
Addr1
Addr2
null
City,St,Zip
-----------------
Addr1
null
City,St
Zip
-----------------
Addr1
Addr2
Addr3
City,St,Zip
-----------------
Addr1
City
State
Zip
-----------------

*/

string entity_1_address_1 := map(L.entity_1_address_1[1..3] = 'C/O' or L.entity_1_address_1[1..4] = 'ATTN' => '',L.entity_1_address_1);
string entity_1_address_2 := map(L.entity_1_address_2[1..3] = 'C/O' or L.entity_1_address_2[1..4] = 'ATTN' => '',L.entity_1_address_2);
				   
self.Append_Prep_Address1    := 
				lib_StringLib.StringLib.StringToUpperCase(trim(regexreplace(' +',
					map(L.entity_1_address_3 ='' and L.entity_1_address_4 ='' => entity_1_address_1,
						L.entity_1_address_3!='' and L.entity_1_address_4 ='' and  
							regexfind('[a-zA-Z]',L.entity_1_address_3) = true and regexfind('[1-9]',L.entity_1_address_3) = true
																					=> entity_1_address_1 +' '+ entity_1_address_2,
					    L.entity_1_address_3!='' and L.entity_1_address_4 ='' and  regexfind('[a-zA-Z]',L.entity_1_address_3) = false
																					=> entity_1_address_1,
						L.entity_1_address_3!='' and L.entity_1_address_4 ='' and entity_1_address_1 =''
																					=> entity_1_address_2,																					
						L.entity_1_address_3!='' and L.entity_1_address_4 ='' and  regexfind('[a-zA-Z]',L.entity_1_address_3) = true
																					=> entity_1_address_1,
						L.entity_1_address_3!='' and L.entity_1_address_4 ='' => entity_1_address_1 +' '+ entity_1_address_2,
					    L.entity_1_address_3 ='' and L.entity_1_address_4!='' => entity_1_address_1 +' '+ entity_1_address_2,
						
						L.entity_1_address_3!='' and L.entity_1_address_4!='' and entity_1_address_2=''
																					 => entity_1_address_1,
																					 
						L.entity_1_address_3!='' and L.entity_1_address_4!='' and regexfind('[a-zA-z]',L.entity_1_address_4)
																					 => entity_1_address_1 +' '+ 
																						entity_1_address_2 +' '+ 
																						L.entity_1_address_3,
					    
						L.entity_1_address_3!='' and L.entity_1_address_4!='' and ~regexfind('[a-zA-z]',L.entity_1_address_4)
																					 => entity_1_address_1 +' '+ 
																						entity_1_address_2 +' '+ 
																						L.entity_1_address_3 +' '+
																						L.entity_1_address_4
																						,'')
																						,' '),left,right));
																						
Prep_AddressLast := 
				lib_StringLib.StringLib.StringToUpperCase(trim(regexreplace(' +',
					map(entity_1_address_1+entity_1_address_2+L.entity_1_address_3 ='' => L.entity_1_address_4,
						L.entity_1_address_3 ='' and L.entity_1_address_4 ='' => entity_1_address_2,
					    L.entity_1_address_3!='' and L.entity_1_address_4 ='' and entity_1_address_1 =''
																					=> L.entity_1_address_3,
						L.entity_1_address_3!='' and L.entity_1_address_4 ='' and  
							regexfind('[a-zA-Z]',L.entity_1_address_3) = true and regexfind('[1-9]',L.entity_1_address_3) = true
																					=> L.entity_1_address_3,
						L.entity_1_address_3!='' and L.entity_1_address_4 ='' and  regexfind('[a-zA-Z]',L.entity_1_address_3) = false
																					=> entity_1_address_2+' '+L.entity_1_address_3,																					
																					
						L.entity_1_address_3!='' and L.entity_1_address_4 ='' and  regexfind('[a-zA-Z]',L.entity_1_address_3) = true
																					=> entity_1_address_2+' '+L.entity_1_address_3,
						L.entity_1_address_3!='' and L.entity_1_address_4 ='' => L.entity_1_address_3,
					    L.entity_1_address_3 ='' and L.entity_1_address_4!='' => L.entity_1_address_4,
						
						L.entity_1_address_3!='' and L.entity_1_address_4!='' and entity_1_address_2=''
																					 => L.entity_1_address_3+' '+L.entity_1_address_4,
																					 
						L.entity_1_address_3!='' and L.entity_1_address_4!='' and regexfind('[a-zA-z]',L.entity_1_address_4)
																					 => L.entity_1_address_4,
					    
						L.entity_1_address_3!='' and L.entity_1_address_4!='' and regexfind('[a-zA-z]',L.entity_1_address_4) = false
																					 => entity_1_address_2+' '+
																						L.entity_1_address_3+' '+
																						L.entity_1_address_4,''),' '),left,right));

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Format Address Last as CITY, ST Zip5 if possible
string tok_last  := trim(Prep_AddressLast[stringlib.stringfind(Prep_AddressLast,' ',stringlib.stringfindcount(Prep_AddressLast,' '))+1..
								 stringlib.stringfind(Prep_AddressLast,' ',stringlib.stringfindcount(Prep_AddressLast,' '))+40],left,right);
string tok_2ndtoLast := stringlib.stringfilter(
							stringlib.stringtouppercase(
								trim(Prep_AddressLast[stringlib.stringfind(Prep_AddressLast,' ',stringlib.stringfindcount(Prep_AddressLast,' ')-1)+1..
								                      stringlib.stringfind(Prep_AddressLast,' ',stringlib.stringfindcount(Prep_AddressLast,' '))],left,right)
							)
						,'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
string the_rest := trim(Prep_AddressLast[1..stringlib.stringfind(Prep_AddressLast,' ',stringlib.stringfindcount(Prep_AddressLast,' ')-1)],left,right);

								 
string st := if(trim(tok_2ndtoLast,left,right) in %set_st%
				   ,trim(tok_2ndtoLast,left,right),'');
					
string zip := if(regexfind('[a-zA-Z]',tok_last)=false
				   ,tok_last[1..5],'');
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				   
self.Append_Prep_AddressLast := regexreplace('BALTO, MD',
								regexreplace(' ,',
								regexreplace(' , ',
								regexreplace(',,',
									map(st!='' and zip != '' => the_rest+', '+st+' '+ zip,Prep_AddressLast)
								,',')
								,', ')
								,', ')
								,'BALTIMORE, MD');
				


																			
self := L;
end;
outfile := project(infile,%tPreClean%(left));
endmacro;