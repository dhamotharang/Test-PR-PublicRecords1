export mod_clean_name_addr := module

import SANCTN, Address, Ut, Lib_FileServices, lib_stringlib;

//Function to determine if name is a company name
export	varstring IsCompanyName(string cname)	:= FUNCTION
				Boolean IsCompany	 	 := SANCTN.fIscompany(cname);
				string  CompanyName	 := If(NOT(IsCompany),'',cname);
				return trim(CompanyName,left,right);
END;
	
	//Function to Standardize Corporation Suffix in name
export  varstring StdCorpSuffix(string suffix)	:= FUNCTION
				string temp_corp	:= trim(StringLib.StringToUppercase(suffix),left,right);
				string temp_corp1	:= StringLib.StringFindReplace(temp_corp,'INCORPORATED','INC');
				string temp_corp2 	:= StringLib.StringFindReplace(temp_corp1,'INCORPORATEDO','INC');
				string temp_corp3	:= StringLib.StringFindReplace(temp_corp2,'CORPORATION','CORP');
				string temp_corp4	:= StringLib.StringFindReplace(temp_corp3,'CORPORATE','CORP');
				string temp_corp5	:= StringLib.StringFindReplace(temp_corp4,'LIMITED LIABILITY COMPANY','LLC');
				string temp_corp6 	:= StringLib.StringFindReplace(temp_corp5,'CENTEROFFIC','CENTER');
				string temp_corp7 	:= StringLib.StringFindReplace(temp_corp6,'COMPANY','CO');
				string temp_corp8 	:= StringLib.StringFindReplace(temp_corp7,'LIMITED PARTNERSHIP','L.P.');
				string temp_corp9 	:= StringLib.StringFindReplace(temp_corp8,'INCOPORATED','INC');
				string temp_corp10	:= StringLib.StringFindReplace(temp_corp9,'INCORPORA','INC');
				string temp_corp11 	:= StringLib.StringFindReplace(temp_corp10,'INCO','INC');
				string temp_corp12 	:= StringLib.StringFindReplace(temp_corp11,'CORPORTION','CORP');
				string temp_corp13 	:= StringLib.StringFindReplace(temp_corp12,'CORPORATIO','CORP');
				string temp_corp14 	:= StringLib.StringFindReplace(temp_corp13,'CORPORATI','CORP');
				string temp_corp15 	:= StringLib.StringFindReplace(temp_corp14,'CORPORAT','CORP');
				string temp_corp16 	:= StringLib.StringFindReplace(temp_corp15,'CORPORAITON','CORP');
				string temp_corp17 	:= StringLib.StringFindReplace(temp_corp16,'CORPORA','CORP');
				string temp_corp18 	:= StringLib.StringFindReplace(temp_corp17,'COMPANIES','');
				string temp_corp19 	:= StringLib.StringFindReplace(temp_corp18,'COMPAN','CO');
				return trim(temp_corp19,left,right); 
END;
		
		
//Pattern for corporation suffix
//Note: Need Additional logic to handle Corporation names with 'CO' otherwise will affect names like "COOPER", "COMMONWEALTH". 
//Same goes for LP/PL could affect name like "Abdul Salph" or "Sample"
	shared suffixpattern := '( INC.| INC| CORP[ ]*| CORP$|CORP.| CORP INC|LLC| L. L. C.| L.L.C.| L.L.P.|LLP|LP LTD| LTD| LTD INC|PL$|PLL|PLC$|PLLC| L[.]P[.]$| L[.] P[.]$)';
	
//Pattern for corporation prefix
shared prefixpattern := '(^THE | THE$|(THE)$|[\\(]THE[\\)])';

//Pattern for DBA
shared DBApattern	:= '^(.*)(DBA - |/ DBA | DBA/|DBA | DBA:|D/B/A:| D/B/A |D/B/A | DBA\\)| DBA| D/B/A|C/O |C/0 |ATTN:|ATT:|ATTN - |ATTN |ATTENTION:|ATN:| AKA |^AKA | A/K/A | A/K/A|T/A )(.*)';

