import ut, aid, data_services,AID_Support;

export proc_buildaddressid (string filedate) := function

#constant(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);

//ds_pat_raw	:= dataset(ut.foreign_prod+'~thor_data400::in::patriot_file_raw', patriot.Layout_Patriot, flat);
ds_pat_raw	:= dataset('~thor_data400::in::patriot_file_raw', patriot.Layout_Patriot, flat);
ds_fse_raw	:= dataset(ut.foreign_prod+ 'thor_data400::in::patriot_file_fse_raw', patriot.Layout_Patriot, flat); 

ds_file			:= ds_pat_raw + ds_fse_raw;

us_st_ab_filter :=  ',AK |, AK |,AL |, AL |,AR |, AR |,AZ |, AZ |'+
					',CA |, CA |,CO |, CO |,CT |, CT |,DC |, DC |,DE |, DE |,FL |, FL |,GA |, GA |,HI |, HI |'+
					',IA |, IA |,ID |, ID |,IL |, IL |,IN |, IN |,KS |, KS |,KY |, KY |,LA |, LA |,MA |, MA |'+
					',MD |, MD |,ME |, ME |,MI |, MI |,MN |, MN |,MO |, MO |,MS |, MS |,MT |, MT |,NC |, NC |'+
					',ND |, ND |,NE |, NE |,NH |, NH |,NJ |, NJ |,NM |, NM |,NV |, NV |,NY |, NY |,OH |, OH |'+
					',OK |, OK |,OR |, OR |,PA |, PA |,RI |, RI |,SC |, SC |,SD |, SD |,TN |, TN |,TX |, TX |'+
					',UT |, UT |,VA |, VA |,VT |, VT |,WA |, WA |,WI |, WI |,WV |, WV |,WY |, WY ';

us_state_filter	:= 'ALABAMA|ALASKA|ARIZONA|ARKANSAS|CALIFORNIA|COLORADO|CONNECTICUT|'+
					'DELAWARE|FLORIDA|GEORGIA|HAWAII|IDAHO|ILLINOIS|INDIANA|IOWA|'+
					'KANSAS|KENTUCKY|LOUISIANA|MAINE|MARYLAND|MASSACHUSETTS|MICHIGAN|'+
					'MINNESOTA|MISSISSIPPI|MISSOURI|MONTANA|NEBRASKA|NEVADA|NEW HAMPSHIRE|'+
					'NEW JERSEY|NEW MEXICO|NEW YORK|NORTH CAROLINA|NORTH DAKOTA|OHIO|'+
					'OKLAHOMA|OREGON|PENNSYLVANIA|RHODE ISLAND|SOUTH CAROLINA|SOUTH DAKOTA|'+
					'TENNESSEE|TEXAS|UTAH|VERMONT|VIRGINIA|WASHINGTON|WEST VIRGINIA|'+
					'WISCONSIN|WYOMING';

us_filter		:= ds_file((regexfind(us_st_ab_filter, addr_1, 0)<>'' or
						regexfind(us_st_ab_filter, addr_2, 0)<>'' or
						regexfind(us_st_ab_filter, addr_3, 0)<>'' or
						regexfind(us_st_ab_filter, addr_4, 0)<>'' or
						regexfind(us_st_ab_filter, addr_5, 0)<>'' or
						regexfind(us_st_ab_filter, addr_6, 0)<>'' or
						regexfind(us_st_ab_filter, addr_7, 0)<>'' or
						regexfind(us_st_ab_filter, addr_8, 0)<>'' or
						regexfind(us_st_ab_filter, addr_9, 0)<>'' or
						regexfind(us_st_ab_filter, addr_10, 0)<>'' or
						regexfind(us_state_filter, StringLib.StringToUpperCase(addr_1), 0)<>'' or
						regexfind(us_state_filter, StringLib.StringToUpperCase(addr_2), 0)<>'' or
						regexfind(us_state_filter, StringLib.StringToUpperCase(addr_3), 0)<>'' or
						regexfind(us_state_filter, StringLib.StringToUpperCase(addr_4), 0)<>'' or
						regexfind(us_state_filter, StringLib.StringToUpperCase(addr_5), 0)<>'' or
						regexfind(us_state_filter, StringLib.StringToUpperCase(addr_6), 0)<>'' or
						regexfind(us_state_filter, StringLib.StringToUpperCase(addr_7), 0)<>'' or
						regexfind(us_state_filter, StringLib.StringToUpperCase(addr_8), 0)<>'' or
						regexfind(us_state_filter, StringLib.StringToUpperCase(addr_9), 0)<>'' or
						regexfind(us_state_filter, StringLib.StringToUpperCase(addr_10), 0)<>'' or
						regexfind('UNITED STATES|INTERNATIONAL', StringLib.StringToUpperCase(country), 0)<>'') and
						trim(StringLib.StringToUpperCase(country),left,right)<>'GEORGIA');

