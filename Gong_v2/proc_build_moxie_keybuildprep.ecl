import Gong,lib_metaphone,lib_KeyLib,Address,ut;

#uniquename(keyPrepLayout)
#uniquename(appndKeyFields)
#uniquename(p_gongBuilding)
#uniquename(infile)

%infile% := Gong_v2.File_Base_Building_Indexes;

				
%keyPrepLayout% := record
Gong.layout_gong;
unsigned integer8 __filepos { virtual(fileposition)};
string60        addr:= '';		 
string3         area:= '';
//string13        cityd:= ''; 
string13        city:= ''; 
string       	cn:= '';
//string       	cn2:= '';		
string3         county:= '';
string12        latlong10:= '';
string12        latlong25:= '';
string60        lfmname:= '';
string60        lfmname2:= '';
string60        lfmname3:= '';
string60        lfmname4:= '';	
string12        _ln:= '';		
//string96		advMatch:='';
string93		indvNameMatch:= '';
string144		cnameMatch:= '';
string29        name:= '';
string54        neighbor:= '';
string          pcn:= '';
string5         pct:= '';
string5         pct2:= '';
string          phcn:= '';
string6         phln:= '';
string6         phln2:= '';
string7         phone7:= '';
string10        phone_h:= '';
string2         postdird:= '';
string10        pr:= '';
string2         predird:= '';
string5         pst:= '';
string5         pst2:= '';
string25        recid:= '';
string80        sortname:= '';
string12        st_named:= '';
string4         suffixd:= '';
string3         z3:= '';

end;



%keyPrepLayout% %appndKeyFields%(%infile% L) := transform

/* ------------------------------------------------------------------------------------------- */

#uniquename(isCompany)
#uniquename(isRes)

%isCompany%			:= L.listing_type_bus !='' or L.listing_type_gov !='';
%isRes%		        := L.listing_type_res !='';
real latitude 		:= (real) (L.geo_lat);
real longitude 		:= (real) (L.geo_long);
real milesperdegree := 3959.0 * (acos(sin(((real)L.geo_lat) / 57.296) * sin(((real)L.geo_lat) / 57.296) 
						+ cos(((real)L.geo_lat) / 57.296) * cos(((real)L.geo_lat) / 57.296) * cos(1.0 / 57.296)));
						
string6 lat25 		:= intformat((integer) ((latitude) * 69.098 / 25 + .5), 6, 1);
string6 long25 		:= intformat((integer) ((longitude + 180) * milesperdegree / 25 + 0.5), 6, 1);
string6 lat10 		:= intformat((integer) ((latitude) * 69.098 / 10 + .5), 6, 1);
string6 long10 		:= intformat((integer) ((longitude + 180) * milesperdegree / 10 + 0.5), 6, 1);
/* ------------------------------------------------------------------------------------------- */


self.addr			:= stringlib.stringtouppercase(trim(L.prim_range)+' '+
					   trim(L.predir)+' '+
					   trim(L.prim_name)+' '+
					   trim(L.suffix)+' '+
					   trim(L.postdir)+' '+
					   trim(L.unit_desig)+' '+
					   trim(L.sec_range));
self.area			:= L.phoneno[1..3];
//self.cityd			:= stringlib.stringtouppercase(L.p_city_name)[1..13]; derived in Gong_v2.proc_build_moxie_phoneKeys
self.cn				:= if(%isCompany%,keyLib.GongDacName(L.company_name+' '+L.caption_text),'');
//self.cn2			:= if(%isCompany%,keyLib.GongDacName(L.company_name+' '+L.caption_text),'');
self.county			:= stringlib.stringtouppercase(L.county_code)[3..5]; 
self.latlong10		:= lat10+long10;
self.latlong25		:= lat25+long25;
self.lfmname		:= if(regexfind('-',L.name_last)=false,map(%isres% => 
						stringlib.stringtouppercase(trim(L.name_last)+' '+ 
						trim(L.name_first)+' '+
						trim(L.name_middle)),stringlib.stringtouppercase(L.company_name)),'');
self.lfmname2		:= stringlib.stringfilterout(if(regexfind('-',L.name_last),
						map(%isRes% => 
							stringlib.stringtouppercase(trim(L.name_last)[1..stringlib.stringfind(L.name_last,'-',1)]+' '+ 
							trim(L.name_first)+' '+
							trim(L.name_middle)),stringlib.stringtouppercase(L.company_name)),''),'-');
							
self.lfmname3		:= stringlib.stringfilterout(if(regexfind('-',L.name_last),
						map(%isRes% => 
							stringlib.stringtouppercase(trim(L.name_last)[stringlib.stringfind(L.name_last,'-',1)..stringlib.stringfind(L.name_last,' ',1)]+' '+ 
							trim(L.name_first)+' '+
							trim(L.name_middle)),stringlib.stringtouppercase(L.company_name)),''),'-');
							
