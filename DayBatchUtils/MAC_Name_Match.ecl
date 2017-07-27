export MAC_Name_Match(linkData,inDataRec,outDataRec,inLName_field,inFName_field,outLName_field,
											outFName_Field,matchCode_Field,outFile,matchF_initial = false) := MACRO
import ut, NID;
#uniquename(appendMatch);

linkData %appendMatch%(linkData l) := TRANSFORM
		isLNameMatch := ut.NBEQ(l.inDataRec.inLName_Field,l.outDataRec.outLName_Field);
		isFNameMatch := ut.NBEQ(NID.PreferredFirstNew(l.inDataRec.inFName_Field,false),NID.PreferredFirstNew(l.outDataRec.outFName_Field,false)) or
		                ut.NBEQ(NID.PreferredFirstNew(l.inDataRec.inFName_Field,true),NID.PreferredFirstNew(l.outDataRec.outFName_Field,true));
		isF_initialMatch := matchF_Initial AND ut.NBEQ(l.inDataRec.inFName_Field[1],l.outDataRec.outFName_Field[1]);
		
		SELF.matchCode_Field := MAP(isLNameMatch AND isFNameMatch => 'FL' + l.matchCode_Field,
																isLNameMatch AND isF_initialMatch => 'fL' + l.matchCode_Field,
																isLNameMatch => 'L' + l.matchCode_Field,
																isFNameMatch => 'F' + l.matchCode_Field,
																isF_initialMatch => 'f' + l.matchCode_Field,
																l.matchCode_Field
																);
		SELF := l;
END;

outFile := PROJECT(linkData,%appendMatch%(LEFT));

ENDMACRO;