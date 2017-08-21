/*2010-06-10T19:56:40Z (skasavajjala_prod)
c:\SuperComputer\Production\QueryBuilder\workspace\skasavajjala_prod\prod\FLAccidents\InFile_FLCrash1_v3\2010-06-10T19_56_40Z.ecl
*/
flc0_v3_in := dataset('~thor_data400::sprayed::flcrash1'
									,FLAccidents.Layout_FLCrash1_v3, csv(Heading(1),separator(','),terminator(['\n','\r\n']),quote('')));

flc0_v3_rec := FLAccidents.Layout_FLCrash1;
 fSlashedMDYtoYmd(string pDateIn) 
						:=     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
									+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
									+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);
flc0_v3_rec flc0_convert_to_old(flc0_v3_in l) := transform
   self.rec_type_1             := '1';
   
   self.report_date            := fSlashedMDYtoYmd(l.report_date)[1..6];
   
   self.city_nbr               := trim(l.county_code,left,right) + trim(l.city_code,left,right);
  
   self.alcohol_drug           := map(l.alcohol_drug = '1' => 'A',
                                       l.alcohol_drug = '2' => 'D',
									   l.alcohol_drug = '3' => 'B',
									   l.alcohol_drug = '4' => 'U',
									   l.alcohol_drug = '0' => 'N','');
   
   self.invest_complete        := map(l.invest_complete = '1' => 'Y',
                                       l.invest_complete = '2' => 'N','');
   self.first_aid_name         := map(l.first_aid_name_code = '1' => 'Physician',
                                      l.first_aid_name_code = '2' => 'EMT',
									  l.first_aid_name_code = '3' => 'Police Officer',
									  l.first_aid_name_code = '4' => 'Certified 1st Aider',
									  l.first_aid_name_code = '5' => 'Other','');
   self.injured_taken_to       := map(l.injured_taken_to_code = '1' => 'Y',
                                       l.injured_taken_to_code = '0' => 'N',''); 
	self.location_type         :=  map(l.location_type = '1' => 'B',
                                       l.location_type = '2' => 'R',
									   l.location_type = '3' => 'O',''); 
 
	self.first_contrib_cause	:=	l.rd_condition_primary;
	self.second_contrib_cause	:=	l.rd_condition_secondary;
	self.first_contrib_envir	:=	l.vision_obstructed_primary;
	self.second_contrib_envir   :=   l.vision_obstructed_secondary;
	self                := l;
	self                        := [];

end;

export InFile_FLCrash1_v3 := project(flc0_v3_in,flc0_convert_to_old(left));
