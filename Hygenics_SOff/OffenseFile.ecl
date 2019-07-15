//export OffenseFile := Mapping_Accurint_Offenses_As_Common;
Offense := Mapping_Accurint_Offenses_As_Common;
//Added the following to remove dups and make the persistent key unique
sortedOffense := sort(distribute(Offense,HASH(Seisint_Primary_Key,offense_persistent_id)), 
                               Seisint_Primary_Key,
															 offense_persistent_id,
															 offense_date,
                               conviction_date,      
                               StringLib.StringFilter(StringLib.StringToUpperCase(offense_code_or_statute),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),															 
                               StringLib.StringFilter(StringLib.StringToUpperCase(offense_description+offense_description_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),                               
															 StringLib.StringFilter(StringLib.StringToUpperCase(court_case_number),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),	
															 
															 StringLib.StringFilter(StringLib.StringToUpperCase(conviction_jurisdiction),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),                               
                               StringLib.StringFilter(StringLib.StringToUpperCase(court),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
                               StringLib.StringFilter(StringLib.StringToUpperCase(offense_category),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),                               
															 StringLib.StringFilter(StringLib.StringToUpperCase(arrest_date),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),                               
															 StringLib.StringFilter(StringLib.StringToUpperCase(victim_minor),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),  
                               victim_age,
                               victim_gender,
                               victim_relationship,
                               sentence_description,
                               sentence_description_2,
                               fcra_conviction_flag,
                               fcra_traffic_flag,
                               fcra_date,
                               fcra_date_type,
                               conviction_override_date,
                               conviction_override_date_type,
                               offense_score
															 ,local);

															 
sortedOffense rollupCrim(sortedOffense L, sortedOffense R) := TRANSFORM
    self.conviction_jurisdiction  := if(l.conviction_jurisdiction = '', r.conviction_jurisdiction  ,l.conviction_jurisdiction);
    self.court                    := if(l.court                   = '', r.court                    ,l.court);
		self.offense_category         := if(l.offense_category        = '', r.offense_category         ,l.offense_category);
		self.arrest_date              := if(l.arrest_date             = '', r.arrest_date              ,l.arrest_date);
		self.victim_minor             := if(l.victim_minor            = '', r.victim_minor             ,l.victim_minor);
		self.victim_age               := if(l.victim_age              = '', r.victim_age               ,l.victim_age);
		self.victim_gender            := if(l.victim_gender           = '', r.victim_gender            ,l.victim_gender);
		self.victim_relationship      := if(l.victim_relationship     = '', r.victim_relationship      ,l.victim_relationship);
		
		self.sentence_description     := if(l.sentence_description    = '', r.sentence_description     ,l.sentence_description);
		self.sentence_description_2   := if(l.sentence_description_2  = '', r.sentence_description_2   ,l.sentence_description_2);
		self.fcra_conviction_flag     := if(l.fcra_conviction_flag    = '', r.fcra_conviction_flag     ,l.fcra_conviction_flag);
		self.fcra_traffic_flag        := if(l.fcra_traffic_flag       = '', r.fcra_traffic_flag        ,l.fcra_traffic_flag);
		self.fcra_date                := if(l.fcra_date               = '', r.fcra_date                ,l.fcra_date);
		
		self.fcra_date_type                := if(l.fcra_date_type                = '', r.fcra_date_type               ,l.fcra_date_type);
		self.conviction_override_date      := if(l.conviction_override_date      = '', r.conviction_override_date     ,l.conviction_override_date);
		self.conviction_override_date_type := if(l.conviction_override_date_type = '', r.conviction_override_date_type,l.conviction_override_date_type);
		self.offense_score                 := if(l.offense_score                 = '', r.offense_score                ,l.offense_score);
    SELF   := L; 
END;														 

rollupoffenseOut := ROLLUP(sortedOffense,  
              left.Seisint_Primary_Key   = right.Seisint_Primary_Key and 
							left.offense_persistent_id = right.offense_persistent_id and
							trim(left.offense_date)    = trim(Right.offense_date) and 
							trim(left.conviction_date) = trim(right.conviction_date) and 
              StringLib.StringFilter(StringLib.StringToUpperCase(left.offense_description+offense_description_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') = StringLib.StringFilter(StringLib.StringToUpperCase(Right.offense_description+offense_description_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') and 							 
							StringLib.StringFilter(StringLib.StringToUpperCase(left.offense_code_or_statute),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') = StringLib.StringFilter(StringLib.StringToUpperCase(Right.offense_code_or_statute),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') and 
              StringLib.StringFilter(StringLib.StringToUpperCase(left.court_case_number),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') = StringLib.StringFilter(StringLib.StringToUpperCase(Right.court_case_number),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') and
							
							(StringLib.StringFilter(StringLib.StringToUpperCase(left.conviction_jurisdiction),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')= StringLib.StringFilter(StringLib.StringToUpperCase(Right.conviction_jurisdiction),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') or right.conviction_jurisdiction ='' or left.conviction_jurisdiction ='') and                                
              (StringLib.StringFilter(StringLib.StringToUpperCase(left.court),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')                  = StringLib.StringFilter(StringLib.StringToUpperCase(Right.court),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')                   or right.court                   ='' or left.court             ='') and 
              (StringLib.StringFilter(StringLib.StringToUpperCase(left.offense_category),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')       = StringLib.StringFilter(StringLib.StringToUpperCase(Right.offense_category),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')        or right.offense_category        ='' or left.offense_category  ='') and                       
							(StringLib.StringFilter(StringLib.StringToUpperCase(left.arrest_date),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')            = StringLib.StringFilter(StringLib.StringToUpperCase(Right.arrest_date),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')             or right.arrest_date             ='' or left.arrest_date       ='') and                   
							(StringLib.StringFilter(StringLib.StringToUpperCase(left.victim_minor),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')           = StringLib.StringFilter(StringLib.StringToUpperCase(Right.victim_minor),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')            or right.victim_minor            ='' or left.victim_minor      ='') and 
							(left.victim_age           = right.victim_age           or   right.victim_age            ='' or left.victim_age     ='') and 
							(left.victim_gender        = right.victim_gender        or   right.victim_gender         ='' or left.victim_gender  ='') and 
							(left.victim_relationship  = right.victim_relationship  or   right.victim_relationship   ='' or left.victim_relationship     ='') and 
              (StringLib.StringFilter(StringLib.StringToUpperCase(Left.sentence_description+Left.sentence_description_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') =StringLib.StringFilter(StringLib.StringToUpperCase(Right.sentence_description+Right.sentence_description_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') or   right.sentence_description+right.sentence_description_2  ='' or Left.sentence_description+Left.sentence_description_2   ='') and                                
							(left.fcra_conviction_flag = right.fcra_conviction_flag or   right.fcra_conviction_flag  ='' or left.fcra_conviction_flag    ='') and 
							(left.fcra_traffic_flag    = right.fcra_traffic_flag    or   right.fcra_traffic_flag     ='' or left.fcra_traffic_flag       ='') and 
							(left.fcra_date            = right.fcra_date            or   right.fcra_date             ='' or left.fcra_date       ='') and 
							(left.fcra_date_type       = right.fcra_date_type       or   right.fcra_date_type        ='' or left.fcra_date_type  ='') and 
							(left.conviction_override_date = right.conviction_override_date           or   right.conviction_override_date        ='' or left.conviction_override_date       ='') and 
							(left.conviction_override_date_type = right.conviction_override_date_type or   right.conviction_override_date_type   ='' or left.conviction_override_date_type  ='') and 
              (left.offense_score = right.offense_score               or   right.offense_score         ='' or left.offense_score   =''),             
          		rollupCrim(LEFT,RIGHT),local) : persist ('~thor400::persist::SexOffender::Rolledupoffenses');
							
dedupedOffense:= dedup(rollupoffenseOut,Seisint_Primary_Key,
															 offense_persistent_id,
															 offense_date,
                               conviction_date,      
                               StringLib.StringFilter(StringLib.StringToUpperCase(offense_code_or_statute),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),															 
                               StringLib.StringFilter(StringLib.StringToUpperCase(offense_description+offense_description_2),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),                               
															 StringLib.StringFilter(StringLib.StringToUpperCase(court_case_number),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),	
															 
															 StringLib.StringFilter(StringLib.StringToUpperCase(conviction_jurisdiction),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),                               
                               StringLib.StringFilter(StringLib.StringToUpperCase(court),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
                               // StringLib.StringFilter(StringLib.StringToUpperCase(offense_category),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),                               
															 StringLib.StringFilter(StringLib.StringToUpperCase(arrest_date),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),                               
															 StringLib.StringFilter(StringLib.StringToUpperCase(victim_minor),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),  
                               victim_age,
                               victim_gender,
                               victim_relationship,
                               sentence_description,
                               sentence_description_2,
                               fcra_conviction_flag,
                               fcra_traffic_flag,
                               fcra_date,
                               fcra_date_type,
                               conviction_override_date,
                               conviction_override_date_type,
                               offense_score,local);							
export OffenseFile := dedupedOffense;							
	