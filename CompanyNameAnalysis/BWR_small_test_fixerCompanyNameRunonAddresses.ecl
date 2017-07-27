import text;
import CompanyNameAnalysis;

//-------------- test test test test ---------------------------
// The following is a set of 101 company names from NGBDL2.Layout_Header
CompanyName_with_id_rec := RECORD
  integer coname_id;
	string company_name;
	string prim_name;
	string city;
	string state;
END;

standardized_sampleCompanyNameAndAddress0 := 
      DATASET([
// inline_ds_701-800_randomized_companynamescontainingrunonaddresses.ecl
               {701,'BANK OF BENTONVILLEBENTONVILLEAR 72712','','',''},
               {702,'UNION BANK 120 W 12TH STKANSAS CITYMO 64105','','',''},
               {703,'MERCANTILE BANK OF ST LOUIS 721 LOCUSTST LOUISMO 63101','','',''},
               {704,'CENTRAL BANK PO BO X207OSAGE BEACHMO 65065','','',''},
               {705,'FIRST MIDWEST BANK PO BOX 160POPLAR BLUFFMO 63902','','',''},
               {706,'BANK OF MONTREAL 430 PARK AVE 16TH FLOORNEW YORKNY 10022','','',''},
               {707,'COMMERCE BANK OF ST LOUISST LOUISMO 63105','','',''},
               {708,'CITIZENS BANK OF ROGERSVILLEROGERSVILLEMO 65742','','',''},
               {709,'FIRSTAR BANK NA PO BOX 66911ST LOUISMO 63166','','',''},
               {710,'FARMERS STATE BANK PO BOX 129STANBERRYMO 64489','','',''},
               {711,'K C BOBCAT INC 2209 W 40 HWYBLUE SPRINGSMO 64015','','',''},
               {712,'PACIFIC MUTUAL LIFE INS CO 700NEWPORT BEACHCA 92660','','',''},
               {713,'SECURITY BANK OF PULASKI CO PO BOX SWAYNESVILLEMO 65583','','',''},
               {714,'MERCANTILE BANK OF MONETT PO BOX 437PINEVILLEMO 64856','','',''},
               {715,'LEASTEC CORPORATION LEASETECNEEDHAM HEIGHTSMA 02194','','',''},
               {716,'ECOLAB INC ECOLAB CENTER NORTHST PAULMN 55102','','',''},
               {717,'ECOLAB INC ECOLAB CENTERST PAULMN 55102','','',''},
               {718,'ROADBUILDERS MACHINERY SUPPLKANSAS CITYKS 66105','','',''},
               {719,'BOATMENS NATIONAL BANK 4625 LINDELL BLVDST LOUISMO 63108','','',''},
               {720,'SOUTH SIDE NATIONAL BANK 3606 GRAVOISST LOUISMO 63116','','',''},
               {721,'SECURITY LEASING SERVICES INCKANSAS CITYMO 64152','','',''},
               {722,'PHH VEHICLE MANAGEMENTHUNT VALLEYMD 21030','','',''},
               {723,'THE BOATMENS NATIONAL BANK 800 MARKET STST LOUISMO 63101','','',''},
               {724,'SECURITY BANK OF PULASKI CO PO BOX SWAYNESVILLEMO 65583','','',''},
               {725,'BOATMENS BANK PO BOX 410MOUNTAIN GROVEMO 65711','','',''},
               {726,'BC NATIONAL BANKS PO BOX 335PLEASANT HILLMO 64080','','',''},
               {727,'BOATMENS FIRST NATIONAL BANKST LOUISMO 63179','','',''},
               {728,'FIRST BANKCREVE COEURMO 63141','','',''},
               {729,'IBJ SCHRODER LEASING CORP ONE STATE STNEW YORKNY 10004','','',''},
               {730,'BOATMENS BANK 9500 MISSION RDOVERLAND PARKKS 66206','','',''},
               {731,'TOYOTALIFT MIDAMERICA INCKANSAS CITYMO 64106','','',''},
               {732,'1ST BUSINESS BANK OF KCKANSAS CITYMO 64112','','',''},
               {733,'VARILEASE CORPORATIONFARMINGTON HILLSMI 48334','','',''},
               {734,'ECOLAB ECOLAB CENTERST PAULMO 55102','','',''},
               {735,'MITSUI VENDOR LEASING USA INCSAN DIEGOCA 92122','','',''},
               {736,'CITIZENS NATIONAL BANK 7305 MANCHESTER RDST LOUISMO 63143','','',''},
               {737,'DUCHESNE BANK PO BOX 76940ST PETERSMO 63376','','',''},
               {738,'RELIANCE SURETY COPHILADELPHIAPA 19103','','',''},
               {739,'FIRST STATE COMMUNITY BANKFARMINGTONMO 63640','','',''},
               {740,'ST LOUIS LEASING CORPORATIONELLISVILLEMO 63021','','',''},
               {741,'CITIZENS BANK DRAWER ABLYTHEDALEMO 64426','','',''},
               {742,'YALE FINANCIAL SERVICES INCFLEMINGTONNJ 08822','','',''},
               {743,'BOATMENS FIRST NATIONAL BANKST LOUISMO 63179','','',''},
               {744,'BANK OF LINCOLNWOODLINCOLNWOODIL 60646','','',''},
               {745,'BANNISTER BANK TRUSTKANSAS CITYMO 64138','','',''},
               {746,'SENSORMATIC ELECTRONICS CORPDEERFIELD BEACHFL 33442','','',''},
               {747,'KING COMMERCIAL CORPST LOUISMO 63127','','',''},
               {748,'FIRST BANK 11901 OLIVE BLVDCREVE COEURMO 63141','','',''},
               {749,'BLUE SPRINGS BANK 1100 MAINBLUE SPRINGSMO 64105','','',''},
               {750,'MERCANTILE BANKWILLOW SPRINGSMO 65793','','',''},
               {751,'BANK IV PO BOX 14040SHAWNEE MISSIONKS 66285','','',''},
               {752,'CITIZENS JACKSON COUNTY BANKBLUE SPRINGSMO 64015','','',''},
               {753,'MISSOURI BANK TRUST COKANSAS CITYMO 64196','','',''},
               {754,'CENTRAL BANK PO BOX 207OSAGE BEACHMO 65065','','',''},
               {755,'MERCANTILE BANK PO BOX 419147KANSAS CITYMO 64141','','',''},
               {756,'SNAPON CREDIT CORP PO BOX 15010SHAWNEE MISSIONKS 66285','','',''},
               {757,'UMB BANK NA 1010 GRANDKANSAS CITYMO 64106','','',''},
               {758,'FEDERAL FINANCE PLAN PO BOX 1391DES MOINESIA 50305','','',''},
               {759,'MISSOURI SOUTHERN BANK PO BOX 528WEST PLAINSMO 65775','','',''},
               {760,'NATIONAL REALTY FUNDINGKANSAS CITYMO 64105','','',''},
               {761,'PLAZA ALLERGY SERVICES INCKANSAS CITYMO 64112','','',''},
               {762,'THE BOATMENS NATIONAL BANKST LOUISMO 63101','','',''},
               {763,'THE BANK OF ST CHARLES COUNTYST CHARLESMO 63304','','',''},
               {764,'MERRILL LYNCH CAPITAL SERVICESNEW YORKNY 10281','','',''},
               {765,'SNAPON CREDIT CORP PO BOX 15010SHAWNEE MISSIONKS 66285','','',''},
               {766,'ST LOUIS LEASING CORPORATIONELLISVILLEMO 63021','','',''},
               {767,'COMMERCE BANK OF ST LOUISST LOUISMO 63105','','',''},
               {768,'CREDIT SUISSE FIRST BOSTON 11 MADISON AVENEW YORKNY 10010','','',''},
               {769,'MIDWEST BANKCENTRE 2191 LEMAY FERRY RDST LOUISMO 63125','','',''},
               {770,'CASS BANK TRUST COMPANY 3636 S GEYER RDST LOUISMO 63127','','',''},
               {771,'COMMERCE BANK 8000 FORSYTH BLVDST LOUISMO 63105','','',''},
               {772,'FIRST BANK 1835 FIRST STREETHIGHLAND PARKIL 60035','','',''},
               {773,'ROADBUILDERS MACHINERYKANSAS CITYKS 66105','','',''},
               {774,'TRUCKSTOP RESTAURANTS INC PO BOX 356BOONVILLEMO 65233','','',''},
               {775,'BRINKER TRACTOR SALES INC PO BOX 9FLORISSANTMO 63032','','',''},
               {776,'SOUTHWEST BANK 2301 S KINGSHIGHWAYST LOUISMO 63110','','',''},
               {777,'GENERAL MOTORS ACCEPTANCECREVE COEURMO 63141','','',''},
               {778,'KING COMMERCIAL CORPST LOUISMO 63128','','',''},
               {779,'CENTRAL BANK PO BOX 207OSAGE BEACHMO 65065','','',''},
               {780,'UNITED MO BANK OF KC 928 GRANDKANSAS CITYMO 64106','','',''},
               {781,'HIGH RIDGE MERCANTILE BANK PO BOX 30HIGH RIDGEMO 63049','','',''},
               {782,'COUNTRY CLUB BANK PO BOX 16410KANSAS CITYMO 64112','','',''},
               {783,'FIRST BANKLAKE ST LOUISMO 63367','','',''},
               {784,'NORWEST EQUIPMENT FINANCE INCMINNEAPOLISMN 55479','','',''},
               {785,'BANNISTER BANK TRUST 222 W GREGORYKANSAS CITYMO 64114','','',''},
               {786,'ST LOUIS LEASING CORPORATIONELLISVILLEMO 63021','','',''},
               {787,'FIRSTAR BANK NA PO BOX 66911ST LOUISMO 63166','','',''},
               {788,'GARDNER WALLCOVERING INCHOPKINSVILLEKY 42240','','',''},
               {789,'IBM CREDIT CORP 1133 WESTCHESTER AVEWHITE PLAINSNY 10604','','',''},
               {790,'MERCANTILE BANKCAPE GIRARDEAUMO 63702','','',''},
               {791,'ORIX USA CORPORATIONLOS ANGELESCA 90071','','',''},
               {792,'FIRST NATIONAL BANK PO BOX 138CAMDENTONMO 65020','','',''},
               {793,'MISSOURI BANK TRUST COKANSAS CITYMO 64196','','',''},
               {794,'MERAMEC VALLEY BANK 199 CLARKSON RDELLISVILLEMO 63011','','',''},
               {795,'SECURITY BANK OF KANSAS CITYKANSAS CITYKS 66117','','',''},
               {796,'TRICON CAPITAL UNIT OF 3200 PARK CTR DRCOSTA MESACA 92626','','',''},
               {797,'SAGE FINANCIAL CORP 2170 PONTIAC RDAUBURN HILLSMI 48326','','',''},
               {798,'MONTGOMERY FIRST NATIONAL BANK PO BOX 948SIKESTONMO 63801','','',''},
               {799,'MARK TWAIN KANSAS CITY BANKKANSAS CITYMO 64112','','',''},
               {800,'PARIBAS 787 7TH AVENEW YORKNY 10019','','',''}
							]
				      , CompanyName_with_id_rec
						 );
output(COUNT(standardized_sampleCompanyNameAndAddress0),NAMED('c_standardized_sampleCompanyNameAndAddress0'));
output(standardized_sampleCompanyNameAndAddress0,NAMED('standardized_sampleCompanyNameAndAddress0'));

coname_ds_with_spaces_added := CompanyNameAnalysis.fixerCompanyNameRunonAddresses(standardized_sampleCompanyNameAndAddress0) ;

output(COUNT(coname_ds_with_spaces_added),NAMED('c_coname_ds_with_spaces_added'));
output(coname_ds_with_spaces_added,NAMED('coname_ds_with_spaces_added'));
