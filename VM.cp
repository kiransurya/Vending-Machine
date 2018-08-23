#line 1 "D://VM.c"
#line 35 "D://VM.c"
 int stepCount=0, pulseCount=1,count=0;
 unsigned int coinSwitchValue=50,coinCount=0,coinSwitchToggleFlag=0;
 unsigned int irReceiverValue= 136 +1, i=0,zeroPositionValue1=0,numberOfNapkins=0;
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
 TRISA = 0xFF;
 TRISE = 0xFF;
 adcon1=0x82;
 adcon0=0x01;
 TRISB = 0x00;
 TRISC = 0x00;
 TRISD = 0x00;
  PORTB.f5 =0;
  PORTC.f0 =0;
  PORTD.f1 =0;
  PORTB.f5 =0;

 Delay_ms( 50 );
  PORTB.f5 =1;
 Delay_ms( 100 );


 irReceiverValue = ADC_Read(0);




if (irReceiverValue <  140 )
{
  PORTC.f0 =0;

 }

else if (irReceiverValue >  136 )
 {
  PORTC.f0 =1;
 }




 Delay_ms( 100 );

 while(1)
 {

 irReceiverValue = ADC_Read(0);
 delay_ms(10);
 coinSwitchValue = ADC_Read(1);
 delay_ms(10);
 zeroPositionValue1 = ADC_Read(2);
 delay_ms(10);
 dispensing = PORTE.f0;
#line 124 "D://VM.c"
 if (irReceiverValue <  140 )
 {
  PORTC.f0 =0;

 }
 if (irReceiverValue >  136 )
 {
  PORTC.f0 =1;

 }
#line 138 "D://VM.c"
  PORTB.f5 =0;
 Delay_ms( 100 );

 if (dispensing == 1)
 {

  PORTD.f1 =1;

 for( i=0; i<200; i++)
 {
  PORTD.f1 =1;
 delay_ms(10);
  PORTD.f1 =0;
 Delay_ms(10);

 }


 }
 if (dispensing == 0)
 {

  PORTD.f1 =0;
 }

 if(coinSwitchValue >=  20 )
 {
 coinSwitchToggleFlag=1;
 }

 if(coinSwitchValue <  20  && coinSwitchToggleFlag)
 {
 Delay_ms( 50 );
 coinCount=coinCount+1;
 coinSwitchToggleFlag=0;
 }
 if(PORTA.f3 == 1 && irReceiverValue <  140 )
 {
 Delay_ms( 50 );
 coinCount=coinCount+1;
 coinSwitchToggleFlag=0;
 }



 if(coinCount ==  1 )
 {


 while (numberOfNapkins <  2 )
 {

 while(zeroPositionvalue1 = 1)
 {

  PORTD.f1 =1;

 for( i=0; i<200; i++)
 {
  PORTD.f1 =1;
 delay_ms(10);
  PORTD.f1 =0;
 Delay_ms(10);

 }

 numberOfNapkins++;
 Delay_ms( 200 );

 }
 }



 irReceiverValue = ADC_Read(0);

 delay_ms(10);

 if (irReceiverValue <  140 )
 {
  PORTC.f0 =0;
 }
 if (irReceiverValue >  136 )
 {
  PORTC.f0 =1;
 }
#line 228 "D://VM.c"
  PORTB.f5 =0;
 Delay_ms( 100 );


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