//US Records
total_us_records:= us_filter(~((regexfind(',DE |, DE ', addr_1, 0)<>'' and trim(country,left,right) = 'GERMANY') or
						(regexfind(',DE |, DE ', addr_2, 0)<>'' and trim(country,left,right) = 'GERMANY') or
						(regexfind(',DE |, DE ', addr_3, 0)<>'' and trim(country,left,right) = 'GERMANY') or
						(regexfind(',DE |, DE ', addr_4, 0)<>'' and trim(country,left,right) = 'GERMANY') or
						(regexfind(',DE |, DE ', addr_5, 0)<>'' and trim(country,left,right) = 'GERMANY') or
						(regexfind(',DE |, DE ', addr_6, 0)<>'' and trim(country,left,right) = 'GERMANY') or
						(regexfind(',DE |, DE ', addr_7, 0)<>'' and trim(country,left,right) = 'GERMANY') or
						(regexfind(',DE |, DE ', addr_8, 0)<>'' and trim(country,left,right) = 'GERMANY') or
						(regexfind(',DE |, DE ', addr_9, 0)<>'' and trim(country,left,right) = 'GERMANY') or
						(regexfind(',DE |, DE ', addr_10, 0)<>'' and trim(country,left,right) = 'GERMANY') or
						(regexfind(',IN |, IN ', addr_1, 0)<>'' and trim(country,left,right) = 'INDIA') or
						(regexfind(',IN |, IN ', addr_2, 0)<>'' and trim(country,left,right) = 'INDIA') or
						(regexfind(',IN |, IN ', addr_3, 0)<>'' and trim(country,left,right) = 'INDIA') or
						(regexfind(',IN |, IN ', addr_4, 0)<>'' and trim(country,left,right) = 'INDIA') or
						(regexfind(',IN |, IN ', addr_5, 0)<>'' and trim(country,left,right) = 'INDIA') or
						(regexfind(',IN |, IN ', addr_6, 0)<>'' and trim(country,left,right) = 'INDIA') or
						(regexfind(',IN |, IN ', addr_7, 0)<>'' and trim(country,left,right) = 'INDIA') or
						(regexfind(',IN |, IN ', addr_8, 0)<>'' and trim(country,left,right) = 'INDIA') or
						(regexfind(',IN |, IN ', addr_9, 0)<>'' and trim(country,left,right) = 'INDIA') or
						(regexfind(',IN |, IN ', addr_10, 0)<>'' and trim(country,left,right) = 'INDIA') or
						(regexfind(',CA |, CA ', addr_1, 0)<>'' and trim(country,left,right) = 'CANADA') or
						(regexfind(',CA |, CA ', addr_2, 0)<>'' and trim(country,left,right) = 'CANADA') or
						(regexfind(',CA |, CA ', addr_3, 0)<>'' and trim(country,left,right) = 'CANADA') or
						(regexfind(',CA |, CA ', addr_4, 0)<>'' and trim(country,left,right) = 'CANADA') or
						(regexfind(',CA |, CA ', addr_5, 0)<>'' and trim(country,left,right) = 'CANADA') or
						(regexfind(',CA |, CA ', addr_6, 0)<>'' and trim(country,left,right) = 'CANADA') or
						(regexfind(',CA |, CA ', addr_7, 0)<>'' and trim(country,left,right) = 'CANADA') or
						(regexfind(',CA |, CA ', addr_8, 0)<>'' and trim(country,left,right) = 'CANADA') or
						(regexfind(',CA |, CA ', addr_9, 0)<>'' and trim(country,left,right) = 'CANADA') or
						(regexfind(',CA |, CA ', addr_10, 0)<>'' and trim(country,left,right) = 'CANADA') or
						(regexfind(',TN |, TN ', addr_1, 0)<>'' and trim(country,left,right) = 'TUNISIA') or
						(regexfind(',TN |, TN ', addr_2, 0)<>'' and trim(country,left,right) = 'TUNISIA') or
						(regexfind(',TN |, TN ', addr_3, 0)<>'' and trim(country,left,right) = 'TUNISIA') or
						(regexfind(',TN |, TN ', addr_4, 0)<>'' and trim(country,left,right) = 'TUNISIA') or
						(regexfind(',TN |, TN ', addr_5, 0)<>'' and trim(country,left,right) = 'TUNISIA') or
						(regexfind(',TN |, TN ', addr_6, 0)<>'' and trim(country,left,right) = 'TUNISIA') or
						(regexfind(',TN |, TN ', addr_7, 0)<>'' and trim(country,left,right) = 'TUNISIA') or
						(regexfind(',TN |, TN ', addr_8, 0)<>'' and trim(country,left,right) = 'TUNISIA') or
						(regexfind(',TN |, TN ', addr_9, 0)<>'' and trim(country,left,right) = 'TUNISIA') or
						(regexfind(',TN |, TN ', addr_10, 0)<>'' and trim(country,left,right) = 'TUNISIA') or
						(regexfind('TIJUANA|MEXICO|MEXICAL|DUBAI|VENEZUELA|DEPARTAMENTO|HONDURA|COLOMBIA|BAJA|INCARCERATED|INMATE|BAGHDAD',StringLib.StringToUpperCase(addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10))) or

            (regexfind('ALBANIA|ALGERIA|ARGENTINA|SWEDEN|TAIWAN|CHINA|ARMENIA|AFGHANISTAN|BELGIUM|KANDAHAR|BRAZIL|BRITISH ',StringLib.StringToUpperCase(addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10))) or
            (regexfind('CAMEROON|CANADA|CORPORATION|COSTA RICA|CUBA|CZECH REPUBLIC|DOMINICAN REPUBLIC|EGYPT|GERMANY|EL SALVADOR',StringLib.StringToUpperCase(addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10))) or
						(regexfind('YUGOSLAV|FRANCE|RUSSIA|GREECE|BEIRUT|GUYANA|HAITI|HUNGARY|INDIA|INDONESIA|THAILAND|ISRAEL|ITALY|JORDAN|PERU|KENYA',StringLib.StringToUpperCase(addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10))) or
						(regexfind('KOREA|KUWAIT|JORDAN|LEBANON|AL KIFAH|MALTA|IRAN|NIGERIA|AL-QAIDA|ISLAMIC|UNITED KINGDOM|VIET NAM|ZURICH',StringLib.StringToUpperCase(addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10))) or
						(regexfind('UNITED ARAB EMIRATES|PAKISTAN|PANAMA|PERU|PHILIPPINES|DA	MASCUS|PERU|LIBERIA|NIGERIA|PAKISTAN|PANAMA|PHILIPPINES',StringLib.StringToUpperCase(addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10))) or
						(regexfind('POLAND|PUERTO RICO|LEBANON|SUDAN|SWITZERLAND|SYRIA|TAIWAN|TUNISIA|TURKEY|HONG KONG',StringLib.StringToUpperCase(addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10))) or
						(regexfind('BAHAMAS|BANGLADESH|CAMBODIA|ECUADOR|GHANA|GUYANA|KUWAIT|LEBANON|PORTUGAL|SUDAN|SURINAME|TUNISIA|UKRAINE',StringLib.StringToUpperCase(addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10))) or
						(regexfind('UNITED STATES|WWW|GRANDE STOCKYARDS',addr_1))
						));

