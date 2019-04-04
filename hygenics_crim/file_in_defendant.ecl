
import data_services, ut,LIB_Date;
 Parsename :=  module
export Fixname (string pname,string plastname,string pfirstname,string pmiddlename) := function

   outname :=        MAP( 
 												 regexfind('(JANE|JOHN) AKA[ :](.*) DOE AKA[ ]*$',pname)   =>regexreplace('(JANE|JOHN) AKA[ :](.*) DOE AKA[ ]*$',pname,'$1'),
												 regexfind('DOE AKA[ :](.*) (JANE|JOHN) AKA[ ]*$',pname)   =>regexreplace('DOE AKA[ :](.*) (JANE|JOHN) AKA[ ]*$',pname,'$1'),

                         regexfind('DOE AKA[ :](.*) (JANE|JOHN) AKA[: ](.*)',pname)=>regexreplace('DOE AKA[: ](.*) (JANE|JOHN) AKA[: ](.*)',pname,'$1$3'),
                         regexfind('(JANE|JOHN) AKA[ :](.*) DOE AKA[: ](.*)',pname)=>regexreplace('(JANE|JOHN) AKA[ :](.*) DOE AKA[: ](.*)',pname,'$1$3'),
												 regexfind('(.*) AKA[/ :]DOE[, ](.*) AKA[/: ](JANE|JOHN)',pname)=>regexreplace('(.*) AKA[/ :]DOE[, ](.*) AKA[/: ](JANE|JOHN)',pname,'$1$2'),

                                                                           
										  	 regexfind('DOE, (.*) AKA (JOHN|JANE)[ ]*$',pname)  =>regexreplace('DOE, (.*) AKA (JOHN|JANE)[ ]*$',pname,'$1'),
												 regexfind('DOE AKA (.*) (JOHN|JANE)[ ]*$',pname)   =>regexreplace('DOE AKA (.*) (JOHN|JANE)[ ]*$',pname,'$1'),
												 
												 regexfind('(JANE|JOHN)[,] DOE[-/ ]+AKA[:/ ]',pname)     =>regexreplace('(JANE|JOHN)[,] DOE[-/ ]+AKA[:/ ]',pname,''),
												 regexfind('(JANE|JOHN)[ ]DOE[/,]+ AKA[:/ ]',pname)     =>regexreplace('(JANE|JOHN)[ ]DOE[/,]+ AKA[:/ ]',pname,''),
												 regexfind('(JANE|JOHN)[ ]DOE[-/ ]+AKA[,/ ]',pname)      =>regexreplace('(JANE|JOHN)[ ]DOE[-/ ]+AKA[,/ ]',pname,''),
												 regexfind('DOE (JANE|JOHN)[, ]+AKA[:,/ ]',pname)     =>regexreplace('DOE (JANE|JOHN)[, ]+AKA[:,/ ]',pname,''),

												 regexfind(' AKA[: ](JANE|JOHN) DOE',pname)   =>regexreplace(' AKA[: ](JANE|JOHN) DOE',pname,''),
												 regexfind('^AKA[: ](JANE|JOHN) DOE',pname)   =>regexreplace('^AKA[: ](JANE|JOHN) DOE',pname,''), 
												 regexfind('DOE[-,/ ]*(JANE|JOHN) AKA[,: ]',pname)   =>regexreplace('DOE[-,/ ]*(JANE|JOHN) AKA[,: ]',pname,''), 												 
												 regexfind('^DOE| DOE[-,/:( ]',pname) and regexfind('[-,/:( ]AKA[)-,/: ]',pname) and regexfind('JOHN|JANE',pname) =>
 											 												    regexreplace('^DOE| DOE[-,/:( ]',
																									regexreplace('[-,/:( ]AKA[)-,/: ]',
																									regexreplace('JOHN|JANE',pname,''),''),''),

                         //Two AKA  CARPENTER AKA CHAPMAN AKA GEROFSKY, SARAH RENEE                                                                    
                         regexfind('(.*)[ (]AKA[): ](.*)[ (]AKA[): ](.*)(, (.*))[ ]$',pname) => regexreplace('(.*)[ (]AKA[): ](.*)[ (]AKA[): ](.*)(, (.*))[ ]$',pname,'$1$4'),                                                                           
 												 
												 //Two AKA  //SPOSATO AKA WEESE, LARA AKA LAURA MARA 
              											

                         regexfind('(.*)[ (]AKA[): ](.*)(, (.*))[ (]AKA[): ](.*)',pname) => regexreplace('(.*)[ (]AKA[): ](.*)(, (.*))[ (]AKA[): ](.*)',pname,'$1$3'),                                                                           
												 //Two AKA //BARRAZZA, REGUGIO AKA ALTAMIRANO AKA                                                                               
												 regexfind('(.*)[ (]AKA[): ](.*)[ (]AKA[): ]+$',pname) => regexreplace('(.*)[ (]AKA[): ](.*)[ (]AKA[): ]+$',pname,'$1'),
										     //Two AKA
												 regexfind('(.*)[ (]AKA[): ](.*)[ (]AKA[): ](.*)',pname) => regexreplace('(.*)[ (]AKA[): ](.*)[ (]AKA[): ](.*)',pname,'$1'),

                         //Three AKA
												 regexfind('(.*)[ (]AKA[): ](.*)[ (]AKA[): ](.*)[ (]AKA[): ](.*)',pname) => regexreplace('(.*)[ (]AKA[): ](.*)[ (]AKA[): ](.*)[ (]AKA[): ](.*)',pname,'$1'),


												 regexfind('^[A-Z]+ AKA[ ]*$',pmiddlename) and regexfind('(.*) AKA[ ]*$',pname) => regexreplace('(.*) AKA[ ]*$',pname,'$1'),
												 regexfind('^AKA[: ]+(.*)$',pmiddlename) and regexfind('(.*) AKA[: ]+(.*)[ ]*$',pname) => regexreplace('(.*) AKA[: ]+(.*)[ ]*$',pname,'$1'),
												 regexfind('(.*) [(]AKA[)][ ]*$',pname) => regexreplace('(.*) [(]AKA[)][ ]*$',pname,'$1'),

 	                       pmiddlename ='AKA' and regexfind('(.*) AKA[ ]*$',pname) => regexreplace('(.*) AKA[ ]*$',pname,'$1'),
																								 
												 //NAME AKA NAME												 
												 regexfind('(.*)[/ ]+AKA[/ ]+(.*)',pmiddlename) => regexreplace('(.*)[/ ]+AKA[/ ]+(.*)',pname,'$1'),
                         //AKA name    												 												 
												 regexfind('^[(]AKA[)][ ]*(.*)$',pmiddlename) and regexfind('(.*) [(]AKA[)][ ]*(.*)[ ]*$',pname) => regexreplace('(.*) [(]AKA[)][ ]*(.*)[ ]*$',pname,'$1'),
                         
                         //AKA beginning
												 regexfind('^[(]*AKA[)]*[, ](.*)',pname) => regexreplace('^[(]*AKA[)]*[, ](.*)',pname,'$1'),
												 //AKA in the end
												 regexfind('(.*)[ (:]AKA[) ]*$',pname)  => regexreplace('(.*)[ :(]AKA[) ]*$',pname,'$1'), 
												 
  											 /////////////////////////////////////////////////////order of the following imp////////////////////////////
												 
												 //L (AKA alias), F M
												 regexfind('(.*) [(][ ]*AKA[-:/ ]+(.*)[)]([, ](.*))',pname) => regexreplace('(.*) [(][ ]*AKA[-:/ ]+(.*)[)]([, ](.*))',pname,'$1$3'),
                         //Name (AKA alias)
												 //(regexfind('[(]AKA',pmiddlename) or pmiddlename ='')and 
												 regexfind('(.*)[ ][(]AKA[-:/, ]+(.*)[) ]',pname)   =>regexreplace('(.*)[ ][(]AKA[-:/, ]+(.*)[) ]',pname,'$1'),
												 
                         //L, F AKA alias
                         regexfind('((.*),)[ ](.*)[/( ]+AKA[):/ ]+(.*)',pname) => regexreplace('((.*),)[ ](.*)[(/: ]+AKA[:/) ]+(.*)',pname,'$1$2'),
												 
												 //L AKA alias, F M
												 regexfind('(.*)[/( ]AKA[)/: ](.*)(, (.*))',pname)=> regexreplace('(.*)[(/ ]AKA[)/: ](.*)(, (.*))',pname,'$1$3'),												 
												 //L AKA, F M
												 regexfind('(.*)[/ (]AKA[) ]*$',plastname) and regexfind('(.*)[/ (]AKA[) ]*(, (.*))',pname)=> regexreplace('(.*)[/ (]AKA[) ]*(, (.*))',pname,'$1$2'),
											 
					

												 pfirstname ='AKA' and regexfind(' AKA ',pname) => regexreplace(' AKA ',pname,' '),
												 regexfind('^AKA[:]+(.*)$',pfirstname) => regexreplace('AKA:',pname,' '),
												 
												 regexfind('(.*)[: (]*AKA[): ]+[ ]*$',pfirstname) => regexreplace('[ (:]*AKA[): ]',pname,' '),	
												 
												 regexfind('(.*),[ ](.*)[/( ]+AKA[):/ ]+(.*)',pname) => regexreplace('((.*),)[ ](.*)[(/: ]+AKA[:/) ]+(.*)',pname,'$1 $2'),          
                         pname
												 );
