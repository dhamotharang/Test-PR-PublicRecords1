import business_header, business_header_ss, corp, did_add, dnb_dmi, dca, ut,address;

dfrec := record
	string7   Company_ID;
	string100 Company_Name;
	string50  Address_1;
	string50  Address_2;
	string14  Phone;
	string31  City;
	string2   State;
	string19  Start_Date;
	string27  Industry_Class;
	string24  Product;
	string3   Users;
	string12  Jan;
	string12  Feb;
	string12  Mar;
	string12  Apr;
	string12  May;
	string12  Jun;
	string12  Jul;
	string12  Aug;
	string12  Sep;
	string12  Oct;
	string12  Nov;
	string12  Dec;
	string12  Jan1;
	string13  Feb1;
	string12  Mar1;
	string12  Apr1;
	string14  May1;
	string1   lf;	
end;

df := dataset('~thor_data400::in::jncompany_info_20050810',dfrec,flat);

seqrec := record
	string7   Company_ID;
	string100 Company_Name;
	string50  Address_1;
	string50  Address_2;
	string14  Phone;
	string31  City;
	string2   State;
	string19  Start_Date;
	string27  Industry_Class;
	string24  Product;
	string3   Users;
	string12  Jan;
	string12  Feb;
	string12  Mar;
	string12  Apr;
	string12  May;
	string12  Jun;
	string12  Jul;
	string12  Aug;
	string12  Sep;
	string12  Oct;
	string12  Nov;
	string12  Dec;
	string12  Jan1;
	string13  Feb1;
	string12  Mar1;
	string12  Apr1;
	string14  May1;
	unsigned4	seq;
	string182	clean_address;
end;

seqrec into_seq(df L, integer C) := transform
	self.company_id := stringlib.stringfilterout(L.company_id,'\n\r');
	self.company_name := stringlib.stringfilterout(L.company_name,'\n\r');
	self.address_1 := stringlib.stringfilterout(L.address_1,'\n\r');
	self.address_2 := stringlib.stringfilterout(L.address_2,'\n\r');
	self.phone := stringlib.stringfilterout(L.phone,'\n\r');
	self.city := stringlib.stringfilterout(L.city,'\n\r');
	self.state := stringlib.stringfilterout(L.state,'\n\r');
	self.start_date := stringlib.stringfilterout(L.start_date,'\n\r');
	self.industry_class := stringlib.stringfilterout(L.industry_class,'\n\r');
	self.product := stringlib.stringfilterout(L.product,'\n\r');
	self.users := stringlib.stringfilterout(L.users,'\n\r');
	self.jan := stringlib.stringfilterout(L.jan,'\n\r');
	self.feb := stringlib.stringfilterout(L.feb,'\n\r');
	self.mar := stringlib.stringfilterout(L.mar,'\n\r');
	self.apr := stringlib.stringfilterout(L.apr,'\n\r');
	self.may := stringlib.stringfilterout(L.may,'\n\r');
	self.jun := stringlib.stringfilterout(L.jun,'\n\r');
	self.jul := stringlib.stringfilterout(L.jul,'\n\r');
	self.aug := stringlib.stringfilterout(L.aug,'\n\r');
	self.sep := stringlib.stringfilterout(L.sep,'\n\r');
	self.oct := stringlib.stringfilterout(L.oct,'\n\r');
	self.nov := stringlib.stringfilterout(L.nov,'\n\r');
	self.dec := stringlib.stringfilterout(L.dec,'\n\r');
	self.jan1 := stringlib.stringfilterout(L.jan1,'\n\r');
	self.feb1 := stringlib.stringfilterout(L.feb1,'\n\r');
	self.mar1 := stringlib.stringfilterout(L.mar1,'\n\r');
	self.apr1 := stringlib.stringfilterout(L.apr1,'\n\r');
	self.may1 := stringlib.stringfilterout(L.may1,'\n\r');
	self.seq := C;
	self.clean_address := address.cleanaddress182(L.address_1 + ' ' + L.address_2, L.city + ' ' + L.state);
end;

df2 := project(df,into_seq(LEFT,COUNTER));

business_header_ss.Layout_BDID_InBatch into_slim(df2 L) := transform
	self.prim_range := L.clean_address[1..10];
	self.predir 	:= L.clean_address[11..12];
	self.prim_name	:= L.clean_address[13..40];
	self.addr_suffix := l.clean_address[41..44];
	self.postdir 	:= L.clean_address[45..46];
	self.unit_desig := L.clean_address[47..56];
	self.sec_range := L.clean_address[57..64];
	self.p_city_name := l.clean_address[90..114];
	self.st := l.clean_address[115..116];
	self.z5 := L.clean_address[117..121];
	self.zip4 := L.clean_address[122..125];
	self.phone10 := stringlib.stringfilter(L.phone,'0123456789');
	self.company_name := stringlib.stringtouppercase(L.company_name);
	self.seq := L.seq;
	self.fein := '';
end;

df3 := project(df2,into_slim(LEFT));

business_header.mac_BDID_Roxie(df3,wbdid)

dnbfile := dnb_dmi.Files().Base.companies.qa;

slimrec2 := record
	unsigned6	bdid;
	unsigned1	score;
	unsigned4	seq;
	string4	DNB_StartYear := '';
	string8	DNB_StartDate := '';
	string8	Corp_StartDate := '';
	string10	DNB_NumEmployees := '';
	string10	DCA_NumEmployees := '';
end;

slimrec2 into_slimout(wBDID L) := transform
	self := L;
end;

slimout := project(wBDID, into_slimout(LEFT));

