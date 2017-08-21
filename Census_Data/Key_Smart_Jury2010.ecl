Import Data_Services, ut;
export Key_Smart_Jury2010 := index(file_smart_jury2010,{stusab,county,tract,blkgrp},{age,income,home_value,education},'~thor::key::smart_jury_qa');
