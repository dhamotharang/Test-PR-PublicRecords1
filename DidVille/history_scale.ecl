import ut;

ms(unsigned4 l) :=
  (ut.DaysSince1900((string4)(l div 100),(string2)(l % 100),'1') - ut.DaysSince1900('1995','1','1')) div 30;

export history_scale(unsigned4 l) := IF(MS(l)>0,MS(l),5) / 100;