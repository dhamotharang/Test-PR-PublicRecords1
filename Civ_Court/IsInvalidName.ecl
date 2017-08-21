IMPORT Civ_Court,  ut;

EXPORT IsInvalidName( string name) := FUNCTION

string100 temp_name := ut.CleanSpacesAndUpper(name);

string1 v_inv_name_flag := IF(StringLib.StringFind(temp_name,'1-',1)!=0 OR
															StringLib.StringFind(temp_name,'(1)',1)!=0 OR
															StringLib.StringFind(temp_name,'$',1)!=0 OR
															StringLib.StringFind(temp_name,'MOBILE HOME',1)!=0 OR
															StringLib.StringFind(temp_name,'ABANDONED VEHICLE',1)!=0 OR
															StringLib.StringFind(temp_name,'ACCURA',1)!=0 OR
															StringLib.StringFind(temp_name,'AUDI',1)!=0 OR
															StringLib.StringFind(temp_name,'AMPHETAMINE',1)!=0 OR
															StringLib.StringFind(temp_name,'ARBITER',1)!=0 OR
															StringLib.StringFind(temp_name,'BIRTH CERT',1)!=0 OR
															StringLib.StringFind(temp_name,'BUICK',1)!=0 OR
															StringLib.StringFind(temp_name,'CADILAC',1)!=0 OR
															StringLib.StringFind(temp_name,'CADILLAC',1)!=0 OR
															StringLib.StringFind(temp_name,'CHEV ',1)!=0 OR
															StringLib.StringFind(temp_name,'CHEVROLE',1)!=0 OR
															StringLib.StringFind(temp_name,'CHRYSLER',1)!=0 OR
															StringLib.StringFind(temp_name,'CELLPHONE',1)!=0 OR
															StringLib.StringFind(temp_name,'COBRA ',1)!=0 OR
															StringLib.StringFind(temp_name,'COCAINE ',1)!=0 OR
															StringLib.StringFind(temp_name,'CONTRABAND',1)!=0 OR
															StringLib.StringFind(temp_name,'CURRENCY',1)!=0 OR
															StringLib.StringFind(temp_name,'DODGE',1)!=0 OR
															StringLib.StringFind(temp_name,'DOLLAR',1)!=0 OR
															StringLib.StringFind(temp_name,'EXPEDITED',1)!=0 OR
															StringLib.StringFind(temp_name,'FD ESCORT',1)!=0 OR
															StringLib.StringFind(temp_name,'FORD',1)!=0 OR
															StringLib.StringFind(temp_name,'GAMBLING',1)!=0 OR
															StringLib.StringFind(temp_name,'GMC',1)!=0 OR
															StringLib.StringFind(temp_name,'GLOCK',1)!=0 OR
															StringLib.StringFind(temp_name,'HANDGUN',1)!=0 OR
															StringLib.StringFind(temp_name,'HEROI',1)!=0 OR
															StringLib.StringFind(temp_name,'HARLEY DAVIDS',1)!=0 OR
															StringLib.StringFind(temp_name,'HONDA',1)!=0 OR
															StringLib.StringFind(temp_name,'JAGUAR',1)!=0 OR
															StringLib.StringFind(temp_name,'JEEP',1)!=0 OR
															StringLib.StringFind(temp_name,'LINCLON',1)!=0 OR
															StringLib.StringFind(temp_name,'LINCOLN',1)!=0 OR
															StringLib.StringFind(temp_name,'MAGNUM',1)!=0 OR
															StringLib.StringFind(temp_name,'MARIJUANA',1)!=0 OR
															StringLib.StringFind(temp_name,'MAZDA',1)!=0 OR
															StringLib.StringFind(temp_name,'METH ',1)!=0 OR
															StringLib.StringFind(temp_name,'MERC ',1)!=0 OR
															StringLib.StringFind(temp_name,'MERCEDES',1)!=0 OR
															StringLib.StringFind(temp_name,'MINOLTA',1)!=0 OR
															StringLib.StringFind(temp_name,'MITSUBISHI',1)!=0 OR
															StringLib.StringFind(temp_name,'MOTOROLA',1)!=0 OR
															StringLib.StringFind(temp_name,'NEC ',1)!=0 OR
															StringLib.StringFind(temp_name,'NISSAN',1)!=0 OR
															StringLib.StringFind(temp_name,'NOKIA',1)!=0 OR
															StringLib.StringFind(temp_name,'NONE',1)!=0 OR
															StringLib.StringFind(temp_name,'OLDS ',1)!=0 OR
															StringLib.StringFind(temp_name,'OLDSMOB',1)!=0 OR
															StringLib.StringFind(temp_name,'ORDER FOR',1)!=0 OR
															StringLib.StringFind(temp_name,'OUT OF STATE',1)!=0 OR
															StringLib.StringFind(temp_name,'PACKARD',1)!=0 OR
															StringLib.StringFind(temp_name,'PAC-TEL',1)!=0 OR
															StringLib.StringFind(temp_name,'PACTEL',1)!=0 OR
															StringLib.StringFind(temp_name,'PAGENET',1)!=0 OR
															StringLib.StringFind(temp_name,'PANASONIC',1)!=0 OR
															StringLib.StringFind(temp_name,'PENTAX',1)!=0 OR
															StringLib.StringFind(temp_name,'PESO ',1)!=0 OR
															StringLib.StringFind(temp_name,'PLUG ',1)!=0 OR
															StringLib.StringFind(temp_name,'PONTIAC',1)!=0 OR
															StringLib.StringFind(temp_name,'POUND',1)!=0 OR
															StringLib.StringFind(temp_name,'RADIO',1)!=0 OR
															StringLib.StringFind(temp_name,'RCA',1)!=0 OR
															StringLib.StringFind(temp_name,'REAL PROPERTY',1)!=0 OR
															StringLib.StringFind(temp_name,'REMINGTON',1)!=0 OR
															StringLib.StringFind(temp_name,'REVOLVER',1)!=0 OR
															StringLib.StringFind(temp_name,'RICOH ',1)!=0 OR
															StringLib.StringFind(temp_name,'RUGER ',1)!=0 OR
															StringLib.StringFind(temp_name,'SAFE',1)!=0 OR
															StringLib.StringFind(temp_name,'SCHEDULE',1)!=0 OR
															StringLib.StringFind(temp_name,'SHOTGUN',1)!=0 OR
															StringLib.StringFind(temp_name,'SENTRA ',1)!=0 OR
															StringLib.StringFind(temp_name,'SMITH & WESSON',1)!=0 OR
															StringLib.StringFind(temp_name,'SUBARU',1)!=0 OR
															StringLib.StringFind(temp_name,'SUZUKI',1)!=0 OR
															StringLib.StringFind(temp_name,'TRAILER',1)!=0 OR
															StringLib.StringFind(temp_name,'TOYOTA',1)!=0 OR
															StringLib.StringFind(temp_name,'VOLKSWA',1)!=0 OR
															StringLib.StringFind(temp_name,'WINCESTER',1)!=0 OR
															StringLib.StringFind(temp_name,'WINCHESTER',1)!=0 OR
															regexfind('1969|197[0-9]{1}|198[0-9]{1}|200[0-9]{1}',temp_name),'Y',' ');

  RETURN  if(trim(v_inv_name_flag,left,right)= '',0,1);
END;
															
															