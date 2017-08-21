IMPORT Civ_Court, ut;

EXPORT Files_In_MS_Harrison := MODULE

	//spray as CSV, no seperator due to multiple record lengths
	EXPORT civil_in	:= dataset('~thor_data400::in::civil::ms_harrison',Civ_Court.Layouts_In_MS_Harrison.raw_in, CSV); 
	
	//Project to fixed layout - currently records are two different lengths
	Civ_Court.Layouts_In_MS_Harrison.Civil xfrmRawIn(civil_in input) := TRANSFORM
		self.case_num	:= input.line[1..12];
		self.seq_num	:= input.line[13..15];
		self.plt_def	:= input.line[16..18];
		self.cv_crim	:= input.line[19..20];
		self.case_type	:= input.line[21..40];
		self.status			:= input.line[41..42];
		self.entitiy_name		:= input.line[43..77];
		self.file_date			:= input.line[78..85];
		self.offense_date1	:= input.line[86..93];
		self.offense1				:= input.line[94..123];
		self.disposition1		:= input.line[124..153];
		self.disposition_date1	:= input.line[154..161];
		self.offense_date2			:= input.line[162..169];
		self.offense2						:= input.line[170..199];
		self.disposition2				:= input.line[200..229];
		self.disposition_date2	:= input.line[230..237];
		self.offense_date3			:= input.line[238..245];
		self.offense3						:= input.line[246..275];
		self.disposition3				:= input.line[276..305];
		self.disposition_date3	:= input.line[306..313];
		self.offense_date4			:= input.line[314..321];
		self.offense4						:= input.line[322..351];
		self.disposition4				:= input.line[352..381];
		self.disposition_date4	:= input.line[382..389];
		self.offense_date5			:= input.line[390..397];
		self.offense5						:= input.line[398..427];
		self.disposition5				:= input.line[428..457];
		self.disposition_date5	:= input.line[458..465];
		self := [];
	END;
	
	EXPORT civil_fixed	:= project(civil_in,xfrmRawIn(left));
	
	//Normalize offense/disposition
	Civ_Court.Layouts_In_MS_Harrison.Civil_norm NormRawIn(civil_fixed input, integer1 C) := TRANSFORM
		ClnOffDate1	:= IF(input.offense_date1 = '00000000','',input.offense_date1);
		ClnOffDate2	:= IF(input.offense_date2 = '00000000','',input.offense_date2);
		ClnOffDate3	:= IF(input.offense_date3 = '00000000','',input.offense_date3);
		ClnOffDate4	:= IF(input.offense_date4 = '00000000','',input.offense_date4);
		ClnOffDate5	:= IF(input.offense_date5 = '00000000','',input.offense_date5);
		self.offense_date	:= CHOOSE(C,ClnOffDate1,ClnOffDate2,ClnOffDate3,ClnOffDate4,ClnOffDate5);
		self.offense	:= CHOOSE(C,input.offense1,input.offense2,input.offense3,input.offense4,input.offense5);
		self.disposition	:= CHOOSE(C,input.disposition1,input.disposition2,input.disposition3,input.disposition4,input.disposition5);
		ClnDispDate1	:= IF(input.disposition_date1 = '00000000','',input.disposition_date1);
		ClnDispDate2	:= IF(input.disposition_date2 = '00000000','',input.disposition_date2);
		ClnDispDate3	:= IF(input.disposition_date3 = '00000000','',input.disposition_date3);
		ClnDispDate4	:= IF(input.disposition_date4 = '00000000','',input.disposition_date4);
		ClnDispDate5	:= IF(input.disposition_date5 = '00000000','',input.disposition_date5);
		self.disposition_date	:= CHOOSE(C,ClnDispDate1,ClnDispDate2,ClnDispDate3,ClnDispDate4,ClnDispDate5);
		self := input;
	END;
	
 NormCivil	:= normalize(civil_fixed,5,NormRawIn(left,counter));
 
 EXPORT civil	:= dedup(NormCivil(trim(cv_crim,left,right) = 'CV')); //Filter Civil records
		
END;