//Pattern for address
	shared Addrpattern	:= '^(.*)(PO BOX |P.O. BOX |P O BOX | -- | [0-9]+ )(.*)';
		 
//Get corporation suffix
export	varstring GetCorpSuffix(string csuffix) := FUNCTION
				string temp_suffix := regexfind(suffixpattern,trim(csuffix),1);
				return trim(StringLib.StringToUppercase(temp_suffix),left,right);
END;

//Get corporation prefix
export	varstring GetCorpPrefix(string cprefix) := FUNCTION
				string temp_prefix := regexfind(prefixpattern,cprefix,1);
				return trim(StringLib.StringToUppercase(temp_prefix),left,right);
END;

//Get DBA name from name field
export varstring GetDBAName(string dname)	:= FUNCTION
					string upperDBA	:= StringLib.StringToUppercase(dname);
					string temp_dba	:= regexfind(DBApattern,upperDBA,3);
//				string clnCO		:= StringLib.StringFindReplace(temp_dba,'C/O','');
//				string clnDBA		:= StringLib.StringFindReplace(clnCO,'DBA','');
				return trim(temp_dba,left,right);
END;


//Get Corp name w/o DBA name from name field
export varstring GetCorpName(string dname)	:= FUNCTION
				string uppercorp	:= StringLib.StringToUppercase(dname);
				string temp_corp	:= regexfind(DBApattern,uppercorp,1);
				return StringLib.StringCleanSpaces(trim(temp_corp,left,right));
END;

//Get Contact name without address field
export varstring GetContactName(string cname)	:= FUNCTION
				string	stripspace	:= StringLib.StringCleanSpaces(cname); 
				string temp_contact	:= regexfind(Addrpattern,stripspace,1);
				return trim(temp_contact,left,right);
END;
		

// Function to clean the bad chars and remove Corp Suffix from a given string.
// Note: Commented out LP, stripping names like "Abdul Salph" or "Sample"
export	varstring cleanFName(string name) := FUNCTION
        string temp_name   := trim(StringLib.StringToUppercase(name),left,right);
        string temp_name1  := StringLib.StringFindReplace(temp_name,'*','');
        string temp_name2  := StringLib.StringFindReplace(temp_name1,'%','');
        string temp_name3  := StringLib.StringFindReplace(temp_name2,',','');
        string temp_name4  := StringLib.StringFindReplace(temp_name3,':','');
        string temp_name5  := StringLib.StringFindReplace(temp_name4,';','');
		string temp_name6  := StringLib.StringFindReplace(temp_name5,'#','');
		string temp_name7  := StringLib.StringFindReplace(temp_name6,'.','');
		string temp_name8 := REGEXREPLACE('(ATTN:)',temp_name7,'');
		string temp_name9 := REGEXREPLACE('(C/O)',temp_name8,'');
        string temp_name10 := REGEXREPLACE('( CORP)',temp_name9,'');
        string temp_name11 := REGEXREPLACE('( INC)',temp_name10,'');
        string temp_name12 := REGEXREPLACE('(N/A)',temp_name11,'');
		string temp_name13 := REGEXREPLACE('( LLC)',temp_name12,'');
		string temp_name14 := REGEXREPLACE('( L L C)',temp_name13,'');
        string temp_name15 := REGEXREPLACE('( LC)',temp_name14,'');
        string temp_name16 := REGEXREPLACE('( LLP.+LTD)',temp_name15,'');
		string temp_name17 := REGEXREPLACE('( LLP)',temp_name16,'');
		string temp_name18 := REGEXREPLACE('( LP.+LTD)',temp_name17,'');
		// string temp_name20 := StringLib.StringFindReplace(temp_name19,'LP','');
		string temp_name19 := REGEXREPLACE('( LTD.+INC)',temp_name18,'');
		string temp_name20 := REGEXREPLACE('( LTD)',temp_name19,'');
		string temp_name21 := REGEXREPLACE('( PLLC)',temp_name20,'');
		string temp_name22 := REGEXREPLACE('( PLC)',temp_name21,'');
		string temp_name23 := REGEXREPLACE('(C/0)',temp_name22,'');
		string temp_name24 := REGEXREPLACE('^(THE)',temp_name23,'');
		string temp_name25 := REGEXREPLACE('( THE\\>)',temp_name24,'');
		string temp_name26 := REGEXREPLACE('( LP\\>)',temp_name25,'');
		string temp_name27 := REGEXREPLACE('( (THE))',temp_name26,'');
		return trim(temp_name27,left,right);
