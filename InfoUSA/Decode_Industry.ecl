export Decode_Industry (string7 Industry) := 
case(Industry,
			'554101A'=>'E85 GASOLINE',
			'581206a'=>'HUNGARIAN',
			'581206b'=>'CZECHOSLOVAKIAN',
			'581206c'=>'RUSSIAN/UKRAINIAN',
			'581206d'=>'POLISH',
			'581206A'=>'BISTRO',
			'581206B'=>'BREW PUB',
			'581206C'=>'CHINESE',
			'581206D'=>'DELI',
			'581206E'=>'BARBECUE',
			'581206F'=>'INDIAN',
			'581206G'=>'CAJUN',
			'581206H'=>'SOUL FOOD',
			'581206I'=>'ITALIAN',
			'581206J'=>'JAPANESE',
			'581206K'=>'KOREAN',
			'581206L'=>'CARIBBEAN',
			'581206M'=>'IRISH',
			'581206N'=>'KOSHER',
			'581206P'=>'PIZZA',
			'581206Q'=>'SWISS',
			'581206R'=>'MIDDLE EASTERN',
			'581206S'=>'SPANISH',
			'581206T'=>'THAI',
			'581206U'=>'CONTINENTAL',
			'581206V'=>'MEXICAN',
			'581206W'=>'VIETNAMESE',
			'581206Y'=>'ORIENTAL',
			'581206Z'=>'SEAFOOD',
			'5812060'=>'STEAK HOUSES',
			'5812061'=>'FRENCH',
			'5812062'=>'GERMAN',
			'5812063'=>'AMERICAN',
			'5812064'=>'VEGETARIAN',
			'5812065'=>'JAMAICAN',
			'5812066'=>'PERUVIAN',
			'5812067'=>'PORTUGUESE',
			'5812068'=>'HAWAIIAN',
			'5812069'=>'GREEK',
			'581208a'=>'HUNGARIAN',
			'581208b'=>'CZECHOSLOVAKIAN',
			'581208c'=>'RUSSIAN/UKRAINIAN',
			'581208d'=>'POLISH',
			'581208A'=>'BISTRO',
			'581208B'=>'BREW PUB',
			'581208C'=>'CHINESE',
			'581208D'=>'DELI',
			'581208E'=>'BARBECUE',
			'581208F'=>'INDIAN',
			'581208G'=>'CAJUN',
			'581208H'=>'SOUL FOOD',
			'581208I'=>'ITALIAN',
			'581208J'=>'JAPANESE',
			'581208K'=>'KOREAN',
			'581208L'=>'CARIBBEAN',
			'581208M'=>'IRISH',
			'581208N'=>'KOSHER',
			'581208P'=>'PIZZA',
			'581208Q'=>'SWISS',
			'581208R'=>'MIDDLE EASTERN',
			'581208S'=>'SPANISH',
			'581208T'=>'THAI',
			'581208U'=>'CONTINENTAL',
			'581208V'=>'MEXICAN',
			'581208W'=>'VIETNAMESE',
			'581208Y'=>'ORIENTAL',
			'581208Z'=>'SEAFOOD',
			'5812080'=>'STEAK HOUSES',
			'5812081'=>'FRENCH',
			'5812082'=>'GERMAN',
			'5812083'=>'AMERICAN',
			'5812084'=>'VEGETARIAN',
			'5812085'=>'JAMAICAN',
			'5812086'=>'PERUVIAN',
			'5812087'=>'PORTUGUESE',
			'5812088'=>'HAWAIIAN',
			'5812089'=>'GREEK',
			'591205I'=>'INDEPENDENT DRUG STORE',
			'591205M'=>'MULTIPLE LOCATION CHAIN DRUG STORE',
			'602101A'=>'$1,000 - 499,999 IN ASSETS',
			'602101B'=>'$500,000 - 999,999 IN ASSETS',
			'602101C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'602101D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'602101E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'602101F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'602101G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'602101H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'602101I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'602101J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'602101K'=>'OVER $1 BILLION IN ASSETS',
			'602102A'=>'$1,000 - 499,999 IN ASSETS',
			'602102B'=>'$500,000 - 999,999 IN ASSETS',
			'602102C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'602102D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'602102E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'602102F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'602102G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'602102H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'602102I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'602102J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'602102K'=>'OVER $1 BILLION IN ASSETS',
			'602201A'=>'$1 - 499,999 IN ASSETS',
			'602201B'=>'$500,000 - 999,999 IN ASSETS',
			'602201C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'602201D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'602201E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'602201F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'602201G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'602201H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'602201I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'602201J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'602201K'=>'OVER $1 BILLION IN ASSETS',
			'602999A'=>'$1,000 - 499,999 IN ASSETS',
			'602999B'=>'$500,000 - 999,999 IN ASSETS',
			'602999C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'602999D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'602999E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'602999F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'602999G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'602999H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'602999I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'602999J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'602999K'=>'OVER $1 BILLION IN ASSETS',
			'603501A'=>'$1,000 - 499,999 IN ASSETS',
			'603501B'=>'$500,000 - 999,999 IN ASSETS',
			'603501C'=>'$1,000,000 - 2,499,000 IN ASSETS',
			'603501D'=>'$2,500,000 - 4,999,000 IN ASSETS',
			'603501E'=>'$5,000,000 - 9,999,000 IN ASSETS',
			'603501F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'603501G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'603501H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'603501I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'603501J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'603501K'=>'OVER $1 BILLION IN ASSETS',
			'603502A'=>'$1,000 - 499,999 IN ASSETS',
			'603502B'=>'$500,000 - 999,999 IN ASSETS',
			'603502C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'603502D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'603502E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'603502F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'603502G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'603502H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'603502I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'603502J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'603502K'=>'OVER $1 BILLION IN ASSETS',
			'603503A'=>'$1,000 - 499,999 IN ASSETS',
			'603503B'=>'$500,000 - 999,999 IN ASSETS',
			'603503C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'603503D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'603503E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'603503F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'603503G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'603503H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'603503I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'603503J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'603503K'=>'OVER $1 BILLION IN ASSETS',
			'603504A'=>'$1,000 - 499,999 IN ASSETS',
			'603504B'=>'$500,000 - 999,999 IN ASSETS',
			'603504C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'603504D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'603504E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'603504F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'603504G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'603504H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'603504I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'603504J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'603504K'=>'OVER $1 BILLION IN ASSETS',
			'603698A'=>'$1,000 - 499,999 IN ASSETS',
			'603698B'=>'$500,000 - 999,999 IN ASSETS',
			'603698C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'603698D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'603698E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'603698F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'603698G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'603698H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'603698I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'603698J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'603698K'=>'OVER $1 BILLION IN ASSETS',
			'606101A'=>'$1,000 - 499,999 IN ASSETS',
			'606101B'=>'$500,000 - 999,999 IN ASSETS',
			'606101C'=>'$1,000,000 - 2,499,000 IN ASSETS',
			'606101D'=>'$2,500,000 - 4,999,000 IN ASSETS',
			'606101E'=>'$5,000,000 - 9,999,000 IN ASSETS',
			'606101F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'606101G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'606101H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'606101I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'606101J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'606101K'=>'OVER $1 BILLION IN ASSETS',
			'606102A'=>'$1,000 - 499,999 IN ASSETS',
			'606102B'=>'$500,000 - 999,999 IN ASSETS',
			'606102C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'606102D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'606102E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'606102F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'606102G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'606102H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'606102I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'606102J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'606102K'=>'OVER $1 BILLION IN ASSETS',
			'606103A'=>'$1,000 - 499,999 IN ASSETS',
			'606103B'=>'$500,000 - 999,999 IN ASSETS',
			'606103C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'606103D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'606103E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'606103F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'606103G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'606103H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'606103I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'606103J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'606103K'=>'OVER $1 BILLION IN ASSETS',
			'606104A'=>'$1,000 - 499,999 IN ASSETS',
			'606104B'=>'$500,000 - 999,999 IN ASSETS',
			'606104C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'606104D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'606104E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'606104F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'606104G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'606104H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'606104I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'606104J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'606104K'=>'OVER $1 BILLION IN ASSETS',
			'606298A'=>'$1,000 - 499,999 IN ASSETS',
			'606298B'=>'$500,000 - 999,999 IN ASSETS',
			'606298C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'606298D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'606298E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'606298F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'606298G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'606298H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'606298I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'606298J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'606298K'=>'OVER $1 BILLION IN ASSETS',
			'608198A'=>'$1,000 - 499,999 IN ASSETS',
			'608198B'=>'$500,000 - 999,999 IN ASSETS',
			'608198C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'608198D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'608198E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'608198F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'608198G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'608198H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'608198I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'608198J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'608198K'=>'OVER $1 BILLION IN ASSETS',
			'608298A'=>'$1,000 - 499,999 IN ASSETS',
			'608298B'=>'$500,000 - 999,999 IN ASSETS',
			'608298C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'608298D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'608298E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'608298F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'608298G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'608298H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'608298I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'608298J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'608298K'=>'OVER $1 BILLION IN ASSETS',
			'611198A'=>'$1,000 - 499,999 IN ASSETS',
			'611198B'=>'$500,000 - 999,999 IN ASSETS',
			'611198C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'611198D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'611198E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'611198F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'611198G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'611198H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'611198I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'611198J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'611198K'=>'OVER $1 BILLION IN ASSETS',
			'614101A'=>'$1,000 - 499,999 IN ASSETS',
			'614101B'=>'$500,000 - 999,999 IN ASSETS',
			'614101C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'614101D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'614101E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'614101F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'614101G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'614101H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'614101I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'614101J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'614101K'=>'OVER $1 BILLION IN ASSETS',
			'614102A'=>'$1,000 - 499,999 IN ASSETS',
			'614102B'=>'$500,000 - 999,999 IN ASSETS',
			'614102C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'614102D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'614102E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'614102F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'614102G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'614102H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'614102I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'614102J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'614102K'=>'OVER $1 BILLION IN ASSETS',
			'614103A'=>'$1,000 - 499,999 IN ASSETS',
			'614103B'=>'$500,000 - 999,999 IN ASSETS',
			'614103C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'614103D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'614103E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'614103F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'614103G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'614103H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'614103I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'614103J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'614103K'=>'OVER $1 BILLION IN ASSETS',
			'614104A'=>'$1,000 - 499,999 IN ASSETS',
			'614104B'=>'$500,000 - 999,999 IN ASSETS',
			'614104C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'614104D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'614104E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'614104F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'614104G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'614104H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'614104I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'614104J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'614104K'=>'OVER $1 BILLION IN ASSETS',
			'614106A'=>'$1,000 - 499,999 IN ASSETS',
			'614106B'=>'$500,000 - 999,999 IN ASSETS',
			'614106C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'614106D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'614106E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'614106F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'614106G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'614106H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'614106I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'614106J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'614106K'=>'OVER $1 BILLION IN ASSETS',
			'615301A'=>'$1,000 - 499,999 IN ASSETS',
			'615301B'=>'$500,000 - 999,999 IN ASSETS',
			'615301C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'615301D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'615301E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'615301F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'615301G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'615301H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'615301I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'615301J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'615301K'=>'OVER $1 BILLION IN ASSETS',
			'615303A'=>'$1,000 - 499,999 IN ASSETS',
			'615303B'=>'$500,000 - 999,999 IN ASSETS',
			'615303C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'615303D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'615303E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'615303F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'615303G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'615303H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'615303I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'615303J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'615303K'=>'OVER $1 BILLION IN ASSETS',
			'615304A'=>'$1,000 - 499,999 IN ASSETS',
			'615304B'=>'$500,000 - 999,999 IN ASSETS',
			'615304C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'615304D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'615304E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'615304F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'615304G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'615304H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'615304I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'615304J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'615304K'=>'OVER $1 BILLION IN ASSETS',
			'615305A'=>'$1,000 - 499,999 IN ASSETS',
			'615305B'=>'$500,000 - 999,999 IN ASSETS',
			'615305C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'615305D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'615305E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'615305F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'615305G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'615305H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'615305I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'615305J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'615305K'=>'OVER $1 BILLION IN ASSETS',
			'615998A'=>'$1,000 - 499,999 IN ASSETS',
			'615998B'=>'$500,000 - 999,999 IN ASSETS',
			'615998C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'615998D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'615998E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'615998F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'615998G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'615998H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'615998I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'615998J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'615998K'=>'OVER $1 BILLION IN ASSETS',
			'615999A'=>'$1,000 - 499,999 IN ASSETS',
			'615999B'=>'$500,000 - 999,999 IN ASSETS',
			'615999C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'615999D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'615999E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'615999F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'615999G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'615999H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'615999I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'615999J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'615999K'=>'OVER $1 BILLION IN ASSETS',
			'616201A'=>'$1,000 - 499,999 IN ASSETS',
			'616201B'=>'$500,000 - 999,999 IN ASSETS',
			'616201C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'616201D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'616201E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'616201F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'616201G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'616201H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'616201I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'616201J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'616201K'=>'OVER $1 BILLION IN ASSETS',
			'628202A'=>'$1,000 - 499,999 IN ASSETS',
			'628202B'=>'$500,000 - 999,999 IN ASSETS',
			'628202C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'628202D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'628202E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'628202F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'628202G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'628202H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'628202I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'628202J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'628202K'=>'OVER $1 BILLION IN ASSETS',
			'628203A'=>'$1,000 - 499,999 IN ASSETS',
			'628203B'=>'$500,000 - 999,999 IN ASSETS',
			'628203C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'628203D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'628203E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'628203F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'628203G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'628203H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'628203I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'628203J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'628203K'=>'OVER $1 BILLION IN ASSETS',
			'628204A'=>'$1,000 - 499,999 IN ASSETS',
			'628204B'=>'$500,000 - 999,999 IN ASSETS',
			'628204C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'628204D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'628204E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'628204F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'628204G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'628204H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'628204I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'628204J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'628204K'=>'OVER $1 BILLION IN ASSETS',
			'628205A'=>'$1,000 - 499,999 IN ASSETS',
			'628205B'=>'$500,000 - 999,999 IN ASSETS',
			'628205C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'628205D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'628205E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'628205F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'628205G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'628205H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'628205I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'628205J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'628205K'=>'OVER $1 BILLION IN ASSETS',
			'628206A'=>'$1,000 - 499,999 IN ASSETS',
			'628206B'=>'$500,000 - 999,999 IN ASSETS',
			'628206C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'628206D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'628206E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'628206F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'628206G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'628206H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'628206I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'628206J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'628206K'=>'OVER $1 BILLION IN ASSETS',
			'671201A'=>'$1,000 - 499,999 IN ASSETS',
			'671201B'=>'$500,000 - 999,999 IN ASSETS',
			'671201C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'671201D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'671201E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'671201F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'671201G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'671201H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'671201I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'671201J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'671201K'=>'OVER $1 BILLION IN ASSETS',
			'672201A'=>'$1,000 - 499,999 IN ASSETS',
			'672201B'=>'$500,000 - 999,999 IN ASSETS',
			'672201C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'672201D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'672201E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'672201F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'672201G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'672201H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'672201I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'672201J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'672201K'=>'OVER $1 BILLION IN ASSETS',
			'672298A'=>'$1,000 - 499,999 IN ASSETS',
			'672298B'=>'$500,000 - 999,999 IN ASSETS',
			'672298C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'672298D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'672298E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'672298F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'672298G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'672298H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'672298I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'672298J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'672298K'=>'OVER $1 BILLION IN ASSETS',
			'673298A'=>'$1,000 - 499,999 IN ASSETS',
			'673298B'=>'$500,000 - 999,999 IN ASSETS',
			'673298C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'673298D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'673298E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'673298F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'673298G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'673298H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'673298I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'673298J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'673298K'=>'OVER $1 BILLION IN ASSETS',
			'673301A'=>'$1,000 - 499,999 IN ASSETS',
			'673301B'=>'$500,000 - 999,999 IN ASSETS',
			'673301C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'673301D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'673301E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'673301F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'673301G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'673301H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'673301I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'673301J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'673301K'=>'OVER $1 BILLION IN ASSETS',
			'673306A'=>'$1,000 - 499,999 IN ASSETS',
			'673306B'=>'$500,000 - 999,999 IN ASSETS',
			'673306C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'673306D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'673306E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'673306F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'673306G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'673306H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'673306I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'673306J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'673306K'=>'OVER $1 BILLION IN ASSETS',
			'679801A'=>'$1,000 - 499,999 IN ASSETS',
			'679801B'=>'$500,000 - 999,999 IN ASSETS',
			'679801C'=>'$1,000,000 - 2,499,999 IN ASSETS',
			'679801D'=>'$2,500,000 - 4,999,999 IN ASSETS',
			'679801E'=>'$5,000,000 - 9,999,999 IN ASSETS',
			'679801F'=>'$10,000,000 - 19,999,999 IN ASSETS',
			'679801G'=>'$20,000,000 - 49,999,999 IN ASSETS',
			'679801H'=>'$50,000,000 - 99,999,999 IN ASSETS',
			'679801I'=>'$100,000,000 - 499,999,999 IN ASSETS',
			'679801J'=>'$500,000,000 - 999,999,999 IN ASSETS',
			'679801K'=>'OVER $1 BILLION IN ASSETS',
			'701101A'=>'1 - 24 ROOMS',
			'701101B'=>'25 - 49 ROOMS',
			'701101C'=>'50 - 99 ROOMS',
			'701101D'=>'100 - 299 ROOMS',
			'701101E'=>'300 - 499 ROOMS',
			'701101F'=>'500 - 999 ROOMS',
			'701101G'=>'OVER 1,000 ROOMS',
			'783201A'=>'MOVIE THEATER DRIVE INN SCREENS',
			'783201B'=>'MOVIE THEATRE SCREENS 2 - 5',
			'783201C'=>'MOVIE THEATER SCREENS 6 - 10',
			'783201D'=>'MOVIE THEATER SCREENS 11 - 15',
			'783201E'=>'MOVIE THEATRE SCREENS 16 +',
			'783201F'=>'IMAX',
			'801104F'=>'FREESTANDING AMBULATORY CENTERS',
			'805101A'=>'1 - 19 BEDS',
			'805101B'=>'20 - 99 BEDS',
			'805101C'=>'100 - 249 BEDS',
			'805101D'=>'250 - 499 BEDS',
			'805101E'=>'500 + BEDS',
			'806202A'=>'1 - 24 BEDS',
			'806202B'=>'25 - 49 BEDS',
			'806202C'=>'50 - 99 BEDS',
			'806202D'=>'100 - 199 BEDS',
			'806202E'=>'200 - 299 BEDS',
			'806202F'=>'300 - 399 BEDS',
			'806202G'=>'400 - 499 BEDS',
			'806202H'=>'500 + BEDS',
			'806202S'=>'HEADQUARTER OF HEALTH CARE SYSTEMS',
			'811103A'=>'ASSOCIATE MEMBER',
			'811103F'=>'FIRM MEMBER OR PARTNER',
			'811103M'=>'MULTIPLE LOCATIONS',
			'821101A'=>'1 - 299 STUDENTS',
			'821101B'=>'300 - 499 STUDENTS',
			'821101C'=>'500 - 999 STUDENTS',
			'821101D'=>'1,000 - 9,999 STUDENTS',
			'821101E'=>'OVER 10,000 STUDENTS',
			'821103A'=>'1 - 299 STUDENTS',
			'821103B'=>'300 - 499 STUDENTS',
			'821103C'=>'500 - 999 STUDENTS',
			'821103D'=>'1,000 - 9,999 STUDENTS',
			'821103E'=>'OVER 10,000 STUDENTS',
			'821198A'=>'1 - 299 STUDENTS',
			'821198B'=>'300 - 499 STUDENTS',
			'821198C'=>'500 - 999 STUDENTS',
			'821198D'=>'1,000 - 9,999 STUDENTS',
			'821198E'=>'OVER 10,000 STUDENTS',
			'822101A'=>'1 - 299 STUDENTS',
			'822101B'=>'300 - 499 STUDENTS',
			'822101C'=>'500 - 999 STUDENTS',
			'822101D'=>'1,000 - 9,999 STUDENTS',
			'822101E'=>'OVER 10,000 STUDENTS',
			'822298A'=>'1 - 299 STUDENTS',
			'822298B'=>'300 - 499 STUDENTS',
			'822298C'=>'500 - 999 STUDENTS',
			'822298D'=>'1,000 - 9,999 STUDENTS',
			'822298E'=>'OVER 10,000 STUDENTS',
			'8231061'=>'1,000 - 10,000 BOOKS',
			'8231062'=>'10,001 - 25,000 BOOKS',
			'8231063'=>'25,001 - 50,000 BOOKS',
			'8231064'=>'50,001 - 100,000 BOOKS',
			'8231065'=>'100,001 - 500,000 BOOKS',
			'8231066'=>'500,001 - 1,000,000 BOOKS',
			'8231067'=>'1,000,001 + BOOKS',
			'8231091'=>'1,000 - 10,000 BOOKS',
			'8231092'=>'10,001 - 25,000 BOOKS',
			'8231093'=>'25,001 - 50,000 BOOKS',
			'8231094'=>'50,001 - 100,000 BOOKS',
			'8231095'=>'100,001 - 500,000 BOOKS',
			'8231096'=>'500,001 - 1,000,000 BOOKS',
			'8231097'=>'1,000,001 + BOOKS',
			'8231111'=>'1,000 - 10,000 BOOKS',
			'8231112'=>'10,001 - 25,000 BOOKS',
			'8231113'=>'25,001 - 50,000 BOOKS',
			'8231114'=>'50,001 - 100,000 BOOKS',
			'8231115'=>'100,001 - 500,000 BOOKS',
			'8231116'=>'500,001 - 1,000,000 BOOKS',
			'8231117'=>'1,000,001 + BOOKS',

			'');