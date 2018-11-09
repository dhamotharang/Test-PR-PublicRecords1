import Address, Ut, lib_stringlib, _Control, business_header,_Validate, NID;
// 	The Courtlink Data is unique in format. Understanding the format of the data is 
// 	necessary to understand the formatting steps taken in the code: 
//	The file will consist of six different sections.  Each section begins with a three 
// 	character tag beginning with a slash (/).  The item codes are as follows:
//
// 	Basic Docket Information	/01
// 	Other Docket Numbers		/02
// 	Plaintiffs					/03
// 	Defendants					/04
// 	Other litigants				/05
//	Attorneys					/06
//
// Following each section, the data consists of delimited fields.  Fields are delimited 
// by the ASCII character 166 (¦).  All fields are text strings.  Fields that do not 
// contain data will still be followed by the delimiter (thus, there will be two 
// successive delimiter characters).  The delimited fields within each section are as 
// follows:
//
// Section: /01 Basic Docket Information
// (1)State¦(2)CourtID¦(3)Court Name¦(4)Docket Number¦(5)Office Name¦
// (6)Docket As Of Date¦(7)Class Code¦(8)Case Caption¦(9)Date Filed¦(10)Judge 
// Title¦(11)Judge Name¦(12)Referred To Judge Title¦(13)Referred To Judge¦
// (14)Jury Demand¦(15)Demand Amount¦(16)Nature of Suit Code¦(17)Nature of 
// Suit Description¦(18)Lead Docket Number¦(19)Jurisdiction¦(20)Cause¦
// (21)Statute¦(22)CA¦(23)Case Closed¦(24)Date Retrieved
//
// Section: /02 Other Docket Numbers
// (1)Other Docket Number
//
// Sections: /03 Plaintiff; /04 Defendant, /05 Other Litigant
// (1)Litigant Name¦(2)Litigant Label¦(3)Layout Code¦(4)Termination Date
//
// Section: /06 Attorney
// (1)Attorney Name¦(2)Attorney Label¦(3)Firm Name¦(4)Address¦(5)City¦
// (6)State¦(7)Zip Code¦(8)Country¦(9)Additional Information¦(10)Termination 
// Date
//
// The following code will add linking keys to each section of the file so that 
//	records can be linked together to form a flat file for each party: litigant, 
//	defendant or other litigant.  All names will be cleaned, including judges &
//	attorneys.  Attorney addresses are cleaned.  No DID/BDID process is performed.
//	Given that only names exist for the parties, it was determined that DID/BDIDs 
//	would not be heavily populated anyway. 
///////////////////////////////////////////////////////////////////////////////////
export Standardize_Input := module

	export fPreProcess(dataset(Layouts.Input.Sprayed) pRawFileInput, string pversion) := function
	
	
	//	remove special characters that were seen in the data
	//////////////////////////////
		CourtLink.Layouts.Input.Sprayed	trfRemoveSpecialCharacters(CourtLink.Layouts.Input.Sprayed l)	:=	transform
			string tmp1		:=	StringLib.StringFindReplace(l.TmpField, '»','');
			string tmp2		:=	StringLib.StringFindReplace(tmp1, '«','');
			string tmp3		:=	StringLib.StringFindReplace(tmp2, '§','; ');
			string tmp4		:=	StringLib.StringFindReplace(tmp3, '&#064;','@');
			self.TmpField	:=	tmp4 + '¦';
		end;

		CleanRaw	:=	project(pRawFileInput, trfRemoveSpecialCharacters(left));
	//////////////////////////////
	
	
	//	Add linking keys to the data in order to join all associated records together. This data is 
	//	positional in nature, so we have an /01 record followed by 1-n /03, /04, /05 records and each 
	//	these records can have 1-n /06 records associated with them.
	//////////////////////////////
		CourtLink.Layouts.input.CommonBlob	trfAddLinks(CourtLink.Layouts.Input.Sprayed input)	:=	transform
			self.RecId		:=	input.tmpField[2..3];
			self.LinkKey1	:=	if (input.tmpField[1..3]='/01',
										input.tmpField[4..5] + input.tmpField[StringLib.StringFind(input.tmpField, '¦', 3) + 1..StringLib.StringFind(input.tmpField, '¦', 4) - 1],
										''
									);
			integer pos		:=	if (StringLib.StringFind(input.tmpField, '¦', 1) = 0,
										length(input.tmpField) + 1,
										StringLib.StringFind(input.tmpField, '¦', 1)
									);
			self.LinkKey2	:=	if (input.tmpField[1..3]='/03' or input.tmpField[1..3]='/04' or input.tmpField[1..3]='/05',
										input.tmpField[..pos - 1],
										''
									);						
			self.tmpField	:=	input.tmpField;
		end;

		AddLinks	:=	project(CleanRaw, trfAddLinks(left));
	//////////////////////////////
	
	//	Iterate thru the records, propagating the appropriate linking keys to the records.  So, when we encounter 
	//	an /01 record, we propagate the linking key associated with that record to all records following it until
	//	the next /01 record is encountered.  Same thing for all /03, /04 & /05 records.  
	//	Example - before iterate - no keys assigned
	//		/01 Basic Docket Information
	//		/02 Other Docket Number
	//		/03 Plaintiff #1
 	//		/06 Plaintiff #1 Attorney #1
	//		/06 Plaintiff #1 Attorney #2
	//		/04 Defendant #1
	//		/06 Defendant #1 Attorney #1
	//		/06 Defendant #1 Attorney #2
	//	Example - after iterate - keys assigned
	//		</01 key value>					/01 Basic Docket Information
	//		</01 key value>					/02 Other Docket Number
	//		</01 key value>	</03 key value>	/03 Plaintiff #1
 	//		</01 key value>	</03 key value>	/06 Plaintiff #1 Attorney #1
	//		</01 key value>	</03 key value>	/06 Plaintiff #1 Attorney #2
	//		</01 key value>	</04 key value>	/04 Defendant #1
	//		</01 key value>	</04 key value>	/06 Defendant #1 Attorney #1
	//		</01 key value>	</04 key value>	/06 Defendant #1 Attorney #2	
	//////////////////////////////	
		CourtLink.Layouts.input.CommonBlob trfPropagateLinks(CourtLink.Layouts.input.CommonBlob l,CourtLink.Layouts.input.CommonBlob r)	:=	transform
			self.LinkKey1	:=	if (r.LinkKey1 = '',
										l.LinkKey1,
										r.LinkKey1
									);
			self.LinkKey2	:=	if (r.LinkKey2 = '' and r.tmpField[1..3] != '/01',
										l.LinkKey2,
										r.LinkKey2
									);					
			self		:=	r;
		end;

		LitDebt	:=	sort(distribute(iterate(AddLinks, trfPropagateLinks(left,right)),hash(linkKey1,LinkKey2)),LinkKey1,local);
	//////////////////////////////


		reformatDate(string inDate) := function
			string tmpDate 		:=  regexreplace('/',inDate,'')[1..8];
			string CCYYMMDDDate	:=	trim((tmpDate[5..8] + tmpDate[1..2] + tmpDate[3..4]),left,right);
			string newDate		:=	if (length(trim(CCYYMMDDDate,left,right))!=8,'',trim(CCYYMMDDDate,left,right));
			return newDate; 
		end; 
		

	//	Parse thru the /01 record, mapping to the fields	
	//////////////////////////////
		CourtLink.Layouts.Input.BasicInfo	  trfRec01(CourtLink.Layouts.input.CommonBlob l)	:=	transform	
			self.State					:= 	if (StringLib.StringFind(l.tmpField, '¦', 1) != 0,
													stringlib.StringToUppercase(l.tmpField[4..StringLib.StringFind(l.tmpField, '¦', 1) - 1]),
													''
												);
			self.CourtID				:= 	if (StringLib.StringFind(l.tmpField, '¦', 2) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 1) + 1..StringLib.StringFind(l.tmpField, '¦', 2) - 1]),
													''
												);
			self.CourtName				:= 	if (StringLib.StringFind(l.tmpField, '¦', 3) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 2) + 1..StringLib.StringFind(l.tmpField, '¦', 3) - 1]),
													''
												);
			self.DocketNumber			:= 	if (StringLib.StringFind(l.tmpField, '¦', 4) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 3) + 1..StringLib.StringFind(l.tmpField, '¦', 4) - 1]),
													''
												);
			self.OfficeName				:= 	if (StringLib.StringFind(l.tmpField, '¦', 5) != 0,
													regexreplace('[()]', stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 4) + 1..StringLib.StringFind(l.tmpField, '¦', 5) - 1]),''), 
													''
												);
			self.AsOfDate				:= 	if (StringLib.StringFind(l.tmpField, '¦', 6) != 0,
													reformatDate(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 5) + 1..StringLib.StringFind(l.tmpField, '¦', 6) - 1]),
													''
													);
			self.ClassCode				:= 	if (StringLib.StringFind(l.tmpField, '¦', 7) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 6) + 1..StringLib.StringFind(l.tmpField, '¦', 7) - 1]),
													''
												);
			self.CaseCaption			:= 	if (StringLib.StringFind(l.tmpField, '¦', 8) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 7) + 1..StringLib.StringFind(l.tmpField, '¦', 8) - 1]),
													''
												);
			self.DateFiled				:= 	if (StringLib.StringFind(l.tmpField, '¦', 9) != 0,
													reformatDate(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 8) + 1..StringLib.StringFind(l.tmpField, '¦', 9) - 1]),
													''
												);
			self.JudgeTitle				:= 	if (StringLib.StringFind(l.tmpField, '¦', 10) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 9) + 1..StringLib.StringFind(l.tmpField, '¦', 10) - 1]),
													''
												);
			self.JudgeName				:= 	if (StringLib.StringFind(l.tmpField, '¦', 11) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 10) + 1..StringLib.StringFind(l.tmpField, '¦', 11) - 1]),
													''
												);
			self.ReferredToJudgeTitle	:= 	if (StringLib.StringFind(l.tmpField, '¦', 12) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 11) + 1..StringLib.StringFind(l.tmpField, '¦', 12) - 1]),
													''
												);
			self.ReferredToJudge		:= 	if (StringLib.StringFind(l.tmpField, '¦', 13) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 12) + 1..StringLib.StringFind(l.tmpField, '¦', 13) - 1]),
													''
												);
			self.JuryDemand				:= 	if (StringLib.StringFind(l.tmpField, '¦', 14) != 0 and 
												trim(stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 13) + 1..StringLib.StringFind(l.tmpField, '¦', 14) - 1]),left,right)<>'NONE',
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 13) + 1..StringLib.StringFind(l.tmpField, '¦', 14) - 1]),
													''
												);
			self.DemandAmount			:= 	if (StringLib.StringFind(l.tmpField, '¦', 15) != 0 and
												(integer)stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 14) + 1..StringLib.StringFind(l.tmpField, '¦', 15) - 1])<>0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 14) + 1..StringLib.StringFind(l.tmpField, '¦', 15) - 1]),
													''
												);
			self.SuitNatureCode			:= 	if (StringLib.StringFind(l.tmpField, '¦', 16) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 15) + 1..StringLib.StringFind(l.tmpField, '¦', 16) - 1]),
													''
												);
			self.SuitNatureDesc			:= 	if (StringLib.StringFind(l.tmpField, '¦', 17) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 16) + 1..StringLib.StringFind(l.tmpField, '¦', 17) - 1]),
													''
												);
			self.LeadDocketNumber		:= 	if (StringLib.StringFind(l.tmpField, '¦', 18) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 17) + 1..StringLib.StringFind(l.tmpField, '¦', 18) - 1]),
													''
												);
			self.Jurisdiction			:= 	if (StringLib.StringFind(l.tmpField, '¦', 19) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 18) + 1..StringLib.StringFind(l.tmpField, '¦', 19) - 1]),
													''
												);
			self.Cause					:= 	if (StringLib.StringFind(l.tmpField, '¦', 20) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 19) + 1..StringLib.StringFind(l.tmpField, '¦', 20) - 1]),
													''
												);
			self.Statute				:= 	if (StringLib.StringFind(l.tmpField, '¦', 21) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 20) + 1..StringLib.StringFind(l.tmpField, '¦', 21) - 1]),
													''
												);
			self.CA						:= 	if (StringLib.StringFind(l.tmpField, '¦', 22) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 21) + 1..StringLib.StringFind(l.tmpField, '¦', 22) - 1]),
													''
												);
			self.CaseClosed				:= 	if (StringLib.StringFind(l.tmpField, '¦', 23) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 22) + 1..StringLib.StringFind(l.tmpField, '¦', 23) - 1]),
													''
												);
			self.DateRetrieved			:= 	if (StringLib.StringFind(l.tmpField, '¦', 24) != 0,
													reformatDate(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 23) + 1..StringLib.StringFind(l.tmpField, '¦', 24) - 1]),
													''
												);
			self						:=	l;
		end;

		Rec01		:=	sort(distribute(project(LitDebt(recId='01'), trfRec01(left))(trim(Statute,left,right)='15:1692' or trim(Statute,left,right)='15:1681' or trim(Statute,left,right)='47:227'),hash(LinkKey1)),LinkKey1,local);
	//////////////////////////////	

	//	Parse thru the /02 record, mapping to the fields	
	//////////////////////////////
		CourtLink.Layouts.Input.OtherDocketNumbers  trfRec02(CourtLink.Layouts.input.CommonBlob l)	:=	transform	
			self.DocketNumber			:= 	if (StringLib.StringFind(l.tmpField, '¦', 1) != 0,
													stringlib.StringToUppercase(l.tmpField[4..StringLib.StringFind(l.tmpField, '¦', 1) - 1]),
													''
												);
			self						:=	l;
		end;

		Rec02		:=	sort(distribute(project(LitDebt(recId='02'), trfRec02(left))(trim(DocketNumber,left,right)<>'NONE'),hash(LinkKey1)),LinkKey1,local); 
	//////////////////////////////	

	//	Parse thru the /03-/05 records, mapping to the fields	
	//////////////////////////////
		CourtLink.Layouts.Input.Parties	  trfRec03_05(CourtLink.Layouts.input.CommonBlob l)	:=	transform	
			self.LitigantName			:= 	if (StringLib.StringFind(l.tmpField, '¦', 1) != 0,
													stringlib.StringToUppercase(l.tmpField[4..StringLib.StringFind(l.tmpField, '¦', 1) - 1]),
													''
												);
			self.LitigantLabel			:= 	if (StringLib.StringFind(l.tmpField, '¦', 2) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 1) + 1..StringLib.StringFind(l.tmpField, '¦', 2) - 1]),
													''
												);
			self.LayoutCode				:= 	if (StringLib.StringFind(l.tmpField, '¦', 3) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 2) + 1..StringLib.StringFind(l.tmpField, '¦', 3) - 1]),
													''
												);
			self.TerminationDate		:= 	if (StringLib.StringFind(l.tmpField, '¦', 4) != 0,
													reformatDate(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 3) + 1..StringLib.StringFind(l.tmpField, '¦', 4) - 1]),
													''
												);
			self						:=	l;
		end;											
											
		Rec03_05	:=	sort(distribute(project(LitDebt(recId='03' or recId='04' or recId='05'), trfRec03_05(left)),hash(LinkKey1)),LinkKey1,local);  
	//////////////////////////////	

	//	Parse thru the /06 record, mapping to the fields	
	//////////////////////////////
		CourtLink.Layouts.Input.Attorney	  trfRec06(CourtLink.Layouts.input.CommonBlob l)	:=	transform	
			self.AttorneyName			:= 	if (StringLib.StringFind(l.tmpField, '¦', 1) != 0,
													stringlib.StringToUppercase(l.tmpField[4..StringLib.StringFind(l.tmpField, '¦', 1) - 1]),
													''
												);
			self.AttorneyLabel			:= 	if (StringLib.StringFind(l.tmpField, '¦', 2) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 1) + 1..StringLib.StringFind(l.tmpField, '¦', 2) - 1]),
													''
												);
			self.FirmName				:= 	if (StringLib.StringFind(l.tmpField, '¦', 3) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 2) + 1..StringLib.StringFind(l.tmpField, '¦', 3) - 1]),
													''
												);
			self.Address				:= 	if (StringLib.StringFind(l.tmpField, '¦', 4) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 3) + 1..StringLib.StringFind(l.tmpField, '¦', 4) - 1]),
													''
												);
			self.City					:= 	if (StringLib.StringFind(l.tmpField, '¦', 5) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 4) + 1..StringLib.StringFind(l.tmpField, '¦', 5) - 1]),
													''
												);
			self.State					:= 	if (StringLib.StringFind(l.tmpField, '¦', 6) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 5) + 1..StringLib.StringFind(l.tmpField, '¦', 6) - 1]),
													''
												);
			self.ZipCode				:= 	if (StringLib.StringFind(l.tmpField, '¦', 7) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 6) + 1..StringLib.StringFind(l.tmpField, '¦', 7) - 1]),
													''
												);
			self.Country				:= 	if (StringLib.StringFind(l.tmpField, '¦', 8) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 7) + 1..StringLib.StringFind(l.tmpField, '¦', 8) - 1]),
													''
												);
			self.AddtlInfo				:= 	if (StringLib.StringFind(l.tmpField, '¦', 9) != 0,
													stringlib.StringToUppercase(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 8) + 1..StringLib.StringFind(l.tmpField, '¦', 9) - 1]),
													''
												);
			self.TermDate				:= 	if (StringLib.StringFind(l.tmpField, '¦', 10) != 0,
													reformatDate(l.tmpField[StringLib.StringFind(l.tmpField, '¦', 9) + 1..StringLib.StringFind(l.tmpField, '¦', 10) - 1]),
													''
												);	
												
			self						:=	l;
		end;

		Rec06		:=	sort(distribute(project(LitDebt(recId='06'), trfRec06(left)),hash(LinkKey1)),LinkKey1,local); 
	//////////////////////////////	

	//	Join the Attorney (/06) records to the appropriate party (/03-/05) records	
	//////////////////////////////
		CourtLink.Layouts.Input.PartyAtty		JoinPartyAtty(CourtLink.Layouts.Input.Parties l, CourtLink.Layouts.Input.Attorney r)	:=	transform
			self						:=	l;
			self						:=	r;
		end;

		JoinedPartyAtty	:=	join(	Rec03_05,
									Rec06,
									left.linkKey1 	= 	right.LinkKey1 and
									left.LinkKey2	=	right.LinkKey2,
									JoinPartyAtty(left,right),
									left outer,
									local
								);
	//////////////////////////////	

	//	Join the Other Docket (/02) records to the appropriate Basic Docket (/01) records	
	//////////////////////////////
		CourtLink.Layouts.Input.BasicOther	JoinBasicOther(CourtLink.Layouts.Input.BasicInfo l, CourtLink.Layouts.Input.OtherDocketNumbers r)	:=	transform
			self					:=	l;
			self.OtherDocketNumber	:=	r.DocketNumber;
		end;

		JoinedBasicOther	:=	join(	Rec01,
										Rec02,
										left.linkKey1 	= 	right.LinkKey1,
										JoinBasicOther(left,right),
										left outer,
										local
									);
						
	//////////////////////////////	

	//	Join the  joined docket records to the joined Party/Attorney records	
	//////////////////////////////
		CourtLink.Layouts.Input.CommonInput	JoinCommon(CourtLink.Layouts.Input.BasicOther l, CourtLink.Layouts.Input.PartyAtty r)	:=	transform
			self							:=	r;
			self.CourtState					:=	l.state;
			self.dt_first_seen				:= 	(unsigned4)l.AsOfDate;  
			self.dt_last_seen				:= 	(unsigned4)l.AsOfDate;
			self.dt_vendor_first_reported	:= 	(unsigned4)pversion;
			self.dt_vendor_last_reported	:= 	(unsigned4)pversion;
			self.record_type				:= 	'C';	
			self							:=	l;
		end;

		dPreProcess	:=	join(	JoinedBasicOther,
								JoinedPartyAtty,
								left.linkKey1 	= 	right.LinkKey1,
								JoinCommon(left,right),
								left outer,
								local
							);
   
		return dPreProcess;
	end;
   
	export fStandardizeName(dataset(Layouts.Input.CommonInput) pPreProcessInput) := function

    NID.Mac_CleanFullNames(pPreProcessInput, cleaned_litigant_output, LitigantName);
		cleaned_litigant_name := cleaned_litigant_output;
		
		Layouts.base tStandardizeLitigant(cleaned_litigant_name L) := TRANSFORM
		  is_person := L.nametype IN ['P', 'D']; // We're counting a dual person name too
			
		  SELF.business_person := IF(is_person, 'P', 'B');
			SELF.debtor := IF(NOT(is_person), StringLib.StringToUppercase(TRIM(L.LitigantName, LEFT, RIGHT)),
			                                  '');
			SELF.debtor_title		 := L.cln_title;
			SELF.debtor_fname		 := L.cln_fname;
			SELF.debtor_mname		 := L.cln_mname;
			SELF.debtor_lname		 := L.cln_lname;
			SELF.debtor_suffix   := L.cln_suffix;
			SELF.debtor_score	   := '';		
			SELF.causeCode			 := MAP(L.Statute='15:1692' => '1',
											            L.Statute='15:1681' => '2',
											            L.Statute='47:227' 	=> '3',
											            '');

		  SELF := L;
			SELF := [];
		END;
		
		dStandardizedLitigantName := PROJECT(cleaned_litigant_name, tStandardizeLitigant(LEFT));
		
    NID.Mac_CleanFullNames(dStandardizedLitigantName, cleaned_judge_output, JudgeName);
		cleaned_judge_name := cleaned_judge_output;
		
		Layouts.base tStandardizeJudge(cleaned_judge_name L) := TRANSFORM
			SELF.judge_title	:= L.cln_title;
			SELF.judge_fname	:= L.cln_fname;
			SELF.judge_mname	:= L.cln_mname;
			SELF.judge_lname	:= L.cln_lname;
			SELF.judge_suffix := L.cln_suffix;
			SELF.judge_score	:= '';		

		  SELF := L;
		END;
		
		dStandardizedJudgeName := PROJECT(cleaned_judge_name, tStandardizeJudge(LEFT));
		
    NID.Mac_CleanFullNames(dStandardizedJudgeName, cleaned_attorney_output, AttorneyName);
		cleaned_attorney_name := cleaned_attorney_output;
		
		Layouts.base tStandardizeAttorney(cleaned_attorney_name L) := TRANSFORM
			SELF.attorney_title	:= L.cln_title;
			SELF.attorney_fname	:= L.cln_fname;
			SELF.attorney_mname	:= L.cln_mname;
			SELF.attorney_lname	:= L.cln_lname;
			SELF.attorney_suffix := L.cln_suffix;
			SELF.attorney_score	:= '';		

		  SELF := L;
		END;
		
		dStandardizedAttorneyName := PROJECT(cleaned_attorney_name, tStandardizeAttorney(LEFT));
		
		return dStandardizedAttorneyName;
	end;
	

	export fStandardizeAddresses(dataset(Layouts.base) pStandardizeNameInput) := function
	

		addresslayout := record
			Layouts.base; 
			string100                           address1       ;
			string50                            address2       ;
		end;
		
		addresslayout tProjectAddress(Layouts.base l) := transform
			self.address1	:= l.address;
			self.address2	:= trim(l.city) + ', '   + trim(l.state) + ' ' + trim(l.zip);  
			self			:= l;
		end;
      
		dAddressPrep   := project(pStandardizeNameInput, tProjectAddress(left));
      
		address.mac_address_clean( 	dAddressPrep
									,address1
									,address2
									,true
									,dAddressStandardized
								  );

		dAddressStandardized_dist     := distribute(dAddressStandardized  ,hash(courtid, docketNumber));
		
		Layouts.base tGetStandardizedAddress(dAddressStandardized_dist l) := transform
			Clean_Attorney_address	:= Address.CleanAddressFieldsFips(l.clean).addressrecord;
			self.prim_range			:=	Clean_Attorney_address.prim_range;
			self.predir				:=	Clean_Attorney_address.predir;
			self.prim_name			:=	Clean_Attorney_address.prim_name;
			self.addr_suffix		:=	Clean_Attorney_address.addr_suffix;
			self.postdir			:=	Clean_Attorney_address.postdir;
			self.unit_desig			:=	Clean_Attorney_address.unit_desig;
			self.sec_range			:=	Clean_Attorney_address.sec_range;
			self.p_city_name		:=	Clean_Attorney_address.p_city_name;
			self.v_city_name		:=	Clean_Attorney_address.v_city_name;
			self.st					:=	Clean_Attorney_address.st;
			self.zip				:=	Clean_Attorney_address.zip;
			self.zip4				:=	Clean_Attorney_address.zip4;
			self.cart				:=	Clean_Attorney_address.cart;
			self.cr_sort_sz			:=	Clean_Attorney_address.cr_sort_sz;
			self.lot				:=	Clean_Attorney_address.lot;
			self.lot_order			:=	Clean_Attorney_address.lot_order;
			self.dbpc				:=	Clean_Attorney_address.dbpc;
			self.chk_digit			:=	Clean_Attorney_address.chk_digit;
			self.rec_type			:=	Clean_Attorney_address.rec_type;
			self.fips_state			:=	Clean_Attorney_address.fips_state;
			self.fips_county		:=	Clean_Attorney_address.fips_county;
			self.geo_lat			:=	Clean_Attorney_address.geo_lat;
			self.geo_long			:=	Clean_Attorney_address.geo_long;
			self.msa				:=	Clean_Attorney_address.msa;
			self.geo_blk			:=	Clean_Attorney_address.geo_blk;
			self.geo_match			:=	Clean_Attorney_address.geo_match;
			self.err_stat			:=	Clean_Attorney_address.err_stat;
			self					:=  l;
		end;
      
		dCleanAddressAppended  := project(dAddressStandardized_dist, tGetStandardizedAddress(left));
		return dCleanAddressAppended;
      
	end;

	export fAll( dataset(Layouts.Input.Sprayed)  pRawFileInput, string pversion) := function
   
		dPreprocess			:= fPreProcess             	(pRawFileInput,pversion);
		dStandardizeName	:= fStandardizeName        	(dPreprocess);
      
		#if(_flags.UseStandardizePersists)
			dAppendBusinessInfo  := fStandardizeAddresses	(dStandardizeName) : persist(Persistnames.standardizeInput, EXPIRE(2));
		#else
			dAppendBusinessInfo  := fStandardizeAddresses	(dStandardizeName);
		#end
      
		return dAppendBusinessInfo;
   
	end;
end;