//Foreign Records
non_us_filter	:= ds_file(~((regexfind(us_st_ab_filter, addr_1, 0)<>'' or
						regexfind(us_st_ab_filter, addr_2, 0)<>'' or
						regexfind(us_st_ab_filter, addr_3, 0)<>'' or
						regexfind(us_st_ab_filter, addr_4, 0)<>'' or
						regexfind(us_st_ab_filter, addr_5, 0)<>'' or
						regexfind(us_st_ab_filter, addr_6, 0)<>'' or
						regexfind(us_st_ab_filter, addr_7, 0)<>'' or
						regexfind(us_st_ab_filter, addr_8, 0)<>'' or
						regexfind(us_st_ab_filter, addr_9, 0)<>'' or
						regexfind(us_st_ab_filter, addr_10, 0)<>'' or
						regexfind(us_state_filter, StringLib.StringToUpperCase(addr_1), 0)<>'' or
						regexfind(us_state_filter, StringLib.StringToUpperCase(addr_2), 0)<>'' or
						regexfind(us_state_filter, StringLib.StringToUpperCase(addr_3), 0)<>'' or
						regexfind(us_state_filter, StringLib.StringToUpperCase(addr_4), 0)<>'' or
						regexfind(us_state_filter, StringLib.StringToUpperCase(addr_5), 0)<>'' or
						regexfind(us_state_filter, StringLib.StringToUpperCase(addr_6), 0)<>'' or
						regexfind(us_state_filter, StringLib.StringToUpperCase(addr_7), 0)<>'' or
						regexfind(us_state_filter, StringLib.StringToUpperCase(addr_8), 0)<>'' or
						regexfind(us_state_filter, StringLib.StringToUpperCase(addr_9), 0)<>'' or
						regexfind(us_state_filter, StringLib.StringToUpperCase(addr_10), 0)<>'' or
						regexfind('UNITED STATES|INTERNATIONAL', StringLib.StringToUpperCase(country), 0)<>'') and
						trim(StringLib.StringToUpperCase(country),left,right)<>'GEORGIA'));

