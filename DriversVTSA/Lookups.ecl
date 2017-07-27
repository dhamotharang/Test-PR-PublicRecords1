export Lookups := MODULE

cd2desc (string1 Pin) :=
case(pIn,
'A' => 'OPERATORS LICENSE',
'B' => 'OPERATORS W/ LICENSE',
'C' => 'COMMERCIAL LIGHT',
'D' => 'COMMERCIAL HEAVY',
'E' => 'COMMERCIAL LIGHT W/ MOTORCYCLE',
'F' => 'COMMERCIAL HEAVY W/ MOTORCYCLE',
'G' => 'COMMERCIAL TRACTOR/TRAILER',
'H' => 'CHAUFFERS LICENSE',
'I' => 'DRIVING INSTRUCTOR PERMIT',
'J' => 'BUS LICENSE',
'K' => 'MOTORCYCLE (+100cc)',
'L' => 'MOTOR DRIVEN CYCLE (-100cc)',
'M' => 'MOPED',
'N' => '2 AXLE/TRUCK NO CARGO',
'O' => '2 AXLE/TRUCK WITH CARGO',
'P' => '3 AXLE/TRUCK AND BUS',
'Q' => '',
'R' => '',
'S' => '', 
'T' => '',
'U' => '',
'V' => '',
'W' => 'NON DRIVER ID CARD',
'X' => 'DRIVE ALL VEHICLES', 
'Y' => 'OTHER CLASS', 
'Z' => 'DRIVERS PERMIT',
''); 

export lookup_License_Class (string6 pIn) := function
		ds := dataset([{pIn[1]},{pIn[2]},{pIn[3]},{pIn[4]},{pIn[5]},{pIn[6]}],{string1 class_code});
		class_rec	:= record
				string1 cd := '';
				string250	desc := '';
		end;
		class_rec class_desc (ds l) := transform
			self.cd := l.class_code;
			self.desc := cd2desc(l.class_code);
		end;
		ds_desc := project(ds, class_desc(left));
		class_rec roll_trans(ds_desc le, ds_desc ri) := transform
				self.desc := trim(le.desc) + ', ' + ri.desc; 
				self.cd := ri.cd;
		end;
		r_desc := rollup(ds_desc(cd <> ''),true, roll_trans(left,right));
		return(r_desc[1].desc);
		
end;


export lookup_License_Restrictions(integer pIn) :=
case(pIn,
1 =>	'NO RESTRICTIONS',
2 =>	'Organ Donor', 
3 =>	'Corrective Lenses',
4 =>	'With Licensed Driver',
5 =>	'Mirror Restrictions',
6 =>	'Vision Restrictions',
7 =>	'Automatic Transmission',
8 =>	'Power Steering/Steering Knob',
9 =>	'Motorcycle Endorsement',
10 =>	'Daylight Only',
11 =>	'Not Covered by Specific Rest.',
12 =>	'Non Correctable Hearing', 
13 =>	'Must Wear Hearing Aid', 
14 =>	'Limited to Rural Areas', 
15 =>	'No Interstate Driving',
16 =>	'Driving Range Restriction', 
17 =>	'Seat Cushion Required', 
18 =>	'Accelerator on Left Side', 
19 =>	'Ext for Accelerator/Brake', 
20 =>	'Dimmer Switch on Steering Wheel',
21 =>	'Mechanical Turn Signal',
22 =>	'Full Hand Controls Required',
23 =>	'Artificial Limb',
24 =>	'Hardship Restriction',
25 =>	'Emergency Endorsement', 
26 =>	'Minor Restriction (Permit)',
27 =>	'Special Equipment Required',
28 =>	'Temporary License',
29 =>	'Contact State DMV',
30 =>	'First License',
31 =>	'Valid Only In-State',
32 =>	'Drivers Education',
33 =>	'Back Cushion Required',
34 =>	'Brace Required (Leg,Back,Etc.)',
35 =>	'Foot Operated Emergency Brake',
36 =>	'Privilage Restriction',
37 =>	'5 or More Restrictions',
38 =>	'Speed Restriction',
39 =>	'Vision Exam Restriction',
'');

export lookup_Hair_Color(string pIn) :=
case(pIn,
 'A' => 'AUBURN',
 'B' => 'BROWN',
 'G' => 'GREY',
 'K' => 'BLACK', 
 'L' => 'BLONDE', 
 'M' => 'MIXED',
 'N' => 'NONE/BALD',
 'R' => 'RED',
 'U' => '', 
 'W' => 'WHITE',
 pIn);

export lookup_Eye_Color(string pIn) :=
case(pIn,
 'B' => 'BROWN',
 'E' => 'GREEN',
 'G' => 'GREY',
 'H' => 'HAZEL', 
 'K' => 'BLACK',
 'L' => 'BLUE',
 'M' => 'MIXED', 
 pIn);

export lookup_history(string pIn) := 
case(pIn,
 'H' => 'Historical',
 'C' => 'Current',
 ''  => 'Current',
 pIn);
END;