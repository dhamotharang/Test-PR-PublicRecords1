

Rules_Generation(Attribute_Type, Attribute_Group):= FUNCTIONMACRO
IMPORT lib_stringlib,STD;
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
END;

ds:=dataset('~kel_shell::in::kel_shell_qa_confluence_' + Attribute_Group + '_' + Attribute_Type + '_sprayed',lay,CSV(HEADING(1), QUOTE('"')));

// ds;

p_lay:=RECORD
  string  Sno;
	string	Attribute_Name;
	string	Attribute_Description;
	string	Attribute_Value;
	string	NextGenAttr;
	string	JIRA_Ticket;
	string	Logic;
	string	Special_Values;
	string	Output_Values;
	string	Foundational_Attribute;
	string	Prerequisite_Attributes;
	string	Supporting_Attributes;
	string	Search_Key;
	string	Approved_for_FCRA;
	string	Development_Layout;
	string	ECL_Format;
	string	R_Format;
	string	SAS_Format;
	string	Drop_Group;
	string	Monotonicity;
	string	Modeling_Purpose;
	string	Predecessor_Attribute_Name;
	string	Predecessor_Attribute_Source;
	string	Priority;
	string	Risk;
END;

p_ds:=project(ds,transform(p_lay,   self.Sno:=left.field1;
																		self.Attribute_Name:=left.field2;
																		self.Attribute_Description:=left.field3;
																		self.Attribute_Value:=left.field4;
																		self.NextGenAttr:=left.field5;
																		self.JIRA_Ticket:=left.field6;
																		self.Logic:=left.field7;
																		self.Special_Values:=left.field8;
																		self.Output_Values:=left.field9;
																		self.Foundational_Attribute:=left.field10;
																		self.Prerequisite_Attributes:=left.field11;
																		self.Supporting_Attributes:=left.field12;
																		self.Search_Key:=left.field13;
																		self.Approved_for_FCRA:=left.field14;
																		self.Development_Layout:=left.field15;
																		self.ECL_Format:=left.field16;
																		self.R_Format:=left.field17;
																		self.SAS_Format:=left.field18;
																		self.Drop_Group:=left.field19;
																		self.Monotonicity:=left.field20;
																		self.Modeling_Purpose:=left.field21;
																		self.Predecessor_Attribute_Name:=left.field22;
																		self.Predecessor_Attribute_Source:=left.field23;
																		self.Priority:=left.field24;
																		self.Risk:=left.field25;
																		));

Rules_lay:=record
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
SET OF STRING 	DefaultValueRate;
string	HitRate;
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

IMPORT Std;
																	