add_foreign	:= us_filter((regexfind(',DE |, DE ', addr_1, 0)<>'' and trim(country,left,right) = 'GERMANY') or
						(regexfind(',DE |, DE ', addr_2, 0)<>'' and trim(country,left,right) = 'GERMANY') or
						(regexfind(',DE |, DE ', addr_3, 0)<>'' and trim(country,left,right) = 'GERMANY') or
						(regexfind(',DE |, DE ', addr_4, 0)<>'' and trim(country,left,right) = 'GERMANY') or
						(regexfind(',DE |, DE ', addr_5, 0)<>'' and trim(country,left,right) = 'GERMANY') or
						(regexfind(',DE |, DE ', addr_6, 0)<>'' and trim(country,left,right) = 'GERMANY') or
						(regexfind(',DE |, DE ', addr_7, 0)<>'' and trim(country,left,right) = 'GERMANY') or
						(regexfind(',DE |, DE ', addr_8, 0)<>'' and trim(country,left,right) = 'GERMANY') or
						(regexfind(',DE |, DE ', addr_9, 0)<>'' and trim(country,left,right) = 'GERMANY') or
						(regexfind(',DE |, DE ', addr_10, 0)<>'' and trim(country,left,right) = 'GERMANY') or
						(regexfind(',IN |, IN ', addr_1, 0)<>'' and trim(country,left,right) = 'INDIA') or
						(regexfind(',IN |, IN ', addr_2, 0)<>'' and trim(country,left,right) = 'INDIA') or
						(regexfind(',IN |, IN ', addr_3, 0)<>'' and trim(country,left,right) = 'INDIA') or
						(regexfind(',IN |, IN ', addr_4, 0)<>'' and trim(country,left,right) = 'INDIA') or
						(regexfind(',IN |, IN ', addr_5, 0)<>'' and trim(country,left,right) = 'INDIA') or
						(regexfind(',IN |, IN ', addr_6, 0)<>'' and trim(country,left,right) = 'INDIA') or
						(regexfind(',IN |, IN ', addr_7, 0)<>'' and trim(country,left,right) = 'INDIA') or
						(regexfind(',IN |, IN ', addr_8, 0)<>'' and trim(country,left,right) = 'INDIA') or
						(regexfind(',IN |, IN ', addr_9, 0)<>'' and trim(country,left,right) = 'INDIA') or
						(regexfind(',IN |, IN ', addr_10, 0)<>'' and trim(country,left,right) = 'INDIA') or
						(regexfind(',CA |, CA ', addr_1, 0)<>'' and trim(country,left,right) = 'CANADA') or
						(regexfind(',CA |, CA ', addr_2, 0)<>'' and trim(country,left,right) = 'CANADA') or
						(regexfind(',CA |, CA ', addr_3, 0)<>'' and trim(country,left,right) = 'CANADA') or
						(regexfind(',CA |, CA ', addr_4, 0)<>'' and trim(country,left,right) = 'CANADA') or
						(regexfind(',CA |, CA ', addr_5, 0)<>'' and trim(country,left,right) = 'CANADA') or
						(regexfind(',CA |, CA ', addr_6, 0)<>'' and trim(country,left,right) = 'CANADA') or
						(regexfind(',CA |, CA ', addr_7, 0)<>'' and trim(country,left,right) = 'CANADA') or
						(regexfind(',CA |, CA ', addr_8, 0)<>'' and trim(country,left,right) = 'CANADA') or
						(regexfind(',CA |, CA ', addr_9, 0)<>'' and trim(country,left,right) = 'CANADA') or
						(regexfind(',CA |, CA ', addr_10, 0)<>'' and trim(country,left,right) = 'CANADA') or
						(regexfind(',TN |, TN ', addr_1, 0)<>'' and trim(country,left,right) = 'TUNISIA') or
						(regexfind(',TN |, TN ', addr_2, 0)<>'' and trim(country,left,right) = 'TUNISIA') or
						(regexfind(',TN |, TN ', addr_3, 0)<>'' and trim(country,left,right) = 'TUNISIA') or
						(regexfind(',TN |, TN ', addr_4, 0)<>'' and trim(country,left,right) = 'TUNISIA') or
						(regexfind(',TN |, TN ', addr_5, 0)<>'' and trim(country,left,right) = 'TUNISIA') or
						(regexfind(',TN |, TN ', addr_6, 0)<>'' and trim(country,left,right) = 'TUNISIA') or
						(regexfind(',TN |, TN ', addr_7, 0)<>'' and trim(country,left,right) = 'TUNISIA') or
						(regexfind(',TN |, TN ', addr_8, 0)<>'' and trim(country,left,right) = 'TUNISIA') or
						(regexfind(',TN |, TN ', addr_9, 0)<>'' and trim(country,left,right) = 'TUNISIA') or
						(regexfind(',TN |, TN ', addr_10, 0)<>'' and trim(country,left,right) = 'TUNISIA') or
						(regexfind('TIJUANA|MEXICO|MEXICAL|DUBAI|VENEZUELA|DEPARTAMENTO|HONDURA|COLOMBIA|BAJA|INCARCERATED|INMATE|BAGHDAD',StringLib.StringToUpperCase(addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10))) or
 
            (regexfind('ALBANIA|ALGERIA|ARGENTINA|SWEDEN|TAIWAN|CHINA|ARMENIA|AFGHANISTAN|BELGIUM|KANDAHAR|BRAZIL|BRITISH ',StringLib.StringToUpperCase(addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10))) or
            (regexfind('CAMEROON|CANADA|CORPORATION|COSTA RICA|CUBA|CZECH REPUBLIC|DOMINICAN REPUBLIC|EGYPT|GERMANY|EL SALVADOR',StringLib.StringToUpperCase(addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10))) or
						(regexfind('YUGOSLAV|FRANCE|RUSSIA|GREECE|BEIRUT|GUYANA|HAITI|HUNGARY|INDIA|INDONESIA|THAILAND|ISRAEL|ITALY|JORDAN|PERU|KENYA',StringLib.StringToUpperCase(addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10))) or
						(regexfind('KOREA|KUWAIT|JORDAN|LEBANON|AL KIFAH|MALTA|IRAN|NIGERIA|AL-QAIDA|ISLAMIC|UNITED KINGDOM|VIET NAM|ZURICH',StringLib.StringToUpperCase(addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10))) or
						(regexfind('UNITED ARAB EMIRATES|PAKISTAN|PANAMA|PERU|PHILIPPINES|DA	MASCUS|PERU|LIBERIA|NIGERIA|PAKISTAN|PANAMA|PHILIPPINES',StringLib.StringToUpperCase(addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10))) or
						(regexfind('POLAND|PUERTO RICO|LEBANON|SUDAN|SWITZERLAND|SYRIA|TAIWAN|TUNISIA|TURKEY|HONG KONG',StringLib.StringToUpperCase(addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10))) or
						(regexfind('BAHAMAS|BANGLADESH|CAMBODIA|ECUADOR|GHANA|GUYANA|KUWAIT|LEBANON|PORTUGAL|SUDAN|SURINAME|TUNISIA|UKRAINE',StringLib.StringToUpperCase(addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10))) or
					  (regexfind('UNITED STATES|WWW|GRANDE STOCKYARDS',addr_1)) 
						);

