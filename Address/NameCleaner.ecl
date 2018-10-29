export NameCleaner := MODULE

import lib_stringlib;

/****

ECL based NAME CLEANER
May be used as a direct replacement for the name cleaning servers

FOR EVALUATION ONLY
Please send any comments to Charles Salvo

exported functions:
export string73 CleanPerson73(string name)
export string73 CleanPersonFML73(string name) 
export string73 CleanPersonFML73(string name) 
export string140 CleanDualName140(string dualname)

NEW FUNCTION
export string73 CleanPersonParsed73(string fname, string mname, string lname, string suffix)


****/

/*
		cln_title		:= [1..5];
		cln_fname		:= [6..25];
		cln_mname		:= [26..45];
		cln_lname		:= [46..65];
		cln_suffix	    := [66..70];
		name_score		:= [71..73];
*/

shared string73 BuildName(string5 title, string20 fname, string20 mname, string20 lname, string5 suffix, integer4 score=85)
 := BEGINC++
#include <string.h>
#body	
	char buf[74];
	snprintf(buf, 74, "%-5.5s%-20.20s%-20.20s%-20.20s%-5.5s%03d", title,fname,mname,lname,suffix,score);
	memcpy(__result, buf, 73);
ENDC++;

shared string73 NotAName := BuildName('','','','','',0);


shared integer NameScore(string name, integer fmt) := FUNCTION
	i := MAP(
		NOT Address.Persons.validPersonNameFormat(fmt) => 0,
		Address.Persons.InvalidNameFormat(name) => 10,
		name IN SpecialNames.full_name_obscenities => 10,
		Address.Business.HasBusinessWord(name)=> 10,
		Address.SpecialNames.IsKnownBusiness(name) => 20,
		Address.SpecialNames.IsInvalidName(name) => 20,
		Address.Persons.IsLikelyPersonalNameFormat(fmt) => 85,
		Address.Persons.IsSomewhatLikelyPersonalNameFormat(fmt) => 83, 
		80);

	fname := Address.Persons.FirstName(name, fmt);
	j := MAP(
			Length(Trim(fname)) = 1 => 3,
			Address.Persons.IsFirstName(fname) => 7,
			0);
	k := IF(Address.Persons.IsLastNameEither(name, fmt), 7, 0);
	
	RETURN i + j + k;
	
END;

shared string removewhitespace(string s) := BEGINC++
	char *t = (char *)rtlMalloc(lenS);
	
	for (int i = 0; i < lenS; ++i)
	{
		t[i] = s[i] < ' ' ? ' ' : s[i];
	}
	__result = t;
	__lenResult = lenS;
ENDC++;		

shared string73 CleanPerson(string name, string1 hint='U') := FUNCTION
	t := TRIM(StringLib.StringToUpperCase(removewhitespace(name)),LEFT,RIGHT);
	s := Address.Persons.SuffixToAlpha(Address.Persons.FixupSlash(t));
	n := Address.Persons.PersonalNameFormat(s);
	return if (Address.Persons.validPersonNameFormat(n),
		BuildName(Address.Persons.Title(s, n, hint, t),
				Address.Persons.FirstName(s, n, hint),
				Address.Persons.MiddleName(s, n, hint), 
				Address.Persons.LastName(s, n, hint),
				Address.Persons.NameSuffix(s, n),
				NameScore(s, n)),
		NotAName);
END;

export string73 CleanPerson73(string name, string1 hint='U') := FUNCTION
	return CleanPerson(name, hint);
END;

export string73 CleanPersonFML73(string name) := FUNCTION
	return CleanPerson(name, 'F');
END;

export string73 CleanPersonLFM73(string name) := FUNCTION
	return CleanPerson(name, 'L');
END;

export string73 CleanPersonParsed73(string fname, string mname, string lname, string suffix) :=
	CleanPersonFML73(Address.Persons.ReconstructName(fname,mname,lname,suffix));