END;

export	varstring cleanInternetName(string name) := FUNCTION
        string temp_name   := trim(StringLib.StringToUppercase(name),left,right);
        string temp_name1  := StringLib.StringFindReplace(temp_name,'*','');
        string temp_name2  := StringLib.StringFindReplace(temp_name1,'%','');
        string temp_name3  := StringLib.StringFindReplace(temp_name2,',','');
        string temp_name4  := StringLib.StringFindReplace(temp_name3,':','');
        string temp_name5  := StringLib.StringFindReplace(temp_name4,';','');
		string temp_name6  := StringLib.StringFindReplace(temp_name5,'#','');
		string temp_name7 := REGEXREPLACE('(ATTN:)',temp_name6,'');
		string temp_name8 := REGEXREPLACE('(C/O)',temp_name7,'');
        string temp_name9 := REGEXREPLACE('( CORP)',temp_name8,'');
        string temp_name10 := REGEXREPLACE('( INC)',temp_name9,'');
        string temp_name11 := REGEXREPLACE('(N/A)',temp_name10,'');
		string temp_name12 := REGEXREPLACE('( LLC)',temp_name11,'');
		string temp_name13 := REGEXREPLACE('( L L C)',temp_name12,'');
        string temp_name14 := REGEXREPLACE('( LC)',temp_name13,'');
        string temp_name15 := REGEXREPLACE('( LLP.+LTD)',temp_name14,'');
		string temp_name16 := REGEXREPLACE('( LLP)',temp_name15,'');
		string temp_name17 := REGEXREPLACE('( LP.+LTD)',temp_name16,'');
		string temp_name18 := REGEXREPLACE('( LTD.+INC)',temp_name17,'');
		string temp_name19 := REGEXREPLACE('( LTD)',temp_name18,'');
		string temp_name20 := REGEXREPLACE('( PLLC)',temp_name19,'');
		string temp_name21 := REGEXREPLACE('( PLC)',temp_name20,'');
		string temp_name22 := REGEXREPLACE('(C/0)',temp_name21,'');
		string temp_name23 := REGEXREPLACE('^(THE)',temp_name22,'');
		string temp_name24 := REGEXREPLACE('(THE\\>)',temp_name23,'');
		string temp_name25 := REGEXREPLACE('( LP\\>)',temp_name24,'');
		return trim(temp_name25,left,right);
END;


// Function to strip punctuations from a given string.
export	varstring strippunctName(string name) := FUNCTION
        string temp_name   := trim(StringLib.StringToUppercase(name),left,right);
        string temp_name1  := StringLib.StringFindReplace(temp_name,'*',' ');
        string temp_name2  := StringLib.StringFindReplace(temp_name1,'%',' ');
        string temp_name3  := StringLib.StringFindReplace(temp_name2,',',' ');
        string temp_name4  := StringLib.StringFindReplace(temp_name3,'(','');
        string temp_name5  := StringLib.StringFindReplace(temp_name4,')','');
        string temp_name6  := StringLib.StringFindReplace(temp_name5,':','');
        string temp_name7  := StringLib.StringFindReplace(temp_name6,';',' ');
		string temp_name8  := StringLib.StringFindReplace(temp_name7,'#','');
		string temp_name9  := StringLib.StringFindReplace(temp_name8,'.',' ');
		string temp_name10 := StringLib.StringFindReplace(temp_name9,'"','');
		return trim(temp_name10,left,right);