return outname;
end;

export Fixmiddlename (string pname,string plastname,string pfirstname,string pmiddlename) := function
middlename := map(pmiddlename ='AKA'   and regexfind('(.*) AKA[ ]*$',pname)   => '',
		                       regexfind('(.*)[/ ]+AKA[ /]+(.*)',pmiddlename) => regexreplace('(.*)[/ ]+AKA[/ ]+(.*)',pmiddlename,'$1'),
												   regexfind('(.*) AKA[ ]*$',pmiddlename) => regexreplace('(.*) AKA[ ]*$',pmiddlename,'$1'),
												   regexfind('^[A-Z]+ AKA[ ]*$',pmiddlename) and regexfind('(.*) AKA[ ]*$',pname)   => regexreplace('^([A-Z]+) AKA[ ]*$',pmiddlename,'$1'),
												   pmiddlename ='(AKA)' and regexfind('(.*) (AKA)[ ]*$',pname) => '',	
													 regexfind('^AKA[: ]+(.*)$',pmiddlename) =>'',
													 regexfind('[(][ ]*AKA[-:/ ]+(.*)[)][, ](.*)',pmiddlename) =>regexreplace('[(][ ]*AKA[-:/ ]+(.*)[)][, ](.*)',pmiddlename,'$2'),
													 regexfind('[(][ ]*AKA[-:/ ]+(.*)[)]*[ ]*$',pmiddlename) =>'',
													 
													 regexfind('^[(]AKA[)][ ]*(.*)$',pmiddlename) =>'',
												   pmiddlename
													);