slimrec2 get_from_DNB(slimout L, dnbfile R) := transform
	self.DNB_StartYear := R.rawfields.year_started;
	self.DNB_StartDate := R.rawfields.date_of_incorporation;
	self.DNB_NumEmployees := R.rawfields.employees_total;
	self := L;
end;

wDNB := join(distribute(slimout,hash(bdid)), 
		   distribute(dnbfile(bdid != 0), hash(bdid)), 
				left.bdid = right.bdid,
		   get_from_DNB(LEFT,RIGHT),
		   left outer, local);


wDNB roll_DNB(wDNB L, wDNB R) := transform
	self.dnb_startyear := if (l.dnb_startyear = '', R.dnb_startyear, L.dnb_startyear);
	self.dnb_startdate := if (L.dnb_startdate = '', R.dnb_startdate, L.dnb_startdate);
	self.dnb_numEmployees := if (L.dnb_NumEmployees = '', R.dnb_NumEmployees, L.dnb_NumEmployees);
	self := L;
end;

wDNB_Roll := rollup(group(sort(wDNB,seq,-dnb_startyear, -dnb_startdate, -dnb_numEmployees),seq), true, 
			roll_DNB(LEFT,RIGHT));
			
cpfile := corp.File_Corp_Base;

slimrec2 get_from_Corp(wDNB_ROLL L, cpfile R) := transform
	self.corp_StartDate := R.corp_inc_Date;
	self := L;
end;

wCorp := join(distribute(wDNB_Roll, hash (bdid)),
		    distribute(cpfile(bdid != 0), hash(bdid)),
				left.bdid = right.bdid,
			get_from_Corp(LEFT,RIGHT),
			left outer, local);

wCorp Roll_Corp(wCorp L, wCorp R) := transform
	self.corp_startdate := if (L.corp_startDate = '', R.corp_startdate, L.corp_Startdate);
	self := l;
end;

wcorp_Roll := rollup(group(sort(wCorp, seq, -corp_startdate),seq),true, roll_corp(LEFT,rIGHT));

dcafile := dca.File_DCA_Base;

slimrec2 get_from_DCA(wCorp_Roll L, dcafile R) := transform
	self.DCA_NumEmployees := R.EMP_Num;
	self := L;
end;

wDCA := join(distribute(wCorp_Roll,hash(bdid)), 
			  distribute(dcafile(bdid != 0), hash(bdid)),
					left.bdid = right.bdid,
			  get_from_DCA(LEFT,RIGHT),
			  left outer, local);

wDCA roll_DCA(wDCA L, wDCA R) := transform
	self.DCA_NumEmployees := if (L.dca_numEmployees = '', R.dca_numEmployees, L.dca_NumEmployees);
	self := L;
end;

outf1 := rollup(group(sort(wDCA, seq, -dca_numemployees),seq),true,roll_dca(LEFT,RIGHT));

my_outrec := record
	string12	seq;
	string12	bdid;
	string3	score;
	string7   Company_ID;
	string100 Company_Name;
	string50  Address_1;
	string50  Address_2;
	string14  Phone;
	string31  City;
	string2   State;
	string19  Start_Date;
	string27  Industry_Class;
	string24  Product;
	string3   Users;
	string12  Jan;
	string12  Feb;
	string12  Mar;
	string12  Apr;
	string12  May;
	string12  Jun;
	string12  Jul;
	string12  Aug;
	string12  Sep;
	string12  Oct;
	string12  Nov;
	string12  Dec;
	string12  Jan1;
	string13  Feb1;
	string12  Mar1;
	string12  Apr1;
	string14  May1;
	string4	DNB_StartYear := '';
	string8	DNB_StartDate := '';
	string8	Corp_StartDate := '';
	string10	DNB_NumEmployees := '';
	string10	DCA_NumEmployees := '';
end;

my_outrec into_out(outf1 L, df2 R) := transform
	self.seq := intformat(L.seq,12,1);
	self.bdid := intformat(L.bdid, 12 ,1);
	self.score := intformat(L.score, 3, 1);
	self := R;
	self := L;
end;

outfinal := join(outf1, 
		    df2,
				left.seq = right.seq,
		    into_out(LEFT,RIGHT),
		    hash);

output(outfinal,,'~thor_data400::out::FraudModel_Internal_' + thorlib.wuid(), csv(quote('"'), terminator('\n')));

nonamerec := record
	string12	seq;
	string12	bdid;
	string3	score;
	string7   Company_ID;
	//string100 Company_Name;
	string50  Address_1;
	string50  Address_2;
	string14  Phone;
	string31  City;
	string2   State;
	string19  Start_Date;
	string27  Industry_Class;
	string24  Product;
	string3   Users;
	string12  Jan;
	string12  Feb;
	string12  Mar;
	string12  Apr;
	string12  May;
	string12  Jun;
	string12  Jul;
	string12  Aug;
	string12  Sep;
	string12  Oct;
	string12  Nov;
	string12  Dec;
	string12  Jan1;
	string13  Feb1;
	string12  Mar1;
	string12  Apr1;
	string14  May1;
	string4	DNB_StartYear := '';
	string8	DNB_StartDate := '';
	string8	Corp_StartDate := '';
	string10	DNB_NumEmployees := '';
	string10	DCA_NumEmployees := '';
end;

outfinal2 := project(outfinal, transform(nonamerec, self := Left));
output(outfinal2,,'~thor_Data400::out::FraudModel_Internal_NoName_' + thorlib.wuid(), csv(quote('"'), terminator('\n')));
output((count(outfinal((integer)bdid != 0))/count(outfinal)) * 100);
