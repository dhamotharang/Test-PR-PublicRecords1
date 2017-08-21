
export Unicode FN_CleanupNameData(Unicode dataIn) := FUNCTION
	dataUpper := UnicodeLib.UnicodeToUpperCase(dataIn);
	dataTrim := TRIM(dataUpper);
	d1 := UnicodeLib.UnicodeCleanSpaces(dataTrim);
	d2 := d1;
	//d2 := UnicodeLib.UnicodeFindReplace(d1,u'-',u' ');
	d3 := UnicodeLib.UnicodeFindReplace(d2,u'/',u' ');
	d4 := UnicodeLib.UnicodeFindReplace(d3,u'5',u'S');                                                                                                                                                                                                       

	d5 := UnicodeLib.UnicodeFindReplace(d4,u'0',u'O');
	d6 := REGEXREPLACE(u'(\\+|_|=|\\{|\\}|\\[|\\]|\\(|\\)|<|>|\\.|[0-9])',d5, u' ');
	d7 := UnicodeLib.UnicodeFindReplace(d6,u'´',u'\'');	
	d8 := UnicodeLib.UnicodeFindReplace(d7,u', ',u',');
	d9 := UnicodeLib.UnicodeFindReplace(d8,u' ,',u',');
	d10 := UnicodeLib.UnicodeFindReplace(d9,u',,',u',');
	d11 := UnicodeLib.UnicodeFindReplace(d10,u'  ',u' ');
	
	d12 :=UnicodeLib.UnicodeFindReplace(d11,u'AAR N ',u'AARON ');
	d13 :=UnicodeLib.UnicodeFindReplace(d12,u'GONZ LEZ ',u'GONZALEZ ');
	d14 :=UnicodeLib.UnicodeFindReplace(d13,u'L ON ',u'LEON ');
	d15 :=UnicodeLib.UnicodeFindReplace(d14,u'MAR A ',u'MARIA ');
	d16 :=UnicodeLib.UnicodeFindReplace(d15,u'RODR GUEZ ',u'RODRIGUEZ ');
	d17 :=UnicodeLib.UnicodeFindReplace(d16,u'G MEZ ',u'GOMEZ ');
	d18 :=UnicodeLib.UnicodeFindReplace(d17,u'S NCHEZ ',u'SANCHEZ ');
	d19 :=UnicodeLib.UnicodeFindReplace(d18,u'JES S ',u'JESUS ');
	d20 :=UnicodeLib.UnicodeFindReplace(d19,u'BARR N ',u'BARRON ');
	d21 :=UnicodeLib.UnicodeFindReplace(d20,u'D AZ ',u'DIAZ ');
	d22 :=UnicodeLib.UnicodeFindReplace(d21,u'RAM N ',u'RAMON ');
	d23 :=UnicodeLib.UnicodeFindReplace(d22,u'P REZ ',u'PEREZ ');
	d24 :=UnicodeLib.UnicodeFindReplace(d23,u'C SAR ',u'CESAR ');
	d25 :=UnicodeLib.UnicodeFindReplace(d24,u'MART NEZ ',u'MARTINEZ ');
	d26 :=UnicodeLib.UnicodeFindReplace(d25,u'H CTOR ',u'HECTOR ');
	d27 :=UnicodeLib.UnicodeFindReplace(d26,u'GARC A ',u'GARCIA ');
	d28 :=UnicodeLib.UnicodeFindReplace(d27,u'DE L A ',u'DE LA ');
	d29 :=UnicodeLib.UnicodeFindReplace(d28,u'L PEZ',u'LOPEZ');
	d30 :=UnicodeLib.UnicodeFindReplace(d29,u'CH VEZ ',u'CHAVEZ ');
	d31 :=UnicodeLib.UnicodeFindReplace(d30,u' MC ',u' MC');
	d32 :=UnicodeLib.UnicodeFindReplace(d31,u'D ELA ',u'DE LA ');
	d33 :=UnicodeLib.UnicodeFindReplace(d32,u'R IZ ',u'RUIZ ');
	d34 :=UnicodeLib.UnicodeFindReplace(d33,u'HERN NDEZ ',u'HERNANDEZ ');
	d35 :=UnicodeLib.UnicodeFindReplace(d34,u'LE N ',u'LEON ');
	d36 :=UnicodeLib.UnicodeFindReplace(d35,u' SN ',u' SAN ');
	d37 :=UnicodeLib.UnicodeFindReplace(d36,u'ALARC N ',u'ALARCON ');
	d38 :=UnicodeLib.UnicodeFindReplace(d37,u'ALRAC N ',u'ALARCON ');
	d39 :=UnicodeLib.UnicodeFindReplace(d38,u'C RUZ ',u'CRUZ ');
	d40 :=UnicodeLib.UnicodeFindReplace(d39,u' O O ',u' ');//convention for "no father"...
	d41 :=UnicodeLib.UnicodeFindReplace(d40,u'GARC IA' ,u'GARCIA');
	d42 :=UnicodeLib.UnicodeFindReplace(d41,u'GRAC IA' ,u'GARCIA');
	d43 :=UnicodeLib.UnicodeFindReplace(d42,u'ESCORC IA' ,u'ESCORCIA');
	d44 :=UnicodeLib.UnicodeFindReplace(d43,u'GRACIA' ,u'GARCIA');
	d45 :=UnicodeLib.UnicodeFindReplace(d44,u' VALENC IA' ,u' VALENCIA');
	d46 :=UnicodeLib.UnicodeFindReplace(d45,u'MOLI NA ' ,u'MOLINA ');
	d47 :=UnicodeLib.UnicodeFindReplace(d46,u' GUAD ' ,u' GUADALUPE ');
	d48 :=UnicodeLib.UnicodeFindReplace(d47,u' DEL P ' ,u' DEL PILAR ');
	d49 :=UnicodeLib.UnicodeFindReplace(d48,u' DEL C ' ,u' DEL CARMEN ');
	d50 :=UnicodeLib.UnicodeFindReplace(d49,u' NTRA ' ,u' NUESTRA ');
	d51 :=UnicodeLib.UnicodeFindReplace(d50,u' SRA ' ,u' SENORA ');
	d52 :=UnicodeLib.UnicodeFindReplace(d51,u' NIÑO J ' ,u' NIÑO JESUS ');
	d53 :=UnicodeLib.UnicodeFindReplace(d52,u' DE J Y M ' ,u' DE JESUS Y MARIA ');
	d54 :=UnicodeLib.UnicodeFindReplace(d53,u' DE J Y ' ,u' DE JESUS Y ');
	d55 :=UnicodeLib.UnicodeFindReplace(d54,u' DE J ' ,u' DE JESUS ');
	d56 :=UnicodeLib.UnicodeFindReplace(d55,u'GPE ' ,u'GUADALUPE ');
	d57 :=UnicodeLib.UnicodeFindReplace(d56,u'MTZ ' ,u'MARTINEZ ');
	d58 :=UnicodeLib.UnicodeFindReplace(d57,u'HDEZ ' ,u'HERNANDEZ ');
	d59 :=UnicodeLib.UnicodeFindReplace(d58,u' STA ' ,u' SANTA ');
	d60 :=UnicodeLib.UnicodeFindReplace(d59,u' DE G ' ,u' DE GUADALUPE ');
	d61 :=UnicodeLib.UnicodeFindReplace(d60,u' SC ' ,u' SAGRADO CORAZON ');
	d62 :=UnicodeLib.UnicodeFindReplace(d61,u' S C ' ,u' SAGRADO CORAZON ');
	d63 :=UnicodeLib.UnicodeFindReplace(d62,u'FCO ' ,u'FRANCISCO ');
	d64 :=UnicodeLib.UnicodeFindReplace(d63,u'‘' ,u'');
	d65 :=UnicodeLib.UnicodeFindReplace(d64,u' - ' ,u'-');
	d66 :=UnicodeLib.UnicodeFindReplace(d65,u'- ' ,u'-');
	d67 :=UnicodeLib.UnicodeFindReplace(d66,u'--' ,u'-');
	d68 :=UnicodeLib.UnicodeFindReplace(d67,u'D\' A' ,u'D\'A');
	d69 :=UnicodeLib.UnicodeFindReplace(d68,u' M DEL ',u' MARIA DEL ');
	d70 :=UnicodeLib.UnicodeFindReplace(d69,u' M DE ' ,u' MARIA DE ');
	d71 :=UnicodeLib.UnicodeFindReplace(d70,u' DELA ' ,u' DE LA ');
		d72 :=UnicodeLib.UnicodeFindReplace(d71,u'MA-DE ' ,u'MARIA DE ');
		d73 :=UnicodeLib.UnicodeFindReplace(d72,u'MA-DEL ' ,u'MARIA DEL ');
