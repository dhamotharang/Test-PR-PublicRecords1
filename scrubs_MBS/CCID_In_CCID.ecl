import FraudShared;
Infile := FraudShared.Files().Input.MBSFdnCCID.Sprayed;
f0:= Project(Infile,Transform(FraudShared.Layouts.Input.MBSFdnCCID
										,Self.account_id :=REGEXREPLACE('[^a-zA-Z0-9 ]',trim(left.account_id,left,right),'') 
										,Self:=left));
export CCID_In_CCID := f0;