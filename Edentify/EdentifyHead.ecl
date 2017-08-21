import header, mdr, doxie, ut;



File_Header_Main := 
          Header.File_Headers(~MDR.Source_is_on_Probation(src),
                         LENGTH(Stringlib.StringFilter(ssn,'0123456789'))=9,
						 ssn[1]<'9',
						 ssn[1..3] >'000',
						 ssn[4..5]>'00',
						 ssn[6..9]>'0000',
						 fname>'',
						 LNAME>'',
						 (integer)ssn not in Doxie.bad_ssn_list) ;

							
rEdentifyRef :=RECORD
	STRING25 	RefFirstName;
	STRING1 	RefMI;
	STRING25 	RefLastName;
	STRING4 	RefNameSuffix;
	STRING9 	RefSSN;
	STRING 	RefLocator;
	unsigned3 	RefCreated;
	unsigned3 	RefUpdated;
	INTEGER 	RefOccurrences;
	STRING2 	RefSource;
	
END;

rEdentifyRef	tHeaderToEdentify(File_Header_Main pInput)
 :=
  transform
	SELF.RefFirstName :=stringlib.stringfilterout(pInput.fname,'",\'');
	SELF.RefMI :=  stringlib.stringfilterout(pInput.mname,'",\'');
	SELF.RefLastName :=stringlib.stringfilterout(pInput.lname,'",\'');
	SELF.RefNameSuffix :=if (ut.is_unk(ut.Translate_Suffix(pInput.name_suffix )),
						    '',
							 ut.Translate_Suffix(pInput.name_suffix ));
 
	SELF.RefSSN :=pInput.ssn;
	SELF.RefLocator :=(string) pInput.rid; 
	SELF.RefCreated :=IF(pInput.dt_first_seen=0,
						 pInput.dt_last_seen,
						 pInput.dt_first_seen);
	SELF.RefUpdated :=IF(pInput.dt_last_seen=0,
	                     pInput.dt_first_seen,
						 pInput.dt_last_seen);
	SELF.RefOccurrences :=1;
	SELF.RefSource :=pInput.src;
  end
 ;

dHeaderAsEdentify	 :=	project(File_Header_Main,tHeaderToEdentify(left));

dEdentifyDist		 :=	distribute(dHeaderAsEdentify,hash(RefSSN,RefLastName,RefFirstName,RefMI,RefNameSuffix));
dEdentifySort		 :=	sort(dEdentifyDist,RefSSN,RefLastName,RefFirstName,RefMI,RefNameSuffix,RefSource,local);
 
string1 RefSource(string2 src) := MAP(
						src= 'GO'=>'N',
						MDR.sourceTools.SourceIsUtility(src) =>'N',
						src= 'TC'=>'N',
						src= 'NC'=>'N',
						src= 'TB'=>'N',
						src= 'TU'=>'N',
						src= 'MI'=>'N',
						src= 'LT'=>'N',
						src= 'EQ'=>'N',
						src= 'MC'=>' ',
						src= 'B' =>'B',
						src= 'N' =>'N',
						'P');

rEdentifyRef	tRollupSameSSNName(dEdentifySort pLeft, dEdentifySort pRight, pInput)
 :=
  transform
	self.RefCreated		:=	ut.min2 (pLeft.RefCreated,
	                                 pRight.RefCreated);
	self.RefUpdated 	:=	ut.max2 (pLeft.RefUpdated,
	                                 pRight.RefUpdated);
	self.RefOccurrences :=	if(pLeft.RefSource=pRight.RefSource,
	                           pLeft.RefOccurrences, 
							   pLeft.RefOccurrences+ 1);
	self.RefSource      :=  if (pInput=1,
	                           pleft.RefSource, 
							   if(RefSource(pLeft.RefSource)<>RefSource(pRight.RefSource) 
	                           AND RefSource(pLeft.RefSource)<>'',
							   'B',
	                           RefSource(pLeft.RefSource)));
	self.RefLocator     :=  if(pLeft.RefUpdated > pRight.RefUpdated,
							   pLeft.RefLocator,
							   pRight.RefLocator);
							  
	self				:=	pLeft;
	
  end
 ;

dRolledUpPerSrc	:=	rollup(dEdentifySort ,
					   left.RefSSN 			= right.RefSSN
				   and left.RefLastName 	= right.RefLastName
				   and left.RefFirstName	= right.RefFirstName
				   and left.RefMI			= right.RefMI
				   and left.RefNameSuffix	= right.RefNameSuffix
				   and left.RefSource       = right.RefSource ,
					   tRollupSameSSNName(left,right,1),
					   local
					  );

					  
dRolledUp   	:=	rollup(dRolledUpPerSrc ,
					   left.RefSSN 			= right.RefSSN
				   and left.RefLastName 	= right.RefLastName
				   and left.RefFirstName	= right.RefFirstName
				   and left.RefMI			= right.RefMI
				   and left.RefNameSuffix	= right.RefNameSuffix,
				 	   tRollupSameSSNName(left,right,2),
					   local
					  );
rEdentifyRefout :=RECORD
	STRING25 	RefFirstName;
	STRING1 	RefMI;
	STRING25 	RefLastName;
	STRING4 	RefNameSuffix;
	STRING9 	RefSSN;
	STRING 	RefLocator;
	string 	RefCreated;
	string 	RefUpdated;
	string 	RefOccurrences;
	STRING1 	RefSource;
	
END;

string munge(string i) := if (i[5..6] = '00', i[1..4] + '0101', i);

rEdentifyRefOut trEdentifyRefOut(dRolledUp pInput)
  :=transform
	self.refLastname := stringlib.stringfilter(pInput.reflastname,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ');
     self.refFirstname := stringlib.stringfilter(pInput.refFirstname,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ');
     self.refcreated := munge(trim((string6)pInput.refcreated) + '01');
	self.RefUpdated := munge(trim((string6)pInput.RefUpdated) + '01');
	self.RefOccurrences := (string)pInput.RefOccurrences;
	 
	self.RefSource :=if (pInput.RefSource<>'P'
	                     AND pInput.RefSource<>'B'
						 AND pInput.RefSource<>'N',
						 RefSource(pinput.RefSource),
						 pInput.RefSource);
	self :=Pinput;
	
END;

final_list := project(dRolledUp(Reflastname != '' or Refssn != ''),trEdentifyRefOut(left));

sam1 := sample(final_list,4,1);
sam2 := sample(final_list,4,2);
sam3 := sample(final_list,4,3);
sam4 := sample(final_list,4,4);

output(sam1,,'~thor_data400::temp::jtolbert::eDentify_csv_set1',csv);
output(sam2,,'~thor_data400::temp::jtolbert::eDentify_csv_set2',csv);
output(sam3,,'~thor_data400::temp::jtolbert::eDentify_csv_set3',csv);
output(sam4,,'~thor_data400::temp::jtolbert::eDentify_csv_set4',csv);


