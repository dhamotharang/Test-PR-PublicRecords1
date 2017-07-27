df := faa.file_airmen_Certificate_in;

faa.layout_airmen_certificate_out into(df L) := transform
	self.cer_type_mapped := case(l.cer_type,
		'P'  => 'Pilot',
		'Y'  => 'Pilot 61.75',
		'B'  => 'Pilot 61.77',
		'F'  => 'Flight Instructor',
		'A'  => 'Authorized Aircraft Instructor',
		'G'  => 'Ground Instructor',
		'E'  => 'Flight Engineer',
		'H'  => 'Flight Engineer (Special Purpose - Lessee)',
		'X'  => 'Flight Engineer (Foreign Based)',
		'M'  => 'Mechanic',
		'T'  => 'Control Tower Operator',
		'R'  => 'Repairman',
		'I'  => 'Repairman Experimental Aircraft Builder',
		'L'  => 'Repairman Light Sport Aircraft',
		'W'  => 'Rigger',
		'D'  => 'Dispatcher',
		'N'  => 'Flight Navigator',
		'J'  => 'Flight Navigator (Special Purpose - Foreign Based)',
		'Z'  => 'Flight Attendant',
		'Unknown');
	self.cer_level_mapped := case(l.cer_level,
		'A'  => 'Airline Transport Pilot',
		'C'  => 'Commercial',
		'P'  => 'Private',
		'V'  => 'Recreational',
		'T'  => 'Sport',
		'S'  => 'Student',
		'Z'  => 'Commercial (Foreign Based)',
		'Y'  => 'Private (Foreign Based)',
		'X'  => 'Historic (Foreign Based)',
		'B'  => 'Airline Transport Pilot (Special Purpose)',
		'K'  => 'Obsolete',
		'U'  => 'Master Parachute Rigger',
		'W'  => 'Senior Parachute Rigger',
		'Unknown');
	self := l;
end;

df2 := project(df,into(LEFT));

export airmen_certificate_process := df2;