total_foreign	:= non_us_filter + add_foreign;

//Apply AddressID Enhancement Only to Valid US Records				
	addressidLayout := record
		Patriot.Layout_Patriot;
		string120 append_prep_address1;
		string60  append_prep_addresslast;
		aid.common.xaid append_rawaid
	end;

	addressidLayout gwlTrans(total_us_records l):= transform
		
		additional_clean_up := '|AL AMIRAT STREET, SECTION 309, ST. 3/H.20, AL MANS|CURRENTLY INCARCERATED AT: INMATE NUMBER - 43799-4 24,|INMATE NUMBER #85993-279, CI ADAMS COUNTY, CORRECT IONAL INSTITUTION,|OFFICE OF COMMERICAL AFFAIRS ROYAL THAI EMBASSY|OFFICE OF THE REPRESENTATIVE T.R.N.C.|PHILIPS BUILDING';
		remove_usa_1 := regexreplace('\\(FORMERLY LOCATED AT\\)', regexreplace('UNITED STATES OF AMERICA|\\(UNITED STATES OF|UNITED STATES OF|UNITED STATES'+ additional_clean_up, StringLib.StringToUpperCase(trim(l.addr_1,left,right)), ''), '');
		remove_usa_2 := regexreplace('UNITED STATES OF AMERICA|UNITED STATES OF|UNITED STATES|OF AMERICA|AMERICA'+ additional_clean_up, StringLib.StringToUpperCase(trim(l.addr_2,left,right)), '');
		remove_usa_3 := regexreplace('UNITED STATES OF AMERICA|UNITED STATES|AMERICA \\(FORMER LOCATION\\)|\\(FORMER LOCATION\\)|OF AMERICA|AMERICA'+ additional_clean_up, StringLib.StringToUpperCase(trim(l.addr_3,left,right)), '');
		
		self.append_prep_address1 	:= if(regexfind('[0-9]+', StringLib.StringToUpperCase(remove_usa_1), 0)<>'' and regexfind('C/O', StringLib.StringToUpperCase(remove_usa_1), 0)='' and remove_usa_2<>'' and remove_usa_3<>'',
											StringLib.StringToUpperCase(remove_usa_1)+' '+StringLib.StringToUpperCase(remove_usa_2),
											if(regexfind('[0-9]+', StringLib.StringToUpperCase(remove_usa_1), 0)<>'' and regexfind('C/O', StringLib.StringToUpperCase(remove_usa_1), 0)='' and remove_usa_2<>'' and remove_usa_3='',
											StringLib.StringToUpperCase(remove_usa_1),
											if((regexfind('[0-9]+', StringLib.StringToUpperCase(remove_usa_1), 0)='' or regexfind('C/O', StringLib.StringToUpperCase(remove_usa_1), 0)<>'') and regexfind('[0-9]+', StringLib.StringToUpperCase(remove_usa_2), 0)<>'' and remove_usa_3<>'',
											StringLib.StringToUpperCase(remove_usa_2),
											'')));
		self.append_prep_addresslast := if(remove_usa_1<>'' and remove_usa_2<>'' and remove_usa_3<>'',
											StringLib.StringToUpperCase(remove_usa_3),
											if(regexfind('C/O', StringLib.StringToUpperCase(remove_usa_1), 0)='' and remove_usa_2<>'' and remove_usa_3='',
											StringLib.StringToUpperCase(remove_usa_2),
											''));
		self.append_rawaid 			:= 0;
		self 						:= l;
	end;

