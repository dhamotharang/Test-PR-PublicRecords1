
import ut, aid, data_services,AID_Support,PromoteSupers,RoxieKeyBuild,prte2,address,header, prte2, std;

export proc_build_base(string filedate) := function

#constant(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);

PRTE2.CleanFields(files.GWL_IN_2, ds_file);

filter_recs_boca 	:= ds_file(cust_name <> 'IN_PR');
filter_recs_alpha := ds_file(cust_name = 'IN_PR');

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

us_filter		:= filter_recs_boca((regexfind(us_st_ab_filter, addr_1, 0)<>'' or
						regexfind(us_st_ab_filter, addr_2, 0)<>'' or
						regexfind(us_st_ab_filter, addr_3, 0)<>'' or
						regexfind(us_st_ab_filter, addr_4, 0)<>'' or
						regexfind(us_st_ab_filter, addr_5, 0)<>'' or
						regexfind(us_st_ab_filter, addr_6, 0)<>'' or
						regexfind(us_st_ab_filter, addr_7, 0)<>'' or
						regexfind(us_st_ab_filter, addr_8, 0)<>'' or
						regexfind(us_st_ab_filter, addr_9, 0)<>'' or
						regexfind(us_st_ab_filter, addr_10, 0)<>'' or
						regexfind(us_state_filter, addr_1, 0)<>'' or
						regexfind(us_state_filter, addr_2, 0)<>'' or
						regexfind(us_state_filter, addr_3, 0)<>'' or
						regexfind(us_state_filter, addr_4, 0)<>'' or
						regexfind(us_state_filter, addr_5, 0)<>'' or
						regexfind(us_state_filter, addr_6, 0)<>'' or
						regexfind(us_state_filter, addr_7, 0)<>'' or
						regexfind(us_state_filter, addr_8, 0)<>'' or
						regexfind(us_state_filter, addr_9, 0)<>'' or
						regexfind(us_state_filter, addr_10, 0)<>'' or
						regexfind('UNITED STATES|INTERNATIONAL', country, 0)<>'') and
						trim(country,left,right)<>'GEORGIA');

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
						(regexfind('TIJUANA|MEXICO|MEXICAL|DUBAI|VENEZUELA|DEPARTAMENTO|HONDURA|COLOMBIA|BAJA|INCARCERATED|INMATE|BAGHDAD',addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10)) or

            (regexfind('ALBANIA|ALGERIA|ARGENTINA|SWEDEN|TAIWAN|CHINA|ARMENIA|AFGHANISTAN|BELGIUM|KANDAHAR|BRAZIL|BRITISH ',addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10)) or
            (regexfind('CAMEROON|CANADA|CORPORATION|COSTA RICA|CUBA|CZECH REPUBLIC|DOMINICAN REPUBLIC|EGYPT|GERMANY|EL SALVADOR',addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10)) or
						(regexfind('YUGOSLAV|FRANCE|RUSSIA|GREECE|BEIRUT|GUYANA|HAITI|HUNGARY|INDIA|INDONESIA|THAILAND|ISRAEL|ITALY|JORDAN|PERU|KENYA',addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10)) or
						(regexfind('KOREA|KUWAIT|JORDAN|LEBANON|AL KIFAH|MALTA|IRAN|NIGERIA|AL-QAIDA|ISLAMIC|UNITED KINGDOM|VIET NAM|ZURICH',addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10)) or
						(regexfind('UNITED ARAB EMIRATES|PAKISTAN|PANAMA|PERU|PHILIPPINES|DA	MASCUS|PERU|LIBERIA|NIGERIA|PAKISTAN|PANAMA|PHILIPPINES',addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10)) or
						(regexfind('POLAND|PUERTO RICO|LEBANON|SUDAN|SWITZERLAND|SYRIA|TAIWAN|TUNISIA|TURKEY|HONG KONG',addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10)) or
						(regexfind('BAHAMAS|BANGLADESH|CAMBODIA|ECUADOR|GHANA|GUYANA|KUWAIT|LEBANON|PORTUGAL|SUDAN|SURINAME|TUNISIA|UKRAINE',addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10)) or
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
						regexfind(us_state_filter, addr_1, 0)<>'' or
						regexfind(us_state_filter, addr_2, 0)<>'' or
						regexfind(us_state_filter, addr_3, 0)<>'' or
						regexfind(us_state_filter, addr_4, 0)<>'' or
						regexfind(us_state_filter, addr_5, 0)<>'' or
						regexfind(us_state_filter, addr_6, 0)<>'' or
						regexfind(us_state_filter, addr_7, 0)<>'' or
						regexfind(us_state_filter, addr_8, 0)<>'' or
						regexfind(us_state_filter, addr_9, 0)<>'' or
						regexfind(us_state_filter, addr_10, 0)<>'' or
						regexfind('UNITED STATES|INTERNATIONAL', country, 0)<>'') and
						trim(country,left,right)<>'GEORGIA'));

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
						(regexfind('TIJUANA|MEXICO|MEXICAL|DUBAI|VENEZUELA|DEPARTAMENTO|HONDURA|COLOMBIA|BAJA|INCARCERATED|INMATE|BAGHDAD',addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10)) or
 
            (regexfind('ALBANIA|ALGERIA|ARGENTINA|SWEDEN|TAIWAN|CHINA|ARMENIA|AFGHANISTAN|BELGIUM|KANDAHAR|BRAZIL|BRITISH ',addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10)) or
            (regexfind('CAMEROON|CANADA|CORPORATION|COSTA RICA|CUBA|CZECH REPUBLIC|DOMINICAN REPUBLIC|EGYPT|GERMANY|EL SALVADOR',addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10)) or
						(regexfind('YUGOSLAV|FRANCE|RUSSIA|GREECE|BEIRUT|GUYANA|HAITI|HUNGARY|INDIA|INDONESIA|THAILAND|ISRAEL|ITALY|JORDAN|PERU|KENYA',addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10)) or
						(regexfind('KOREA|KUWAIT|JORDAN|LEBANON|AL KIFAH|MALTA|IRAN|NIGERIA|AL-QAIDA|ISLAMIC|UNITED KINGDOM|VIET NAM|ZURICH',addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10)) or
						(regexfind('UNITED ARAB EMIRATES|PAKISTAN|PANAMA|PERU|PHILIPPINES|DA	MASCUS|PERU|LIBERIA|NIGERIA|PAKISTAN|PANAMA|PHILIPPINES',addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10)) or
						(regexfind('POLAND|PUERTO RICO|LEBANON|SUDAN|SWITZERLAND|SYRIA|TAIWAN|TUNISIA|TURKEY|HONG KONG',addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10)) or
						(regexfind('BAHAMAS|BANGLADESH|CAMBODIA|ECUADOR|GHANA|GUYANA|KUWAIT|LEBANON|PORTUGAL|SUDAN|SURINAME|TUNISIA|UKRAINE',addr_1+addr_2+addr_3+addr_4+addr_5+addr_6+addr_7+addr_8+addr_9+addr_10)) or
					  (regexfind('UNITED STATES|WWW|GRANDE STOCKYARDS',addr_1)) 
						);

