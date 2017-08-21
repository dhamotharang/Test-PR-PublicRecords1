export VARSTRING CDL_License_Type(string field2, string code) := 
            CASE(field2,
                 'FL' => CASE(code,
                              'A' => 'Y' ,//'Commercial - Any Trailer With GVWR Of 26000 pounds',  
			               'B' => 'Y' ,//'Commercial - Any Single Vehicle With A GVWR Of 26000 pounds',  
			               'C' => 'Y', //'Commercial - Any Endorsed Vehicle With A GVWR of less than 26000 pounds',  
			               'D' => '' , //'Non-Commercial - Any Single Vehicle less than 8000 pounds',  
			               'E' => '' , //'Non-Commercial - Regular Operator License',  
			               'I' => '' , //'Identification Card',  
			               'L' => '' , //'Learner Permit',  
			               'N' => '',  
                              ''),
			  'IA' => CASE(code,
                              '' => '' , //'ID - Non-license',  
			               'A' => 'Y' ,//'Commercial Driver\'s License Class A',  
			               'B' => 'Y' ,//'Commercial Driver\'s License Class B',  
			               'C' => '' , //'Operator',  
			               'D' => '' , //'Chauffer',  
                              ''),
			  'ID' => CASE(code,
                              '' => '' , //'Non-operator - ID only',  
			               'A' => 'Y' ,//'Commercial - Class A',  
			               'B' => 'Y' ,//'Commercial - Class B',  
			               'C' => 'Y' ,//'Commercial - Class C',  
			               'D' => '' , //'Operator - Non-commercial',  
                              ''),
			  'KY' => CASE(code,
                              '' => '',  
			               'A' => 'Y' ,//'CDL, Class A',  
			               'B' => 'Y' ,//'CDL, Class B',  
			               'C' => 'Y' ,//'CDL, Class C',  
			               'D' => '' , //'Operators',  
			               'E' => '' , //'Moped Only',  
			               'M' => '' , //'Motorcycle',  
			               'N' => '' , //'Non-Resident',  
			               'X' => '' , //'Operator and Motorcycle',  
			               'Y' => 'Y' ,//'Operator, Motorcycle and CDL',  ***************************
			               'Z' => '' , //'Operator and CDL',  ***************************
                              ''),
			  'MA' => CASE(code,
                              '' => '' , //'Operator',  
			               'A' => 'Y' ,//'Commercial over 26000 lbs with trailer over 10000 lbs',  
			               'B' => 'Y' ,//'Commercial over 26000 lbs with trailer under 10001 lbs',  
			               'C' => 'Y' ,//'Commercial under 26001 lbs with trailer under 10001 lbs',  
			               'D' => '' , //'Operator',  
                              ''),
			  'ME' => CASE(code,
                              '' => '',  
			               '*' => '',  
			               '1' => '',  
			               '2' => '',  
			               '3' => '',  
			               '?' => '',  
			               'A' => 'Y' ,//'Commercial Drivers License Class A',  
			               'B' => 'Y' ,//'Commercial Drivers License Class B',  
			               'C' => '' , //'Operator',  
			               'R' => '',  
                              ''),
			  'MI' => CASE(code,
                              'D' => 'Operators',  
			               'I' => 'Identification Card',  
                              ''),
			  'MN' => CASE(code,
                              '' => '',//'No class - used for permits',  
			               'A' => '',//'Valid for any vehicle.',  
			               'B' => '',//'Valid for all vehicles in Class C; Class CC; and all other single unit vehicles; including buses with a passenger endorsement. May tow only vehicles with a GVW of 1000 lbs or less.',  
			               'C' => '',//'Valid for operating class C vehicles with either a hazardous materials endorsement or a school bus endorsement.',  
			               'D' => '',//'Valid for single unit vehicles designed to carry less than 15 passengers with a GVW less than 26000 lbs; vehicle combinations with a GVW less than 26000 lbs; farm trucks; fire trucks and emergency equipment or personal recreational equipment.',  
			               'E' => '',//'Valid for single unit vehicles designed to carry less than 15 passengers with a GVW less than 26000 lbs; vehicle combinations with a GVW less than 26000 lbs; farm trucks; fire trucks and emergency equipment or personal recreational equipment.',  
			               'G' => '',  
			               'H' => '',  
			               'I' => '',//'ID card only',  
			               'K' => '',  
			               'M' => '',//'Moped license only (motorized bicycle)',  
			               'P' => '',  
			               'R' => '',//'Tracer (former name)',  
			               'T' => '',//'Lifetime ID card only (65 years and older)',  
			               'X' => '',  
                              ''),
			  'MO' => CASE(code,
                              'A' => 'Y' ,//'Commercial Class A',  
			               'B' => 'Y' ,//'Commercial Class B',  
			               'C' => 'Y' ,//'Commercial Class C',  
			               'E' => '' , //'Non-Commercial For Hire',  
			               'F' => '' , //'Non-Commercial',  
			               'M' => '' , //'Motorcycle Only',  
			               'N' => '' , //'Identification Card',  
			               'P' => '' , //'Learner\'s Permit',  
                              ''),
			  'NM' => CASE(code,
                              'I' => '' , //'ID Card',  
			               'L' => '' , //'License',  
			               'P' => '' , //'Learner\'s Permit',  
			               'T' => '' , //'Temporary',  
			               'V' => '' , //'Provisional',  
                              ''),
			  'OH' => CASE(code,
                              '\'' => '',  
			               'A' => 'Y' ,//'Class A - Commercial',  
			               'B' => 'Y' ,//'Class B - Commercial',  
			               'C' => 'Y' ,//'Class C - Commercial',  
			               'D' => '' , //'Operator - Non Commercial',  
			               'I' => '' , //'Identification Card',  
			               'M1' => '' , //'Motorcycle Only - Non Commercial',  
			               'M2' => '' , //'Motorized Bicycle Only - Non Commercial',  
			               'M3' => '' , //'3 Wheel Motorcycle Only - Non Commercial',  
			               'T' => '' , //'Temporary Id Card',  
                              ''),
			  'OR' => CASE(code,
                              '' => 'Unknown',  
			               '1' => '',  
			               '2' => '',  
			               '3' => '',  
			               '4' => '',  
			               '5' => '',  
			               'A' => 'Y' ,//'CDL Class A',  
			               'B' => 'Y' ,//'CDL Class B',  
			               'C' => 'Y' ,//'CDL Class C',  
			               'D' => '' , //'Operators - Non-Commercial',  
			               'L' => '' , //'Golf Cart Only',  
			               'N' => '' , //'Not Licensed',  
			               'O' => '' , //'Not Licensed',  
			               'P' => '' , //'Permit Only',  
			               'R' => '' , //'Emergency Permit',  
			               'RP' => '' , //'Emergency Permit',  
			               'T' => '' , //'Moped Only',  
			               'U' => '',  
			               'V' => '',  
			               'W' => '',  
			               'X' => '',  
			               'Y' => '',  
			               'Z' => '',  
                              ''),
			  'TN' => CASE(code,
                              '**' => '',  
			               '0' => '',  
			               '00' => '',  
			               '04' => '',  
			               '05' => '',  
			               '0A' => '',  
			               '1' => '',  
			               '10' => '',  
			               '15' => '',  
			               '2' => '',  
			               '20' => '',  
			               '24' => '',  
			               '25' => '',  
			               '3' => '',  
			               '30' => '',  
			               '34' => '',  
			               '4' => '',  
			               '5' => '',  
			               '60' => '' , //'Hardship License Only',  
			               '6M' => '' , //'Hardship License With Motorcycle',  
			               '7' => '',  
			               '70' => '' , //'Temporary Identification (Expiring)',  
			               '80' => '' , //'History Only (Not Printed)',  
			               '90' => '',//'Identification (Non-Expiring)',  
			               'A0' => 'Y' ,//'Class A Only',  
			               'A1' => 'Y' ,//'Class A With Motorcycle',  
			               'A3' => '' , //'Class A With Class A Learner Permit',  
			               'A4' => '' , //'Class A With Class B Learner Permit',  
			               'A5' => '' , //'Class A With Class C Learner Permit',  
			               'A6' => '' , //'Class A With Motorcycle & Class A Permit',  
			               'A7' => '' , //'Class A With Motorcycle & Class B Permit',  
			               'AP' => '' , //'Class A Learner Permit',  
			               'B0' => 'Y' ,//'Class B Only',  
			               'B1' => '' , //'Class B With Motorcycle',  
			               'B2' => '' , //'Class B With Class A Permit',  
			               'B4' => '' , //'Class B With Motorcycle & Class A Permit',  
			               'B5' =>'' , // 'Class B With Class B Permit',  
			               'B6' => '' , //'Class B With Class C Learner Permit',  
			               'B7' => '' , //'Class B With Motorcycle & Class B Permit',  
			               'C0' => '' , //'Class C Only',  
			               'C1' => '' , //'Class C With Motorcycle',  
			               'C2' => '' , //'Class C With Class A Learner Permit',  
			               'C3' => '' , //'Class C With Class B Learner Permit',  
			               'C5' => '' , //'Class C With Motorcycle &. Class A Permit',  
			               'C6' => '' , //'Class C With Motorcycle &. Class B Permit',  
			               'D0' => '' , //'Class D Only',  
			               'D1' =>'' , // 'Class D With Motorcycle',  
			               'D2' => '' , //'Class D With Class A Permit',  
			               'D3' => '' , //'Class D With Class B Permit',  
			               'D4' => '' , //'Class D With Class C Permit',  
			               'D5' => '' , //'Class D With Motorcycle Permit',  
			               'D6' => '' , //'Class D With Motorcycle & Class A Permit',  
			               'D7' => '' , //'Class D With Motorcycle & Class B Permit',  
			               'D8' => '' , //'Class D With Motorcycle & Class C Permit',  
			               'D9' => '' , //'Class D Learner Permit & Motorcycle Permit',  
			               'DP' => '' , //'Class D Learner Permit',  
			               'M0' => '' , //'Motorcycle Only',  
			               'M1' => '' , //'Motorcycle With Class D Permit',  
			               'M2' => '' , //'Motorcycle With Class A Permit',  
			               'MP' => '' , //'Motorcycle Learner Permit',  
                              ''),
			  'TX' => CASE(code,
                              'A' => '',  
			               'B' => '',  
			               'C' => '',  
			               'I' => '' , //'Identification Card',  
			               'M' => '',  
			               'O' => '' , //'Application',  
                              ''),
			  'WI' => CASE(code,
                              'CDLI' => 'Y' ,//'CDL Instruction Permit',  
			               'CYCI' => '' , //'Cycle Instruction Permit',  
			               'JUVI' => '' , //'Juvenile Instruction Permit',  
			               'JUVP' => '' , //'Juvenile',  
			               'MPDI' => '' , //'Moped Instruction Permit',  
			               'OCCL' => '' , //'Occupational License',  
			               'PROB' => '' , //'Probationary',  
			               'REGI' => '' , //'Regular Instruction Permit',  
			               'RGLR' => '' , //'Regular',  
			               'SPRI' => '' , //'Special Restricted Instruction Permit',  
			               'SPRR' => '' , //'Special Restricted',  
                              ''),
			  'WV' => CASE(code,
                              '01' => '' , //'Level 1 Instruction Permit',  
			               '02' => '' , //'Level 2 License',  
			               '03' => '' , //'Level 3 License',  
			               '04' => '' , //'Operator - Non commercial vehicles',  
			               '05' => '' , //'Chauffer',  
			               '07' => '' , //'Not Licensed',  
			               '08' => 'Y' ,//'Commercial Driver\'s License',  
			               '09' => '' , //'Motorcycle Only',  
			               '0A' => '' , //'Graduated License Level I',  
			               '0B' => '' , //'Graduated License Level II',  
			               '0C' => 'Y' ,//'CDL Instruction Permit',  
			               '10' => '' , //'Employee',  
                              ''),
			'');
