// GENERATE RANDOM FICTITIOUS biz NAMES
suffix:=['EXPRESS','SERVICES','MACHINES',
         'DISTRIBUTORS','MART','CONTRACTORS',
		 'ELECTRICAL','CHEMICAL','REPAIR SHOPS','STUDIOS',
		 'STORES','SHOPPES','INTERNATIONAL',
		 'OF AMERICA','ENGINEERING','CARPETS','APPLIANCES',
		 'METALS','CATERING','STEEL',
		 'BOOKS','FILMS','PAINTS'];

layout_biz := RECORD
integer5 seq;
string30 biz;
END;
/*
SET_biz:=DATASET([{0,'VALEN'},

{1,'RED'},
{2,'GREEN'},
{3,'BLU'},
{4,'SILVA'},
{5,'GOLDER'},
{6,'BELL'},
{7,'RING'},
{8,'CAR'},
{9,'BLACK'},
{10,'BROWN'},
{11,'FARM'},
{12,'ZILL'},
{13,'ALPHA'},
{14,'BETA'},
{15,'ZETA'},
{16,'KAFKA'},
{18,'RABBIT'},
{19,'WOLF'},
{20,'FOX'},
{21,'DEER'},
{22,'CAT'},
{23,'BISON'},
{24,'MOUS'},
{25,'TIGER'},
{27,'RAM'},
{28,'HAPPY'},
{29,'ANY'},
{30,'LAFF'},
{31,'SORRY'},
{32,'LONELY'},
{33,'PARTY'},
{34,'UNI'},
{35,'POLY'},
{36,'TRI'},
{37,'BAR'},
{38,'MALL'},
{39,'PAC'},

{40,'HART'},
{41,'SARD'},
{42,'DES'},
{43,'CARR'},
{44,'GAGLE'},
{45,'BALE'},
{46,'LED'},
{47,'MED'},
{48,'TAR'},
{49,'GER'},

{50,'WILL'},
{51,'DODD'},
{52,'GARB'},
{53,'KIM'},
{54,'LOND'},
{55,'PAR'},
{56,'BERL'},
{57,'AMST'},
{58,'KIRK'},
{59,'KRIST'},
{60,'TED'},
{61,'POP'},

{62,'GRIM'}



],layout_biz);
// we need to add more here.. to gen a 1000?
*/
set_biz:=choosen(gen_LastNames(StringLib.stringFind(lname,'JR.',1) = 0 and StringLib.stringFind(lname,'SR.',1) = 0),100);

layout_biz genBusinesses(SET_biz L, integer c):=TRANSFORM
SELF.SEQ:=(l.seq*23+c)*37%1400;
SELF.biz:=TRIM(L.lname)+' '+suffix[c];
END;
ds_random:=sort(NORMALIZE(set_biz,23,genBusinesses(left,counter)),seq);
export gen_BusinessNames:=ds_random;