total_foreign	:= non_us_filter + add_foreign;

	Layouts.addressidLayout gwlTrans(total_us_records l):= transform
			
		a1 := trim(l.addr_1,left,right);
			
		a2 := trim(l.addr_2,left,right);
				
    a3 := trim(l.addr_3,left,right);		
			
		self.append_prep_address1 	:= if(regexfind('[0-9]+', a1, 0)<>'' and regexfind('C/O', a1, 0)='' and a2<>'' and a3<>'',
											a1+' '+a2,
											if(regexfind('[0-9]+', a1, 0)<>'' and regexfind('C/O', a1, 0)='' and a2<>'' and a3='',
											a1,
											if((regexfind('[0-9]+', a1, 0)='' or regexfind('C/O', a1, 0)<>'') and regexfind('[0-9]+', a2, 0)<>'' and a3<>'',
											a2,
											'')));
		self.append_prep_addresslast := if(a1<>'' and a2<>'' and a3<>'',
											a3,
											if(regexfind('C/O', a1, 0)='' and a2<>'' and a3='',
											a2,
											''));
		self.append_rawaid 			:= 0;
		self 					        	:= l;
	end;

prepAddress := project(total_us_records, gwlTrans(left)); 


	unsigned4 lAIDAppendFlags		:= AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;			

	AID.MacAppendFromRaw_2Line(prepAddress, Append_Prep_Address1, append_prep_addresslast, Append_RawAID, addressCleaned, lAIDAppendFlags);

	Layouts.Layout_GWL addressAppended(addressCleaned pInput) := transform
	
	  string73 tempname            :=ut.CleanSpacesAndUpper(pinput.orig_pty_name);
    pname                        := Address.CleanPersonFML73_fields(tempName);
		SELF.title                   := IF(pInput.link_ssn !='', pname.title, '');
	  self.fname          				 := IF(pInput.link_ssn !='', pname.fname, '');      
    
    self.mname 			           	 := IF(pInput.link_ssn !='', pname.mname, ''); 
    self.lname 			 		         := IF(pInput.link_ssn !='', pname.lname, ''); 
    self.suffix 			           := IF(pInput.link_ssn !='', pname.name_suffix, ''); 
    self.a_score			   	       := IF(pInput.link_ssn !='', pname.name_score, '');
		self.cname                   := IF(pInput.link_fein != '',pInput.orig_pty_name,''); 
		self.Append_RawAID		       := pInput.AIDWork_RawAID;
		self.prim_range 	           := pInput.AIDWork_ACECache.prim_range;
		self.predir 		             := pInput.AIDWork_ACECache.predir;
		self.prim_name 		           := pInput.AIDWork_ACECache.prim_name;
		self.addr_suffix 	           := pInput.AIDWork_ACECache.addr_suffix;
		self.postdir 		             := pInput.AIDWork_ACECache.postdir;
		self.unit_desig 	           := pInput.AIDWork_ACECache.unit_desig;
		self.sec_range 		           := pInput.AIDWork_ACECache.sec_range;
		self.p_city_name 	           := pInput.AIDWork_ACECache.p_city_name;
		self.v_city_name 	           := pInput.AIDWork_ACECache.v_city_name;
		self.st 			               := pInput.AIDWork_ACECache.st;
		self.zip 			               := pInput.AIDWork_ACECache.zip5;
		self.zip4 			             := pInput.AIDWork_ACECache.zip4;
		self.cart 			             := pInput.AIDWork_ACECache.cart;
		self.cr_sort_sz 	           := pInput.AIDWork_ACECache.cr_sort_sz;
		self.lot 			               := pInput.AIDWork_ACECache.lot;
		self.lot_order 		           := pInput.AIDWork_ACECache.lot_order;
		self.dpbc 			             := pInput.AIDWork_ACECache.dbpc;
		self.chk_digit 		           := pInput.AIDWork_ACECache.chk_digit;
		self.record_type 	           := pInput.AIDWork_ACECache.rec_type;
		self.ace_fips_st             := pInput.AIDWork_ACECache.county[..2];
		self.county 		             := pInput.AIDWork_ACECache.county[3..];
		self.geo_lat 		             := pInput.AIDWork_ACECache.geo_lat;
		self.geo_long 		           := pInput.AIDWork_ACECache.geo_long;
		self.msa 			               := pInput.AIDWork_ACECache.msa;
		self.geo_blk 		             := pInput.AIDWork_ACECache.geo_blk;
		self.geo_match 		           := pInput.AIDWork_ACECache.geo_match;
		self.err_stat 		           := pInput.AIDWork_ACECache.err_stat;
		self.bdid := if(pInput.link_fein != '', prte2.fn_AppendFakeID.bdid(self.cname, self.prim_range, self.prim_name, self.v_city_name, self.st, self.zip, pInput.cust_name),0);
    SELF.did  := if(pInput.link_ssn  != '', prte2.fn_AppendFakeID.did(self.fname, self.lname, pInput.link_ssn, pInput.link_dob, pInput.cust_name),0);		
 		self			:= pInput;
	 	end;
		
