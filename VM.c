//Definition of Global Variables
//***************Delay Variables Definition**************************
#define STEPDELAY  10  //Delay in between each step
#define COINSWITCHDELAY  20  //Delay after reading coinswitch & zero positioning switch ON/OFF status from ADC
#define IRSETDELAY 100   //Delay to set the IR Transmitter ON/OFF before reading ADC
#define INITIALRESETDELAY 50     //Delay after initial reset of all Ports
#define COINCOUNTDELAY 50 //Delay for coin count
#define ADCSTOPDELAY 200 //Delay after ADC stop
#define DELAYBETWEENNAPKINS 200 //Deplay between number of napkins being dispensed
#define FULLCYCLEDELAY 100   // Delay after 1 full cycle run
#define NAPKINSTODISPENSE 2 // MAX N+1 BASED ON IR OFFSET POSITION FROM LAST NAPKIN POSITION, N BEING OFFSET POSITION
//******************************************************************

//*******CONSTANTS DEFINITION USED FOR IF CONDITION*******
#define TOTALSTEPS  250         //Total number of steps to complete 1 full rotation is 250
#define ZEROSTEPS    5         //Actual=36         //Minimum number of steps for zero positioning
#define ZEROPOSITIONHIGHVALUE 160 //***160 The ADC value for the zero positioning switch ON condition is less than 160
#define COINSWITCHLOWVALUE 20 //Low value for coin switch is 20
#define IRHIGHVALUE 136//  ***160 If napkin is present IR measured value will be greater than 160
#define IRLOWVALUE  140     //***130 If napkin is not present IR measured value will be lesser than 100
#define CHECKCOINCOUNT 1   //This value is used to change the number of coins for dispensing. If 1 - one coins, 2 - two coins and so on
#define dispatching 1      //
//********************************************************

#define IRTx PORTB.f5        //IR Transmitter Enable
#define SoldOutLED PORTC.f0  //SOLDOUT LED
#define M1_Pulse PORTD.f1    //STEPPER MODULE PULSE
#define M1_Dir PORTB.f5      //STEPPER MODULE DIRECTION
//#define M1_Enable PORTB.f6   //STEPPER MODULE ENABLE
#define SW_1 PORTB.f6        // INPUT TO SOFTWARE
#define SW_2 PORTB.f7         // Input to softare



  int stepCount=0, pulseCount=1,count=0;
  unsigned int coinSwitchValue=50,coinCount=0,coinSwitchToggleFlag=0;
  unsigned int irReceiverValue=IRHIGHVALUE+1, i=0,zeroPositionValue1=0,numberOfNapkins=0;
  unsigned int dispensing=0;



unsigned int adc_vlu = 0;

int adc_vlu_get(void)
{
 adc_vlu = 0;
 adcon0.go=1;
 while(!pir1.adif);
 adc_vlu = adresh;
 adc_vlu = adc_vlu << 8;
 adc_vlu = adc_vlu + adresl;
 pir1.adif = 0;
 return(adc_vlu);
}