return(middlename)	;												
end;

export Fixlastname (string pname,string plastname,string pfirstname,string pmiddlename) := function
	lastname:=					map(plastname ='AKA'   and regexfind('^AKA, (.*)',pname)   => '',
		                       plastname ='(AKA)'   and regexfind('^(AKA), (.*)',pname)   => '',
		                       regexfind('^AKA[ ]+(.*)$',plastname) => regexreplace('^AKA[ ]+(.*)$',plastname,'$1'),
		                       regexfind('(.*)[/ ]+AKA[ /]+(.*)',plastname) => regexreplace('(.*)[/ ]+AKA[/ ]+(.*)',plastname,'$1'),
												   plastname
													);							
 return(lastname);													
end;

export Fixfirstname (string pname,string plastname,string pfirstname,string pmiddlename) := function
	firstname:=					map(pfirstname IN ['AKA','(AKA)','AKA:']     => '',		
		                       regexfind('^AKA[:]+(.*)$',pfirstname) => regexreplace('^AKA[: ]+(.*)$',pfirstname,'$1'),
													 regexfind('(.*)[:(]AKA[): ]+$',pfirstname) => regexreplace('(.*)[:(]AKA[): ]+$',pfirstname,'$1'),
												   pfirstname
													);								
 return(firstname);													
end;
end;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

file_in_offense_all 	:=  file_in_offense;

