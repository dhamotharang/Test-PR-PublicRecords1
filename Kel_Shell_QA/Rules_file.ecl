﻿IMPORT STD;

lay:=RECORD
    STRING field1;
    STRING field2;
    STRING field3;
    STRING field4;
    STRING field5;
    STRING field6;
    STRING field7;
    STRING field8;
    STRING field9;
    STRING field10;
    STRING field11;
    STRING field12;
    STRING field13;
    STRING field14;
    STRING field15;
    STRING field16;
    STRING field17;
    STRING field18;
    STRING field19;
    STRING field20;
    STRING field21;
    STRING field22;
    STRING field23;
    STRING field24;
    STRING field25;
    STRING field26;
    STRING field27;
    STRING field28;
    STRING field29;
    STRING field30;
    STRING field31;
    STRING field32;
END;

ds:=dataset('~kel_shell::in::test_csv',lay,CSV(HEADING(4), QUOTE('"')));
// ds;

p_lay:=record
string	ECLFieldname;
// string	KELFieldname;
string	Category;
// string	AttributeDefinition;
string	SourceDescription;
// string	NumericCharactersallowed;
// string	Type;
string	Min;
string	Max;
// string	AlphaCharactersallowed;
// string	AllSpecialCharactersallowed;
// string	ExcludedCharacters;
// string	UniqueAcceptableOutputs;
// string	NULLAcceptable;
string  OtherOutputRules;
// string	Average;
// string	StdDev;
// string	NullRate;
// string	ZeroRate;
SET OF INTEGER 	DefaultValues;
// string	DefaultValueRate;
// string	HitRate;
// string	Other;
// string	Product;
// string	Version;
// string	Other_p;
// string	AdditionalComments;
// string	CurrentlyUsed;
// string	InitialDate;
// string	DateofLastUpdate;
// string	DescriptionofChange;
// string	ResetFlag;
end;

p:=project(ds,transform(p_lay,
self.ECLFieldname:=left.field1;
// self.KELFieldname:=left.field2;
self.Category:=left.field3;
// self.AttributeDefinition:=left.field4;
self.SourceDescription:=left.field5;
// self.NumericCharactersallowed:=left.field6;
// self.Type:=left.field7;
self.Min:=left.field8;
self.Max:=left.field9;
// self.AlphaCharactersallowed:=left.field10;
// self.AllSpecialCharactersallowed:=left.field11;
// self.ExcludedCharacters:=left.field12;
// self.UniqueAcceptableOutputs:=left.field13;
// self.NULLAcceptable:=left.field14;
self.OtherOutputRules:=left.field15;
// self.Average:=left.field16;
// self.StdDev:=left.field17;
// self.NullRate:=left.field18;
// self.ZeroRate:=left.field19;
// self.DefaultValues:=left.field20;
// self.DefaultValueRate:=left.field21;
// self.HitRate:=left.field22;
// self.Other:=left.field23;
// self.Product:=left.field24;
// self.Version:=left.field25;
// self.Other_p:=left.field26;
// self.AdditionalComments:=left.field27;
// self.CurrentlyUsed:=left.field28;
// self.InitialDate:=left.field29;
// self.DateofLastUpdate:=left.field30;
// self.DescriptionofChange:=left.field31;
// self.ResetFlag:=left.field32;
self.DefaultValues:=(SET OF INTEGER)STD.STr.SplitWords(regexreplace(',',trim(left.field20,left,right),'|'),'|') ;
self:=[];
));

// EXPORT Rules_file:= p(Category in ['Assets','B2B Trade','Bankruptcy History','Inquiry History',	'Criminal History',	'Business Input Clean ',	'Business Input Clean Populated',	'Business Input Echo Populated',	'Input Clean Populated',	'Input Clean',	'Input Echo Populated',	'Business Input Echo','Input Echo']);

// manual file
// EXPORT Rules_file:= p;

// auto generation file
EXPORT Rules_file:= Kel_Shell_QA.Automated_Rules_File;