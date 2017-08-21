
suffix:=['','ES','OV','SON','ER','ARZI','ERO','ART','UR','IN',
        'ETTA','WALLAH','ALI','STON','ANA','AIMA','ONEN','ILLE','OST','OVA',
				'ARNI','EZZI','OSHI','VANDORN','MAN'];

layout_lname := RECORD
integer5 seq;
string30 lname;
END;

SET_lname:=DATASET([
{0,'VALEN'},
{1,'KORN'},
{2,'MCJOHN'},
{3,'BLAIR'},
{4,'MCBAIN'},
{5,'CORD'},
{6,'RAXELL'},
{7,'STUL'},
{8,'JON'},
{9,'RAMIR'},
{10,'CHORZAIM'},
{11,'ZAM'},
{12,'ELWOOD'},
{13,'DOM'},
{14,'JOHAN'},
{15,'BORD'},
{16,'COHN'},
{18,'ALI'},
{19,'TELL'},
{20,'ZELL'},
{21,'DONN'},
{22,'ALEX'},
{23,'NORD'},
{24,'OKAZ'},
{25,'PERS'},
{27,'QIR'},
{28,'ROZ'},
{29,'JOS'},
{30,'ULAK'},
{31,'SAMUEL'},
{32,'PAUL'},
{33,'PETER'},
{34,'IVAN'},
{35,'TEMUR'},
{36,'YUL'},
{37,'AUG'},
{38,'CLINT'},
{39,'GREEN'},

{40,'HART'},
{41,'SARD'},
{42,'DES'},
{43,'CARR'},
{44,'GAGLE'},
{45,'BALE'},
{46,'LED'},
{47,'RED'},
{48,'TAR'},
{49,'GER'},

{50,'HILL'},
{51,'DAR'},
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

{62,'GOLD'}



],layout_lname);
// we need to add more here.. to gen a 1000?


layout_lname genLastNames(SET_LNAME L, integer c):=TRANSFORM
SELF.SEQ:=(l.seq*24+c)*37%1300;
SELF.LNAME:=TRIM(L.LNAME)+suffix[c];
END;
ds_random:=sort(NORMALIZE(set_lname,24,genLastNames(left,counter)),seq);

layout_lname sequenceit(ds_random l, integer C):= TRANSFORM
self.seq:=C;
self:=l;
END;

export gen_LastNames := project(ds_random,sequenceit(LEFT,COUNTER));
//export gen_LastName := 'todo';