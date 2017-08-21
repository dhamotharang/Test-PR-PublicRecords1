temp_layout := record
string8 receivingdt;
CellPhone.layoutCellmillion;

end;

/* ***************************************************************************************** */
d20060615 := dataset('~thor_dell400::in::cellphones::traffix::20060615::cellmillion.txt',
					CellPhone.layoutCellmillion,csv(terminator('\n'), separator('|'), quote('')));
					
temp_layout t20060615(d20060615 input) := Transform

self.receivingdt 	:= '20060615'; 
self				:= input; 

end;

p20060615 := project(d20060615,t20060615(left));

/* ***************************************************************************************** */
d20060719 := dataset('~thor_dell400::in::cellphones::traffix::20060719::cellmillion.txt',
					CellPhone.layoutCellmillion,csv(terminator('\n'), separator('|'), quote('')));
					
temp_layout t20060719(d20060719 input) := Transform

self.receivingdt 	:= '20060719'; 
self				:= input; 

end;

p20060719 := project(d20060719,t20060719(left));
					
/* ***************************************************************************************** */
d20060831 := dataset('~thor_dell400::in::cellphones::traffix::20060831::cell2million08312006.txt',
					CellPhone.layoutCellmillion,csv(terminator('\n'), separator('|'), quote('')));
					
temp_layout t20060831(d20060831 input) := Transform

self.receivingdt 	:= '20060831'; 
self				:= input; 

end;

p20060831 := project(d20060831,t20060831(left));
/* ***************************************************************************************** */
d20060929 := dataset('~thor_dell400::in::cellphones::traffix::20060929::Cellmillion09292006.txt',
					CellPhone.layoutCellmillion,csv(terminator('\n'), separator('|'), quote('')));
					
temp_layout t20060929(d20060929 input) := Transform

self.receivingdt 	:= '20060929'; 
self				:= input; 

end;

p20060929 := project(d20060929,t20060929(left));
/* ***************************************************************************************** */
d20061026 := dataset('~thor_dell400::in::cellphones::traffix::20061026::cell_938470_10262006.txt',
					CellPhone.layoutCellmillion,csv(terminator('\n'), separator('|'), quote('')));
					
temp_layout t20061026(d20061026 input) := Transform

self.receivingdt 	:= '20061026'; 
self				:= input; 

end;

p20061026  := project(d20061026 ,t20061026 (left));
/* ***************************************************************************************** */

d20061215 := dataset('~thor_dell400::in::cellphones::traffix::20061215::cell_1121636_12152006.txt',
					CellPhone.layoutCellmillion,csv(terminator('\n'), separator('|'), quote('')));
					
temp_layout t20061215(d20061215 input) := Transform

self.receivingdt 	:= '20061215'; 
self				:= input; 

end;

p20061215 := project(d20061215,t20061215(left));
/* ***************************************************************************************** */

d20070108 := dataset('~thor_dell400::in::cellphones::traffix::20070108::cell_503354_01082007.txt',
					CellPhone.layoutCellmillion,csv(terminator('\n'), separator('|'), quote('')));
			
temp_layout t20070108(d20070108 input) := Transform

self.receivingdt 	:= '20070108'; 
self				:= input; 

end;

p20070108 := project(d20070108,t20070108(left));
/* ***************************************************************************************** */

d20070122 := dataset('~thor_dell400::in::cellphones::traffix::20070122::cell_852164_01222007_con0107.txt',
					CellPhone.layoutCellmillion,csv(terminator('\n'), separator('|'), quote('')));
			
temp_layout t20070122(d20070122 input) := Transform

self.receivingdt 	:= '20070122'; 
self				:= input; 

end;

p20070122 := project(d20070122,t20070122(left));
/* ***************************************************************************************** */

d20070202 := dataset('~thor_dell400::in::cellphones::traffix::20070202::cell_215674_02012007.txt',
					CellPhone.layoutCellmillion,csv(terminator('\n'), separator('|'), quote('')))
			+dataset('~thor_dell400::in::cellphones::traffix::20070202::cell_784326_02012007_oth0040.txt',
					CellPhone.layoutCellmillion,csv(terminator('\n'), separator('|'), quote('')));
			
