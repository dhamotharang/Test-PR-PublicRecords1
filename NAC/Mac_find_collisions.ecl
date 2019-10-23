
EXPORT Mac_find_collisions
	(
	infile
	,matchset
	,priority_
	,fname_field = 'fname'	,mname_field = 'mname'	,lname_field = 'lname'	,suffix_field = 'name_suffix'
	,ssn_field = 'ssn'	,dob_field = 'dob'
	,phone_field = 'phone'
	,seq_field = 'PrepRecSeq'
	,month_field = 'Case_Benefit_Month'
	,use_month = 'true'
	,month
	,use_state = 'true'
	,DID_field	= 'did'
	,score_field	= 'did_score'
	,outrec
	,outfile
	,score_threshold
	,ssn_threshold
	,dob_threshold
	,prange_field	= 'prim_range',pname_field = 'prim_name'	,srange_field = 'sec_range'
	,predir_field = 'predir',addr_suffix_field = 'suffix',postdir_field = 'postdir'
	,udesig_field = 'unit_desig',city_field = 'v_city_name'
	,state_field = 'st'	,zip_field	= 'zip', zip4_field = 'zip4'
	) 
	:= macro

import header,ut;

// L             LexId
// N             Name
// S             Full SSN
// P             Probable SSN
// D             DOB
// B             Probable DOB
// A             Street Address
// C             City/State Address
// Z             Zip Address
// V             Last Name + Partial First
// W             Last Name
// H             Phone

matchChars:=
					 if('L' in matchset,'L','')
					+if('N' in matchset,'N','')
					+if('V' in matchset,'V','')
					+if('W' in matchset,'W','')
					+if('S' in matchset,'S','')
					+if('P' in matchset,'P','')
					+if('D' in matchset,'D','')
					+if('B' in matchset,'B','')
					+if('A' in matchset,'A','')
					+if('C' in matchset,'C','')
					+if('Z' in matchset,'Z','')
					+if('H' in matchset,'H','')
					;

ssn_value(string9 l, string9 r) :=
  MAP( l='' or r='' => 0
       ,l = r      => 3
			,(unsigned)l % 10000 = (unsigned)r % 10000 AND 
						(((unsigned)l div 10000) = 0 OR ((unsigned)r div 10000) = 0)  => 1
       ,ut.stringsimilar(l,r) < 4 or ut.stringsimilar(r,l) < 4 => 3-min(ut.stringsimilar(l,r),ut.stringsimilar(r,l))
       ,-10 );

inf_dis:=distribute(infile
		(
		Client_Eligible_Status_Indicator<>'N',

		#if('L' in matchset)
			did_field > 0,
			age > 17,
			header.sig_near_dob(dob_field,best_dob),

			#if(score_threshold = 3)
				score_field > 99,
			#elseif(score_threshold = 2)
				score_field > 84,
			#elseif(score_threshold = 1)
				score_field > 74,
			#else
				score_field > 99,
			#end

		#elseif('S' in matchset
					and 'N' not in matchset
					and 'V' not in matchset
					and 'W' not in matchset
					and 'L' not in matchset
					and 'P' not in matchset
					and 'D' not in matchset
					and 'B' not in matchset
					and 'A' not in matchset
					and 'C' not in matchset
					and 'Z' not in matchset
					and 'H' not in matchset)
			ssn_field<>'',
		#else
			lname_field<>'',
		#end
		true)  //the one just keeps the commas from messing it up
		,hash(
		#if('L' in matchset)
			did_field
		#elseif('N' in matchset)
			lname_field,
			prefname
		#elseif('S' in matchset
					and 'N' not in matchset
					and 'V' not in matchset
					and 'W' not in matchset
					and 'L' not in matchset
					and 'P' not in matchset
					and 'D' not in matchset
					and 'B' not in matchset
					and 'A' not in matchset
					and 'C' not in matchset
					and 'Z' not in matchset
					and 'H' not in matchset)
			ssn_field
		#else
			lname_field,
			prefname[1]
		#end
		));