//		d74 :=UnicodeLib.UnicodeFindReplace(d73,u'COMO REPRESENTANTE DEL MENOR' ,u'');
				d74 :=UnicodeLib.UnicodeFindReplace(d73,u'WIDOW OF WIDOW OF' ,u'WIDOW OF');
				d75 :=UnicodeLib.UnicodeFindReplace(d74,u' DE WIDOW OF' ,u' WIDOW OF');
				d76 :=UnicodeLib.UnicodeFindReplace(d75,u'MIGUEL OR MOGUEL' ,u'MIGUEL');
				d77 :=UnicodeLib.UnicodeFindReplace(d76,u'STEVE OR ESTEVE OR ESTEVEZ' ,u'ESTEVEZ');
				d78 :=UnicodeLib.UnicodeFindReplace(d77,u'LLOERA OR LOERA' ,u'LLOERA');
				d79 :=UnicodeLib.UnicodeFindReplace(d78,u'HAYDEE OR AIDEE OR HAIDEE' ,u'AIDEE');
				d80 :=UnicodeLib.UnicodeFindReplace(d79,u'ALVAREZ OR ALAVEZ' ,u'ALVAREZ');				
				d81 :=UnicodeLib.UnicodeFindReplace(d80,u'ISAAC OR ISAC',u'ISAAC');
				d82 :=UnicodeLib.UnicodeFindReplace(d81,u'ELIEZER OR ELIER',u'ELIEZER');
				d83 :=UnicodeLib.UnicodeFindReplace(d82,u'JONATHAN OR JHONATHAN',u'JONATHAN');
				d84 :=UnicodeLib.UnicodeFindReplace(d83,u'WILLIAM OR WILLIAN',u'WILLIAM');
				d85 :=UnicodeLib.UnicodeFindReplace(d84,u'CITLALI OR CITALLI',u'CITLALLI');
				d86 :=UnicodeLib.UnicodeFindReplace(d85,u'CINDY OR SINDY',u'CINDY');
				d87 :=UnicodeLib.UnicodeFindReplace(d86,u'STEPHANIE OR ESTEPHANIE',u'STEPHANIE');
				d88 :=UnicodeLib.UnicodeFindReplace(d87,u'ELIZABETH OR ELIZABETH',u'ELIZABETH');                 
				d89 :=UnicodeLib.UnicodeFindReplace(d88,u'JOHNNY OR JHONY',u'JOHNNY');
				d90 :=UnicodeLib.UnicodeFindReplace(d89,u'CECILIA OR CESILIA',u'CECELIA');
				d91 :=UnicodeLib.UnicodeFindReplace(d90,u'ADRIANA OR ARIADNA',u'ADRIANA');
				d92 :=UnicodeLib.UnicodeFindReplace(d91,u'ELEAZAR OR ELEZAR',u'ELEAZAR');
				d93 :=UnicodeLib.UnicodeFindReplace(d92,u'OF THE LIGHT',u'DE LA LUZ');
				d94 :=UnicodeLib.UnicodeFindReplace(d93,u'NATHANEL OR NATHAEL OR NATHANIE',u'NATHANIEL');
				d95 :=UnicodeLib.UnicodeFindReplace(d94,u'HERBERTO OR HERIBE',u'HERBERTO');	 
				d96 :=UnicodeLib.UnicodeFindReplace(d95,u'VALDEZ OR VALADEZ',u'VALDEZ');	 
				d97 :=UnicodeLib.UnicodeFindReplace(d96,u'ALEJANDRO OR ALEXANDRO',u'ALEJANDRO');	
				d98 :=UnicodeLib.UnicodeFindReplace(d97,u'HERNANDEZ OR HERANDEZ',u'HERNANDEZ');                             
				d99 :=UnicodeLib.UnicodeFindReplace(d98,u'CARDENAS OR CARDENAZ',u'CARDENAS');                              
				d100 :=UnicodeLib.UnicodeFindReplace(d99,u'BOLAÑOS OR BOLANOZ',u'BOLAÑOS');                                
				d101 :=UnicodeLib.UnicodeFindReplace(d100,u'ALVEAR OR ALBEAR',u'ALVEAR');                         
				d102 :=UnicodeLib.UnicodeFindReplace(d101,u'ZUÑIGA OR SUÑIGA',u'ZUÑIGA');
				d103 :=UnicodeLib.UnicodeFindReplace(d102,u'AVENDAÑO OR ABENDAÑO',u'AVENDAÑO');                              
				d104 :=UnicodeLib.UnicodeFindReplace(d103,u'JENNIFER OR JENIFER',u'JENNIFER');
				d105 :=UnicodeLib.UnicodeFindReplace(d104,u'JENNY OR JEENY',u'JENNY');				
   			d106 :=UnicodeLib.UnicodeFindReplace(d105,u'JIM NEZ',u'JIMINEZ');	
				d107 :=UnicodeLib.UnicodeFindReplace(d106,u'DOM NGUEZ',u'DOMINGUEZ');	                      
				d108 :=UnicodeLib.UnicodeFindReplace(d107,u'DOLOR ES ',u'DOLORES ');	
				d109 :=UnicodeLib.UnicodeFindReplace(d108,u'GUADALU PE ',u'GUADALUPE ');	
				d110 :=UnicodeLib.UnicodeFindReplace(d109,u'CARM EN ',u'CARMEN ');	
				d111 :=UnicodeLib.UnicodeFindReplace(d110,u'CONCEPC ION ',u'CONCEPCION ');	
				d112 :=UnicodeLib.UnicodeFindReplace(d111,u'DE L OS ',u'DE LOS ');	
				d113 :=UnicodeLib.UnicodeFindReplace(d112,u'CARL OS ',u'CARLOS ');	
				d114 :=UnicodeLib.UnicodeFindReplace(d113,u'DEL OS ',u'DE LOS ');	
				d115 :=UnicodeLib.UnicodeFindReplace(d114,u'DE OS ',u'DE LOS ');	
				d116 :=UnicodeLib.UnicodeFindReplace(d115,u'ME DINA ',u'MEDINA ');	
				d117 :=UnicodeLib.UnicodeFindReplace(d116,u'PER EZ',u'PEREZ');	
				d118 :=UnicodeLib.UnicodeFindReplace(d117,u' VDA ',u' WIDOW OF ');	
				d119 :=UnicodeLib.UnicodeFindReplace(d118,u' VIUDA ',u' WIDOW OF ');	
				d120 :=UnicodeLib.UnicodeFindReplace(d119,u' DEL CARME ',u' DEL CARMEN ');	
				d121 :=UnicodeLib.UnicodeFindReplace(d120,u' VEZ ',u' VALDEZ ');	
				d122 :=UnicodeLib.UnicodeFindReplace(d121,u'NO LEGIBILE',u'ILLEGIBLE');	
				d123 :=UnicodeLib.UnicodeFindReplace(d122,u'AL MA ',u'ALMA ');	
				d124 :=UnicodeLib.UnicodeFindReplace(d123,u' MORAL ES',u' MORALES');
				d125 :=UnicodeLib.UnicodeFindReplace(d124,u'PANAME RICANA',u'PANAMERICANA');
				d126 :=UnicodeLib.UnicodeFindReplace(d125,u'PA NAMERICANA',u'PANAMERICANA');
				d127 :=UnicodeLib.UnicodeFindReplace(d126,u' NOW IN THE NAME OF ',u' AND ');
				d128 := IF(d127=u'LIC',u'',d127);
				d130 :=UnicodeLib.UnicodeFindReplace(d128,u'ESTATE OF',u'');
				d131 :=UnicodeLib.UnicodeFindReplace(d130,u'IN ESTATE OF',u'');
				d132 :=UnicodeLib.UnicodeFindReplace(d131,u'ESTATES OF',u'');
				d133 :=UnicodeLib.UnicodeFindReplace(d132,u'DE LA ESTATE DE ',u' ');			
				d134 :=UnicodeLib.UnicodeFindReplace(d133,u'ESTATE DEL ',u' ');
				d135 :=UnicodeLib.UnicodeFindReplace(d134,u'ESTATE DE LA ',u' ');			
				d136 :=UnicodeLib.UnicodeFindReplace(d135,u'ESTATE DE LOS ',u' ');			
				d137 :=UnicodeLib.UnicodeFindReplace(d136,u'ESTATE DE ',u' ');			
				d138 :=UnicodeLib.UnicodeFindReplace(d137,u'ESTATE ASSETS OF',u'');
				d139 :=UnicodeLib.UnicodeFindReplace(d138,u'AS EXECUTOR ESTATE',u'');
				d140 :=UnicodeLib.UnicodeFindReplace(d139,u'AS EXECUTOR OF ESTATE',u'');
				d141 :=UnicodeLib.UnicodeFindReplace(d140,u'IN RE ESTATE',u'');


			
				removestr :=u'('
										+ u'NAME WITHHELD AND|NAME WITHHELD|NAMES WITHHELD|NAME NOT DISLOSED|NAME WITHHHELD|NAME WITHELD|PARTIES NOT NAMED|AND NAME WITHELD|UNKNOWN PARTY' 
										+ u'|BUSINESS NAMED|OTHER NAME NOT KNOWN|LAST NAME NOT CITED|OTHER NAMES NOT CITED|BUSINESS NAME' 
										+	u'|LAST NAME NOT CITED|NO LAST NAME|LAST NAME NOT GIVEN|LENDERS NOT NAMED|AND PARTY NOT NAMED|PARTY NOT NAMED' 
										+ u'|AND UNDISCLOSED PARTY|VS UNDISCLOSED PARTY|UNSPECIFIED ESTATE|AND UNDISCLOSED|VS UNDISCLOSED|V S UNDISCLOSED'
										+ u'|V UNDISCLOSED|UNDISCLOSED|NOT NAMED|LAST NAME UNKNOWN|ET AL WITH FAMILY NAME|OF FAMILY NAME|WITH FAMILY NAME'
										+ u'|OF LAST NAME'
										+ u')';
											
				rmvd := REGEXREPLACE(removestr,d141, u'');
	
				

				// d139 :=IF(d138[1..6]=u'ESTATE',d138[7..length(d138)],d138);
				// d140 :=IF(d139[length(d139)-6..length(d139)]=u'ESTATE',d139[1..(length(d139)-6)],d139);
				final := UnicodeLib.UnicodeCleanSpaces(rmvd);
				
	return final;
END;