self.lfmname4		:= stringlib.stringfilterout(if(regexfind('-',L.name_last),
						map(%isRes% => 
							stringlib.stringtouppercase(regexreplace('-',trim(L.name_last),' ')+' '+ 
							trim(L.name_first)+' '+
							trim(L.name_middle)),stringlib.stringtouppercase(L.company_name)),''),'-');
self._ln			:= map(%isRes% and L.name_last[1..3] <> 'MAC' => stringlib.stringtouppercase(L.name_last),
							%isRes% and L.name_last[1..3] = 'MAC' => 'MC'+stringlib.stringtouppercase(L.name_last)[4..14],'');		
self.name			:= map(%isRes% => stringlib.stringtouppercase(L.name_first[1..11]+L.name_middle[1..6]+L.name_last[1..12]),stringlib.stringtouppercase(L.company_name));
self.neighbor		:= stringlib.stringtouppercase(L.prim_name
					  +L.suffix
					  +L.predir
					  +L.postdir
					  +L.prim_range
					  +L.sec_range);

self.pcn			:= if(%isCompany%,keyLib.GongDaphcName(L.company_name+' '+L.caption_text),'');
self.pct    		:= lib_metaphone.MetaphoneLib.DMetaphone1(L.p_city_name);
self.pct2   		:= lib_metaphone.MetaphoneLib.DMetaphone2(L.p_city_name);
self.phcn   		:= map(%isCompany% => '',lib_keyLib.KeyLib.GongCompName(L.company_name+' '+L.caption_text));
self.phln   		:= map(%isRes% => lib_metaphone.MetaphoneLib.DMetaphone1(L.name_last),'');
self.phln2   		:= map(%isRes% => lib_metaphone.MetaphoneLib.DMetaphone2(L.name_last),'');
self.phone7			:= L.phoneno[4..10];
self.phone_h		:= L.phoneno;
self.phoneno		:= map(L.publish_code != 'N' => L.phoneno,'');
self.pr				:= L.prim_range;
self.pst    		:= lib_metaphone.MetaphoneLib.DMetaphone1(L.prim_name);
self.pst2    		:= lib_metaphone.MetaphoneLib.DMetaphone2(L.prim_name);
self.recid			:= L.bell_id+L.filedate+L.dual_name_flag+L.sequence_number;
self.sortname		:= //regexreplace(
					   stringlib.stringtouppercase(trim(L.company_name)+' '+
					   trim(L.group_id)+' '+
					   trim(L.group_seq)+' '+
					   trim(L.prim_range)+' '+
					   trim(L.prim_name)+' '+
					   trim(L.caption_text));
					   //,'[ ]+', '');
self.st_named		:= stringlib.stringtouppercase(L.prim_name)[1..12];//because of normalize it becomes st_named
self.z3				:= L.z5[1..3];
// Population of this field was moved into the following attributes -- Gong_v2.proc_build_moxie_phoneKeys and Gong_v2.proc_build_moxie_phoneticKeys
//	names.name_suffix.prim_range.predir.st_name.sec_range.city.st.z5.phone
// self.advMatch		:= self.name+
						// stringlib.stringtouppercase(L.name_suffix)+
						// L.prim_range+
						// stringlib.stringtouppercase(L.predir)+
						// self.st_named+
						// L.sec_range+
						// stringlib.stringtouppercase(L.p_city_name)[1..13]+
						// stringlib.stringtouppercase(L.st)+
						// L.z5+
						// L.phoneno;
//prim_range.predird.st_named.postdird.listing_type_bus.listing_type_gov.pubnonpub.sortname.phoneno.bell_id.group_id.group_seq.style_code.indent_code
self.cnameMatch 		:=  
						stringlib.stringtouppercase(L.prim_range+
						L.predir+ //because of normalize it becomes predird
						self.st_named+ 
						L.postdir+ //because of normalize it becomes postdird
						L.listing_type_bus+
						L.listing_type_gov+
						L.publish_code+ //same as pubnonpub
						self.sortname+
						L.phoneno+
						L.bell_id+
						L.group_id+
						L.group_seq+
						L.style_code+
						L.indent_code);
//fn.prim_range.predird.st_named.postdird.ln.phoneno.bell_id.group_id.group_seq.style_code.indent_code.mn
self.indvNameMatch		:= map 
					   (%isRes% => stringlib.stringtouppercase(L.name_first)[1..10]+ //fn
						stringlib.stringtouppercase(L.prim_range)+
						stringlib.stringtouppercase(L.predir)+ //because of normalize it becomes predird
						self.st_named+ 
						stringlib.stringtouppercase(L.postdir)+ //because of normalize it becomes postdird
						self._ln+
						L.phoneno+
						L.bell_id+
						L.group_id+
						L.group_seq+
						L.style_code+
						L.indent_code+
						stringlib.stringtouppercase(L.name_middle)[1..10]//mn
						,'');

self 				:= L;
end;

%p_gongBuilding% := project(%infile%,%appndKeyFields%(left)): persist('~thor_200::persist::gong::moxie::keybuildprep');

export proc_build_moxie_keybuildprep:= %p_gongBuilding%;

