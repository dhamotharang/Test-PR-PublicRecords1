

IMPORT std, NAC_V2, wk_ut;

;
/*divide(INTEGER	dividend ,INTEGER	divisor) := FUNCTION
	decimal8_2 x := (dividend*1000)/divisor;
	x1 := ROUND(x);
	decimal6_1 v := x1/10;	
	return v;	
END;*/
// 
real get_pct(INTEGER8	dividend ,INTEGER8	divisor)
  :=		
			(real)MAP(
				divisor=0 => 0,
				//divide(dividend, divisor)
				(100*dividend)/divisor
			);

string fmt_pct7(INTEGER	dividend ,INTEGER	divisor) := FUNCTION
			string7 v := realformat(get_pct(dividend, divisor), 7, 3);
			return MAP(
						v[2]=' ' => '00' + v[3..],
						v[1]=' ' => '0' + v[2..],
						v) + '%';
END;

string fmt_pct6(INTEGER	dividend ,INTEGER	divisor) := FUNCTION
			string6 v := realformat(get_pct(dividend, divisor), 6, 2);
			return 	v + '%';
END;
			
Missing := '{missing}';

LF := '\n';

	rText	:=
		record
			string	TextLine{maxlength(512000)};
	end;

EXPORT Print := MODULE
	export dRow := RECORD
		string130		text;
		string1			eol := LF;
	END;
	
	shared dNcrRow := RECORD
		string2		state;
		string4		RecordCode;
		string1		Level;
		string4		textValue;
		string4		fieldCode;
		string32	FieldName;
		string10	cnt;
		string10	pct;
		string32	SampleValue := '';
	END;
	
	shared errText := PROJECT(SORT(nac_v2.ValidationCodes.dsErrorCodes,errCode), TRANSFORM(dRow,
								self.text := left.textValue + ' = ERROR - ' + left.msg;));
	shared warningText := PROJECT(SORT(nac_v2.ValidationCodes.dsWarningCodes,errCode), TRANSFORM(dRow,
								self.text := left.textValue + ' = WARNING - ' + left.msg;));



	export NCR_Header := DATASET([
				{'====================================== FIELD MESSAGES ==================================='},
				{(string6)'STATE'
						+ (string6)'CODE' 
						+ (string32)'FIELD'
						+ (string20)'SAMPLE'
						+ ' ' + (string10)'MESSAGE' 
						+ (string8)'  COUNT'
						+ (string6)'   PCT'}
				], dRow);



	// Legend for NCR2 report
	export Legend := DATASET([{'LEGEND'},{'======'}], dRow) & errText & DATASET([{''}], dRow) & warningText;

	export NCR_Samples(DATASET(nac_v2.ValidationCodes.rError) errs, integer nTotal, string2 st = 'XX') := FUNCTION
					t := TABLE(errs, {errs.Severity, errs.errCode, errs.fieldCode, errs.Level, n := COUNT(GROUP)}, 
																	Severity, errCode, fieldCode, level, few);
					errs_d := DEDUP(errs, Severity, errCode, fieldCode, Level, ALL);	// pick a random sample error value
					
					samples := JOIN(t, errs_d,  
												left.Severity=right.Severity and left.errCode=right.errCode 
															and left.fieldCode=right.fieldCode and left.Level=right.Level,
												TRANSFORM(dNcrRow,
													self.state := if(right.state='', 'XX', right.state);
													self.TextValue := nac_V2.ValidationCodes.GetErrorText(left.Severity, left.errCode);
													self.FieldName := nac_v2.ValidationCodes.GetFieldName(left.FieldCode);
													self.cnt := intformat(left.n, 8, 0);
													self.pct := fmt_pct6(left.n, nTotal);
													self.SampleValue := if(right.badValue='', '{missing}', 
																				IF(self.TextValue = 'W116', $.ValidationCodes.addr_errors(right.badValue),
																						right.badValue));
													self.RecordCode := right.RecordCode;
													self := left;),
													KEEP(1), INNER);
					return SORT(samples, textValue);
	END;
	
	export NCR2_Summary(integer cnt, integer nErrors, integer nWarnings) := DATASET([
												{''},
												{'TOTAL RECORDS  '+ INTFORMAT(cnt, 12, 0)},
												{'TOTAL ERRORS   '+ INTFORMAT(nErrors, 12, 0)},
												{'TOTAL WARNINGS '+ INTFORMAT(nWarnings, 12, 0)},
												{''}
												], dRow);
	



	export NCR2_Report(string lfn, DATASET(nac_v2.ValidationCodes.rError) errs, integer nTotal, integer nErrors,
																				integer nWarnings,		// total warnings
																				string2 st='XX', boolean reject = false,  
																				DATASET(NAC_V2.Layouts2.rItemSummary) programs,
																				DATASET(NAC_V2.Layouts2.rItemSummary) types,
																				BOOLEAN show_email_message) := FUNCTION