prepAddress := project(total_us_records, gwlTrans(left)) : persist('~thor_data400::persist::prep_addressid_patriot_file');

	unsigned4 lAIDAppendFlags		:= AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;			

	AID.MacAppendFromRaw_2Line(prepAddress, Append_Prep_Address1, append_prep_addresslast, Append_RawAID, addressCleaned, lAIDAppendFlags);

	patriotLayout := record
		Patriot.Layout_Patriot_addressid;
	end;
	
	patriotLayout addressAppended(addressCleaned pInput) := transform
		self.Append_RawAID		:= pInput.AIDWork_RawAID;
		self.aid_prim_range 	:= pInput.AIDWork_ACECache.prim_range;
		self.aid_predir 		:= pInput.AIDWork_ACECache.predir;
		self.aid_prim_name 		:= pInput.AIDWork_ACECache.prim_name;
		self.aid_addr_suffix 	:= pInput.AIDWork_ACECache.addr_suffix;
		self.aid_postdir 		:= pInput.AIDWork_ACECache.postdir;
		self.aid_unit_desig 	:= pInput.AIDWork_ACECache.unit_desig;
		self.aid_sec_range 		:= pInput.AIDWork_ACECache.sec_range;
		self.aid_p_city_name 	:= pInput.AIDWork_ACECache.p_city_name;
		self.aid_v_city_name 	:= pInput.AIDWork_ACECache.v_city_name;
		self.aid_st 			:= pInput.AIDWork_ACECache.st;
		self.aid_zip 			:= pInput.AIDWork_ACECache.zip5;
		self.aid_zip4 			:= pInput.AIDWork_ACECache.zip4;
		self.aid_cart 			:= pInput.AIDWork_ACECache.cart;
		self.aid_cr_sort_sz 	:= pInput.AIDWork_ACECache.cr_sort_sz;
		self.aid_lot 			:= pInput.AIDWork_ACECache.lot;
		self.aid_lot_order 		:= pInput.AIDWork_ACECache.lot_order;
		self.aid_dpbc 			:= pInput.AIDWork_ACECache.dbpc;
		self.aid_chk_digit 		:= pInput.AIDWork_ACECache.chk_digit;
		self.aid_record_type 	:= pInput.AIDWork_ACECache.rec_type;
		self.aid_fips_st 		:= pInput.AIDWork_ACECache.county[..2];
		self.aid_county 		:= pInput.AIDWork_ACECache.county[3..];
		self.aid_geo_lat 		:= pInput.AIDWork_ACECache.geo_lat;
		self.aid_geo_long 		:= pInput.AIDWork_ACECache.geo_long;
		self.aid_msa 			:= pInput.AIDWork_ACECache.msa;
		self.aid_geo_blk 		:= pInput.AIDWork_ACECache.geo_blk;
		self.aid_geo_match 		:= pInput.AIDWork_ACECache.geo_match;
		self.aid_err_stat 		:= pInput.AIDWork_ACECache.err_stat;
		self					:= pInput;
	end;
		