inf_ddp:=dedup(inf_dis,		record,		all,		local);

NAC.Layouts.Collisions tr(inf_ddp l, inf_ddp r) := transform
			// sort collumns for intra-state collisions.  this will aid dedupe in NAC.Mod_Collisions
			fn_left(string le, string ri):=function
				return map(l.Case_State_Abbreviation <> r.Case_State_Abbreviation => le
									 ,l.month_field = r.month_field and l.PrepRecSeq > r.PrepRecSeq => ri
									 ,le);
			end;
			fn_right(string le, string ri):=function
				return map(l.Case_State_Abbreviation <> r.Case_State_Abbreviation => ri
									 ,l.month_field = r.month_field and l.PrepRecSeq > r.PrepRecSeq => le
									 ,ri);
			end;

			self.pri:=priority_;

			self.matchset
			:= if((l.fname_field=r.fname_field
						or l.fname_field=r.client_first_name
						or l.client_first_name=r.client_first_name
						or l.fname_field=r.prefname
						or l.prefname=r.client_first_name
						or l.prefname=r.prefname)
						and
						(l.lname_field=r.lname_field
						or l.client_last_name=r.client_last_name
						or l.lname_field=r.client_last_name),'N',
						if((l.lname_field=r.lname_field
							or l.lname_field=r.client_last_name
							or l.client_last_name=r.client_last_name)
							and
							(l.fname_field<>r.fname_field
							or l.fname_field<>r.prefname)
							and
							(l.fname_field[1]=r.fname_field[1]
							or l.fname_field[1]=r.client_first_name[1]
							or l.client_first_name[1]=r.client_first_name[1]
							or l.fname_field[1]=r.prefname[1]
							or l.prefname[1]=r.client_first_name[1]
							or l.prefname[1]=r.prefname[1]),'V',
							if(l.lname_field=r.lname_field
								or l.client_last_name=r.client_last_name
								or l.lname_field=r.client_last_name,'W','')))

					+if((unsigned)l.ssn_field>0 and (unsigned)r.ssn_field>0 and l.ssn_field=r.ssn_field,'S',
						if((unsigned)l.ssn_field>0 and (unsigned)r.ssn_field>0 and ssn_value(l.ssn_field,r.ssn_field) > 0,'P','')) //*FIX

					+if((unsigned)l.dob_field>0 and	(unsigned)r.dob_field>0 and	l.dob_field=r.dob_field,'D',
						if(header.gens_ok(l.suffix_field,l.dob_field,r.suffix_field,r.dob_field) and
									(unsigned)l.dob_field>0 and	(unsigned)r.dob_field>0 and
									(header.sig_near_dob(l.dob_field,r.dob_field) or header.date_value(l.dob_field,r.dob_field) > 1),'B','')) //*FIX

					+if(l.pname_field<>'' and	r.pname_field<>'' and	l.pname_field=r.pname_field and	l.prange_field=r.prange_field,'A','')

					+if(l.city_field<>'' and r.city_field<>'' and	l.state_field<>'' and	r.state_field<>'' and	l.city_field=r.city_field and	l.state_field=r.state_field,'C','')

					+if(l.zip_field<>'' and	r.zip_field<>'' and	l.zip_field=r.zip_field,'Z','');

			self.MatchCodes := self.matchset;

			self.LexID:=if('L' in matchset,l.did,0);
			self.LexIdScore:=intformat(if('L' in matchset,l.did_score,0),3,1);
			self.ClientEligibleStatusIndicator := l.Client_Eligible_Status_Indicator;
			self.ActivityType := '4';
			self.BuildVersion := (string)l.ProcessDate;
			self.BenefitState := fn_left(l.Case_State_Abbreviation,r.Case_State_Abbreviation);

			self.SearchCaseID := fn_left(l.Case_Identifier,r.Case_Identifier);
			self.SearchClientID := fn_left(l.Client_Identifier,r.Client_Identifier);
			self.SearchBenefitType := fn_left(l.Case_Benefit_Type,r.Case_Benefit_Type);
			self.SearchBenefitMonth := fn_left(l.Case_Benefit_Month,r.Case_Benefit_Month);
			self.SearchLastName := fn_left(l.Client_Last_Name,r.Client_Last_Name);
			self.SearchFirstName := fn_left(l.Client_First_Name,r.Client_First_Name);
			self.SearchMiddleName := fn_left(l.Client_Middle_Name,r.Client_Middle_Name);
			self.SearchSSN := fn_left(l.Client_SSN,r.Client_SSN);
			self.SearchDOB := fn_left(l.Client_DOB,r.Client_DOB);
			self.SearchEligibilityDate := fn_left(l.Client_Eligible_Status_Date,r.Client_Eligible_Status_Date);
			self.SearchEligibilityStatus := fn_left(l.Client_Eligible_Status_Indicator,r.Client_Eligible_Status_Indicator);
			self.SearchAddress1StreetAddress1 := fn_left(l.Case_Physical_Address_Street_1,r.Case_Physical_Address_Street_1);
			self.SearchAddress1StreetAddress2 := fn_left(l.Case_Physical_Address_Street_2,r.Case_Physical_Address_Street_2);
			self.SearchAddress1City := fn_left(l.Case_Physical_Address_City,r.Case_Physical_Address_City);
			self.SearchAddress1State := fn_left(l.Case_Physical_Address_State,r.Case_Physical_Address_State);
			self.SearchAddress1Zip := fn_left(l.Case_Physical_Address_Zip,r.Case_Physical_Address_Zip);
			self.SearchAddress2StreetAddress1 := fn_left(l.Case_Mailing_Address_Street_1,r.Case_Mailing_Address_Street_1);
			self.SearchAddress2StreetAddress2 := fn_left(l.Case_Mailing_Address_Street_2,r.Case_Mailing_Address_Street_2);
			self.SearchAddress2City := fn_left(l.Case_Mailing_Address_City,r.Case_Mailing_Address_City);
			self.SearchAddress2State := fn_left(l.Case_Mailing_Address_State,r.Case_Mailing_Address_State);
			self.SearchAddress2Zip := fn_left(l.Case_Mailing_Address_Zip,r.Case_Mailing_Address_Zip);
			self.SearchSequenceNumber := fn_left((string)l.PrepRecSeq,(string)r.PrepRecSeq);
			self.OrigSearchSequenceNumber := (unsigned)fn_left((string)l.PrepRecSeq,(string)r.PrepRecSeq);
			self.SearchNCFFileDate := (unsigned)fn_left((string)l.NCF_FileDate,(string)r.NCF_FileDate);
			self.SearchProcessDate := (unsigned)fn_left((string)l.ProcessDate,(string)r.ProcessDate);

			self.CaseState := fn_right(l.Case_State_Abbreviation,r.Case_State_Abbreviation);
			self.CaseBenefitType := fn_right(l.Case_Benefit_Type,r.Case_Benefit_Type);
			self.CaseBenefitMonth := fn_right(l.Case_Benefit_Month,r.Case_Benefit_Month);
			self.CaseID := fn_right(l.Case_Identifier,r.Case_Identifier);
			self.CaseLastName := fn_right(l.Case_Last_Name,r.Case_Last_Name);
			self.CaseFirstName := fn_right(l.Case_First_Name,r.Case_First_Name);
			self.CaseMiddleName := fn_right(l.Case_Middle_Name,r.Case_Middle_Name);
			self.CasePhone1 := fn_right(l.Case_Phone_1,r.Case_Phone_1);
			self.CasePhone2 := fn_right(l.Case_Phone_2,r.Case_Phone_2);
			self.CaseEmail := fn_right(l.Case_Email,r.Case_Email);
			self.CasePhysicalStreet1 := fn_right(l.Case_Physical_Address_Street_1,r.Case_Physical_Address_Street_1);
			self.CasePhysicalStreet2 := fn_right(l.Case_Physical_Address_Street_2,r.Case_Physical_Address_Street_2);
			self.CasePhysicalCity := fn_right(l.Case_Physical_Address_City,r.Case_Physical_Address_City);
			self.CasePhysicalState := fn_right(l.Case_Physical_Address_State,r.Case_Physical_Address_State);
			self.CasePhysicalZip := fn_right(l.Case_Physical_Address_Zip,r.Case_Physical_Address_Zip);
			self.CaseMailStreet1 := fn_right(l.Case_Mailing_Address_Street_1,r.Case_Mailing_Address_Street_1);
			self.CaseMailStreet2 := fn_right(l.Case_Mailing_Address_Street_2,r.Case_Mailing_Address_Street_2);
			self.CaseMailCity := fn_right(l.Case_Mailing_Address_City,r.Case_Mailing_Address_City);
			self.CaseMailState := fn_right(l.Case_Mailing_Address_State,r.Case_Mailing_Address_State);
			self.CaseMailZip := fn_right(l.Case_Mailing_Address_Zip,r.Case_Mailing_Address_Zip);
			self.CaseCountyParishCode := fn_right(l.Case_County_Parish_Code,r.Case_County_Parish_Code);
			self.CaseCountyParishName := fn_right(l.Case_County_Parish_Name,r.Case_County_Parish_Name);
			self.ClientID := fn_right(l.Client_Identifier,r.Client_Identifier);
			self.ClientLastName := fn_right(l.Client_Last_Name,r.Client_Last_Name);
			self.ClientFirstName := fn_right(l.Client_First_Name,r.Client_First_Name);
			self.ClientMiddleName := fn_right(l.Client_Middle_Name,r.Client_Middle_Name);
			self.ClientGender := fn_right(l.Client_Gender,r.Client_Gender);
			self.ClientRace := fn_right(l.Client_Race,r.Client_Race);
			self.ClientEthnicity := fn_right(l.Client_Ethnicity,r.Client_Ethnicity);
			self.ClientSSN := fn_right(l.Client_SSN,r.Client_SSN);
			self.ClientSSNType := fn_right(l.Client_SSN_Type_Indicator,r.Client_SSN_Type_Indicator);
			self.ClientDOB := fn_right(l.Client_DOB,r.Client_DOB);
			self.ClientDOBType := fn_right(l.Client_DOB_Type_Indicator,r.Client_DOB_Type_Indicator);
			self.ClientEligibilityStatus := fn_right(l.Client_Eligible_Status_Indicator,r.Client_Eligible_Status_Indicator);
			self.ClientEligibilityDate := fn_right(l.Client_Eligible_Status_Date,r.Client_Eligible_Status_Date);
			self.ClientPhone := fn_right(l.Client_Phone,r.Client_Phone);
			self.ClientEmail := fn_right(l.Client_Email,r.Client_Email);
			self.StateContactName := fn_right(l.State_Contact_Name,r.State_Contact_Name);
			self.StateContactPhone := fn_right(l.State_Contact_Phone,r.State_Contact_Phone);
			self.StateContactPhoneExtension := fn_right(l.State_Contact_Phone_Extension,r.State_Contact_Phone_Extension);
			self.StateContactEmail := fn_right(l.State_Contact_Email,r.State_Contact_Email);
			self.ClientSequenceNumber := fn_right((string)l.PrepRecSeq,(string)r.PrepRecSeq);
			self.OrigClientSequenceNumber := (unsigned)fn_right((string)l.PrepRecSeq,(string)r.PrepRecSeq);
			self.ClientNCFFileDate := (unsigned)fn_right((string)l.NCF_FileDate,(string)r.NCF_FileDate);
			self.ClientProcessDate := (unsigned)fn_right((string)l.ProcessDate,(string)r.ProcessDate);
			self:=l;