file_in_defendant_all := dataset(data_services.foreign_prod+'thor_200::in::crim::hd::aoc_defendant', hygenics_crim.layout_in_defendant,
														CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))
														(stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID' and nametype<>'B' and name not in ['UNKNOWN', 'RESTRICTED', 'EXPUNGED', 'EXPUNGED EXPUNGED', 'NONAME'] and regexfind('[0-9][0-9]+', name[1..2], 0)='' and trim(SourceName, left, right)<>'NORTH_CAROLINA_ADMINISTRATIVE_OFFICE_OF_THE_COURTS');

file_in_defendant_CW  := dataset(data_services.foreign_prod+'thor_200::in::crim::hd::aoc_defendant_cw', hygenics_crim.layout_in_defendant,
														CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))
														(stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID' and nametype<>'B' and name not in ['UNKNOWN', 'RESTRICTED', 'EXPUNGED', 'EXPUNGED EXPUNGED', 'NONAME'] and regexfind('[0-9][0-9]+', name[1..2], 0)='') ;

proj_def_cw           := Project(file_in_defendant_CW,transform(hygenics_crim.layout_in_defendant,self.sourcename := trim(left.sourcename)+'_CW'; self := left;));

file_in_defendant_IE  := dataset(data_services.foreign_prod+'thor_200::in::crim::hd::aoc_defendant_IE', hygenics_crim.layout_in_defendant,
														CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))
														(stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID' and nametype<>'B' and name not in ['UNKNOWN', 'RESTRICTED', 'EXPUNGED', 'EXPUNGED EXPUNGED', 'NONAME'] and regexfind('[0-9][0-9]+', name[1..2], 0)='') ;

proj_def_IE           := Project(file_in_defendant_IE,transform(hygenics_crim.layout_in_defendant,self.sourcename := trim(left.sourcename)+'_IE'; self := left;));

//Pull Only OR Defendants Where There is a Corresponding Offense////////////////////////////////////////////////

	Filtered_Offense_Sources := ['OR','FL','AZ','MN','MD'];
	
	or_off_only					:= file_in_offense_all(statecode IN Filtered_Offense_Sources);
	not_or_off					:= file_in_offense_all(statecode NOT IN Filtered_Offense_Sources);

	or_def_only					:= file_in_defendant_all(statecode IN Filtered_Offense_Sources);
	not_or_def					:= file_in_defendant_all(statecode NOT IN Filtered_Offense_Sources);

	hygenics_crim.layout_in_defendant noCivil(or_def_only l,or_off_only r):= transform	
		self := l;
	end;

  or_def_off_mat 			:= join(or_def_only,or_off_only,
													left.recordid = right.recordid and
													left.statecode = right.statecode,
													noCivil(left, right),skew(1));
													
	or_def_off_match 		:= dedup(sort(or_def_off_mat, statecode, recordid), record);
	
	all_def := not_or_def + or_def_off_match+proj_def_cw+proj_def_IE;//:persist('~thor_200::persist::crim::hd::aoc_def_filtered');
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	layout_in_defendant findComp(all_def l):= transform
		// self.name 		:= MAP(_functions.is_company(l.name)=1 and l.dob='' and l.gender[1] not in ['F','M'] and l.height='' and l.weight='' and length(StringLib.StringFilter(StringLib.StringToUpperCase(l.name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))=0 => '',
												 // _functions.is_company(l.name)=1 and l.dob='' and l.gender[1] not in ['F','M'] and l.height='' and l.weight='' => '',
												 // l.middlename ='AKA' and regexfind('(.*) AKA[ ]*$',l.name) => regexreplace('(.*) AKA[ ]*$',l.name,'$1'),
												 // regexfind('^[A-Z]+ AKA[ ]*$',l.middlename) and regexfind('(.*) AKA[ ]*$',l.name) => regexreplace('(.*) AKA[ ]*$',l.name,'$1'),
												 // regexfind('^AKA (.*)$',l.middlename) and regexfind('(.*) AKA (.*)[ ]*$',l.name) => regexreplace('(.*) AKA (.*)[ ]*$',l.name,'$1'),
												 // regexfind('(.*) [(]AKA[)][ ]*$',l.name) => regexreplace('(.*) [(]AKA[)][ ]*$',l.name,'$1'),
												 // regexfind('(.*) [(]AKA[, ](.*)[)][ ]*$',l.name) => regexreplace('(.*) [(]AKA[, ](.*)[)][ ]*$',l.name,'$1'),
												 // regexfind('^AKA, (.*)',l.name) => regexreplace('^AKA, (.*)',l.name,'$1'),
												 // regexfind('(.*)[/ ]+AKA[/ ]+(.*)',l.middlename) => regexreplace('(.*)[/ ]+AKA[/ ]+(.*)',l.name,'$1'),
												 // regexfind('(.*) AKA[ ]*$',l.name)  => regexreplace('(.*) AKA[ ]*$',l.name,'$1'),
							           // l.name
												 // );
		// self.middlename := map(l.middlename ='AKA'   and regexfind('(.*) AKA[ ]*$',l.name)   => '',
		                       // regexfind('(.*)[/ ]+AKA[ /]+(.*)',l.middlename) => regexreplace('(.*)[/ ]+AKA[/ ]+(.*)',l.middlename,'$1'),
												   // regexfind('(.*) AKA[ ]*$',l.middlename) => regexreplace('(.*) AKA[ ]*$',l.middlename,'$1'),
												   // regexfind('^[A-Z]+ AKA[ ]*$',l.middlename) and regexfind('(.*) AKA[ ]*$',l.name)   => regexreplace('^([A-Z]+) AKA[ ]*$',l.middlename,'$1'),
												   // l.middlename ='(AKA)' and regexfind('(.*) (AKA)[ ]*$',l.name) => '',	
													 // regexfind('^AKA (.*)$',l.middlename) =>'',
												   // l.middlename
													// );
		// self.lastname   := map(l.lastname ='AKA'   and regexfind('^AKA, (.*)',l.name)   => '',
												   // l.lastname
													// );					
													
    temp_name 		  := Parsename.fixname(l.name,l.lastname,l.firstname,l.middlename);
		
		tempmiddle      := Parsename.Fixmiddlename(l.name,l.lastname,l.firstname,l.middlename);
		
		templast        := Parsename.FixLastname(l.name,l.lastname,l.firstname,l.middlename);
									 			
		tempfirst       := Parsename.FixFirstname(l.name,l.lastname,l.firstname,l.middlename);	
		
		self.name       := temp_name;
    self.lastname		:= templast;	
		self.firstname  := tempfirst;
    self.middlename := tempmiddle;														
		self 			:= l;
	end;

	all_rec := project(all_def, findComp(left)) ;

//Added 60 Day Restriction to INDIANA Sourced Data///////////////////////////////////////////////////////////////////

	ds_filter 	:= all_rec(statecode<>'IN'); 
	ds_IN				:= all_rec(statecode='IN' and LIB_Date.DaysApart(recorduploaddate,_functions.GetDate )<=60);
											
	filtered_recs	:= ds_filter + ds_IN;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	remove_companies		:= filtered_recs(name<>'' and  trim(name,left,right) not in ['BOB AKA','DOB AKA','AKA-DOB','AKA']);
	// and 
  // regexfind('^[ ]*AKA[, ]+[A-Z ]+|^[A-Z ]+ AKA[ ]*$|[:,/ ]AKA[:,/ ]|AKA[0-9]+ AKA[0-9]+|[(]AKA',name,0)= ''  );
output(all_rec( regexfind('^[ ]*AKA[, ]+[A-Z ]+|^[A-Z ]+ AKA[ ]*$|[:,/ ]AKA[:,/ ]|AKA[0-9]+ AKA[0-9]+|[(]AKA',name,0) <>  ''));
// output(all_rec( sourcename ='ARIZONA_DEPARTMENT_OF_PUBLIC_SAFETY_CW'));
export file_in_defendant 
	:= remove_companies((StateCode not in ['AZ','AK', 'OR']) or 
								(StateCode in ['AZ','AK'] and defendantstatus in ['','DEFENDANT'] and (trim(lastname, left, right)<>'PARKING' and regexfind('[0-9][0-9]+', trim(firstname, left, right)[1..2], 0)='')) or 
								(StateCode in ['OR'] and regexfind('DEFENDANT', defendantstatus, 0)<>'' and sourcename='OREGON_ADMINISTRATOR_OF_THE_COURTS_APPELLATE_CASE_MANAGEMENT_SYSTEM') or 
								(StateCode in ['OR'] and defendantstatus ='' and sourcename='OREGON_ADMINISTRATOR_OF_THE_COURTS')
								):persist('~thor200_144::persist::in::crim::aoc_defendant_filtered');/*(StateCode in _include_states and defendantstatus='DEFENDANT')*//*(sourcetype in _control.keep_sourcetypes and sourcename not in _control.discard_sourcenames)*/;
