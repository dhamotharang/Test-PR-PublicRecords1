IMPORT UT; 
export Function_ParseDate (string p_DateIn, string format):= Function
string fSlashedMDYtoCYMD(string pDateIn) 
				:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
				+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
				+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);
				
string fSlashedMDYtoCYMD_v2(string pDateIn) 
				:=    intformat((integer2)regexreplace('.*-.*-([0-9]+)',pDateIn,'$1'),4,1) 
				+     intformat((integer1)regexreplace('([0-9]+)-.*-.*',pDateIn,'$1'),2,1)
				+     intformat((integer1)regexreplace('.*-([0-9]+)-.*',pDateIn,'$1'),2,1);				
				
string CleanMDY1(string pDateIn) 
				:=    intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
				+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1)				
				+     intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),2,1);
				
string CleanMDY2(string pDateIn) 
				:=    intformat((integer1)regexreplace('([0-9]+)-.*-.*',pDateIn,'$1'),2,1)
				+     intformat((integer1)regexreplace('.*-([0-9]+)-.*',pDateIn,'$1'),2,1)				
				+     intformat((integer2)regexreplace('.*-.*-([0-9]+)',pDateIn,'$1'),2,1);				
				
 string DateOut := MAP ( format = 'MM/DD/YYYY' => fSlashedMDYtoCYMD(p_DateIn) ,
 												 format = 'MM-DD-YYYY'=>  fSlashedMDYtoCYMD_v2(p_DateIn) ,
                         format = 'MMDDYYYY'   => p_DateIn[5..8]+p_DateIn[1..2]+p_DateIn[3..4] ,
                         format = 'MM/DD/YYDOB'=> (string)ut.Date_MMDDYY_i2_v2(CleanMDY1(p_DateIn)) ,
												 format = 'MM-DD-YYDOB'=> (string)ut.Date_MMDDYY_i2_v2(CleanMDY2(p_DateIn)) ,
												 format = 'MMDDYYDOB'  => (string)ut.Date_MMDDYY_i2_v2(p_DateIn) ,
												 format = 'MM/DD/YY'   => (string)ut.Date_MMDDYY_i2(CleanMDY1(p_DateIn)) ,
												 format = 'MM-DD-YY'   => (string)ut.Date_MMDDYY_i2(CleanMDY2(p_DateIn)) ,
												 format = 'MMDDYY'     => (string)ut.Date_MMDDYY_i2(p_DateIn) ,
                         '');
 return DateOut;
end;