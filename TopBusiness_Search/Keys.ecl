import TopBusiness;

export Keys(
	string version = '',
	boolean pUseOtherEnvironment = false) :=

module

	export Address := KeyPrep_BID_Address(TopBusiness.Files(version,pUseOtherEnvironment).Linking.Linked.Built,version,pUseOtherEnvironment);
	export CompanyName := KeyPrep_BID_CompanyName(TopBusiness.Files(version,pUseOtherEnvironment).Linking.Linked.Built,version,pUseOtherEnvironment);
	export FEIN := KeyPrep_BID_FEIN(TopBusiness.Files(version,pUseOtherEnvironment).Linking.Linked.Built,version,pUseOtherEnvironment);
	export LLID9 := KeyPrep_BID_LLID9(TopBusiness.Files(version,pUseOtherEnvironment).LLID9.Linked.Built,version,pUseOtherEnvironment);
	export LLID12 := KeyPrep_BID_LLID12(TopBusiness.Files(version,pUseOtherEnvironment).LLID12.Linked.Built,version,pUseOtherEnvironment);
	export PhoneNumber := KeyPrep_BID_PhoneNumber(TopBusiness.Files(version,pUseOtherEnvironment).Linking.Linked.Built,version,pUseOtherEnvironment);
	export URL := KeyPrep_BID_URL(TopBusiness.Files(version,pUseOtherEnvironment).URLs.Linked.Built,version,pUseOtherEnvironment);

end;
