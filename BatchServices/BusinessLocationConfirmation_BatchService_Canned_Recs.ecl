EXPORT BusinessLocationConfirmation_BatchService_Canned_Recs := 
	DATASET(
		[
// dorothy lane market's fein = 310561868
// burger king's fein = 590787929
//{'acctno','company','fname','mname','lname','fein','prim range','predir','prim name','add. suffix',
// 'postdir','unit desig','sec range','city','state','zip','z4'}
////			{'1','DOROTHY LANE MARKET','','','','','6177','','FAR HILLS','AVE','','ste','1','DAYTON','OH','45420',''},
////			{'777','Northrop Grumman','','','','f1','2555','','university','dr','','ste','1','fairborn','OH','45324',''},
//			{'','abbadabba','','','','','6177','','FAR HILLS','AVE','','ste','1','DAYTON','OH','45420',''},
//			{'2','TRIUNE SOFTWARE, INC.','','','','','4027','','Colonel Glenn','Hwy','','ste','330','BEAVERCREEK','OH','45431',''},
////			{'3','IAMS','','','','','8700','','Mason Montgomery','Rd','','','','Mason','OH','45040',''},
////			{'4','McDonalds','','','','','2111','','McDonald\'s','Dr','','','','Oak Brook','IL','60523',''},
////			{'5','Burger King Corporation','','','','','5505','','Blue Lagoon','Dr','','','','Miami','FL','33126',''},
//			{'','THE IAMS COMPANY','','','','','1300','E','9th','St','','','','Cleveland','OH','44114',''},
////			{'6','','Doug','','Brook','f2','4027','','Colonel Glenn','Hwy','','ste','330','BEAVERCREEK','OH','45431',''},
////			{'7','','Who','R','U','f2','4027','','Colonel Glenn','Hwy','','ste','330','BEAVERCREEK','OH','45431',''},
//			{'222','MERKER ORNAMENTAL IRON','','','','','317','S','FINDLAY','ST','','ste','3','DAYTON','OH','45403',''},
////			{'8','','William','j','merker','','317','S','FINDLAY','ST','','ste','3','DAYTON','OH','45403',''},
////			{'9','LEXISNEXIS','','','','','9443','','SPRINGBORO','','','','','MIAMISBURG','OH','45342',''},
////			{'10','LEXISNEXIS2','','','','f4','','','','','','','','','','',''},
////			{'223','MERKER ORNAMENTAL IRON2','','','','','','','','','','','','','','',''},
//			{'11','','','','','','4027','','Colonel Glenn','Hwy','','ste','330','BEAVERCREEK','OH','45431',''},
////			{'11','','','','','','4027','','Colonel Glenn','Hwy','','ste','330','BEAVERCREEK','OH','',''},
//			{'12','kykfkutglgnbc','','','','','4027','','Colonel Glenn','Hwy','','ste','330','BEAVERCREEK','OH','',''},
////			{'12','kykfkutglgnbc','','','','','4027','','Colonel Glenn','Hwy','','ste','330','','','45431',''},
////			{'13','McThisisntanameandyouknowit','','','','','2111','','McDonald\'s','Dr','','','','Oak Brook','IL','60523',''},
////			{'14','','','','','','9443','','SPRINGBORO','','','','','','','45342',''},
////			{'18','','','','','','777','','nonesense','dr','','','','','','45342',''},
////			{'15','DOROTHY LANE MARKET','','','','310561868','','','','','','','','','','',''},
////			{'16','Burger King Corporation','','','','590787929','','','','','','','','','','',''},
////			{'20','DOROTHY LANE MARKET','','','','310561688','','','','','','','','','','',''},
////			{'21','Burger King Corporation','','','','570987929','','','','','','','','','','',''},
////      {'22','PRINCIPAL LIFE INSURANCE COMPANY','','','','','711','','HIGH','ST','','','','DES MOINES','IA','50392',''},
////      {'23','A-Z RANCH & PET CENTER','','','','','410','','SHOUP','ST','','','','SALMON','ID','83467','4209'},
////      {'24','LOST AND FOUND RECORDS','','','','','715','','CLARENCE','DR','','','','IDAHO FALLS','ID','83402','5685'},
////      {'25','LOST AND FOUND RECORDS','','','','','715','','CLARENCE','DR','','','','','ID','','5685'},

//1	Bocce Grill			690 Northwest 51st Street	Boca Raton 	FL	33431
//2	Circuit City			1400 Glades Rd, Bay 140	Boca Raton 	FL	33431
//3	Circuit City Stores, INC		540493875				
//4	Nordstrom Rack			1400 Glades Rd	Boca Raton 	FL	33431
//5		Patrick Tracy		2240 NW Street Suite 900 	Boca Raton 	FL	33431
//6	ChoicePoint			4530 Conference Way South	Boca Raton 	FL	33431
//7				6000 Glades Road	Boca Raton 	FL	33431
//8	Old Navy 			6000 Glades Road, Suite 100	Boca Raton 	FL	33431
//9	BlueMartini			6000 Glades Road, #C-1380	Boca Raton 	FL	33431
//10	BlueMartini		205716241	477 Rosemary Ave, STE 309	West Palm Beach	FL	33401
//11				5050 Champion Blvd 	Boca Raton 	FL	33496
//12	Cheeseburger Cheeseburger			5030 Champion Blvd 	Boca Raton 	FL	33496
//13		Loon Wuen		5030 Champion Blvd, #B1	Boca Raton 	FL	33496
//14	Wok Out			5030 Champion Blvd, #B1	Boca Raton 	Boca Raton 	33496
//15				4975 Linton Blvd	Delray Beach	FL	33445
//16	Commerce Bank			4975 Linton Blvd	Delray Beach	FL	33445
//17	Palm Beach County Bank INC			4975 Linton Blvd	Delray Beach	FL	33445
//18	TD Bank NA			4975 Linton Blvd	Delray Beach	FL	33445
      {'101','Bocce Grill','','','','','690','nw','51st','st','','','','Boca Raton','fl','33431',''},
      {'102','Circuit City','','','','','1400','','Glades','rd','','bay','140','Boca Raton','fl','33431',''},
      {'103','Circuit City Stores, INC','','','','540493875','','','','','','','','','','',''},
      {'104','Nordstrom Rack','','','','','1400','','Glades','rd','','','','Boca Raton','fl','33431',''},
      {'105','','Tracy','','Patrick','','2240','nw','19th','st','','ste','900','Boca Raton','fl','33431',''},
      {'106','ChoicePoint','','','','','4530','','Conference','way','s','','','Boca Raton','fl','33431',''},
      {'107','','','','','','6000','','Glades','rd','','','','Boca Raton','fl','33431',''},
      {'108','Old Navy','','','','','6000','','Glades','rd','','ste','100','Boca Raton','fl','33431',''},
      {'109','BlueMartini','','','','','6000','','Glades','rd','','#','C-1380','Boca Raton','fl','33431',''},
      {'110','BlueMartini','','','','205716241','477','','Rosemary','ave','','ste','309','West Palm Beach','fl','33401',''},
      {'111','','','','','','5050','','Champion','blvd','','','','Boca Raton','fl','33469',''},
      {'112','Cheeseburger Cheeseburger','','','','','5030','','Champion','blvd','','','','Boca Raton','fl','33469',''},
      {'113','','Wuen','','Loon','','5030','','Champion','blvd','','#','B1','Boca Raton','fl','33469',''},
      {'114','Wok Out','','','','','5030','','Champion','blvd','','#','B1','Boca Raton','Boca Raton','33469',''},
      {'115','','','','','','4975','','Linton','blvd','','','','Delray Beach','fl','33445',''},
      {'116','Commerce Bank','','','','','4975','','Linton','blvd','','','','Delray Beach','fl','33445',''},
      {'117','Palm Beach County Bank INC','','','','','4975','','Linton','blvd','','','','Delray Beach','fl','33445',''},
      {'118','TD Bank NA','','','','','4975','','Linton','blvd','','','','Delray Beach','fl','33445',''}
		],
		BatchServices.BusinessLocationConfirmation_BatchService_Layouts.Input
	);
	
/* Invoke like this in a BW:

	#STORED('batch_in', BatchServices.BusinessLocationConfirmation_BatchService_Canned_Recs)
	BatchServices.BusinessLocationConfirmation_BatchService()
	
*/