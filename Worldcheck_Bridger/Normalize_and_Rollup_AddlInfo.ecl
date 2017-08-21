#option('skipFileFormatCrcCheck', 1);
#option('maxLength', 131072);

import WorldCheck, lib_stringlib, ut;

export Normalize_and_Rollup_AddlInfo(dataset(Layout_WorldCheck_Premium) in_f):= function

	//Standard Additional Info Layout	
	Layout_AddlInfo := record
		string	Type;
		string	Information;
		string	Parsed;
		string	Comments;
	end;
	
	Layout_temp := record//, maxlength(30900)
		string ID;
		Layout_AddlInfo;
		string addl_info;
		//string ID;
	end;

	//Input Files
	//in_f 				:= File_WorldCheck_In;
	in_file_2			:= distribute(in_f, random());
	ds_with_new_fields 	:= in_file_2;

//POPULATE DOB ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
	Layout_dob := record
		in_f;
		string addl_info;
	end;
	
	
//New Multiple DOB's production 3/15/2017

	pattern Splitdates := pattern('[^;]+');
	MyParsedRec := record, maxlength(30900)
		ds_with_new_fields;
		string CompleteDOB := TRIM(MATCHTEXT(Splitdates),left,right);
	end;


	MyParsedDOB := PARSE(ds_with_new_fields(trim(Date_Of_Birth,left,right) != ''),Date_Of_Birth,Splitdates,MyParsedRec,scan,first);
	
	Layout_dob trfDOB(MyParsedDOB l) := transform
			self.addl_info		:= TRIM(l.CompleteDOB,left,right);
			self				:= l;
	end;


	ds_NormDOBs := project(MyParsedDOB, trfDOB(left));

	
	//Calculate DOB with Age and Age_As_Of_Date
	Layout_dob dobTran(ds_NormDOBs l):= transform
		self.addl_info 	:= if(trim(L.date_of_birth,left,right)='' 
								and trim(L.age,left,right) between '18' and '95'
								and (trim(L.age_as_of_date,left,right)[1..2] between '19' and '20') 
								and length(trim(L.age_as_of_date[1..4],left,right))=4,
								(string)((integer)L.age_as_of_date[1..4]-(integer)L.age)+'/00/00',
								L.date_of_birth);
		self 			:= l;
	end;

	populate_dob := project(ds_NormDOBs, dobTran(left));
	
	Layout_temp standardTran(populate_dob l):= transform
		self.type 				:= 'Date of Birth';
		self.information		:= l.addl_info;
								//Bridger needs dobs in YYYY/MM/DD format in order to do a search	
		self.parsed				:= if(length(trim(l.addl_info, left, right))=10 and regexfind('/', trim(l.addl_info, left, right)[5],0)<>'' and regexfind('/', trim(l.addl_info, left, right)[8],0)<>'',
										l.addl_info,
										'');
		self.comments 			:= '';
		self.id					:= l.uid;
		self := l;
	end;
	
ds_reformdob := project(populate_dob, standardTran(left))(information<>'');

//Old version - obsolete 2017/03/15
/*
	//Calculate DOB with Age and Age_As_Of_Date
	Layout_dob dobTran(ds_with_new_fields l):= transform
		self.addl_info 	:= if(trim(L.date_of_birth,left,right)='' 
								and trim(L.age,left,right) between '18' and '95'
								and (trim(L.age_as_of_date,left,right)[1..2] between '19' and '20') 
								and length(trim(L.age_as_of_date[1..4],left,right))=4,
								(string)((integer)L.age_as_of_date[1..4]-(integer)L.age)+'/00/00',
								L.date_of_birth);
		self 			:= l;
	end;

	populate_dob := project(ds_with_new_fields, dobTran(left));
	
	Layout_temp standardTran(populate_dob l):= transform
		self.type 				:= 'Date of Birth';
		self.information		:= l.addl_info;
								//Bridger needs dobs in YYYY/MM/DD format in order to do a search	
		self.parsed				:= if(length(trim(l.addl_info, left, right))=10 and regexfind('/', trim(l.addl_info, left, right)[5],0)<>'' and regexfind('/', trim(l.addl_info, left, right)[8],0)<>'',
										l.addl_info,
										'');
		self.comments 			:= '';
		self.id					:= l.uid;
		self := l;
	end;
	
ds_reformdob := project(populate_dob, standardTran(left))(information<>'');
*/
//END DOB section

