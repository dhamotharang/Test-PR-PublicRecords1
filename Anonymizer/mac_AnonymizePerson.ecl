IMPORT Anonymizer, Std, Address;
EXPORT mac_AnonymizePerson(Input, Firstname='', Lastname='', Gender='', SSN='', DOB='', FullName='',Phone='',Email='') := FUNCTIONMACRO
  RETURN PROJECT(Input, 
    TRANSFORM(RECORDOF(LEFT),
			#IF(#TEXT(FirstName)!='')
      SELF.Firstname := IF(LEFT.FirstName <> '', Anonymizer.fn_name_replace('FIRST', LEFT.Firstname, 
         #IF(#TEXT(Gender) != '')
          LEFT.Gender
         #ELSE
          ''
         #END
        ), ''),	
			#END
			#IF(#TEXT(LastName)!='')
        SELF.Lastname := IF(LEFT.LastName <> '', Anonymizer.fn_name_replace('LAST', LEFT.Lastname), ''),
			#END
			#IF(#TEXT(FullName)!='')
				_CleanName 	:= Address.CleanNameFields(Address.CleanPerson73(LEFT.FullName)).CleanNameRecord;
				_First			:= Anonymizer.fn_name_replace('FIRST', _CleanName.fname,
											 #IF(#TEXT(Gender) != '') LEFT.Gender
											 #ELSE ''
											 #END);
				_Middle			:= _CleanName.mname;
				_Last				:= Anonymizer.fn_name_replace('LAST', _CleanName.lname);
				_Suffix			:= _CleanName.name_suffix;
				SELF.FullName := IF(LEFT.FullName <> '', (_First + ' ' + IF(_Middle <> '', TRIM(_Middle) + ' ', '') + _Last + ' ' + TRIM(_Suffix)), ''),
			#END
      #IF(#TEXT(SSN) != '')
        SELF.SSN := (TYPEOF(LEFT.SSN))IF((UNSIGNED)LEFT.SSN <> 0,
          #IF(#TEXT(FirstName)!= '' and #TEXT(LastName)!='')
            ((STRING)HASH32(LEFT.Lastname + LEFT.Firstname))[1..9]
          #ELSEIF(#TEXT(FullName)!='')
            ((STRING)HASH32(TRIM(_CleanName.lname)+TRIM(_CleanName.fname)))[1..9]
          #ELSE
            ((STRING)HASH32(LEFT.SSN))[1..9]
          #END
         ,''), 
			#END
			#IF(#TEXT(DOB) != '')
				SELF.DOB := (TYPEOF(LEFT.DOB)) IF((UNSIGNED)LEFT.DOB <> 0,
          (STRING)(Std.Date.Year((UNSIGNED)LEFT.DOB) * 10000 +
          #IF(#TEXT(FirstName)!= '' and #TEXT(LastName)!='')
            ([12,11,10,9,8,7,6,5,4,3,2,1][HASH32(LEFT.Lastname + LEFT.Firstname)%12+1] * 100) + [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30][HASH32(LEFT.Lastname + LEFT.Firstname)%30+1])
          #ELSEIF(#TEXT(FullName)!='')
            ([12,11,10,9,8,7,6,5,4,3,2,1][HASH32(TRIM(_CleanName.lname)+TRIM(_CleanName.fname))%12+1] * 100) + [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30][HASH32(TRIM(_CleanName.lname)+TRIM(_CleanName.fname))%30+1])
          #ELSE
            ([12,11,10,9,8,7,6,5,4,3,2,1][HASH32(LEFT.DOB)%12+1] * 100) + [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30][HASH32(LEFT.DOB)%30+1])
          #END  
        ,''),
      #END
			#IF(#TEXT(Phone) != '')
				SELF.Phone := (TYPEOF(LEFT.Phone))IF((UNSIGNED)LEFT.Phone <> 0,(STRING)INTFORMAT(((INTEGER)HASH32(LEFT.Phone)),10,1)[1..10],''), 
			#END
			#IF(#TEXT(Email) != '')
				SELF.Email := IF(LEFT.Email <> '', Anonymizer.fn_email_replace(LEFT.Email), '');
			#END
      SELF := LEFT
        ));

ENDMACRO;