cleanAddress 	:= project(addressCleaned,addressAppended(left)) : persist('~thor_data400::persist::addressid_patriot_file');

//Collect Foreign Addresses
	patriotLayout noCleanAddr(total_foreign pInput):= transform
		self.Append_RawAID		:= 0;
		self.aid_prim_range 	:= '';
		self.aid_predir 		:= '';
		self.aid_prim_name 		:= '';
		self.aid_addr_suffix 	:= '';
		self.aid_postdir 		:= '';
		self.aid_unit_desig 	:= '';
		self.aid_sec_range 		:= '';
		self.aid_p_city_name 	:= '';
		self.aid_v_city_name 	:= '';
		self.aid_st 			:= '';
		self.aid_zip 			:= '';
		self.aid_zip4 			:= '';
		self.aid_cart 			:= '';
		self.aid_cr_sort_sz 	:= '';
		self.aid_lot 			:= '';
		self.aid_lot_order 		:= '';
		self.aid_dpbc 			:= '';
		self.aid_chk_digit 		:= '';
		self.aid_record_type 	:= '';
		self.aid_fips_st		:= '';
		self.aid_county 		:= '';
		self.aid_geo_lat 		:= '';
		self.aid_geo_long 		:= '';
		self.aid_msa 			:= '';
		self.aid_geo_blk 		:= '';
		self.aid_geo_match 		:= '';
		self.aid_err_stat 		:= '';
		self					:= pInput;
	end;

leftoverAddress := project(total_foreign, noCleanAddr(left));

//Concat All Records
all_recs 	:= cleanAddress + leftoverAddress;
build_all := output(all_recs,,'~thor_data400::in::patriot_file_'+filedate+'_addressid');							 

	RETURN build_all; 
end;