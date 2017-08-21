// GENERATE RANDOM FICTITIOUS CITY NAMES
suffix:=['TOWN','VILLE','MONT',
         'VALE','PARK','FORT',
		 'LAKE','BERG','WATER','VALLEY',
		 'RIVER','FOREST','WOOD',
		 'INGTON','IZZA',' BEACH','ROCK',
		 'STONE','HILL','ESTON',
		 ' LODGE',' CABINS','OXI'];

layout_city := RECORD
integer5 seq;
string30 city;
END;

SET_city:=DATASET([{0,'VALEN'},

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



],layout_city);
// we need to add more here.. to gen a 1000?


layout_city genCities(SET_city L, integer c):=TRANSFORM
SELF.SEQ:=(l.seq*23+c)*37%1400;
SELF.city:=TRIM(L.city)+suffix[c];
END;
ds_random:=sort(NORMALIZE(set_city,23,genCities(left,counter)),seq);

layout_cityzip:=RECORD
layout_city;
string3 zip_prefix;

END;

layout_cityzip sequenceit(ds_random l, integer C):= TRANSFORM
self.seq:=C;
self.zip_prefix:=intformat(c,3,1);
self:=l;
END;
//output(ds_random);
my_blank_value := DATASET([{9999,'','***'}],layout_cityzip);
export gen_CityNames := project(ds_random,sequenceit(LEFT,COUNTER)) + my_blank_value;


