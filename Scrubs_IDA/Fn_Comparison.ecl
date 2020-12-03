IMPORT Scrubs_IDA, STD, Phonesplus_v2;

EXPORT Fn_Comparison := FUNCTION 
    Outp := Scrubs_IDA.Base_In_IDA;
    r := {
        STRING orig;
        STRING clean;
    };

    //Addressline1
    PossibleFailure1 := Outp(STD.str.WordCount(Trim(orig_address1,left,right)) > 5);
    Addr1Comp := PROJECT(PossibleFailure1,transform(r,
                                                    self.orig:=TRIM(left.orig_address1,left,right),
                                                    self.clean:=TRIM(left.Prim_range,left,right) + ' ' + TRIM(Left.predir,left,right) + ' ' + TRIM(left.prim_name,left,right) + ' ' + TRIM(left.addr_suffix,left,right) + ' ' + TRIM(left.postdir,left,right)
                                                ));
    PossibleFailure2 := Outp(STD.str.filterout(TRIM(orig_address1,whitespace),'0123456789') = '' AND LENGTH(TRIM(orig_address1,whitespace)) > 0);
    Addr1Comp2 := PROJECT(PossibleFailure2,transform(r,
                                                    self.orig:=TRIM(left.orig_address1,left,right),
                                                    self.clean:=TRIM(left.Prim_range,left,right) + ' ' + TRIM(Left.predir,left,right) + ' ' + TRIM(left.prim_name,left,right) + ' ' + TRIM(left.addr_suffix,left,right) + ' ' + TRIM(left.postdir,left,right)
                                                ));
    //Addressline2
    PossibleFailure3 := Outp(STD.str.WordCount(Trim(orig_address2,left,right)) > 3);
    Addr2Comp := PROJECT(PossibleFailure3,transform(r,
                                                    self.orig:=TRIM(left.orig_address2,left,right),
                                                    self.clean:=TRIM(left.unit_desig,left,right) + ' ' + TRIM(Left.sec_range,left,right)
                                                ));
    //Phone
    PossibleFailure4 := Outp(STD.str.FindCount(TRIM(orig_phone,ALL), orig_phone[1]) = LENGTH(TRIM(orig_phone,ALL)) AND TRIM(orig_phone,all) <> '');
    Phone1Comp := PROJECT(PossibleFailure4,transform(r,
                                                    self.orig:=TRIM(left.orig_phone,left,right),
                                                    self.clean:=TRIM(left.clean_phone,left,right)
                                                ));
    PossibleFailure5 := Outp(LENGTH(TRIM(orig_phone,all)) < 10 AND TRIM(orig_phone,all) <> '' AND TRIM(orig_phone,all) <> 'INVALID');
    Phone2Comp := PROJECT(PossibleFailure5,transform(r,
                                                    self.orig:=TRIM(left.orig_phone,left,right),
                                                    self.clean:=TRIM(left.clean_phone,left,right)
                                                ));
    PossibleFailure6 := Outp(LENGTH(STD.str.filter(TRIM(orig_phone,all), 'X')) > 0);
    Phone3Comp := PROJECT(PossibleFailure6,transform(r,
                                                    self.orig:=TRIM(left.orig_phone,left,right),
                                                    self.clean:=TRIM(left.clean_phone,left,right)
                                                ));
    //DRIVERS LICENSE
    possibleFailure7 := Outp(Orig_DL = 'DL' OR Orig_DL[1..7] = 'DRIVERS');
    possiblefailure8 := Outp(STD.str.filter(trim(orig_dl,left,right),'0123456789') = '' AND trim(orig_dl,left,right) <> 'DL' AND trim(orig_dl,left,right) <> '' AND orig_dl[1..7] <> 'DRIVERS');
    //EMAIL
    possibleFailure9 := Outp(REGEXFIND('^[a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$', TRIM(Orig_Email,left,right)) = false AND TRIM(Orig_Email,left,right) <> '');
    //FIRST NAME
    possibleFailure10 := Outp(orig_first_name[2] = ' ' AND TRIM(orig_first_name,left,right) <> '');
    FirstnameComp       := PROJECT(PossibleFailure10,transform(r,
                                                    self.orig:=TRIM(left.orig_First_Name,left,right) + ' ' + TRIM(left.orig_Middle_Name,left,right) + ' ' + TRIM(left.orig_Last_name,left,right);
                                                    self.clean:=TRIM(left.fname,left,right) + ' ' + TRIM(left.mname,left,right) + ' ' + TRIM(left.lname,left,right);
                                                ));
    //LAST NAME
    possibleFailure11 := Outp(LENGTH(TRIM(orig_last_name,all)) = 1 AND TRIM(orig_last_name,left,right) <> '');
    lastnameComp       := PROJECT(PossibleFailure11,transform(r,
                                                    self.orig:=TRIM(left.orig_First_Name,left,right) + ' ' + TRIM(left.orig_Middle_Name,left,right) + ' ' + TRIM(left.orig_Last_name,left,right);
                                                    self.clean:=TRIM(left.fname,left,right) + ' ' + TRIM(left.mname,left,right) + ' ' + TRIM(left.lname,left,right);
                                                ));
    //Phone (again)

    possibleFailure12 := OutP(TRIM(orig_phone,ALL) != '' 
                AND LENGTH(STD.str.filter(orig_phone,'0123456789')) IN [10,7]
                AND (STD.str.findCount(orig_phone[LENGTH(orig_phone)-6..LENGTH(orig_phone)],orig_phone[LENGTH(orig_phone)-6]) > 6
                OR orig_phone[LENGTH(orig_phone)-3..LENGTH(orig_phone)] IN ['0000','9999']
                OR orig_phone[LENGTH(orig_phone)-6] IN ['0','1']
                OR (LENGTH(orig_phone) = 10 AND orig_phone[..3] IN ['800','811','822','833','844','855','866','877','888','899'])));

    //possibleFailure12 := Outp(Phonesplus_v2.Fn_Is_Phone_Valid(orig_phone,false) = false AND LENGTH(std.str.filter(orig_phone,'0123456789')) = 10 AND STD.str.FindCount(TRIM(orig_phone,ALL), orig_phone[1]) <> 10);
    Phone4Comp := PROJECT(PossibleFailure12,transform(r,
                                                    self.orig:=TRIM(left.orig_phone,left,right),
                                                    self.clean:=TRIM(left.clean_phone,left,right)
                                                ));
    //SSN
    possibleFailure13 := Outp(STD.str.FindCount(orig_ssn, orig_ssn[1]) = 9);
    //SUFFIX
    possibleFailure14 := Outp(orig_suffix = '0');
    suffixComp := PROJECT(PossibleFailure14,transform(r,
                                                    self.orig:=TRIM(left.orig_suffix,left,right),
                                                    self.clean:=TRIM(left.name_suffix,left,right)
                                                ));
    //LAST NAME (again)
    PossibleFailure15 := Outp(LENGTH(TRIM(orig_last_name,left,right)) > 20 AND STD.str.WordCount(Orig_last_name) > 2);
    lastname2Comp := PROJECT(PossibleFailure15,transform(r,
                                                    self.orig:=TRIM(left.orig_First_Name,left,right) + ' ' + TRIM(left.orig_Middle_Name,left,right) + ' ' + TRIM(left.orig_Last_name,left,right);
                                                    self.clean:=TRIM(left.fname,left,right) + ' ' + TRIM(left.mname,left,right) + ' ' + TRIM(left.lname,left,right);
                                                ));

    ex := {
        STRING Example;
    };
    r2 := {
        STRING      Field,
        UNSIGNED5   Rec_Total_Count,
        UNSIGNED5   Field_Pop_Count,
        STRING4     Field_Pop_Perc,
        STRING      Failure_Desc,
        UNSIGNED5   Failure_Count,
        STRING4     Failure_Perc_Of_Pop,
        DATASET(ex) Known_Problem{MAXCOUNT(5)},
        STRING4     Percent_Changed_In_Cleanup,
        STRING4     Percent_Remaining_Same,
    };
    recTotal    := COUNT(OUTP);
    totalAddr1  := COUNT(OUTP(TRIM(Orig_Address1,all) <> ''));
    totalAddr2  := COUNT(OUTP(TRIM(Orig_Address2,all) <> ''));
    totalPhone  := COUNT(OUTP(TRIM(Orig_phone,all) <> ''));
    totalDL     := COUNT(OUTP(TRIM(Orig_DL,all) <> ''));
    totalEmail  := COUNT(OUTP(TRIM(Orig_Email,all) <> ''));
    totalfname  := COUNT(OUTP(TRIM(Orig_First_Name,all) <> ''));
    totallname  := COUNT(OUTP(TRIM(Orig_last_Name,all) <> ''));
    totalssn  := COUNT(OUTP(TRIM(orig_ssn,all) <> ''));
    totalsuffix  := COUNT(OUTP(TRIM(orig_suffix,all) <> ''));

    TABLE1 := CHOOSEN(PROJECT(PossibleFailure1,TRANSFORM(ex,SELF.example:=LEFT.Orig_Address1)),5);
    TABLE2 := CHOOSEN(PROJECT(PossibleFailure2,TRANSFORM(ex,SELF.example:=LEFT.Orig_Address1)),5);
    TABLE3 := CHOOSEN(PROJECT(PossibleFailure3,TRANSFORM(ex,SELF.example:=LEFT.Orig_Address2)),5);
    TABLE4 := CHOOSEN(PROJECT(PossibleFailure4,TRANSFORM(ex,SELF.example:=LEFT.Orig_Phone)),5);
    TABLE5 := CHOOSEN(PROJECT(PossibleFailure5,TRANSFORM(ex,SELF.example:=LEFT.Orig_Phone)),5);
    TABLE6 := CHOOSEN(PROJECT(PossibleFailure6,TRANSFORM(ex,SELF.example:=LEFT.Orig_Phone)),5);
    TABLE7 := CHOOSEN(PROJECT(PossibleFailure7,TRANSFORM(ex,SELF.example:=LEFT.Orig_DL)),5);
    TABLE8 := CHOOSEN(PROJECT(PossibleFailure8,TRANSFORM(ex,SELF.example:=LEFT.Orig_DL)),5);
    TABLE9 := CHOOSEN(PROJECT(PossibleFailure9,TRANSFORM(ex,SELF.example:=LEFT.Orig_Email)),5);
    TABLE10 := CHOOSEN(PROJECT(PossibleFailure10,TRANSFORM(ex,SELF.example:=LEFT.Orig_First_Name)),5);
    TABLE11 := CHOOSEN(PROJECT(PossibleFailure11,TRANSFORM(ex,SELF.example:=LEFT.Orig_Last_Name)),5);
    TABLE12 := CHOOSEN(PROJECT(PossibleFailure12,TRANSFORM(ex,SELF.example:=LEFT.Orig_Phone)),5);
    TABLE13 := CHOOSEN(PROJECT(PossibleFailure13,TRANSFORM(ex,SELF.example:=LEFT.Orig_ssn)),5);
    TABLE14 := CHOOSEN(PROJECT(PossibleFailure14,TRANSFORM(ex,SELF.example:=LEFT.Orig_suffix)),5);
    TABLE15 := CHOOSEN(PROJECT(PossibleFailure15,TRANSFORM(ex,SELF.example:=LEFT.Orig_last_name)),5);

    masterTable := DATASET([
        {'orig_address1',   recTotal,   totalAddr1, (totalAddr1/recTotal*100),  'Unusually high number of words',         COUNT(PossibleFailure1), (COUNT(PossibleFailure1)/totaladdr1 * 100),  TABLE1, COUNT(addr1Comp(orig <> clean))/COUNT(addr1Comp)*100,   COUNT(addr1Comp(orig = clean))/COUNT(addr1Comp)*100},
        {'orig_address1',   recTotal,   totalAddr1, (totalAddr1/recTotal*100),  'The field is only numbers',              COUNT(PossibleFailure2), (COUNT(PossibleFailure2)/totaladdr1 * 100),  TABLE2, COUNT(addr1Comp2(orig <> clean))/COUNT(addr1Comp2)*100, COUNT(addr1Comp2(orig = clean))/COUNT(addr1Comp2)*100},
        {'orig_address2',   recTotal,   totalAddr2, (totalAddr2/recTotal*100),  'Unusually high number of words',         COUNT(PossibleFailure3), (COUNT(PossibleFailure3)/totaladdr2 * 100),  TABLE3, COUNT(addr2Comp(orig <> clean))/COUNT(addr2Comp)*100,   COUNT(addr2Comp(orig = clean))/COUNT(addr2Comp)*100},
        {'orig_phone',      recTotal,   totalPhone, (totalPhone/recTotal*100),  'Value is string of repeating numbers',   COUNT(PossibleFailure4), (COUNT(PossibleFailure4)/totalPhone * 100),  TABLE4, COUNT(phone1Comp(orig <> clean))/COUNT(phone1Comp)*100, COUNT(phone1Comp(orig = clean))/COUNT(phone1Comp)*100},
        {'orig_phone',      recTotal,   totalPhone, (totalPhone/recTotal*100),  'Too few digits',                         COUNT(PossibleFailure5), (COUNT(PossibleFailure5)/totalPhone * 100),  TABLE5, COUNT(Phone2Comp(orig <> clean))/COUNT(Phone2Comp)*100, COUNT(phone2Comp(orig = clean))/COUNT(phone2Comp)*100},
        {'orig_phone',      recTotal,   totalPhone, (totalPhone/recTotal*100),  'Numbers are Xs',                         COUNT(PossibleFailure6), (COUNT(PossibleFailure6)/totalPhone * 100),  TABLE6, COUNT(Phone3Comp(orig <> clean))/COUNT(Phone3Comp)*100, COUNT(phone3Comp(orig = clean))/COUNT(phone3Comp)*100},
        {'orig_phone',      recTotal,   totalPhone, (totalPhone/recTotal*100),  'Invalid Phone Number',                   COUNT(PossibleFailure12), (COUNT(PossibleFailure12)/totalPhone * 100),  TABLE12, COUNT(Phone4Comp(orig <> clean))/COUNT(Phone4Comp)*100, COUNT(phone4Comp(orig = clean))/COUNT(phone4Comp)*100},
        {'orig_DL',         recTotal,   totalDL,    (totalDL/recTotal*100),     'Value is default "DL"',                  COUNT(PossibleFailure7), (COUNT(PossibleFailure7)/totaldl * 100),     TABLE7, 0,0},
        {'orig_DL',         recTotal,   totalDL,    (totalDL/recTotal*100),     'Value is geographic area',               COUNT(PossibleFailure8), (COUNT(PossibleFailure8)/totaldl * 100),     TABLE8, 0,0},
        {'orig_email',      recTotal,   totalEmail, (totalEmail/recTotal*100),  'Value has trailing # + number',          COUNT(PossibleFailure9), (COUNT(PossibleFailure9)/totalemail * 100),  TABLE9, 0,0},
        {'orig_first_name', recTotal,   totalfname, (totalfname/recTotal*100),  'Value is two words w/ first initial',  COUNT(PossibleFailure10), (COUNT(PossibleFailure10)/totalfname * 100),TABLE10, COUNT(firstnameComp(orig <> clean))/COUNT(firstnameComp)*100, COUNT(firstnameComp(orig = clean))/COUNT(firstnameComp)*100},
        {'orig_last_name',  recTotal,   totallname, (totallname/recTotal*100),  'Value is just an initial',             COUNT(PossibleFailure11), (COUNT(PossibleFailure11)/totallname * 100),TABLE11, COUNT(lastnameComp(orig <> clean))/COUNT(lastnameComp)*100, COUNT(lastnameComp(orig = clean))/COUNT(lastnameComp)*100},
        {'orig_last_name',  recTotal,   totallname, (totallname/recTotal*100),  'Value may not be a name',             COUNT(PossibleFailure15), (COUNT(PossibleFailure15)/totallname * 100),TABLE15, COUNT(lastname2Comp(orig <> clean))/COUNT(lastname2Comp)*100, COUNT(lastname2Comp(orig = clean))/COUNT(lastname2Comp)*100},
        {'orig_ssn',        recTotal,   totalssn, (totalssn/recTotal*100),      'Repeating string of numbers',            COUNT(PossibleFailure13), (COUNT(PossibleFailure13)/totalssn * 100),TABLE13, 0,0},
        {'orig_suffix',     recTotal,   totalsuffix, (totalsuffix/recTotal*100),'Value is "0"',                           COUNT(PossibleFailure14), (COUNT(PossibleFailure14)/totalsuffix * 100),TABLE14, COUNT(suffixComp(orig <> clean))/COUNT(suffixComp)*100, COUNT(suffixComp(orig = clean))/COUNT(suffixComp)*100}
    ],r2);
    
    masterOutput := OUTPUT(masterTable, NAMED('_MASTER_TABLE'));
    allOutputs := SEQUENTIAL(
        OUTPUT(addr1Comp(TRIM(orig,all) <> TRIM(clean,all)), NAMED('Address1TooLong_Changes')),
        OUTPUT(addr1Comp(TRIM(orig,all) = TRIM(clean,all)), NAMED('Address1TooLong_Remaining')),
        OUTPUT(addr1Comp2(TRIM(orig,all) <> TRIM(clean,all)), NAMED('Address1JustNumbers_Changes')),
        OUTPUT(addr1Comp2(TRIM(orig,all) = TRIM(clean,all)), NAMED('Address1JustNumbers_Remaining')),
        OUTPUT(addr2Comp(TRIM(orig,all) <> TRIM(clean,all)), NAMED('Address2TooLong_Changes')),
        OUTPUT(addr2Comp(TRIM(orig,all) = TRIM(clean,all)), NAMED('Address2TooLong_Remaining')),
        OUTPUT(Phone1Comp(orig <> clean), NAMED('PhoneRepeatingNum_Changes')),
        OUTPUT(Phone1Comp(orig = clean), NAMED('PhoneRepeatingNum_Remaining')),
        OUTPUT(Phone2Comp(orig <> clean), NAMED('PhoneTooShort_Changes')),
        OUTPUT(Phone2Comp(orig = clean), NAMED('PhoneTooShort_Remaining')),
        OUTPUT(Phone3Comp(orig <> clean), NAMED('PhoneWXs_Changes')),
        OUTPUT(Phone3Comp(orig = clean), NAMED('PhoneWXs_Remaining')),
        OUTPUT(Phone4Comp(orig <> clean), NAMED('Phone_Invalid_Num_Changes')),
        OUTPUT(Phone4Comp(orig = clean), NAMED('Phone_Invalid_Num_Remaining')),
        OUTPUT(FirstnameComp(TRIM(orig,all) <> TRIM(clean,all)), NAMED('FirstNameInitial_Changes')),
        OUTPUT(FirstnameComp(TRIM(orig,all) = TRIM(clean,all)), NAMED('FirstNameInitial_Remaining')),
        OUTPUT(LastnameComp(TRIM(orig,all) <> TRIM(clean,all)), NAMED('LastNameInitial_Changes')),
        OUTPUT(LastnameComp(TRIM(orig,all) = TRIM(clean,all)), NAMED('LastNameInitial_Remaining')),
        OUTPUT(Lastname2Comp(TRIM(orig,all) <> TRIM(clean,all)), NAMED('LastNameNonName_Changes')),
        OUTPUT(Lastname2Comp(TRIM(orig,all) = TRIM(clean,all)), NAMED('LastNameNonName_Remaining')),
    );

    return SEQUENTIAL(
        masterOutput,
        allOutputs
    );

END;