GroupID := STD.Str.ToLowerCase(lfn[6..9]);

boolean IsOnboarding(string gid) := NAC_V2.dNAC2Config(GroupID=gid)[1].Onboarding in ['y','Y'];
IsOnboardingMessage := IF(IsOnboarding(GroupID) = FALSE, 
		STD.Str.toUpperCase(GroupID) + ' is in Production, file will be FULLY ingested. ', 
		STD.Str.toUpperCase(GroupID) + ' is onboarding, file is STAGED for file validation only. ');

internal_use_message := IF(show_email_message, '*** For Internal Use only ***', '');
onboarding_message := IF(show_email_message, IsOnboardingMessage, '');

  d_prog := programs(itemcode = 'D');  // DSNAP
	UNSIGNED4	d_count :=  d_prog[1].counts;  
	s_prog := programs(itemcode = 'S');  // SNAP
	UNSIGNED4 s_count := s_prog[1].counts; 
	t_prog := programs(itemcode = 'T');  // TANF
	UNSIGNED4 t_count := t_prog[1].counts;
	m_prog := programs(itemcode = 'M');  // Medicaid
	UNSIGNED4 m_count := m_prog[1].counts;
	c_prog := programs(itemcode = 'C');  // Child Care
	UNSIGNED4 c_count := c_prog[1].counts;
	n_prog := programs(itemcode = 'N');  // Child Nutr.
	UNSIGNED4 n_count := n_prog[1].counts;
	p_prog := programs(itemcode = 'P');  // CHIP
	UNSIGNED4 p_count := p_prog[1].counts;
	i_prog := programs(itemcode = 'I');  // WIC
  UNSIGNED4 i_count := i_prog[1].counts;      

	h_prog := programs(itemcode = 'H');  // Public Housing
	UNSIGNED4 h_count := h_prog[1].counts;   
	u_prog := programs(itemcode = 'U');  // Unemployment Insurance
	UNSIGNED4 u_count := u_prog[1].counts;   
	w_prog := programs(itemcode = 'W');  // Workers Compensation
	UNSIGNED4 w_count := w_prog[1].counts;  
	v_prog := programs(itemcode = 'V');  // Drivers License   
	UNSIGNED4 v_count := v_prog[1].counts;  



	ds_programs_label 				:= DATASET([{ 0, 'RECORD COUNTS BY PROGRAM:'}] , {UNSIGNED4 id, string130 text});
	ds_programs_dsnap 				:= DATASET([{ 1, 'DSNAP           \t' + INTFORMAT(d_count , 12, 0)}] , {UNSIGNED4 id, string130 text});
	ds_programs_snap  				:= DATASET([{ 2, 'SNAP            \t' + INTFORMAT(s_count , 12, 0)}] , {UNSIGNED4 id, string130 text});
	ds_programs_tanf  				:= DATASET([{ 3, 'TANF            \t' + INTFORMAT(t_count , 12, 0)}] , {UNSIGNED4 id, string130 text});
	ds_programs_med   				:= DATASET([{ 4, 'Medicaid        \t' + INTFORMAT(m_count , 12, 0)}] , {UNSIGNED4 id, string130 text});
	ds_programs_cc    				:= DATASET([{ 5, 'Child Care      \t' + INTFORMAT(c_count , 12, 0)}] , {UNSIGNED4 id, string130 text});
	ds_programs_cn    				:= DATASET([{ 6, 'Child Nutr.     \t' + INTFORMAT(n_count , 12, 0)}] , {UNSIGNED4 id, string130 text});
	ds_programs_chip  				:= DATASET([{ 7, 'CHIP            \t' + INTFORMAT(p_count , 12, 0)}] , {UNSIGNED4 id, string130 text});
	ds_programs_wic   				:= DATASET([{ 8, 'WIC             \t' + INTFORMAT(i_count , 12, 0)}] , {UNSIGNED4 id, string130 text});
	ds_programs_publichousing := DATASET([{ 9, 'Public Housing  \t' + INTFORMAT(h_count , 12, 0)}] , {UNSIGNED4 id, string130 text});
	ds_programs_unemployment  := DATASET([{10, 'Unemployment    \t' + INTFORMAT(u_count , 12, 0)}] , {UNSIGNED4 id, string130 text});
	ds_programs_workerscomp   := DATASET([{11, 'Workers Comp.   \t' + INTFORMAT(w_count , 12, 0)}] , {UNSIGNED4 id, string130 text});
	ds_programs_driverslic    := DATASET([{12, 'Drivers License \t' + INTFORMAT(v_count , 12, 0)}] , {UNSIGNED4 id, string130 text});
  ds_programs_endspace := DATASET([{999, ''}] , {UNSIGNED4 id, string130 text}); 

	ds_programs_all_01 :=  
		ds_programs_label +
		IF(d_count>0 , ds_programs_dsnap) +
		IF(s_count>0 , ds_programs_snap) +
		IF(t_count>0 , ds_programs_tanf) +
		IF(m_count>0 , ds_programs_med) +
		IF(p_count>0 , ds_programs_chip) +
		IF(c_count>0 , ds_programs_cc) +
		IF(i_count>0 , ds_programs_wic) +
		IF(n_count>0 , ds_programs_cn) +
		IF(h_count>0 , ds_programs_publichousing) +
		IF(u_count>0 , ds_programs_unemployment) +
		IF(w_count>0 , ds_programs_workerscomp) +
		IF(v_count>0 , ds_programs_driverslic) +
		ds_programs_endspace; 

		ds_programs_all := PROJECT(SORT(ds_programs_all_01, id, LOCAL), drow); 

		AD01_type := types(itemcode = 'AD01');  // Addresses
		UNSIGNED4 AD01_count := AD01_type[1].counts;
		CA01_type := types(itemcode = 'CA01');  // Cases 
		UNSIGNED4 CA01_count := CA01_type[1].counts;
		CL01_type := types(itemcode = 'CL01');  //  Clients
		UNSIGNED4 CL01_count := CL01_type[1].counts;
		SC01_type := types(itemcode = 'SC01');  //  State Contacts
		UNSIGNED4 SC01_count := SC01_type[1].counts;
		EX01_type := types(itemcode = 'EX01');  //  Exceptions
		UNSIGNED4 EX01_count := EX01_type[1].counts; 


				ds := DATASET([{lfn}], dRow) 
						 	& DATASET([{internal_use_message}], dRow) 
							& DATASET([{onboarding_message}], dRow) 	
							& NCR_Header
							& PROJECT(SORT(NCR_Samples(errs, nTotal, st),textValue), TRANSFORM(dRow,
										self.text := (string6)left.state + (string6)left.RecordCode +
																	(string32)nac_v2.ValidationCodes.GetFieldName(left.FieldCode) +
																	(string20)left.SampleValue + ' ' +
																	(string10)left.textValue +
																	left.cnt +
																	left.pct;))
							& DATASET([
												{''},
												{'TOTAL RECORDS \t'+ INTFORMAT(nTotal, 12, 0)},
												{'TOTAL ERRORS  \t'+ INTFORMAT(nErrors, 12, 0)},
												{'TOTAL WARNINGS\t'+ INTFORMAT(nWarnings, 12, 0)},
												{''}
												], dRow)
												

	 			 
					& ds_programs_all 
			 

				 	& DATASET([
			 							{'RECORD COUNTS BY TYPE:'},										
										{'AD01          \t' + INTFORMAT(AD01_count , 12, 0)},
										{'CA01          \t' + INTFORMAT(CA01_count , 12, 0)},
										{'CL01          \t' + INTFORMAT(CL01_count , 12, 0)},
										{'SC01          \t' + INTFORMAT(SC01_count , 12, 0)},
										{'EX01          \t' + INTFORMAT(EX01_count , 12, 0)},
										{''} 
									], dRow)																
							& IF(reject,
										DATASET([{'FILE CONTAINS TOO MANY ERRORS AND CANNOT BE ACCEPTED FOR PROCESSING.   ****   FILE WAS REJECTED   ********'},{''}], dRow),
										DATASET([{'FILE CONTENT IS ACCEPTABLE.   ****   FILE WILL BE PROCESSED   ********'},{''}], dRow))
							& Legend;
				return ds;
	END;



	dText := RECORD
		string			text;
	END;	
	EXPORT string NCR2_to_Text(DATASET(dRow) dNcr2) := FUNCTION
	 	ds := PROJECT(dNcr2, TRANSFORM(dText,
						 self.Text := TRIM(left.Text);));
			dText	tText(dText l, dText r)	:= 
				transform
					self.Text	:=	trim(l.Text) + LF + trim(r.Text);
				end;
		toText		:=	rollup(ds, true, tText(left, right));
		return toText[1].Text;
	END;




	export	rNCD	:=
	record
		string1		Level;					// C=Contribution, R=Record, F=Field
		string2		filler1 := '  ';
		string4		RecordCode;
		string2		filler2 := '  ';
		string4		fieldCode;
		string2		filler3 := '  ';
		string4		textValue;
		string2		filler4 := '  ';
		string25	FieldName;
		string2		filler5 := '  ';
		string12	cnt;
		string2		filler6 := '  ';
		string8		pct;
		string2		filler7 := '  ';
		string80	SampleValue;
		string1		eol	:=	'\n';
	end;

	
	export NCD2_Report(string lfn, DATASET(nac_v2.ValidationCodes.rError) errs, integer nTotal, integer nErrors,
																				integer nWarnings,		// total warnings
																				integer nWarned,			// Records with warnings
																				integer nRejected,
																				string2 st='XX', boolean reject = false) := FUNCTION
																				
				dPreamble	:=	dataset([
								{'C','','','',	'1001','', '','',	'File Name','',  '','', '','', lfn},
								{'C','','','',	'1002','', '','',	'File Accepted','',  '','', '','', IF(reject,'NO', 'YES')},
								{'C','','','',	'1003','', '','',	'Total Records','',  INTFORMAT(nTotal, 12, 1),'', '','', ''},
								{'C','','','',	'1004','', '','',	'Accepted Records','',  INTFORMAT(nTotal-nRejected, 12, 1),'', fmt_pct7(nTotal-nRejected,nTotal),'', ''},
								{'C','','','',	'1005','', '','',	'Rejected Records','',  INTFORMAT(nRejected, 12, 1),'', fmt_pct7(nRejected,nTotal),'', ''},
								{'C','','','',	'1098','', '','',	'Warnings','',  INTFORMAT(nWarnings, 12, 1),'', fmt_pct7(nWarned,nTotal),'', ''},
								{'C','','','',	'1099','', '','',	'Errors','',  INTFORMAT(nErrors, 12, 1),'', fmt_pct7(nRejected,nTotal),'', ''}
												], rNCD
									 );
									 
				dBody := PROJECT(NCR_Samples(errs, nTotal, st), TRANSFORM(rNCD,
																	self.pct := fmt_pct7((integer)left.cnt, nTotal);
																	self.cnt := INTFORMAT((integer)left.cnt, 12, 1);
																	self := left;));
		
				dEnd	:=	dataset([
								{'C','','','',	'9999','', '','',	'End of Report','',  '','', '','', ''}], rNCD);
																				
				ds := dPreamble & SORT(dBody,fieldCode) & dEnd;
				return ds;
	END;
	
	
	export rNCX2 := RECORD						// reject report
				string4			RecordCode;
				string2			ProgramState;
				string1			ProgramCode;
				string20		CaseId;
				string20		ClientId;
				//string1			Severity;
				string1			Level;
				string4			ErrorCode;
				string4			fieldCode;
				string32		FieldName;
				string32		ErrorMessage;
				string32		SampleValue;
				string1			eol := '\n'
		END;
		
		rNcx2 toNcx2(nac_v2.ValidationCodes.rError err, string4 RecordCode, string2 ProgramState, string1 ProgramCode,
										string20 CaseId, string20 ClientId) := TRANSFORM
									self.RecordCode := RecordCode;
									self.ProgramState := ProgramState;
									self.ProgramCode := ProgramCode;
									self.CaseId := CaseId;
									self.ClientId := ClientId;
									self.ErrorMessage := nac_V2.ValidationCodes.GetErrorMsg(err.Severity, err.errCode);
									self.ErrorCode := nac_V2.ValidationCodes.GetErrorText(err.Severity, err.errCode);
									self.FieldName := nac_v2.ValidationCodes.GetFieldName(err.FieldCode);
									self.SampleValue := if(err.badValue='', Missing, 
											IF(self.ErrorCode = 'W116', $.ValidationCodes.addr_errors(err.badValue),
								err.badValue));


									self := err;
							END;

	
	export NCX2_Report( DATASET(nac_v2.Layouts2.rCaseEx) cases
												,DATASET(nac_v2.Layouts2.rClientEx) clients
												,DATASET(nac_v2.Layouts2.rAddressEx) addresses
												,DATASET(nac_v2.Layouts2.rStateContactEx) contacts
												,DATASET(nac_v2.Layouts2.rExceptionEx) exceptions
												,DATASET(nac_v2.Layouts2.rBadRecordEx) badRecords
												) := FUNCTION

		rr_cases := NORMALIZE(cases(errors>0 OR warnings>0), left.dsErrs, toNcx2(RIGHT,
														'CA01',
														left.ProgramState, left.ProgramCode, left.CaseId, ''
														));

		rr_clients := NORMALIZE(clients(errors>0 OR warnings>0), LEFT.dsErrs, toNcx2(RIGHT,
														'CL01',
														left.ProgramState, left.ProgramCode, left.CaseId, left.ClientId
														));

		rr_addresses := NORMALIZE(addresses(errors>0 OR warnings>0), left.dsErrs, toNcx2(RIGHT,
														'AD01',
														left.ProgramState, left.ProgramCode, left.CaseId, left.ClientId
														));

		rr_contacts := NORMALIZE(contacts(errors>0 OR warnings>0), LEFT.dsErrs, toNcx2(RIGHT,
														'SC01',
														left.ProgramState, left.ProgramCode, left.CaseId, left.ClientId
													));

		rr_exceptions := NORMALIZE(exceptions(errors>0 OR warnings>0), LEFT.dsErrs, toNcx2(RIGHT,
													'EX01',
													left.SourceProgramState, left.SourceProgramCode, '', left.SourceClientId
													));

		rr_badRecords := NORMALIZE(badRecords(errors>0 OR warnings>0), LEFT.dsErrs, toNcx2(RIGHT,
													'XXXX',
													'', '', '', ''
													));

		records := rr_cases + rr_clients + rr_addresses + rr_contacts + rr_exceptions + rr_badRecords;
	
		return SORT(CHOOSEN(records, 1000),errorcode);		// HHSCO-35
			
	END;

END;