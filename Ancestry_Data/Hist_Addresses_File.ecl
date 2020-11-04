Import STD, MDR, Ancestry_Data, ut;


Export hist_addresses_file( string pVersion ) := Module

Shared tucs := mdr.sourceTools.src_TUCS_Ptrack;
Shared tracker := mdr.sourceTools.src_InfutorTRK;

// infutor narc
Shared narc := Ancestry_Data.Files.input_ds_narc(prim_range+''+prim_name<>'',zip<>''or st<>'',(integer)date_last_seen >= 199001 or (integer)date_last_seen = 0);

// input knowx names
Shared knowx := Ancestry_Data.Files.infutor_best_knowx(prim_range+''+prim_name<>'',zip<>'' or st<>'', dt_last_seen >= 199001 or dt_last_seen = 0): independent;

// All layouts
Shared address_main_layout := Ancestry_Data.Layouts.hist_address_layout;
Shared output_layout := Ancestry_Data.Layouts.address_output_layout;

// starting point infutor narc input 1
Export narcdata := project(narc, transform(address_main_layout,
                                    self.LexID := left.did;
                                    self.address_suffix := left.addr_suffix;
                                    self.city := left.p_city_name;
                                    self.state := left.st;
                                    self.date_first_seen := (unsigned3)(((string8)left.date_first_seen)[1..6]);
                                    self.date_last_seen := (unsigned3)(((string8)left.date_last_seen)[1..6]);
                                    self.dt_vendor_first_reported := (unsigned3)(((string8)left.date_vendor_first_reported)[1..6]);
                                    self.dt_vendor_last_reported := (unsigned3)(((string8)left.date_vendor_last_reported)[1..6]);
                                    self := left;
                                    )): independent;
// knowx without tucs nor tracker input 2
Shared knowxWoTucsTracker := project(knowx(src not in [tucs, tracker]),transform(address_main_layout,
                                    self.LexID := left.s_did;
                                    self.address_suffix := left.suffix;
                                    self.city := left.city_name;
                                    self.state := left.st;
                                    self.date_first_seen := left.dt_first_seen;
                                    self.date_last_seen := left.dt_last_seen;
                                    self := left;
                                    ));
// tucs 70%
Shared knowxOnlyTucs := project(knowx(src in [tucs]), transform(address_main_layout,
                                self.LexID := left.s_did;
                                self.address_suffix := left.suffix;
                                self.city := left.city_name;
                                self.state := left.st;
                                self.date_first_seen := left.dt_first_seen;
                                self.date_last_seen := left.dt_last_seen;
                                self := left;
                                    ));
// tracker 30%                                                                
Shared knowxOnlyTracker := project(knowx(src in [tracker]),transform(address_main_layout,
                            self.LexID := left.s_did;
                            self.address_suffix := left.suffix;
                            self.city := left.city_name;
                            self.state := left.st;
                            self.date_first_seen := left.dt_first_seen;
                            self.date_last_seen := left.dt_last_seen;
                            self := left;
                                ));

Shared count_join(inputleft, inputright ) := Functionmacro

jointhem := join( 
	distribute(inputleft, LexID ), 
	distribute(inputright, LexID ), 
	left.LexID = right.LexID and 
	left.predir = right.predir and
	left.prim_name = right.prim_name and
    left.address_suffix = right.address_suffix and 
    left.postdir = right.postdir and 
    left.unit_desig = right.unit_desig and 
    left.sec_range = right.sec_range and 
    left.city = right.city and 
    left.state = right.state and 
    left.zip = right.zip, 
	transform(
		address_main_layout,
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


// adding records from tracker to the rest of the data
sumalldata := (adding_tucs + adding_trackeronly );


final_form := project(sumalldata(Lexid<>0), transform(output_layout,
                city_name := trim(left.city, right);
				self.LexID := left.LexID;
				self.line1 := stringlib.stringcleanspaces(left.prim_range + ' ' + left.predir + ' ' + left.prim_name + ' ' + left.address_suffix + ' ' + left.postdir + ' ' + IF(left.sec_range='','',left.unit_desig+' '+left.sec_range));
				self.line2 := stringlib.stringcleanspaces(city_name + ', ' + left.state + ' ' + left.zip);
                self.date_first_seen := (unsigned3)(((string8)left.date_first_seen)[1..6]);
                self.date_last_seen := (unsigned3)(((string8)left.date_last_seen)[1..6]);
                self.dt_vendor_first_reported := (unsigned3)(((string8)left.dt_vendor_first_reported)[1..6]);
                self.dt_vendor_last_reported := (unsigned3)(((string8)left.dt_vendor_last_reported)[1..6]);
                self := left;
				));

rolled_dataset := rollup(sort(final_form, LexID, line1, line2 ),
                left.LexID = right.LexID and 
                left.line1 = right.line1 and 
                left.line2 = right.line2,
                transform(output_layout,
                self.date_first_seen := ut.Min2(left.date_first_seen, right.date_first_seen),
                self.date_last_seen := max(left.date_last_seen, right.date_last_seen),
                self.dt_vendor_first_reported := ut.min2(left.dt_vendor_first_reported, right.dt_vendor_first_reported),
                self.dt_vendor_last_reported := max(left.dt_vendor_last_reported, right.dt_vendor_last_reported),
                self := left;), local );


Export outputDS := sort(rolled_dataset, Lexid, -date_last_seen );

End;