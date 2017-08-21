#option('skipFileFormatCrcCheck', 1);
#option('maxLength', 131072);

import WorldCheck, lib_stringlib, ut;

export Mapping_and_Rollup_AddlInfo(dataset(Layout_WorldCheck_Premium) in_f):= function

	//Standard Additional Info Layout	
	Layout_AddlInfo := record
		string	Type{xpath('Type')};
		string	Information{xpath('Information')};
		string	Parsed{xpath('Parsed')};
		string	Comments{xpath('Comments')};
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
	

//New Multiple DOB's 

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

	ds_NormDOB := project(MyParsedDOB, trfDOB(left));
	

	//Calculate DOB Dob Field
	Layout_dob dobTran2(ds_NormDOB l):= transform
		self.addl_info 	:= l.addl_info;
		self 							:= l;
	end;

	populate_dob_flow1 := project(ds_NormDOB((trim(date_of_birth,left,right)!='')  and 
						(trim(age,left,right) not between '18' and '95') and 
						(trim(age_as_of_date,left,right)[1..2] not between '19' and '20') and 
						(length(trim(age_as_of_date[1..4],left,right))!=4))
						,dobTran2(left));
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////																										
	//Calculate DOB with Age and Age_As_Of_Date --- Bugzilla #86894	
							Layout_dob dobTran(ds_with_new_fields l, unsigned1 cnt):= transform
								string10 addl_info1 	:= (string)((integer)L.age_as_of_date[1..4]-(integer)L.age)+'/00/00';
							
								string10 addl_info2 	:= if(addl_info1 !='',(string)((integer)addl_info1[1..4]-1)+'/00/00','');
		
								self.addl_info := choose(cnt,addl_info1,addl_info2);
								self 			:= l;
							end;
							populate_dob_flow2 := normalize(ds_with_new_fields((trim(date_of_birth,left,right)='')  and 
											(trim(age,left,right) between '18' and '95') and 
											(trim(age_as_of_date,left,right)[1..2] between '19' and '20') and 
											(length(trim(age_as_of_date[1..4],left,right))=4))
											,2, dobTran(left,counter));
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	populate_dob := populate_dob_flow1 + populate_dob_flow2;
	
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
	
	ds_reformd := project(populate_dob, standardTran(left))(information<>'');//: persist('~thor_200::persist::worldcheck::all_dob');


//Remove '/' and replace with '-' for dates//////////////////////////////////////////////////////////////////////////
	
	ds_reformd removeSlash(ds_reformd l) := transform
		self.information 	:= _Functions.Fix_Date(l.information);
		self.parsed 		:= _Functions.Fix_Date(l.parsed);
		self.addl_info		:= _Functions.Fix_Date(l.addl_info);							
		self := l;
	end;

ds_reformdob := project(ds_reformd, removeSlash(left)): persist('~thor_200::persist::worldcheck::all_dob');

//Old version
/*
	//Calculate DOB Dob Field
	Layout_dob dobTran2(ds_with_new_fields l):= transform
		self.addl_info 	:= 	L.date_of_birth;
		self 			:= l;
	end;

	populate_dob_flow1 := project(ds_with_new_fields((trim(date_of_birth,left,right)!='')  and 
																										(trim(age,left,right) not between '18' and '95') and 
																										(trim(age_as_of_date,left,right)[1..2] not between '19' and '20') and 
																										(length(trim(age_as_of_date[1..4],left,right))!=4))
																										,dobTran2(left));
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////																										
	//Calculate DOB with Age and Age_As_Of_Date --- Bugzilla #86894	
							Layout_dob dobTran(ds_with_new_fields l, unsigned1 cnt):= transform
								string10 addl_info1 	:= (string)((integer)L.age_as_of_date[1..4]-(integer)L.age)+'/00/00';
	
							
								string10 addl_info2 	:= if(addl_info1 !='',(string)((integer)addl_info1[1..4]-1)+'/00/00','');
		
								self.addl_info := choose(cnt,addl_info1,addl_info2);
								self 			:= l;
							end;
													populate_dob_flow2 := normalize(ds_with_new_fields((trim(date_of_birth,left,right)='')  and 
																										(trim(age,left,right) between '18' and '95') and 
																										(trim(age_as_of_date,left,right)[1..2] between '19' and '20') and 
																										(length(trim(age_as_of_date[1..4],left,right))=4))
																										,2, dobTran(left,counter));
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	populate_dob := populate_dob_flow1 + populate_dob_flow2;
	
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
	
	ds_reformd := project(populate_dob, standardTran(left))(information<>'');//: persist('~thor_200::persist::worldcheck::all_dob');


//Remove '/' and replace with '-' for dates//////////////////////////////////////////////////////////////////////////
	
	ds_reformd removeSlash(ds_reformd l) := transform
		self.information 	:= _Functions.Fix_Date(l.information);
		self.parsed 		:= _Functions.Fix_Date(l.parsed);
		self.addl_info		:= _Functions.Fix_Date(l.addl_info);							
		self := l;
	end;

	ds_reformdob := project(ds_reformd, removeSlash(left)): persist('~thor_200::persist::worldcheck::all_dob');

// END of DOB
*/
//POPULATE POSITIONS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	// Shared parsing pieces for Positions
	pattern SingleName := pattern('[^;]+');

	MyParsedRecord := record, maxlength(30900)
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

	// Reformate Position values
	ds_NormPositions := project(MyParsedPosition, trfPosition(left));
							
	Layout_temp positionTran(ds_NormPositions l):= transform
		self.Information	:= l.addl_info;
		self 				:= l;
	end;
	
ds_reformPosition := project(ds_NormPositions, positionTran(left)): persist('~thor_200::persist::worldcheck::all_occupations');

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

	// Reformat POB values
	ds_NormPOBs := project(MyParsedPOB, trfPOB(left));
							
	Layout_temp POBTran(ds_NormPOBs l):= transform
		self.Information	:= l.addl_info;
		self 				:= l;
	end;
	
ds_reformPOB := project(ds_NormPOBs, POBTran(left)): persist('~thor_200::persist::worldcheck::all_pob');

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
							
	Layout_temp ExtSourcesTran(NormExtSourcess l):= transform
		self.Comments	:= trim(l.addl_info, left, right);
		self 			:= l;
	end;
	
	reformExtSources := project(NormExtSourcess, ExtSourcesTran(left)): persist('~thor_200::persist::worldcheck::all_ext_sources');

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

	ds_reformExtSources := project(dedup_out,proj_rec1(left));

////////////////////////////////////////////////////////////////////////////////////////////

//Concat Additional Information Groupings
concatAddlInfo := ds_reformdob + ds_reformPosition + ds_reformPOB + ds_reformExtSources; 

	// Rollup of Additional Information Groupings
	AddlInfo_rollup := record
		string ID;
		dataset(Layout_AddlInfo) AdditionalInfo{xpath('AdditionalInfo')};
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
return AddlInfo_out;

end;