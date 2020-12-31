import Business_Credit,std;

export CalculateDBTV5(dataset(Business_Credit.Layouts.rAccountBase) TradeLines):= function

    rAddRequiredFields:=RECORD
        Business_Credit.Layouts.rAccountBase;
        integer     Cycle_Days_Diff;
        STRING      FunctionalPaymentInterval;        
        STRING      FunctionalDateAccountOpened;
        integer     Internal_Payment_Status;
        integer     Prior_DBT_V5;
        integer     Prior_Payment_Status;
        INTEGER     Prior_ExceptionCycleDays;
        integer     Last_Payment_Status_Before_Exception;
        integer     Last_DBT_V5_Before_Exception;
        INTEGER     Prior_Last_Payment_Status_Before_Exception;
        integer     Prior_Last_DBT_V5_Before_Exception;
        unsigned4   Fixed_Delinquency_Date;
        string     DBT_V5_General_Cap;
        INTEGER     Exception_Cycle_Days;
        integer     Raw_DBT_V5;
        string      DBT_V5;
    END;

    rAddRequiredStringFields:=RECORD
        Business_Credit.Layouts.rAccountBase;
        string     Raw_DBT_V5;
        string     DBT_V5;
    END;

    WithRequiredFields:=project(Tradelines,transform(rAddRequiredFields,self:=left;self:=[];));
    
    SortFile:=sort(distribute(WithRequiredFields,hash(Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,Cycle_End_Date,process_date,local);
	
	GroupFile:=group(Sortfile,Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,LOCAL);
	
	
    rAddRequiredFields tCalculateDBTV5(rAddRequiredFields L,rAddRequiredFields R, integer C):=transform
        
        
        

        IsV5:=if(R.Overall_File_Format_Version[1..2]='05',true,false);

        

        SameCycleEndDate:=if(R.cycle_end_date=L.cycle_end_date,true,false);

        self.FunctionalPaymentInterval:=if(R.payment_interval='',L.FunctionalPaymentInterval,R.payment_interval);
        self.FunctionalDateAccountOpened:=if(R.Date_Account_Opened='',L.FunctionalDateAccountOpened,R.Date_Account_Opened);

        IsMonthly:=if(self.FunctionalPaymentInterval in ['IL','M','IM',''],true,false);

        ChangeInPaymentInterval:=if(self.FunctionalPaymentInterval<>'' and self.FunctionalPaymentInterval<>L.FunctionalPaymentInterval,true,false);
        HasBucket:=(REAL)R.Past_Due_Aging_Amount_Bucket_1<>0 or
                   (REAL)R.Past_Due_Aging_Amount_Bucket_2<>0 or
                   (REAL)R.Past_Due_Aging_Amount_Bucket_3<>0 or
                   (REAL)R.Past_Due_Aging_Amount_Bucket_4<>0 or
                   (REAL)R.Past_Due_Aging_Amount_Bucket_5<>0 or
                   (REAL)R.Past_Due_Aging_Amount_Bucket_6<>0 or
                   (REAL)R.Past_Due_Aging_Amount_Bucket_7<>0;
        PastDueAmountStatus:=map( ABS((REAL)R.Past_Due_Amount - ( (REAL)R.Past_Due_Aging_Amount_Bucket_1))<=7 =>1,
                                  ABS((REAL)R.Past_Due_Amount - ((REAL)R.past_due_aging_amount_bucket_1 + (REAL)R.past_due_aging_amount_bucket_2))<=7   => 2,
                                  ABS((REAL)R.Past_Due_Amount - ((REAL)R.past_due_aging_amount_bucket_1 + (REAL)R.past_due_aging_amount_bucket_2 +  (REAL)R.past_due_aging_amount_bucket_3))<=7   => 3,
                                  ABS((REAL)R.Past_Due_Amount - ((REAL)R.past_due_aging_amount_bucket_1 + (REAL)R.past_due_aging_amount_bucket_2 +  (REAL)R.past_due_aging_amount_bucket_3 +   (REAL)R.past_due_aging_amount_bucket_4))<=7   => 4,
                                  ABS((REAL)R.Past_Due_Amount - ((REAL)R.past_due_aging_amount_bucket_1 + (REAL)R.past_due_aging_amount_bucket_2 +  (REAL)R.past_due_aging_amount_bucket_3 +   (REAL)R.past_due_aging_amount_bucket_4 + (REAL)R.past_due_aging_amount_bucket_5))<=7   => 5,
                                  ABS((REAL)R.Past_Due_Amount - ((REAL)R.past_due_aging_amount_bucket_1 + (REAL)R.past_due_aging_amount_bucket_2 +  (REAL)R.past_due_aging_amount_bucket_3 +   (REAL)R.past_due_aging_amount_bucket_4 + (REAL)R.past_due_aging_amount_bucket_5 + (REAL)R.past_due_aging_amount_bucket_6))<=7   => 6,
                                  ABS((REAL)R.Past_Due_Amount - ((REAL)R.past_due_aging_amount_bucket_1 + (REAL)R.past_due_aging_amount_bucket_2 +  (REAL)R.past_due_aging_amount_bucket_3 +   (REAL)R.past_due_aging_amount_bucket_4 + (REAL)R.past_due_aging_amount_bucket_5 + (REAL)R.past_due_aging_amount_bucket_6 +  (REAL)R.past_due_aging_amount_bucket_7))<=7  => 7,
                                  -1);
        self.Cycle_Days_Diff:=if(C=1,0,STD.Date.DaysBetween((unsigned4)(L.cycle_end_date),(unsigned4)R.cycle_end_date));
        self.Internal_Payment_Status:= 
                          MAP(R.payment_status_category='' AND R.Past_Due_Amount<>'' AND (real)R.Past_Due_Amount <> 0 => PastDueAmountStatus,
                              R.payment_status_category='' AND R.Past_Due_Amount<>'' AND (real)R.Past_Due_Amount=0  => 0,
                              R.payment_status_category='' AND R.Past_Due_Amount='' AND HasBucket=>-1,
                              R.payment_status_category='' AND R.Past_Due_Amount='' AND HasBucket=false=>-97,
                              R.payment_status_category<>'' and (Integer)R.payment_status_category = 0 => 0, 
                              (Integer)R.payment_status_category = 1 => 1,
                              (Integer)R.payment_status_category = 2 => 2,
                              (Integer)R.payment_status_category = 3 => 3,
                              (Integer)R.payment_status_category = 4 => 4,
                              (Integer)R.payment_status_category = 5 => 5,
                              (Integer)R.payment_status_category = 6 => 6,
                              (Integer)R.payment_status_category = 7 => 7,
                              -97);
        OpenDateCheck:=if((unsigned4)self.FunctionalDateAccountOpened>=(unsigned4)R.cycle_end_date and self.Internal_Payment_Status>0,true,false);
        self.Prior_DBT_V5:=map(            
                                C=1=>0,
                                SameCycleEndDate=>L.Prior_DBT_V5,
                                L.Raw_DBT_V5);
        self.Prior_Payment_Status:=map(
                                C=1=>0,
                                SameCycleEndDate=>L.Prior_Payment_Status,
                                L.Internal_Payment_Status);
        self.Prior_ExceptionCycleDays:=map(
                                C=1=>0,
                                SameCycleEndDate=>L.Prior_ExceptionCycleDays,
                                L.Exception_Cycle_Days);
        self.Prior_Last_Payment_Status_Before_Exception:=map(
                                C=1=>0,
                                SameCycleEndDate=>L.Prior_Last_Payment_Status_Before_Exception,
                                L.Last_Payment_Status_Before_Exception);
        self.Prior_Last_DBT_V5_Before_Exception:=map(
                                C=1=>0,
                                SameCycleEndDate=>L.Prior_Last_DBT_V5_Before_Exception,
                                L.Last_DBT_V5_Before_Exception);

        DBTV5DirectMapping:=map(Self.Internal_Payment_Status=0=>0,
                                Self.Internal_Payment_Status=1=>15,
                                Self.Internal_Payment_Status=2=>45,
                                Self.Internal_Payment_Status=3=>75,
                                Self.Internal_Payment_Status=4=>105,
                                Self.Internal_Payment_Status=5=>135,
                                Self.Internal_Payment_Status=6=>165,
                                Self.Internal_Payment_Status=7=>195,
                                Self.Internal_Payment_Status= -97=>-97,
                                Self.Internal_Payment_Status= -1=>-1,
                                0);

        PaymentIntervalDays:=map(    self.FunctionalPaymentInterval='A'=>365,
                                     self.FunctionalPaymentInterval='SA'=>182,
                                     self.FunctionalPaymentInterval='Q'=>90,
                                     self.FunctionalPaymentInterval='S'=>90,
                                     self.FunctionalPaymentInterval='SF'=>90,
                                     self.FunctionalPaymentInterval='BM'=>60,
                                     self.FunctionalPaymentInterval='BW'=>14,
                                     self.FunctionalPaymentInterval='SM'=>15,
                                     self.FunctionalPaymentInterval='W'=>7,
                                     self.FunctionalPaymentInterval='D'=>1,
                                     self.FunctionalPaymentInterval='SP'=>1,
                                     self.FunctionalPaymentInterval='IM'=>30,
                                     self.FunctionalPaymentInterval='IL'=>30,
                                     self.FunctionalPaymentInterval='M'=>30,
                                     30);                                

        self.Fixed_Delinquency_Date:=(unsigned4)map(length(R.delinquency_date)=8=>R.delinquency_date,
                                         length(R.delinquency_date)=6=>R.delinquency_date+'01',
                                         '');
        DBT_V5_General_CapRound1:=MAP(R.days_delinquent <> '' and (integer)R.days_delinquent>0=>R.days_delinquent,
                                     std.date.isValidDate(self.Fixed_Delinquency_Date) and Self.Fixed_Delinquency_Date=(unsigned4)R.cycle_end_date=>'15',
                                     std.date.isValidDate(self.Fixed_Delinquency_Date) and Self.Fixed_Delinquency_Date<(unsigned4)R.cycle_end_date=>(string)STD.Date.DaysBetween(Self.Fixed_Delinquency_Date,(unsigned4)R.cycle_end_date),
                                     self.FunctionalDateAccountOpened<>'' and (unsigned4)self.FunctionalDateAccountOpened<(unsigned4)R.cycle_end_date=>(string)STD.Date.DaysBetween((unsigned4)self.FunctionalDateAccountOpened,(unsigned4)R.cycle_end_date),
                                     '');
        DBT_V5_General_CapRound2:=if(self.Internal_Payment_Status in [1,2,3,4,5,6],(string)(self.Internal_Payment_Status*PaymentIntervalDays),'');
        self.DBT_V5_General_Cap:=map(DBT_V5_General_CapRound1 = '' => DBT_V5_General_CapRound2,
                                     DBT_V5_General_CapRound2 = '' => DBT_V5_General_CapRound1,
                                     (integer)DBT_V5_General_CapRound1 < (integer)DBT_V5_General_CapRound2 => DBT_V5_General_CapRound1,
                                     DBT_V5_General_CapRound2);
        self.Raw_DBT_V5:=map(
                                     OpenDateCheck=>-5,
                                     isV5=false=>DBTV5DirectMapping,
                                     ChangeInPaymentInterval and self.Internal_Payment_Status <= 0 =>self.Internal_Payment_Status,
                                     ChangeInPaymentInterval and self.Internal_Payment_Status = 1 =>if(self.DBT_V5_General_Cap='' or (integer)self.DBT_V5_General_Cap  >= 15,15,(integer)self.DBT_V5_General_Cap),
                                     ChangeInPaymentInterval and self.Internal_Payment_Status in [2,3,4,5,6] and PaymentIntervalDays < 30 => if(self.DBT_V5_General_Cap='' or (integer)self.DBT_V5_General_Cap  >= RoundUP(((Self.Internal_Payment_Status-1)*((real)PaymentIntervalDays))+((real)(PaymentIntervalDays/2))),RoundUP(((Self.Internal_Payment_Status-1)*((real)PaymentIntervalDays))+((real)(PaymentIntervalDays/2))),(integer)self.DBT_V5_General_Cap),
                                     ChangeInPaymentInterval and self.Internal_Payment_Status in [2,3,4,5,6] and PaymentIntervalDays >= 30 =>if(self.DBT_V5_General_Cap='' or (integer)self.DBT_V5_General_Cap  >= RoundUP(((Self.Internal_Payment_Status-1)*((real)PaymentIntervalDays))+15.0),RoundUP(((Self.Internal_Payment_Status-1)*((real)PaymentIntervalDays))+15.0),(integer)self.DBT_V5_General_Cap),
                                     ChangeInPaymentInterval and self.Internal_Payment_Status=7 and R.days_delinquent<>'' and (integer)R.days_delinquent>0=>(integer)R.days_delinquent,
                                     ChangeInPaymentInterval and self.Internal_Payment_Status=7 and self.Prior_Payment_Status <> 0 =>self.Prior_DBT_V5,
                                     ChangeInPaymentInterval and self.Internal_Payment_Status=7 and self.Prior_Payment_Status = 0 =>-2,
                                     IsMonthly=>DBTV5DirectMapping,
                                     self.Prior_DBT_V5<0 and self.Internal_Payment_Status<0=>self.Internal_Payment_Status,
                                     self.Prior_DBT_V5 = 0 and self.Internal_Payment_Status=1 => if(self.DBT_V5_General_Cap='' or (integer)self.DBT_V5_General_Cap  >= 15,15,(integer)self.DBT_V5_General_Cap),
                                     self.Prior_DBT_V5 = 0 and self.Internal_Payment_Status in [2,3,4,5,6] and PaymentIntervalDays < 30 => if(self.DBT_V5_General_Cap='' or (integer)self.DBT_V5_General_Cap  >= RoundUP(((Self.Internal_Payment_Status-1)*((real)PaymentIntervalDays))+((real)(PaymentIntervalDays/2))),RoundUP(((Self.Internal_Payment_Status-1)*((real)PaymentIntervalDays))+((real)(PaymentIntervalDays/2))),(integer)self.DBT_V5_General_Cap),
                                     self.Prior_DBT_V5 = 0 and self.Internal_Payment_Status in [2,3,4,5,6] and PaymentIntervalDays >= 30 =>if(self.DBT_V5_General_Cap='' or (integer)self.DBT_V5_General_Cap  >= RoundUP(((Self.Internal_Payment_Status-1)*((real)PaymentIntervalDays))+15.0),RoundUP(((Self.Internal_Payment_Status-1)*((real)PaymentIntervalDays))+15.0),(integer)self.DBT_V5_General_Cap),
                                     self.Prior_DBT_V5 = 0 and self.Internal_Payment_Status=7 and R.days_delinquent<>'' and (integer)R.days_delinquent>0=>(integer)R.days_delinquent,
                                     self.Prior_DBT_V5 = 0 and self.Internal_Payment_Status=7 and (R.days_delinquent = '' or (integer)R.days_delinquent <=0) => -2,
                                     self.Prior_DBT_V5 in [-1,-97,-2,-3,-4,-5] and self.Internal_Payment_Status =1 =>if(self.DBT_V5_General_Cap='' or (integer)self.DBT_V5_General_Cap  >= 15,15,(integer)self.DBT_V5_General_Cap),
                                     self.Prior_DBT_V5 in [-1,-97,-2,-3,-4,-5] and self.Internal_Payment_Status in [2,3,4,5,6] and PaymentIntervalDays < 30 => if(self.DBT_V5_General_Cap='' or (integer)self.DBT_V5_General_Cap  >= RoundUP(((Self.Internal_Payment_Status-1)*((real)PaymentIntervalDays))+((real)(PaymentIntervalDays/2))),RoundUP(((Self.Internal_Payment_Status-1)*((real)PaymentIntervalDays))+((real)(PaymentIntervalDays/2))),(integer)self.DBT_V5_General_Cap),
                                     self.Prior_DBT_V5 in [-1,-97,-2,-3,-4,-5] and self.Internal_Payment_Status in [2,3,4,5,6] and PaymentIntervalDays >= 30 =>if(self.DBT_V5_General_Cap='' or (integer)self.DBT_V5_General_Cap  >= RoundUP(((Self.Internal_Payment_Status-1)*((real)PaymentIntervalDays))+15.0),RoundUP(((Self.Internal_Payment_Status-1)*((real)PaymentIntervalDays))+15.0),(integer)self.DBT_V5_General_Cap),
                                     self.Prior_DBT_V5 in [-1,-97,-2,-3,-4,-5] and self.Internal_Payment_Status=7 and R.days_delinquent <> '' and (integer)R.days_delinquent>0=>(integer)R.days_delinquent,
                                     self.Prior_DBT_V5 in [-1,-97,-2,-3,-4,-5] and self.Internal_Payment_Status=7 and (R.days_delinquent = '' or (integer)R.days_delinquent <=0)  and self.Internal_Payment_Status>self.Prior_Last_Payment_Status_Before_Exception and ((((real)(self.Internal_Payment_Status-self.Prior_Last_Payment_Status_Before_Exception-1))*((real)PaymentIntervalDays))+(((real)PaymentIntervalDays)/2))<= self.Prior_ExceptionCycleDays => if(self.DBT_V5_General_Cap='' or (integer)self.DBT_V5_General_Cap  >=self.Prior_Last_DBT_V5_Before_Exception+self.Prior_ExceptionCycleDays,self.Prior_Last_DBT_V5_Before_Exception+self.Prior_ExceptionCycleDays,(integer)self.DBT_V5_General_Cap),
                                     self.Prior_DBT_V5 in [-1,-97,-2,-3,-4,-5] and self.Internal_Payment_Status=7 and (R.days_delinquent = '' or (integer)R.days_delinquent <=0) =>self.Prior_DBT_V5,
                                     self.Internal_Payment_Status <= 0 or self.Prior_DBT_V5 <= 0 => self.Internal_Payment_Status,
                                     self.Internal_Payment_Status=self.Prior_Payment_Status and self.Internal_Payment_Status in [1,2,3,4,5,6] and PaymentIntervalDays < 30 => if(self.DBT_V5_General_Cap='' or (integer)self.DBT_V5_General_Cap  >= RoundUP(((Self.Internal_Payment_Status-1)*((real)PaymentIntervalDays))+((real)(PaymentIntervalDays/2))),RoundUP(((Self.Internal_Payment_Status-1)*((real)PaymentIntervalDays))+((real)(PaymentIntervalDays/2))),(integer)self.DBT_V5_General_Cap),
                                     self.Internal_Payment_Status=self.Prior_Payment_Status and self.Internal_Payment_Status in [1,2,3,4,5,6] and PaymentIntervalDays >= 30 and (self.Prior_DBT_V5+self.Cycle_Days_Diff)>=(self.Internal_Payment_Status*PaymentIntervalDays) =>if(self.DBT_V5_General_Cap='' or (integer)self.DBT_V5_General_Cap  >= RoundUP(((Self.Internal_Payment_Status-1)*((real)PaymentIntervalDays))+15.0),RoundUP(((Self.Internal_Payment_Status-1)*((real)PaymentIntervalDays))+15.0),(integer)self.DBT_V5_General_Cap),
                                     self.Internal_Payment_Status=self.Prior_Payment_Status and self.Internal_Payment_Status in [1,2,3,4,5,6] and PaymentIntervalDays >= 30 and (self.Prior_DBT_V5+self.Cycle_Days_Diff)<(self.Internal_Payment_Status*PaymentIntervalDays) =>if(self.DBT_V5_General_Cap='' or (integer)self.DBT_V5_General_Cap  >= self.Prior_DBT_V5+self.Cycle_Days_Diff,self.Prior_DBT_V5+self.Cycle_Days_Diff,(integer)self.DBT_V5_General_Cap),
                                     self.Internal_Payment_Status=self.Prior_Payment_Status and self.Internal_Payment_Status=7 and R.days_delinquent<>'' and (integer)R.days_delinquent > 0 => (integer)R.days_delinquent,
                                     self.Internal_Payment_Status=self.Prior_Payment_Status and self.Internal_Payment_Status=7 and (R.days_delinquent='' or (integer)R.days_delinquent <= 0) and PaymentIntervalDays < 30 => -3,
                                     self.Internal_Payment_Status=self.Prior_Payment_Status and self.Internal_Payment_Status=7 and (R.days_delinquent='' or (integer)R.days_delinquent <= 0) and PaymentIntervalDays >= 30 => self.Prior_DBT_V5+self.Cycle_Days_Diff,
                                     (self.Internal_Payment_Status-self.Prior_Payment_Status)>1 and self.Internal_Payment_Status in [1,2,3,4,5,6] and PaymentIntervalDays < 30 => if(self.DBT_V5_General_Cap='' or (integer)self.DBT_V5_General_Cap  >= RoundUP(((Self.Internal_Payment_Status-1)*((real)PaymentIntervalDays))+((real)(PaymentIntervalDays/2))),RoundUP(((Self.Internal_Payment_Status-1)*((real)PaymentIntervalDays))+((real)(PaymentIntervalDays/2))),(integer)self.DBT_V5_General_Cap),
                                     (self.Internal_Payment_Status-self.Prior_Payment_Status)>1 and self.Internal_Payment_Status in [1,2,3,4,5,6] and PaymentIntervalDays >= 30 => if(self.DBT_V5_General_Cap='' or (integer)self.DBT_V5_General_Cap  >= RoundUP(((Self.Internal_Payment_Status-1)*((real)PaymentIntervalDays))+15.0),RoundUP(((Self.Internal_Payment_Status-1)*((real)PaymentIntervalDays))+15.0),(integer)self.DBT_V5_General_Cap),
                                     (self.Internal_Payment_Status-self.Prior_Payment_Status)>1 and self.Internal_Payment_Status=7 and R.days_delinquent<>'' and (integer)R.days_delinquent > 0 => (integer)R.days_delinquent,
                                     (self.Internal_Payment_Status-self.Prior_Payment_Status)>1 and self.Internal_Payment_Status=7 and (R.days_delinquent='' or (integer)R.days_delinquent <= 0) => -4,
                                     self.Internal_Payment_Status<self.Prior_Payment_Status and PaymentIntervalDays < 30 => if(self.DBT_V5_General_Cap='' or (integer)self.DBT_V5_General_Cap  >= RoundUP(((Self.Internal_Payment_Status-1)*((real)PaymentIntervalDays))+((real)(PaymentIntervalDays/2))),RoundUP(((Self.Internal_Payment_Status-1)*((real)PaymentIntervalDays))+((real)(PaymentIntervalDays/2))),(integer)self.DBT_V5_General_Cap),
                                     self.Internal_Payment_Status<self.Prior_Payment_Status and PaymentIntervalDays >= 30 => if(self.DBT_V5_General_Cap='' or (integer)self.DBT_V5_General_Cap  >= RoundUP(((Self.Internal_Payment_Status-1)*((real)PaymentIntervalDays))+15.0),RoundUP(((Self.Internal_Payment_Status-1)*((real)PaymentIntervalDays))+15.0),(integer)self.DBT_V5_General_Cap),
                                     if(self.DBT_V5_General_Cap='' or (integer)self.DBT_V5_General_Cap  >=self.Prior_DBT_V5+self.Cycle_Days_Diff,self.Prior_DBT_V5+self.Cycle_Days_Diff,(integer)self.DBT_V5_General_Cap));
                                     



        self.Exception_Cycle_Days:=map(
                                     self.Raw_DBT_V5>=0=>0,
                                     OpenDateCheck=>self.Cycle_Days_Diff,
                                     isV5=false and self.Internal_Payment_Status < 0  and self.Prior_DBT_V5 >= 0 =>self.Cycle_Days_Diff,
                                     isV5=false and self.Internal_Payment_Status < 0  =>self.Cycle_Days_Diff+self.Prior_ExceptionCycleDays,
                                     ChangeInPaymentInterval and self.Internal_Payment_Status<0 and self.Prior_DBT_V5<0=>self.Cycle_Days_Diff+self.Prior_ExceptionCycleDays,
                                     ChangeInPaymentInterval and self.Internal_Payment_Status<0 =>self.Cycle_Days_Diff,
                                     ChangeInPaymentInterval and self.Internal_Payment_Status=7 and (R.days_delinquent='' or (integer)R.days_delinquent<=0) and self.Prior_DBT_V5 < 0 =>self.Cycle_Days_Diff+self.Prior_ExceptionCycleDays,
                                     ChangeInPaymentInterval and self.Internal_Payment_Status=7 and (R.days_delinquent='' or (integer)R.days_delinquent<=0) and self.Prior_DBT_V5 >= 0 =>self.Prior_ExceptionCycleDays,
                                     IsMonthly and self.Internal_Payment_Status < 0  and self.Prior_DBT_V5 >= 0 =>self.Cycle_Days_Diff,
                                     IsMonthly and self.Internal_Payment_Status < 0 =>self.Cycle_Days_Diff+self.Prior_ExceptionCycleDays,
                                     self.Prior_DBT_V5<0 and self.Internal_Payment_Status<0=>self.Cycle_Days_Diff+self.Prior_ExceptionCycleDays,
                                     self.Prior_DBT_V5 = 0 and self.Internal_Payment_Status=7 and (R.days_delinquent = '' or (integer)R.days_delinquent <=0) => self.Cycle_Days_Diff,
                                     self.Prior_DBT_V5 in [-1,-97,-2,-3,-4,-5] and self.Internal_Payment_Status=7 and (R.days_delinquent='' or (integer)R.days_delinquent<=0)  and (self.Internal_Payment_Status<=self.Prior_Last_Payment_Status_Before_Exception or ((((real)(self.Internal_Payment_Status-self.Prior_Last_Payment_Status_Before_Exception-1))*((real)PaymentIntervalDays))+(((real)PaymentIntervalDays)/2))> self.Prior_ExceptionCycleDays)=>self.Cycle_Days_Diff+self.Prior_ExceptionCycleDays,
                                     self.Internal_Payment_Status=self.Prior_Payment_Status and self.Internal_Payment_Status=7 and (R.days_delinquent='' or (integer)R.days_delinquent <= 0) and PaymentIntervalDays < 30 => self.Cycle_Days_Diff,
                                     self.Internal_Payment_Status>self.Prior_Payment_Status and self.Internal_Payment_Status=7 and (R.days_delinquent='' or (integer)R.days_delinquent <= 0) => self.Cycle_Days_Diff,
                                     0);
                                     
                                     
                                     
                                     
                                     
        
        self.Last_Payment_Status_Before_Exception:=map(
                                     self.Raw_DBT_V5>=0=>0,
                                     OpenDateCheck=>0,
                                     isV5=false and self.Internal_Payment_Status < 0  and self.Prior_DBT_V5 >= 0 =>self.Prior_Payment_Status,
                                     isV5=false and self.Internal_Payment_Status < 0 =>self.Prior_Last_Payment_Status_Before_Exception,
                                     ChangeInPaymentInterval and self.Internal_Payment_Status<0 and self.Prior_DBT_V5<0=>self.Prior_Last_Payment_Status_Before_Exception,
                                     ChangeInPaymentInterval and self.Internal_Payment_Status<0 =>self.Prior_Payment_Status,
                                     ChangeInPaymentInterval and self.Internal_Payment_Status=7 and (R.days_delinquent='' or (integer)R.days_delinquent<=0) and self.Prior_DBT_V5 < 0 =>self.Prior_Last_Payment_Status_Before_Exception,
                                     ChangeInPaymentInterval and self.Internal_Payment_Status=7 and (R.days_delinquent='' or (integer)R.days_delinquent<=0) and self.Prior_DBT_V5 >= 0 =>0,
                                     IsMonthly and self.Internal_Payment_Status < 0  and self.Prior_DBT_V5 >= 0=>self.Prior_Payment_Status,
                                     IsMonthly and self.Internal_Payment_Status < 0 =>self.Prior_Last_Payment_Status_Before_Exception,
                                     self.Prior_DBT_V5<0 and self.Internal_Payment_Status<0=>self.Prior_Payment_Status,
                                     self.Prior_DBT_V5 = 0 and self.Internal_Payment_Status=7 and (R.days_delinquent = '' or (integer)R.days_delinquent <=0) =>0,
                                     self.Prior_DBT_V5 in [-1,-97,-2,-3,-4,-5] and self.Internal_Payment_Status=7 and (R.days_delinquent='' or (integer)R.days_delinquent<=0)  and (self.Internal_Payment_Status<=self.Prior_Last_Payment_Status_Before_Exception or ((((real)(self.Internal_Payment_Status-self.Prior_Last_Payment_Status_Before_Exception-1))*((real)PaymentIntervalDays))+(((real)PaymentIntervalDays)/2))> self.Prior_ExceptionCycleDays)=>self.Prior_Last_Payment_Status_Before_Exception,
                                     self.Internal_Payment_Status=self.Prior_Payment_Status and self.Internal_Payment_Status=7 and (R.days_delinquent='' or (integer)R.days_delinquent <= 0) and PaymentIntervalDays < 30 => self.Prior_Payment_Status,
                                     self.Internal_Payment_Status>self.Prior_Payment_Status and self.Internal_Payment_Status=7 and (R.days_delinquent='' or (integer)R.days_delinquent <= 0) => self.Prior_Payment_Status,
                                     0);

                                     
        
        
        self.Last_DBT_V5_Before_Exception:=map(
                                     self.Raw_DBT_V5>=0=>0,
                                     OpenDateCheck=>0,
                                     isV5=false and self.Internal_Payment_Status < 0 and self.Prior_DBT_V5 >= 0=>self.Prior_DBT_V5,
                                     isV5=false and self.Internal_Payment_Status < 0  =>self.Prior_Last_DBT_V5_Before_Exception,
                                     ChangeInPaymentInterval and self.Internal_Payment_Status<0 and self.Prior_DBT_V5<0=>self.Prior_Last_DBT_V5_Before_Exception,
                                     ChangeInPaymentInterval and self.Internal_Payment_Status<0 =>self.Prior_DBT_V5,
                                     ChangeInPaymentInterval and self.Internal_Payment_Status=7 and (R.days_delinquent='' or (integer)R.days_delinquent<=0) and self.Prior_DBT_V5 < 0 =>self.Prior_Last_DBT_V5_Before_Exception,
                                     ChangeInPaymentInterval and self.Internal_Payment_Status=7 and (R.days_delinquent='' or (integer)R.days_delinquent<=0) and self.Prior_DBT_V5 >= 0 =>0,
                                     IsMonthly and self.Internal_Payment_Status < 0 and self.Prior_DBT_V5 >= 0 =>self.Prior_DBT_V5,
                                     IsMonthly and self.Internal_Payment_Status < 0  =>self.Prior_Last_DBT_V5_Before_Exception,
                                     self.Prior_DBT_V5<0 and self.Internal_Payment_Status<0=>self.Prior_DBT_V5,
                                     self.Prior_DBT_V5 = 0 and self.Internal_Payment_Status=7 and (R.days_delinquent = '' or (integer)R.days_delinquent <=0) =>0,
                                     self.Prior_DBT_V5 in [-1,-97,-2,-3,-4,-5] and self.Internal_Payment_Status=7 and (R.days_delinquent='' or (integer)R.days_delinquent<=0)  and (self.Internal_Payment_Status<=self.Prior_Last_Payment_Status_Before_Exception or ((((real)(self.Internal_Payment_Status-self.Prior_Last_Payment_Status_Before_Exception-1))*((real)PaymentIntervalDays))+(((real)PaymentIntervalDays)/2))> self.Prior_ExceptionCycleDays)=>self.Prior_Last_DBT_V5_Before_Exception,
                                     self.Internal_Payment_Status=self.Prior_Payment_Status and self.Internal_Payment_Status=7 and (R.days_delinquent='' or (integer)R.days_delinquent <= 0) and PaymentIntervalDays < 30 => self.Prior_DBT_V5,
                                     self.Internal_Payment_Status>self.Prior_Payment_Status and self.Internal_Payment_Status=7 and (R.days_delinquent='' or (integer)R.days_delinquent <= 0) => self.Prior_DBT_V5,
                                     0);

        self.DBT_V5:=if(self.Raw_DBT_V5<=0,'',(string)self.Raw_DBT_V5);
        self:=R;        
    end;
    CalculateDBTV5:=iterate(Groupfile,tCalculateDBTV5(left,right,counter));
    MakeEverythingString:=project(CalculateDBTV5,transform(rAddRequiredStringFields,
        self.Raw_DBT_V5:=(string)left.Raw_DBT_V5;
        self:=left;));
    return MakeEverythingString;
end;

