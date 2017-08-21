//
import ut,doxie;

string Zip1 := '92401,92402,92403,92404,92405,92406,92407,92408,92410,92411,92412,92413,92414,92415,92418,92423,92424,92427'	
			: stored('Zip1');		// san bernardino, ca

string Zip2 := '65801,65802,65803,65804,65805,65806,65807,65808,65809,65810,65814,65817,65890,65897,65898,65899' 
			: stored('Zip2');		// springfield, mo

string Zip3 := '32801,32802,32803,32804,32805,32806,32807,32808,32809,32810,32811,32812,32814,32815,32816,32817,32818,32819,32820,32821,32822,32824,32825,32826,32827,32828,32829,32830,32831,32832,32833,32834,32835,32836,32837,32839,32853,32854,32855,32856,32857,32858,32859,32860,32861,32862,32867,32868,32869,32872,32877,32878,32885,32886,32887,32891,32896,32897,32899' 
			: stored('Zip3');		// orlando, fl


unsigned Radius1 := 75 : stored('Radius1');
unsigned Radius2 := 75 : stored('Radius2');
unsigned Radius3 := 75 : stored('Radius3');

unsigned1 StCode1 := ut.St2Code(ziplib.ZipToState2(Zip1));
unsigned1 StCode2 := ut.St2Code(ziplib.ZipToState2(Zip2));
unsigned1 StCode3 := ut.St2Code(ziplib.ZipToState2(Zip3));

unsigned4 z1l := 199906 : stored('Zip1LowYYYYMM');
unsigned4 z1h := 199911 : stored('Zip1HighYYYYMM'); 

unsigned4 z2l := 200001 : stored('Zip2LowYYYYMM');
unsigned4 z2h := 200005 : stored('Zip2HighYYYYMM');

unsigned4 z3l := 200809 : stored('Zip3LowYYYYMM');
unsigned4 z3h := 200902 : stored('Zip3HighYYYYMM');

unsigned1 AgeHigh := 99 : stored('AgeHigh');
unsigned1 AgeLow :=  0 : stored('AgeLow');

doxie.Start_TroySearch(zip1,z1l,z1h,Radius1,ofile)
i1 := output( count(ofile), named('From_Zip1') );

doxie.And_TroySearch(ofile,zip2,z2l,z2h,Radius2,ofile1)

i2 := output( count(ofile1), named('From_Zip2') );

doxie.And_TroySearch(ofile1,zip3,z3l,z3h,Radius3,ofile2)

i3 := output( count(ofile2), named('From_Zip3') );

Cands := map ( Zip2 = '' => ofile,
	        Zip3 = '' => ofile1 ,
	        ofile2 );
			
export get_candidates := cands	: persist('thor::persist::fbi_cjr1:get_candidates');
	   
	   