END;

// Function to strip punctuations with the exception of ['(',')','#']
export	varstring strippunctMisc(string name) := FUNCTION
        string temp_name   := trim(StringLib.StringToUppercase(name),left,right);
        string temp_name1  := StringLib.StringFindReplace(temp_name,'*','');
        string temp_name2  := StringLib.StringFindReplace(temp_name1,'%','');
        string temp_name3  := StringLib.StringFindReplace(temp_name2,',',' ');
        string temp_name4  := StringLib.StringFindReplace(temp_name3,':',' ');
        string temp_name5  := StringLib.StringFindReplace(temp_name4,';',' ');
				string temp_name6  := StringLib.StringFindReplace(temp_name5,'.',' ');
				string temp_name7  := StringLib.StringFindReplace(temp_name6,'+',' ');
				string temp_name8  := StringLib.StringFindReplace(temp_name7,'"','');
				string temp_name9  := StringLib.StringFindReplace(temp_name8,'>',' ');
				string temp_name10  := StringLib.StringFindReplace(temp_name9,'{','');
				string temp_name11  := StringLib.StringFindReplace(temp_name10,'}','');
				return trim(temp_name11,left,right);
END;

// Function to strip 'BRANCH" from name
export	varstring stripBranch(string name) := FUNCTION
		string temp_name  := trim(StringLib.StringToUppercase(name),left,right);
		string temp_name1 := REGEXREPLACE('( BRANCH OFFICE)',temp_name,'');
		string temp_name2 := REGEXREPLACE('( BRANCH OFFIC)',temp_name1,'');
		string temp_name3 := REGEXREPLACE('( BRANCH OFFI)',temp_name2,'');
		string temp_name4 := REGEXREPLACE('( BRANCH OFF)',temp_name3,'');
		string temp_name5 := REGEXREPLACE('( BRANCH OF)',temp_name4,'');
		string temp_name6 := REGEXREPLACE('( BRANCH O)',temp_name5,'');
		string temp_name7 := REGEXREPLACE('( BRANCH)',temp_name6,'');
		string temp_name8 := REGEXREPLACE('( BRANC)',temp_name7,'');
		string temp_name9 := REGEXREPLACE('( BRAN$)',temp_name8,'');
		string temp_name10 := REGEXREPLACE('(BRCH)',temp_name9,'');
        string temp_name11 := REGEXREPLACE('(INCOFFICE)',temp_name10,'');
        string temp_name12 := REGEXREPLACE('( BR OFFICE)',temp_name11,'');
		string temp_name13 := REGEXREPLACE('( BR OFFIC)',temp_name12,'');
        string temp_name14 := REGEXREPLACE('( BR OFF)',temp_name13,'');
		string temp_name15 := REGEXREPLACE('( BRA$)',temp_name14,'');
		string temp_name16 := REGEXREPLACE('( BR$)',temp_name15,'');
        return trim(temp_name16,left,right);
END;



//Clean address function
export varstring cleanAddress(string street, string citystatezip) := FUNCTION
return if(street <> '',Address.CleanAddress182(trim(street),trim(citystatezip)),'');
END;

//Clean Name function lfm 
export varstring cleanLFMName(String lfm):= FUNCTION
return IF(lfm != '' and IsCompanyName(lfm) = '',Address.CleanPersonLFM73(trim(regexreplace('^O ',lfm,'O'))),'');
END;

//Clean Name function fml 
export varstring cleanFMLName(String fml):= FUNCTION
return IF(fml != '' and IsCompanyName(fml) = '',Address.CleanPersonFML73(trim(regexreplace('^O ',fml,'O'))),'');
END;

//Clean Company function
export varstring cleanCompany(string company)	:= FUNCTION
string  tmpClnCompany	:= If(IsCompanyName(company)!= '',DataLib.companyclean(TRIM(company,LEFT,RIGHT)),'');
return  StringLib.StringCleanSpaces(tmpClnCompany);
END;

end;