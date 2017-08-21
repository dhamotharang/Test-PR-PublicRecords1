EXPORT Valid_fid := function

//Input OKC Assesor,Deeds

	inLNAssessor			:=	dataset(ln_propertyV2.filenames.inAssessor,LN_PropertyV2.Layouts.PreProcess_Assessor_Layout,thor);

  LNAssess_fidrec := record
	inLNAssessor.ln_fares_id;
	
	integer LNAssesCnt := count(group);
	end;
	
	LNAssessgrp := table(inLNAssessor,LNAssess_fidrec,ln_fares_id,few);
	
	LNAssessset :=  Set(LNAssessgrp(LNAssesCnt > 1),ln_fares_id);
	
	LNAssesfilter :=  inLNAssessor(ln_fares_id in LNAssessset);
	
	LNAssess_fidnewrec := record
	LNAssesfilter.ln_fares_id;
	LNAssesfilter.process_date;
	LNAssesfilter.apna_or_pin_number;
	LNAssesfilter.assessee_name;
	integer LNAssesnewCnt := count(group);
	end;
	
		LNAssessgrpnew := table(LNAssesfilter,LNAssess_fidnewrec,ln_fares_id,process_date,apna_or_pin_number,assessee_name,few);

LNAsses_valid := if ( count(LNAssessgrpnew(LNAssesnewCnt = 1)) > 0,Sequential(Output('Duplicate fares id found in LN tax assesments'),Output(choosen(LNAssessgrpnew(LNAssesnewCnt = 1),10),named('DUPLICATE_OKCASSES_FARES_ID')),FAIL('DUPLICATE FARES ID FOUND IN OKC ASSESMENT RECORDS.ABORT ...')),Output('NO DUPLICATE FARES ID  ASSIGNED TO ASSESMENT RECORDS.CONTINUE...'));
	
	
	inDeeds     			:=	dataset(ln_propertyV2.filenames.inDeeds,LN_PropertyV2.Layouts.PreProcess_Deed_Layout,thor);

	LNDeeds_fidrec := record
	inDeeds.ln_fares_id;
	integer LNdeedsCnt := count(group);
	end;
	
	LNDeedsgrp := table(inDeeds,LNDeeds_fidrec,ln_fares_id,few);
	
	LNDeedsgrpset := Set(LNDeedsgrp(LNdeedsCnt > 1),ln_fares_id);
	
	LNDeedsgrpfilter := inDeeds( ln_fares_id in LNDeedsgrpset);
	
LNDeeds_fidnewrec := record
	LNDeedsgrpfilter.ln_fares_id;
	LNDeedsgrpfilter.process_date;
	LNDeedsgrpfilter.fares_unformatted_apn;
	LNDeedsgrpfilter.name1;
	integer LNdeedsnewCnt := count(group);
	end;	
	
		LNDeedsgrpnew := table(LNDeedsgrpfilter,LNDeeds_fidnewrec,ln_fares_id,process_date,fares_unformatted_apn,name1,few);

LNDeeds_valid :=	if ( count(LNDeedsgrpnew(LNdeedsnewCnt = 1)) > 0,Sequential(Output('Duplicate fares id found in LN tax assesments'),Output(choosen(LNDeedsgrpnew(LNdeedsnewCnt = 1),10),named('DUPLICATE_OKCDEEDS_FARES_ID')),FAIL('DUPLICATE FARES ID FOUND IN OKC DEEDS RECORDS.ABORT ...')),Output('NO DUPLICATE FARES ID  ASSIGNED TO OKC DEEDS RECORDS.CONTINUE...'));