temp_layout t20070202(d20070202 input) := Transform

self.receivingdt 	:= '20070202'; 
self				:= input; 

end;

p20070202 := project(d20070202,t20070202(left));
/* ***************************************************************************************** */

d20070308 := dataset('~thor_dell400::in::cellphones::traffix::20070308::cell_235803_03012007.txt',
					CellPhone.layoutCellmillion,csv(terminator('\n'), separator('|'), quote('')))
			+dataset('~thor_dell400::in::cellphones::traffix::20070308::cell_709405_03012007_oth0040.txt',
					CellPhone.layoutCellmillion,csv(terminator('\n'), separator('|'), quote('')));
			
temp_layout t20070308(d20070308 input) := Transform

self.receivingdt 	:= '20070308'; 
self				:= input; 

end;

p20070308 := project(d20070308,t20070308(left));

/* ***************************************************************************************** */

d20070620 := dataset('~thor_dell400::in::cellphones::traffix::20070620::cell_1000000_06202007.txt',
					CellPhone.layoutCellmillion,csv(terminator('\n'), separator('|'), quote('')));
			
temp_layout t20070620(d20070620 input) := Transform

self.receivingdt 	:= '20070620'; 
self				:= input; 

end;

p20070620 := project(d20070620,t20070620(left));

/* ***************************************************************************************** */

d20070719 := dataset('~thor_dell400::in::cellphones::traffix::20070719::cell_1000000_07172007.txt',
					CellPhone.layoutCellmillion,csv(terminator('\n'), separator('|'), quote('')));
			
temp_layout t20070719(d20070719 input) := Transform

self.receivingdt 	:= '20070719'; 
self				:= input; 

end;

p20070719 := project(d20070719,t20070719(left));

/* ***************************************************************************************** */

d20070824 := dataset('~thor_dell400::in::cellphones::traffix::20070824::cell_1000000_08212007.txt',
					CellPhone.layoutCellmillion,csv(terminator('\n'), separator('|'), quote('')));
			
temp_layout t20070824(d20070824 input) := Transform

self.receivingdt 	:= '20070824'; 
self				:= input; 

end;

p20070824 := project(d20070824,t20070824(left));

/* ***************************************************************************************** */

d20070924 := dataset('~thor_dell400::in::cellphones::traffix::20070924::cell_1247185_07212007.txt',
					CellPhone.layoutCellmillion,csv(terminator('\n'), separator('|'), quote('')));
			
temp_layout t20070924(d20070924 input) := Transform

self.receivingdt 	:= '20070924'; 
self				:= input; 

end;

p20070924 := project(d20070924,t20070924(left));

/* ***************************************************************************************** */

d20071207 := dataset('~thor_dell400::in::cellphones::traffix::20071023::cell_1000000_11212007_october_revised.txt',
					CellPhone.layoutCellmillion,csv(terminator('\n'), separator('|'), quote('')));
			
temp_layout t20071207(d20071207 input) := Transform

self.receivingdt 	:= '20071207'; 
self				:= input; 

end;

p20071207 := project(d20071207,t20071207(left));

/* ***************************************************************************************** */

d20080108 := dataset('~thor_dell400::in::cellphones::traffix::20080108::cell_1000000_12212007.txt',
					CellPhone.layoutCellmillion,csv(terminator('\n'), separator('|'), quote('')));
			
temp_layout t20080108(d20080108 input) := Transform

self.receivingdt 	:= '20080108'; 
self				:= input; 

end;

p20080108 := project(d20080108,t20080108(left));


export fileCellmillion := p20060615+p20060719+p20060831+p20060929+p20061026+p20061215+p20070108+p20070122+p20070202+p20070308+p20070620+p20070719+p20070824+p20070924+p20071207
						 +p20080108;