Rules_ds:=project(p_ds,transform(Rules_lay,
									self.ECLFieldname:=left.Attribute_Name;
									// self.KELFieldname:=left.field2;
									self.Category:=Attribute_Group;
									// self.AttributeDefinition:=left.field4;
									self.SourceDescription:=left.Attribute_Description;
									// self.NumericCharactersallowed:=left.field6;
									// self.Type:=left.field7;
									self.Min:=IF(STD.STr.SplitWords(REGEXREPLACE(' - ', left.Output_Values, '-'),'-')[1] in ['YYYYMMDD'] OR 
									             REGEXFIND(',', left.Output_Values) OR
															 REGEXFIND('[a-zA-Z]', left.Output_Values),
																								 'No Min',
																								 STD.STr.SplitWords(REGEXREPLACE(' - ', left.Output_Values, '-'),'-')[1]);
									self.Max:=IF(STD.STr.SplitWords(REGEXREPLACE(' - ', left.Output_Values, '-'),'-')[2] in ['YYYYMMDD'] OR
									             REGEXFIND(',', left.Output_Values) OR
															 REGEXFIND('[a-zA-Z]', left.Output_Values),
																								 'No Max',
																								 STD.STr.SplitWords(REGEXREPLACE(' - ', left.Output_Values, '-'),'-')[2]);
																								 
									// self.AlphaCharactersallowed:=left.field10;
									// self.AllSpecialCharactersallowed:=left.field11;
									// self.ExcludedCharacters:=left.field12;
									// self.UniqueAcceptableOutputs:=left.field13;
									// self.NULLAcceptable:=left.field14;
									self.OtherOutputRules:=MAP(REGEXFIND(',', left.Output_Values) OR REGEXFIND('[a-zA-Z]', left.Output_Values) =>'No BinSize',
									                           STD.STr.SplitWords(REGEXREPLACE(' - ', left.Output_Values, '-'),'-')[1] in ['YYYYMMDD'] or STD.STr.SplitWords(REGEXREPLACE(' - ', left.Output_Values, '-'),'-')[2] in ['YYYYMMDD'] =>'No BinSize',
									                           (integer)STD.STr.SplitWords(REGEXREPLACE(' - ', left.Output_Values, '-'),'-')[2]> 99999 => (string)ROUNDUP((integer)STD.STr.SplitWords(REGEXREPLACE(' - ', left.Output_Values, '-'),'-')[2]/10),
									                           (integer)STD.STr.SplitWords(REGEXREPLACE(' - ', left.Output_Values, '-'),'-')[2]> 999 and (integer)STD.STr.SplitWords(REGEXREPLACE(' - ', left.Output_Values, '-'),'-')[2] <= 99999 => '100',
									                           (integer)STD.STr.SplitWords(REGEXREPLACE(' - ', left.Output_Values, '-'),'-')[2]>= 99 and (integer)STD.STr.SplitWords(REGEXREPLACE(' - ', left.Output_Values, '-'),'-')[2] <= 999 => '10',
									                           (integer)STD.STr.SplitWords(REGEXREPLACE(' - ', left.Output_Values, '-'),'-')[2]>= 11 and (integer)STD.STr.SplitWords(REGEXREPLACE(' - ', left.Output_Values, '-'),'-')[2] <= 98 => '5',
																						 (integer)STD.STr.SplitWords(REGEXREPLACE(' - ', left.Output_Values, '-'),'-')[2]>= 0 and (integer)STD.STr.SplitWords(REGEXREPLACE(' - ', left.Output_Values, '-'),'-')[2] <= 10 => '1',
																						 'No BinSize'
									                           );
									// self.Average:=left.field16;
									// self.StdDev:=left.field17;
									// self.NullRate:=left.field18;
									// self.ZeroRate:=left.field19;
									// self.DefaultValues:=left.field20;
									self.DefaultValueRate:= (SET OF STRING)STD.STr.SplitWords(regexreplace(',',trim(
									                           regexreplace('-99999',trim(regexreplace('-99998', trim(regexreplace('-99997',trim(left.Special_Values,left,right),'0.05'),left,right),'0.05'),left,right),'0.05'),left,right),'|'),'|');
									self.HitRate:=(string) MAP(count((SET OF INTEGER)STD.STr.SplitWords(regexreplace(',',trim(left.Special_Values,left,right),'|'),'|')) = 3 => '.85',
									                           count((SET OF INTEGER)STD.STr.SplitWords(regexreplace(',',trim(left.Special_Values,left,right),'|'),'|')) = 2 => '.9',
																						 count((SET OF INTEGER)STD.STr.SplitWords(regexreplace(',',trim(left.Special_Values,left,right),'|'),'|')) = 1 => '.95',
																						 '1'
									                          );
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
									self.DefaultValues:=(SET OF INTEGER)STD.STr.SplitWords(regexreplace(',',trim(left.Special_Values,left,right),'|'),'|') ;
									self:=[];
									));
																		
RETURN Rules_ds;																		
																																		
ENDMACRO;							
									
EXPORT Automated_Rules_File :=  Rules_Generation('Person','Best PII') +
                                Rules_Generation('Person','Professional License') +
                                Rules_Generation('Person','assets') +
																Rules_Generation('Person','Derogs -Bankruptcy History') +
																Rules_Generation('Person','Derogs -Criminal History') +
																Rules_Generation('Business','Business B2B Trade') +
																// Rules_Generation('Business','Business LexID') +
																Rules_Generation('Business','Business Input Validation') +
																Rules_Generation('Person','Validation') +
																Rules_Generation('Business','Business Derog - Bankruptcy History') +
																
																Rules_Generation('Business','Secretary of State') +
																Rules_Generation('Business','Best BII') +
																Rules_Generation('Business','Business Uniform Commercial Code') +
																Rules_Generation('Business','Business Assets')+
																Rules_Generation('Business','Business Best')+
																Rules_Generation('Person', 'Address History')+
																Rules_Generation('Business','Business Judgments')+
																Rules_Generation('Business','Business Derogs - Landlord Tenant Disputes')+
																Rules_Generation('Business','Business Derogs - Overall History')+
																Rules_Generation('Business','Business Derogs - Lien and Judgment History')+
																Rules_Generation('Business','Business Input - Business Header Velocity')+
																Rules_Generation('Business','Business Firmographics')+
																Rules_Generation('Business','Business Best - Best Sources')+
																Rules_Generation('Business','Business Best - Best Characteristics')+
																Rules_Generation('Business','Business Associate')+
																Rules_Generation('Business','Business Source Verification')+ 
																Rules_Generation('Person','Education')+
																Rules_Generation('Suit','Derogs - Lien and Judgment History');