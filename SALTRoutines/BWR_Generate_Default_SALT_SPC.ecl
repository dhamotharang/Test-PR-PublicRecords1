#workunit('name', 'Generate_Default_SALT_SPC');

IMPORT Consumer_Credit;
InputFile := Consumer_Credit.Files.Bankruptcy_Data;

IMPORT SALT38;
SALT38.MAC_Default_SPC(InputFile, generatedSALTSpecification);

FinalSALTSpecification := ROLLUP(generatedSALTSpecification, TRUE, TRANSFORM(RECORDOF(LEFT), SELF.s := LEFT.s + '\n' + RIGHT.s));

OUTPUT(generatedSALTSpecification, NAMED('Multi_Line_Default_SPC'));
OUTPUT(FinalSALTSpecification, NAMED('Single_Line_Default_SPC'));