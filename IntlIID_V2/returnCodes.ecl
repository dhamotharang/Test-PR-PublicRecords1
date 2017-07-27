export returnCodes (layout, cnt, country, addronlymatch, gender, isFirst, isLast, isAddr, isDOB, IsLPhone, isMPhone, isID,
										fnamePop, lnamePop, addrPop, dobPop, natIDPop, lPhonePop, mPhonePop) := // the is fields are true if verified/populated

MACRO


CHOOSEN(
	IF(	'0001' in set (layout,resultcode) or
			'0002' in set (layout,resultcode), DATASET([{'0001',getRCdesc('0001')}],iesp.share.t_RiskIndicator)) &
	IF(	'0003' in set (layout,resultcode), DATASET([{'0003',getRCdesc('0003')}],iesp.share.t_RiskIndicator)) &
	IF(	'0004' in set (layout,resultcode), DATASET([{'0004',getRCdesc('0004')}],iesp.share.t_RiskIndicator)) &
	IF(	addrOnlyMatch, DATASET([{'9997',getRCdesc('9997')}],iesp.share.t_RiskIndicator)) &
	// IF('9998' in set (layout,resultcode), DATASET([{'9998',getRCdesc('9998')}],iesp.share.t_RiskIndicator)) ,
	IF(	'9999' in set (layout,resultcode), DATASET([{'9999',getRCdesc('9999')}],iesp.share.t_RiskIndicator)) &
	// IF(watchlist = 1, DATASET([{'L032',getRCdesc('L032')}],iesp.share.t_RiskIndicator)) &	// done outside of this function
	// IF(watchlist = 2, DATASET([{'L0WL',getRCdesc('L0WL')}],iesp.share.t_RiskIndicator)) &	// done outside of this funtion
	IF(	'0611' in set (layout,resultcode) or
			'02130111' in set (layout,uid+resultcode) or
			'02140111' in set (layout,uid+resultcode) or
			'02150111' in set (layout,uid+resultcode) or
			'0107' in set (layout,resultcode), DATASET([{'0107',getRCdesc('0107')}],iesp.share.t_RiskIndicator)) &
	IF(	'0108' in set (layout,resultcode) or
			'02130112' in set (layout,uid+resultcode) or
			'02140112' in set (layout,uid+resultcode) or
			'02150112' in set (layout,uid+resultcode), DATASET([{'0108',getRCdesc('0108')}],iesp.share.t_RiskIndicator)) &
	IF(	'4113' in set (layout,resultcode), DATASET([{'4113',getRCdesc('4113')}],iesp.share.t_RiskIndicator)) &
	IF(	'4114' in set (layout,resultcode), DATASET([{'4114',getRCdesc('4114')}],iesp.share.t_RiskIndicator)) &
	IF(	'01777002' in set (layout,uid+resultcode), DATASET([{'7002',getRCdesc('7002')}],iesp.share.t_RiskIndicator)) &	// do I check hphone or mphone here?
	IF(	'06197003' in set (layout,uid+resultcode), DATASET([{'7003',getRCdesc('7003')}],iesp.share.t_RiskIndicator)) &	// do I check hphone or mphone here?
	IF(	'06197001' in set (layout,uid+resultcode), DATASET([{'7111',getRCdesc('7111')}],iesp.share.t_RiskIndicator)) &
	IF(	'06197002' in set (layout,uid+resultcode), DATASET([{'7112',getRCdesc('7112')}],iesp.share.t_RiskIndicator)) &
	IF(	('8100' in set (layout,resultcode) or
			'01657002' in set (layout,uid+resultcode) or
			'01667002' in set (layout,uid+resultcode) or
			'01677002' in set (layout,uid+resultcode) or
			'01687002' in set (layout,uid+resultcode)) and ~isFirst and fnamePop, DATASET([{'8100',getRCdesc('8100')}],iesp.share.t_RiskIndicator)) &
	IF(	'8101' in set (layout,resultcode) and ~isLast and lnamePop, DATASET([{'8101',getRCdesc('8101')}],iesp.share.t_RiskIndicator)) &
	IF(	'8102' in set (layout,resultcode), DATASET([{'8102',getRCdesc('8102')}],iesp.share.t_RiskIndicator)) &
	IF(	'8104' in set (layout,resultcode) and gender <> '(unknown)', DATASET([{'8104',getRCdesc('8104')}],iesp.share.t_RiskIndicator)) &
	IF(	('7009' in set (layout,resultcode) or
			'8111' in set (layout,resultcode)) and ~isDOB and dobPop, DATASET([{'8111',getRCdesc('8111')}],iesp.share.t_RiskIndicator)) &	// can I just say ~isDOB
	IF(	'8120' in set (layout,resultcode) and ~isID and natIDPop, DATASET([{'8120',getRCdesc('8120')}],iesp.share.t_RiskIndicator)) &	// can I just say ~isID
	IF(	('01777003' in set (layout,uid+resultcode) or
			'01948150' in set (layout,uid+resultcode) or
			'01677004' in set (layout,uid+resultcode) or
			'02038150' in set (layout,uid+resultcode) or
			'01677011' in set (layout,uid+resultcode)) and ~isLPhone and lPhonePop, DATASET([{'8150',getRCdesc('8150')}],iesp.share.t_RiskIndicator)) &	// can I just say ~lPhone
	IF(	('01958150' in set (layout,uid+resultcode) or
			'01687004' in set (layout,uid+resultcode) or
			'01687011' in set (layout,uid+resultcode) or
			'02048150' in set (layout,uid+resultcode)) and ~isMPhone and mPhonePop, DATASET([{'8151',getRCdesc('8151')}],iesp.share.t_RiskIndicator)) &	// can I just say ~isMPhone
	IF(	('01777003' in set (layout,uid+resultcode) or
			'01928150' in set (layout,uid+resultcode) or
			'01938150' in set (layout,uid+resultcode) or
			'02038150' in set (layout,uid+resultcode) or
			'02048150' in set (layout,uid+resultcode)) and ((~isLPhone and lPhonePop) or (~isMPhone and mPhonePop)) and
			~(('01777003' in set (layout,uid+resultcode) or
			'01948150' in set (layout,uid+resultcode) or
			'01947004' in set (layout,uid+resultcode) or
			'02038150' in set (layout,uid+resultcode) or
			'01947011' in set (layout,uid+resultcode) or
			'01677011' in set (layout,uid+resultcode)) and ~isLPhone and lPhonePop) and
			~(('01957011' in set (layout,uid+resultcode) or
			'01958150' in set (layout,uid+resultcode) or
			'01957004' in set (layout,uid+resultcode) or
			'01687011' in set (layout,uid+resultcode) or
			'02048150' in set (layout,uid+resultcode)) and ~isMPhone and mPhonePop), DATASET([{'8152',getRCdesc('8152')}],iesp.share.t_RiskIndicator)) &
	IF(	'8242' in set (layout,resultcode), DATASET([{'8242',getRCdesc('8242')}],iesp.share.t_RiskIndicator)) &
	IF(	'8243' in set (layout,resultcode), DATASET([{'8243',getRCdesc('8243')}],iesp.share.t_RiskIndicator)) &
	IF(	'8252' in set (layout,resultcode), DATASET([{'8252',getRCdesc('8252')}],iesp.share.t_RiskIndicator)) &
	IF(	'8253' in set (layout,resultcode), DATASET([{'8253',getRCdesc('8253')}],iesp.share.t_RiskIndicator)) &
	IF(	'8254' in set (layout,resultcode), DATASET([{'8254',getRCdesc('8254')}],iesp.share.t_RiskIndicator)) &
	IF(	('8260' in set (layout,resultcode) or
			'01777001' in set (layout,uid+resultcode) or
			'01657011' in set (layout,uid+resultcode) or
			'01667011' in set (layout,uid+resultcode)) and ~isAddr and addrPop, DATASET([{'8260',getRCdesc('8260')}],iesp.share.t_RiskIndicator)) &	// can I just say ~isAddr?
	IF(	'8262' in set (layout,resultcode) and ~isAddr and addrPop, DATASET([{'8262',getRCdesc('8262')}],iesp.share.t_RiskIndicator)) &
	IF(	'8263' in set (layout,resultcode) and ~isAddr and addrPop, DATASET([{'8263',getRCdesc('8263')}],iesp.share.t_RiskIndicator)) &
	IF(	'8264' in set (layout,resultcode) and ~isAddr and addrPop, DATASET([{'8264',getRCdesc('8264')}],iesp.share.t_RiskIndicator)) &
	IF(	'8265' in set (layout,resultcode) and ~isAddr and addrPop, DATASET([{'8265',getRCdesc('8265')}],iesp.share.t_RiskIndicator)) &
	IF(	'8266' in set (layout,resultcode) and ~isAddr and addrPop, DATASET([{'8266',getRCdesc('8266')}],iesp.share.t_RiskIndicator)) &
	IF(	'9500' in set (layout,resultcode), DATASET([{'9500',getRCdesc('9500')}],iesp.share.t_RiskIndicator)) &	// may need to check something here
	// need an L0IA
	// need an L0IE
	// need an L0IG
	IF(	('02136000' in set (layout,uid+resultcode) or
			'02146000' in set (layout,uid+resultcode) or
			'02156000' in set (layout,uid+resultcode) or
			'01654111' in set (layout,uid+resultcode) or
			'01664111' in set (layout,uid+resultcode) or
			'01674111' in set (layout,uid+resultcode) or
			'01684111' in set (layout,uid+resultcode)) and (~isFirst or ~isLast or ~isAddr or ~isLPhone or ~isMPhone or ~isDOB or ~isID), DATASET([{'6000',getRCdesc('6000')}],iesp.share.t_RiskIndicator)) &
	IF(	'6100' in set (layout,resultcode) and ~isFirst and fnamePop, DATASET([{'6100',getRCdesc('6100')}],iesp.share.t_RiskIndicator)) &
	IF(	'6101' in set (layout,resultcode) and ~IsLast and lnamePop, DATASET([{'6101',getRCdesc('6101')}],iesp.share.t_RiskIndicator)) &
	IF(	'6102' in set (layout,resultcode), DATASET([{'6102',getRCdesc('6102')}],iesp.share.t_RiskIndicator)) &
	IF(	'6104' in set (layout,resultcode), DATASET([{'6104',getRCdesc('6104')}],iesp.share.t_RiskIndicator)) &
	IF(	'6111' in set (layout,resultcode) and ~isDOB and dobPop, DATASET([{'6111',getRCdesc('6111')}],iesp.share.t_RiskIndicator)) &
	IF(	'6120' in set (layout,resultcode) and ~isID and natIDPop, DATASET([{'6120',getRCdesc('6120')}],iesp.share.t_RiskIndicator)) &
	IF(	('01946150' in set (layout,uid+resultcode) or
			'02036150' in set (layout,uid+resultcode)) and ~isLPhone and lPhonePop, DATASET([{'6150',getRCdesc('6150')}],iesp.share.t_RiskIndicator)) &	// need to add Ireland mobile validation codes?
	IF(	('01956150' in set (layout,uid+resultcode) or
			'01876150' in set (layout,uid+resultcode) or
			'02046150' in set (layout,uid+resultcode)) and ~isMPhone and mPhonePop, DATASET([{'6151',getRCdesc('6151')}],iesp.share.t_RiskIndicator)) &
	IF(	('01926150' in set (layout,uid+resultcode) or
			'01936150' in set (layout,uid+resultcode) or
			'02016150' in set (layout,uid+resultcode) or
			'02026150' in set (layout,uid+resultcode)) and ((~isLPhone and lPhonePop) or (~isMPhone and mPhonePop)) and
			~(('01946150' in set (layout,uid+resultcode) or
			'02036150' in set (layout,uid+resultcode)) and ~isLPhone and lPhonePop) and
			~(('01956150' in set (layout,uid+resultcode) or
			'02046150' in set (layout,uid+resultcode)) and ~isMPhone and mPhonePop), DATASET([{'6152',getRCdesc('6152')}],iesp.share.t_RiskIndicator)) &
	IF(	'6240' in set (layout,resultcode), DATASET([{'6240',getRCdesc('6240')}],iesp.share.t_RiskIndicator)) &
	IF(	'6250' in set (layout,resultcode), DATASET([{'6250',getRCdesc('6250')}],iesp.share.t_RiskIndicator)) &
	IF(	'6260' in set (layout,resultcode) and ~isAddr and addrPop, DATASET([{'6260',getRCdesc('6260')}],iesp.share.t_RiskIndicator)) &
	IF(	'6261' in set (layout,resultcode) and ~isAddr and addrPop, DATASET([{'6261',getRCdesc('6261')}],iesp.share.t_RiskIndicator)) &
	IF(	'6262' in set (layout,resultcode), DATASET([{'6262',getRCdesc('6262')}],iesp.share.t_RiskIndicator)) &
	IF(	'6263' in set (layout,resultcode), DATASET([{'6263',getRCdesc('6263')}],iesp.share.t_RiskIndicator)) &
	IF(	'6264' in set (layout,resultcode), DATASET([{'6264',getRCdesc('6264')}],iesp.share.t_RiskIndicator)) &
	IF(	'6265' in set (layout,resultcode), DATASET([{'6265',getRCdesc('6265')}],iesp.share.t_RiskIndicator)) &
	IF(	'6266' in set (layout,resultcode), DATASET([{'6266',getRCdesc('6266')}],iesp.share.t_RiskIndicator)) &
	IF(	'4100' in set (layout,resultcode) and isFirst, DATASET([{'4100',getRCdesc('4100')}],iesp.share.t_RiskIndicator)) &	// how do we check for a full match?
	IF(	'4101' in set (layout,resultcode) and isLast, DATASET([{'4101',getRCdesc('4101')}],iesp.share.t_RiskIndicator)) &		// how do we check for a full match?
	IF(	'4102' in set (layout,resultcode), DATASET([{'4102',getRCdesc('4102')}],iesp.share.t_RiskIndicator)) &
	IF(	('02134111' in set (layout,uid+resultcode) or
			'02144111' in set (layout,uid+resultcode) or
			'02154111' in set (layout,uid+resultcode)) and isDOB, DATASET([{'4111',getRCdesc('4111')}],iesp.share.t_RiskIndicator)) &	// how do we check for a full match?
	IF(	'4112' in set (layout,resultcode) and isFirst, DATASET([{'4112',getRCdesc('4112')}],iesp.share.t_RiskIndicator)) &				// how do we check for a full match?
	IF(	'4115' in set (layout,resultcode) and isFirst, DATASET([{'4115',getRCdesc('4115')}],iesp.share.t_RiskIndicator)) &				// how do we check for a full match?
	IF(	'4120' in set (layout,resultcode) and isID, DATASET([{'4120',getRCdesc('4120')}],iesp.share.t_RiskIndicator)) &						// how do we check for a full match?
	IF(	('01944150' in set (layout,uid+resultcode) or
			'02034150' in set (layout,uid+resultcode)) and isLPhone, DATASET([{'4150',getRCdesc('4150')}],iesp.share.t_RiskIndicator)) &
	IF(	('01954150' in set (layout,uid+resultcode) or
			'02044150' in set (layout,uid+resultcode)) and isMPhone, DATASET([{'4151',getRCdesc('4151')}],iesp.share.t_RiskIndicator)) &
	IF(	('01924150' in set (layout,uid+resultcode) or
			'01934150' in set (layout,uid+resultcode) or
			'02024150' in set (layout,uid+resultcode) or
			'02034150' in set (layout,uid+resultcode)) and (isLPhone or isMPhone) and 
			~(('01944150' in set (layout,uid+resultcode) or
			'02034150' in set (layout,uid+resultcode)) and isLPhone) and
			~(('01954150' in set (layout,uid+resultcode) or
			'02044150' in set (layout,uid+resultcode)) and isMPhone), DATASET([{'4152',getRCdesc('4152')}],iesp.share.t_RiskIndicator)) &	// do not return 4152 if either 4150 or 4151
	IF(	'4260' in set (layout,resultcode) and isAddr, DATASET([{'4260',getRCdesc('4260')}],iesp.share.t_RiskIndicator)) &	// how do we check for a full match?
	IF(	'4262' in set (layout,resultcode), DATASET([{'4262',getRCdesc('4262')}],iesp.share.t_RiskIndicator)) &	
	IF(	'4263' in set (layout,resultcode), DATASET([{'4263',getRCdesc('4263')}],iesp.share.t_RiskIndicator)) &
	IF(	'4264' in set (layout,resultcode), DATASET([{'4264',getRCdesc('4264')}],iesp.share.t_RiskIndicator)) &
	IF(	'4265' in set (layout,resultcode), DATASET([{'4265',getRCdesc('4265')}],iesp.share.t_RiskIndicator)) &
	IF(	'4266' in set (layout,resultcode), DATASET([{'4266',getRCdesc('4266')}],iesp.share.t_RiskIndicator)) &
	IF(	'0100' in set (layout,resultcode) or
			'0600' in set (layout,resultcode) or
			'01650102' in set (layout,uid+resultcode) or 
			'01660102' in set (layout,uid+resultcode) or 
			'01670102' in set (layout,uid+resultcode) or
			'01680102' in set (layout,uid+resultcode) or
			'01690102' in set (layout,uid+resultcode) or
			'01770101' in set (layout,uid+resultcode), DATASET([{'0100',getRCdesc('0100')}],iesp.share.t_RiskIndicator)) &
	IF(	'01920101' in set (layout,uid+resultcode) or
			'01930101' in set (layout,uid+resultcode) or
			'01940101' in set (layout,uid+resultcode) or
			'01950101' in set (layout,uid+resultcode) or
			'02100101' in set (layout,uid+resultcode) or
			'02020101' in set (layout,uid+resultcode) or
			'02030101' in set (layout,uid+resultcode) or
			'02040101' in set (layout,uid+resultcode) or
			'02050101' in set (layout,uid+resultcode) or
			'0601' in set (layout,resultcode) or
			'01770103' in set (layout,uid+resultcode) or
			'01770102' in set (layout,uid+resultcode), DATASET([{'0101',getRCdesc('0101')}],iesp.share.t_RiskIndicator)) &
	IF(	'01920102' in set (layout,uid+resultcode) or
			'01930102' in set (layout,uid+resultcode) or
			'01940102' in set (layout,uid+resultcode) or
			'01950102' in set (layout,uid+resultcode) or
			'02050102' in set (layout,uid+resultcode), DATASET([{'0102',getRCdesc('0102')}],iesp.share.t_RiskIndicator)) &
	IF(	'01650103' in set (layout,uid+resultcode) or
			'01660103' in set (layout,uid+resultcode), DATASET([{'0103',getRCdesc('0103')}],iesp.share.t_RiskIndicator)) &
	IF(	'0410' in set (layout,resultcode) or
			'0910' in set (layout,resultcode) or
			'01650111' in set (layout,uid+resultcode) or
			'01660111' in set (layout,uid+resultcode) or
			'01670111' in set (layout,uid+resultcode) or
			'01680111' in set (layout,uid+resultcode) or
			'01770104' in set (layout,uid+resultcode), DATASET([{'0104',getRCdesc('0104')}],iesp.share.t_RiskIndicator)) &		
	IF(	'01770105' in set (layout,uid+resultcode) or
			'01920260' in set (layout,uid+resultcode) or
			'01930260' in set (layout,uid+resultcode), DATASET([{'0105',getRCdesc('0105')}],iesp.share.t_RiskIndicator)) &
	IF(	'0106' in set (layout,resultcode) or
			'02130915' in set (layout,uid+resultcode), DATASET([{'0106',getRCdesc('0106')}],iesp.share.t_RiskIndicator)) &
	IF(	'0109' in set (layout,resultcode) or
			'02140916' in set (layout,uid+resultcode) or
			'02150916' in set (layout,uid+resultcode), DATASET([{'0916',getRCdesc('0916')}],iesp.share.t_RiskIndicator)) &
	IF(	'06190112' in set (layout,uid+resultcode) or
			'01650113' in set (layout,uid+resultcode) or
			'01660113' in set (layout,uid+resultcode), DATASET([{'0112',getRCdesc('0112')}],iesp.share.t_RiskIndicator)) &
	IF(	'0606' in set (layout,resultcode) or
			'06190113' in set (layout,uid+resultcode) or
			'01650123' in set (layout,uid+resultcode) or
			'01660123' in set (layout,uid+resultcode), DATASET([{'0113',getRCdesc('0113')}],iesp.share.t_RiskIndicator)) &
	IF(	'0607' in set (layout,resultcode) or
			'06190114' in set (layout,uid+resultcode) or
			'01650133' in set (layout,uid+resultcode) or
			'01660133' in set (layout,uid+resultcode), DATASET([{'0114',getRCdesc('0114')}],iesp.share.t_RiskIndicator)) &
	IF(	'0605' in set (layout,resultcode), DATASET([{'0605',getRCdesc('0605')}],iesp.share.t_RiskIndicator)) &
	IF(	'0650' in set (layout,resultcode), DATASET([{'0650',getRCdesc('0650')}],iesp.share.t_RiskIndicator)) &
	IF(	'01870760' in set (layout,uid+resultcode) or
			'01950260' in set (layout,uid+resultcode) or
			'01870260' in set (layout,uid+resultcode) or
			'01680112' in set (layout,uid+resultcode), DATASET([{'0760',getRCdesc('0760')}],iesp.share.t_RiskIndicator)) &
	IF(	'0912' in set (layout,resultcode), DATASET([{'0912',getRCdesc('0912')}],iesp.share.t_RiskIndicator)) &
	IF(	'0913' in set (layout,resultcode), DATASET([{'0913',getRCdesc('0913')}],iesp.share.t_RiskIndicator)) &
	IF(	'0914' in set (layout,resultcode), DATASET([{'0914',getRCdesc('0914')}],iesp.share.t_RiskIndicator)) &
	IF(	'01670112' in set (layout,uid+resultcode) or
			'01940260' in set (layout,uid+resultcode), DATASET([{'9150',getRCdesc('9150')}],iesp.share.t_RiskIndicator)) ,
cnt)

ENDMACRO;