/*
		cln_title1		:= [1..5];
		cln_fname2		:= [6..25];
		cln_mname1		:= [26..45];
		cln_lname1		:= [46..65];
		cln_suffix1	    := [66..70];
		cln_title2		:= [71..75];
		cln_fname2		:= [76..95];
		cln_mname2		:= [96..115];
		cln_lname2		:= [116..135];
		cln_suffix2	    := [136..140];
*/
shared string140 BuildDualName(string title, string fname, string mname, string lname, string suffix,
						string title2, string fname2, string mname2, string lname2, string suffix2)
 := BEGINC++
#include <string.h>
#body	
	memset(__result, ' ', 140);
	if (lenTitle)
		memcpy(__result, title, lenTitle > 5 ? 5 : lenTitle);
	memcpy(__result + 5, fname, lenFname > 20 ? 20 : lenFname);
	if (lenMname)	if (lenTitle)
		memcpy(__result, title, lenTitle > 5 ? 5 : lenTitle);

		memcpy(__result + 25, mname, lenMname > 20 ? 20 : lenMname);
	memcpy(__result + 45, lname, lenLname > 20 ? 20 : lenLname);
	if (lenSuffix)
		memcpy(__result + 65, suffix, lenSuffix > 5 ? 5 : lenSuffix);
		
	if (lenTitle2)
		memcpy(__result + 70, title2, lenTitle2 > 5 ? 5 : lenTitle2);
	memcpy(__result + 75, fname2, lenFname2 > 20 ? 20 : lenFname2);
	if (lenMname2)
		memcpy(__result + 95, mname2, lenMname2 > 20 ? 20 : lenMname2);
	memcpy(__result + 115, lname2, lenLname2 > 20 ? 20 : lenLname2);
	if (lenSuffix2)
		memcpy(__result + 135, suffix2, lenSuffix2 > 5 ? 5 : lenSuffix2);
		
ENDC++;

export string140 CleanDualName140(string dualname) := FUNCTION
	s := Address.Persons.FixupSlash(TRIM(StringLib.StringToUpperCase(dualname),LEFT,RIGHT));
	n := Address.Persons.PersonalNameFormat(s);
	return if (Address.Persons.IsNameFormatDual(n),
		BuildDualName(Address.Persons.Title(s,n), Address.Persons.FirstName(s, n), Address.Persons.MiddleName(s, n), 
				Address.Persons.LastName(s, n), Address.Persons.NameSuffix(s, n),
				Address.Persons.Title2(s,n), Address.Persons.FirstName2(s, n), Address.Persons.MiddleName2(s, n),
				Address.Persons.LastName2(s, n), Address.Persons.NameSuffix2(s, n)),
		'');
end;


export string140 CleanNameEx(string name, string1 hint='U') := FUNCTION
	t := TRIM(StringLib.StringToUpperCase(removewhitespace(name)),LEFT,RIGHT);
	s := Address.Persons.SuffixToAlpha(Address.Persons.FixupSlash(t));
	n := Address.Persons.PersonalNameFormat(s);

	return BuildDualName(Address.Persons.Title(s,n,hint,t), 
			Address.Persons.FirstName(s, n, hint), Address.Persons.MiddleName(s, n, hint), 
			Address.Persons.LastName(s, n, hint), Address.Persons.NameSuffix(s, n),
			Address.Persons.Title2(s,n,t), Address.Persons.FirstName2(s, n), Address.Persons.MiddleName2(s, n),
			Address.Persons.LastName2(s, n), Address.Persons.NameSuffix2(s, n));
End;

export string PersonNameFormat(string name) := FUNCTION
	t := TRIM(StringLib.StringToUpperCase(removewhitespace(name)),LEFT,RIGHT);
	s := Address.Persons.SuffixToAlpha(Address.Persons.FixupSlash(t));
	n := Address.Persons.PersonalNameFormat(s);
	RETURN IF(n=0,'***',Address.Persons.WhichFormat(n));
END;
		
END;

