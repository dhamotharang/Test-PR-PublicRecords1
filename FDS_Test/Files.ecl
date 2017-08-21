import ut;
export Files := module

	export	Input	:=	module
	
		export PubRec		:=	dataset('~thor_data400::in::fds_test::20091116::public_record::search', Layouts.Input.PubRec, CSV(HEADING(1),SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])));
		
		export CleanPubRec	:=	dataset(ut.foreign_prod + 'thor400_92::persist::fds::pub_rec::did_bdid_ssn_fein_jmf',Layouts.Input.CleanPubRec,flat);
		
		export AssetLic		:=	dataset('~thor_data400::in::fds_test::20091130::assets::search', Layouts.input.AssetLicRec, CSV(HEADING(1),SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])));
		
		export ClnAssetLic	:=	dataset('~thor_data400::input::fds::AssetLic_rec::cleaned',Layouts.Input.CleanAssetLicRec,flat);
		
		export ConsumerRec	:=	dataset(ut.foreign_prod + '~thor_data400::in::fds_test::20091130::assets::search', consumer_Layouts.Input.ConsumerRec, CSV(HEADING(1),SEPARATOR(['|']), TERMINATOR(['\r\n', '\n'])));
		
		export CleanConsumerRec	:=	dataset('~thor400_84::persist::fds::consumer_rec::did_bdid_ssn_fein',consumer_Layouts.Input.CleanConsumerRec,flat);
		
	end;

end;