void main()
 {
               TRISA = 0xFF; //Making portA all channels as input
               TRISE = 0xFF; //Making portE all channels as input
               adcon1=0x82;
               adcon0=0x01;
               TRISB = 0x00; //Making portB channels as output
               TRISC = 0x00; //Making portC all channels as output
               TRISD = 0x00; //Making portD all channels as output
               IRTx=0;     //Make PortB.2 Low - IR TANSMITTER PULSE IS ZERO( Sensor input)
               SoldOutLED=0;  //SOLDOUT LED
               M1_Pulse=0;    //STEPPER MODULE PULSE
               M1_Dir=0;      //STEPPER MODULE DIRECTION
              // M1_Enable=0;   //STEPPER MODULE ENABLE
               Delay_ms(INITIALRESETDELAY);
               IRTx=1;            //Make PortB.2 High - IR TANSMITTER PULSE IS ON
               Delay_ms(IRSETDELAY);


  irReceiverValue = ADC_Read(0);

  //irReceiverValue = adc_vlu_get();  //


if (irReceiverValue < IRLOWVALUE)  //Napkin present
{
    SoldOutLED=0; //RELAY WILL SWITCH ON READY LED

  }

else if (irReceiverValue > IRHIGHVALUE)  //No Napkin present
  {
     SoldOutLED=1; //RELAY WILL SWITCH ON SOLD OUT LED
  }


 // irReceiverValue = IRHIGHVALUE;  // ???
  //IRTx=0; //IR Transmitter is SET OFF
  Delay_ms(IRSETDELAY);

  while(1)
  {

      irReceiverValue = ADC_Read(0);
      delay_ms(10);
      coinSwitchValue = ADC_Read(1);     //PORTD.f0;
      delay_ms(10);
      zeroPositionValue1 = ADC_Read(2); // digital
      delay_ms(10);
      dispensing = PORTE.f0;




     /*PORTB.f0=0;  //ADC INPUT made ZERO to START read
      for(i=0; i<9; i++){
      PORTB.f1 =1; //ADC CLOCK PULSE
      PORTB.f1 =0; //ADC CLOCK PULSE
      coinSwitchValue=coinSwitchValue<<1;
      zeroPositionValue=zeroPositionValue<<1;
      coinSwitchValue=coinSwitchValue+PORTA.f1;
      zeroPositionValue=zeroPositionValue+PORTA.f2;
      irReceiverValue=irReceiverValue<<1;
      irReceiverValue=irReceiverValue+PORTA.f0;*/




        if (irReceiverValue < IRLOWVALUE)   //Napkin present
        {
          SoldOutLED=0; // # RELAY WILL SWITCH ON READY LED

       }
       if (irReceiverValue > IRHIGHVALUE)
       {
        SoldOutLED=1;// # RELAY WILL SWITCH ON SOLD OUT LED

       }
      /*else
       {
        SoldOutLED=0;// # PORTB.f3=0;
       }*/
        IRTx=0; //IR Transmitter is SET OFF
        Delay_ms(IRSETDELAY);

    if (dispensing == 1)
    {
         // M1_Enable=1;
          M1_Pulse=1;

     for( i=0; i<200; i++)
     {
          M1_Pulse=1;
          delay_ms(10);
          M1_Pulse=0;
          Delay_ms(10);

      }


    }
     if (dispensing == 0)
     {
          //M1_Enable=0;
          M1_Pulse=0;
     }

    if(coinSwitchValue  >= COINSWITCHLOWVALUE)
    {
       coinSwitchToggleFlag=1;
    }

    if(coinSwitchValue  < COINSWITCHLOWVALUE && coinSwitchToggleFlag)
    {
      Delay_ms(COINCOUNTDELAY);
      coinCount=coinCount+1;
      coinSwitchToggleFlag=0;
    }
     if(PORTA.f3 == 1 && irReceiverValue < IRLOWVALUE)   // #
     {
      Delay_ms(COINCOUNTDELAY);
      coinCount=coinCount+1;
      coinSwitchToggleFlag=0;
    }


    //If number of coin detected is equal to required number of coins run stepper motor required number of cycle
    if(coinCount == CHECKCOINCOUNT)
    {
      // # IR Transmitter is SET ON

      while (numberOfNapkins < NAPKINSTODISPENSE)
       {
        //PORTA.f4=0;
        while(zeroPositionvalue1 = 1) // #
        {
          //M1_Enable=1;
          M1_Pulse=1;

          for( i=0; i<200; i++)
          {
              M1_Pulse=1;
              delay_ms(10);
              M1_Pulse=0;
              Delay_ms(10);

          }

            numberOfNapkins++;
            Delay_ms(DELAYBETWEENNAPKINS);
             //PORTA.f4=1;
         }
       }

       //PORTB.f0=1; //ADC INPUT made ONE to STOP read
       //Delay_ms(ADCSTOPDELAY);
       irReceiverValue = ADC_Read(0);

       delay_ms(10);

       if (irReceiverValue < IRLOWVALUE)
       {   //Napkin present
         SoldOutLED=0; //RELAY WILL SWITCH ON READY LED
       }
       if (irReceiverValue > IRHIGHVALUE)
       {
        SoldOutLED=1;//RELAY WILL SWITCH ON SOLD OUT LED
       }
     /*else
       {
       SoldOutLED=0;;
       }*/
        IRTx=0; //IR Transmitter is SET OFF
        Delay_ms(IRSETDELAY);
        //*** PORTB.f2=0; //IR Transmitter is SET OFF

       numberOfNapkins=0;
       stepCount=0;
       coinSwitchValue=0;
       coinCount=0;
       irReceiverValue=0;
       zeroPositionValue1=0;
       coinSwitchToggleFlag=0;



  }
 }
}