//Fares Assesments and Deeds

  Fares_Asses_rec := record
	LN_PropertyV2.File_Fares_assessor_in.fares_id;
	integer Fares_AssesCnt := count(group);
	end;
	
	FaresAssesgrp := table(LN_PropertyV2.File_Fares_assessor_in,Fares_Asses_rec,fares_id,few);
		
	FaresAssessset := Set(FaresAssesgrp(Fares_AssesCnt > 1),fares_id);
	
	FaresAssesfilter :=  LN_PropertyV2.File_Fares_assessor_in(fares_id in FaresAssessset);
	
	Fares_Asses_newrec := record
	FaresAssesfilter.fares_id;
	FaresAssesfilter.formatted_apn;
	FaresAssesfilter.owner_name;
	integer Fares_AssesCntnew := count(group);
	end;
	
		FaresAssesgrpnew := table(FaresAssesfilter,Fares_Asses_newrec,fares_id,formatted_apn,owner_name,few);

FaresAsses_valid := 	if ( count(FaresAssesgrpnew(Fares_AssesCntnew  = 1)) > 0,Sequential(Output('Duplicate fares id found in fares tax assesments'),Output(choosen(FaresAssesgrpnew(Fares_AssesCntnew = 1),10),named('DUPLICATE_FARESASSE_FARES_ID')),FAIL('DUPLICATE FARES ID FOUND IN FARES ASSESMENT RECORDS.ABORT ...')),Output('NO DUPLICATE FARES ID  ASSIGNED TO FARES ASSESMENT RECORDS.CONTINUE...'));
	
		
	Fares_Deeds_rec := record
	LN_PropertyV2.File_Fares_deeds_in.fares_id;
	integer Fares_DeedsCnt := count(group);
	end;
	
	FaresDeedsgrp := table(LN_PropertyV2.File_Fares_deeds_in,Fares_Deeds_rec,fares_id,few);
	
		
	
	FaresDeedsgrpset := Set(FaresDeedsgrp(Fares_DeedsCnt > 1),fares_id);
	
	FaresDeedsgrpfilter := LN_PropertyV2.File_Fares_deeds_in( fares_id in FaresDeedsgrpset);
	
Fares_Deeds_newrec := record
	FaresDeedsgrpfilter.fares_id;
	FaresDeedsgrpfilter.process_date;
	FaresDeedsgrpfilter.apn_parcel_number_formatted;
	FaresDeedsgrpfilter.owner_buyer_last_name;
	FaresDeedsgrpfilter.owner_buyer_first_name;

	integer Fares_DeedsCntnew := count(group);
	end;	
	
		FaresDeedsgrpnew := table(FaresDeedsgrpfilter,Fares_Deeds_newrec,fares_id,process_date,apn_parcel_number_formatted,owner_buyer_last_name,owner_buyer_first_name,few);

	FaresDeeds_valid := if ( count(FaresDeedsgrpnew(Fares_DeedsCntnew  = 1)) > 0,Sequential(Output('Duplicate fares id found in fares deeds'),Output(choosen(FaresDeedsgrpnew(Fares_DeedsCntnew  = 1),10),named('DUPLICATE_FARESDEEDS_FARES_ID')),FAIL('DUPLICATE FARES ID FOUND IN FARES DEED RECORDS.ABORT ...')),Output('NO DUPLICATE FARES ID  ASSIGNED TO FARES DEED RECORDS.CONTINUE...'));

		
	return	Parallel(
	
	if (count(LNAssessgrp(LNAssesCnt > 1)) > 0, LNAsses_valid,Output('No_Duplicate_LNAssesments_Found')),
	if (count(LNDeedsgrp(LNdeedsCnt > 1)) > 0 , LNDeeds_valid,Output('No_Duplicate_LNDeeds_Found')),
	if (count(FaresAssesgrp(Fares_AssesCnt > 1)) > 0 , FaresAsses_valid,Output('No_Duplicate_FaresAssesments_Found')),
		if (count(FaresDeedsgrp(Fares_DeedsCnt > 1)) > 0 , FaresDeeds_valid,Output('No_Duplicate_FaresDeeds_Found'))

	
	);
	
	end;
		