//POPULATE POSITIONS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	// Shared parsing pieces for Positions
	pattern SingleName := pattern('[^;]+');

	MyParsedRecord := record//, maxlength(30900)
		ds_with_new_fields;
		string CompleteName := TRIM(MATCHTEXT(SingleName),left,right);
	end;

	Invalid_Names := ['',',','NONE','N/A','NOT AVAILABLE','UNAVAILABLE','UNKNOWN','NONE REPORTED'];

	////////// Begin parsing and normalizing Positions//////////
	// Parse the Position values	
	MyParsedPosition := PARSE(ds_with_new_fields(trim(Position,left,right) != ''),Position,SingleName,MyParsedRecord,scan,first);

	// Specify the invalid Position values
	// Transform the Position values
	Layout_temp trfPosition(MyParsedPosition l) := transform
		self.addl_info		:= IF(stringlib.StringToUpperCase(TRIM(l.CompleteName,left,right)) in Invalid_Names
											,SKIP
											,TRIM(l.CompleteName,left,right));
		self.ID				:= l.uid;
		self.Type 			:= 'Occupation'; // Name type of two for the AKA records
		self.Information	:= '';
		self.Parsed			:= '';
		self.Comments		:= '';
	end;

	// Normalize the Position values
	ds_NormPositions := NORMALIZE(MyParsedPosition
                            ,1
							,trfPosition(left));
							
	Layout_temp positionTran(ds_NormPositions l):= transform
		self.Information	:= l.addl_info;
		self 				:= l;
	end;
	
ds_reformPosition := project(ds_NormPositions, positionTran(left));

//POPULATE POB ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  

	////////// Begin parsing and normalizing POBs//////////
	// Parse the POB values	
	MyParsedPOB := PARSE(ds_with_new_fields(trim(Places_Of_Birth,left,right) != ''),Places_Of_Birth,SingleName,MyParsedRecord,scan,first);

	// Specify the invalid POB values
	// Transform the POB values
	Layout_temp trfPOB(MyParsedPOB l) := transform
		self.addl_info		:= IF(stringlib.StringToUpperCase(TRIM(l.CompleteName,left,right)) in Invalid_Names
											,SKIP
											,TRIM(l.CompleteName,left,right));
		self.ID				:= l.uid;
		self.Type 			:= 'Place of Birth'; // Name type of two for the AKA records
		self.Information	:= '';
		self.Parsed			:= '';
		self.Comments		:= '';
	end;

	// Normalize the POB values
	ds_NormPOBs := NORMALIZE(MyParsedPOB
                            ,1
							,trfPOB(left));
							
	Layout_temp POBTran(ds_NormPOBs l):= transform
		self.Information	:= l.addl_info;
		self 				:= l;
	end;
	
ds_reformPOB := project(ds_NormPOBs, POBTran(left));

//POPULATE EXTERNAL SOURCES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

	// Shared parsing pieces for external sources
	pattern SingleExtSrc  := pattern('[^ ]+');

	MyParsedExtSrcRecord := record//, maxlength(30900)
		in_f;
		string CompleteExtSrc := TRIM(MATCHTEXT(SingleExtSrc),left,right);
	end;

	// Invalid values which should be skipped
	Invalid_Values := [''             ,','
				  ,'NONE'         ,'N/A'
				  ,'NOT AVAILABLE','UNAVAILABLE'
				  ,'UNKNOWN'      ,'NONE REPORTED'];

	////////// Begin parsing and normalizing ExtSourcess//////////
	// Parse the ExtSources values	
	MyParsedExtSources := PARSE(ds_with_new_fields(trim(External_Sources,left,right) != ''),External_Sources,SingleExtSrc,MyParsedExtSrcRecord,scan,first);

	// Specify the invalid ExtSources values
	// Transform the ExtSources values
	Layout_temp trfExtSources(MyParsedExtSources l) := transform
		self.addl_info		:= IF(stringlib.StringToUpperCase(TRIM(l.CompleteExtSrc,left,right)) in Invalid_Values
											,SKIP
											,TRIM(l.CompleteExtSrc,left,right));
		self.ID				:= l.uid;
		self.Type 			:= 'Other Information'; // Name type of two for the AKA records
		self.Information	:= 'External Sources';
		self.Parsed			:= '';
		self.Comments		:= '';
	end;

	// Normalize the ExtSources values
	NormExtSourcess 	:= NORMALIZE(MyParsedExtSources
                            ,1
							,trfExtSources(left));
							