end;


match:=join(inf_ddp,inf_ddp,

		#if(use_state)
			left.Case_State_Abbreviation<>right.Case_State_Abbreviation and
		#end

		#if(use_month)
			left.month_field=right.month_field and
		#end

		//left.Client_Eligible_Status_Indicator=right.Client_Eligible_Status_Indicator and
		IF(left.Case_Benefit_Type='D','S',left.Case_Benefit_Type)=
					IF(right.Case_Benefit_Type='D','S',right.Case_Benefit_Type) and
		left.seq_field<>right.seq_field and
		(left.Case_Identifier<>right.Case_Identifier
		or
		left.Case_State_Abbreviation<>right.Case_State_Abbreviation) and

		#if('L' in matchset)
			left.did_field=right.did_field and
		#end

		#if('N' in matchset)
			(left.fname_field=right.fname_field or
			left.fname_field=right.prefname or
			left.prefname=right.prefname) and
			left.lname_field=right.lname_field and
		#end

		#if('D' not in matchset)
			ut.nneq(left.suffix_field,right.suffix_field)		and
		#end

		#if('V' in matchset)
			left.lname_field=right.lname_field and
			(left.fname_field<>right.fname_field or
			left.fname_field<>right.prefname) and
			(left.fname_field[1]=right.fname_field[1] or
			left.prefname[1]=right.prefname[1] or
			left.fname_field[1]=right.prefname[1]) and
			ut.nneq(left.suffix_field,right.suffix_field)		and
		#end

		#if('S' in matchset)
			(unsigned)left.ssn_field>0 and
			(unsigned)right.ssn_field>0 and
			left.ssn_field=right.ssn_field and
		#end

		#if('D' in matchset)
			(unsigned)left.dob_field>0 and
			(unsigned)right.dob_field>0 and
			left.dob_field=right.dob_field and
		#end

		#if('P' in matchset)
			(unsigned)left.ssn_field>0 and
			(unsigned)right.ssn_field>0 and
			#if(ssn_threshold = 3)
				ssn_value(left.ssn_field,right.ssn_field) > 1 and
			#elseif(ssn_threshold = 2)
				ssn_value(left.ssn_field,right.ssn_field) > 0 and
			#elseif(ssn_threshold = 1)
				ssn_value(left.ssn_field,right.ssn_field) > -1 and
			#else
				ssn_value(left.ssn_field,right.ssn_field) > 1 and
			#end
		#end

		#if('B' in matchset)
			header.gens_ok(left.suffix_field,left.dob_field,right.suffix_field,right.dob_field) and
			(unsigned)left.dob_field>0 and
			(unsigned)right.dob_field>0 and
			#if(dob_threshold = 3)
				header.sig_near_dob(left.dob_field,right.dob_field) and
			#elseif(dob_threshold = 2)
				header.date_value(left.dob_field,right.dob_field) > 1 and
			#elseif(dob_threshold = 1)
				header.date_value(left.dob_field,right.dob_field) > 0 and
			#else
				header.sig_near_dob(left.dob_field,right.dob_field) and
			#end
		#end

		#if('A' in matchset)
			left.pname_field<>'' and
			right.pname_field<>'' and
			left.pname_field=right.pname_field and
			left.prange_field=right.prange_field and
		#end

		#if('C' in matchset)
			left.city_field<>'' and
			right.city_field<>'' and
			left.state_field<>'' and
			right.state_field<>'' and
			left.city_field=right.city_field and
			left.state_field=right.state_field and
		#end

		#if('Z' in matchset)
			left.zip_field<>'' and
			right.zip_field<>'' and
			left.zip_field=right.zip_field and
		#end

		true	//the one just keeps the "and" from messing it up
		,tr(left,right)
		,local);

outfile := dedup(match);

endmacro;