cleanAddress 	:= project(addressCleaned,addressAppended(left));
//Collect Foreign Addresses
	 Layouts.Layout_GWL noCleanAddr(total_foreign pInput):= transform
		self.Append_RawAID		:= 0;
		self.prim_range     	:= '';
		self.predir 		      := '';
		self.prim_name 		    := '';
		self.addr_suffix 	    := '';
		self.postdir 		      := '';
		self.unit_desig 	    := '';
		self.sec_range 		    := '';
		self.p_city_name 	    := '';
		self.v_city_name 	    := '';
		self.st 			        := '';
		self.zip 			        := '';
		self.zip4 			      := '';
		self.cart 			      := '';
		self.cr_sort_sz 	    := '';
		self.lot 			        := '';
		self.lot_order 		    := '';
		self.dpbc 			      := '';
		self.chk_digit 		    := '';
		self.record_type 	    := '';
		self.ace_fips_st      := '';
		self.county 		      := '';
		self.geo_lat 		      := '';
		self.geo_long 		    := '';
		self.msa 			        := '';
		self.geo_blk 		      := '';
		self.geo_match 		    := '';
		self.err_stat 		    := '';
		self					        := pInput;
	end;

leftoverAddress := project(total_foreign, noCleanAddr(left));

ds_file_old := files.GWL_IN_1;

