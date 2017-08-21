import ut,doxie;
export functions := 
MODULE

shared fi := ManualLink_Services.files;
shared ly := ManualLink_Services.layouts;
shared gl := ManualLink_Services.globals;

//****** A BUNCH OF LITTLE FUNCTIONS FOR WRITING FILES AND MANAGING SUPERFILES

WriteNewFileToDisk(dataset(ly.overlink) newfile) :=
FUNCTION
	return output(newfile,,fi.newfile_name);
END;

MoveGrandFatherFileToDelete() :=
FUNCTION
	return 
	sequential(
		FileServices.AddSuperFile(fi.overlink_delete_name, fi.overlink_grandfather_name,,TRUE),
		FileServices.ClearSuperFile(fi.overlink_grandfather_name)
	);
END;

MoveFatherFileToGrandFather() :=
FUNCTION
	return 
	sequential(
		FileServices.AddSuperFile(fi.overlink_grandfather_name, fi.overlink_father_name,,TRUE),
		FileServices.ClearSuperFile(fi.overlink_father_name)
	);
END;

MoveOldFileToFather() :=
FUNCTION
	return 
	sequential(
		FileServices.AddSuperFile(fi.overlink_father_name, fi.overlink_qa_name,,TRUE),
		FileServices.ClearSuperFile(fi.overlink_qa_name)
	);
END;

MoveNewFileToQA() :=
FUNCTION
	return 
	sequential(
		FileServices.AddSuperFile(fi.overlink_qa_name, fi.newfile_name)
	);
END;


Delete() :=
FUNCTION
	return 
	sequential(
		FileServices.ClearSuperFile( fi.overlink_delete_name, TRUE )
	);
END;


//****** A BIG FUNCTION TO USE THE LITTLE FUNCTIONS ABOVE

export WriteMoveDelete(dataset(ly.overlink) newfile) :=
sequential(	
	WriteNewFileToDisk(newfile),
	MoveGrandFatherFileToDelete(),
	MoveFatherFileToGrandFather(),
	MoveOldFileToFather(),
	MoveNewFileToQA(),
	Delete()
);


//****** TO MARK THE RECORDS AS APPLIED TO THE HEADER

export MarkAsApplied(
	string8 RecordsReportedBeforeOrOnThisDate, //YYYYMMDD
	string6 RecordsReportedBeforeOrAtThisTime  //HHMMSS - Time entered is irrelevant unless a record matches by date
) := 
FUNCTION
	isCorrectRecord() := 
	MACRO
		left.date_applied_to_header = '' and
		(
			left.date_reported < RecordsReportedBeforeOrOnThisDate or
			(left.date_reported = RecordsReportedBeforeOrOnThisDate and left.time_reported <= RecordsReportedBeforeOrAtThisTime)
		)
	ENDMACRO;
	newfile := 
	project(
		ManualLink_Services.files.Overlink_QA,
		transform(
			ManualLink_Services.layouts.overlink,
			self.date_applied_to_header := 
				if(
					isCorrectRecord(), 
					gl.date, 										
					left.date_applied_to_header
				),
			self.time_applied_to_header := 
				if(
					isCorrectRecord(), 
					gl.time, 										
					left.time_applied_to_header
				),
			self.user_applied_to_header := 
				if(
					isCorrectRecord(), 
					(string)thorlib.jobowner(),	
					left.user_applied_to_header
				),
			self := left
		)
	);	

	return WriteMoveDelete(newfile);
END;


//****** TO UNMARK THE RECORDS AS APPLIED TO THE HEADER THAT WERE MARKED ON A CERTAIN DATE AND TIME

export UnMarkAsApplied(
	string8 RecordsAppliedOnThisDate, //YYYYMMDD
	string6 RecordsAppliedAtThisTime  //HHMMSS
) := 
FUNCTION
	isCorrectRecord() := 
	MACRO
		left.date_applied_to_header = RecordsAppliedOnThisDate and 
		left.time_applied_to_header = RecordsAppliedAtThisTime
	ENDMACRO;
	newfile := 
	project(
		ManualLink_Services.files.Overlink_QA,
		transform(
			ManualLink_Services.layouts.overlink,
			self.date_applied_to_header := 
				if(
					isCorrectRecord(), 
					'', 										
					left.date_applied_to_header
				),
			self.time_applied_to_header :=
				if(
					isCorrectRecord(), 
					'', 										
					left.time_applied_to_header
				),
			self.user_applied_to_header := 
				if(
					isCorrectRecord(), 
					'', 										
					left.user_applied_to_header
				),
			self := left
		)
	);	

	return WriteMoveDelete(newfile);
END;


//****** TO ADD A NEW RECORD TO THE FILE

export AddRecord(
	unsigned6 myADL,
	unsigned6 myBug,
	string 		myComment
) := 
FUNCTION

	oldfile := fi.Overlink_QA;
	newfile_name := fi.base_name + thorlib.wuid();

	ly.Overlink BuildNewRecord() := 
	TRANSFORM
			self.ADL := myADL;
			self.RIDs := 				
			project(
				doxie.Key_Header(keyed(s_did = myADL)),
				ly.rec_RID
			);
			self.user_reported := thorlib.jobowner();
			self.date_reported := gl.date;
			self.time_reported := gl.time;
			self.bug_number := myBug;
			self.date_applied_to_header := '';
			self.time_applied_to_header := '';
			self.user_applied_to_header := '';
			self.comments_by_user_reported := myComment;
	END;

	newrecord := dataset ([BuildNewRecord ()]);
	newfile := oldfile + newrecord;

	return WriteMoveDelete(newfile);
END;


END;//functions module