import tools;
export Proc_Build_Bid_Keys(

	string pversion

) :=
function

	tools.mac_WriteIndex('key_yellowpages_bid		,keynames(pversion).bid.new'	,BuildBidKey		);

	return
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
			parallel(
				 BuildBidKey	
			)
			,Promote(pversion).buildfiles.New2Built
		)
		,output('No Valid version parameter passed, skipping YellowPages.Proc_Build_Bid_Keys atribute')
	);

end;