//Alpha CT records
alpha_recs := project(filter_recs_alpha, transform(Layouts.Layout_GWL, self := left, self :=[]));

ds_base := cleanAddress + leftoverAddress + ds_file_old + alpha_recs;
				 
PromoteSupers.MAC_SF_BuildProcess(ds_base,constants.Base_GWL, writefile_Patriots);

sequential(writefile_Patriots);

h := header.file_headers;

hr := record
  string20 fname := h.fname;
  string20 lname := h.lname;
  string20 mname := h.mname;
  end;

ht := dedup(table(h,hr),fname,lname,mname,all);

u := ht; 


Urec := record
	U;
	unsigned4	seq;
end;

Urec into_seq(U L, integer C) := transform
	self.seq := C;
	self := L;
end;

u2 := project(u,into_seq(LEFT,COUNTER));

res := record
  U;
  unsigned2 score := 0;
  end;

p:=files.File_Patriot;

r := record
  unsigned1 one := 1;
  p.fname;
  p.mname;
  p.lname;
  end;

t := dedup(table(p(fname<>'',lname<>''),r),fname,lname,mname,all);

Bads := t;

integer namecheck(string20 f1,string20 m1, string20 l1,
       string20 f2,string20 m2, string20 l2) := MIN(datalib.namematch(f1,m1,l1,f2,m2,l2),3);
	 

res compare(U2 L, Bads R) := transform
 	self.score := namecheck(L.fname,L.mname,L.lname,R.fname,R.mname,R.lname);
	self := L;
end;

o1a := join(U2(seq % 4 = 0),bads,
				namecheck(Left.fname,Left.mname,Left.lname,
			  Right.fname,Right.mname,Right.lname) < 3 ,
	  		compare(LEFT,RIGHT),left outer,all);
			
o1b := join(U2(seq % 4 = 1),bads,
				namecheck(Left.fname,Left.mname,Left.lname,
			  Right.fname,Right.mname,Right.lname) < 3 ,
		  	compare(LEFT,RIGHT),left outer,all);

o1c := join(U2(seq % 4 = 2),bads,
			 namecheck(Left.fname,Left.mname,Left.lname,
			 Right.fname,Right.mname,Right.lname) < 3 ,
			 compare(LEFT,RIGHT),left outer,all);

o1d := join(U2(seq % 4 = 3),bads,
				namecheck(Left.fname,Left.mname,Left.lname,
				Right.fname,Right.mname,Right.lname) < 3 ,
			  compare(LEFT,RIGHT),left outer,all);

o1 := o1a + o1b + o1c + o1d;

res roll(o1 L, o1 R) := transform
	self.score := if (L.score < R.score, L.score, R.score);
	self := L;
end;

o2 := rollup(sort(o1,hash(lname),lname,fname,mname,local),left.fname = right.fname and left.mname = right.mname and left.lname = right.lname,
			roll(LEFT,RIGHT),local);

Sequential(output(o2,,constants.FileName_Scorenames+workunit,compressed,overwrite),
           FileServices.StartSuperfiletransaction(),
	      	 FileServices.ClearSuperfile(constants.FileName_Scorenames),
					 FileServices.AddSuperfile(constants.FileName_Scorenames,constants.FileName_Scorenames+workunit),
					 FileServices.FinishSuperfiletransaction()
  				 );

Return 'success';
end;





