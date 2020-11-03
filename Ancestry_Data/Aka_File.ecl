Import Ancestry_Data, MDR, ut;

Export aka_file( string pVersion ) := Module 

Shared tucs := mdr.sourceTools.src_TUCS_Ptrack;
Shared tracker := mdr.sourceTools.src_InfutorTRK;

// infutor narc
Shared narc := Ancestry_Data.Files.input_ds_narc(fname<>'' or lname<>'');

// input knowx names
Shared knowx := Ancestry_Data.Files.infutor_best_knowx(fname<>'' or lname<>'');

// All layouts
Shared file_layout := Ancestry_Data.Layouts.aka_file_layout;

// input #1
Export narcdata := project(narc, transform(file_layout,
							self.LexID := left.did;
							self.first := left.fname;
							self.middle := left.mname;
							self.last := left.lname;
							self.suffix := left.name_suffix;
								)): independent;

// input #2 without tucs nor tracker
Shared knowxWoTucsTracker := project(knowx( src not in [tucs, tracker]), transform(file_layout,
										self.LexID := left.s_did;
										self.first := left.fname;
										self.middle := left.mname;
										self.last := left.lname;
										self.suffix := left.name_suffix;
											));
// tucs is 70% only in tucs
Export knowxOnlyTucs := project(knowx(src in [tucs]), transform(file_layout,
										self.LexID := left.s_did;
										self.first := left.fname;
										self.middle := left.mname;
										self.last := left.lname;
										self.suffix := left.name_suffix;
										));

// tracker is 30% only in tracker
Shared knowxOnlyTracker := project(knowx(src in [tracker]), transform(file_layout,
										self.LexID := left.s_did;
										self.first := left.fname;
										self.middle := left.mname;
										self.last := left.lname;
										self.suffix := left.name_suffix;
										));

// funtion for joins
Shared count_join(inputleft, inputright ) := Functionmacro

jointhem := join( 
	distribute(inputleft, LexID ), 
	distribute(inputright, LexID ), 
	left.LexID = right.LexID and 
	left.first = right.first and
	left.middle = right.middle and 
	left.last = right.last and 
	left.suffix = right.suffix,
	transform(
		file_layout,
        self := right;
	), right only, local 
);
Return jointhem;
Endmacro;

// // get records in knowx without tucs nor tracker only
Export adding_knowx := count_join(narcdata, knowxWoTucsTracker ): independent;

// adding narc and knowx without tucs nor tracker
Shared adding_narcknowx := (narcdata + adding_knowx );

// get records from tucs only
Export adding_tucsonly := count_join(adding_narcknowx, knowxOnlyTucs ): independent;

// adding records from tucs
Shared adding_tucs := ( adding_narcknowx + adding_tucsonly );

// get records from tracker only
Export adding_trackeronly := count_join(adding_tucs, knowxOnlytracker ): independent;

// adding records from tracker to the rest of the dataset
sumalldata := (adding_tucs + adding_trackeronly );


final_form := project(sumalldata(LexID<>0),transform(file_layout,
			    self.first := trim(left.first, right);
				self.middle := trim(left.middle, right);
				self.last := trim(left.last, right);
				self.suffix := trim(ut.fGetSuffix(left.suffix), right);
				self := left;
				));

dedup_dataset := dedup(sort(distribute(final_form, LexID ),
									LexID, first, middle, last, suffix, local ),
									LexID, first, middle, last, suffix, local );

Export outputDS := sort(dedup_dataset, LexID );
								
End;