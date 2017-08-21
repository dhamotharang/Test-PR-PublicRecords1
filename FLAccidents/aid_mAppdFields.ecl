////////////////////////////////////////////////////////////////////////////////////////
//Macro: Append Prep Address Fields
////////////////////////////////////////////////////////////////////////////////////////
export aid_mAppdFields(infile,inStreet,incity,inState,inZip,outfile) := macro
#uniquename(tlayout)
#uniquename(tPreClean)
#uniquename(prep_city1)
#uniquename(prep_city)
#uniquename(tPreClean)
#uniquename(c_4token)
#uniquename(c_3token)
#uniquename(c_2token)
#uniquename(c_1token)
#uniquename(drvd_city)
#uniquename(prsd_city)

%tlayout% := record
string Append_Prep_Address1;
string Append_Prep_AddressLast;
unsigned8 rawaid := 0;
infile;
end;

%tlayout% %tPreClean%(infile pInput) := transform
string %prep_city1%:= if(stringlib.stringfilter(pInput.incity,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') != '',
					trim(
					regexreplace(' +',

					regexreplace(' BC ',
					regexreplace(' BCH',
					regexreplace(' BHC',
					regexreplace(' CLW',
					regexreplace(' CLWR',
					regexreplace(' CLWTR',
					regexreplace(' CRK',
					regexreplace(' CTY',
					regexreplace(' FTLAUDERDALE',
					regexreplace(' FTMYERS',
					regexreplace(' GDN',
					regexreplace(' GRDN',
					regexreplace(' GRDNS',
					regexreplace(' GRD',
					regexreplace(' GRDS',
					regexreplace(' GVILLE',
					regexreplace(' HBR',
					regexreplace(' HGHTS',
					regexreplace(' HGTS',
					regexreplace(' HLWD',
					regexreplace(' HMSTD',
					regexreplace(' JAX',
					regexreplace(' KEYWEST',
					regexreplace(' LAUD ',
					regexreplace(' LAUDERDL',
					regexreplace(' LK ',
					regexreplace(' LKS ',
					regexreplace(' LW ',
					regexreplace(' MAIMI',
					regexreplace(' MIAI ',
					regexreplace(' MIMAI ',
					regexreplace(' MAI ',
					regexreplace(' MAIM',
					regexreplace(' MAMI',
					regexreplace(' MIA ',
					regexreplace(' ORL ',

					
					stringlib.stringfilter(
						 stringlib.stringfindreplace(pInput.incity,'.',' ')
					,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ ')
																


					,' ORLANDO')
					,' MIAMI ')
					,' MIAMI ')
					,' MIAMI ')
					,' MIAMI')
					,' MIAMI')
					,' MIAMI')
					,' MIAMI ')
					,' LAKE WORTH ')
					,' LAKES ')
					,' LAKES ')
					,' LAUDERDALE')
					,' LAUDERDALE ')
					,' KEY WEST ')
					,' JACKSONVILLE ')
					,' HOMESTEAD ')
					,' HOLLYWOOD ')
					,' HEIGHTS ')
					,' HEIGHTS ')
					,' HARBOR ')
					,' GAINSVILLE ')
					,' GARDENS ')
					,' GARDENS ')
					,' GARDENS ')
					,' GARDENS ')
					,' GARDENS ')
					,' FT MYERS ')
					,' FT LAUDERDALE ')
					,' CITY ')
					,' CREEK ')
					,' CLEARWATER ')
					,' CLEARWATER ')
					,' CLEARWATER ')
					,' BEACH ')
					,' BEACH ')
					,' BEACH ')

					,' ')
					,left,right)
				,'BLANK');
				

										

string %prep_city%	:= 	trim(
					regexreplace(' ORALNDO',
					regexreplace(' ORLANOD',
					regexreplace(' ORLNADO',
					regexreplace(' PBG',
					regexreplace(' PENSACOAL',
					regexreplace(' PK ',
					regexreplace(' PNS ',
					regexreplace(' PRK',
					regexreplace(' PSL',
					regexreplace(' PT',
					regexreplace(' SPG',
					regexreplace(' SPGS',
					regexreplace(' SPRG',
					regexreplace(' SPRGS',
					regexreplace(' SPRS',
					regexreplace(' TMAPA',
					regexreplace(' TAMAP',
					regexreplace(' TLH',
					regexreplace(' TPA',
					regexreplace(' WPB',
										%prep_city1%
					,' WEST PALM BEACH ')
					,' TAMPA ')
					,' TAMPA ')
					,' TALLAHASSEE ')
					,' TAMPA ')
					,' SPRINGS ')
					,' SPRINGS ')
					,' SPRINGS ')
					,' SPRINGS ')
					,' SPRINGS ')
					,' PORT ')
					,' PORT ST LUCIE ')
					,' PARK ')
					,' PENSACOLA ')
					,' PARK ')
					,' PENSACOLA')
					,' PALM BEACH GARDENS ')
					,' ORLANDO ')
					,' ORLANDO ')
					,' ORLANDO '),left,right);				

self.Append_Prep_Address1 :=lib_StringLib.StringLib.StringToUpperCase(pInput.inStreet);
self.Append_Prep_AddressLast := lib_StringLib.StringLib.StringToUpperCase(trim(%prep_city%,left,right) + if(%prep_city% <> '',', ','')
																				  + trim(pInput.InState,left,right) 
																				  + ' '
																				  + trim(pInput.InZip,left,right)[1..5]);
self := pInput;
end;
outfile := project(infile,%tPreClean%(left));
endmacro;