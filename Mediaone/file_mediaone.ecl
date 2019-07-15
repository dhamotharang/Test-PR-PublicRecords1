EXPORT file_mediaone:=MODULE
  EXPORT layout:=RECORD
    STRING email;
    STRING fname;
    STRING lname;
    STRING address;
    STRING city;
    STRING zip;
    STRING state;
    STRING phone;
    STRING source;
    STRING ip;
    STRING date_time;
    STRING gender;
    STRING dob;
    STRING nonincentivized_opt_in;
    STRING incentivized_opt_in;
  END;
	
	EXPORT file:=DATASET('~thor::in::mediaone',layout,CSV(terminator('\n'),separator(','),quote('"')))(email!='EMail');
	
	EXPORT file_test:=DATASET('~thor::tmp::mediaone::infile_test',layout,THOR);
END;

/*
Size stats at the file level:

FIELD                 LONGEST LINE    LINE NUMBER
-------------------------------------------------
EMail               : 159             170236650
F Name              : 167             112176612
L Name              : 178             119313339
Address             : 120             963864
City                : 100             91281452
Zip                 : 60              168009991
State               : 38              35873519
Phone Number        : 32              12647168
Source              : 250             39114755
IP                  : 39              61958806
Date and Time       : 45              46298703
Gender              : 33              1097425
DOB                 : 33              29147
Counter             : 33              154066
Counter2            : 0               0
*/