//ALL ADDL INFO FOR STRATA ///////////////////////////////////////////
	
 all_addl_info := ds_reformdob + ds_reformPosition + ds_reformPOB + NormExtSourcess : persist('~thor_200::persist::worldcheck::all_links');
	
//////////////////////////////////////////////////////////////////////

	
	
	Layout_temp ExtSourcesTran(NormExtSourcess l):= transform
		self.Comments	:= trim(l.addl_info, left, right);
		self 			:= l;
	end;
	
	reformExtSources := project(NormExtSourcess, ExtSourcesTran(left));

	layout_rec := record, maxlength(100000)
		Layout_temp;
		string names 	:= '';
		integer comp_cnt;
	end;

	layout_rec CompP(reformExtSources l) := transform
		self.names 		:= trim(l.comments, left, right);
		self.comp_cnt	:= 0;
		self 			:= l;
	end;

	ExtSourceP 	:= project(reformExtSources, compP(left));
	ExtSourceD 	:= dedup(ExtSourceP, record, all);
	sortcfind 	:= sort(ExtSourceD,id);

	//Denorm Exteral Sources (append |)
	layout_rec denorm_recs(sortcfind l, sortcfind r, unsigned c) := transform
		self.names := if(c = 1,
							r.names,
						if(l.names <> '',
							l.names + ' | ' + r.names,
							r.names));
		self := l
	end;

	denorm_out 	:= denormalize(sortcfind, sortcfind,
                                (left.id = right.id),
                                denorm_recs(left, right,counter));

	dedup_out 	:= dedup(denorm_out, id, all);

	Layout_temp proj_rec1(dedup_out l) := transform
		self.Comments := l.names;
		self := l;
	end;

	ds_reformExtSources := project(dedup_out,proj_rec1(left));//:persist('~thor_200::persist::in::worldcheck_external_sources');

////////////////////////////////////////////////////////////////////////////

//Concat Additional Information Groupings
concatAddlInfo := ds_reformdob + ds_reformPosition + ds_reformPOB + ds_reformExtSources : persist('~thor_200::persist::worldcheck::all_additionalinfo');

	// Rollup of Additional Information Groupings
	AddlInfo_rollup := record
		string ID;
		dataset(Layout_AddlInfo) AdditionalInfo;
		//string ID;
	end;

	AddlInfo_rollup t_AI(concatAddlInfo L) := transform
		self.AdditionalInfo 	:= row(L, Layout_AddlInfo);
		self := L;
	end;

	p_AddlInfo := project(concatAddlInfo, t_AI(left));

	AddlInfo_rollup   t_AddlInfo_child(p_AddlInfo L, p_AddlInfo R) := transform
		self.AdditionalInfo   	:= row({r.AdditionalInfo[1].Type,
													r.AdditionalInfo[1].Information,
													r.AdditionalInfo[1].Parsed,
													r.AdditionalInfo[1].Comments}
												   , Layout_AddlInfo)+L.AdditionalInfo;
		self              				:= L;
	end;

AddlInfo_out := rollup(sort(p_AddlInfo,record)
						, t_AddlInfo_child(left,right)
						, ID): persist('~thor_200::persist::worldcheck::additionalinfo');

//output(AddlInfo_out(ID='153480'));
return sequential(output(all_addl_info), 
					output(AddlInfo_out));

end;